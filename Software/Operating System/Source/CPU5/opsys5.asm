 TITLE '@OSN'
@OSN BEGIN 0
*
OSN0     JMP/  OSN1       0100 ; =0x09df =2527 [Jump direct]
*
         DW    >TIB0      0103 ; =0x01e0 =480 [CURTB: current tib address]
         DB    X'01'      0105 ; =0x01 =1 [SDSC: system disc number]
         DB    X'01'      0106 ; =0x01 =1 [MXDSC: max disc number]
         DW    >TIBTBL    0107 ; =0x0142 =322 [TIBPT: tib pointer table address]
         DW    >PUBTBL    0109 ; =0x014c =332 [PUBPT: pub pointer table address]
         DW    >MPUBTBL   010b ; =0x0160 =352 [MUXPT: mux device pub pointer table address]
         DW    >TB0LUB    010d ; =0x05d8 =1496 [LUBTB: lub table address]
         DW    >FCBTBL    010f ; =0x016a =362 [FCBPT: file control block pointer table address]
         DW    X'004F'    0111 ; =0x004f =79 [MXLUB: max lub number (all tibs)]
         DB    X'00'      0113 ; =0x00 =0 =NUL [FBFLP: file control block free list pointer]
         DW    X'001B'    0114 ; =0x001b =27 [MXDX: max ojx number]
         DW    >OJXTBL    0116 ; =0x01a8 =424 [DXTB: addr of ojx disc address table]
         DW    >DATBL     0118 ; =0x01a0 =416 [DDTB: disc dir addr table]
         DW    >ALCTBL    011a ; =0x01a4 =420 [DATB: disc space alloc table address]
         DB    X'FF'      011c ; =0xff =255(-1) [DAIP: disc space allocation in process sw]
         DW    SYSBUF     011d ; =0x0848 =2120 [SYSBF: address of system buffer]
         DB    X'FF'      011f ; =0xff =255(-1) [DMACF: dma control flag]
         DW    >SHTBL     0120 ; =0x0596 =1430 [SHTB: sector hold table address]
         DW    >SVCTBL    0122 ; =0x0780 =1920 [SVCTB: svc jump table address]
         DB    X'4A'      0124 ; =0x4a =74 [SVCMX: max svc number]
         DB    X'01'      0125 ; =0x01 =1 [DSABL: dissable task selection switch (0=enabled)]
         DW    >DVITBL    0126 ; =0x0393 =915 [DVINT: addr of device initializtion routine table]
         DW    X'0014'    0128 ; =0x0014 =20 [JLBDA: system job library disc address]
         DW    X'0014'    012a ; =0x0014 =20 [RLBDA: system run library disc address]
         DB    0,4        012c ; =0x00,0x0004 [SYSDTN: system date (32-bit numeric)]
         DC    'MM/DD/YY' 0130 ; hex:cdcdafc4c4afd9d9 [SYSDTS: system date (8-char string with x'0' terminator)]
         DB    X'00'      0138 ; =0x00 =0 =NUL
         DW    X'0000'    0139 ; =0x0000 =0 =NUL,NUL [BASMON: address of basic monitor (0=monitor not loaded)]
         DB    X'FF'      013b ; =0xff =255(-1) [SBFCF: system buffer control flag (-1=free, tibid=in use)]
         DB    X'FF'      013c ; =0xff =255(-1) [OS5FLG: osn5 usage flag (-1=free, tibid=in use)]
         DB    X'FF'      013d ; =0xff =255(-1) [TFLAG: transient usgae flag (-1=free, tibid=in use)]
         DB    X'00'      013e ; =0x00 =0 =NUL [ATNFLG: attn flag]
         DW    X'0000'    013f ; =0x0000 =0 =NUL,NUL [DMACFP: address of last pub to set dma]
         DB    X'00'      0141 ; =0x00 =0 =NUL [TOFLG: time out flag]
>TIBTBL  DW    >TIB0      0142 ; =0x01e0 =480
         DW    >TIB1      0144 ; =0x020e =526
         DW    >TIB2      0146 ; =0x023c =572
         DW    >TIB3      0148 ; =0x026a =618
         DW    X'0000'    014a ; TIB end of table
>PUBTBL  DW    >PUB0      014c ; =0x0298 =664
         DW    >PUB1      014e ; =0x02b7 =695
         DW    >PUB2      0150 ; =0x02d6 =726
         DW    >PUB3      0152 ; =0x02f5 =757
         DW    >PUB4      0154 ; =0x0314 =788
         DW    >PUB5      0156 ; =0x0329 =809
         DW    >PUB6      0158 ; =0x033e =830
         DW    >PUB7      015a ; =0x0359 =857
         DW    >PUB8      015c ; =0x0374 =884
         DW    X'0000'    015e ; PUB end of table
>MPUBTBL DW    X'0006'    0160 ; =0x0006 =6
>M0PPTR  DW    >PUB0      0162 ; =0x0298 =664
         DW    >PUB1      0164 ; =0x02b7 =695
         DW    >PUB2      0166 ; =0x02d6 =726
         DW    X'0000'    0168 ; MUXPUB end of table
>FCBTBL  DW    >FCB00     016a ; =0x03d7 =983
         DW    >FCB01     016c ; =0x03e8 =1000
         DW    >FCB02     016e ; =0x03f9 =1017
         DW    >FCB03     0170 ; =0x040a =1034
         DW    >FCB04     0172 ; =0x041b =1051
         DW    >FCB05     0174 ; =0x042c =1068
         DW    >FCB06     0176 ; =0x043d =1085
         DW    >FCB07     0178 ; =0x044e =1102
         DW    >FCB08     017a ; =0x045f =1119
         DW    >FCB09     017c ; =0x0470 =1136
         DW    >FCB10     017e ; =0x0481 =1153
         DW    >FCB11     0180 ; =0x0492 =1170
         DW    >FCB12     0182 ; =0x04a3 =1187
         DW    >FCB13     0184 ; =0x04b4 =1204
         DW    >FCB14     0186 ; =0x04c5 =1221
         DW    >FCB15     0188 ; =0x04d6 =1238
         DW    >FCB16     018a ; =0x04e7 =1255
         DW    >FCB17     018c ; =0x04f8 =1272
         DW    >FCB18     018e ; =0x0509 =1289
TSIZE    DW    >FCB19     0190 ; =0x051a =1306
         DW    >FCB20     0192 ; =0x052b =1323
         DW    >FCB21     0194 ; =0x053c =1340
         DW    >FCB22     0196 ; =0x054d =1357
         DW    >FCB23     0198 ; =0x055e =1374
         DW    >FCB24     019a ; =0x056f =1391
         DW    >FCB25     019c ; =0x0580 =1408
         DW    X'0000'    019e ; FCB end of table
>DATBL   DW    X'0014'    01a0 ; Disc0 @SLOD0 sector
         DW    X'0014'    01a2 ; Disc1 @SLOD0 sector
>ALCTBL  DW    X'0010'    01a4 ; Disc0 alloc table sector
         DW    X'0010'    01a6 ; Disc1 alloc table sector
>OJXTBL  DB    0,56       01a8 ; =0x00,0x0038
>TIB0    DB    X'00'      01e0 ; =0x00 =0 =NUL [TBRUN: task running flag (1=true)] ()
         DB    X'00'      01e1 ; =0x00 =0 =NUL [TBID: task identifier]
         DB    X'00'      01e2 ; =0x00 =0 =NUL [TBPCT: task priority counter]
         DB    X'00'      01e3 ; =0x00 =0 =NUL [TBPRI: task priority value]
         DW    >TB0LUB    01e4 ; =0x05d8 =1496 [TBLUB: addr of lub table for this task]
         DB    X'04'      01e6 ; =0x04 =4 [TBPLU: 1st programmer logical unit number]
         DB    X'13'      01e7 ; =0x13 =19 [TBLMX: max logical unit number for this task]
         DW    >PUB0      01e8 ; =0x0298 =664 [TBCON: addr of console pub for this task]
         DW    X'0000'    01ea ; =0x0000 =0 =NUL,NUL [TBLOM: low memory address]
         DW    X'0000'    01ec ; =0x0000 =0 =NUL,NUL [TBHIM: high memory address]
         DW    X'0000'    01ee ; =0x0000 =0 =NUL,NUL [TBSHI: last prog segment high address]
         DW    X'0000'    01f0 ; =0x0000 =0 =NUL,NUL [TBSS: 's' reg save area]
         DB    X'01'      01f2 ; =0x01 =1 [TBJCF: job control flag] (JLOG: log option (1=true))
         DB    X'00'      01f3 ; =0x00 =0 =NUL [TBABT: abort flag]
         DB    X'00'      01f4 ; =0x00 =0 =NUL [TBCCD: completion code]
         DB    X'00'      01f5 ; =0x00 =0 =NUL [TBUPS: utility program switches]
         DB    X'0A'      01f6 ; =0x0a =10 [TBPMX: max ncmber of job parameters]
         DW    >TB0PRM    01f7 ; =0x067e =1662 [TBPRM: address of job parameters]
         DW    X'0000'    01f9 ; =0x0000 =0 =NUL,NUL [TBUW0: utility word 0 (first word of cpl program)]
         DB    X'00'      01fb ; =0x00 =0 =NUL [TBRDN: run disc number]
         DW    X'0000'    01fc ; =0x0000 =0 =NUL,NUL [TBRLB: run lib (dir) disc addr]
         DS    6          01fe ; [Uninitialized memory] [TBRFN: run file name (6-char)]
         DB    X'00'      0204 ; =0x00 =0 =NUL [TBCUNT: console unit number]
         DS    8          0205 ; [Uninitialized memory] [TBSUB: storage for sub-totals in cpl math statements]
         DB    X'00'      020d ; =0x00 =0 =NUL [TBDFLT: default disk number]
>TIB1    DB    X'00'      020e ; =0x00 =0 =NUL [TBRUN: task running flag (1=true)] ()
         DB    X'01'      020f ; =0x01 =1 [TBID: task identifier]
         DB    X'00'      0210 ; =0x00 =0 =NUL [TBPCT: task priority counter]
         DB    X'00'      0211 ; =0x00 =0 =NUL [TBPRI: task priority value]
         DW    >TB1LUB    0212 ; =0x0600 =1536 [TBLUB: addr of lub table for this task]
         DB    X'04'      0214 ; =0x04 =4 [TBPLU: 1st programmer logical unit number]
         DB    X'13'      0215 ; =0x13 =19 [TBLMX: max logical unit number for this task]
         DW    >PUB6      0216 ; =0x033e =830 [TBCON: addr of console pub for this task]
         DW    X'0000'    0218 ; =0x0000 =0 =NUL,NUL [TBLOM: low memory address]
         DW    X'0000'    021a ; =0x0000 =0 =NUL,NUL [TBHIM: high memory address]
         DW    X'0000'    021c ; =0x0000 =0 =NUL,NUL [TBSHI: last prog segment high address]
         DW    X'0000'    021e ; =0x0000 =0 =NUL,NUL [TBSS: 's' reg save area]
         DB    X'01'      0220 ; =0x01 =1 [TBJCF: job control flag] (JLOG: log option (1=true))
         DB    X'00'      0221 ; =0x00 =0 =NUL [TBABT: abort flag]
         DB    X'00'      0222 ; =0x00 =0 =NUL [TBCCD: completion code]
         DB    X'00'      0223 ; =0x00 =0 =NUL [TBUPS: utility program switches]
         DB    X'0A'      0224 ; =0x0a =10 [TBPMX: max ncmber of job parameters]
         DW    >TB1PRM    0225 ; =0x06c0 =1728 [TBPRM: address of job parameters]
         DW    X'0000'    0227 ; =0x0000 =0 =NUL,NUL [TBUW0: utility word 0 (first word of cpl program)]
         DB    X'00'      0229 ; =0x00 =0 =NUL [TBRDN: run disc number]
         DW    X'0000'    022a ; =0x0000 =0 =NUL,NUL [TBRLB: run lib (dir) disc addr]
         DS    6          022c ; [Uninitialized memory] [TBRFN: run file name (6-char)]
         DB    X'00'      0232 ; =0x00 =0 =NUL [TBCUNT: console unit number]
         DS    8          0233 ; [Uninitialized memory] [TBSUB: storage for sub-totals in cpl math statements]
         DB    X'00'      023b ; =0x00 =0 =NUL [TBDFLT: default disk number]
>TIB2    DB    X'00'      023c ; =0x00 =0 =NUL [TBRUN: task running flag (1=true)] ()
         DB    X'02'      023d ; =0x02 =2 [TBID: task identifier]
         DB    X'00'      023e ; =0x00 =0 =NUL [TBPCT: task priority counter]
         DB    X'00'      023f ; =0x00 =0 =NUL [TBPRI: task priority value]
         DW    >TB2LUB    0240 ; =0x0628 =1576 [TBLUB: addr of lub table for this task]
         DB    X'04'      0242 ; =0x04 =4 [TBPLU: 1st programmer logical unit number]
         DB    X'13'      0243 ; =0x13 =19 [TBLMX: max logical unit number for this task]
         DW    >PUB6      0244 ; =0x033e =830 [TBCON: addr of console pub for this task]
         DW    X'0000'    0246 ; =0x0000 =0 =NUL,NUL [TBLOM: low memory address]
         DW    X'0000'    0248 ; =0x0000 =0 =NUL,NUL [TBHIM: high memory address]
         DW    X'0000'    024a ; =0x0000 =0 =NUL,NUL [TBSHI: last prog segment high address]
         DW    X'0000'    024c ; =0x0000 =0 =NUL,NUL [TBSS: 's' reg save area]
         DB    X'01'      024e ; =0x01 =1 [TBJCF: job control flag] (JLOG: log option (1=true))
         DB    X'00'      024f ; =0x00 =0 =NUL [TBABT: abort flag]
         DB    X'00'      0250 ; =0x00 =0 =NUL [TBCCD: completion code]
         DB    X'00'      0251 ; =0x00 =0 =NUL [TBUPS: utility program switches]
         DB    X'0A'      0252 ; =0x0a =10 [TBPMX: max ncmber of job parameters]
         DW    >TB2PRM    0253 ; =0x0702 =1794 [TBPRM: address of job parameters]
         DW    X'0000'    0255 ; =0x0000 =0 =NUL,NUL [TBUW0: utility word 0 (first word of cpl program)]
         DB    X'00'      0257 ; =0x00 =0 =NUL [TBRDN: run disc number]
         DW    X'0000'    0258 ; =0x0000 =0 =NUL,NUL [TBRLB: run lib (dir) disc addr]
         DS    6          025a ; [Uninitialized memory] [TBRFN: run file name (6-char)]
         DB    X'00'      0260 ; =0x00 =0 =NUL [TBCUNT: console unit number]
         DS    8          0261 ; [Uninitialized memory] [TBSUB: storage for sub-totals in cpl math statements]
         DB    X'00'      0269 ; =0x00 =0 =NUL [TBDFLT: default disk number]
>TIB3    DB    X'00'      026a ; =0x00 =0 =NUL [TBRUN: task running flag (1=true)] ()
         DB    X'03'      026b ; =0x03 =3 [TBID: task identifier]
         DB    X'00'      026c ; =0x00 =0 =NUL [TBPCT: task priority counter]
         DB    X'00'      026d ; =0x00 =0 =NUL [TBPRI: task priority value]
         DW    >TB3LUB    026e ; =0x0650 =1616 [TBLUB: addr of lub table for this task]
         DB    X'04'      0270 ; =0x04 =4 [TBPLU: 1st programmer logical unit number]
         DB    X'13'      0271 ; =0x13 =19 [TBLMX: max logical unit number for this task]
         DW    >PUB6      0272 ; =0x033e =830 [TBCON: addr of console pub for this task]
         DW    X'0000'    0274 ; =0x0000 =0 =NUL,NUL [TBLOM: low memory address]
         DW    X'0000'    0276 ; =0x0000 =0 =NUL,NUL [TBHIM: high memory address]
         DW    X'0000'    0278 ; =0x0000 =0 =NUL,NUL [TBSHI: last prog segment high address]
         DW    X'0000'    027a ; =0x0000 =0 =NUL,NUL [TBSS: 's' reg save area]
         DB    X'01'      027c ; =0x01 =1 [TBJCF: job control flag] (JLOG: log option (1=true))
         DB    X'00'      027d ; =0x00 =0 =NUL [TBABT: abort flag]
         DB    X'00'      027e ; =0x00 =0 =NUL [TBCCD: completion code]
         DB    X'00'      027f ; =0x00 =0 =NUL [TBUPS: utility program switches]
         DB    X'0A'      0280 ; =0x0a =10 [TBPMX: max ncmber of job parameters]
         DW    >TB3PRM    0281 ; =0x0744 =1860 [TBPRM: address of job parameters]
         DW    X'0000'    0283 ; =0x0000 =0 =NUL,NUL [TBUW0: utility word 0 (first word of cpl program)]
         DB    X'00'      0285 ; =0x00 =0 =NUL [TBRDN: run disc number]
         DW    X'0000'    0286 ; =0x0000 =0 =NUL,NUL [TBRLB: run lib (dir) disc addr]
         DS    6          0288 ; [Uninitialized memory] [TBRFN: run file name (6-char)]
         DB    X'00'      028e ; =0x00 =0 =NUL [TBCUNT: console unit number]
         DS    8          028f ; [Uninitialized memory] [TBSUB: storage for sub-totals in cpl math statements]
         DB    X'00'      0297 ; =0x00 =0 =NUL [TBDFLT: default disk number]
>PUB0    DB    X'C7'      0298 ; =0xc7 =199(-57) ='G' [PBF0: flag 0] (INP: input allowed, OUT: output allowed, SHR: shared device/file, ACT: active device, EXT: extended pub)
         DB    X'02'      0299 ; =0x02 =2 [PBDVC: device type] (VDO: video)
         DB    X'01'      029a ; =0x01 =1 [PBUNT: unit number]
         DW    >PB0DCF    029b ; =0x038b =907 [PBDCF: device control flag address]
         DW    >CRTSRB    029d ; =0x0399 =921 [PBSRB: device service service routine block address]
         DC    'CRT0  '   029f ; hex:c3d2d4b0a0a0 [PBNAM: symbolic device name (6-char)]
         DB    X'00'      02a5 ; =0x00 =0 =NUL [PBENB: input enabled flag (1=true)]
         DB    X'00'      02a6 ; =0x00 =0 =NUL [PBLCH: last char of message]
         DB    X'00'      02a7 ; =0x00 =0 =NUL [PBATN: attention flag]
         DW    X'0000'    02a8 ; =0x0000 =0 =NUL,NUL [PBRCB: address of current rcb]
         DB    X'00'      02aa ; =0x00 =0 =NUL [PBC0: control byte]
         DB    X'83'      02ab ; =0x83 =131(-125) [PBACH: attn char]
         DB    X'18'      02ac ; =0x18 =24 [PBLC: line count (crt screen size)]
         DW    X'F200'    02ad ; =0xf200 =61952(-3584) ='r',NUL [PBDVA: device address]
         DB    X'C5'      02af ; =0xc5 =197(-59) ='E' [PBMCB: mux control byte] [7E1 @ 9600]
         DB    X'00'      02b0 ; =0x00 =0 =NUL [PBCUNT: pub console unit number]
         DW    X'0000'    02b1 ; =0x0000 =0 =NUL,NUL [PBTIB: tib address for this console]
         DW    X'0000'    02b3 ; =0x0000 =0 =NUL,NUL [PBISR: user interupt service routine]
         DW    PD001      02b5 ; =0x2bc5 =11205 [PBPD: pub pre-driver]
>PUB1    DB    X'C7'      02b7 ; =0xc7 =199(-57) ='G' [PBF0: flag 0] (INP: input allowed, OUT: output allowed, SHR: shared device/file, ACT: active device, EXT: extended pub)
         DB    X'02'      02b8 ; =0x02 =2 [PBDVC: device type] (VDO: video)
         DB    X'02'      02b9 ; =0x02 =2 [PBUNT: unit number]
         DW    >PB1DCF    02ba ; =0x038c =908 [PBDCF: device control flag address]
         DW    >CRTSRB    02bc ; =0x0399 =921 [PBSRB: device service service routine block address]
         DC    'CRT1  '   02be ; hex:c3d2d4b1a0a0 [PBNAM: symbolic device name (6-char)]
         DB    X'00'      02c4 ; =0x00 =0 =NUL [PBENB: input enabled flag (1=true)]
         DB    X'00'      02c5 ; =0x00 =0 =NUL [PBLCH: last char of message]
         DB    X'00'      02c6 ; =0x00 =0 =NUL [PBATN: attention flag]
         DW    X'0000'    02c7 ; =0x0000 =0 =NUL,NUL [PBRCB: address of current rcb]
         DB    X'00'      02c9 ; =0x00 =0 =NUL [PBC0: control byte]
         DB    X'83'      02ca ; =0x83 =131(-125) [PBACH: attn char]
         DB    X'18'      02cb ; =0x18 =24 [PBLC: line count (crt screen size)]
         DW    X'F202'    02cc ; =0xf202 =61954(-3582) [PBDVA: device address]
         DB    X'C5'      02ce ; =0xc5 =197(-59) ='E' [PBMCB: mux control byte] [7E1 @ 9600]
         DB    X'01'      02cf ; =0x01 =1 [PBCUNT: pub console unit number]
         DW    X'0000'    02d0 ; =0x0000 =0 =NUL,NUL [PBTIB: tib address for this console]
         DW    X'0000'    02d2 ; =0x0000 =0 =NUL,NUL [PBISR: user interupt service routine]
         DW    PD001      02d4 ; =0x2bc5 =11205 [PBPD: pub pre-driver]
>PUB2    DB    X'C7'      02d6 ; =0xc7 =199(-57) ='G' [PBF0: flag 0] (INP: input allowed, OUT: output allowed, SHR: shared device/file, ACT: active device, EXT: extended pub)
         DB    X'02'      02d7 ; =0x02 =2 [PBDVC: device type] (VDO: video)
         DB    X'04'      02d8 ; =0x04 =4 [PBUNT: unit number]
         DW    >PB2DCF    02d9 ; =0x038d =909 [PBDCF: device control flag address]
         DW    >CRTSRB    02db ; =0x0399 =921 [PBSRB: device service service routine block address]
         DC    'CRT2  '   02dd ; hex:c3d2d4b2a0a0 [PBNAM: symbolic device name (6-char)]
         DB    X'00'      02e3 ; =0x00 =0 =NUL [PBENB: input enabled flag (1=true)]
         DB    X'00'      02e4 ; =0x00 =0 =NUL [PBLCH: last char of message]
         DB    X'00'      02e5 ; =0x00 =0 =NUL [PBATN: attention flag]
         DW    X'0000'    02e6 ; =0x0000 =0 =NUL,NUL [PBRCB: address of current rcb]
         DB    X'00'      02e8 ; =0x00 =0 =NUL [PBC0: control byte]
         DB    X'83'      02e9 ; =0x83 =131(-125) [PBACH: attn char]
         DB    X'18'      02ea ; =0x18 =24 [PBLC: line count (crt screen size)]
         DW    X'F204'    02eb ; =0xf204 =61956(-3580) [PBDVA: device address]
         DB    X'C5'      02ed ; =0xc5 =197(-59) ='E' [PBMCB: mux control byte] [7E1 @ 9600]
         DB    X'02'      02ee ; =0x02 =2 [PBCUNT: pub console unit number]
         DW    X'0000'    02ef ; =0x0000 =0 =NUL,NUL [PBTIB: tib address for this console]
         DW    X'0000'    02f1 ; =0x0000 =0 =NUL,NUL [PBISR: user interupt service routine]
         DW    PD001      02f3 ; =0x2bc5 =11205 [PBPD: pub pre-driver]
>PUB3    DB    X'C2'      02f5 ; =0xc2 =194(-62) ='B' [PBF0: flag 0] (OUT: output allowed, ACT: active device, EXT: extended pub)
         DB    X'03'      02f6 ; =0x03 =3 [PBDVC: device type] (PRT: printer)
         DB    X'00'      02f7 ; =0x00 =0 =NUL [PBUNT: unit number]
         DW    >PB3DCF    02f8 ; =0x038e =910 [PBDCF: device control flag address]
         DW    >PRTSRB    02fa ; =0x03af =943 [PBSRB: device service service routine block address]
         DC    'PRT0  '   02fc ; hex:d0d2d4b0a0a0 [PBNAM: symbolic device name (6-char)]
         DS    1          0302 ; [Uninitialized memory] [PBENB: input enabled flag (1=true)]
         DS    1          0303 ; [Uninitialized memory] [PBLCH: last char of message]
         DS    1          0304 ; [Uninitialized memory] [PBATN: attention flag]
         DS    2          0305 ; [Uninitialized memory] [PBRCB: address of current rcb]
         DS    1          0307 ; [Uninitialized memory] [PBC0: control byte]
         DS    1          0308 ; [Uninitialized memory] [PBACH: attn char]
         DS    1          0309 ; [Uninitialized memory] [PBLC: line count (crt screen size)]
         DW    X'F206'    030a ; =0xf206 =61958(-3578) [PBDVA: device address]
         DB    X'C5'      030c ; =0xc5 =197(-59) ='E' [PBMCB: mux control byte] [7E1 @ 9600]
         DS    1          030d ; [Uninitialized memory] [PBCUNT: pub console unit number]
         DS    2          030e ; [Uninitialized memory] [PBTIB: tib address for this console]
         DS    2          0310 ; [Uninitialized memory] [PBISR: user interupt service routine]
         DW    X'0000'    0312 ; =0x0000 =0 =NUL,NUL [PBPD: pub pre-driver]
>PUB4    DB    X'57'      0314 ; =0x57 =87 [PBF0: flag 0] (INP: input allowed, OUT: output allowed, SHR: shared device/file, FIL: file oriented device, ACT: active device)
         DB    X'04'      0315 ; =0x04 =4 [PBDVC: device type] (DSC: disk)
         DB    X'00'      0316 ; =0x00 =0 =NUL [PBUNT: unit number]
         DW    >PB45DCF   0317 ; =0x038f =911 [PBDCF: device control flag address]
         DW    >DSCSRB    0319 ; =0x03a1 =929 [PBSRB: device service service routine block address]
         DC    'DISK0 '   031b ; hex:c4c9d3cbb0a0 [PBNAM: symbolic device name (6-char)]
         DW    X'032A'    0321 ; =0x032a =810 [PBNTK: number of tracks on disk]
         DB    X'00'      0323 ; =0x00 =0 =NUL [PBDSC: disk select code]
         DW    X'0000'    0324 ; =0x0000 =0 =NUL,NUL [PBBST: addr of bst for this disk]
         DB    X'40'      0326 ; =0x40 =64 [PBBSTL: length of bst]
         DW    X'F140'    0327 ; =0xf140 =61760(-3776) [PBDDVA: device address of disk]
>PUB5    DB    X'57'      0329 ; =0x57 =87 [PBF0: flag 0] (INP: input allowed, OUT: output allowed, SHR: shared device/file, FIL: file oriented device, ACT: active device)
         DB    X'04'      032a ; =0x04 =4 [PBDVC: device type] (DSC: disk)
         DB    X'01'      032b ; =0x01 =1 [PBUNT: unit number]
         DW    >PB45DCF   032c ; =0x038f =911 [PBDCF: device control flag address]
         DW    >DSCSRB    032e ; =0x03a1 =929 [PBSRB: device service service routine block address]
         DC    'DISK1 '   0330 ; hex:c4c9d3cbb1a0 [PBNAM: symbolic device name (6-char)]
         DW    X'032A'    0336 ; =0x032a =810 [PBNTK: number of tracks on disk]
         DB    X'01'      0338 ; =0x01 =1 [PBDSC: disk select code]
         DW    X'0000'    0339 ; =0x0000 =0 =NUL,NUL [PBBST: addr of bst for this disk]
         DB    X'40'      033b ; =0x40 =64 [PBBSTL: length of bst]
         DW    X'F140'    033c ; =0xf140 =61760(-3776) [PBDDVA: device address of disk]
>PUB6    DB    X'47'      033e ; =0x47 =71 [PBF0: flag 0] (INP: input allowed, OUT: output allowed, SHR: shared device/file, ACT: active device)
         DB    X'00'      033f ; =0x00 =0 =NUL [PBDVC: device type] (DUM: dummy)
         DB    X'00'      0340 ; =0x00 =0 =NUL [PBUNT: unit number]
         DW    >PB6DCF    0341 ; =0x0390 =912 [PBDCF: device control flag address]
         DW    >DUMSRB    0343 ; =0x03b7 =951 [PBSRB: device service service routine block address]
         DC    'DUMMY '   0345 ; hex:c4d5cdcdd9a0 [PBNAM: symbolic device name (6-char)]
         DS    1          034b ; [Uninitialized memory] [PBENB: input enabled flag (1=true)]
         DS    1          034c ; [Uninitialized memory] [PBLCH: last char of message]
         DS    1          034d ; [Uninitialized memory] [PBATN: attention flag]
         DS    2          034e ; [Uninitialized memory] [PBRCB: address of current rcb]
         DS    1          0350 ; [Uninitialized memory] [PBC0: control byte]
         DS    1          0351 ; [Uninitialized memory] [PBACH: attn char]
         DS    1          0352 ; [Uninitialized memory] [PBLC: line count (crt screen size)]
         DS    2          0353 ; [Uninitialized memory] [PBDVA: device address]
         DS    1          0355 ; [Uninitialized memory] [PBMCB: mux control byte] [5O1 @ 19200]
         DS    1          0356 ; [Uninitialized memory] [PBCUNT: pub console unit number]
         DW    X'0000'    0357 ; =0x0000 =0 =NUL,NUL [PBPD: pub pre-driver]
>PUB7    DB    X'C7'      0359 ; =0xc7 =199(-57) ='G' [PBF0: flag 0] (INP: input allowed, OUT: output allowed, SHR: shared device/file, ACT: active device, EXT: extended pub)
         DB    X'00'      035a ; =0x00 =0 =NUL [PBDVC: device type] (DUM: dummy)
         DB    X'00'      035b ; =0x00 =0 =NUL [PBUNT: unit number]
         DW    >PB7DCF    035c ; =0x0391 =913 [PBDCF: device control flag address]
         DW    >DUMSRB    035e ; =0x03b7 =951 [PBSRB: device service service routine block address]
         DC    'BLIND '   0360 ; hex:c2ccc9cec4a0 [PBNAM: symbolic device name (6-char)]
         DB    X'00'      0366 ; =0x00 =0 =NUL [PBENB: input enabled flag (1=true)]
         DB    X'00'      0367 ; =0x00 =0 =NUL [PBLCH: last char of message]
         DB    X'00'      0368 ; =0x00 =0 =NUL [PBATN: attention flag]
         DW    X'0000'    0369 ; =0x0000 =0 =NUL,NUL [PBRCB: address of current rcb]
         DB    X'00'      036b ; =0x00 =0 =NUL [PBC0: control byte]
         DB    X'00'      036c ; =0x00 =0 =NUL [PBACH: attn char]
         DB    X'00'      036d ; =0x00 =0 =NUL [PBLC: line count (crt screen size)]
         DW    X'0000'    036e ; =0x0000 =0 =NUL,NUL [PBDVA: device address]
         DB    X'00'      0370 ; =0x00 =0 =NUL [PBMCB: mux control byte] [5O1 @ 19200]
         DB    X'FF'      0371 ; =0xff =255(-1) [PBCUNT: pub console unit number]
         DW    X'0000'    0372 ; =0x0000 =0 =NUL,NUL [PBPD: pub pre-driver]
>PUB8    DB    X'06'      0374 ; =0x06 =6 [PBF0: flag 0] (OUT: output allowed, SHR: shared device/file)
         DB    X'09'      0375 ; =0x09 =9 [PBDVC: device type] (SPL: spooler)
         DB    X'00'      0376 ; =0x00 =0 =NUL [PBUNT: unit number]
         DW    >PB8DCF    0377 ; =0x0392 =914 [PBDCF: device control flag address]
         DW    >SPLSRB    0379 ; =0x03bf =959 [PBSRB: device service service routine block address]
         DC    'PRTQ  '   037b ; hex:d0d2d4d1a0a0 [PBNAM: symbolic device name (6-char)]
         DS    8          0381 ; [Uninitialized memory]
         DW    X'0000'    0389 ; =0x0000 =0 =NUL,NUL
>PB0DCF  DB    X'00'      038b ; =0x00 =0 =NUL
>PB1DCF  DB    X'00'      038c ; =0x00 =0 =NUL
>PB2DCF  DB    X'00'      038d ; =0x00 =0 =NUL
>PB3DCF  DB    X'00'      038e ; =0x00 =0 =NUL
>PB45DCF DB    X'00'      038f ; =0x00 =0 =NUL
>PB6DCF  DB    X'00'      0390 ; =0x00 =0 =NUL
>PB7DCF  DB    X'00'      0391 ; =0x00 =0 =NUL
>PB8DCF  DB    X'00'      0392 ; =0x00 =0 =NUL
>DVITBL  DW    IODFI      0393 ; =0x27e8 =10216
         DW    IODJI      0395 ; =0x2860 =10336
         DW    X'0000'    0397 ; DVI end of table
>CRTSRB  DB    X'00'      0399 ; =0x00 =0 =NUL [Busy flag]
         DB    X'02'      039a ; =0x02 =2 [Max function]
         DW    QIOA       039b ; =0x0823 =2083
         DW    IODFR      039d ; =0x25c8 =9672
         DW    IODFW      039f ; =0x25ed =9709
>DSCSRB  DB    X'00'      03a1 ; =0x00 =0 =NUL [Busy flag]
         DB    X'05'      03a2 ; =0x05 =5 [Max function]
         DW    QIOB       03a3 ; =0x0816 =2070
         DW    DIOR       03a5 ; =0x2b75 =11125
         DW    DIOW       03a7 ; =0x2b9f =11167
         DW    IOD1IO     03a9 ; =0x2154 =8532
         DW    IOD1S      03ab ; =0x22a9 =8873
         DW    IOD1RS     03ad ; =0x22bd =8893
>PRTSRB  DB    X'00'      03af ; =0x00 =0 =NUL [Busy flag]
         DB    X'02'      03b0 ; =0x02 =2 [Max function]
         DW    QIOB       03b1 ; =0x0816 =2070
         DW    X'0000'    03b3 ; =0x0000 =0 =NUL,NUL
         DW    IODMW      03b5 ; =0x29fd =10749
>DUMSRB  DB    X'00'      03b7 ; =0x00 =0 =NUL [Busy flag]
         DB    X'02'      03b8 ; =0x02 =2 [Max function]
         DW    QIOB       03b9 ; =0x0816 =2070
         DW    IOD2R      03bb ; =0x25b0 =9648
         DW    IOD2W      03bd ; =0x25b5 =9653
>SPLSRB  DB    X'00'      03bf ; =0x00 =0 =NUL [Busy flag]
         DB    X'0A'      03c0 ; =0x0a =10 [Max function]
         DW    QIOB       03c1 ; =0x0816 =2070
         DW    X'0000'    03c3 ; =0x0000 =0 =NUL,NUL
         DW    IODS       03c5 ; =0x2967 =10599
         DB    0,4        03c7 ; =0x00,0x0004
         DW    IODS       03cb ; =0x2967 =10599
         DW    IODSI      03cd ; =0x2979 =10617
         DW    X'0000'    03cf ; =0x0000 =0 =NUL,NUL
         DW    IODSV      03d1 ; =0x299d =10653
         DW    IODS       03d3 ; =0x2967 =10599
         DW    IODS       03d5 ; =0x2967 =10599
>FCB00   DB    X'01'      03d7 ; =0x01 =1 [FBNXF: address of next free fcb]
         DB    0,6        03d8 ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      03de ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    03df ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    03e1 ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    03e3 ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      03e5 ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    03e6 ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
>FCB01   DB    X'02'      03e8 ; =0x02 =2 [FBNXF: address of next free fcb]
         DB    0,6        03e9 ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      03ef ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    03f0 ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    03f2 ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    03f4 ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      03f6 ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    03f7 ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
>FCB02   DB    X'03'      03f9 ; =0x03 =3 [FBNXF: address of next free fcb]
         DB    0,6        03fa ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      0400 ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    0401 ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    0403 ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    0405 ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      0407 ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    0408 ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
>FCB03   DB    X'04'      040a ; =0x04 =4 [FBNXF: address of next free fcb]
         DB    0,6        040b ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      0411 ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    0412 ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    0414 ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    0416 ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      0418 ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    0419 ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
>FCB04   DB    X'05'      041b ; =0x05 =5 [FBNXF: address of next free fcb]
         DB    0,6        041c ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      0422 ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    0423 ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    0425 ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    0427 ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      0429 ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    042a ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
>FCB05   DB    X'06'      042c ; =0x06 =6 [FBNXF: address of next free fcb]
         DB    0,6        042d ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      0433 ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    0434 ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    0436 ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    0438 ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      043a ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    043b ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
>FCB06   DB    X'07'      043d ; =0x07 =7 [FBNXF: address of next free fcb]
         DB    0,6        043e ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      0444 ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    0445 ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    0447 ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    0449 ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      044b ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    044c ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
>FCB07   DB    X'08'      044e ; =0x08 =8 [FBNXF: address of next free fcb]
         DB    0,6        044f ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      0455 ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    0456 ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    0458 ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    045a ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      045c ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    045d ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
>FCB08   DB    X'09'      045f ; =0x09 =9 [FBNXF: address of next free fcb]
         DB    0,6        0460 ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      0466 ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    0467 ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    0469 ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    046b ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      046d ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    046e ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
>FCB09   DB    X'0A'      0470 ; =0x0a =10 [FBNXF: address of next free fcb]
         DB    0,6        0471 ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      0477 ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    0478 ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    047a ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    047c ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      047e ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    047f ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
>FCB10   DB    X'0B'      0481 ; =0x0b =11 [FBNXF: address of next free fcb]
         DB    0,6        0482 ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      0488 ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    0489 ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    048b ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    048d ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      048f ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    0490 ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
>FCB11   DB    X'0C'      0492 ; =0x0c =12 [FBNXF: address of next free fcb]
         DB    0,6        0493 ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      0499 ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    049a ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    049c ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    049e ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      04a0 ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    04a1 ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
>FCB12   DB    X'0D'      04a3 ; =0x0d =13 [FBNXF: address of next free fcb]
         DB    0,6        04a4 ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      04aa ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    04ab ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    04ad ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    04af ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      04b1 ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    04b2 ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
>FCB13   DB    X'0E'      04b4 ; =0x0e =14 [FBNXF: address of next free fcb]
         DB    0,6        04b5 ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      04bb ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    04bc ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    04be ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    04c0 ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      04c2 ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    04c3 ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
>FCB14   DB    X'0F'      04c5 ; =0x0f =15 [FBNXF: address of next free fcb]
         DB    0,6        04c6 ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      04cc ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    04cd ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    04cf ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    04d1 ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      04d3 ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    04d4 ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
>FCB15   DB    X'10'      04d6 ; =0x10 =16 [FBNXF: address of next free fcb]
         DB    0,6        04d7 ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      04dd ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    04de ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    04e0 ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    04e2 ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      04e4 ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    04e5 ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
>FCB16   DB    X'11'      04e7 ; =0x11 =17 [FBNXF: address of next free fcb]
         DB    0,6        04e8 ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      04ee ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    04ef ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    04f1 ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    04f3 ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      04f5 ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    04f6 ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
>FCB17   DB    X'12'      04f8 ; =0x12 =18 [FBNXF: address of next free fcb]
         DB    0,6        04f9 ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      04ff ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    0500 ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    0502 ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    0504 ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      0506 ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    0507 ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
>FCB18   DB    X'13'      0509 ; =0x13 =19 [FBNXF: address of next free fcb]
         DB    0,6        050a ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      0510 ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    0511 ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    0513 ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    0515 ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      0517 ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    0518 ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
>FCB19   DB    X'14'      051a ; =0x14 =20 [FBNXF: address of next free fcb]
         DB    0,6        051b ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      0521 ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    0522 ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    0524 ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    0526 ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      0528 ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    0529 ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
>FCB20   DB    X'15'      052b ; =0x15 =21 [FBNXF: address of next free fcb]
         DB    0,6        052c ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      0532 ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    0533 ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    0535 ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    0537 ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      0539 ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    053a ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
>FCB21   DB    X'16'      053c ; =0x16 =22 [FBNXF: address of next free fcb]
         DB    0,6        053d ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      0543 ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    0544 ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    0546 ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    0548 ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      054a ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    054b ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
>FCB22   DB    X'17'      054d ; =0x17 =23 [FBNXF: address of next free fcb]
         DB    0,6        054e ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      0554 ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    0555 ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    0557 ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    0559 ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      055b ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    055c ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
>FCB23   DB    X'18'      055e ; =0x18 =24 [FBNXF: address of next free fcb]
         DB    0,6        055f ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      0565 ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    0566 ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    0568 ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    056a ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      056c ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    056d ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
>FCB24   DB    X'19'      056f ; =0x19 =25 [FBNXF: address of next free fcb]
         DB    0,6        0570 ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      0576 ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    0577 ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    0579 ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    057b ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      057d ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    057e ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
>FCB25   DB    X'FF'      0580 ; =0xff =255(-1) [FBNXF: address of next free fcb]
         DB    0,6        0581 ; =0x00,0x0006 [FBFNM: file name]
         DB    X'00'      0587 ; =0x00 =0 =NUL [FBATT: file attribute (type)] (DIR: directory file)
         DW    X'0000'    0588 ; =0x0000 =0 =NUL,NUL [FBDA: disc address]
         DW    X'0000'    058a ; =0x0000 =0 =NUL,NUL [FBBP: buffer pointer]
         DW    X'0000'    058c ; =0x0000 =0 =NUL,NUL [FBSZ: file track size]
         DB    X'00'      058e ; =0x00 =0 =NUL [FBF0: flag 0] ()
         DW    X'0000'    058f ; =0x0000 =0 =NUL,NUL [FBFLB: disk address of library]
ATNQUE   DW    X'FFFF'    0591 ; =0xffff =65535(-1)
         DW    X'FFFF'    0593 ; =0xffff =65535(-1)
         DB    X'FF'      0595 ; =0xff =255(-1)
>SHTBL   DB    X'FF'      0596 ; =0xff =255(-1) [Task id]
         DB    X'00'      0597 ; =0x00 =0 =NUL [Disk number]
         DW    X'FF00'    0598 ; =0xff00 =65280(-256) [Disk address]
         DB    X'FF'      059a ; =0xff =255(-1) [Task id]
         DB    X'00'      059b ; =0x00 =0 =NUL [Disk number]
         DW    X'FF00'    059c ; =0xff00 =65280(-256) [Disk address]
         DB    X'FF'      059e ; =0xff =255(-1) [Task id]
         DB    X'00'      059f ; =0x00 =0 =NUL [Disk number]
         DW    X'FF00'    05a0 ; =0xff00 =65280(-256) [Disk address]
         DB    X'FF'      05a2 ; =0xff =255(-1) [Task id]
         DB    X'00'      05a3 ; =0x00 =0 =NUL [Disk number]
         DW    X'FF00'    05a4 ; =0xff00 =65280(-256) [Disk address]
         DB    X'FF'      05a6 ; =0xff =255(-1) [Task id]
         DB    X'00'      05a7 ; =0x00 =0 =NUL [Disk number]
         DW    X'FF00'    05a8 ; =0xff00 =65280(-256) [Disk address]
         DB    X'FF'      05aa ; =0xff =255(-1) [Task id]
         DB    X'00'      05ab ; =0x00 =0 =NUL [Disk number]
         DW    X'FF00'    05ac ; =0xff00 =65280(-256) [Disk address]
         DB    X'FF'      05ae ; =0xff =255(-1) [Task id]
         DB    X'00'      05af ; =0x00 =0 =NUL [Disk number]
         DW    X'FF00'    05b0 ; =0xff00 =65280(-256) [Disk address]
         DB    X'FF'      05b2 ; =0xff =255(-1) [Task id]
         DB    X'00'      05b3 ; =0x00 =0 =NUL [Disk number]
         DW    X'FF00'    05b4 ; =0xff00 =65280(-256) [Disk address]
         DB    X'FF'      05b6 ; =0xff =255(-1) [Task id]
         DB    X'00'      05b7 ; =0x00 =0 =NUL [Disk number]
         DW    X'FF00'    05b8 ; =0xff00 =65280(-256) [Disk address]
         DB    X'FF'      05ba ; =0xff =255(-1) [Task id]
         DB    X'00'      05bb ; =0x00 =0 =NUL [Disk number]
         DW    X'FF00'    05bc ; =0xff00 =65280(-256) [Disk address]
         DB    X'FF'      05be ; =0xff =255(-1) [Task id]
         DB    X'00'      05bf ; =0x00 =0 =NUL [Disk number]
         DW    X'FF00'    05c0 ; =0xff00 =65280(-256) [Disk address]
         DB    X'FF'      05c2 ; =0xff =255(-1) [Task id]
         DB    X'00'      05c3 ; =0x00 =0 =NUL [Disk number]
         DW    X'FF00'    05c4 ; =0xff00 =65280(-256) [Disk address]
         DB    X'FF'      05c6 ; =0xff =255(-1) [Task id]
         DB    X'00'      05c7 ; =0x00 =0 =NUL [Disk number]
         DW    X'FF00'    05c8 ; =0xff00 =65280(-256) [Disk address]
         DB    X'FF'      05ca ; =0xff =255(-1) [Task id]
         DB    X'00'      05cb ; =0x00 =0 =NUL [Disk number]
         DW    X'FF00'    05cc ; =0xff00 =65280(-256) [Disk address]
         DB    X'FF'      05ce ; =0xff =255(-1) [Task id]
         DB    X'00'      05cf ; =0x00 =0 =NUL [Disk number]
         DW    X'FF00'    05d0 ; =0xff00 =65280(-256) [Disk address]
         DB    X'FF'      05d2 ; =0xff =255(-1) [Task id]
         DB    X'00'      05d3 ; =0x00 =0 =NUL [Disk number]
         DW    X'FF00'    05d4 ; =0xff00 =65280(-256) [Disk address]
         DW    X'FFFF'    05d6 ; =0xffff =65535(-1)
>TB0LUB  DB    X'00'      05d8 ; =0x00 =0 =NUL [PUB number (-1=not assigned)] [SYSRDR]
         DB    X'FF'      05d9 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'00'      05da ; =0x00 =0 =NUL [PUB number (-1=not assigned)] [SYSIPT]
         DB    X'FF'      05db ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'00'      05dc ; =0x00 =0 =NUL [PUB number (-1=not assigned)] [SYSLOG]
         DB    X'FF'      05dd ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'00'      05de ; =0x00 =0 =NUL [PUB number (-1=not assigned)] [SYSLST]
         DB    X'FF'      05df ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      05e0 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS000]
         DB    X'FF'      05e1 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      05e2 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS001]
         DB    X'FF'      05e3 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      05e4 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS002]
         DB    X'FF'      05e5 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      05e6 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS003]
         DB    X'FF'      05e7 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      05e8 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS004]
         DB    X'FF'      05e9 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      05ea ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS005]
         DB    X'FF'      05eb ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      05ec ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS006]
         DB    X'FF'      05ed ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      05ee ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS007]
         DB    X'FF'      05ef ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      05f0 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS008]
         DB    X'FF'      05f1 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      05f2 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS009]
         DB    X'FF'      05f3 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      05f4 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS010]
         DB    X'FF'      05f5 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      05f6 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS011]
         DB    X'FF'      05f7 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      05f8 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS012]
         DB    X'FF'      05f9 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      05fa ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS013]
         DB    X'FF'      05fb ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      05fc ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS014]
         DB    X'FF'      05fd ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      05fe ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS015]
         DB    X'FF'      05ff ; =0xff =255(-1) [FCB address (-1=not assigned)]
>TB1LUB  DB    X'06'      0600 ; =0x06 =6 [PUB number (-1=not assigned)] [SYSRDR]
         DB    X'FF'      0601 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'06'      0602 ; =0x06 =6 [PUB number (-1=not assigned)] [SYSIPT]
         DB    X'FF'      0603 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'06'      0604 ; =0x06 =6 [PUB number (-1=not assigned)] [SYSLOG]
         DB    X'FF'      0605 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'06'      0606 ; =0x06 =6 [PUB number (-1=not assigned)] [SYSLST]
         DB    X'FF'      0607 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0608 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS000]
         DB    X'FF'      0609 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      060a ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS001]
         DB    X'FF'      060b ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      060c ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS002]
         DB    X'FF'      060d ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      060e ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS003]
         DB    X'FF'      060f ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0610 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS004]
         DB    X'FF'      0611 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0612 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS005]
         DB    X'FF'      0613 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0614 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS006]
         DB    X'FF'      0615 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0616 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS007]
         DB    X'FF'      0617 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0618 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS008]
         DB    X'FF'      0619 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      061a ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS009]
         DB    X'FF'      061b ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      061c ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS010]
         DB    X'FF'      061d ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      061e ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS011]
         DB    X'FF'      061f ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0620 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS012]
         DB    X'FF'      0621 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0622 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS013]
         DB    X'FF'      0623 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0624 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS014]
         DB    X'FF'      0625 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0626 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS015]
         DB    X'FF'      0627 ; =0xff =255(-1) [FCB address (-1=not assigned)]
>TB2LUB  DB    X'06'      0628 ; =0x06 =6 [PUB number (-1=not assigned)] [SYSRDR]
         DB    X'FF'      0629 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'06'      062a ; =0x06 =6 [PUB number (-1=not assigned)] [SYSIPT]
         DB    X'FF'      062b ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'06'      062c ; =0x06 =6 [PUB number (-1=not assigned)] [SYSLOG]
         DB    X'FF'      062d ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'06'      062e ; =0x06 =6 [PUB number (-1=not assigned)] [SYSLST]
         DB    X'FF'      062f ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0630 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS000]
         DB    X'FF'      0631 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0632 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS001]
         DB    X'FF'      0633 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0634 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS002]
         DB    X'FF'      0635 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0636 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS003]
         DB    X'FF'      0637 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0638 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS004]
         DB    X'FF'      0639 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      063a ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS005]
         DB    X'FF'      063b ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      063c ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS006]
         DB    X'FF'      063d ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      063e ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS007]
         DB    X'FF'      063f ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0640 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS008]
         DB    X'FF'      0641 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0642 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS009]
         DB    X'FF'      0643 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0644 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS010]
         DB    X'FF'      0645 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0646 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS011]
         DB    X'FF'      0647 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0648 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS012]
         DB    X'FF'      0649 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      064a ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS013]
         DB    X'FF'      064b ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      064c ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS014]
         DB    X'FF'      064d ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      064e ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS015]
         DB    X'FF'      064f ; =0xff =255(-1) [FCB address (-1=not assigned)]
>TB3LUB  DB    X'06'      0650 ; =0x06 =6 [PUB number (-1=not assigned)] [SYSRDR]
         DB    X'FF'      0651 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'06'      0652 ; =0x06 =6 [PUB number (-1=not assigned)] [SYSIPT]
         DB    X'FF'      0653 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'06'      0654 ; =0x06 =6 [PUB number (-1=not assigned)] [SYSLOG]
         DB    X'FF'      0655 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'06'      0656 ; =0x06 =6 [PUB number (-1=not assigned)] [SYSLST]
         DB    X'FF'      0657 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0658 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS000]
         DB    X'FF'      0659 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      065a ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS001]
         DB    X'FF'      065b ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      065c ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS002]
         DB    X'FF'      065d ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      065e ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS003]
         DB    X'FF'      065f ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0660 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS004]
         DB    X'FF'      0661 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0662 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS005]
         DB    X'FF'      0663 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0664 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS006]
         DB    X'FF'      0665 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0666 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS007]
         DB    X'FF'      0667 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0668 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS008]
         DB    X'FF'      0669 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      066a ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS009]
         DB    X'FF'      066b ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      066c ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS010]
         DB    X'FF'      066d ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      066e ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS011]
         DB    X'FF'      066f ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0670 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS012]
         DB    X'FF'      0671 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0672 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS013]
         DB    X'FF'      0673 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0674 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS014]
         DB    X'FF'      0675 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DB    X'FF'      0676 ; =0xff =255(-1) [PUB number (-1=not assigned)] [SYS015]
         DB    X'FF'      0677 ; =0xff =255(-1) [FCB address (-1=not assigned)]
         DC    ' ',6      0678
>TB0PRM  DC    ' ',66     067e
>TB1PRM  DC    ' ',66     06c0
>TB2PRM  DC    ' ',66     0702
>TB3PRM  DC    ' ',60     0744
>SVCTBL  DW    OSN3       0780 ; PIOC - physical i/o control
         DW    OSNTR      0782 ; TRTN - transient return
         DW    OSN4A      0784 ; LODNM - load file name specified
         DW    OSN4B      0786 ; LODD - load specifying disk addr
         DW    OSN4       0788 ; LODJX - load JX module specified
         DW    OSNA       078a ; TS - load transient module
         DW    FLGWT      078c ; FLWT - wait for flag to go positive
         DW    WAIT       078e ; WT - unconditional wait
         DW    RCBWT      0790 ; RBWT - wait for RCB to go ready
         DW    ABRT       0792 ; ABRT - abort task
         DW    EXIT       0794 ; EXIT - exit to OJX00
         DW    GETDAT     0796 ; DT - get binary date
         DW    OSN3A      0798 ; GIOB - get I/O block
         DW    OSN5A      079a ; DIRPD - search pri dir
         DW    OSN5       079c ; DIRNM - search directory for file name specified
         DW    OSN3B      079e ; CONIO - console I/O
         DW    OSN3C      07a0 ; SYSIO - device-independent logical I/O [all units]
         DW    DIO        07a2 ; DIO - disk I/O call
         DW    OSN6       07a4 ; SHLD - disk sector hold
         DW    OSN6A      07a6 ; SFRE - disk sector free
         DW    DIO1       07a8 ; DRDY - disk ready check
         DW    DIOL       07aa ; DIOL - disk I/O with length spec.
         DW    OSNAGM     07ac ; GMEM - get memory block from transient area
         DW    OSNARM     07ae ; RMEM - release memory block back to transient area
         DW    OSN9A      07b0 ; LIOC - logical I/O control
         DW    OSN2       07b2 ; EXP - file expand
         DW    X'0000'    07b4 ; undefined
         DW    IODJBT     07b6 ; GB - get binary time
         DW    IODJCT     07b8 ; GC - get character time
         DW    X'0000'    07ba ; undefined
         DW    LOD32      07bc ; LD - CPL 32-bit load
         DW    STO32      07be ; ST - CPL 32-bit store
         DW    ADD32      07c0 ; AD - CPL 32-bit add
         DW    DIOLF      07c2 ; DIOLF - DIO with return on error
         DW    SUB32      07c4 ; SU - CPL 32-bit subtract
         DW    LOCDNO     07c6 ; GDPUB - locate pub for disk specified in AL
         DW    MUL32      07c8 ; MU - CPL 32-bit multiply
         DW    DIV32      07ca ; DV - CPL 32-bit divide
         DW    COM32      07cc ; CN - CPL 32-bit numeric compare
         DW    COMST      07ce ; CS - CPL string compare
         DW    COMG32     07d0 ; CG - CPL 32-bit computed goto
         DW    MOVST      07d2 ; MV - CPL 32-bit string move
         DW    @CP        07d4 ; CP - CPL cursor position
         DW    MUL16      07d6 ; MUL16 - 16-bit multiply
         DW    DIV16      07d8 ; DIV16 - 16-bit divide
         DW    CVD16      07da ; CVD16 - 16-bit convert to decimal from memory
         DW    CVR16      07dc ; CVR16 - 16-bit convert to decimal from A register
         DW    @CB        07de ; CB - CPL cursor blanking
         DW    @CS        07e0 ; CC - CPL cursor blanking with specified string
         DW    @WN        07e2 ; WN - CPL formatted write without CR
         DW    @DC        07e4 ; DC - CPL decode
         DW    @NC        07e6 ; NC - CPL encode
         DW    @RF        07e8 ; RF - CPL formatted read
         DW    @WF        07ea ; WF - CPL formatted write
         DW    @RT        07ec ; RT - CPL rewrite
         DW    @RB        07ee ; RB - CPL binary read
         DW    @WB        07f0 ; WB - CPL binary write
         DW    @OP        07f2 ; OP - CPL open
         DW    @CT        07f4 ; CT - CPL control function
         DW    LOD48      07f6 ; LD48 - CPL 48-bit load
         DW    STO48      07f8 ; ST48 - CPL 48-bit store
         DW    ADD48      07fa ; AD48 - CPL 48-bit add
         DW    LSFT64     07fc ; SL64 - CPL 64-bit left shift
         DW    SUB48      07fe ; SU48 - CPL 48-bit subtract
         DW    NEG64      0800 ; NEG64 - CPL 64-bit negate
         DW    MUL48      0802 ; MU48 - CPL 48-bit multiply
         DW    DIV48      0804 ; DV48 - CPL 48-bit divide
         DW    COM48      0806 ; CN48 - CPL 48-bit numeric compare
         DW    COMG48     0808 ; CG48 - CPL 48-bit computed goto
         DW    LOD64      080a ; LD64 - CPL 64-bit load
         DW    STO64      080c ; ST64 - CPL 64-bit store
         DW    ADD64      080e ; AD64 - CPL 64-bit add
         DW    SUB64      0810 ; SU64 - CPL 64-bit subtract
         DW    MUL64      0812 ; MU64 - CPL 64-bit multiply
         DW    DIV64      0814 ; DV64 - CPL 64-bit divide
*
*
* Function QIOB
*
QIOB     LDAB+ *Z,3       0816 ; [Load AL indexed, displaced, indirect]
         SABB             0819 ; [AL - BL -> BL]
         BNZ   @D0822     081a ; =+6 [Branch if not zero]
         STBB+ *Z,3       081c ; [Store BL indexed, displaced, indirect]
         STBB+ *Z,5       081f ; [Store BL indexed, displaced, indirect]
@D0822   RSR              0822 ; [Return from subroutine]
*
* Function QIOA
*
QIOA     JSR   QIOB       0823 ; =-15 [Jump to subroutine relative]
         LDA=  >M0PPTR    0825 ; =0x0162 =354 [Load A with immediate]
@D0828   LDB+  A+         0828 ; [Load B indexed, direct, post-incremented]
         BZ    @D083B     082a ; =+15 [Branch if zero]
         SUB   Z,B        082c ; [Z - B -> B]
         BNZ   @D0828     082e ; =-8 [Branch if not zero]
         CLA              0830 ; [Clear A]
         STA+  Z,27       0831 ; [Store A indexed, displaced, direct]
         LDA+  Z,21       0834 ; [Load A indexed, displaced, direct]
         LDBB+ Z,23       0837 ; [Load BL indexed, displaced, direct]
         STBB+ A          083a ; [Store BL to address in A]
@D083B   LDAB+ Z,13       083b ; [Load AL indexed, displaced, direct]
         BZ    @D0847     083e ; =+7 [Branch if zero]
         CLAB             0840 ; [Clear AL]
         STAB+ Z,13       0841 ; [Store AL indexed, displaced, direct]
         STAB+ *Z,16      0844 ; [Store AL indexed, displaced, indirect]
@D0847   RSR              0847 ; [Return from subroutine]
*
* ORG X'0848' overlaid 42 uninitialized bytes
SYSBUF   DW    X'0023'    0848 ; =0x0023 =35
         DC    'CENTURION III (3,H2,F0,FB26,6,PRTQ)' 084a
*
* Function ENTRY
*
ENTRY    JMP/  OSNZ       086d ; =0x2d70 =11632 [Jump direct]
*
TRTBL    DW    X'0000'    0870 ; =0x0000 =0 =NUL,NUL
         DS    360        0872 ; [Uninitialized memory]
         DW    X'0000'    09da ; =0x0000 =0 =NUL,NUL
         DW    X'8D8D'    09dc ; =0x8d8d =36237(-29299) =CR,CR
         DB    X'FF'      09de ; =0xff =255(-1)
*
* Function OSN1 (OSNLB4/OSNLB5)
*
*
* Exts:
*   OSN0
*   DIORST
*   OSNAXT
*   CVR16
*   @HEX
*   OSN3C
*   OSNA
*   ATNQUE
*   OSN3B
*   OSN4
*
OSN1     STA-  S-         09df ; [Push A to the stack]
         STB-  S-         09e1 ; [Push B to the stack]
         CLA              09e3 ; [Clear A]
         STAB/ OSN0+65    09e4 ; [external symbol] [Store AL direct]
         LDAB+ X+         09e7 ; [Load AL indexed, direct, post-incremented]
         BM    @D0A29     09e9 ; =+62 [Branch on minus]
         STA-  S-         09eb ; [Push A to the stack]
         LDBB= X'11'      09ed ; =17 [Load BL with immediate]
         SABB             09ef ; [AL - BL -> BL]
         BZ    @D0A10     09f0 ; =+30 [Branch if zero]
         LDBB= X'15'      09f2 ; =21 [Load BL with immediate]
         SABB             09f4 ; [AL - BL -> BL]
         BZ    @D0A10     09f5 ; =+25 [Branch if zero]
         LDBB= X'21'      09f7 ; =33 [Load BL with immediate]
         SABB             09f9 ; [AL - BL -> BL]
         BZ    @D0A10     09fa ; =+20 [Branch if zero]
@P09FC   LDB/  OSN0+3     09fc ; [external symbol] [Load B direct]
         LDAB+ B,2        09ff ; [Load AL indexed, displaced, direct]
         BP    @D0A0C     0a02 ; =+8 [Branch on plus]
         JSR/  WAIT       0a04 ; =0x0b5e =2910 [Jump to subroutine direct]
         LDB*  @P09FC+1   0a07 ; =-12 [Load B relative indirect]
         LDAB+ B,3        0a09 ; [Load AL indexed, displaced, direct]
@D0A0C   DCAB             0a0c ; [Decrement AL]
         STAB+ B,2        0a0d ; [Store AL indexed, displaced, direct]
@D0A10   LDA+  S+         0a10 ; [Pop A from the stack]
         LDBB/ OSN0+36    0a12 ; [external symbol] [Load BL direct]
         SABB             0a15 ; [AL - BL -> BL]
         BGZ   @D0A29     0a16 ; =+17 [Branch if greater than zero]
         SLA              0a18 ; [Left shift A]
         LDB/  OSN0+34    0a19 ; [external symbol] [Load B direct]
         AAB              0a1c ; [A + B -> B]
         LDA+  B          0a1d ; [Load A from address in B]
         BZ    @D0A29     0a1e ; =+9 [Branch if zero]
         STA   @W0A26+1   0a20 ; =+5 [Store A relative]
         LDB+  S+         0a22 ; [Pop B from the stack]
         LDA+  S+         0a24 ; [Pop A from the stack]
@W0A26   JMP/  X'0000'    0a26 ; =0x0000 =0 =NUL,NUL [Jump direct]
@D0A29   JSR   ABRT       0a29 ; =+127 [Jump to subroutine relative]
         DB    X'09'      0a2b ; =0x09 =9
*
*
* Function @F0A2C
*
@F0A2C   CLA              0a2c ; [Clear A]
         STA+  Z,25       0a2d ; [Store A indexed, displaced, direct]
         XFR   Z,A        0a30 ; [Transfer Z to A]
         STA-  S-         0a32 ; [Push A to the stack]
         STX-  S-         0a34 ; [Push X to the stack]
         LDX/  OSN0+32    0a36 ; [external symbol] [Load X direct]
         LDB+  Z          0a39 ; [Load B from address in Z]
@D0A3A   LDA+  X          0a3a ; [Load A from address in X]
         BM    @D0A4B     0a3b ; =+14 [Branch on minus]
         SUBB  BL,AU      0a3d ; [BL - AU -> AU]
         BNZ   @D0A45     0a3f ; =+4 [Branch if not zero]
         LDA=  X'FF00'    0a41 ; =0xff00 =65280(-256) [Load A with immediate]
         STA+  X          0a44 ; [Store A to address in X]
@D0A45   INX              0a45 ; [Increment X]
         INX              0a46 ; [Increment X]
         INX              0a47 ; [Increment X]
         INX              0a48 ; [Increment X]
         JMP   @D0A3A     0a49 ; =-17 [Jump relative]
@D0A4B   IVA              0a4b ; [Invert A]
         BNZ   @D0A45     0a4c ; =-9 [Branch if not zero]
         INRB  BL         0a4e ; [Increment BL by 1]
         STBB- S-         0a50 ; [Push BL to the stack]
         LDAB+ Z,7        0a52 ; [Load AL indexed, displaced, direct]
         XAX              0a55 ; [Transfer A to X]
         INX              0a56 ; [Increment X]
         LDA+  Z,4        0a57 ; [Load A indexed, displaced, direct]
         DCA              0a5a ; [Decrement A]
         XAY              0a5b ; [Transfer A to Y]
         ADD   X,Y        0a5c ; [X + Y -> Y]
         ADD   X,Y        0a5e ; [X + Y -> Y]
@D0A60   DCX              0a60 ; [Decrement X]
         BM    @D0A81     0a61 ; =+30 [Branch on minus]
         LDA-  Y-         0a63 ; [Load A indexed, pre-decremented, direct]
         CLRB  AU         0a65 ; [Clear AU]
         XABB             0a67 ; [Transfer AL to BL]
         BM    @D0A60     0a68 ; =-10 [Branch on minus]
         SLA              0a6a ; [Left shift A]
         LDB/  OSN0+9     0a6b ; [external symbol] [Load B direct]
         AAB              0a6e ; [A + B -> B]
         LDA+  B          0a6f ; [Load A from address in B]
         XAZ              0a70 ; [Transfer A to Z]
         LDAB+ Z          0a71 ; [Load AL from address in Z]
         BZ    @D0A60     0a72 ; =-20 [Branch if zero]
         LDA+  Z,5        0a74 ; [Load A indexed, displaced, direct]
         INA              0a77 ; [Increment A]
         INA              0a78 ; [Increment A]
         LDBB+ S          0a79 ; [Load BL from address in S]
         LDA+  A          0a7a ; [Load A from address in A]
         BZ    @D0A60     0a7b ; =-29 [Branch if zero]
         JSR+  A          0a7d ; [Jump to subroutine indexed, direct]
         JMP   @D0A60     0a7f ; =-33 [Jump relative]
@D0A81   LDAB+ S+         0a81 ; [Pop AL from the stack]
         LDX+  S+         0a83 ; [Pop X from the stack]
         LDA+  S+         0a85 ; [Pop A from the stack]
         XAZ              0a87 ; [Transfer A to Z]
         LDA+  Z          0a88 ; [Load A from address in Z]
         LDBB/ OSN0+31    0a89 ; [external symbol] [Load BL direct]
         SABB             0a8c ; [AL - BL -> BL]
         BNZ   @D0A92     0a8d ; =+3 [Branch if not zero]
         JSR/  DIORST     0a8f ; [external symbol] [Jump to subroutine direct]
@D0A92   LDA=  @W0B2E     0a92 ; =0x0b2e =2862 [Load A with immediate]
         XAY              0a95 ; [Transfer A to Y]
         LDA+  Z          0a96 ; [Load A from address in Z]
         LDB+  Y+         0a97 ; [Load B indexed, direct, post-incremented]
@D0A99   LDBB+ B          0a99 ; [Load BL from address in B]
         SABB             0a9a ; [AL - BL -> BL]
         BNZ   @D0AA2     0a9b ; =+5 [Branch if not zero]
         LDBB= X'FF'      0a9d ; =255(-1) [Load BL with immediate]
         STBB+ *Y,-2      0a9f ; [Store BL indexed, displaced, indirect]
@D0AA2   LDB+  Y+         0aa2 ; [Load B indexed, direct, post-incremented]
         BNZ   @D0A99     0aa4 ; =-13 [Branch if not zero]
         JSR/  OSNAXT     0aa6 ; [external symbol] [Jump to subroutine direct]
         RSR              0aa9 ; [Return from subroutine]
*
* Function ABRT (OSNLB4/OSNLB5)
*
* SVC ABRT - abort task
*
*
ABRT     STA-  S-         0aaa ; [Push A to the stack]
         STB-  S-         0aac ; [Push B to the stack]
         STX-  S-         0aae ; [Push X to the stack]
         LDA/  OSN0+3     0ab0 ; [external symbol] [Load A direct]
         XAZ              0ab3 ; [Transfer A to Z]
         JSR/  @F0A2C     0ab4 ; =0x0a2c =2604 [Jump to subroutine direct]
         CLA              0ab7 ; [Clear A]
         LDAB+ X          0ab8 ; [Load AL from address in X]
         STAB  @B0B09+1   0ab9 ; =+79 [Store AL relative]
         JSR/  CVR16      0abb ; [external symbol] [Jump to subroutine direct]
         DW    @S0CF6     0abe ; =0x0cf6 =3318
         XFRB  XU,AL      0ac0 ; [Transfer XU to AL]
         JSR/  @HEX       0ac2 ; [external symbol] [Jump to subroutine direct]
         STA/  @S0CFA     0ac5 ; =0x0cfa =3322 [Store A direct]
         XFRB  XL,AL      0ac8 ; [Transfer XL to AL]
         JSR/  @HEX       0aca ; [external symbol] [Jump to subroutine direct]
         STA/  @S0CFC     0acd ; =0x0cfc =3324 [Store A direct]
         LDA=  @W0CED     0ad0 ; =0x0ced =3309 [Load A with immediate]
         STA/  @W0CCE     0ad3 ; =0x0cce =3278 [Store A direct]
         LDB=  @W0CC8     0ad6 ; =0x0cc8 =3272 [Load B with immediate]
         JSR/  OSN3C      0ad9 ; [external symbol] [Jump to subroutine direct]
@D0ADC   LDAB/ @W0CC8     0adc ; =0x0cc8 =3272 [Load AL direct]
         BM    @D0ADC     0adf ; =-5 [Branch on minus]
         LDA/  OSN0+3     0ae1 ; [external symbol] [Load A direct]
         BZ    @B0B09     0ae4 ; =+35 [Branch if zero]
         XAX              0ae6 ; [Transfer A to X]
         LDAB+ X,18       0ae7 ; [Load AL indexed, displaced, direct]
         LDBB= X'80'      0aea ; =128(-128) [Load BL with immediate]
         NABB             0aec ; [AL & BL -> BL]
         BZ    @B0B09     0aed ; =+26 [Branch if zero]
         LDA+  X,10       0aef ; [Load A indexed, displaced, direct]
         STA   @W0B05     0af2 ; =+17 [Store A relative]
         LDA+  X,14       0af4 ; [Load A indexed, displaced, direct]
         STA   @W0B07     0af7 ; =+14 [Store A relative]
         LDX+  S+         0af9 ; [Pop X from the stack]
         LDB+  S+         0afb ; [Pop B from the stack]
         LDA+  S+         0afd ; [Pop A from the stack]
         LDX+  S+         0aff ; [Pop X from the stack]
         JSR/  OSNA       0b01 ; [external symbol] [Jump to subroutine direct]
         DB    X'06'      0b04 ; =0x06 =6
@W0B05   DW    X'0000'    0b05 ; =0x0000 =0 =NUL,NUL
@W0B07   DW    X'0000'    0b07 ; =0x0000 =0 =NUL,NUL
@B0B09   LDBB= X'00'      0b09 ; =0 =NUL [Load BL with immediate]
         JSR   @F0B10     0b0b ; =+3 [Jump to subroutine relative]
         DB    X'FF'      0b0d ; =0xff =255(-1)
*
*
* Function EXIT (OSNLB4/OSNLB5)
*
* SVC EXIT - exit to OJX00
*
*
EXIT     LDBB= X'00'      0b0e ; =0 =NUL [Load BL with immediate]
*
* Function @F0B10
*
@F0B10   LDA/  OSN0+3     0b10 ; [external symbol] [Load A direct]
         XAZ              0b13 ; [Transfer A to Z]
         LDAB+ X          0b14 ; [Load AL from address in X]
         BM    @D0B1A     0b15 ; =+3 [Branch on minus]
         STAB+ Z,20       0b17 ; [Store AL indexed, displaced, direct]
@D0B1A   STBB+ Z,19       0b1a ; [Store BL indexed, displaced, direct]
         CLAB             0b1d ; [Clear AL]
@P0B1E   STAB/ OSN0+37    0b1e ; [external symbol] [Store AL direct]
         LDA+  Z,12       0b21 ; [Load A indexed, displaced, direct]
         XAS              0b24 ; [Transfer A to S]
         JSR/  @F0A2C     0b25 ; =0x0a2c =2604 [Jump to subroutine direct]
         LDAB+ Z          0b28 ; [Load AL from address in Z]
         BZ    @F0B6D     0b29 ; =+66 [Branch if zero]
         JMP/  @J0C9A     0b2b ; =0x0c9a =3226 [Jump direct]
*
@W0B2E   DW    OSN0+28    0b2e ; =0x011c =284
         DW    OSN0+31    0b30 ; =0x011f =287
         DW    OSN0+59    0b32 ; =0x013b =315
         DW    OSN0+60    0b34 ; =0x013c =316
         DW    OSN0+61    0b36 ; =0x013d =317
         DW    X'0000'    0b38 ; =0x0000 =0 =NUL,NUL
*
*
* Function FLGWT (OSNLB4/OSNLB5)
*
* SVC FLWT - wait for flag to go positive
*
*
FLGWT    CLA              0b3a ; [Clear A]
         LDAB+ X+         0b3b ; [Load AL indexed, direct, post-incremented]
         LDB=  OSN0       0b3d ; [external symbol] [Load B with immediate]
         AAB              0b40 ; [A + B -> B]
         STB-  S-         0b41 ; [Push B to the stack]
         JMP   @D0B47     0b43 ; =+2 [Jump relative]
@D0B45   JSR   WAIT       0b45 ; =+23 [Jump to subroutine relative]
@D0B47   LDAB+ *S         0b47 ; [Load AL indexed, indirect]
         BP    @D0B45     0b49 ; =-6 [Branch on plus]
         LDA/  OSN0+3     0b4b ; [external symbol] [Load A direct]
         LDAB+ A,1        0b4e ; [Load AL indexed, displaced, direct]
         LDB+  S+         0b51 ; [Pop B from the stack]
         STAB+ B          0b53 ; [Store AL to address in B]
         RSR              0b54 ; [Return from subroutine]
*
@D0B55   JSR   WAIT       0b55 ; =+7 [Jump to subroutine relative]
*
* Function RCBWT (OSNLB4/OSNLB5)
*
* SVC RBWT - wait for RCB to go ready
*
*
RCBWT    LDAB+ *X         0b57 ; [Load AL indexed, indirect]
         BM    @D0B55     0b59 ; =-6 [Branch on minus]
         INX              0b5b ; [Increment X]
         INX              0b5c ; [Increment X]
         RSR              0b5d ; [Return from subroutine]
*
* Function WAIT (OSNLB4/OSNLB5)
*
* SVC WT - unconditional wait
*
*
WAIT     CLAB             0b5e ; [Clear AL]
         STAB/ OSN0+65    0b5f ; [external symbol] [Store AL direct]
         LDAB* @P0B1E+1   0b62 ; =-69 [Load AL relative indirect]
         BNZ   @D0B68     0b64 ; =+2 [Branch if not zero]
         JSR   @F0B6D     0b66 ; =+5 [Jump to subroutine relative]
@D0B68   RSR              0b68 ; [Return from subroutine]
*
* Function GETDAT (OSNLB4/OSNLB5)
*
* SVC DT - get binary date
*
*
GETDAT   LDA=  X'0000'    0b69 ; =0x0000 =0 =NUL,NUL [Load A with immediate]
         RSR              0b6c ; [Return from subroutine]
*
* Function @F0B6D
*
@F0B6D   LDB/  OSN0+3     0b6d ; [external symbol] [Load B direct]
         XFR   Z,A        0b70 ; [Transfer Z to A]
         STA-  S-         0b72 ; [Push A to the stack]
         XFR   Y,A        0b74 ; [Transfer Y to A]
         STA-  S-         0b76 ; [Push A to the stack]
         STX-  S-         0b78 ; [Push X to the stack]
         XFR   S,A        0b7a ; [Transfer S to A]
         STA+  B,16       0b7c ; [Store A indexed, displaced, direct]
         CLA              0b7f ; [Clear A]
         STA*  @F0B6D+1   0b80 ; =-20 [Store A relative indirect]
         JMP/  @J0C5F     0b82 ; =0x0c5f =3167 [Jump direct]
@J0B85   LDA=  OSN0       0b85 ; [external symbol] [Load A with immediate]
         XAS              0b88 ; [Transfer A to S]
         LDX+  A,9        0b89 ; [Load X indexed, displaced, direct]
         CLAB             0b8c ; [Clear AL]
         XAYB             0b8d ; [Transfer AL to YL]
         LDAB= X'C1'      0b8e ; =193(-63) ='A' [Load AL with immediate]
         XFRB  AL,AU      0b90 ; [Transfer AL to AU]
@D0B92   LDB+  X+         0b92 ; [Load B indexed, direct, post-incremented]
         BZ    @D0BCF     0b94 ; =+57 [Branch if zero]
         INRB  YL         0b96 ; [Increment YL by 1]
         LDAB+ B          0b98 ; [Load AL from address in B]
         ANDB  AU,AL      0b99 ; [AU & AL -> AL]
         OREB  AU,AL      0b9b ; [AU ^ AL -> AL]
         BNZ   @D0B92     0b9d ; =-13 [Branch if not zero]
         LDAB+ B,15       0b9f ; [Load AL indexed, displaced, direct]
         BZ    @D0B92     0ba2 ; =-18 [Branch if zero]
@D0BA4   STB/  @W0C4F+1   0ba4 ; =0x0c50 =3152 [Store B direct]
         XFRB  YL,AL      0ba7 ; [Transfer YL to AL]
         DCAB             0ba9 ; [Decrement AL]
@B0BAA   STAB= X'00'      0baa ; =0 =NUL [Store AL immediate]
         CLAB             0bac ; [Clear AL]
         STAB+ B,15       0bad ; [Store AL indexed, displaced, direct]
         LDA+  B,25       0bb0 ; [Load A indexed, displaced, direct]
         BZ    @D0BE2     0bb3 ; =+45 [Branch if zero]
         STA/  OSN0+3     0bb5 ; [external symbol] [Store A direct]
         XAZ              0bb8 ; [Transfer A to Z]
@D0BB9   LDAB= X'01'      0bb9 ; =1 [Load AL with immediate]
         LDBB+ Z          0bbb ; [Load BL from address in Z]
         ORIB  BL,AL      0bbc ; [BL | AL -> AL]
         STAB+ Z          0bbe ; [Store AL to address in Z]
         LDAB= X'02'      0bbf ; =2 [Load AL with immediate]
         LDBB+ Z,18       0bc1 ; [Load BL indexed, displaced, direct]
         ORIB  AL,BL      0bc4 ; [AL | BL -> BL]
         STBB+ Z,18       0bc6 ; [Store BL indexed, displaced, direct]
         LDX=  @W0CC0     0bc9 ; =0x0cc0 =3264 [Load X with immediate]
         JMP/  EXIT       0bcc ; =0x0b0e =2830 [Jump direct]
@D0BCF   CLA              0bcf ; [Clear A]
         LDAB/ ATNQUE     0bd0 ; [external symbol] [Load AL direct]
         BM    @D0BE0     0bd3 ; =+11 [Branch on minus]
@J0BD5   XAY              0bd5 ; [Transfer A to Y]
         INR   Y          0bd6 ; [Increment Y by 1]
         LDB/  OSN0+9     0bd8 ; [external symbol] [Load B direct]
         SLA              0bdb ; [Left shift A]
         AAB              0bdc ; [A + B -> B]
         LDB+  B          0bdd ; [Load B from address in B]
         JMP   @D0BA4     0bde ; =-60 [Jump relative]
@D0BE0   JMP   @J0C5F     0be0 ; =+125 [Jump relative]
@D0BE2   LDA/  OSN0+7     0be2 ; [external symbol] [Load A direct]
         XAY              0be5 ; [Transfer A to Y]
@D0BE6   LDA+  Y+         0be6 ; [Load A indexed, direct, post-incremented]
         BZ    @D0C34     0be8 ; =+74 [Branch if zero]
         LDBB+ A          0bea ; [Load BL from address in A]
         BNZ   @D0BE6     0beb ; =-7 [Branch if not zero]
         XAZ              0bed ; [Transfer A to Z]
         LDA+  Z,12       0bee ; [Load A indexed, displaced, direct]
         LDB+  Z,10       0bf1 ; [Load B indexed, displaced, direct]
         SAB              0bf4 ; [A - B -> B]
         LDA=  X'0FFF'    0bf5 ; =0x0fff =4095 [Load A with immediate]
         SAB              0bf8 ; [A - B -> B]
         BZ    @D0BFD     0bf9 ; =+2 [Branch if zero]
         BL    @D0BE6     0bfb ; =-23 [Branch on link]
@D0BFD   LDB=  ATNQUE+1   0bfd ; [external symbol] [Load B with immediate]
@D0C00   LDAB+ B          0c00 ; [Load AL from address in B]
         DCR   B          0c01 ; [Decrement B by 1]
         STAB+ B+         0c03 ; [Store AL indexed, direct, post-incremented]
         BM    @D0C0B     0c05 ; =+4 [Branch on minus]
         INR   B          0c07 ; [Increment B by 1]
         JMP   @D0C00     0c09 ; =-11 [Jump relative]
@D0C0B   LDB   @W0C4F+1   0c0b ; =+67 [Load B relative]
         STB+  Z,8        0c0d ; [Store B indexed, displaced, direct]
         LDAB+ B,24       0c10 ; [Load AL indexed, displaced, direct]
         STAB+ Z,36       0c13 ; [Store AL indexed, displaced, direct]
         XFR   Z,A        0c16 ; [Transfer Z to A]
         STA+  B,25       0c18 ; [Store A indexed, displaced, direct]
         LDA+  Z,4        0c1b ; [Load A indexed, displaced, direct]
         XAY              0c1e ; [Transfer A to Y]
         LDAB  @B0BAA+1   0c1f ; =-118 [Load AL relative]
         XFRB  AL,AU      0c21 ; [Transfer AL to AU]
         CLAB             0c23 ; [Clear AL]
         IVAB             0c24 ; [Invert AL]
         STA+  Y+         0c25 ; [Store A indexed, direct, post-incremented]
         STA+  Y+         0c27 ; [Store A indexed, direct, post-incremented]
         STA+  Y+         0c29 ; [Store A indexed, direct, post-incremented]
         STA+  Y+         0c2b ; [Store A indexed, direct, post-incremented]
         XFR   Z,A        0c2d ; [Transfer Z to A]
         STA/  OSN0+3     0c2f ; [external symbol] [Store A direct]
         JMP   @D0BB9     0c32 ; =-123 [Jump relative]
@D0C34   LDB=  ATNQUE     0c34 ; [external symbol] [Load B with immediate]
         LDAB/ @B0BAA+1   0c37 ; =0x0bab =2987 [Load AL direct]
         XAY              0c3a ; [Transfer A to Y]
         LDAB+ B          0c3b ; [Load AL from address in B]
@D0C3C   SUBB  YL,AL      0c3c ; [YL - AL -> AL]
         BZ    @D0C76     0c3e ; =+54 [Branch if zero]
         LDAB+ B+         0c40 ; [Load AL indexed, direct, post-incremented]
         BP    @D0C3C     0c42 ; =-8 [Branch on plus]
         DCR   B          0c44 ; [Decrement B by 1]
         XFRB  YL,AL      0c46 ; [Transfer YL to AL]
         STAB+ B          0c48 ; [Store AL to address in B]
         LDA=  @W0CE2     0c49 ; =0x0ce2 =3298 [Load A with immediate]
         STA/  @W0CCE     0c4c ; =0x0cce =3278 [Store A direct]
@W0C4F   LDA=  X'0000'    0c4f ; =0x0000 =0 =NUL,NUL [Load A with immediate]
         LDB=  @W0CC8     0c52 ; =0x0cc8 =3272 [Load B with immediate]
         JSR/  OSN3B      0c55 ; [external symbol] [Jump to subroutine direct]
@D0C58   LDAB  @W0CC8     0c58 ; =+110 [Load AL relative]
         BM    @D0C58     0c5a ; =-4 [Branch on minus]
         JMP/  @J0B85     0c5c ; =0x0b85 =2949 [Jump direct]
@J0C5F   LDX=  @S0CC5     0c5f ; =0x0cc5 =3269 [Load X with immediate]
@D0C62   LDA+  X+         0c62 ; [Load A indexed, direct, post-incremented]
         BNZ   @D0C82     0c64 ; =+28 [Branch if not zero]
         STAB/ OSN0+65    0c66 ; [external symbol] [Store AL direct]
         LDX/  OSN0+7     0c69 ; [external symbol] [Load X direct]
         STX   @J0C5F+1   0c6c ; =-14 [Store X relative]
         LDAB/ ATNQUE     0c6e ; [external symbol] [Load AL direct]
         BM    @D0C76     0c71 ; =+3 [Branch on minus]
         JMP/  @J0BD5     0c73 ; =0x0bd5 =3029 [Jump direct]
@D0C76   LDAB/ OSN0+62    0c76 ; [external symbol] [Load AL direct]
         BZ    @J0C5F     0c79 ; =-28 [Branch if zero]
         CLA              0c7b ; [Clear A]
         STAB/ OSN0+62    0c7c ; [external symbol] [Store AL direct]
         JMP/  @J0B85     0c7f ; =0x0b85 =2949 [Jump direct]
@D0C82   STX   @J0C5F+1   0c82 ; =-36 [Store X relative]
         XAZ              0c84 ; [Transfer A to Z]
         LDBB+ Z          0c85 ; [Load BL from address in Z]
         BZ    @D0C62     0c86 ; =-38 [Branch if zero]
         STA/  OSN0+3     0c88 ; [external symbol] [Store A direct]
         LDA+  Z,16       0c8b ; [Load A indexed, displaced, direct]
         BZ    @D0CBD     0c8e ; =+45 [Branch if zero]
         XAS              0c90 ; [Transfer A to S]
         LDX+  S+         0c91 ; [Pop X from the stack]
         LDA+  S+         0c93 ; [Pop A from the stack]
         XAY              0c95 ; [Transfer A to Y]
         LDA+  S+         0c96 ; [Pop A from the stack]
         XAZ              0c98 ; [Transfer A to Z]
         RSR              0c99 ; [Return from subroutine]
*
@J0C9A   LDA+  Z,12       0c9a ; [Load A indexed, displaced, direct]
         LDB+  Z,10       0c9d ; [Load B indexed, displaced, direct]
         SAB              0ca0 ; [A - B -> B]
         LDA=  X'0FFF'    0ca1 ; =0x0fff =4095 [Load A with immediate]
         SAB              0ca4 ; [A - B -> B]
         BZ    @D0CC1     0ca5 ; =+26 [Branch if zero]
         BNL   @D0CC1     0ca7 ; =+24 [Branch on no link]
         CLAB             0ca9 ; [Clear AL]
         STAB+ Z          0caa ; [Store AL to address in Z]
         LDA=  @W0CD2     0cab ; =0x0cd2 =3282 [Load A with immediate]
         STA   @W0CCE     0cae ; =+30 [Store A relative]
         LDA+  Z,8        0cb0 ; [Load A indexed, displaced, direct]
         LDB=  @W0CC8     0cb3 ; =0x0cc8 =3272 [Load B with immediate]
         JSR/  OSN3B      0cb6 ; [external symbol] [Jump to subroutine direct]
@D0CB9   LDAB  @W0CC8     0cb9 ; =+13 [Load AL relative]
         BM    @D0CB9     0cbb ; =-4 [Branch on minus]
@D0CBD   JSR/  EXIT       0cbd ; =0x0b0e =2830 [Jump to subroutine direct]
@W0CC0   STB+  P          0cc0 ; [Store B to address in P]
@D0CC1   CLA              0cc1 ; [Clear A]
         JSR/  OSN4       0cc2 ; [external symbol] [Jump to subroutine direct]
@S0CC5   DB    0,3        0cc5 ; =0x00,0x0003
@W0CC8   DW    X'0082'    0cc8 ; =0x0082 =130
         DB    X'00'      0cca ; =0x00 =0 =NUL
         DW    X'0200'    0ccb ; =0x0200 =512
         DB    X'50'      0ccd ; =0x50 =80
@W0CCE   DW    @W0CD2     0cce ; =0x0cd2 =3282
         DW    X'0000'    0cd0 ; =0x0000 =0 =NUL,NUL
@W0CD2   DW    X'000E'    0cd2 ; =0x000e =14
         DC    'MEM TOO SMALL' 0cd4
         DB    X'8D'      0ce1 ; =0x8d =141(-115) =CR
@W0CE2   DW    X'0009'    0ce2 ; =0x0009 =9
         DC    'STAND BY' 0ce4 ; hex:d3d4c1cec4a0c2d9
         DB    X'8D'      0cec ; =0x8d =141(-115) =CR
@W0CED   DW    X'0010'    0ced ; =0x0010 =16
         DC    'ABORT  '  0cef ; hex:c1c2cfd2d4a0a0
@S0CF6   DC    '  @ '     0cf6 ; hex:a0a0c0a0
@S0CFA   DC    '  '       0cfa ; hex:a0a0 dec:41120(-96)
@S0CFC   DC    '  '       0cfc ; hex:a0a0 dec:41120(-96)
         DB    X'8D'      0cfe ; =0x8d =141(-115) =CR
*
*
* Function RSTRT (OSNLB4/OSNLB5)
*
*
RSTRT    JMP   RSTRT      0cff ; =-2 [Jump relative]
*
* Function OSN2T (OSNLB4/OSNLB5)
*
*
* Exts:
*   FLGWT
*   OSNTC
*
* Function OSN2 (OSNLB4/OSNLB5)
*
* SVC EXP - file expand
*
*
OSN2     STAB- S-         0d01 ; [Push AL to the stack]
         STB-  S-         0d03 ; [Push B to the stack]
         JSR/  FLGWT      0d05 ; [external symbol] [Jump to subroutine direct]
         DB    X'1C'      0d08 ; =0x1c =28
         CLA              0d09 ; [Clear A]
         JMP/  OSNTC      0d0a ; [external symbol] [Jump direct]
*
* Function OSN3 (OSNLB4/OSNLB5)
*
* SVC PIOC - physical i/o control
*
*
* Exts:
*   OSN0
*   ABRT
*   BFWAIT
*   SYSBUF
*   DIO
*   OSN2
*
OSN3     XFR   Z,A        0d0d ; [Transfer Z to A]
         STA-  S-         0d0f ; [Push A to the stack]
         XFR   Y,A        0d11 ; [Transfer Y to A]
         STA-  S-         0d13 ; [Push A to the stack]
         STX-  S-         0d15 ; [Push X to the stack]
         XFR   B,Z        0d17 ; [Transfer B to Z]
         JSR   OSN3A      0d19 ; =+64 [Jump to subroutine relative]
         XAX              0d1b ; [Transfer A to X]
         XFR   B,Y        0d1c ; [Transfer B to Y]
@D0D1E   LDAB+ *X,5       0d1e ; [Load AL indexed, displaced, indirect]
         BNZ   @D0D28     0d21 ; =+5 [Branch if not zero]
         LDAB+ *X,3       0d23 ; [Load AL indexed, displaced, indirect]
         BZ    @D0D2E     0d26 ; =+6 [Branch if zero]
@D0D28   JSR$  X'005A'    0d28 ; =0x005a =90 [Jump to OPSYS (SVC)]
         DB    X'07'      0d2b ; =0x07 =7 [Service call WT - unconditional wait]
         JMP   @D0D1E     0d2c ; =-16 [Jump relative]
@D0D2E   CLA              0d2e ; [Clear A]
         LDAB+ Z,3        0d2f ; [Load AL indexed, displaced, direct]
         BLE   @D0D57     0d32 ; =+35 [Branch if less than or equal to zero]
         LDB+  *X,5       0d34 ; [Load B indexed, displaced, indirect]
         SABB             0d37 ; [AL - BL -> BL]
         BGZ   @D0D57     0d38 ; =+29 [Branch if greater than zero]
         INA              0d3a ; [Increment A]
         SLA              0d3b ; [Left shift A]
         LDB+  X,5        0d3c ; [Load B indexed, displaced, direct]
         AAB              0d3f ; [A + B -> B]
         LDB+  B          0d40 ; [Load B from address in B]
         BZ    @D0D57     0d41 ; =+20 [Branch if zero]
         LDA/  OSN0+3     0d43 ; [external symbol] [Load A direct]
         LDAB+ A,1        0d46 ; [Load AL indexed, displaced, direct]
         INAB             0d49 ; [Increment AL]
         STAB+ *X,5       0d4a ; [Store AL indexed, displaced, indirect]
         STAB+ *X,3       0d4d ; [Store AL indexed, displaced, indirect]
         LDAB= X'80'      0d50 ; =128(-128) [Load AL with immediate]
         STAB+ Z          0d52 ; [Store AL to address in Z]
         XFR   X,A        0d53 ; [Transfer X to A]
         JMP+  B          0d55 ; [Jump indexed, direct]
@D0D57   JSR/  ABRT       0d57 ; [external symbol] [Jump to subroutine direct]
         DB    X'23'      0d5a ; =0x23 =35
*
*
* Function OSN3A (OSNLB4/OSNLB5)
*
* SVC GIOB - get I/O block
*
*
OSN3A    STX-  S-         0d5b ; [Push X to the stack]
         LDX/  OSN0+3     0d5d ; [external symbol] [Load X direct]
         CLA              0d60 ; [Clear A]
         LDAB+ B,1        0d61 ; [Load AL indexed, displaced, direct]
         BP    @D0D72     0d64 ; =+12 [Branch on plus]
         SLAB             0d66 ; [Left shift AL]
         SRAB             0d67 ; [Arithmetic right shift AL]
         LDBB+ X,6        0d68 ; [Load BL indexed, displaced, direct]
         SABB             0d6b ; [AL - BL -> BL]
         BM    @D0D77     0d6c ; =+9 [Branch on minus]
@D0D6E   JSR/  ABRT       0d6e ; [external symbol] [Jump to subroutine direct]
         DB    X'0A'      0d71 ; =0x0a =10
*
@D0D72   LDBB+ X,6        0d72 ; [Load BL indexed, displaced, direct]
         ADDB  BL,AL      0d75 ; [BL + AL -> AL]
@D0D77   LDBB+ X,7        0d77 ; [Load BL indexed, displaced, direct]
         SABB             0d7a ; [AL - BL -> BL]
         BGZ   @D0D6E     0d7b ; =-15 [Branch if greater than zero]
         SLA              0d7d ; [Left shift A]
         LDX+  X,4        0d7e ; [Load X indexed, displaced, direct]
         ADD   A,X        0d81 ; [A + X -> X]
         CLA              0d83 ; [Clear A]
         LDAB+ X+         0d84 ; [Load AL indexed, direct, post-incremented]
         BM    @D0D6E     0d86 ; =-26 [Branch on minus]
         SLA              0d88 ; [Left shift A]
         LDB/  OSN0+9     0d89 ; [external symbol] [Load B direct]
         AAB              0d8c ; [A + B -> B]
         LDB+  B          0d8d ; [Load B from address in B]
         STB-  S-         0d8e ; [Push B to the stack]
         LDAB+ B          0d90 ; [Load AL from address in B]
         BZ    @D0D6E     0d91 ; =-37 [Branch if zero]
         LDB=  X'0010'    0d93 ; =0x0010 =16 [Load B with immediate]
         NABB             0d96 ; [AL & BL -> BL]
         BZ    @D0DA3     0d97 ; =+10 [Branch if zero]
         CLA              0d99 ; [Clear A]
         LDAB+ X          0d9a ; [Load AL from address in X]
         BM    @D0D6E     0d9b ; =-47 [Branch on minus]
         SLA              0d9d ; [Left shift A]
         LDB/  OSN0+15    0d9e ; [external symbol] [Load B direct]
         AAB              0da1 ; [A + B -> B]
         LDB+  B          0da2 ; [Load B from address in B]
@D0DA3   LDA+  S+         0da3 ; [Pop A from the stack]
         LDX+  S+         0da5 ; [Pop X from the stack]
         RSR              0da7 ; [Return from subroutine]
*
* Function OSN3B (OSNLB4/OSNLB5)
*
* SVC CONIO - console I/O
*
*
OSN3B    STB-  S-         0da8 ; [Push B to the stack]
         STB-  S-         0daa ; [Push B to the stack]
         XFR   Z,B        0dac ; [Transfer Z to B]
         STB+  S,2        0dae ; [Store B indexed, displaced, direct]
         LDB+  S          0db1 ; [Load B from address in S]
         XFR   B,Z        0db2 ; [Transfer B to Z]
         XFR   Y,B        0db4 ; [Transfer Y to B]
         STB+  S          0db6 ; [Store B to address in S]
         STX-  S-         0db7 ; [Push X to the stack]
         XAX              0db9 ; [Transfer A to X]
         LDAB+ X          0dba ; [Load AL from address in X]
         LDBB= X'80'      0dbb ; =128(-128) [Load BL with immediate]
         NABB             0dbd ; [AL & BL -> BL]
         BNZ   @D0DC4     0dbe ; =+4 [Branch if not zero]
         JSR/  ABRT       0dc0 ; [external symbol] [Jump to subroutine direct]
         DB    X'0B'      0dc3 ; =0x0b =11
*
@D0DC4   LDAB+ X,13       0dc4 ; [Load AL indexed, displaced, direct]
         BZ    @D0DD3     0dc7 ; =+10 [Branch if zero]
         CLAB             0dc9 ; [Clear AL]
         STAB+ X,13       0dca ; [Store AL indexed, displaced, direct]
         STAB+ *X,3       0dcd ; [Store AL indexed, displaced, indirect]
         STAB+ *X,16      0dd0 ; [Store AL indexed, displaced, indirect]
@D0DD3   JMP/  @D0D1E     0dd3 ; =0x0d1e =3358 [Jump direct]
*
* Function OSN3C (OSNLB4/OSNLB5)
*
* SVC SYSIO - device-independent logical I/O [all units]
*
*
OSN3C    STB-  S-         0dd6 ; [Push B to the stack]
         JSR   OSN3A      0dd8 ; =-127 [Jump to subroutine relative]
         STB-  S-         0dda ; [Push B to the stack]
         LDB+  A,1        0ddc ; [Load B indexed, displaced, direct]
         LDBB= X'04'      0ddf ; =4 [Load BL with immediate]
         SUBB  BU,BL      0de1 ; [BU - BL -> BL]
         BZ    @D0DEC     0de3 ; =+7 [Branch if zero]
         LDB+  S+         0de5 ; [Pop B from the stack]
         LDB+  S+         0de7 ; [Pop B from the stack]
         JMP/  OSN3       0de9 ; =0x0d0d =3341 [Jump direct]
@D0DEC   JSR/  BFWAIT     0dec ; [external symbol] [Jump to subroutine direct]
         LDBB+ A,2        0def ; [Load BL indexed, displaced, direct]
         STBB/ @B0E93     0df2 ; =0x0e93 =3731 [Store BL direct]
         LDA+  S          0df5 ; [Load A from address in S]
         LDAB+ A,7        0df6 ; [Load AL indexed, displaced, direct]
         LDBB= X'02'      0df9 ; =2 [Load BL with immediate]
         SABB             0dfb ; [AL - BL -> BL]
         BNZ   @D0E1D     0dfc ; =+31 [Branch if not zero]
         LDA+  S+         0dfe ; [Pop A from the stack]
         LDB+  S          0e00 ; [Load B from address in S]
         STX+  S          0e01 ; [Store X indexed, direct]
         XAX              0e03 ; [Transfer A to X]
         XFR   Y,A        0e04 ; [Transfer Y to A]
         STA-  S-         0e06 ; [Push A to the stack]
         XFR   Z,A        0e08 ; [Transfer Z to A]
         STA-  S-         0e0a ; [Push A to the stack]
         XFR   B,Z        0e0c ; [Transfer B to Z]
         LDA+  Z,6        0e0e ; [Load A indexed, displaced, direct]
         XAY              0e11 ; [Transfer A to Y]
         LDAB+ Z,3        0e12 ; [Load AL indexed, displaced, direct]
         DCAB             0e15 ; [Decrement AL]
         BZ    @D0E21     0e16 ; =+9 [Branch if zero]
         DCAB             0e18 ; [Decrement AL]
         BNZ   @D0E1D     0e19 ; =+2 [Branch if not zero]
         JMP   @D0E9A     0e1b ; =+125 [Jump relative]
@D0E1D   JSR/  ABRT       0e1d ; [external symbol] [Jump to subroutine direct]
         DB    X'0C'      0e20 ; =0x0c =12
*
@D0E21   LDA+  X,8        0e21 ; [Load A indexed, displaced, direct]
         STA   @W0E94     0e24 ; =+110 [Store A relative]
         JSR   @F0E8C     0e26 ; =+100 [Jump to subroutine relative]
         DB    X'01'      0e28 ; =0x01 =1
         LDA=  SYSBUF+5   0e29 ; [external symbol] [Load A with immediate]
         LDB+  X,10       0e2c ; [Load B indexed, displaced, direct]
         AAB              0e2f ; [A + B -> B]
         LDA+  B          0e30 ; [Load A from address in B]
         LDAB= X'84'      0e31 ; =132(-124) =EOT [Load AL with immediate]
         SUBB  AU,AL      0e33 ; [AU - AL -> AL]
         BZ    @D0E49     0e35 ; =+18 [Branch if zero]
         STB-  S-         0e37 ; [Push B to the stack]
         LDA=  X'8D00'    0e39 ; =0x8d00 =36096(-29440) =CR,NUL [Load A with immediate]
         LDAB+ B+         0e3c ; [Load AL indexed, direct, post-incremented]
         SUBB  AU,AL      0e3e ; [AU - AL -> AL]
         BNZ   @D0E56     0e40 ; =+20 [Branch if not zero]
         LDA+  S+         0e42 ; [Pop A from the stack]
         LDA/  SYSBUF+1   0e44 ; [external symbol] [Load A direct]
         BP    @D0E4D     0e47 ; =+4 [Branch on plus]
@D0E49   LDAB= X'01'      0e49 ; =1 [Load AL with immediate]
         JMP   @D0E7D     0e4b ; =+48 [Jump relative]
@D0E4D   STA+  X,8        0e4d ; [Store A indexed, displaced, direct]
         CLA              0e50 ; [Clear A]
         STA+  X,10       0e51 ; [Store A indexed, displaced, direct]
         JMP   @D0E21     0e54 ; =-53 [Jump relative]
@D0E56   LDAB+ B+         0e56 ; [Load AL indexed, direct, post-incremented]
         SUBB  AU,AL      0e58 ; [AU - AL -> AL]
         BNZ   @D0E56     0e5a ; =-6 [Branch if not zero]
         LDA=  SYSBUF+5   0e5c ; [external symbol] [Load A with immediate]
         SUB   B,A        0e5f ; [B - A -> A]
         STA+  X,10       0e61 ; [Store A indexed, displaced, direct]
         LDA+  S+         0e64 ; [Pop A from the stack]
         XAX              0e66 ; [Transfer A to X]
         SUB   B,A        0e67 ; [B - A -> A]
         DCA              0e69 ; [Decrement A]
         LDB+  Z,4        0e6a ; [Load B indexed, displaced, direct]
         SAB              0e6d ; [A - B -> B]
         BLE   @D0E73     0e6e ; =+3 [Branch if less than or equal to zero]
         LDA+  Z,4        0e70 ; [Load A indexed, displaced, direct]
@D0E73   STA+  Y+         0e73 ; [Store A indexed, direct, post-incremented]
@D0E75   LDBB+ X+         0e75 ; [Load BL indexed, direct, post-incremented]
         STBB+ Y+         0e77 ; [Store BL indexed, direct, post-incremented]
         DCA              0e79 ; [Decrement A]
         BGZ   @D0E75     0e7a ; =-7 [Branch if greater than zero]
         STAB+ Y          0e7c ; [Store AL to address in Y]
@D0E7D   LDBB= X'FF'      0e7d ; =255(-1) [Load BL with immediate]
         STBB/ OSN0+59    0e7f ; [external symbol] [Store BL direct]
         STAB+ Z          0e82 ; [Store AL to address in Z]
         LDA+  S+         0e83 ; [Pop A from the stack]
         XAZ              0e85 ; [Transfer A to Z]
         LDA+  S+         0e86 ; [Pop A from the stack]
         XAY              0e88 ; [Transfer A to Y]
         LDX+  S+         0e89 ; [Pop X from the stack]
         RSR              0e8b ; [Return from subroutine]
*
* Function @F0E8C
*
@F0E8C   LDAB+ X+         0e8c ; [Load AL indexed, direct, post-incremented]
         STAB  @B0E98     0e8e ; =+8 [Store AL relative]
         JSR/  DIO        0e90 ; [external symbol] [Jump to subroutine direct]
@B0E93   DB    X'00'      0e93 ; =0x00 =0 =NUL
@W0E94   DW    X'0000'    0e94 ; =0x0000 =0 =NUL,NUL
         DW    SYSBUF     0e96 ; =0x0848 =2120
@B0E98   DB    X'00'      0e98 ; =0x00 =0 =NUL
         RSR              0e99 ; [Return from subroutine]
*
@D0E9A   CLAB             0e9a ; [Clear AL]
         LDB+  Y          0e9b ; [Load B from address in Y]
         BLE   @D0E7D     0e9c ; =-33 [Branch if less than or equal to zero]
         LDA+  X,8        0e9e ; [Load A indexed, displaced, direct]
         STA   @W0E94     0ea1 ; =-15 [Store A relative]
         JSR   @F0E8C     0ea3 ; =-25 [Jump to subroutine relative]
         DB    X'01'      0ea5 ; =0x01 =1
         LDA+  X,10       0ea6 ; [Load A indexed, displaced, direct]
         LDB=  SYSBUF+5   0ea9 ; [external symbol] [Load B with immediate]
         AAB              0eac ; [A + B -> B]
         STB-  S-         0ead ; [Push B to the stack]
         LDB+  Y          0eaf ; [Load B from address in Y]
         AAB              0eb0 ; [A + B -> B]
         STB+  X,10       0eb1 ; [Store B indexed, displaced, direct]
         LDA=  X'018A'    0eb4 ; =0x018a =394 [Load A with immediate]
         SAB              0eb7 ; [A - B -> B]
         BP    @D0ECC     0eb8 ; =+18 [Branch on plus]
         LDA+  S+         0eba ; [Pop A from the stack]
         CLA              0ebc ; [Clear A]
         STA+  X,10       0ebd ; [Store A indexed, displaced, direct]
         LDAB= X'02'      0ec0 ; =2 [Load AL with immediate]
         LDB/  SYSBUF+1   0ec2 ; [external symbol] [Load B direct]
         BM    @D0EE0     0ec5 ; =+25 [Branch on minus]
@D0EC7   STB+  X,8        0ec7 ; [Store B indexed, displaced, direct]
         JMP   @D0E9A     0eca ; =-50 [Jump relative]
@D0ECC   LDX+  S+         0ecc ; [Pop X from the stack]
         LDA+  Y+         0ece ; [Load A indexed, direct, post-incremented]
@D0ED0   LDBB+ Y+         0ed0 ; [Load BL indexed, direct, post-incremented]
         STBB+ X+         0ed2 ; [Store BL indexed, direct, post-incremented]
         DCA              0ed4 ; [Decrement A]
         BGZ   @D0ED0     0ed5 ; =-7 [Branch if greater than zero]
         LDBB= X'8D'      0ed7 ; =141(-115) =CR [Load BL with immediate]
         STBB+ X          0ed9 ; [Store BL to address in X]
         JSR   @F0E8C     0eda ; =-80 [Jump to subroutine relative]
         DB    X'02'      0edc ; =0x02 =2
         CLAB             0edd ; [Clear AL]
         JMP   @D0E7D     0ede ; =-99 [Jump relative]
@D0EE0   LDAB= X'FF'      0ee0 ; =255(-1) [Load AL with immediate]
         STAB/ OSN0+59    0ee2 ; [external symbol] [Store AL direct]
         XFR   X,B        0ee5 ; [Transfer X to B]
         LDA+  B,8        0ee7 ; [Load A indexed, displaced, direct]
         STA   @W0EF1     0eea ; =+5 [Store A relative]
         LDAB  @B0E93     0eec ; =-91 [Load AL relative]
         JSR/  OSN2       0eee ; [external symbol] [Jump to subroutine direct]
@W0EF1   DW    X'0000'    0ef1 ; =0x0000 =0 =NUL,NUL
*
         JSR/  BFWAIT     0ef3 ; [external symbol] [Jump to subroutine direct]
         XFR   B,B        0ef6 ; [Transfer B to B]
         BP    @D0EC7     0ef8 ; =-51 [Branch on plus]
         LDAB= X'02'      0efa ; =2 [Load AL with immediate]
         JMP/  @D0E7D     0efc ; =0x0e7d =3709 [Jump direct]
*
* Function OSN4 (OSNLB4/OSNLB5)
*
* SVC LODJX - load JX module specified
*
*
* Exts:
*   OSN0
*   ABRT
*   OSN5
*   SYSBUF
*   FLGWT
*   DIO
*
OSN4     XAB              0eff ; [Transfer A to B]
         BM    @D0F13     0f00 ; =+17 [Branch on minus]
         LDB/  OSN0+20    0f02 ; [external symbol] [Load B direct]
         SAB              0f05 ; [A - B -> B]
         BGZ   @D0F13     0f06 ; =+11 [Branch if greater than zero]
         SLA              0f08 ; [Left shift A]
         LDB/  OSN0+22    0f09 ; [external symbol] [Load B direct]
         AAB              0f0c ; [A + B -> B]
         LDAB/ OSN0+5     0f0d ; [external symbol] [Load AL direct]
         LDB+  B          0f10 ; [Load B from address in B]
         BNZ   OSN4B      0f11 ; =+33 [Branch if not zero]
@D0F13   JSR/  ABRT       0f13 ; [external symbol] [Jump to subroutine direct]
         DB    X'07'      0f16 ; =0x07 =7
*
*
* Function OSN4A (OSNLB4/OSNLB5)
*
* SVC LODNM - load file name specified
*
*
OSN4A    JSR   BFWAIT     0f17 ; =+70 [Jump to subroutine relative]
         LDAB+ X+         0f19 ; [Load AL indexed, direct, post-incremented]
         STAB- S-         0f1b ; [Push AL to the stack]
         LDB+  X+         0f1d ; [Load B indexed, direct, post-incremented]
         JSR/  OSN5       0f1f ; [external symbol] [Jump to subroutine direct]
         DW    SYSBUF     0f22 ; =0x0848 =2120
         BZ    @D0F6C     0f24 ; =+70 [Branch if zero]
         LDB+  A,7        0f26 ; [Load B indexed, displaced, direct]
         CLA              0f29 ; [Clear A]
         LDAB+ S+         0f2a ; [Pop AL from the stack]
         JMP   @D0F38     0f2c ; =+10 [Jump relative]
*
* Function OSN4C (OSNLB4/OSNLB5)
*
*
OSN4C    CLRB  AU         0f2e ; [Clear AU]
         INRB  AU         0f30 ; [Increment AU by 1]
         JMP   @D0F36     0f32 ; =+2 [Jump relative]
*
* Function OSN4B (OSNLB4/OSNLB5)
*
* SVC LODD - load specifying disk addr
*
*
OSN4B    CLRB  AU         0f34 ; [Clear AU]
@D0F36   JSR   BFWAIT     0f36 ; =+39 [Jump to subroutine relative]
@D0F38   STB   @W0F92     0f38 ; =+88 [Store B relative]
         STAB  @B0F91     0f3a ; =+85 [Store AL relative]
@B0F3C   STA=  X'0000'    0f3c ; =0x0000 =0 =NUL,NUL [Store A immediate]
         XFR   Z,A        0f3f ; [Transfer Z to A]
         STA-  S-         0f41 ; [Push A to the stack]
         XFR   Y,A        0f43 ; [Transfer Y to A]
         STA-  S-         0f45 ; [Push A to the stack]
         LDA/  OSN0+3     0f47 ; [external symbol] [Load A direct]
         XAZ              0f4a ; [Transfer A to Z]
         LDA+  Z,12       0f4b ; [Load A indexed, displaced, direct]
         LDBB  @B0F3C+1   0f4e ; =-19 [Load BL relative]
         BZ    @D0F54     0f50 ; =+2 [Branch if zero]
         LDA+  X+         0f52 ; [Load A indexed, direct, post-incremented]
@D0F54   STA/  @W0FEF+1   0f54 ; =0x0ff0 =4080 [Store A direct]
         LDBB+ X,2        0f57 ; [Load BL indexed, displaced, direct]
         BNZ   @D0F5D     0f5a ; =+1 [Branch if not zero]
         XAS              0f5c ; [Transfer A to S]
@D0F5D   JMP   @D0F70     0f5d ; =+17 [Jump relative]
*
* Function BFWAIT (OSNLB4/OSNLB5)
*
*
BFWAIT   STA-  S-         0f5f ; [Push A to the stack]
         STB-  S-         0f61 ; [Push B to the stack]
         JSR/  FLGWT      0f63 ; [external symbol] [Jump to subroutine direct]
         DB    X'3B'      0f66 ; =0x3b =59
         LDB+  S+         0f67 ; [Pop B from the stack]
         LDA+  S+         0f69 ; [Pop A from the stack]
         RSR              0f6b ; [Return from subroutine]
*
@D0F6C   JSR/  ABRT       0f6c ; [external symbol] [Jump to subroutine direct]
         DB    X'03'      0f6f ; =0x03 =3
*
@D0F70   LDB+  Z,10       0f70 ; [Load B indexed, displaced, direct]
         LDAB  @B0F3C+1   0f73 ; =-56 [Load AL relative]
         BZ    @D0F78     0f75 ; =+1 [Branch if zero]
         LDB+  X          0f77 ; [Load B from address in X]
@D0F78   LDA+  X+         0f78 ; [Load A indexed, direct, post-incremented]
         BZ    @D0F80     0f7a ; =+4 [Branch if zero]
         SAB              0f7c ; [A - B -> B]
         BNL   @D0FD9     0f7d ; =+90 [Branch on no link]
         XAB              0f7f ; [Transfer A to B]
@D0F80   LDAB+ X+         0f80 ; [Load AL indexed, direct, post-incremented]
         STX-  S-         0f82 ; [Push X to the stack]
         STAB- S-         0f84 ; [Push AL to the stack]
         STB   @W0FB4+1   0f86 ; =+45 [Store B relative]
         STB   @W0FF7+1   0f88 ; =+110 [Store B relative]
@D0F8A   LDA   @W0F92     0f8a ; =+6 [Load A relative]
         BM    @D0F6C     0f8c ; =-34 [Branch on minus]
         JSR/  DIO        0f8e ; [external symbol] [Jump to subroutine direct]
@B0F91   DB    X'00'      0f91 ; =0x00 =0 =NUL
@W0F92   DW    X'0000'    0f92 ; =0x0000 =0 =NUL,NUL
@W0F94   DW    SYSBUF     0f94 ; =0x0848 =2120
         DB    X'01'      0f96 ; =0x01 =1
         LDA   @W0F94     0f97 ; =-5 [Load A relative]
         INA              0f99 ; [Increment A]
         LDB+  A+         0f9a ; [Load B indexed, direct, post-incremented]
         STB   @W0F92     0f9c ; =-12 [Store B relative]
         INA              0f9e ; [Increment A]
         INA              0f9f ; [Increment A]
         XAY              0fa0 ; [Transfer A to Y]
@D0FA1   CLA              0fa1 ; [Clear A]
         LDAB+ Y+         0fa2 ; [Load AL indexed, direct, post-incremented]
         BM    @D0F8A     0fa4 ; =-28 [Branch on minus]
         BZ    @D0FDD     0fa6 ; =+53 [Branch if zero]
         DCAB             0fa8 ; [Decrement AL]
         BNZ   @D0F6C     0fa9 ; =-63 [Branch if not zero]
         LDAB+ Y+         0fab ; [Load AL indexed, direct, post-incremented]
         SRA              0fad ; [Arithmetic right shift A]
         STA-  S-         0fae ; [Push A to the stack]
         LDB+  Y+         0fb0 ; [Load B indexed, direct, post-incremented]
@D0FB2   STB-  S-         0fb2 ; [Push B to the stack]
@W0FB4   LDA=  X'0000'    0fb4 ; =0x0000 =0 =NUL,NUL [Load A with immediate]
         LDB+  Y+         0fb7 ; [Load B indexed, direct, post-incremented]
         AAB              0fb9 ; [A + B -> B]
         LDX+  B          0fba ; [Load X indexed, direct]
         ADD   A,X        0fbc ; [A + X -> X]
         LDA+  S+         0fbe ; [Pop A from the stack]
         ADD   A,X        0fc0 ; [A + X -> X]
         STX+  B          0fc2 ; [Store X indexed, direct]
         XAB              0fc4 ; [Transfer A to B]
         LDA+  S          0fc5 ; [Load A from address in S]
         DCA              0fc6 ; [Decrement A]
         STA+  S          0fc7 ; [Store A to address in S]
         BGZ   @D0FB2     0fc8 ; =-24 [Branch if greater than zero]
         LDA+  S+         0fca ; [Pop A from the stack]
@D0FCC   LDAB+ Y+         0fcc ; [Load AL indexed, direct, post-incremented]
         JMP   @D0FA1     0fce ; =-47 [Jump relative]
@D0FD0   LDAB/ @B0F3C+1   0fd0 ; =0x0f3d =3901 [Load AL direct]
         BZ    @D0FD9     0fd3 ; =+4 [Branch if zero]
         JSR/  ABRT       0fd5 ; [external symbol] [Jump to subroutine direct]
         DB    X'1F'      0fd8 ; =0x1f =31
*
@D0FD9   JSR/  ABRT       0fd9 ; [external symbol] [Jump to subroutine direct]
         DB    X'04'      0fdc ; =0x04 =4
*
@D0FDD   LDAB+ Y+         0fdd ; [Load AL indexed, direct, post-incremented]
         XAX              0fdf ; [Transfer A to X]
         LDA+  Y+         0fe0 ; [Load A indexed, direct, post-incremented]
         LDB   @W0FB4+1   0fe2 ; =-47 [Load B relative]
         ADD   B,A        0fe4 ; [B + A -> A]
         XFR   X,X        0fe6 ; [Transfer X to X]
         BZ    @D100A     0fe8 ; =+32 [Branch if zero]
         STA-  S-         0fea ; [Push A to the stack]
         ADD   X,A        0fec ; [X + A -> A]
         DCA              0fee ; [Decrement A]
@W0FEF   LDB=  X'0000'    0fef ; =0x0000 =0 =NUL,NUL [Load B with immediate]
         SAB              0ff2 ; [A - B -> B]
         BZ    @W0FF7     0ff3 ; =+2 [Branch if zero]
         BL    @D0FD0     0ff5 ; =-39 [Branch on link]
@W0FF7   LDB=  X'0000'    0ff7 ; =0x0000 =0 =NUL,NUL [Load B with immediate]
         SAB              0ffa ; [A - B -> B]
         BNL   @D0FFF     0ffb ; =+2 [Branch on no link]
         STA   @W0FF7+1   0ffd ; =-7 [Store A relative]
@D0FFF   LDA+  S+         0fff ; [Pop A from the stack]
@D1001   LDBB+ Y+         1001 ; [Load BL indexed, direct, post-incremented]
         STBB+ A+         1003 ; [Store BL indexed, direct, post-incremented]
         DCX              1005 ; [Decrement X]
         BGZ   @D1001     1006 ; =-7 [Branch if greater than zero]
         JMP   @D0FCC     1008 ; =-62 [Jump relative]
@D100A   STA-  S-         100a ; [Push A to the stack]
         LDA   @W0FF7+1   100c ; =-22 [Load A relative]
         LDB+  Z,14       100e ; [Load B indexed, displaced, direct]
         SAB              1011 ; [A - B -> B]
         BNL   @D1017     1012 ; =+3 [Branch on no link]
         STA+  Z,14       1014 ; [Store A indexed, displaced, direct]
@D1017   LDB+  S+         1017 ; [Pop B from the stack]
         LDAB= X'FF'      1019 ; =255(-1) [Load AL with immediate]
         STAB/ OSN0+59    101b ; [external symbol] [Store AL direct]
         LDAB+ S+         101e ; [Pop AL from the stack]
         BZ    @D102D     1020 ; =+11 [Branch if zero]
         LDX+  S+         1022 ; [Pop X from the stack]
         LDA+  S+         1024 ; [Pop A from the stack]
         XAY              1026 ; [Transfer A to Y]
         LDA+  S+         1027 ; [Pop A from the stack]
         XAZ              1029 ; [Transfer A to Z]
         LDA   @W0FF7+1   102a ; =-52 [Load A relative]
         RSR              102c ; [Return from subroutine]
*
@D102D   LDA+  Z,12       102d ; [Load A indexed, displaced, direct]
         XAS              1030 ; [Transfer A to S]
         CLA              1031 ; [Clear A]
         XAX              1032 ; [Transfer A to X]
         LDA   @W0FF7+1   1033 ; =-61 [Load A relative]
         JMP+  B          1035 ; [Jump indexed, direct]
*
* Function OSN5 (OSNLB4/OSNLB5)
*
* SVC DIRNM - search directory for file name specified
*
*
* Exts:
*   OSN0
*   ABRT
*   LOCDNO
*   COMP
*   DIO
*   OSNZ
*   FLGWT
*
OSN5     JSR/  @F10FA     1037 ; =0x10fa =4346 [Jump to subroutine direct]
         LDA$  OSN0+24    103a ; [external symbol] [Load A indirect]
@J103D   STA   @W107C     103d ; =+61 [Store A relative]
         LDA+  X+         103f ; [Load A indexed, direct, post-incremented]
         STA/  @W10C5     1041 ; =0x10c5 =4293 [Store A direct]
         STX-  S-         1044 ; [Push X to the stack]
         JSR   @F10BB     1046 ; =+115 [Jump to subroutine relative]
         DW    X'000E'    1048 ; =0x000e =14
         LDA   @W10C5     104a ; =+121 [Load A relative]
         LDAB+ A,8        104c ; [Load AL indexed, displaced, direct]
         INAB             104f ; [Increment AL]
         BNZ   @D1056     1050 ; =+4 [Branch if not zero]
         JSR/  ABRT       1052 ; [external symbol] [Jump to subroutine direct]
         DB    X'24'      1055 ; =0x24 =36
*
@D1056   JSR   @F10BB     1056 ; =+99 [Jump to subroutine relative]
         DW    X'000F'    1058 ; =0x000f =15
         XFR   Y,A        105a ; [Transfer Y to A]
         STA-  S-         105c ; [Push A to the stack]
         LDAB  @B10C2     105e ; =+98 [Load AL relative]
         JSR/  LOCDNO     1060 ; [external symbol] [Jump to subroutine direct]
         LDB+  Y,18       1063 ; [Load B indexed, displaced, direct]
         LDX+  Y,16       1066 ; [Load X indexed, displaced, direct]
         LDA   @W10C5     1069 ; =+90 [Load A relative]
@D106B   LDBB+ A+         106b ; [Load BL indexed, direct, post-incremented]
         STBB+ X+         106d ; [Store BL indexed, direct, post-incremented]
         DCRB  BU         106f ; [Decrement BU by 1]
         BGZ   @D106B     1071 ; =-8 [Branch if greater than zero]
         LDA+  S+         1073 ; [Pop A from the stack]
         XAY              1075 ; [Transfer A to Y]
@D1076   LDA   @W107C     1076 ; =+4 [Load A relative]
         BM    @D10AD     1078 ; =+51 [Branch on minus]
         JSR   @F10BB     107a ; =+63 [Jump to subroutine relative]
@W107C   DW    X'0000'    107c ; =0x0000 =0 =NUL,NUL
         LDA   @W107C     107e ; =-4 [Load A relative]
         STA   @W10B5+1   1080 ; =+52 [Store A relative]
         LDB   @W10C5     1082 ; =+65 [Load B relative]
         LDA+  B,1        1084 ; [Load A indexed, displaced, direct]
         STA   @W107C     1087 ; =-13 [Store A relative]
         CLA              1089 ; [Clear A]
         LDAB+ B,5        108a ; [Load AL indexed, displaced, direct]
         BZ    @D1076     108d ; =-25 [Branch if zero]
         BM    @D10AD     108f ; =+28 [Branch on minus]
         XAX              1091 ; [Transfer A to X]
@D1092   LDA=  X'0010'    1092 ; =0x0010 =16 [Load A with immediate]
         AAB              1095 ; [A + B -> B]
         STB   @W109F     1096 ; =+7 [Store B relative]
         JSR/  COMP       1098 ; [external symbol] [Jump to subroutine direct]
         DW    X'0006'    109b ; =0x0006 =6
@W109D   DW    X'0000'    109d ; =0x0000 =0 =NUL,NUL
@W109F   DW    X'0000'    109f ; =0x0000 =0 =NUL,NUL
         LDA   @W109F     10a1 ; =-4 [Load A relative]
         XFRB  BL,BL      10a3 ; [Transfer BL to BL]
         BZ    @D10AE     10a5 ; =+7 [Branch if zero]
         XAB              10a7 ; [Transfer A to B]
         DCX              10a8 ; [Decrement X]
         BGZ   @D1092     10a9 ; =-25 [Branch if greater than zero]
         JMP   @D1076     10ab ; =-55 [Jump relative]
@D10AD   CLA              10ad ; [Clear A]
@D10AE   LDX+  S+         10ae ; [Pop X from the stack]
         LDBB= X'FF'      10b0 ; =255(-1) [Load BL with immediate]
         STBB/ OSN0+60    10b2 ; [external symbol] [Store BL direct]
@W10B5   LDB=  X'0000'    10b5 ; =0x0000 =0 =NUL,NUL [Load B with immediate]
         XFR   A,A        10b8 ; [Transfer A to A]
         RSR              10ba ; [Return from subroutine]
*
* Function @F10BB
*
@F10BB   LDA+  X+         10bb ; [Load A indexed, direct, post-incremented]
         STA   @W10C3     10bd ; =+4 [Store A relative]
         JSR/  DIO        10bf ; [external symbol] [Jump to subroutine direct]
@B10C2   DB    X'00'      10c2 ; =0x00 =0 =NUL
@W10C3   DW    OSNZ       10c3 ; =0x2d70 =11632
@W10C5   DW    X'0000'    10c5 ; =0x0000 =0 =NUL,NUL
         DB    X'01'      10c7 ; =0x01 =1
         RSR              10c8 ; [Return from subroutine]
*
* Function OSN5A (OSNLB4/OSNLB5)
*
* SVC DIRPD - search pri dir
* Search private directory for file name specified.
*
*
OSN5A    JSR   @F10FA     10c9 ; =+47 [Jump to subroutine relative]
         LDA+  X+         10cb ; [Load A indexed, direct, post-incremented]
         JMP/  @J103D     10cd ; =0x103d =4157 [Jump direct]
*
* Function BSTLU (OSNLB4/OSNLB5)
*
*
BSTLU    STX-  S-         10d0 ; [Push X to the stack]
         XFR   Y,B        10d2 ; [Transfer Y to B]
         STB-  S-         10d4 ; [Push B to the stack]
         STA-  S-         10d6 ; [Push A to the stack]
         LDA+  B,13       10d8 ; [Load A indexed, displaced, direct]
         SLA              10db ; [Left shift A]
         SLA              10dc ; [Left shift A]
         SLA              10dd ; [Left shift A]
         SLA              10de ; [Left shift A]
         DCA              10df ; [Decrement A]
         XAX              10e0 ; [Transfer A to X]
         LDA+  B,16       10e1 ; [Load A indexed, displaced, direct]
         XAY              10e4 ; [Transfer A to Y]
         LDA+  S+         10e5 ; [Pop A from the stack]
         BZ    @D10F3     10e7 ; =+10 [Branch if zero]
@D10E9   LDB+  Y+         10e9 ; [Load B indexed, direct, post-incremented]
         BM    @D10F3     10eb ; =+6 [Branch on minus]
         INX              10ed ; [Increment X]
         SAB              10ee ; [A - B -> B]
         BNZ   @D10E9     10ef ; =-8 [Branch if not zero]
         XFR   X,A        10f1 ; [Transfer X to A]
@D10F3   LDB+  S+         10f3 ; [Pop B from the stack]
         XFR   B,Y        10f5 ; [Transfer B to Y]
         LDX+  S+         10f7 ; [Pop X from the stack]
         RSR              10f9 ; [Return from subroutine]
*
* Function @F10FA
*
@F10FA   STB-  S-         10fa ; [Push B to the stack]
         STAB- S-         10fc ; [Push AL to the stack]
         JSR/  FLGWT      10fe ; [external symbol] [Jump to subroutine direct]
         DB    X'3C'      1101 ; =0x3c =60
         LDAB+ S+         1102 ; [Pop AL from the stack]
         STAB  @B10C2     1104 ; =-68 [Store AL relative]
         LDA+  S+         1106 ; [Pop A from the stack]
         STA   @W109D     1108 ; =-109 [Store A relative]
         RSR              110a ; [Return from subroutine]
*
* Function OSN6 (OSNLB4/OSNLB5)
*
* SVC SHLD - disk sector hold
*
*
* Exts:
*   OSN0
*   ABRT
*
OSN6     JSR   @F1133     110b ; =+38 [Jump to subroutine relative]
         BZ    @D1112     110d ; =+3 [Branch if zero]
@D110F   LDAB= X'01'      110f ; =1 [Load AL with immediate]
         RSR              1111 ; [Return from subroutine]
*
@D1112   LDB/  OSN0+32    1112 ; [external symbol] [Load B direct]
         LDA-  B-         1115 ; [Load A indexed, pre-decremented, direct]
@D1117   LDA+  B+         1117 ; [Load A indexed, direct, post-incremented]
         LDA+  B+         1119 ; [Load A indexed, direct, post-incremented]
         BP    @D1117     111b ; =-6 [Branch on plus]
         IVA              111d ; [Invert A]
         BZ    @D110F     111e ; =-17 [Branch if zero]
         LDA   @W1137+1   1120 ; =+22 [Load A relative]
         STA+  B          1122 ; [Store A to address in B]
         LDA/  OSN0+3     1123 ; [external symbol] [Load A direct]
         LDA+  A,1        1126 ; [Load A indexed, displaced, direct]
         LDAB  @F1133+1   1129 ; =+9 [Load AL relative]
         STA-  B-         112b ; [Store A indexed, pre-decremented, direct]
         CLAB             112d ; [Clear AL]
         RSR              112e ; [Return from subroutine]
*
@D112F   JSR/  ABRT       112f ; [external symbol] [Jump to subroutine direct]
         DB    X'0E'      1132 ; =0x0e =14
*
*
* Function @F1133
*
@F1133   STAB= X'00'      1133 ; =0 =NUL [Store AL immediate]
         BM    @D112F     1135 ; =-8 [Branch on minus]
@W1137   STB=  X'0000'    1137 ; =0x0000 =0 =NUL,NUL [Store B immediate]
         BM    @D112F     113a ; =-13 [Branch on minus]
         STX-  S-         113c ; [Push X to the stack]
         LDX/  OSN0+32    113e ; [external symbol] [Load X direct]
         DCX              1141 ; [Decrement X]
         DCX              1142 ; [Decrement X]
@D1143   LDA+  X+         1143 ; [Load A indexed, direct, post-incremented]
         LDA+  X+         1145 ; [Load A indexed, direct, post-incremented]
         BP    @D1150     1147 ; =+7 [Branch on plus]
         IVA              1149 ; [Invert A]
         BNZ   @D1143     114a ; =-9 [Branch if not zero]
         LDX+  S+         114c ; [Pop X from the stack]
         XAB              114e ; [Transfer A to B]
         RSR              114f ; [Return from subroutine]
*
@D1150   LDBB  @F1133+1   1150 ; =-30 [Load BL relative]
         SABB             1152 ; [AL - BL -> BL]
         BNZ   @D1143     1153 ; =-18 [Branch if not zero]
         LDA   @W1137+1   1155 ; =-31 [Load A relative]
         LDB+  X          1157 ; [Load B from address in X]
         SAB              1158 ; [A - B -> B]
         BNZ   @D1143     1159 ; =-24 [Branch if not zero]
         XFR   X,A        115b ; [Transfer X to A]
         LDX+  S+         115d ; [Pop X from the stack]
         RSR              115f ; [Return from subroutine]
*
* Function OSN6A (OSNLB4/OSNLB5)
*
* SVC SFRE - disk sector free
*
*
OSN6A    JSR   @F1133     1160 ; =-47 [Jump to subroutine relative]
         BZ    @D116A     1162 ; =+6 [Branch if zero]
         LDB=  X'FF00'    1164 ; =0xff00 =65280(-256) [Load B with immediate]
         STB-  A-         1167 ; [Store B indexed, pre-decremented, direct]
         CLAB             1169 ; [Clear AL]
@D116A   RSR              116a ; [Return from subroutine]
*
* Function MUL64 (OSNLB4/OSNLB5)
*
* SVC MU64 - CPL 64-bit multiply
* Multiplies the given integer with the one in TBSUB.
*
* ASM:
*   Clobbers: A, B
*     JSR/ MUL64
*     DW ADDR    ; address of 64-bit integer
*
* Exts:
*   OSN0
*   SET@F
*
MUL64    JSR   >L64       116b ; =+75 [Jump to subroutine relative]
         JMP   @D1175     116d ; =+6 [Jump relative]
*
* Function MUL48 (OSNLB4/OSNLB5)
*
* SVC MU48 - CPL 48-bit multiply
* Multiplies the given integer with the one in TBSUB.
*
* ASM:
*   Clobbers: A, B
*     JSR/ MUL48
*     DW ADDR    ; address of 48-bit integer
*
MUL48    JSR   >L48       116f ; =+89 [Jump to subroutine relative]
         JMP   @D1175     1171 ; =+2 [Jump relative]
*
* Function MUL32 (OSNLB4/OSNLB5)
*
* SVC MU - CPL 32-bit multiply
* Multiplies the given integer with the one in TBSUB.
*
* ASM:
*   Clobbers: A, B
*     JSR/ MUL32
*     DW ADDR    ; address of 32-bit integer
*
MUL32    JSR   >L32       1173 ; =+89 [Jump to subroutine relative]
@D1175   JSR/  @F13D4     1175 ; =0x13d4 =5076 [Jump to subroutine direct]
         JSR/  @F130D     1178 ; =0x130d =4877 [Jump to subroutine direct]
         RSR              117b ; [Return from subroutine]
*
* Function DIV64 (OSNLB4/OSNLB5)
*
* SVC DV64 - CPL 64-bit divide
* Divides the integer in TBSUB by the given integer.
*
* ASM:
*   Clobbers: A, B
*     JSR/ DIV64
*     DW ADDR    ; address of 64-bit integer
*
DIV64    JSR   >L64       117c ; =+58 [Jump to subroutine relative]
         JMP   @D1186     117e ; =+6 [Jump relative]
*
* Function DIV48 (OSNLB4/OSNLB5)
*
* SVC DV48 - CPL 48-bit divide
* Divides the integer in TBSUB by the given integer.
*
* ASM:
*   Clobbers: A, B
*     JSR/ DIV48
*     DW ADDR    ; address of 48-bit integer
*
DIV48    JSR   >L48       1180 ; =+72 [Jump to subroutine relative]
         JMP   @D1186     1182 ; =+2 [Jump relative]
*
* Function DIV32 (OSNLB4/OSNLB5)
*
* SVC DV - CPL 32-bit divide
* Divides the integer in TBSUB by the given integer.
*
* ASM:
*   Clobbers: A, B
*     JSR/ DIV32
*     DW ADDR    ; address of 32-bit integer
*
DIV32    JSR   >L32       1184 ; =+72 [Jump to subroutine relative]
@D1186   JSR/  @F13D4     1186 ; =0x13d4 =5076 [Jump to subroutine direct]
         JSR/  @F1347     1189 ; =0x1347 =4935 [Jump to subroutine direct]
         RSR              118c ; [Return from subroutine]
*
* Function ADD64 (OSNLB4/OSNLB5)
*
* SVC AD64 - CPL 64-bit add
* Adds the given integer with the one in TBSUB.
*
* ASM:
*   Clobbers: A, B
*     JSR/ ADD64
*     DW ADDR    ; address of 64-bit integer
*
ADD64    JSR   >L64       118d ; =+41 [Jump to subroutine relative]
         JMP   @D1197     118f ; =+6 [Jump relative]
*
* Function ADD48 (OSNLB4/OSNLB5)
*
* SVC AD48 - CPL 48-bit add
* Adds the given integer with the one in TBSUB.
*
* ASM:
*   Clobbers: A, B
*     JSR/ ADD48
*     DW ADDR    ; address of 48-bit integer
*
ADD48    JSR   >L48       1191 ; =+55 [Jump to subroutine relative]
         JMP   @D1197     1193 ; =+2 [Jump relative]
*
* Function ADD32 (OSNLB4/OSNLB5)
*
* SVC AD - CPL 32-bit add
* Adds the given integer with the one in TBSUB.
*
* ASM:
*   Clobbers: A, B
*     JSR/ ADD32
*     DW ADDR    ; address of 32-bit integer
*
ADD32    JSR   >L32       1195 ; =+55 [Jump to subroutine relative]
@D1197   JSR/  >ASUB      1197 ; =0x1215 =4629 [Jump to subroutine direct]
         JSR/  @F12B4     119a ; =0x12b4 =4788 [Jump to subroutine direct]
         DW    @W1221     119d ; =0x1221 =4641
         RSR              119f ; [Return from subroutine]
*
* Function SUB64 (OSNLB4/OSNLB5)
*
* SVC SU64 - CPL 64-bit subtract
* Subtracts the given integer from the one in TBSUB.
*
* ASM:
*   Clobbers: A, B
*     JSR/ SUB64
*     DW ADDR    ; address of 64-bit integer
*
SUB64    JSR   >L64       11a0 ; =+22 [Jump to subroutine relative]
         JMP   @D11AA     11a2 ; =+6 [Jump relative]
*
* Function SUB48 (OSNLB4/OSNLB5)
*
* SVC SU48 - CPL 48-bit subtract
* Subtracts the given integer from the one in TBSUB.
*
* ASM:
*   Clobbers: A, B
*     JSR/ SUB48
*     DW ADDR    ; address of 48-bit integer
*
SUB48    JSR   >L48       11a4 ; =+36 [Jump to subroutine relative]
         JMP   @D11AA     11a6 ; =+2 [Jump relative]
*
* Function SUB32 (OSNLB4/OSNLB5)
*
* SVC SU - CPL 32-bit subtract
* Subtracts the given integer from the one in TBSUB.
*
* ASM:
*   Clobbers: A, B
*     JSR/ SUB32
*     DW ADDR    ; address of 32-bit integer
*
SUB32    JSR   >L32       11a8 ; =+36 [Jump to subroutine relative]
@D11AA   JSR/  >ASUB      11aa ; =0x1215 =4629 [Jump to subroutine direct]
         JSR/  NEG64      11ad ; =0x1403 =5123 [Jump to subroutine direct]
         DW    @W1221     11b0 ; =0x1221 =4641
*
         JSR/  @F12B4     11b2 ; =0x12b4 =4788 [Jump to subroutine direct]
         DW    @W1221     11b5 ; =0x1221 =4641
         RSR              11b7 ; [Return from subroutine]
*
* Function >L64
*
>L64     STX   @W11C7+1   11b8 ; =+14 [Store X relative]
         LDX+  S+         11ba ; [Pop X from the stack]
         LDA+  X+         11bc ; [Load A indexed, direct, post-incremented]
         STA   @W11C5     11be ; =+5 [Store A relative]
         JSR/  >CP64      11c0 ; =0x1463 =5219 [Jump to subroutine direct]
         DW    @W1221     11c3 ; =0x1221 =4641
@W11C5   DW    X'0000'    11c5 ; =0x0000 =0 =NUL,NUL
@W11C7   JMP/  @W11C7     11c7 ; =0x11c7 =4551 [Jump direct]
*
* Function >L48
*
>L48     LDAB= X'01'      11ca ; =1 [Load AL with immediate]
         JMP   @D11CF     11cc ; =+1 [Jump relative]
*
* Function >L32
*
>L32     CLA              11ce ; [Clear A]
@D11CF   STAB  @B11F0+1   11cf ; =+32 [Store AL relative]
         STX   @W1200+1   11d1 ; =+46 [Store X relative]
         LDX+  S+         11d3 ; [Pop X from the stack]
         LDB+  X+         11d5 ; [Load B indexed, direct, post-incremented]
         XFRB  BU,BU      11d7 ; [Transfer BU to BU]
         BZ    @D120A     11d9 ; =+47 [Branch if zero]
         INRB  BU         11db ; [Increment BU by 1]
         BZ    @D1203     11dd ; =+36 [Branch if zero]
         DCRB  BU         11df ; [Decrement BU by 1]
         STB-  S-         11e1 ; [Push B to the stack]
         CLA              11e3 ; [Clear A]
         LDB+  B          11e4 ; [Load B from address in B]
         BP    @D11EA     11e5 ; =+3 [Branch on plus]
         LDA=  X'FFFF'    11e7 ; =0xffff =65535(-1) [Load A with immediate]
@D11EA   STA   @W1221     11ea ; =+53 [Store A relative]
         STA   @W1223     11ec ; =+53 [Store A relative]
         LDB+  S+         11ee ; [Pop B from the stack]
@B11F0   LDAB= X'00'      11f0 ; =0 =NUL [Load AL with immediate]
         BZ    @D11F8     11f2 ; =+4 [Branch if zero]
         LDA+  B+         11f4 ; [Load A indexed, direct, post-incremented]
         STA   @W1223     11f6 ; =+43 [Store A relative]
@D11F8   LDA+  B+         11f8 ; [Load A indexed, direct, post-incremented]
         STA   @W1225     11fa ; =+41 [Store A relative]
         LDA+  B+         11fc ; [Load A indexed, direct, post-incremented]
         STA   @W1227     11fe ; =+39 [Store A relative]
@W1200   JMP/  @W1200     1200 ; =0x1200 =4608 [Jump direct]
@D1203   DCRB  BU         1203 ; [Decrement BU by 1]
         LDA=  X'FFFF'    1205 ; =0xffff =65535(-1) [Load A with immediate]
         JMP   @D120B     1208 ; =+1 [Jump relative]
@D120A   CLA              120a ; [Clear A]
@D120B   STA   @W1221     120b ; =+20 [Store A relative]
         STA   @W1223     120d ; =+20 [Store A relative]
         STA   @W1225     120f ; =+20 [Store A relative]
         STB   @W1227     1211 ; =+20 [Store B relative]
         JMP   @W1200     1213 ; =-21 [Jump relative]
*
* Function >ASUB
*
>ASUB    LDA/  OSN0+3     1215 ; [external symbol] [Load A direct]
         LDB=  X'0025'    1218 ; =0x0025 =37 [Load B with immediate]
         ADD   B,A        121b ; [B + A -> A]
>SUBADR  STA=  X'0000'    121d ; =0x0000 =0 =NUL,NUL [Store A immediate]
         RSR              1220 ; [Return from subroutine]
*
@W1221   DS    2          1221 ; [Uninitialized memory]
@W1223   DS    2          1223 ; [Uninitialized memory]
@W1225   DS    2          1225 ; [Uninitialized memory]
@W1227   DS    2          1227 ; [Uninitialized memory]
*
*
* Function LOD64 (OSNLB4/OSNLB5)
*
* SVC LD64 - CPL 64-bit load
* Loads to TBSUB.
*
* ASM:
*   Clobbers: A, B
*     JSR/ LOD64
*     DW ADDR    ; address of 64-bit integer
*
LOD64    JSR   >L64       1229 ; =-115 [Jump to subroutine relative]
         JMP   @D123B     122b ; =+14 [Jump relative]
*
* Function LOD48 (OSNLB4/OSNLB5)
*
* SVC LD48 - CPL 48-bit load
* Loads to 64-bits in TBSUB.
*
* ASM:
*   Clobbers: A, B
*     JSR/ LOD48
*     DW ADDR    ; address of 48-bit integer
*
LOD48    JSR/  SET@F      122d ; [external symbol] [Jump to subroutine direct]
         DB    X'00'      1230 ; =0x00 =0 =NUL
*
*
* Function LOD48A (OSNLB4/OSNLB5)
*
* 48-bit load without setting STATUS.
* Loads to 64-bits in TBSUB.
*
* ASM:
*   Clobbers: A, B
*     JSR/ LOD48A
*     DW ADDR     ; address of 48-bit integer
*
LOD48A   JSR   >L48       1231 ; =-105 [Jump to subroutine relative]
         JMP   @D123B     1233 ; =+6 [Jump relative]
*
* Function LOD32 (OSNLB4/OSNLB5)
*
* SVC LD - CPL 32-bit load
* Loads to 64-bits in TBSUB.
*
* ASM:
*   Clobbers: A, B
*     JSR/ LOD32
*     DW ADDR    ; address of 32-bit integer
*
LOD32    JSR/  SET@F      1235 ; [external symbol] [Jump to subroutine direct]
         DB    X'00'      1238 ; =0x00 =0 =NUL
*
*
* Function LOD32A (OSNLB4/OSNLB5)
*
* 32-bit load without setting STATUS.
* Loads to 64-bits in TBSUB.
*
* ASM:
*   Clobbers: A, B
*     JSR/ LOD32A
*     DW ADDR     ; address of 32-bit integer
*
LOD32A   JSR   >L32       1239 ; =-109 [Jump to subroutine relative]
@D123B   JSR   >ASUB      123b ; =-40 [Jump to subroutine relative]
         LDB   @W1221     123d ; =-30 [Load B relative]
         STB+  A+         123f ; [Store B indexed, direct, post-incremented]
         LDB   @W1223     1241 ; =-32 [Load B relative]
         STB+  A+         1243 ; [Store B indexed, direct, post-incremented]
         LDB   @W1225     1245 ; =-34 [Load B relative]
         STB+  A+         1247 ; [Store B indexed, direct, post-incremented]
         LDB   @W1227     1249 ; =-36 [Load B relative]
         STB+  A          124b ; [Store B to address in A]
         RSR              124c ; [Return from subroutine]
*
* Function STO64 (OSNLB4/OSNLB5)
*
* SVC ST64 - CPL 64-bit store
* Stores TBSUB to 64-bits.
*
* ASM:
*   Clobbers: A, B
*     JSR/ STO64
*     DW ADDR    ; address of 64-bit integer
*
STO64    JSR/  >ASUB      124d ; =0x1215 =4629 [Jump to subroutine direct]
         STA   @W125B     1250 ; =+9 [Store A relative]
         LDA+  X+         1252 ; [Load A indexed, direct, post-incremented]
         STA   @W1259     1254 ; =+3 [Store A relative]
         JSR/  >CP64      1256 ; =0x1463 =5219 [Jump to subroutine direct]
@W1259   DW    X'0000'    1259 ; =0x0000 =0 =NUL,NUL
@W125B   DW    X'0000'    125b ; =0x0000 =0 =NUL,NUL
         RSR              125d ; [Return from subroutine]
*
* Function STO48 (OSNLB4/OSNLB5)
*
* SVC ST48 - CPL 48-bit store
* Stores TBSUB to 48-bits.
*
* ASM:
*   Clobbers: A, B
*     JSR/ STO48
*     DW ADDR    ; address of 48-bit integer
*
STO48    LDAB= X'01'      125e ; =1 [Load AL with immediate]
         STAB  @B128E+1   1260 ; =+45 [Store AL relative]
         JMP   @D1267     1262 ; =+3 [Jump relative]
*
* Function STO32 (OSNLB4/OSNLB5)
*
* SVC ST - CPL 32-bit store
* Stores TBSUB to 32-bits.
*
* ASM:
*   Clobbers: A, B
*     JSR/ STO32
*     DW ADDR    ; address of 32-bit integer
*
STO32    CLA              1264 ; [Clear A]
         STAB  @B128E+1   1265 ; =+40 [Store AL relative]
@D1267   LDA+  X+         1267 ; [Load A indexed, direct, post-incremented]
         XAZ              1269 ; [Transfer A to Z]
         JSR/  >ASUB      126a ; =0x1215 =4629 [Jump to subroutine direct]
         STA   @W1279     126d ; =+10 [Store A relative]
         STA   @W1280     126f ; =+15 [Store A relative]
         STA/  @W13F6     1271 ; =0x13f6 =5110 [Store A direct]
         JSR/  >CP64      1274 ; =0x1463 =5219 [Jump to subroutine direct]
         DW    @W1221     1277 ; =0x1221 =4641
@W1279   DW    X'0000'    1279 ; =0x0000 =0 =NUL,NUL
*
         JSR/  >CP64      127b ; =0x1463 =5219 [Jump to subroutine direct]
         DW    @W147D     127e ; =0x147d =5245
@W1280   DW    X'0000'    1280 ; =0x0000 =0 =NUL,NUL
*
         JSR/  @F144A     1282 ; =0x144a =5194 [Jump to subroutine direct]
         DW    @W1221     1285 ; =0x1221 =4641
         LDA   @W1221     1287 ; =-104 [Load A relative]
         BNZ   @D12A2     1289 ; =+23 [Branch if not zero]
         LDA/  @W147F     128b ; =0x147f =5247 [Load A direct]
@B128E   LDBB= X'00'      128e ; =0 =NUL [Load BL with immediate]
         BZ    @D129A     1290 ; =+8 [Branch if zero]
         STA+  Z+         1292 ; [Store A indexed, direct, post-incremented]
         LDA   @W1223     1294 ; =-115 [Load A relative]
         BM    @D12A2     1296 ; =+10 [Branch on minus]
         JMP   @D12A5     1298 ; =+11 [Jump relative]
@D129A   LDA   @W1223     129a ; =-121 [Load A relative]
         BNZ   @D12A2     129c ; =+4 [Branch if not zero]
         LDA   @W1225     129e ; =-123 [Load A relative]
         BP    @D12A5     12a0 ; =+3 [Branch on plus]
@D12A2   JSR/  @F13F0     12a2 ; =0x13f0 =5104 [Jump to subroutine direct]
@D12A5   LDA/  @W1481     12a5 ; =0x1481 =5249 [Load A direct]
         STA+  Z+         12a8 ; [Store A indexed, direct, post-incremented]
         LDA/  @W1483     12aa ; =0x1483 =5251 [Load A direct]
         STA+  Z+         12ad ; [Store A indexed, direct, post-incremented]
         LDA/  X'005A'    12af ; =0x005a =90 [Load A direct]
         XAZ              12b2 ; [Transfer A to Z]
         RSR              12b3 ; [Return from subroutine]
*
* Function @F12B4
*
@F12B4   LDB/  >SUBADR+1  12b4 ; =0x121e =4638 [Load B direct]
         LDA=  X'0008'    12b7 ; =0x0008 =8 [Load A with immediate]
         AAB              12ba ; [A + B -> B]
*
* Function @F12BB
*
@F12BB   XFR   Y,A        12bb ; [Transfer Y to A]
         STA-  S-         12bd ; [Push A to the stack]
         XFR   Z,A        12bf ; [Transfer Z to A]
         STA-  S-         12c1 ; [Push A to the stack]
         XFR   B,Z        12c3 ; [Transfer B to Z]
         LDA=  X'0008'    12c5 ; =0x0008 =8 [Load A with immediate]
         LDB+  X+         12c8 ; [Load B indexed, direct, post-incremented]
         AAB              12ca ; [A + B -> B]
         XFR   B,Y        12cb ; [Transfer B to Y]
         STX-  S-         12cd ; [Push X to the stack]
         CLR   X          12cf ; [Clear X]
         LDA-  Y-         12d1 ; [Load A indexed, pre-decremented, direct]
         LDB-  Z-         12d3 ; [Load B indexed, pre-decremented, direct]
         AAB              12d5 ; [A + B -> B]
         STB+  Z          12d6 ; [Store B to address in Z]
         LDB-  Y-         12d7 ; [Load B indexed, pre-decremented, direct]
         LDA=  X'0001'    12d9 ; =0x0001 =1 [Load A with immediate]
         BNL   @D12E1     12dc ; =+3 [Branch on no link]
         AAB              12de ; [A + B -> B]
         RLR   X          12df ; [Left rotate X by 1]
@D12E1   LDA-  Z-         12e1 ; [Load A indexed, pre-decremented, direct]
         AAB              12e3 ; [A + B -> B]
         STB+  Z          12e4 ; [Store B to address in Z]
         BNL   @D12EA     12e5 ; =+3 [Branch on no link]
         LDX=  X'0001'    12e7 ; =0x0001 =1 [Load X with immediate]
@D12EA   LDA-  Y-         12ea ; [Load A indexed, pre-decremented, direct]
         CLR   B          12ec ; [Clear B]
         ADD   X,A        12ee ; [X + A -> A]
         RLR   B          12f0 ; [Left rotate B by 1]
         LDX-  Z-         12f2 ; [Load X indexed, pre-decremented, direct]
         ADD   A,X        12f4 ; [A + X -> X]
         STX+  Z          12f6 ; [Store X indexed, direct]
         BNL   @D12FD     12f8 ; =+3 [Branch on no link]
         LDB=  X'0001'    12fa ; =0x0001 =1 [Load B with immediate]
@D12FD   LDA-  Y-         12fd ; [Load A indexed, pre-decremented, direct]
         AAB              12ff ; [A + B -> B]
         LDA-  Z-         1300 ; [Load A indexed, pre-decremented, direct]
         AAB              1302 ; [A + B -> B]
         STB+  Z          1303 ; [Store B to address in Z]
         LDX+  S+         1304 ; [Pop X from the stack]
         LDA+  S+         1306 ; [Pop A from the stack]
         XAZ              1308 ; [Transfer A to Z]
         LDA+  S+         1309 ; [Pop A from the stack]
         XAY              130b ; [Transfer A to Y]
         RSR              130c ; [Return from subroutine]
*
* Function @F130D
*
@F130D   LDA/  @W13E2     130d ; =0x13e2 =5090 [Load A direct]
         STA   @W1317     1310 ; =+5 [Store A relative]
         STA   @W1323     1312 ; =+15 [Store A relative]
         JSR/  >CP64      1314 ; =0x1463 =5219 [Jump to subroutine direct]
@W1317   DW    X'0000'    1317 ; =0x0000 =0 =NUL,NUL
         DW    @S1495     1319 ; =0x1495 =5269
         STX-  S-         131b ; [Push X to the stack]
         LDX=  X'0040'    131d ; =0x0040 =64 [Load X with immediate]
@D1320   JSR/  LSFT64     1320 ; =0x1429 =5161 [Jump to subroutine direct]
@W1323   DW    X'0000'    1323 ; =0x0000 =0 =NUL,NUL
         JSR/  LSFT64     1325 ; =0x1429 =5161 [Jump to subroutine direct]
         DW    @W1221     1328 ; =0x1221 =4641
         BNL   @D1337     132a ; =+11 [Branch on no link]
         JSR   @F12B4     132c ; =-122 [Jump to subroutine relative]
         DW    @W147D     132e ; =0x147d =5245
         LDA*  @W1317     1330 ; =-27 [Load A relative indirect]
         BP    @D1337     1332 ; =+3 [Branch on plus]
         JSR/  @F13F0     1334 ; =0x13f0 =5104 [Jump to subroutine direct]
@D1337   DCX              1337 ; [Decrement X]
         BNZ   @D1320     1338 ; =-26 [Branch if not zero]
         LDA*  @W1317     133a ; =-37 [Load A relative indirect]
         BP    @D1341     133c ; =+3 [Branch on plus]
         JSR/  @F13F0     133e ; =0x13f0 =5104 [Jump to subroutine direct]
@D1341   JSR/  @F13F9     1341 ; =0x13f9 =5113 [Jump to subroutine direct]
         LDX+  S+         1344 ; [Pop X from the stack]
         RSR              1346 ; [Return from subroutine]
*
* Function @F1347
*
@F1347   STX-  S-         1347 ; [Push X to the stack]
@P1349   JSR/  >CP64      1349 ; =0x1463 =5219 [Jump to subroutine direct]
         DW    @W1485     134c ; =0x1485 =5253
         DW    @W147D     134e ; =0x147d =5245
         JSR/  NEG64      1350 ; =0x1403 =5123 [Jump to subroutine direct]
         DW    @W1221     1353 ; =0x1221 =4641
         LDB=  @W148D     1355 ; =0x148d =5261 [Load B with immediate]
         JSR/  @F12BB     1358 ; =0x12bb =4795 [Jump to subroutine direct]
         DW    @W1221     135b ; =0x1221 =4641
         LDA/  @W1485     135d ; =0x1485 =5253 [Load A direct]
         BM    @D13CC     1360 ; =+106 [Branch on minus]
         LDB=  @W1221     1362 ; =0x1221 =4641 [Load B with immediate]
         LDX=  X'0004'    1365 ; =0x0004 =4 [Load X with immediate]
@D1368   LDA+  B+         1368 ; [Load A indexed, direct, post-incremented]
         BNZ   @D1371     136a ; =+5 [Branch if not zero]
         DCX              136c ; [Decrement X]
         BGZ   @D1368     136d ; =-7 [Branch if greater than zero]
         JMP   @D13C6     136f ; =+85 [Jump relative]
@D1371   JSR/  @F145C     1371 ; =0x145c =5212 [Jump to subroutine direct]
         DW    @W1485     1374 ; =0x1485 =5253
         LDA   @W13E2     1376 ; =+106 [Load A relative]
         STA   @W137E     1378 ; =+4 [Store A relative]
         STA   @W1391     137a ; =+21 [Store A relative]
         JSR*  @D1371+1   137c ; =-12 [Jump to subroutine relative indirect]
@W137E   DW    X'0000'    137e ; =0x0000 =0 =NUL,NUL
         LDX=  X'0041'    1380 ; =0x0041 =65 [Load X with immediate]
@D1383   JSR/  LSFT64     1383 ; =0x1429 =5161 [Jump to subroutine direct]
         DW    @W147D     1386 ; =0x147d =5245
         DCX              1388 ; [Decrement X]
         BZ    @D13BF     1389 ; =+52 [Branch if zero]
         BNL   @D1383     138b ; =-10 [Branch on no link]
         JMP   @D1397     138d ; =+8 [Jump relative]
@D138F   JSR*  @D1383+1   138f ; =-13 [Jump to subroutine relative indirect]
@W1391   DW    X'0000'    1391 ; =0x0000 =0 =NUL,NUL
*
         JSR*  @D1383+1   1393 ; =-17 [Jump to subroutine relative indirect]
         DW    @W147D     1395 ; =0x147d =5245
*
@D1397   JSR/  @F1441     1397 ; =0x1441 =5185 [Jump to subroutine direct]
         DW    @W148D     139a ; =0x148d =5261
*
         JSR*  @P1349+1   139c ; =-84 [Jump to subroutine relative indirect]
         DW    @W148D     139e ; =0x148d =5261
         DW    @W1485     13a0 ; =0x1485 =5253
         LDB=  @S1495     13a2 ; =0x1495 =5269 [Load B with immediate]
         JSR/  @F12BB     13a5 ; =0x12bb =4795 [Jump to subroutine direct]
         DW    @W1221     13a8 ; =0x1221 =4641
         LDA/  @W148D     13aa ; =0x148d =5261 [Load A direct]
         BM    @D13BA     13ad ; =+11 [Branch on minus]
         JSR/  @F12B4     13af ; =0x12b4 =4788 [Jump to subroutine direct]
         DW    @S149D     13b2 ; =0x149d =5277
*
         JSR*  @P1349+1   13b4 ; =-108 [Jump to subroutine relative indirect]
         DW    @W1485     13b6 ; =0x1485 =5253
         DW    @W148D     13b8 ; =0x148d =5261
*
@D13BA   DCX              13ba ; [Decrement X]
         BNZ   @D138F     13bb ; =-46 [Branch if not zero]
         JSR   @F13F9     13bd ; =+58 [Jump to subroutine relative]
@D13BF   LDA/  @W148B     13bf ; =0x148b =5259 [Load A direct]
         XAY              13c2 ; [Transfer A to Y]
@D13C3   LDX+  S+         13c3 ; [Pop X from the stack]
         RSR              13c5 ; [Return from subroutine]
*
@D13C6   JSR   @F13F0     13c6 ; =+40 [Jump to subroutine relative]
         CLA              13c8 ; [Clear A]
         XAY              13c9 ; [Transfer A to Y]
         JMP   @D13C3     13ca ; =-9 [Jump relative]
@D13CC   JSR   @F13F4     13cc ; =+38 [Jump to subroutine relative]
         LDA/  @W1483     13ce ; =0x1483 =5251 [Load A direct]
         XAY              13d1 ; [Transfer A to Y]
         JMP   @D13C3     13d2 ; =-17 [Jump relative]
*
* Function @F13D4
*
@F13D4   JSR/  >ASUB      13d4 ; =0x1215 =4629 [Jump to subroutine direct]
         STA   @W13E2     13d7 ; =+9 [Store A relative]
         STA   @W13F6     13d9 ; =+27 [Store A relative]
         STA   @W1400     13db ; =+35 [Store A relative]
         JSR/  >CP64      13dd ; =0x1463 =5219 [Jump to subroutine direct]
         DW    @W147D     13e0 ; =0x147d =5245
@W13E2   DW    X'0000'    13e2 ; =0x0000 =0 =NUL,NUL
         CLA              13e4 ; [Clear A]
         STAB  @B1452+1   13e5 ; =+108 [Store AL relative]
         JSR   @F144A     13e7 ; =+97 [Jump to subroutine relative]
         DW    @W147D     13e9 ; =0x147d =5245
*
         JSR   @F144A     13eb ; =+93 [Jump to subroutine relative]
         DW    @W1221     13ed ; =0x1221 =4641
         RSR              13ef ; [Return from subroutine]
*
* Function @F13F0
*
@F13F0   JSR/  SET@F      13f0 ; [external symbol] [Jump to subroutine direct]
         DB    X'02'      13f3 ; =0x02 =2
*
*
* Function @F13F4
*
@F13F4   JSR   @F145C     13f4 ; =+102 [Jump to subroutine relative]
@W13F6   DW    X'0000'    13f6 ; =0x0000 =0 =NUL,NUL
         RSR              13f8 ; [Return from subroutine]
*
* Function @F13F9
*
@F13F9   LDAB  @B1452+1   13f9 ; =+88 [Load AL relative]
         SRAB             13fb ; [Arithmetic right shift AL]
         BNL   @D1402     13fc ; =+4 [Branch on no link]
         JSR   NEG64      13fe ; =+3 [Jump to subroutine relative]
@W1400   DW    X'0000'    1400 ; =0x0000 =0 =NUL,NUL
*
@D1402   RSR              1402 ; [Return from subroutine]
*
* Function NEG64 (OSNLB4/OSNLB5)
*
* SVC NEG64 - CPL 64-bit negate
* Negates the given integer.
*
* ASM:
*   Clobbers: A, B
*     JSR/ NEG64
*     DW ADDR    ; address of 64-bit integer
*
NEG64    LDB+  X+         1403 ; [Load B indexed, direct, post-incremented]
         STX-  S-         1405 ; [Push X to the stack]
         XFR   Y,A        1407 ; [Transfer Y to A]
         STA-  S-         1409 ; [Push A to the stack]
         LDX=  X'0004'    140b ; =0x0004 =4 [Load X with immediate]
         LDA=  X'0008'    140e ; =0x0008 =8 [Load A with immediate]
         AAB              1411 ; [A + B -> B]
         XFR   B,Y        1412 ; [Transfer B to Y]
         LDA=  X'0001'    1414 ; =0x0001 =1 [Load A with immediate]
         SL               1417 ; [Set link]
@D1418   LDB-  Y-         1418 ; [Load B indexed, pre-decremented, direct]
         IVR   B          141a ; [Invert B]
         BNL   @D141F     141c ; =+1 [Branch on no link]
         AAB              141e ; [A + B -> B]
@D141F   STB+  Y          141f ; [Store B to address in Y]
         DCX              1420 ; [Decrement X]
         BGZ   @D1418     1421 ; =-11 [Branch if greater than zero]
         LDA+  S+         1423 ; [Pop A from the stack]
         XAY              1425 ; [Transfer A to Y]
         LDX+  S+         1426 ; [Pop X from the stack]
         RSR              1428 ; [Return from subroutine]
*
* Function LSFT64 (OSNLB4/OSNLB5)
*
* SVC SL64 - CPL 64-bit left shift
* Shifts the given integer left one bit.
*
* ASM:
*   Clobbers: A, B
*     JSR/ LSFT64
*     DW ADDR     ; address of 64-bit integer
*
LSFT64   LDB+  X+         1429 ; [Load B indexed, direct, post-incremented]
         STX-  S-         142b ; [Push X to the stack]
         LDX=  X'0008'    142d ; =0x0008 =8 [Load X with immediate]
         ADD   X,B        1430 ; [X + B -> B]
         LDX=  X'0004'    1432 ; =0x0004 =4 [Load X with immediate]
         RL               1435 ; [Reset link]
@D1436   LDA-  B-         1436 ; [Load A indexed, pre-decremented, direct]
         RLR   A          1438 ; [Left rotate A by 1]
         STA+  B          143a ; [Store A to address in B]
         DCX              143b ; [Decrement X]
         BNZ   @D1436     143c ; =-8 [Branch if not zero]
         LDX+  S+         143e ; [Pop X from the stack]
         RSR              1440 ; [Return from subroutine]
*
* Function @F1441
*
@F1441   LDB+  X+         1441 ; [Load B indexed, direct, post-incremented]
         STX-  S-         1443 ; [Push X to the stack]
         LDX=  X'0004'    1445 ; =0x0004 =4 [Load X with immediate]
         JMP   @D1436     1448 ; =-20 [Jump relative]
*
* Function @F144A
*
@F144A   LDA+  X+         144a ; [Load A indexed, direct, post-incremented]
         STA   @W1459     144c ; =+11 [Store A relative]
         LDA+  A          144e ; [Load A from address in A]
         BM    @B1452     144f ; =+1 [Branch on minus]
         RSR              1451 ; [Return from subroutine]
*
@B1452   LDAB= X'00'      1452 ; =0 =NUL [Load AL with immediate]
         INAB             1454 ; [Increment AL]
         STAB  @B1452+1   1455 ; =-4 [Store AL relative]
         JSR   NEG64      1457 ; =-86 [Jump to subroutine relative]
@W1459   DW    X'0000'    1459 ; =0x0000 =0 =NUL,NUL
         RSR              145b ; [Return from subroutine]
*
* Function @F145C
*
@F145C   LDA+  X+         145c ; [Load A indexed, direct, post-incremented]
         JSR   >CP64A     145e ; =+5 [Jump to subroutine relative]
         DW    @S1495     1460 ; =0x1495 =5269
         RSR              1462 ; [Return from subroutine]
*
* Function >CP64
*
>CP64    LDA+  X+         1463 ; [Load A indexed, direct, post-incremented]
*
* Function >CP64A
*
>CP64A   LDB+  X+         1465 ; [Load B indexed, direct, post-incremented]
         STX-  S-         1467 ; [Push X to the stack]
         XAX              1469 ; [Transfer A to X]
         LDA+  B+         146a ; [Load A indexed, direct, post-incremented]
         STA+  X+         146c ; [Store A indexed, direct, post-incremented]
         LDA+  B+         146e ; [Load A indexed, direct, post-incremented]
         STA+  X+         1470 ; [Store A indexed, direct, post-incremented]
         LDA+  B+         1472 ; [Load A indexed, direct, post-incremented]
         STA+  X+         1474 ; [Store A indexed, direct, post-incremented]
         LDA+  B+         1476 ; [Load A indexed, direct, post-incremented]
         STA+  X+         1478 ; [Store A indexed, direct, post-incremented]
         LDX+  S+         147a ; [Pop X from the stack]
         RSR              147c ; [Return from subroutine]
*
@W147D   DS    2          147d ; [Uninitialized memory]
@W147F   DS    2          147f ; [Uninitialized memory]
@W1481   DS    2          1481 ; [Uninitialized memory]
@W1483   DS    2          1483 ; [Uninitialized memory]
@W1485   DS    6          1485 ; [Uninitialized memory]
@W148B   DS    2          148b ; [Uninitialized memory]
@W148D   DS    8          148d ; [Uninitialized memory]
@S1495   DB    0,8        1495 ; =0x00,0x0008
@S149D   DB    0,7        149d ; =0x00,0x0007
         DB    X'01'      14a4 ; =0x01 =1
*
*
* Function COM48 (OSNLB4/OSNLB5)
*
* SVC CN48 - CPL 48-bit numeric compare
* Jumps to the target address if the comparison is true.
* Returns if the comparison is false.
*
* ASM:
*   Clobbers: A, B, Y, Z
*     JSR/ COM48
*     DW LINT    ; address of left 48-bit integer
*     DW RINT    ; address of right 48-bit integer
*     DW TARGET  ; address of jump target if true
*     DB OPER    ; CPL comparison operator
*
COM48    CLAB             14a5 ; [Clear AL]
         JMP   @D14AA     14a6 ; =+2 [Jump relative]
*
* Function COM32 (OSNLB4/OSNLB5)
*
* SVC CN - CPL 32-bit numeric compare
* Jumps to the target address if the comparison is true.
* Returns if the comparison is false.
*
* ASM:
*   Clobbers: A, B, Y, Z
*     JSR/ COM32
*     DW LINT    ; address of left 32-bit integer
*     DW RINT    ; address of right 32-bit integer
*     DW TARGET  ; address of jump target if true
*     DB OPER    ; CPL comparison operator
*
COM32    LDAB= X'02'      14a8 ; =2 [Load AL with immediate]
@D14AA   STAB  @B14EB+1   14aa ; =+64 [Store AL relative]
         LDA+  X+         14ac ; [Load A indexed, direct, post-incremented]
         XAY              14ae ; [Transfer A to Y]
         LDA+  X          14af ; [Load A from address in X]
         XFRB  AU,AU      14b0 ; [Transfer AU to AU]
         BZ    @D14C2     14b2 ; =+14 [Branch if zero]
         INRB  AU         14b4 ; [Increment AU by 1]
         BZ    @D14BD     14b6 ; =+5 [Branch if zero]
         LDA+  X+         14b8 ; [Load A indexed, direct, post-incremented]
         XAZ              14ba ; [Transfer A to Z]
         JMP   @D14D7     14bb ; =+26 [Jump relative]
@D14BD   LDA=  X'FFFF'    14bd ; =0xffff =65535(-1) [Load A with immediate]
         JMP   @D14C3     14c0 ; =+1 [Jump relative]
@D14C2   CLA              14c2 ; [Clear A]
@D14C3   STA/  @W1223     14c3 ; =0x1223 =4643 [Store A direct]
         STA/  @W1225     14c6 ; =0x1225 =4645 [Store A direct]
         LDA+  X+         14c9 ; [Load A indexed, direct, post-incremented]
         STA/  @W1227     14cb ; =0x1227 =4647 [Store A direct]
         LDA=  @W1223     14ce ; =0x1223 =4643 [Load A with immediate]
         XAZ              14d1 ; [Transfer A to Z]
         CLA              14d2 ; [Clear A]
         LDAB  @B14EB+1   14d3 ; =+23 [Load AL relative]
         ADD   A,Z        14d5 ; [A + Z -> Z]
@D14D7   LDA+  Y+         14d7 ; [Load A indexed, direct, post-incremented]
         LDB+  Z+         14d9 ; [Load B indexed, direct, post-incremented]
         SAB              14db ; [A - B -> B]
         BM    @D1500     14dc ; =+34 [Branch on minus]
         BGZ   @D14F8     14de ; =+24 [Branch if greater than zero]
         LDA+  Y+         14e0 ; [Load A indexed, direct, post-incremented]
         LDB+  Z+         14e2 ; [Load B indexed, direct, post-incremented]
         SAB              14e4 ; [A - B -> B]
         BZ    @B14EB     14e5 ; =+4 [Branch if zero]
         BNL   @D1500     14e7 ; =+23 [Branch on no link]
         JMP   @D14F8     14e9 ; =+13 [Jump relative]
@B14EB   LDAB= X'00'      14eb ; =0 =NUL [Load AL with immediate]
         BNZ   @D14FC     14ed ; =+13 [Branch if not zero]
         LDA+  Y+         14ef ; [Load A indexed, direct, post-incremented]
         LDB+  Z+         14f1 ; [Load B indexed, direct, post-incremented]
         SAB              14f3 ; [A - B -> B]
         BZ    @D14FC     14f4 ; =+6 [Branch if zero]
         BNL   @D1500     14f6 ; =+8 [Branch on no link]
@D14F8   LDBB= X'04'      14f8 ; =4 [Load BL with immediate]
         JMP   @D1502     14fa ; =+6 [Jump relative]
@D14FC   LDBB= X'01'      14fc ; =1 [Load BL with immediate]
         JMP   @D1502     14fe ; =+2 [Jump relative]
@D1500   LDBB= X'02'      1500 ; =2 [Load BL with immediate]
@D1502   XFRB  BL,BU      1502 ; [Transfer BL to BU]
         LDA+  X+         1504 ; [Load A indexed, direct, post-incremented]
         LDBB+ X+         1506 ; [Load BL indexed, direct, post-incremented]
         ANDB  BU,BL      1508 ; [BU & BL -> BL]
         BZ    @D150D     150a ; =+1 [Branch if zero]
         XAX              150c ; [Transfer A to X]
@D150D   LDA/  X'005A'    150d ; =0x005a =90 [Load A direct]
         XAZ              1510 ; [Transfer A to Z]
         RSR              1511 ; [Return from subroutine]
*
@D1512   LDAB+ Z+         1512 ; [Load AL indexed, direct, post-incremented]
         BZ    @D14FC     1514 ; =-26 [Branch if zero]
         LDBB= X'A0'      1516 ; =160(-96) =' ' [Load BL with immediate]
         SABB             1518 ; [AL - BL -> BL]
         BZ    @D1512     1519 ; =-9 [Branch if zero]
         JMP   @D1500     151b ; =-29 [Jump relative]
@D151D   DCR   Y          151d ; [Decrement Y by 1]
@D151F   LDAB+ Y+         151f ; [Load AL indexed, direct, post-incremented]
         BZ    @D14FC     1521 ; =-39 [Branch if zero]
         LDBB= X'A0'      1523 ; =160(-96) =' ' [Load BL with immediate]
         SABB             1525 ; [AL - BL -> BL]
         BZ    @D151F     1526 ; =-9 [Branch if zero]
         JMP   @D14F8     1528 ; =-50 [Jump relative]
@D152A   LDAB+ Y+         152a ; [Load AL indexed, direct, post-incremented]
         BZ    @D1512     152c ; =-28 [Branch if zero]
         JSR   >UCLTR     152e ; =+16 [Jump to subroutine relative]
         XFRB  AL,BU      1530 ; [Transfer AL to BU]
         LDAB+ Z+         1532 ; [Load AL indexed, direct, post-incremented]
         BZ    @D151D     1534 ; =-25 [Branch if zero]
         JSR   >UCLTR     1536 ; =+8 [Jump to subroutine relative]
         SUBB  BU,AL      1538 ; [BU - AL -> AL]
         BZ    @D152A     153a ; =-18 [Branch if zero]
         BM    @D1500     153c ; =-62 [Branch on minus]
         JMP   @D14F8     153e ; =-72 [Jump relative]
*
* Function >UCLTR
*
>UCLTR   LDBB= X'FA'      1540 ; =250(-6) ='z' [Load BL with immediate]
         SABB             1542 ; [AL - BL -> BL]
         BGZ   @D154E     1543 ; =+9 [Branch if greater than zero]
         LDBB= X'E1'      1545 ; =225(-31) ='a' [Load BL with immediate]
         SABB             1547 ; [AL - BL -> BL]
         BM    @D154E     1548 ; =+4 [Branch on minus]
         LDAB= X'C1'      154a ; =193(-63) ='A' [Load AL with immediate]
         ADDB  BL,AL      154c ; [BL + AL -> AL]
@D154E   RSR              154e ; [Return from subroutine]
*
* Function COMST (OSNLB4/OSNLB5)
*
* SVC CS - CPL string compare
* Case-insensitive string compare.
* Jumps to the target address if the comparison is true.
* Returns if the comparison is false.
*
* ASM:
*   Clobbers: A, B, Y, Z
*     JSR/ COMST
*     DW LSTR    ; address of left string
*     DW RSTR    ; address of right string
*     DW TARGET  ; address of jump target if true
*     DB OPER    ; CPL comparison operator
*
COMST    LDA+  X+         154f ; [Load A indexed, direct, post-incremented]
         XAY              1551 ; [Transfer A to Y]
         LDA+  X+         1552 ; [Load A indexed, direct, post-incremented]
         XAZ              1554 ; [Transfer A to Z]
         JMP   @D152A     1555 ; =-45 [Jump relative]
*
* Function COMG48 (OSNLB4/OSNLB5)
*
* SVC CG48 - CPL 48-bit computed goto
* Jumps to the target for the 48-bit value.
* If the value is negative or >=count, returns.
*
* ASM:
*   Clobbers: A, B, Y
*     JSR/ COMG48    
*     DW COUNT        ; number of goto targets
*     DW TGT0         ; target 0
*     * ...           ; additional targets
*     DW TGT<COUNT-1> ; last target
*     DW VALADDR      ; address of 48-bit value
*
COMG48   LDAB= X'04'      1557 ; =4 [Load AL with immediate]
         STAB  @B156B+2   1559 ; =+18 [Store AL relative]
         JMP   @D1561     155b ; =+4 [Jump relative]
*
* Function COMG32 (OSNLB4/OSNLB5)
*
* SVC CG - CPL 32-bit computed goto
* Jumps to the target for the 32-bit value.
* If the value is negative or >=count, returns.
*
* ASM:
*   Clobbers: A, B, Y
*     JSR/ COMG32    
*     DW COUNT        ; number of goto targets
*     DW TGT0         ; target 0
*     * ...           ; additional targets
*     DW TGT<COUNT-1> ; last target
*     DW VALADDR      ; address of 32-bit value
*
COMG32   LDAB= X'02'      155d ; =2 [Load AL with immediate]
         STAB  @B156B+2   155f ; =+12 [Store AL relative]
@D1561   XFR   X,Y        1561 ; [Transfer X to Y]
         LDA+  X+         1563 ; [Load A indexed, direct, post-incremented]
         XAB              1565 ; [Transfer A to B]
         SLA              1566 ; [Left shift A]
         ADD   A,X        1567 ; [A + X -> X]
         LDA+  X+         1569 ; [Load A indexed, direct, post-incremented]
@B156B   LDA+  A,2        156b ; [Load A indexed, displaced, direct]
         BLE   @D157A     156e ; =+10 [Branch if less than or equal to zero]
         SAB              1570 ; [A - B -> B]
         BGZ   @D157A     1571 ; =+7 [Branch if greater than zero]
         SLA              1573 ; [Left shift A]
         ADD   A,Y        1574 ; [A + Y -> Y]
         LDA+  Y          1576 ; [Load A from address in Y]
         BZ    @D157A     1577 ; =+1 [Branch if zero]
         XAX              1579 ; [Transfer A to X]
@D157A   RSR              157a ; [Return from subroutine]
*
* Function MOVST (OSNLB4/OSNLB5)
*
* SVC MV - CPL 32-bit string move
* Concatenates strings into a single string.
*
* ASM:
*   Clobbers: A, B, Y
*     JSR/ MOVST
*     DW TGTSTR  ; address of target string
*     DW SRC0    ; address of source 0
*     * ...      ; additional sources
*     DW 0       ; argument list terminator
*
MOVST    LDA+  X+         157b ; [Load A indexed, direct, post-incremented]
         XAY              157d ; [Transfer A to Y]
@D157E   LDB+  X+         157e ; [Load B indexed, direct, post-incremented]
         BNZ   @D1583     1580 ; =+1 [Branch if not zero]
         RSR              1582 ; [Return from subroutine]
*
@D1583   LDAB+ B+         1583 ; [Load AL indexed, direct, post-incremented]
         STAB+ Y+         1585 ; [Store AL indexed, direct, post-incremented]
         BNZ   @D1583     1587 ; =-6 [Branch if not zero]
         DCR   Y          1589 ; [Decrement Y by 1]
         JMP   @D157E     158b ; =-15 [Jump relative]
*
* Function @DC (OSNLB4/OSNLB5)
*
* SVC DC - CPL decode
* See CENTURION CPU-6 APLIB APPLICATION.
*
* ASM:
*   Clobbers: A, B
*     JSR/ @DC
*     DW STR   ; address of string to decode
*     DW FMT   ; address of CPL format specification
*     DW VAR0  ; address of first variable to decode to
*     * ...    ; additional variables to decode to
*     DW 0     ; argument list terminator
*
* CPL:
*     DECODE(string, format) variable...
*
* Exts:
*   LOD32A
*   OSN0
*   LSFT64
*   STO64
*   ADD64
*   ADD32
*   NEG64
*   STO48
*   STO32
*   OSN9A
*   OSN3A
*   OSN9
*
@DC      LDA+  X+         158d ; [Load A indexed, direct, post-incremented]
         DCA              158f ; [Decrement A]
         DCA              1590 ; [Decrement A]
         DCA              1591 ; [Decrement A]
         DCA              1592 ; [Decrement A]
         CLR   B          1593 ; [Clear B]
         JMP   @D159C     1595 ; =+5 [Jump relative]
*
* Function @RF (OSNLB4/OSNLB5)
*
* SVC RF - CPL formatted read
* See CENTURION CPU-6 APLIB APPLICATION.
*
* ASM:
*   Clobbers: A, B
*     JSR/ @RF
*     DW FILE  ; address of RCB
*     DW FMT   ; address of CPL format specification
*     DW VAR0  ; address of first variable to decode to
*     * ...    ; additional variables to decode to
*     DW 0     ; argument list terminator
*
* CPL:
*     READ(file, format) variable...
*
@RF      JSR/  @F17BA     1597 ; =0x17ba =6074 [Jump to subroutine direct]
         LDB+  X+         159a ; [Load B indexed, direct, post-incremented]
@D159C   JSR/  @F1782     159c ; =0x1782 =6018 [Jump to subroutine direct]
         DB    X'01'      159f ; =0x01 =1
         BNZ   @D15C3     15a0 ; =+33 [Branch if not zero]
         LDA+  X+         15a2 ; [Load A indexed, direct, post-incremented]
         JSR/  @F17C2     15a4 ; =0x17c2 =6082 [Jump to subroutine direct]
@D15A7   LDA+  X+         15a7 ; [Load A indexed, direct, post-incremented]
         STA/  @P168B     15a9 ; =0x168b =5771 [Store A direct]
         XAZ              15ac ; [Transfer A to Z]
         BZ    @D15C7     15ad ; =+24 [Branch if zero]
@D15AF   JSR/  @F1970     15af ; =0x1970 =6512 [Jump to subroutine direct]
         DB    X'01'      15b2 ; =0x01 =1
         DW    @W15CA     15b3 ; =0x15ca =5578
         DB    X'02'      15b5 ; =0x02 =2
         DW    @W15D4     15b6 ; =0x15d4 =5588
         DB    X'03'      15b8 ; =0x03 =3
         DW    @W15E8     15b9 ; =0x15e8 =5608
         DB    X'08'      15bb ; =0x08 =8
         DW    @W15E8     15bc ; =0x15e8 =5608
         DB    X'00'      15be ; =0x00 =0 =NUL
*
@D15BF   JSR/  SET@F      15bf ; =0x17ac =6060 [Jump to subroutine direct]
         DB    X'02'      15c2 ; =0x02 =2
*
@D15C3   LDA+  X+         15c3 ; [Load A indexed, direct, post-incremented]
         BNZ   @D15C3     15c5 ; =-4 [Branch if not zero]
@D15C7   JMP/  @J177D     15c7 ; =0x177d =6013 [Jump direct]
@W15CA   LDBB+ Y          15ca ; [Load BL from address in Y]
         BZ    @D15CF     15cb ; =+2 [Branch if zero]
         INR   Y          15cd ; [Increment Y by 1]
@D15CF   DCA              15cf ; [Decrement A]
         BNZ   @W15CA     15d0 ; =-8 [Branch if not zero]
         JMP   @D15AF     15d2 ; =-37 [Jump relative]
@W15D4   LDBB+ Y+         15d4 ; [Load BL indexed, direct, post-incremented]
         BNZ   @D15DC     15d6 ; =+4 [Branch if not zero]
         DCR   Y          15d8 ; [Decrement Y by 1]
         LDBB= X'A0'      15da ; =160(-96) =' ' [Load BL with immediate]
@D15DC   STBB+ Z+         15dc ; [Store BL indexed, direct, post-incremented]
         DCA              15de ; [Decrement A]
         BNZ   @W15D4     15df ; =-13 [Branch if not zero]
         STAB+ Z          15e1 ; [Store AL to address in Z]
@J15E2   JMP   @D15A7     15e2 ; =-61 [Jump relative]
@D15E4   LDX+  S+         15e4 ; [Pop X from the stack]
         JMP   @D15BF     15e6 ; =-41 [Jump relative]
@W15E8   STX-  S-         15e8 ; [Push X to the stack]
         XAX              15ea ; [Transfer A to X]
         STBB/ @B1671+1   15eb ; =0x1672 =5746 [Store BL direct]
         JSR/  LOD32A     15ee ; [external symbol] [Jump to subroutine direct]
         DW    X'0000'    15f1 ; =0x0000 =0 =NUL,NUL
         LDA/  OSN0+3     15f3 ; [external symbol] [Load A direct]
         LDB=  X'0025'    15f6 ; =0x0025 =37 [Load B with immediate]
         AAB              15f9 ; [A + B -> B]
         STB   @W163A     15fa ; =+62 [Store B relative]
         STB   @W1644     15fc ; =+70 [Store B relative]
         STB   @W1649     15fe ; =+73 [Store B relative]
         STB   @W1678     1600 ; =+118 [Store B relative]
@D1602   DCX              1602 ; [Decrement X]
         BM    @D1669     1603 ; =+100 [Branch on minus]
         LDAB+ Y+         1605 ; [Load AL indexed, direct, post-incremented]
         BZ    @D1667     1607 ; =+94 [Branch if zero]
         LDBB= X'A0'      1609 ; =160(-96) =' ' [Load BL with immediate]
         SABB             160b ; [AL - BL -> BL]
         BZ    @D1602     160c ; =-12 [Branch if zero]
         JSR/  @F169A     160e ; =0x169a =5786 [Jump to subroutine direct]
         BNZ   @D1602     1611 ; =-17 [Branch if not zero]
@D1613   LDBB= X'AE'      1613 ; =174(-82) ='.' [Load BL with immediate]
         SABB             1615 ; [AL - BL -> BL]
         BNZ   @D161F     1616 ; =+7 [Branch if not zero]
         LDAB/ @W1895+1   1618 ; =0x1896 =6294 [Load AL direct]
         STAB  @D1669+1   161b ; =+77 [Store AL relative]
         JMP   @D1660     161d ; =+65 [Jump relative]
@D161F   JSR   @F169A     161f ; =+121 [Jump to subroutine relative]
         BZ    @D1629     1621 ; =+6 [Branch if zero]
         LDAB+ Y+         1623 ; [Load AL indexed, direct, post-incremented]
         BZ    @D1667     1625 ; =+64 [Branch if zero]
         JMP   @D15E4     1627 ; =-69 [Jump relative]
@D1629   JSR/  @F19EF     1629 ; =0x19ef =6639 [Jump to subroutine direct]
         BM    @D15E4     162c ; =-74 [Branch on minus]
         LDAB  @D1669+1   162e ; =+58 [Load AL relative]
         BZ    @D1669     1630 ; =+55 [Branch if zero]
         DCAB             1632 ; [Decrement AL]
         STAB  @D1669+1   1633 ; =+53 [Store AL relative]
         STBB  @B1654     1635 ; =+29 [Store BL relative]
         JSR/  LSFT64     1637 ; [external symbol] [Jump to subroutine direct]
@W163A   DW    X'0000'    163a ; =0x0000 =0 =NUL,NUL
*
         JSR/  STO64      163c ; [external symbol] [Jump to subroutine direct]
         DW    @W1692     163f ; =0x1692 =5778
*
         JSR/  LSFT64     1641 ; [external symbol] [Jump to subroutine direct]
@W1644   DW    X'0000'    1644 ; =0x0000 =0 =NUL,NUL
*
         JSR/  LSFT64     1646 ; [external symbol] [Jump to subroutine direct]
@W1649   DW    X'0000'    1649 ; =0x0000 =0 =NUL,NUL
*
         JSR/  ADD64      164b ; [external symbol] [Jump to subroutine direct]
         DW    @W1692     164e ; =0x1692 =5778
*
         JSR/  ADD32      1650 ; [external symbol] [Jump to subroutine direct]
         DB    X'00'      1653 ; =0x00 =0 =NUL
@B1654   DB    X'00'      1654 ; =0x00 =0 =NUL
         LDA/  OSN0+3     1655 ; [external symbol] [Load A direct]
         LDA+  A,25       1658 ; [Load A indexed, displaced, direct]
         LDAB+ A,6        165b ; [Load AL indexed, displaced, direct]
         BNZ   @D15E4     165e ; =-124 [Branch if not zero]
@D1660   DCX              1660 ; [Decrement X]
         BM    @D1669     1661 ; =+6 [Branch on minus]
         LDAB+ Y+         1663 ; [Load AL indexed, direct, post-incremented]
         BNZ   @D1613     1665 ; =-84 [Branch if not zero]
@D1667   DCR   Y          1667 ; [Decrement Y by 1]
@D1669   LDAB= X'00'      1669 ; =0 =NUL [Load AL with immediate]
         BLE   @B1671     166b ; =+4 [Branch if less than or equal to zero]
         LDAB= X'B0'      166d ; =176(-80) ='0' [Load AL with immediate]
         JMP   @D1629     166f ; =-72 [Jump relative]
@B1671   LDAB= X'00'      1671 ; =0 =NUL [Load AL with immediate]
         BLE   @D167A     1673 ; =+5 [Branch if less than or equal to zero]
         JSR/  NEG64      1675 ; [external symbol] [Jump to subroutine direct]
@W1678   DW    X'0000'    1678 ; =0x0000 =0 =NUL,NUL
*
@D167A   LDA=  STO48      167a ; [external symbol] [Load A with immediate]
         STA   @W1688+1   167d ; =+10 [Store A relative]
@B167F   LDAB= X'00'      167f ; =0 =NUL [Load AL with immediate]
         BZ    @W1688     1681 ; =+5 [Branch if zero]
         LDA=  STO32      1683 ; [external symbol] [Load A with immediate]
         STA   @W1688+1   1686 ; =+1 [Store A relative]
@W1688   JSR/  STO32      1688 ; [external symbol] [Jump to subroutine direct]
@P168B   DW    X'0000'    168b ; =0x0000 =0 =NUL,NUL
         LDX+  S+         168d ; [Pop X from the stack]
         JMP/  @J15E2     168f ; =0x15e2 =5602 [Jump direct]
*
@W1692   DS    8          1692 ; [Uninitialized memory]
*
*
* Function @F169A
*
@F169A   LDBB= X'AD'      169a ; =173(-83) ='-' [Load BL with immediate]
         SABB             169c ; [AL - BL -> BL]
         BZ    @D16A7     169d ; =+8 [Branch if zero]
         LDBB= X'AB'      169f ; =171(-85) ='+' [Load BL with immediate]
         SABB             16a1 ; [AL - BL -> BL]
         BZ    @D16A7     16a2 ; =+3 [Branch if zero]
         CLR   B          16a4 ; [Clear B]
         RSR              16a6 ; [Return from subroutine]
*
@D16A7   LDBB= X'AC'      16a7 ; =172(-84) =',' [Load BL with immediate]
         SABB             16a9 ; [AL - BL -> BL]
         LDAB  @B1671+1   16aa ; =-58 [Load AL relative]
         BNZ   @D16B1     16ac ; =+3 [Branch if not zero]
         STBB  @B1671+1   16ae ; =-62 [Store BL relative]
         RSR              16b0 ; [Return from subroutine]
*
@D16B1   LDX+  S+         16b1 ; [Pop X from the stack]
         JMP/  @D15E4     16b3 ; =0x15e4 =5604 [Jump direct]
*
* Function @CP (OSNLB4/OSNLB5)
*
* SVC CP - CPL cursor position
* See CENTURION CPU-6 APLIB APPLICATION.
*
* ASM:
*   Clobbers: A, B, Y
*     JSR/ @CP
*     DW FILE  ; address of RCB
*     DW COL   ; 1-based column
*     DW ROW   ; 1-based row
*     * OR *  
*     JSR/ @CP
*     DW FILE  ; address of RCB
*     DW COL   ; address of 32-bit integer containing column (address > 0xFF)
*     DW ROW   ; address of 32-bit integer containing row (address > 0xFF)
*
* CPL:
*     CURP(file, column, line) ; 1-based, no expressions
*
@CP      JSR/  @F17BA     16b6 ; =0x17ba =6074 [Jump to subroutine direct]
         STA-  S-         16b9 ; [Push A to the stack]
         INA              16bb ; [Increment A]
         INA              16bc ; [Increment A]
         XAY              16bd ; [Transfer A to Y]
         LDA=  X'0004'    16be ; =0x0004 =4 [Load A with immediate]
         STA+  Y+         16c1 ; [Store A indexed, direct, post-incremented]
         LDA=  X'9BB1'    16c3 ; =0x9bb1 =39857(-25679) [Load A with immediate]
         STA+  Y+         16c6 ; [Store A indexed, direct, post-incremented]
         LDB+  X+         16c8 ; [Load B indexed, direct, post-incremented]
         LDA+  X+         16ca ; [Load A indexed, direct, post-incremented]
         XFRB  AU,AU      16cc ; [Transfer AU to AU]
         BZ    @D16D3     16ce ; =+3 [Branch if zero]
         LDA+  A,2        16d0 ; [Load A indexed, displaced, direct]
@D16D3   STAB+ Y+         16d3 ; [Store AL indexed, direct, post-incremented]
         LDA+  X+         16d5 ; [Load A indexed, direct, post-incremented]
         XFRB  AU,AU      16d7 ; [Transfer AU to AU]
         BZ    @D16DE     16d9 ; =+3 [Branch if zero]
         LDA+  A,2        16db ; [Load A indexed, displaced, direct]
@D16DE   STAB+ Y          16de ; [Store AL to address in Y]
         LDA+  S+         16df ; [Pop A from the stack]
         JSR/  @F1782     16e1 ; =0x1782 =6018 [Jump to subroutine direct]
         DB    X'02'      16e4 ; =0x02 =2
         JMP/  @J177D     16e5 ; =0x177d =6013 [Jump direct]
*
* Function @CS (OSNLB4/OSNLB5)
*
* SVC CC - CPL cursor blanking with specified string
* See CENTURION CPU-6 APLIB APPLICATION.
*
* ASM:
*   Clobbers: A, B, Y
*     JSR/ @CS
*     DW FILE  ; address of RCB
*     DW COUNT ; number of characters
*     DW STR   ; address of string
*
* CPL:
*     CURS(file, number, string)
*
@CS      LDAB= X'01'      16e8 ; =1 [Load AL with immediate]
         STAB  @B170D+1   16ea ; =+34 [Store AL relative]
         JMP   @D16F1     16ec ; =+3 [Jump relative]
*
* Function @CB (OSNLB4/OSNLB5)
*
* SVC CB - CPL cursor blanking
* See CENTURION CPU-6 APLIB APPLICATION.
*
* ASM:
*   Clobbers: A, B, Y
*     JSR/ @CB
*     DW FILE  ; address of RCB
*     DW COUNT ; number of characters
*
* CPL:
*     CURB(file, number)
*
@CB      CLAB             16ee ; [Clear AL]
         STAB  @B170D+1   16ef ; =+29 [Store AL relative]
@D16F1   JSR/  @F17BA     16f1 ; =0x17ba =6074 [Jump to subroutine direct]
         XAY              16f4 ; [Transfer A to Y]
         LDA+  X+         16f5 ; [Load A indexed, direct, post-incremented]
         STA-  S-         16f7 ; [Push A to the stack]
         LDA+  X+         16f9 ; [Load A indexed, direct, post-incremented]
         XFRB  AU,AU      16fb ; [Transfer AU to AU]
         BZ    @D1702     16fd ; =+3 [Branch if zero]
         LDA+  A,2        16ff ; [Load A indexed, displaced, direct]
@D1702   LDB+  Y          1702 ; [Load B from address in Y]
         SAB              1703 ; [A - B -> B]
         BLE   @D1707     1704 ; =+1 [Branch if less than or equal to zero]
         LDA+  Y          1706 ; [Load A from address in Y]
@D1707   INR   Y          1707 ; [Increment Y by 1]
         INR   Y          1709 ; [Increment Y by 1]
         STA+  Y+         170b ; [Store A indexed, direct, post-incremented]
@B170D   LDBB= X'00'      170d ; =0 =NUL [Load BL with immediate]
         BNZ   @D1733     170f ; =+34 [Branch if not zero]
         LDBB= X'A0'      1711 ; =160(-96) =' ' [Load BL with immediate]
@D1713   DCA              1713 ; [Decrement A]
         BM    @D171A     1714 ; =+4 [Branch on minus]
         STBB+ Y+         1716 ; [Store BL indexed, direct, post-incremented]
         JMP   @D1713     1718 ; =-7 [Jump relative]
@D171A   JSR   @F1738     171a ; =+28 [Jump to subroutine relative]
         JSR/  @F17BA     171c ; =0x17ba =6074 [Jump to subroutine direct]
         INA              171f ; [Increment A]
         INA              1720 ; [Increment A]
         XAY              1721 ; [Transfer A to Y]
         LDA+  Y+         1722 ; [Load A indexed, direct, post-incremented]
         LDBB= X'88'      1724 ; =136(-120) =BS [Load BL with immediate]
@D1726   DCA              1726 ; [Decrement A]
         BM    @D172D     1727 ; =+4 [Branch on minus]
         STBB+ Y+         1729 ; [Store BL indexed, direct, post-incremented]
         JMP   @D1726     172b ; =-7 [Jump relative]
@D172D   JSR   @F1738     172d ; =+9 [Jump to subroutine relative]
         LDA+  S+         172f ; [Pop A from the stack]
         JMP   @J177D     1731 ; =+74 [Jump relative]
@D1733   LDB+  X+         1733 ; [Load B indexed, direct, post-incremented]
         LDBB+ B          1735 ; [Load BL from address in B]
         JMP   @D1713     1736 ; =-37 [Jump relative]
*
* Function @F1738
*
@F1738   JSR/  @F17BA     1738 ; =0x17ba =6074 [Jump to subroutine direct]
         LDB+  S,2        173b ; [Load B indexed, displaced, direct]
         JSR/  @F1782     173e ; =0x1782 =6018 [Jump to subroutine direct]
         DB    X'02'      1741 ; =0x02 =2
         RSR              1742 ; [Return from subroutine]
*
* Function @OP (OSNLB4/OSNLB5)
*
* SVC OP - CPL open
* See CENTURION CPU-6 APLIB APPLICATION.
*
* ASM:
*   Clobbers: A, B
*     JSR/ @OP                      
*     DB ACCESS                      ; access mode or 0 to terminate
*     DW FILE                        ; address of RCB
*     * repeat data until terminator
*
* CPL:
*     OPEN access file         ; single
*     OPEN access (file...)... ; single or multiple
*
@OP      LDAB+ X+         1743 ; [Load AL indexed, direct, post-incremented]
         BZ    @D1756     1745 ; =+15 [Branch if zero]
         LDB+  X+         1747 ; [Load B indexed, direct, post-incremented]
         STAB+ B,2        1749 ; [Store AL indexed, displaced, direct]
         LDAB= X'09'      174c ; =9 [Load AL with immediate]
         STAB+ B,3        174e ; [Store AL indexed, displaced, direct]
         JSR/  OSN9A      1751 ; [external symbol] [Jump to subroutine direct]
         JMP   @OP        1754 ; =-19 [Jump relative]
@D1756   RSR              1756 ; [Return from subroutine]
*
* Function @CT (OSNLB4/OSNLB5)
*
* SVC CT - CPL control function
* See CENTURION CPU-6 APLIB APPLICATION.
*
* ASM:
*   Clobbers: A, B
*     JSR/ @CT
*     DB FUNC  ; function to perform
*     DW FILE  ; address of RCB
*
* CPL:
*     CLOSE file  ; close file
*     FREE file   ; free sector lock in file
*     HOLD file   ; hold secotr lock in file
*     RESET file  ; rewind tape
*     REWIND file ; reopen file at beginning
*
@CT      LDAB+ X+         1757 ; [Load AL indexed, direct, post-incremented]
         LDB+  X          1759 ; [Load B from address in X]
         STAB+ B,3        175a ; [Store AL indexed, displaced, direct]
         JSR/  OSN9A      175d ; [external symbol] [Jump to subroutine direct]
         LDB+  X+         1760 ; [Load B indexed, direct, post-incremented]
         LDAB+ B          1762 ; [Load AL from address in B]
         JSR   @F17AE     1763 ; =+73 [Jump to subroutine relative]
         RSR              1765 ; [Return from subroutine]
*
* Function @RB (OSNLB4/OSNLB5)
*
* SVC RB - CPL binary read
* See CENTURION CPU-6 APLIB APPLICATION.
*
* ASM:
*   Clobbers: A, B
*     JSR/ @RB
*     DW FILE  ; address of RCB
*     DW REC   ; address of record
*
* CPL:
*     READB(file, record)
*
@RB      LDB+  X+         1766 ; [Load B indexed, direct, post-incremented]
         LDA+  X+         1768 ; [Load A indexed, direct, post-incremented]
         JSR   @F1782     176a ; =+22 [Jump to subroutine relative]
         DB    X'01'      176c ; =0x01 =1
         JMP   @J177D     176d ; =+14 [Jump relative]
*
* Function @WB (OSNLB4/OSNLB5)
*
* SVC WB - CPL binary write
* See CENTURION CPU-6 APLIB APPLICATION.
*
* ASM:
*   Clobbers: A, B
*     JSR/ @WB
*     DW FILE  ; address of RCB
*     DW REC   ; address of record
*
* CPL:
*     WRITEB(file, record)
*
@WB      LDA+  X,2        176f ; [Load A indexed, displaced, direct]
         LDB+  A+         1772 ; [Load B indexed, direct, post-incremented]
         STB+  A          1774 ; [Store B to address in A]
         LDB+  X+         1775 ; [Load B indexed, direct, post-incremented]
         LDA+  X+         1777 ; [Load A indexed, direct, post-incremented]
         JSR/  @F1782     1779 ; =0x1782 =6018 [Jump to subroutine direct]
         DB    X'02'      177c ; =0x02 =2
*
@J177D   LDA/  X'005A'    177d ; =0x005a =90 [Load A direct]
         XAZ              1780 ; [Transfer A to Z]
         RSR              1781 ; [Return from subroutine]
*
* Function @F1782
*
@F1782   XAY              1782 ; [Transfer A to Y]
         LDA+  Y+         1783 ; [Load A indexed, direct, post-incremented]
         XFR   B,Z        1785 ; [Transfer B to Z]
         BNZ   @D178F     1787 ; =+6 [Branch if not zero]
         LDA+  Y+         1789 ; [Load A indexed, direct, post-incremented]
         INX              178b ; [Increment X]
         CLAB             178c ; [Clear AL]
         JMP   @D17A9     178d ; =+26 [Jump relative]
@D178F   STA+  B,14       178f ; [Store A indexed, displaced, direct]
         XFR   Y,A        1792 ; [Transfer Y to A]
         STA+  B,16       1794 ; [Store A indexed, displaced, direct]
         INA              1797 ; [Increment A]
         INA              1798 ; [Increment A]
         XAY              1799 ; [Transfer A to Y]
         LDAB+ X+         179a ; [Load AL indexed, direct, post-incremented]
         STAB+ B,3        179c ; [Store AL indexed, displaced, direct]
         JSR/  OSN9A      179f ; [external symbol] [Jump to subroutine direct]
         CLA              17a2 ; [Clear A]
         LDAB+ Z          17a3 ; [Load AL from address in Z]
         LDB=  @W19FA     17a4 ; =0x19fa =6650 [Load B with immediate]
         AAB              17a7 ; [A + B -> B]
         LDAB+ B          17a8 ; [Load AL from address in B]
@D17A9   JSR   @F17AE     17a9 ; =+3 [Jump to subroutine relative]
         RSR              17ab ; [Return from subroutine]
*
* Function SET@F (OSNLB4/OSNLB5)
*
* Sets CPL @IF (LSB of STATUS) in the current task.
*
* ASM:
*   Clobbers: AL, B
*     JSR/ SET@F
*     DB VAL     ; value to set
*
SET@F    LDAB+ X+         17ac ; [Load AL indexed, direct, post-incremented]
*
* Function @F17AE
*
@F17AE   LDB/  OSN0+3     17ae ; B = current TIB address
         LDB+  B,25       17b1 ; B = current task utility word address
         BZ    @D17B9     17b4 ; =+3 [Branch if zero]
         STAB+ B,6        17b6 ; store to @IF (LSB of STATUS)
@D17B9   RSR              17b9 ; [Return from subroutine]
*
* Function @F17BA
*
@F17BA   LDA/  OSN0+3     17ba ; [external symbol] [Load A direct]
         LDA+  A,25       17bd ; [Load A indexed, displaced, direct]
         LDA+  A          17c0 ; [Load A from address in A]
         RSR              17c1 ; [Return from subroutine]
*
* Function @F17C2
*
@F17C2   STA/  @W196B+1   17c2 ; =0x196c =6508 [Store A direct]
         STA/  @W1987+1   17c5 ; =0x1988 =6536 [Store A direct]
         CLA              17c8 ; [Clear A]
         STA/  @W19D3+1   17c9 ; =0x19d4 =6612 [Store A direct]
         RSR              17cc ; [Return from subroutine]
*
* Function @NC (OSNLB4/OSNLB5)
*
* NC - CPL encode
* See CENTURION CPU-6 APLIB APPLICATION.
*
* ASM:
*   Clobbers: A, B
*     JSR/ @NC
*     DW STR   ; address of string to encode
*     DW FMT   ; address of CPL format specification
*     DW VAR0  ; address of first variable to encode from
*     * ...    ; additional variables to encode from
*     DW 0     ; argument list terminator
*
* CPL:
*     ENCODE(string, format) variable...
*
@NC      CLA              17cd ; [Clear A]
         STAB- S-         17ce ; [Push AL to the stack]
         STA-  S-         17d0 ; [Push A to the stack]
         LDA+  X+         17d2 ; [Load A indexed, direct, post-incremented]
         XAY              17d4 ; [Transfer A to Y]
         JMP   @D1806     17d5 ; =+47 [Jump relative]
*
* Function @RT (OSNLB4/OSNLB5)
*
* SVC RT - CPL rewrite
* See CENTURION CPU-6 APLIB APPLICATION.
*
* ASM:
*   Clobbers: A, B
*     JSR/ @RT
*     DW FILE  ; address of RCB
*     DW FMT   ; address of CPL format specification
*     DW VAR0  ; address of first variable to encode from
*     * ...    ; additional variables to encode from
*     DW 0     ; argument list terminator
*
* CPL:
*     REWRITE(file, format) variable... ; full spelling
*
@RT      LDAB= X'03'      17d7 ; =3 [Load AL with immediate]
         JMP   @D17F0     17d9 ; =+21 [Jump relative]
*
* Function @WN (OSNLB4/OSNLB5)
*
* SVC WN - CPL formatted write without CR
* See CENTURION CPU-6 APLIB APPLICATION.
*
* ASM:
*   Clobbers: A, B
*     JSR/ @WN
*     DW FILE  ; address of RCB
*     DW FMT   ; address of CPL format specification
*     DW VAR0  ; address of first variable to encode from
*     * ...    ; additional variables to encode from
*     DW 0     ; argument list terminator
*
* CPL:
*     WRITEN(file, format) variable... ; full spelling
*     WRITN(file, format) variable...  ; abbreviated
*
@WN      LDB+  X          17db ; [Load B from address in X]
         JSR/  OSN3A      17dc ; [external symbol] [Jump to subroutine direct]
         LDBB+ A          17df ; [Load BL from address in A]
         LDAB= X'C3'      17e0 ; =195(-61) ='C' [Load AL with immediate]
         NABB             17e2 ; [AL & BL -> BL]
         SABB             17e3 ; [AL - BL -> BL]
         BNZ   @WF        17e4 ; =+4 [Branch if not zero]
         STBB  @B1839+1   17e6 ; =+82 [Store BL relative]
         JMP   @D17EE     17e8 ; =+4 [Jump relative]
*
* Function @WF (OSNLB4/OSNLB5)
*
* SVC WF - CPL formatted write
* See CENTURION CPU-6 APLIB APPLICATION.
*
* ASM:
*   Clobbers: A, B
*     JSR/ @WF
*     DW FILE  ; address of RCB
*     DW FMT   ; address of CPL format specification
*     DW VAR0  ; address of first variable to encode from
*     * ...    ; additional variables to encode from
*     DW 0     ; argument list terminator
*
* CPL:
*     WRITE(file, format) variable... ; full spelling
*
@WF      LDAB= X'01'      17ea ; =1 [Load AL with immediate]
         STAB  @B1839+1   17ec ; =+76 [Store AL relative]
@D17EE   LDAB= X'02'      17ee ; =2 [Load AL with immediate]
@D17F0   LDB+  X+         17f0 ; [Load B indexed, direct, post-incremented]
         STAB- S-         17f2 ; [Push AL to the stack]
         STB-  S-         17f4 ; [Push B to the stack]
         JSR   @F17BA     17f6 ; =-62 [Jump to subroutine relative]
         XAY              17f8 ; [Transfer A to Y]
         LDA+  Y+         17f9 ; [Load A indexed, direct, post-incremented]
         STA+  Y+         17fb ; [Store A indexed, direct, post-incremented]
         XFR   Y,Z        17fd ; [Transfer Y to Z]
         LDBB= X'A0'      17ff ; =160(-96) =' ' [Load BL with immediate]
@D1801   STBB+ Z+         1801 ; [Store BL indexed, direct, post-incremented]
         DCA              1803 ; [Decrement A]
         BGZ   @D1801     1804 ; =-5 [Branch if greater than zero]
@D1806   LDA+  X+         1806 ; [Load A indexed, direct, post-incremented]
         JSR   @F17C2     1808 ; =-72 [Jump to subroutine relative]
@J180A   LDA+  X+         180a ; [Load A indexed, direct, post-incremented]
         STA/  @P168B     180c ; =0x168b =5771 [Store A direct]
         XAZ              180f ; [Transfer A to Z]
         BNZ   @D185B     1810 ; =+73 [Branch if not zero]
         STAB  @B1847+1   1812 ; =+52 [Store AL relative]
@D1814   LDAB+ S,2        1814 ; [Load AL indexed, displaced, direct]
         BZ    @D1842     1817 ; =+41 [Branch if zero]
         JSR   @F17BA     1819 ; =-97 [Jump to subroutine relative]
         XAY              181b ; [Transfer A to Y]
         LDA+  Y+         181c ; [Load A indexed, direct, post-incremented]
         XFR   Y,Z        181e ; [Transfer Y to Z]
         LDA+  Y+         1820 ; [Load A indexed, direct, post-incremented]
         ADD   A,Y        1822 ; [A + Y -> Y]
         LDB=  X'A0A0'    1824 ; =0xa0a0 =41120(-24416) =' ',' ' [Load B with immediate]
@D1827   DCA              1827 ; [Decrement A]
         BLE   @D1832     1828 ; =+8 [Branch if less than or equal to zero]
         LDBB- Y-         182a ; [Load BL indexed, pre-decremented, direct]
         SUBB  BU,BL      182c ; [BU - BL -> BL]
         BZ    @D1827     182e ; =-9 [Branch if zero]
         INR   Y          1830 ; [Increment Y by 1]
@D1832   LDBB= X'00'      1832 ; =0 =NUL [Load BL with immediate]
         STBB+ Y          1834 ; [Store BL to address in Y]
         INA              1835 ; [Increment A]
         LDB+  S          1836 ; [Load B from address in S]
         BZ    @D1841     1837 ; =+8 [Branch if zero]
@B1839   LDBB= X'00'      1839 ; =0 =NUL [Load BL with immediate]
         BZ    @D1841     183b ; =+4 [Branch if zero]
         LDBB= X'8D'      183d ; =141(-115) =CR [Load BL with immediate]
         STBB+ Y          183f ; [Store BL to address in Y]
         INA              1840 ; [Increment A]
@D1841   STA+  Z          1841 ; [Store A to address in Z]
@D1842   LDB+  S+         1842 ; [Pop B from the stack]
         LDAB+ S          1844 ; [Load AL from address in S]
         STAB  @B1850     1845 ; =+9 [Store AL relative]
@B1847   LDAB= X'00'      1847 ; =0 =NUL [Load AL with immediate]
         STAB+ S          1849 ; [Store AL to address in S]
         JSR/  @F17BA     184a ; =0x17ba =6074 [Jump to subroutine direct]
         JSR/  @F1782     184d ; =0x1782 =6018 [Jump to subroutine direct]
@B1850   DB    X'00'      1850 ; =0x00 =0 =NUL
         LDAB+ S+         1851 ; [Pop AL from the stack]
         BZ    @D1858     1853 ; =+3 [Branch if zero]
         JSR/  @F17AE     1855 ; =0x17ae =6062 [Jump to subroutine direct]
@D1858   JMP/  @J177D     1858 ; =0x177d =6013 [Jump direct]
@D185B   JSR/  @F1970     185b ; =0x1970 =6512 [Jump to subroutine direct]
         DB    X'01'      185e ; =0x01 =1
         DW    @W187B     185f ; =0x187b =6267
         DB    X'02'      1861 ; =0x02 =2
         DW    @W187F     1862 ; =0x187f =6271
         DB    X'03'      1864 ; =0x03 =3
         DW    @W1895     1865 ; =0x1895 =6293
         DB    X'04'      1867 ; =0x04 =4
         DW    @W1893     1868 ; =0x1893 =6291
         DB    X'05'      186a ; =0x05 =5
         DW    @W188F     186b ; =0x188f =6287
         DB    X'08'      186d ; =0x08 =8
         DW    @W1897     186e ; =0x1897 =6295
         DB    X'00'      1870 ; =0x00 =0 =NUL
         LDAB= X'02'      1871 ; =2 [Load AL with immediate]
         STAB  @B1847+1   1873 ; =-45 [Store AL relative]
@D1875   LDA+  X+         1875 ; [Load A indexed, direct, post-incremented]
         BNZ   @D1875     1877 ; =-4 [Branch if not zero]
         JMP   @D1814     1879 ; =-103 [Jump relative]
@W187B   ADD   A,Y        187b ; [A + Y -> Y]
         JMP   @D185B     187d ; =-36 [Jump relative]
@W187F   LDBB+ Z+         187f ; [Load BL indexed, direct, post-incremented]
         BNZ   @D1887     1881 ; =+4 [Branch if not zero]
         DCR   Z          1883 ; [Decrement Z by 1]
         LDBB= X'A0'      1885 ; =160(-96) =' ' [Load BL with immediate]
@D1887   STBB+ Y+         1887 ; [Store BL indexed, direct, post-incremented]
         DCA              1889 ; [Decrement A]
         BNZ   @W187F     188a ; =-13 [Branch if not zero]
@J188C   JMP/  @J180A     188c ; =0x180a =6154 [Jump direct]
@W188F   LDBB= X'01'      188f ; =1 [Load BL with immediate]
@B1891   STBB= X'00'      1891 ; =0 =NUL [Store BL immediate]
@W1893   LDBB= X'02'      1893 ; =2 [Load BL with immediate]
@W1895   STBB= X'00'      1895 ; =0 =NUL [Store BL immediate]
@W1897   XFR   Z,B        1897 ; [Transfer Z to B]
         STB-  S-         1899 ; [Push B to the stack]
         XAZ              189b ; [Transfer A to Z]
         DCAB             189c ; [Decrement AL]
         STAB  @B18AA+2   189d ; =+13 [Store AL relative]
@P189F   LDBB$ @P168B     189f ; =0x168b =5771 [Load BL indirect]
         BP    @D18B8     18a2 ; =+20 [Branch on plus]
         LDAB= X'AD'      18a4 ; =173(-83) ='-' [Load AL with immediate]
         LDBB  @B1891+1   18a6 ; =-22 [Load BL relative]
         BZ    @D18AF     18a8 ; =+5 [Branch if zero]
@B18AA   STAB+ Y,1        18aa ; [Store AL indexed, displaced, direct]
         JMP   @D18B8     18ad ; =+9 [Jump relative]
@D18AF   STAB+ Y+         18af ; [Store AL indexed, direct, post-incremented]
         DCR   Z          18b1 ; [Decrement Z by 1]
         BNZ   @D18B8     18b3 ; =+3 [Branch if not zero]
         JMP/  @J194F     18b5 ; =0x194f =6479 [Jump direct]
@D18B8   ADD   Z,Y        18b8 ; [Z + Y -> Y]
         STX-  S-         18ba ; [Push X to the stack]
         XFR   Y,X        18bc ; [Transfer Y to X]
         STX-  S-         18be ; [Push X to the stack]
         DCX              18c0 ; [Decrement X]
         LDAB  @B1891+1   18c1 ; =-49 [Load AL relative]
         BZ    @D18C8     18c3 ; =+3 [Branch if zero]
         DCX              18c5 ; [Decrement X]
         DCR   Z          18c6 ; [Decrement Z by 1]
@D18C8   STX/  @W1955+1   18c8 ; =0x1956 =6486 [Store X direct]
         XFRB  ZL,AL      18cb ; [Transfer ZL to AL]
         STAB/ @B195D+1   18cd ; =0x195e =6494 [Store AL direct]
         CLR   Y          18d0 ; [Clear Y]
         LDA*  @P189F+1   18d2 ; =-52 [Load A relative indirect]
         XAZ              18d4 ; [Transfer A to Z]
         LDBB= X'1C'      18d5 ; =28 [Load BL with immediate]
         LDX=  X'0101'    18d7 ; =0x0101 =257 [Load X with immediate]
@B18DA   LDAB= X'00'      18da ; =0 =NUL [Load AL with immediate]
         BNZ   @D18E7     18dc ; =+9 [Branch if not zero]
         LDA+  Z,4        18de ; [Load A indexed, displaced, direct]
         XAY              18e1 ; [Transfer A to Y]
         LDBB= X'2C'      18e2 ; =44 [Load BL with immediate]
         LDX=  X'3760'    18e4 ; =0x3760 =14176 [Load X with immediate]
@D18E7   STBB  @B1904+1   18e7 ; =+28 [Store BL relative]
         STX   @W190D     18e9 ; =+34 [Store X relative]
         LDX+  Z,2        18eb ; [Load X indexed, displaced, direct]
         LDB+  Z          18ee ; [Load B from address in Z]
         BP    @D1900     18ef ; =+15 [Branch on plus]
         IVR   B          18f1 ; [Invert B]
         IVR   X          18f3 ; [Invert X]
         IVR   Y          18f5 ; [Invert Y]
         INR   Y          18f7 ; [Increment Y by 1]
         BNZ   @D1900     18f9 ; =+5 [Branch if not zero]
         INX              18fb ; [Increment X]
         BNZ   @D1900     18fc ; =+2 [Branch if not zero]
         INR   B          18fe ; [Increment B by 1]
@D1900   LDA=  X'B050'    1900 ; =0xb050 =45136(-20400) [Load A with immediate]
         XAZ              1903 ; [Transfer A to Z]
@B1904   LDAB= X'2C'      1904 ; =44 [Load AL with immediate]
@D1906   ADDB  ZU,BU      1906 ; [ZU + BU -> BU]
         BP    @W190D     1908 ; =+3 [Branch on plus]
         ADDB  ZL,BU      190a ; [ZL + BU -> BU]
         RL               190c ; [Reset link]
@W190D   RLR   Y          190d ; [Left rotate Y by 1]
         RLR   X          190f ; [Left rotate X by 1]
         RLR   B          1911 ; [Left rotate B by 1]
         DCAB             1913 ; [Decrement AL]
         BGZ   @D1906     1914 ; =-16 [Branch if greater than zero]
         LDA=  X'F00F'    1916 ; =0xf00f =61455(-4081) [Load A with immediate]
         ANDB  BU,AU      1919 ; [BU & AU -> AU]
         ANDB  AL,BU      191b ; [AL & BU -> BU]
         RL               191d ; [Reset link]
         RRRB  AU         191e ; [Right rotate AU by 1]
         RRRB  AU         1920 ; [Right rotate AU by 1]
         RRRB  AU         1922 ; [Right rotate AU by 1]
         RRRB  AU         1924 ; [Right rotate AU by 1]
@D1926   LDAB= X'B0'      1926 ; =176(-80) ='0' [Load AL with immediate]
         ADDB  AU,AL      1928 ; [AU + AL -> AL]
         JSR   @W1955     192a ; =+41 [Jump to subroutine relative]
         LDAB/ @W1895+1   192c ; =0x1896 =6294 [Load AL direct]
         DCAB             192f ; [Decrement AL]
         STAB/ @W1895+1   1930 ; =0x1896 =6294 [Store AL direct]
         BNZ   @D1939     1933 ; =+4 [Branch if not zero]
         LDAB= X'AE'      1935 ; =174(-82) ='.' [Load AL with immediate]
         JSR   @W1955     1937 ; =+28 [Jump to subroutine relative]
@D1939   XFR   B,B        1939 ; [Transfer B to B]
         BNZ   @B1904     193b ; =-57 [Branch if not zero]
         XFR   X,X        193d ; [Transfer X to X]
         BNZ   @B1904     193f ; =-61 [Branch if not zero]
         XFR   Y,A        1941 ; [Transfer Y to A]
         BNZ   @B1904     1943 ; =-65 [Branch if not zero]
         LDAB/ @W1895+1   1945 ; =0x1896 =6294 [Load AL direct]
         BP    @D1926     1948 ; =-36 [Branch on plus]
@W194A   LDA+  S+         194a ; [Pop A from the stack]
         XAY              194c ; [Transfer A to Y]
         LDX+  S+         194d ; [Pop X from the stack]
@J194F   LDA+  S+         194f ; [Pop A from the stack]
         XAZ              1951 ; [Transfer A to Z]
         JMP/  @J188C     1952 ; =0x188c =6284 [Jump direct]
@W1955   STAB/ X'0000'    1955 ; =0x0000 =0 =NUL,NUL [Store AL direct]
         LDA   @W1955+1   1958 ; =-4 [Load A relative]
         DCA              195a ; [Decrement A]
         STA   @W1955+1   195b ; =-7 [Store A relative]
@B195D   LDAB= X'00'      195d ; =0 =NUL [Load AL with immediate]
         DCAB             195f ; [Decrement AL]
         STAB  @B195D+1   1960 ; =-4 [Store AL relative]
         BGZ   @D1967     1962 ; =+3 [Branch if greater than zero]
         LDX=  @W194A     1964 ; =0x194a =6474 [Load X with immediate]
@D1967   RSR              1967 ; [Return from subroutine]
*
@D1968   LDA+  S+         1968 ; [Pop A from the stack]
         XAZ              196a ; [Transfer A to Z]
@W196B   LDA=  X'0000'    196b ; =0x0000 =0 =NUL,NUL [Load A with immediate]
         STA   @W1987+1   196e ; =+24 [Store A relative]
*
* Function @F1970
*
@F1970   LDAB= X'FF'      1970 ; =255(-1) [Load AL with immediate]
         STAB/ @W1895+1   1972 ; =0x1896 =6294 [Store AL direct]
         STAB/ @D1669+1   1975 ; =0x166a =5738 [Store AL direct]
         INAB             1978 ; [Increment AL]
         STAB/ @B1891+1   1979 ; =0x1892 =6290 [Store AL direct]
         INAB             197c ; [Increment AL]
         STAB/ @B167F+1   197d ; =0x1680 =5760 [Store AL direct]
         STAB/ @B18DA+1   1980 ; =0x18db =6363 [Store AL direct]
         XFR   Z,A        1983 ; [Transfer Z to A]
         STA-  S-         1985 ; [Push A to the stack]
@W1987   LDA=  X'0000'    1987 ; =0x0000 =0 =NUL,NUL [Load A with immediate]
         XAZ              198a ; [Transfer A to Z]
         LDAB+ Z+         198b ; [Load AL indexed, direct, post-incremented]
         BZ    @D1968     198d ; =-39 [Branch if zero]
         LDBB= X'08'      198f ; =8 [Load BL with immediate]
         NABB             1991 ; [AL & BL -> BL]
         BZ    @D19B9     1992 ; =+37 [Branch if zero]
         LDBB= X'01'      1994 ; =1 [Load BL with immediate]
         NABB             1996 ; [AL & BL -> BL]
         STBB/ @B167F+1   1997 ; =0x1680 =5760 [Store BL direct]
         STBB/ @B18DA+1   199a ; =0x18db =6363 [Store BL direct]
         LDBB= X'02'      199d ; =2 [Load BL with immediate]
         NABB             199f ; [AL & BL -> BL]
         STBB/ @B1891+1   19a0 ; =0x1892 =6290 [Store BL direct]
         SRAB             19a3 ; [Arithmetic right shift AL]
         SRAB             19a4 ; [Arithmetic right shift AL]
         SRAB             19a5 ; [Arithmetic right shift AL]
         SRAB             19a6 ; [Arithmetic right shift AL]
         XABB             19a7 ; [Transfer AL to BL]
         INAB             19a8 ; [Increment AL]
         BZ    @D19AF     19a9 ; =+4 [Branch if zero]
         LDBB= X'0F'      19ab ; =15 [Load BL with immediate]
         DCAB             19ad ; [Decrement AL]
         NABB             19ae ; [AL & BL -> BL]
@D19AF   STBB/ @W1895+1   19af ; =0x1896 =6294 [Store BL direct]
         LDAB= X'08'      19b2 ; =8 [Load AL with immediate]
         JMP   @D19B9     19b4 ; =+3 [Jump relative]
@D19B6   CLAB             19b6 ; [Clear AL]
@D19B7   INX              19b7 ; [Increment X]
         INX              19b8 ; [Increment X]
@D19B9   LDBB+ X+         19b9 ; [Load BL indexed, direct, post-incremented]
         BZ    @D19E8     19bb ; =+43 [Branch if zero]
         SABB             19bd ; [AL - BL -> BL]
         BNZ   @D19B7     19be ; =-9 [Branch if not zero]
         LDA+  Z+         19c0 ; [Load A indexed, direct, post-incremented]
         XFRB  AU,AU      19c2 ; [Transfer AU to AU]
         BZ    @W19CB     19c4 ; =+5 [Branch if zero]
         LDB+  A+         19c6 ; [Load B indexed, direct, post-incremented]
         BM    @D19B6     19c8 ; =-20 [Branch on minus]
         LDA+  A          19ca ; [Load A from address in A]
@W19CB   STA=  X'0000'    19cb ; =0x0000 =0 =NUL,NUL [Store A immediate]
         BZ    @D19B6     19ce ; =-26 [Branch if zero]
         LDB   @W19D3+1   19d0 ; =+2 [Load B relative]
         AAB              19d2 ; [A + B -> B]
@W19D3   STB=  OSN9       19d3 ; [external symbol] [Store B immediate]
         LDA/  OSN0+3     19d6 ; [external symbol] [Load A direct]
         LDA+  *A,25      19d9 ; [Load A indexed, displaced, indirect]
         LDA+  A          19dc ; [Load A from address in A]
         SAB              19dd ; [A - B -> B]
         BM    @D19B6     19de ; =-42 [Branch on minus]
         LDX+  X          19e0 ; [Load X indexed, direct]
         CLR   B          19e2 ; [Clear B]
         XFR   Z,A        19e4 ; [Transfer Z to A]
         STA   @W1987+1   19e6 ; =-96 [Store A relative]
@D19E8   LDA+  S+         19e8 ; [Pop A from the stack]
         XAZ              19ea ; [Transfer A to Z]
         LDA/  @W19CB+1   19eb ; =0x19cc =6604 [Load A direct]
         RSR              19ee ; [Return from subroutine]
*
* Function @F19EF
*
@F19EF   LDBB= X'B0'      19ef ; =176(-80) ='0' [Load BL with immediate]
         SABB             19f1 ; [AL - BL -> BL]
         BM    @D19F9     19f2 ; =+5 [Branch on minus]
         LDAB= X'0A'      19f4 ; =10 [Load AL with immediate]
         SUBB  BL,AL      19f6 ; [BL - AL -> AL]
         IVAB             19f8 ; [Invert AL]
@D19F9   RSR              19f9 ; [Return from subroutine]
*
@W19FA   DW    X'0001'    19fa ; =0x0001 =1
         DW    X'0300'    19fc ; =0x0300 =768
         DW    X'0202'    19fe ; =0x0202 =514
*
*
* Function OSN9 (OSNLB4/OSNLB5)
*
*
* Exts:
*   OSN3A
*   OSN3
*   ABRT
*   FLGWT
*   OSN5A
*   SYSBUF
*   WAIT
*   OSN3C
*   OSN0
*   BFWAIT
*   DIV16
*   LOD32
*   DIV32
*   STO32
*   MUL16
*   OSN2
*
OSN9     XFR   Z,B        1a00 ; [Transfer Z to B]
         JSR/  OSN3A      1a02 ; [external symbol] [Jump to subroutine direct]
         LDA+  A,1        1a05 ; [Load A indexed, displaced, direct]
         LDAB= X'09'      1a08 ; =9 [Load AL with immediate]
         SUBB  AU,AL      1a0a ; [AU - AL -> AL]
         BNZ   @D1A13     1a0c ; =+5 [Branch if not zero]
         XFR   Z,B        1a0e ; [Transfer Z to B]
         JSR/  OSN3       1a10 ; [external symbol] [Jump to subroutine direct]
@D1A13   LDAB+ Z,2        1a13 ; [Load AL indexed, displaced, direct]
         LDBB= X'DF'      1a16 ; =223(-33) =DEL [Load BL with immediate]
         NABB             1a18 ; [AL & BL -> BL]
         STBB+ Z,2        1a19 ; [Store BL indexed, displaced, direct]
*
* Function >O9A0A
*
*
>O9A0A   CLAB             1a1c ; [Clear AL]
         JMP/  @J1BF5     1a1d ; =0x1bf5 =7157 [Jump direct]
*
* Function OSN9A (OSNLB4/OSNLB5)
*
* SVC LIOC - logical I/O control
*
*
OSN9A    STX-  S-         1a20 ; [Push X to the stack]
         XFR   Y,A        1a22 ; [Transfer Y to A]
         STA-  S-         1a24 ; [Push A to the stack]
         XFR   Z,A        1a26 ; [Transfer Z to A]
         STA-  S-         1a28 ; [Push A to the stack]
         XFR   B,Z        1a2a ; [Transfer B to Z]
         LDA+  Z,10       1a2c ; [Load A indexed, displaced, direct]
         XFRB  AU,BU      1a2f ; [Transfer AU to BU]
         BNZ   @D1A42     1a31 ; =+15 [Branch if not zero]
         LDBB= X'05'      1a33 ; =5 [Load BL with immediate]
         SAB              1a35 ; [A - B -> B]
         BLE   @D1A3C     1a36 ; =+4 [Branch if less than or equal to zero]
@J1A38   JSR/  ABRT       1a38 ; [external symbol] [Jump to subroutine direct]
         DB    X'0F'      1a3b ; =0x0f =15
*
@D1A3C   SLA              1a3c ; [Left shift A]
         LDB=  @W1ED2     1a3d ; =0x1ed2 =7890 [Load B with immediate]
         AAB              1a40 ; [A + B -> B]
         LDA+  B          1a41 ; [Load A from address in B]
@D1A42   XAX              1a42 ; [Transfer A to X]
         CLA              1a43 ; [Clear A]
         LDAB+ Z,3        1a44 ; [Load AL indexed, displaced, direct]
         BLE   @J1A38     1a47 ; =-17 [Branch if less than or equal to zero]
         LDBB= X'09'      1a49 ; =9 [Load BL with immediate]
         SABB             1a4b ; [AL - BL -> BL]
         BZ    @D1A7B     1a4c ; =+45 [Branch if zero]
         LDBB= X'0A'      1a4e ; =10 [Load BL with immediate]
         SABB             1a50 ; [AL - BL -> BL]
         BZ    OSN9       1a51 ; =-83 [Branch if zero]
         LDBB+ X+         1a53 ; [Load BL indexed, direct, post-incremented]
         SABB             1a55 ; [AL - BL -> BL]
         BGZ   @J1A38     1a56 ; =-32 [Branch if greater than zero]
         DCAB             1a58 ; [Decrement AL]
         SLA              1a59 ; [Left shift A]
         ADD   A,X        1a5a ; [A + X -> X]
         LDA+  X          1a5c ; [Load A from address in X]
         BZ    @J1A38     1a5d ; =-39 [Branch if zero]
         LDB+  Z,2        1a5f ; [Load B indexed, displaced, direct]
         LDBB= X'20'      1a62 ; =32 [Load BL with immediate]
         ANDB  BU,BL      1a64 ; [BU & BL -> BL]
         BNZ   @D1A6B     1a66 ; =+3 [Branch if not zero]
         JSR*  @J1A38+1   1a68 ; =-49 [Jump to subroutine relative indirect]
         DB    X'10'      1a6a ; =0x10 =16
*
@D1A6B   XFR   Z,B        1a6b ; [Transfer Z to B]
         JMP+  A          1a6d ; [Jump indexed, direct]
*
* Function @F1A6F
*
@F1A6F   LDBB+ X+         1a6f ; [Load BL indexed, direct, post-incremented]
         NABB             1a71 ; [AL & BL -> BL]
         BZ    @D1A7A     1a72 ; =+6 [Branch if zero]
         ANDB  BU,BL      1a74 ; [BU & BL -> BL]
         BNZ   @D1A7A     1a76 ; =+2 [Branch if not zero]
         JMP   @D1AB9     1a78 ; =+63 [Jump relative]
@D1A7A   RSR              1a7a ; [Return from subroutine]
*
@D1A7B   XFR   Z,B        1a7b ; [Transfer Z to B]
@P1A7D   JSR/  OSN3A      1a7d ; [external symbol] [Jump to subroutine direct]
         XAX              1a80 ; [Transfer A to X]
         XFR   B,Y        1a81 ; [Transfer B to Y]
         LDAB+ Z,2        1a83 ; [Load AL indexed, displaced, direct]
         LDBB= X'20'      1a86 ; =32 [Load BL with immediate]
         ORIB  AL,BL      1a88 ; [AL | BL -> BL]
         STBB+ Z,2        1a8a ; [Store BL indexed, displaced, direct]
         LDB+  X          1a8d ; [Load B from address in X]
         XFR   Y,Y        1a8e ; [Transfer Y to Y]
         BZ    @D1A95     1a90 ; =+3 [Branch if zero]
         LDB+  Y,14       1a92 ; [Load B indexed, displaced, direct]
@D1A95   JSR   @F1A6F     1a95 ; =-40 [Jump to subroutine relative]
         DB    X'01'      1a97 ; =0x01 =1
*
         JSR   @F1A6F     1a98 ; =-43 [Jump to subroutine relative]
         DB    X'02'      1a9a ; =0x02 =2
         CLA              1a9b ; [Clear A]
         LDAB+ Z,12       1a9c ; [Load AL indexed, displaced, direct]
         BM    @D1AB9     1a9f ; =+24 [Branch on minus]
         LDBB= X'02'      1aa1 ; =2 [Load BL with immediate]
         SABB             1aa3 ; [AL - BL -> BL]
         BGZ   @D1AB9     1aa4 ; =+19 [Branch if greater than zero]
         SLA              1aa6 ; [Left shift A]
         LDB=  @W1EBB     1aa7 ; =0x1ebb =7867 [Load B with immediate]
         AAB              1aaa ; [A + B -> B]
         LDB+  B          1aab ; [Load B from address in B]
         LDA+  X,1        1aac ; [Load A indexed, displaced, direct]
@D1AAF   LDAB+ B+         1aaf ; [Load AL indexed, direct, post-incremented]
         BM    @D1AB9     1ab1 ; =+6 [Branch on minus]
         SUBB  AU,AL      1ab3 ; [AU - AL -> AL]
         BZ    @D1ABD     1ab5 ; =+6 [Branch if zero]
         JMP   @D1AAF     1ab7 ; =-10 [Jump relative]
@D1AB9   JSR/  ABRT       1ab9 ; [external symbol] [Jump to subroutine direct]
         DB    X'11'      1abc ; =0x11 =17
*
@D1ABD   LDAB= X'09'      1abd ; =9 [Load AL with immediate]
         SUBB  AU,AL      1abf ; [AU - AL -> AL]
         BNZ   @D1ACB     1ac1 ; =+8 [Branch if not zero]
         XFR   Z,B        1ac3 ; [Transfer Z to B]
         JSR/  OSN3       1ac5 ; [external symbol] [Jump to subroutine direct]
         JMP/  @J1B53     1ac8 ; =0x1b53 =6995 [Jump direct]
@D1ACB   LDAB+ Z,1        1acb ; [Load AL indexed, displaced, direct]
         BP    @D1AEF     1ace ; =+31 [Branch on plus]
         XFR   Z,B        1ad0 ; [Transfer Z to B]
         JSR*  @P1A7D+1   1ad2 ; =-86 [Jump to subroutine relative indirect]
         XFR   B,Y        1ad4 ; [Transfer B to Y]
         BZ    @J1B53     1ad6 ; =+123 [Branch if zero]
         LDA+  Y,8        1ad8 ; [Load A indexed, displaced, direct]
         STA+  Z,18       1adb ; [Store A indexed, displaced, direct]
         STA+  Z,22       1ade ; [Store A indexed, displaced, direct]
         LDA+  Y,10       1ae1 ; [Load A indexed, displaced, direct]
         STA+  Z,20       1ae4 ; [Store A indexed, displaced, direct]
         STA+  Z,24       1ae7 ; [Store A indexed, displaced, direct]
         JSR/  @F1B3C     1aea ; =0x1b3c =6972 [Jump to subroutine direct]
         JMP   @J1B53     1aed ; =+100 [Jump relative]
@D1AEF   JSR   @F1AF3     1aef ; =+2 [Jump to subroutine relative]
         JMP   @J1B53     1af1 ; =+96 [Jump relative]
*
* Function @F1AF3
*
@F1AF3   XFR   Z,B        1af3 ; [Transfer Z to B]
         JSR*  @P1A7D+1   1af5 ; =-121 [Jump to subroutine relative indirect]
         XFR   B,Y        1af7 ; [Transfer B to Y]
         BZ    @D1B52     1af9 ; =+87 [Branch if zero]
         LDAB+ A,2        1afb ; [Load AL indexed, displaced, direct]
         STAB- S-         1afe ; [Push AL to the stack]
         JSR/  FLGWT      1b00 ; [external symbol] [Jump to subroutine direct]
         DB    X'3B'      1b03 ; =0x3b =59
         LDB+  Y,15       1b04 ; [Load B indexed, displaced, direct]
         STB   @W1B13     1b07 ; =+10 [Store B relative]
         LDB=  X'0001'    1b09 ; =0x0001 =1 [Load B with immediate]
         ADD   Y,B        1b0c ; [Y + B -> B]
         LDAB+ S+         1b0e ; [Pop AL from the stack]
         JSR/  OSN5A      1b10 ; [external symbol] [Jump to subroutine direct]
@W1B13   DW    X'0000'    1b13 ; =0x0000 =0 =NUL,NUL
         DW    SYSBUF     1b15 ; =0x0848 =2120
         BNZ   @D1B1C     1b17 ; =+3 [Branch if not zero]
         JMP/  @J1A38     1b19 ; =0x1a38 =6712 [Jump direct]
@D1B1C   LDB+  A,7        1b1c ; [Load B indexed, displaced, direct]
         STB+  Y,8        1b1f ; [Store B indexed, displaced, direct]
         STB+  Z,18       1b22 ; [Store B indexed, displaced, direct]
         STB+  Z,22       1b25 ; [Store B indexed, displaced, direct]
         LDA+  A,11       1b28 ; [Load A indexed, displaced, direct]
         STA+  Y,10       1b2b ; [Store A indexed, displaced, direct]
         STA+  Z,20       1b2e ; [Store A indexed, displaced, direct]
         STA+  Z,24       1b31 ; [Store A indexed, displaced, direct]
         LDB/  X'005A'    1b34 ; =0x005a =90 [Load B direct]
         LDAB= X'FF'      1b37 ; =255(-1) [Load AL with immediate]
         STAB+ B,59       1b39 ; [Store AL indexed, displaced, direct]
*
* Function @F1B3C
*
@F1B3C   LDAB+ Y,7        1b3c ; [Load AL indexed, displaced, direct]
         LDBB+ Z,13       1b3f ; [Load BL indexed, displaced, direct]
         BM    @D1B4B     1b42 ; =+7 [Branch on minus]
         SABB             1b44 ; [AL - BL -> BL]
         BZ    @D1B4B     1b45 ; =+4 [Branch if zero]
         JSR/  ABRT       1b47 ; [external symbol] [Jump to subroutine direct]
         DB    X'12'      1b4a ; =0x12 =18
*
@D1B4B   LDA+  Z,6        1b4b ; [Load A indexed, displaced, direct]
         BZ    @D1B52     1b4e ; =+2 [Branch if zero]
         JSR   @F1B5C     1b50 ; =+10 [Jump to subroutine relative]
@D1B52   RSR              1b52 ; [Return from subroutine]
*
@J1B53   LDA+  S+         1b53 ; [Pop A from the stack]
         XAZ              1b55 ; [Transfer A to Z]
         LDA+  S+         1b56 ; [Pop A from the stack]
         XAY              1b58 ; [Transfer A to Y]
         LDX+  S+         1b59 ; [Pop X from the stack]
         RSR              1b5b ; [Return from subroutine]
*
* Function @F1B5C
*
@F1B5C   LDA+  Z,22       1b5c ; [Load A indexed, displaced, direct]
         BP    @D1B65     1b5f ; =+4 [Branch on plus]
         LDAB= X'01'      1b61 ; =1 [Load AL with immediate]
         JMP   @D1B77     1b63 ; =+18 [Jump relative]
@D1B65   STA+  Z,18       1b65 ; [Store A indexed, displaced, direct]
         STA+  Z,8        1b68 ; [Store A indexed, displaced, direct]
         JSR   @F1B82     1b6b ; =+21 [Jump to subroutine relative]
         DB    X'01'      1b6d ; =0x01 =1
         LDB+  Z,6        1b6e ; [Load B indexed, displaced, direct]
         LDB+  B,3        1b71 ; [Load B indexed, displaced, direct]
         STB+  Z,22       1b74 ; [Store B indexed, displaced, direct]
@D1B77   STAB+ Z          1b77 ; [Store AL to address in Z]
         RSR              1b78 ; [Return from subroutine]
*
* Function @F1B79
*
@F1B79   LDAB+ Z          1b79 ; [Load AL from address in Z]
         BP    @D1B81     1b7a ; =+5 [Branch on plus]
         JSR/  WAIT       1b7c ; [external symbol] [Jump to subroutine direct]
         JMP   @F1B79     1b7f ; =-8 [Jump relative]
@D1B81   RSR              1b81 ; [Return from subroutine]
*
* Function @F1B82
*
@F1B82   LDAB+ X+         1b82 ; [Load AL indexed, direct, post-incremented]
         STAB+ Z,3        1b84 ; [Store AL indexed, displaced, direct]
*
* Function @F1B87
*
@F1B87   XFR   Z,B        1b87 ; [Transfer Z to B]
         JSR/  OSN3       1b89 ; [external symbol] [Jump to subroutine direct]
         JSR   @F1B79     1b8c ; =-21 [Jump to subroutine relative]
         RSR              1b8e ; [Return from subroutine]
*
* Function >O9A00
*
*
>O9A00   LDAB= X'01'      1b8f ; =1 [Load AL with immediate]
         JMP   @D1B95     1b91 ; =+2 [Jump relative]
*
* Function >O9A01
*
*
>O9A01   LDAB= X'02'      1b93 ; =2 [Load AL with immediate]
@D1B95   STAB+ Z,3        1b95 ; [Store AL indexed, displaced, direct]
         LDA+  Z,14       1b98 ; [Load A indexed, displaced, direct]
         STA+  Z,4        1b9b ; [Store A indexed, displaced, direct]
         LDA+  Z,16       1b9e ; [Load A indexed, displaced, direct]
         STA+  Z,6        1ba1 ; [Store A indexed, displaced, direct]
         JSR/  OSN3C      1ba4 ; [external symbol] [Jump to subroutine direct]
         JSR   @F1B79     1ba7 ; =-48 [Jump to subroutine relative]
         CLA              1ba9 ; [Clear A]
         STA+  Z,6        1baa ; [Store A indexed, displaced, direct]
         JMP   @J1B53     1bad ; =-92 [Jump relative]
*
* Function >O9A10
*
*
>O9A10   JSR/  @F1E24     1baf ; =0x1e24 =7716 [Jump to subroutine direct]
         XAX              1bb2 ; [Transfer A to X]
         LDA=  X'8401'    1bb3 ; =0x8401 =33793(-31743) [Load A with immediate]
         LDBB+ Y+         1bb6 ; [Load BL indexed, direct, post-incremented]
         SUBB  BL,AU      1bb8 ; [BL - AU -> AU]
         BZ    @J1BF5     1bba ; =+57 [Branch if zero]
         LDAB= X'8D'      1bbc ; =141(-115) =CR [Load AL with immediate]
         SABB             1bbe ; [AL - BL -> BL]
         BNZ   @D1BCB     1bbf ; =+10 [Branch if not zero]
         JSR   @F1B5C     1bc1 ; =-103 [Jump to subroutine relative]
         BNZ   @J1BF5     1bc3 ; =+48 [Branch if not zero]
         CLA              1bc5 ; [Clear A]
         STA+  Z,24       1bc6 ; [Store A indexed, displaced, direct]
         JMP   >O9A10     1bc9 ; =-28 [Jump relative]
@D1BCB   LDBB+ Y+         1bcb ; [Load BL indexed, direct, post-incremented]
         SABB             1bcd ; [AL - BL -> BL]
         BNZ   @D1BCB     1bce ; =-5 [Branch if not zero]
         XFR   X,A        1bd0 ; [Transfer X to A]
         SUB   Y,X        1bd2 ; [Y - X -> X]
         XAY              1bd4 ; [Transfer A to Y]
         LDA+  Z,24       1bd5 ; [Load A indexed, displaced, direct]
         ADD   X,A        1bd8 ; [X + A -> A]
         STA+  Z,24       1bda ; [Store A indexed, displaced, direct]
         DCX              1bdd ; [Decrement X]
@J1BDE   LDA+  Z,14       1bde ; [Load A indexed, displaced, direct]
         XAB              1be1 ; [Transfer A to B]
         SUB   X,B        1be2 ; [X - B -> B]
         BLE   @D1BE7     1be4 ; =+1 [Branch if less than or equal to zero]
         XAX              1be6 ; [Transfer A to X]
@D1BE7   LDB+  Z,16       1be7 ; [Load B indexed, displaced, direct]
         STX+  B+         1bea ; [Store X indexed, direct, post-incremented]
@D1BEC   LDAB+ Y+         1bec ; [Load AL indexed, direct, post-incremented]
         STAB+ B+         1bee ; [Store AL indexed, direct, post-incremented]
         DCX              1bf0 ; [Decrement X]
         BGZ   @D1BEC     1bf1 ; =-7 [Branch if greater than zero]
         CLAB             1bf3 ; [Clear AL]
         STAB+ B          1bf4 ; [Store AL to address in B]
@J1BF5   STAB+ Z          1bf5 ; [Store AL to address in Z]
         JMP/  @J1B53     1bf6 ; =0x1b53 =6995 [Jump direct]
*
* Function >O9A11
*
*
>O9A11   CLAB             1bf9 ; [Clear AL]
         LDX+  Z,16       1bfa ; [Load X indexed, displaced, direct]
         LDB+  X          1bfd ; [Load B from address in X]
         BLE   @J1BF5     1bfe ; =-11 [Branch if less than or equal to zero]
         JSR/  @F1E35     1c00 ; =0x1e35 =7733 [Jump to subroutine direct]
         LDB+  X          1c03 ; [Load B from address in X]
         AAB              1c04 ; [A + B -> B]
         STB+  Z,24       1c05 ; [Store B indexed, displaced, direct]
         LDA=  X'018A'    1c08 ; =0x018a =394 [Load A with immediate]
         SAB              1c0b ; [A - B -> B]
         BP    @D1C18     1c0c ; =+10 [Branch on plus]
         LDAB= X'8D'      1c0e ; =141(-115) =CR [Load AL with immediate]
         STAB+ Y          1c10 ; [Store AL to address in Y]
         JSR/  @F1E54     1c11 ; =0x1e54 =7764 [Jump to subroutine direct]
         BZ    >O9A11     1c14 ; =-29 [Branch if zero]
@D1C16   JMP   @J1BF5     1c16 ; =-35 [Jump relative]
@D1C18   LDA+  X+         1c18 ; [Load A indexed, direct, post-incremented]
@D1C1A   LDBB+ X+         1c1a ; [Load BL indexed, direct, post-incremented]
         STBB+ Y+         1c1c ; [Store BL indexed, direct, post-incremented]
         DCA              1c1e ; [Decrement A]
         BGZ   @D1C1A     1c1f ; =-7 [Branch if greater than zero]
         LDBB= X'8D'      1c21 ; =141(-115) =CR [Load BL with immediate]
         STBB+ Y          1c23 ; [Store BL to address in Y]
         JMP   @D1C16     1c24 ; =-16 [Jump relative]
*
* Function >O9A12
*
*
>O9A12   LDX+  Z,16       1c26 ; [Load X indexed, displaced, direct]
         LDA+  Z,6        1c29 ; [Load A indexed, displaced, direct]
         XAY              1c2c ; [Transfer A to Y]
         LDA+  Z,20       1c2d ; [Load A indexed, displaced, direct]
         LDB=  X'0007'    1c30 ; =0x0007 =7 [Load B with immediate]
         AAB              1c33 ; [A + B -> B]
         ADD   B,Y        1c34 ; [B + Y -> Y]
         LDB=  X'8D00'    1c36 ; =0x8d00 =36096(-29440) =CR,NUL [Load B with immediate]
         LDA+  X+         1c39 ; [Load A indexed, direct, post-incremented]
@D1C3B   LDBB+ Y          1c3b ; [Load BL from address in Y]
         SUBB  BU,BL      1c3c ; [BU - BL -> BL]
         BZ    @D1C57     1c3e ; =+23 [Branch if zero]
         DCA              1c40 ; [Decrement A]
         BM    @D1C4E     1c41 ; =+11 [Branch on minus]
         LDBB+ X          1c43 ; [Load BL from address in X]
         SUBB  BU,BL      1c44 ; [BU - BL -> BL]
         BZ    @D1C4E     1c46 ; =+6 [Branch if zero]
         LDBB+ X+         1c48 ; [Load BL indexed, direct, post-incremented]
         STBB+ Y+         1c4a ; [Store BL indexed, direct, post-incremented]
         JMP   @D1C3B     1c4c ; =-19 [Jump relative]
@D1C4E   LDAB= X'A0'      1c4e ; =160(-96) =' ' [Load AL with immediate]
         STAB+ Y+         1c50 ; [Store AL indexed, direct, post-incremented]
         LDBB+ Y          1c52 ; [Load BL from address in Y]
         SUBB  BU,BL      1c53 ; [BU - BL -> BL]
         BNZ   @D1C4E     1c55 ; =-9 [Branch if not zero]
@D1C57   LDA+  Z,18       1c57 ; [Load A indexed, displaced, direct]
         STA+  Z,8        1c5a ; [Store A indexed, displaced, direct]
         JSR/  @F1B82     1c5d ; =0x1b82 =7042 [Jump to subroutine direct]
         DB    X'02'      1c60 ; =0x02 =2
         JMP   @J1BF5     1c61 ; =-110 [Jump relative]
*
* Function >O9A20
*
*
>O9A20   CLAB             1c63 ; [Clear AL]
         STAB- S-         1c64 ; [Push AL to the stack]
         JSR   @F1CC5     1c66 ; =+93 [Jump to subroutine relative]
         JMP   @D1C70     1c68 ; =+6 [Jump relative]
*
* Function >O9A30
*
*
>O9A30   LDAB= X'01'      1c6a ; =1 [Load AL with immediate]
         STAB- S-         1c6c ; [Push AL to the stack]
         JSR   @F1CD8     1c6e ; =+104 [Jump to subroutine relative]
@D1C70   BZ    @D1C83     1c70 ; =+17 [Branch if zero]
@D1C72   LDBB+ S+         1c72 ; [Pop BL from the stack]
         BNZ   @D1C80     1c74 ; =+10 [Branch if not zero]
         LDBB= X'FF'      1c76 ; =255(-1) [Load BL with immediate]
         STBB/ OSN0+59    1c78 ; [external symbol] [Store BL direct]
         CLR   B          1c7b ; [Clear B]
         STB+  Z,6        1c7d ; [Store B indexed, displaced, direct]
@D1C80   JMP/  @J1BF5     1c80 ; =0x1bf5 =7157 [Jump direct]
@D1C83   LDX+  Z,14       1c83 ; [Load X indexed, displaced, direct]
         STX+  Y+         1c86 ; [Store X indexed, direct, post-incremented]
@D1C88   LDAB+ B+         1c88 ; [Load AL indexed, direct, post-incremented]
         STAB+ Y+         1c8a ; [Store AL indexed, direct, post-incremented]
         DCX              1c8c ; [Decrement X]
         BGZ   @D1C88     1c8d ; =-7 [Branch if greater than zero]
         CLAB             1c8f ; [Clear AL]
         STAB+ Y          1c90 ; [Store AL to address in Y]
         JMP   @D1C72     1c91 ; =-33 [Jump relative]
*
* Function >O9A21
*
*
>O9A21   CLAB             1c93 ; [Clear AL]
         STAB- S-         1c94 ; [Push AL to the stack]
         JSR   @F1CC5     1c96 ; =+45 [Jump to subroutine relative]
         JMP   >O9A32     1c98 ; =+6 [Jump relative]
*
* Function >O9A31
*
*
>O9A31   LDAB= X'01'      1c9a ; =1 [Load AL with immediate]
         STAB- S-         1c9c ; [Push AL to the stack]
         JSR   @F1CD8     1c9e ; =+56 [Jump to subroutine relative]
*
* Function >O9A32
*
*
>O9A32   BNZ   @D1CC1     1ca0 ; =+31 [Branch if not zero]
         LDA+  Y+         1ca2 ; [Load A indexed, direct, post-incremented]
         LDX+  Z,14       1ca4 ; [Load X indexed, displaced, direct]
         BZ    @D1CB0     1ca7 ; =+7 [Branch if zero]
         LDA=  X'018B'    1ca9 ; =0x018b =395 [Load A with immediate]
         SUB   X,A        1cac ; [X - A -> A]
         BLE   @D1CB4     1cae ; =+4 [Branch if less than or equal to zero]
@D1CB0   LDAB= X'05'      1cb0 ; =5 [Load AL with immediate]
         JMP   @D1C72     1cb2 ; =-66 [Jump relative]
@D1CB4   LDAB+ Y+         1cb4 ; [Load AL indexed, direct, post-incremented]
         STAB+ B+         1cb6 ; [Store AL indexed, direct, post-incremented]
         DCX              1cb8 ; [Decrement X]
         BGZ   @D1CB4     1cb9 ; =-7 [Branch if greater than zero]
         JSR/  @F1B82     1cbb ; =0x1b82 =7042 [Jump to subroutine direct]
         DB    X'02'      1cbe ; =0x02 =2
         JMP   @D1C72     1cbf ; =-79 [Jump relative]
@D1CC1   LDAB= X'02'      1cc1 ; =2 [Load AL with immediate]
         JMP   @D1C72     1cc3 ; =-83 [Jump relative]
*
* Function @F1CC5
*
@F1CC5   JSR   @F1D04     1cc5 ; =+61 [Jump to subroutine relative]
         LDA/  OSN0+29    1cc7 ; [external symbol] [Load A direct]
         STA+  Z,6        1cca ; [Store A indexed, displaced, direct]
         LDA=  X'0190'    1ccd ; =0x0190 =400 [Load A with immediate]
         STA+  Z,4        1cd0 ; [Store A indexed, displaced, direct]
         JSR/  BFWAIT     1cd3 ; [external symbol] [Jump to subroutine direct]
         JMP   @D1CE3     1cd6 ; =+11 [Jump relative]
*
* Function @F1CD8
*
@F1CD8   JSR   @F1D04     1cd8 ; =+42 [Jump to subroutine relative]
         LDA+  Z,18       1cda ; [Load A indexed, displaced, direct]
         LDB+  Z,22       1cdd ; [Load B indexed, displaced, direct]
         SAB              1ce0 ; [A - B -> B]
         BZ    @D1CE8     1ce1 ; =+5 [Branch if zero]
@D1CE3   JSR/  @F1B5C     1ce3 ; =0x1b5c =7004 [Jump to subroutine direct]
         BNZ   @D1CFB     1ce6 ; =+19 [Branch if not zero]
@D1CE8   LDA+  Z,16       1ce8 ; [Load A indexed, displaced, direct]
         XAY              1ceb ; [Transfer A to Y]
         LDA+  Z,6        1cec ; [Load A indexed, displaced, direct]
         LDB=  X'0007'    1cef ; =0x0007 =7 [Load B with immediate]
         AAB              1cf2 ; [A + B -> B]
         LDA+  Z,24       1cf3 ; [Load A indexed, displaced, direct]
         STA+  Z,20       1cf6 ; [Store A indexed, displaced, direct]
         AAB              1cf9 ; [A + B -> B]
         CLA              1cfa ; [Clear A]
@D1CFB   RSR              1cfb ; [Return from subroutine]
*
@W1CFC   DS    2          1cfc ; [Uninitialized memory]
@W1CFE   DS    2          1cfe ; [Uninitialized memory]
@W1D00   DW    X'0000'    1d00 ; =0x0000 =0 =NUL,NUL
@W1D02   DW    X'0000'    1d02 ; =0x0000 =0 =NUL,NUL
*
*
* Function @F1D04
*
@F1D04   XFR   Y,A        1d04 ; [Transfer Y to A]
         STA-  S-         1d06 ; [Push A to the stack]
         XFR   Z,A        1d08 ; [Transfer Z to A]
         STA-  S-         1d0a ; [Push A to the stack]
         LDA=  X'018B'    1d0c ; =0x018b =395 [Load A with immediate]
         LDB+  Z,28       1d0f ; [Load B indexed, displaced, direct]
         JSR/  DIV16      1d12 ; [external symbol] [Jump to subroutine direct]
         STB   @W1D02     1d15 ; =-21 [Store B relative]
         BNZ   @D1D1D     1d17 ; =+4 [Branch if not zero]
         DCR   B          1d19 ; [Decrement B by 1]
         JMP   @D1D34     1d1b ; =+23 [Jump relative]
@D1D1D   JSR   @F1D74     1d1d ; =+85 [Jump to subroutine relative]
         STA   @W1CFC     1d1f ; =-37 [Store A relative]
         STB   @W1CFE     1d21 ; =-37 [Store B relative]
         JSR/  LOD32      1d23 ; [external symbol] [Jump to subroutine direct]
         DW    @W1CFC     1d26 ; =0x1cfc =7420
*
         JSR/  DIV32      1d28 ; [external symbol] [Jump to subroutine direct]
         DW    @W1D00     1d2b ; =0x1d00 =7424
*
         JSR/  STO32      1d2d ; [external symbol] [Jump to subroutine direct]
         DW    @W1CFC     1d30 ; =0x1cfc =7420
         LDB   @W1CFE     1d32 ; =-54 [Load B relative]
@D1D34   LDA+  S+         1d34 ; [Pop A from the stack]
         XAZ              1d36 ; [Transfer A to Z]
         LDA+  S          1d37 ; [Load A from address in S]
         STB+  S          1d38 ; [Store B to address in S]
         XFR   Y,B        1d39 ; [Transfer Y to B]
         XAY              1d3b ; [Transfer A to Y]
         LDA+  Z,28       1d3c ; [Load A indexed, displaced, direct]
         JSR/  MUL16      1d3f ; [external symbol] [Jump to subroutine direct]
         STB+  Z,24       1d42 ; [Store B indexed, displaced, direct]
         LDB+  S+         1d45 ; [Pop B from the stack]
@D1D47   STX-  S-         1d47 ; [Push X to the stack]
         XFR   B,X        1d49 ; [Transfer B to X]
         BM    @D1D66     1d4b ; =+25 [Branch on minus]
         XFR   Z,B        1d4d ; [Transfer Z to B]
@P1D4F   JSR/  OSN3A      1d4f ; [external symbol] [Jump to subroutine direct]
         LDA+  B,8        1d52 ; [Load A indexed, displaced, direct]
         ADD   X,A        1d55 ; [X + A -> A]
         STA+  Z,22       1d57 ; [Store A indexed, displaced, direct]
         XFR   X,A        1d5a ; [Transfer X to A]
         SRA              1d5c ; [Arithmetic right shift A]
         SRA              1d5d ; [Arithmetic right shift A]
         SRA              1d5e ; [Arithmetic right shift A]
         SRA              1d5f ; [Arithmetic right shift A]
         LDB+  B,12       1d60 ; [Load B indexed, displaced, direct]
         SAB              1d63 ; [A - B -> B]
         BM    @D1D71     1d64 ; =+11 [Branch on minus]
@D1D66   CLA              1d66 ; [Clear A]
         DCA              1d67 ; [Decrement A]
         STA+  Z,22       1d68 ; [Store A indexed, displaced, direct]
         LDAB= X'01'      1d6b ; =1 [Load AL with immediate]
@D1D6D   LDX+  S+         1d6d ; [Pop X from the stack]
         STAB+ Z          1d6f ; [Store AL to address in Z]
         RSR              1d70 ; [Return from subroutine]
*
@D1D71   CLAB             1d71 ; [Clear AL]
         JMP   @D1D6D     1d72 ; =-7 [Jump relative]
*
* Function @F1D74
*
@F1D74   LDB+  Z,26       1d74 ; [Load B indexed, displaced, direct]
         LDA+  B+         1d77 ; [Load A indexed, direct, post-incremented]
         LDB+  B          1d79 ; [Load B from address in B]
         RSR              1d7a ; [Return from subroutine]
*
* Function @F1D7B
*
@F1D7B   JSR   @F1D74     1d7b ; =-9 [Jump to subroutine relative]
         JMP   @D1D47     1d7d ; =-56 [Jump relative]
*
* Function >O9A50
*
*
>O9A50   JSR   @F1D7B     1d7f ; =-6 [Jump to subroutine relative]
         BNZ   @D1D8F     1d81 ; =+12 [Branch if not zero]
         LDA+  Z,22       1d83 ; [Load A indexed, displaced, direct]
         STA+  Z,18       1d86 ; [Store A indexed, displaced, direct]
         STA+  Z,8        1d89 ; [Store A indexed, displaced, direct]
         JSR/  @F1B87     1d8c ; =0x1b87 =7047 [Jump to subroutine direct]
@D1D8F   JMP/  @J1BF5     1d8f ; =0x1bf5 =7157 [Jump direct]
*
* Function >O9A36
*
*
>O9A36   JSR/  @F1D04     1d92 ; =0x1d04 =7428 [Jump to subroutine direct]
         JMP   @D1D9E     1d95 ; =+7 [Jump relative]
*
* Function >O9A37
*
*
>O9A37   JSR/  @F1D04     1d97 ; =0x1d04 =7428 [Jump to subroutine direct]
         JMP   @D1DA4     1d9a ; =+8 [Jump relative]
*
* Function >O9A56
*
*
>O9A56   JSR   @F1D7B     1d9c ; =-35 [Jump to subroutine relative]
@D1D9E   LDBB= X'12'      1d9e ; =18 [Load BL with immediate]
         JMP   @D1DA6     1da0 ; =+4 [Jump relative]
*
* Function >O9A57
*
*
>O9A57   JSR   @F1D7B     1da2 ; =-41 [Jump to subroutine relative]
@D1DA4   LDBB= X'13'      1da4 ; =19 [Load BL with immediate]
@D1DA6   STBB  @B1DB8     1da6 ; =+16 [Store BL relative]
         XABB             1da8 ; [Transfer AL to BL]
         BNZ   @D1DB9     1da9 ; =+14 [Branch if not zero]
         XFR   Z,B        1dab ; [Transfer Z to B]
         JSR*  @P1D4F+1   1dad ; =-95 [Jump to subroutine relative indirect]
         LDAB+ A,2        1daf ; [Load AL indexed, displaced, direct]
         LDB+  Z,22       1db2 ; [Load B indexed, displaced, direct]
         JSR$  X'005A'    1db5 ; =0x005a =90 [Jump to subroutine indirect]
@B1DB8   DB    X'00'      1db8 ; =0x00 =0 =NUL
*
@D1DB9   JMP   @D1D8F     1db9 ; =-44 [Jump relative]
@D1DBB   CLA              1dbb ; [Clear A]
         STA+  Z,24       1dbc ; [Store A indexed, displaced, direct]
*
* Function >O9A40
*
*
>O9A40   JSR   @F1E24     1dbf ; =+99 [Jump to subroutine relative]
         LDA+  Y+         1dc1 ; [Load A indexed, direct, post-incremented]
         BP    @D1DCF     1dc3 ; =+10 [Branch on plus]
         JSR/  @F1B5C     1dc5 ; =0x1b5c =7004 [Jump to subroutine direct]
         BZ    @D1DBB     1dc8 ; =-15 [Branch if zero]
@D1DCA   LDAB= X'01'      1dca ; =1 [Load AL with immediate]
@D1DCC   JMP/  @J1BF5     1dcc ; =0x1bf5 =7157 [Jump direct]
@D1DCF   XAX              1dcf ; [Transfer A to X]
         DCA              1dd0 ; [Decrement A]
         DCA              1dd1 ; [Decrement A]
         BGZ   @D1DDC     1dd2 ; =+8 [Branch if greater than zero]
         LDA=  X'8401'    1dd4 ; =0x8401 =33793(-31743) [Load A with immediate]
         LDBB+ Y          1dd7 ; [Load BL from address in Y]
         SUBB  AU,BL      1dd8 ; [AU - BL -> BL]
         BZ    @D1DCA     1dda ; =-18 [Branch if zero]
@D1DDC   LDA+  Z,24       1ddc ; [Load A indexed, displaced, direct]
         INA              1ddf ; [Increment A]
         INA              1de0 ; [Increment A]
         ADD   X,A        1de1 ; [X + A -> A]
         STA+  Z,24       1de3 ; [Store A indexed, displaced, direct]
         JMP/  @J1BDE     1de6 ; =0x1bde =7134 [Jump direct]
*
* Function >O9A41
*
*
>O9A41   LDX+  Z,16       1de9 ; [Load X indexed, displaced, direct]
         LDA+  X          1dec ; [Load A from address in X]
         BLE   @D1DF5     1ded ; =+6 [Branch if less than or equal to zero]
         LDB=  X'0188'    1def ; =0x0188 =392 [Load B with immediate]
         SAB              1df2 ; [A - B -> B]
         BLE   @D1DF9     1df3 ; =+4 [Branch if less than or equal to zero]
@D1DF5   LDAB= X'05'      1df5 ; =5 [Load AL with immediate]
@D1DF7   JMP   @D1DCC     1df7 ; =-45 [Jump relative]
@D1DF9   JSR   @F1E35     1df9 ; =+58 [Jump to subroutine relative]
         LDB+  X          1dfb ; [Load B from address in X]
         INA              1dfc ; [Increment A]
         INA              1dfd ; [Increment A]
         AAB              1dfe ; [A + B -> B]
         STB+  Z,24       1dff ; [Store B indexed, displaced, direct]
         LDA=  X'018A'    1e02 ; =0x018a =394 [Load A with immediate]
         SAB              1e05 ; [A - B -> B]
         BP    @D1E11     1e06 ; =+9 [Branch on plus]
         LDAB= X'FF'      1e08 ; =255(-1) [Load AL with immediate]
         STAB+ Y          1e0a ; [Store AL to address in Y]
         JSR   @F1E54     1e0b ; =+71 [Jump to subroutine relative]
         BZ    >O9A41     1e0d ; =-38 [Branch if zero]
         JMP   @D1DF7     1e0f ; =-26 [Jump relative]
@D1E11   LDA+  X+         1e11 ; [Load A indexed, direct, post-incremented]
         STA+  Y+         1e13 ; [Store A indexed, direct, post-incremented]
@D1E15   BLE   @D1E1E     1e15 ; =+7 [Branch if less than or equal to zero]
         LDBB+ X+         1e17 ; [Load BL indexed, direct, post-incremented]
         STBB+ Y+         1e19 ; [Store BL indexed, direct, post-incremented]
         DCA              1e1b ; [Decrement A]
         JMP   @D1E15     1e1c ; =-9 [Jump relative]
@D1E1E   CLAB             1e1e ; [Clear AL]
         DCAB             1e1f ; [Decrement AL]
         STAB+ Y          1e20 ; [Store AL to address in Y]
         CLAB             1e21 ; [Clear AL]
         JMP   @D1DF7     1e22 ; =-45 [Jump relative]
*
* Function @F1E24
*
@F1E24   LDA+  Z,6        1e24 ; [Load A indexed, displaced, direct]
@W1E27   LDB=  X'0007'    1e27 ; =0x0007 =7 [Load B with immediate]
         AAB              1e2a ; [A + B -> B]
         LDA+  Z,24       1e2b ; [Load A indexed, displaced, direct]
         STA+  Z,20       1e2e ; [Store A indexed, displaced, direct]
         ADD   B,A        1e31 ; [B + A -> A]
         XAY              1e33 ; [Transfer A to Y]
         RSR              1e34 ; [Return from subroutine]
*
* Function @F1E35
*
@F1E35   LDA+  Z,6        1e35 ; [Load A indexed, displaced, direct]
         XAY              1e38 ; [Transfer A to Y]
         LDA+  Z,24       1e39 ; [Load A indexed, displaced, direct]
         STA+  Z,20       1e3c ; [Store A indexed, displaced, direct]
         LDB   @W1E27+1   1e3f ; =-25 [Load B relative]
         AAB              1e41 ; [A + B -> B]
         ADD   B,Y        1e42 ; [B + Y -> Y]
         RSR              1e44 ; [Return from subroutine]
*
* Function @F1E45
*
@F1E45   CLA              1e45 ; [Clear A]
         STA+  Z,24       1e46 ; [Store A indexed, displaced, direct]
         LDA+  Z,18       1e49 ; [Load A indexed, displaced, direct]
         STA+  Z,8        1e4c ; [Store A indexed, displaced, direct]
         JSR/  @F1B82     1e4f ; =0x1b82 =7042 [Jump to subroutine direct]
         DB    X'02'      1e52 ; =0x02 =2
         RSR              1e53 ; [Return from subroutine]
*
* Function @F1E54
*
@F1E54   JSR   @F1E45     1e54 ; =-17 [Jump to subroutine relative]
         BNZ   @D1E81     1e56 ; =+41 [Branch if not zero]
@D1E58   JSR/  @F1B5C     1e58 ; =0x1b5c =7004 [Jump to subroutine direct]
         BZ    @D1E81     1e5b ; =+36 [Branch if zero]
         LDBB= X'01'      1e5d ; =1 [Load BL with immediate]
         SABB             1e5f ; [AL - BL -> BL]
         BNZ   @D1E81     1e60 ; =+31 [Branch if not zero]
         LDB+  Z,18       1e62 ; [Load B indexed, displaced, direct]
         STB   @W1E76     1e65 ; =+15 [Store B relative]
         XFR   Z,B        1e67 ; [Transfer Z to B]
@P1E69   JSR/  OSN3A      1e69 ; [external symbol] [Jump to subroutine direct]
         XFR   B,B        1e6c ; [Transfer B to B]
         BM    @D1E82     1e6e ; =+18 [Branch on minus]
         LDAB+ A,2        1e70 ; [Load AL indexed, displaced, direct]
         JSR/  OSN2       1e73 ; [external symbol] [Jump to subroutine direct]
@W1E76   DW    X'0000'    1e76 ; =0x0000 =0 =NUL,NUL
         XFR   B,B        1e78 ; [Transfer B to B]
         BM    @D1E82     1e7a ; =+6 [Branch on minus]
         STB+  Z,22       1e7c ; [Store B indexed, displaced, direct]
         JMP   @D1E58     1e7f ; =-41 [Jump relative]
@D1E81   RSR              1e81 ; [Return from subroutine]
*
@D1E82   LDAB= X'02'      1e82 ; =2 [Load AL with immediate]
         RSR              1e84 ; [Return from subroutine]
*
* Function >O9A1A
*
*
>O9A1A   JSR   @F1E45     1e85 ; =-66 [Jump to subroutine relative]
         JMP/  @J1BF5     1e87 ; =0x1bf5 =7157 [Jump direct]
*
* Function >O9A03
*
*
>O9A03   JSR*  @P1E69+1   1e8a ; =-34 [Jump to subroutine relative indirect]
         XFR   B,B        1e8c ; [Transfer B to B]
         BZ    @D1E96     1e8e ; =+6 [Branch if zero]
*
* Function >O9A13
*
*
>O9A13   JSR/  @F1AF3     1e90 ; =0x1af3 =6899 [Jump to subroutine direct]
@D1E93   JMP/  @J1B53     1e93 ; =0x1b53 =6995 [Jump direct]
@D1E96   JSR/  @F1B82     1e96 ; =0x1b82 =7042 [Jump to subroutine direct]
         DB    X'04'      1e99 ; =0x04 =4
         JMP   @D1E93     1e9a ; =-9 [Jump relative]
*
* Function >O9A14
*
*
>O9A14   LDB+  Z,8        1e9c ; [Load B indexed, displaced, direct]
         LDA+  Z,18       1e9f ; [Load A indexed, displaced, direct]
         STA+  B+         1ea2 ; [Store A indexed, direct, post-incremented]
         LDA+  Z,20       1ea4 ; [Load A indexed, displaced, direct]
         STA+  B          1ea7 ; [Store A to address in B]
         JMP   @D1E93     1ea8 ; =-23 [Jump relative]
*
* Function >O9A15
*
*
>O9A15   LDB+  Z,8        1eaa ; [Load B indexed, displaced, direct]
         LDA+  B+         1ead ; [Load A indexed, direct, post-incremented]
         STA+  Z,22       1eaf ; [Store A indexed, displaced, direct]
         LDA+  B          1eb2 ; [Load A from address in B]
         STA+  Z,24       1eb3 ; [Store A indexed, displaced, direct]
         JSR/  @F1B5C     1eb6 ; =0x1b5c =7004 [Jump to subroutine direct]
         JMP   @D1E93     1eb9 ; =-40 [Jump relative]
*
@W1EBB   DW    @W1EC1     1ebb ; =0x1ec1 =7873
         DW    @W1EC5     1ebd ; =0x1ec5 =7877
         DW    @W1ED0     1ebf ; =0x1ed0 =7888
@W1EC1   DW    X'0001'    1ec1 ; =0x0001 =1
         DW    X'02FF'    1ec3 ; =0x02ff =767
@W1EC5   DW    X'0900'    1ec5 ; =0x0900 =2304
         DW    X'0102'    1ec7 ; =0x0102 =258
         DW    X'0304'    1ec9 ; =0x0304 =772
         DW    X'0607'    1ecb ; =0x0607 =1543
         DW    X'0508'    1ecd ; =0x0508 =1288
         DB    X'FF'      1ecf ; =0xff =255(-1)
@W1ED0   DW    X'04FF'    1ed0 ; =0x04ff =1279
@W1ED2   DW    @W1EDE     1ed2 ; =0x1ede =7902
         DW    @W1EF5     1ed4 ; =0x1ef5 =7925
         DW    @W1F0C     1ed6 ; =0x1f0c =7948
         DW    @W1F1D     1ed8 ; =0x1f1d =7965
         DW    @W1F2E     1eda ; =0x1f2e =7982
         DW    @W1F45     1edc ; =0x1f45 =8005
@W1EDE   DB    X'0B'      1ede ; =0x0b =11
         DW    >O9A00     1edf ; =0x1b8f =7055
         DW    >O9A01     1ee1 ; =0x1b93 =7059
         DW    X'0000'    1ee3 ; =0x0000 =0 =NUL,NUL
         DW    >O9A03     1ee5 ; =0x1e8a =7818
         DB    0,12       1ee7 ; =0x00,0x000c
         DW    >O9A0A     1ef3 ; =0x1a1c =6684
@W1EF5   DB    X'0B'      1ef5 ; =0x0b =11
         DW    >O9A10     1ef6 ; =0x1baf =7087
         DW    >O9A11     1ef8 ; =0x1bf9 =7161
         DW    >O9A12     1efa ; =0x1c26 =7206
         DW    >O9A13     1efc ; =0x1e90 =7824
         DW    >O9A14     1efe ; =0x1e9c =7836
         DW    >O9A15     1f00 ; =0x1eaa =7850
         DB    0,8        1f02 ; =0x00,0x0008
         DW    >O9A1A     1f0a ; =0x1e85 =7813
@W1F0C   DB    X'08'      1f0c ; =0x08 =8
         DW    >O9A20     1f0d ; =0x1c63 =7267
         DW    >O9A21     1f0f ; =0x1c93 =7315
         DW    >O9A21     1f11 ; =0x1c93 =7315
         DB    0,6        1f13 ; =0x00,0x0006
         DW    >O9A36     1f19 ; =0x1d92 =7570
         DW    >O9A37     1f1b ; =0x1d97 =7575
@W1F1D   DB    X'08'      1f1d ; =0x08 =8
         DW    >O9A30     1f1e ; =0x1c6a =7274
         DW    >O9A31     1f20 ; =0x1c9a =7322
         DW    >O9A32     1f22 ; =0x1ca0 =7328
         DB    0,6        1f24 ; =0x00,0x0006
         DW    >O9A36     1f2a ; =0x1d92 =7570
         DW    >O9A37     1f2c ; =0x1d97 =7575
@W1F2E   DB    X'0B'      1f2e ; =0x0b =11
         DW    >O9A40     1f2f ; =0x1dbf =7615
         DW    >O9A41     1f31 ; =0x1de9 =7657
         DW    X'0000'    1f33 ; =0x0000 =0 =NUL,NUL
         DW    >O9A13     1f35 ; =0x1e90 =7824
         DW    >O9A14     1f37 ; =0x1e9c =7836
         DW    >O9A15     1f39 ; =0x1eaa =7850
         DB    0,8        1f3b ; =0x00,0x0008
         DW    >O9A1A     1f43 ; =0x1e85 =7813
@W1F45   DB    X'08'      1f45 ; =0x08 =8
         DW    >O9A50     1f46 ; =0x1d7f =7551
         DW    >O9A50     1f48 ; =0x1d7f =7551
         DB    0,8        1f4a ; =0x00,0x0008
         DW    >O9A56     1f52 ; =0x1d9c =7580
         DW    >O9A57     1f54 ; =0x1da2 =7586
*
*
* Function OSNA (OSNLB4/OSNLB5)
*
* SVC TS - load transient module
*
*
* Exts:
*   ABRT
*   FLGWT
*   OSN0
*   OSN4C
*   WAIT
*
OSNA     STA-  S-         1f56 ; [Push A to the stack]
         STB-  S-         1f58 ; [Push B to the stack]
         CLA              1f5a ; [Clear A]
         LDAB+ X+         1f5b ; [Load AL indexed, direct, post-incremented]
@J1F5D   LDBB/ X'0000'    1f5d ; =0x0000 =0 =NUL,NUL [Load BL direct]
         SABB             1f60 ; [AL - BL -> BL]
         BNL   @D1F67     1f61 ; =+4 [Branch on no link]
         JSR/  ABRT       1f63 ; [external symbol] [Jump to subroutine direct]
         DB    X'1E'      1f66 ; =0x1e =30
*
@D1F67   SLA              1f67 ; [Left shift A]
         INA              1f68 ; [Increment A]
         LDB   @J1F5D+1   1f69 ; =-13 [Load B relative]
         AAB              1f6b ; [A + B -> B]
         LDA+  B          1f6c ; [Load A from address in B]
         BP    @D1F7A     1f6d ; =+11 [Branch on plus]
         LDB=  X'8000'    1f6f ; =0x8000 =32768(-32768) [Load B with immediate]
         SAB              1f72 ; [A - B -> B]
         STB   @W1FCE+1   1f73 ; =+90 [Store B relative]
         CLA              1f75 ; [Clear A]
         STA   @W1F81+1   1f76 ; =+10 [Store A relative]
         JMP   @D1FCA     1f78 ; =+80 [Jump relative]
@D1F7A   STA-  S-         1f7a ; [Push A to the stack]
         JSR/  FLGWT      1f7c ; [external symbol] [Jump to subroutine direct]
         DB    X'3D'      1f7f ; =0x3d =61
         LDA+  S          1f80 ; [Load A from address in S]
@W1F81   LDB=  X'0000'    1f81 ; =0x0000 =0 =NUL,NUL [Load B with immediate]
         SABB             1f84 ; [AL - BL -> BL]
         BZ    @D1FC6     1f85 ; =+63 [Branch if zero]
         LDB=  TRPNT      1f87 ; =0x2152 =8530 [Load B with immediate]
@D1F8A   STB/  @W203F+1   1f8a ; =0x2040 =8256 [Store B direct]
         LDB+  B          1f8d ; [Load B from address in B]
         BZ    @D1FFF     1f8e ; =+111 [Branch if zero]
         LDAB+ B,4        1f90 ; [Load AL indexed, displaced, direct]
         BM    @D1F8A     1f93 ; =-11 [Branch on minus]
         INAB             1f95 ; [Increment AL]
         BNF   @D1F8A     1f96 ; =-14 [Branch on no fault]
         JSR/  @F2077     1f98 ; =0x2077 =8311 [Jump to subroutine direct]
         LDA$  @W203F+1   1f9b ; =0x2040 =8256 [Load A indirect]
         LDBB= X'7F'      1f9e ; =127 [Load BL with immediate]
         STBB+ A,4        1fa0 ; [Store BL indexed, displaced, direct]
         LDB+  A,2        1fa3 ; [Load B indexed, displaced, direct]
         DCA              1fa6 ; [Decrement A]
         AAB              1fa7 ; [A + B -> B]
         STB   @W1FB7     1fa8 ; =+13 [Store B relative]
         LDB=  X'0006'    1faa ; =0x0006 =6 [Load B with immediate]
         AAB              1fad ; [A + B -> B]
         STB   @W1FB9     1fae ; =+9 [Store B relative]
         LDB+  S          1fb0 ; [Load B from address in S]
         LDAB/ OSN0+5     1fb1 ; [external symbol] [Load AL direct]
         JSR/  OSN4C      1fb4 ; [external symbol] [Jump to subroutine direct]
@W1FB7   DW    X'0000'    1fb7 ; =0x0000 =0 =NUL,NUL
@W1FB9   DW    X'0000'    1fb9 ; =0x0000 =0 =NUL,NUL
         DB    X'01'      1fbb ; =0x01 =1
         STB   @W1FCE+1   1fbc ; =+17 [Store B relative]
         LDB$  @W203F+1   1fbe ; =0x2040 =8256 [Load B indirect]
         INA              1fc1 ; [Increment A]
         SAB              1fc2 ; [A - B -> B]
         JSR/  @F20D0     1fc3 ; =0x20d0 =8400 [Jump to subroutine direct]
@D1FC6   LDA+  S+         1fc6 ; [Pop A from the stack]
         STA   @W1F81+1   1fc8 ; =-72 [Store A relative]
@D1FCA   LDB+  S+         1fca ; [Pop B from the stack]
         LDA+  S+         1fcc ; [Pop A from the stack]
@W1FCE   JMP/  X'0000'    1fce ; =0x0000 =0 =NUL,NUL [Jump direct]
*
* Function OSNTR (OSNLB4/OSNLB5)
*
* SVC TRTN - transient return
*
*
OSNTR    STB-  S-         1fd1 ; [Push B to the stack]
         LDB/  OSN0+3     1fd3 ; [external symbol] [Load B direct]
         LDB+  B,1        1fd6 ; [Load B indexed, displaced, direct]
@P1FD9   LDBB/ OSN0+61    1fd9 ; [external symbol] [Load BL direct]
         SUBB  BU,BL      1fdc ; [BU - BL -> BL]
         BNZ   @D1FE4     1fde ; =+4 [Branch if not zero]
         LDBB= X'FF'      1fe0 ; =255(-1) [Load BL with immediate]
         STBB* @P1FD9+1   1fe2 ; =-10 [Store BL relative indirect]
@D1FE4   LDX+  X          1fe4 ; [Load X indexed, direct]
         BP    @D1FED     1fe6 ; =+5 [Branch on plus]
         LDB+  S+         1fe8 ; [Pop B from the stack]
         LDX+  S+         1fea ; [Pop X from the stack]
         RSR              1fec ; [Return from subroutine]
*
@D1FED   XAB              1fed ; [Transfer A to B]
         XFR   X,A        1fee ; [Transfer X to A]
         LDX+  S,2        1ff0 ; [Load X indexed, displaced, direct]
         STB+  S,2        1ff3 ; [Store B indexed, displaced, direct]
@D1FF6   JMP/  @J1F5D     1ff6 ; =0x1f5d =8029 [Jump direct]
*
* Function OSNTC (OSNLB4/OSNLB5)
*
*
OSNTC    STA-  S-         1ff9 ; [Push A to the stack]
         STB-  S-         1ffb ; [Push B to the stack]
         JMP   @D1FF6     1ffd ; =-9 [Jump relative]
@D1FFF   JSR/  ABRT       1fff ; [external symbol] [Jump to subroutine direct]
         DB    X'1F'      2002 ; =0x1f =31
*
*
* Function OSNAGM (OSNLB4/OSNLB5)
*
* SVC GMEM - get memory block from transient area
*
*
OSNAGM   CLA              2003 ; [Clear A]
         STA   @W2030+1   2004 ; =+43 [Store A relative]
         STX-  S-         2006 ; [Push X to the stack]
@D2008   LDA+  *S         2008 ; [Load A indexed, indirect]
         LDB=  X'0005'    200a ; =0x0005 =5 [Load B with immediate]
         ADD   B,A        200d ; [B + A -> A]
         LDX=  TRPNT      200f ; =0x2152 =8530 [Load X with immediate]
         STX-  S-         2012 ; [Push X to the stack]
         LDX+  X          2014 ; [Load X indexed, direct]
         BZ    @D1FFF     2016 ; =-25 [Branch if zero]
@D2018   LDBB+ X,4        2018 ; [Load BL indexed, displaced, direct]
         BP    @D2028     201b ; =+11 [Branch on plus]
         LDB+  X,2        201d ; [Load B indexed, displaced, direct]
         SAB              2020 ; [A - B -> B]
         BZ    @D2025     2021 ; =+2 [Branch if zero]
         BL    @D202E     2023 ; =+9 [Branch on link]
@D2025   LDB+  S          2025 ; [Load B from address in S]
         STB   @W2030+1   2026 ; =+9 [Store B relative]
@D2028   STX+  S          2028 ; [Store X indexed, direct]
         LDX+  X          202a ; [Load X indexed, direct]
         BNZ   @D2018     202c ; =-22 [Branch if not zero]
@D202E   LDX+  S+         202e ; [Pop X from the stack]
@W2030   LDB=  @W2030     2030 ; =0x2030 =8240 [Load B with immediate]
         BNZ   @D203A     2033 ; =+5 [Branch if not zero]
         JSR/  WAIT       2035 ; [external symbol] [Jump to subroutine direct]
         JMP   @D2008     2038 ; =-50 [Jump relative]
@D203A   LDX+  S+         203a ; [Pop X from the stack]
         XAB              203c ; [Transfer A to B]
         LDA   @W2030+1   203d ; =-14 [Load A relative]
@W203F   STA=  X'0000'    203f ; =0x0000 =0 =NUL,NUL [Store A immediate]
         LDA+  A          2042 ; [Load A from address in A]
         LDA+  A,2        2043 ; [Load A indexed, displaced, direct]
         SAB              2046 ; [A - B -> B]
         JSR/  @F20D0     2047 ; =0x20d0 =8400 [Jump to subroutine direct]
         LDA*  @W203F+1   204a ; =-12 [Load A relative indirect]
         LDB/  OSN0+3     204c ; [external symbol] [Load B direct]
         LDBB+ B,1        204f ; [Load BL indexed, displaced, direct]
         STBB+ A,4        2052 ; [Store BL indexed, displaced, direct]
         LDB=  X'0005'    2055 ; =0x0005 =5 [Load B with immediate]
         AAB              2058 ; [A + B -> B]
         INX              2059 ; [Increment X]
         INX              205a ; [Increment X]
         STB+  X+         205b ; [Store B indexed, direct, post-incremented]
         RSR              205d ; [Return from subroutine]
*
* Function OSNARM (OSNLB4/OSNLB5)
*
* SVC RMEM - release memory block back to transient area
*
*
OSNARM   LDA+  X+         205e ; [Load A indexed, direct, post-incremented]
         LDB=  X'FFFB'    2060 ; =0xfffb =65531(-5) [Load B with immediate]
         ADD   B,A        2063 ; [B + A -> A]
         STX-  S-         2065 ; [Push X to the stack]
         LDX=  TRPNT      2067 ; =0x2152 =8530 [Load X with immediate]
@D206A   STX   @W203F+1   206a ; =-44 [Store X relative]
         LDX+  X          206c ; [Load X indexed, direct]
         BZ    @D20CC     206e ; =+92 [Branch if zero]
         XAB              2070 ; [Transfer A to B]
         SUB   X,B        2071 ; [X - B -> B]
         BNZ   @D206A     2073 ; =-11 [Branch if not zero]
         LDX+  S+         2075 ; [Pop X from the stack]
*
* Function @F2077
*
@F2077   LDA*  @W203F+1   2077 ; =-57 [Load A relative indirect]
         STA   @W20B8+1   2079 ; =+62 [Store A relative]
         LDB+  A,2        207b ; [Load B indexed, displaced, direct]
         STB   @W20F8+1   207e ; =+121 [Store B relative]
         LDA+  A          2080 ; [Load A from address in A]
         STA*  @W203F+1   2081 ; =-67 [Store A relative indirect]
         STX-  S-         2083 ; [Push X to the stack]
         STX-  S-         2085 ; [Push X to the stack]
@D2087   LDX=  TRPNT      2087 ; =0x2152 =8530 [Load X with immediate]
@D208A   STX+  S          208a ; [Store X indexed, direct]
         LDX+  X          208c ; [Load X indexed, direct]
         BZ    @D20BD     208e ; =+45 [Branch if zero]
         LDAB+ X,4        2090 ; [Load AL indexed, displaced, direct]
         BP    @D208A     2093 ; =-11 [Branch on plus]
         LDA   @W20B8+1   2095 ; =+34 [Load A relative]
         SUB   X,A        2097 ; [X - A -> A]
         BM    @D20B2     2099 ; =+23 [Branch on minus]
         LDB   @W20F8+1   209b ; =+92 [Load B relative]
         SAB              209d ; [A - B -> B]
         BNZ   @D208A     209e ; =-22 [Branch if not zero]
@D20A0   LDA+  X,2        20a0 ; [Load A indexed, displaced, direct]
         LDB   @W20F8+1   20a3 ; =+84 [Load B relative]
         AAB              20a5 ; [A + B -> B]
         STB   @W20F8+1   20a6 ; =+81 [Store B relative]
         LDA   @W20B8+1   20a8 ; =+15 [Load A relative]
         STB+  A,2        20aa ; [Store B indexed, displaced, direct]
         LDA+  X          20ad ; [Load A from address in X]
         STA+  *S         20ae ; [Store A indexed, indirect]
         JMP   @D2087     20b0 ; =-43 [Jump relative]
@D20B2   LDB+  X,2        20b2 ; [Load B indexed, displaced, direct]
         AAB              20b5 ; [A + B -> B]
         BNZ   @D208A     20b6 ; =-46 [Branch if not zero]
@W20B8   STX=  X'0000'    20b8 ; =0x0000 =0 =NUL,NUL [Store X immediate]
         JMP   @D20A0     20bb ; =-29 [Jump relative]
@D20BD   LDX+  S+         20bd ; [Pop X from the stack]
         LDX+  S+         20bf ; [Pop X from the stack]
         JSR   @F2114     20c1 ; =+81 [Jump to subroutine relative]
         LDA$  @W203F+1   20c3 ; =0x2040 =8256 [Load A indirect]
         LDBB= X'FF'      20c6 ; =255(-1) [Load BL with immediate]
         STBB+ A,4        20c8 ; [Store BL indexed, displaced, direct]
         RSR              20cb ; [Return from subroutine]
*
@D20CC   JSR/  ABRT       20cc ; [external symbol] [Jump to subroutine direct]
         DB    X'20'      20cf ; =0x20 =32
*
*
* Function @F20D0
*
@F20D0   LDA=  X'0005'    20d0 ; =0x0005 =5 [Load A with immediate]
         SUB   B,A        20d3 ; [B - A -> A]
         BL    @D20D8     20d5 ; =+1 [Branch on link]
         RSR              20d7 ; [Return from subroutine]
*
@D20D8   STB   @W20F8+1   20d8 ; =+31 [Store B relative]
         STX-  S-         20da ; [Push X to the stack]
         LDX$  @W203F+1   20dc ; =0x2040 =8256 [Load X indirect]
         LDA+  X,2        20df ; [Load A indexed, displaced, direct]
         SAB              20e2 ; [A - B -> B]
         BL    @D20E8     20e3 ; =+3 [Branch on link]
         JMP/  @D1FFF     20e5 ; =0x1fff =8191 [Jump direct]
@D20E8   BM    @D2111     20e8 ; =+39 [Branch on minus]
         STB   @W2104+1   20ea ; =+25 [Store B relative]
         LDA=  X'0005'    20ec ; =0x0005 =5 [Load A with immediate]
         SAB              20ef ; [A - B -> B]
         BP    @D2111     20f0 ; =+31 [Branch on plus]
         STX   @W20B8+1   20f2 ; =-59 [Store X relative]
         LDA+  X          20f4 ; [Load A from address in X]
         STA$  @W203F+1   20f5 ; =0x2040 =8256 [Store A indirect]
@W20F8   LDA=  X'0000'    20f8 ; =0x0000 =0 =NUL,NUL [Load A with immediate]
         STA+  X,2        20fb ; [Store A indexed, displaced, direct]
         ADD   A,X        20fe ; [A + X -> X]
         JSR   @F2114     2100 ; =+18 [Jump to subroutine relative]
         STX   @W20B8+1   2102 ; =-75 [Store X relative]
@W2104   LDA=  X'0000'    2104 ; =0x0000 =0 =NUL,NUL [Load A with immediate]
         STA+  X,2        2107 ; [Store A indexed, displaced, direct]
         LDAB= X'FF'      210a ; =255(-1) [Load AL with immediate]
         STAB+ X,4        210c ; [Store AL indexed, displaced, direct]
         JSR   @F2114     210f ; =+3 [Jump to subroutine relative]
@D2111   LDX+  S+         2111 ; [Pop X from the stack]
         RSR              2113 ; [Return from subroutine]
*
* Function @F2114
*
@F2114   STX-  S-         2114 ; [Push X to the stack]
         LDX=  TRPNT      2116 ; =0x2152 =8530 [Load X with immediate]
         LDA   @W20B8+1   2119 ; =-98 [Load A relative]
         LDA+  A,2        211b ; [Load A indexed, displaced, direct]
@D211E   LDB+  X          211e ; [Load B from address in X]
         BZ    @D212B     211f ; =+10 [Branch if zero]
         LDB+  B,2        2121 ; [Load B indexed, displaced, direct]
         SAB              2124 ; [A - B -> B]
         BL    @D212B     2125 ; =+4 [Branch on link]
         LDX+  X          2127 ; [Load X indexed, direct]
         JMP   @D211E     2129 ; =-13 [Jump relative]
@D212B   LDA+  X          212b ; [Load A from address in X]
         STA*  @W20B8+1   212c ; =-117 [Store A relative indirect]
         LDA   @W20B8+1   212e ; =-119 [Load A relative]
         STA+  X          2130 ; [Store A to address in X]
         STX/  @W203F+1   2131 ; =0x2040 =8256 [Store X direct]
         LDX+  S+         2134 ; [Pop X from the stack]
         RSR              2136 ; [Return from subroutine]
*
* Function OSNAXT (OSNLB4/OSNLB5)
*
*
OSNAXT   STX-  S-         2137 ; [Push X to the stack]
@D2139   LDX=  TRPNT      2139 ; =0x2152 =8530 [Load X with immediate]
@D213C   STX/  @W203F+1   213c ; =0x2040 =8256 [Store X direct]
         LDX+  X          213f ; [Load X indexed, direct]
         BZ    @D2111     2141 ; =-50 [Branch if zero]
         LDBB+ X,4        2143 ; [Load BL indexed, displaced, direct]
         SABB             2146 ; [AL - BL -> BL]
         BNZ   @D213C     2147 ; =-13 [Branch if not zero]
         STAB- S-         2149 ; [Push AL to the stack]
         JSR/  @F2077     214b ; =0x2077 =8311 [Jump to subroutine direct]
         LDAB+ S+         214e ; [Pop AL from the stack]
         JMP   @D2139     2150 ; =-25 [Jump relative]
*
* Function TRPNT (OSNLB4/OSNLB5)
*
*
TRPNT    DW    X'0000'    2152 ; =0x0000 =0 =NUL,NUL
*
*
* Function IOD1IO (OSNLB5)
*
* I/O driver for Hawk disk.
* Input/output.
*
*
* Exts:
*   BSTLU
*   WAIT
*   OSN0
*   CVR16
*   SYMSG
*   @HEX
*   ABRT
*   SYMSGA
*
IOD1IO   LDAB+ S+         2154 ; [Pop AL from the stack]
         STAB/ @B21DE     2156 ; =0x21de =8670 [Store AL direct]
         LDB+  S+         2159 ; [Pop B from the stack]
         STB/  @W21E5     215b ; =0x21e5 =8677 [Store B direct]
         LDB+  S+         215e ; [Pop B from the stack]
         STB   @W21DF     2160 ; =+125 [Store B relative]
         LDAB+ S+         2162 ; [Pop AL from the stack]
         STAB  @B21DD     2164 ; =+119 [Store AL relative]
         LDAB+ Y,2        2166 ; [Load AL indexed, displaced, direct]
         STAB/ @B21ED     2169 ; =0x21ed =8685 [Store AL direct]
         LDA+  Y,19       216c ; [Load A indexed, displaced, direct]
         STA/  X'0028'    216f ; =0x0028 =40 [Store A direct]
         STBB+ A,15       2172 ; [Store BL indexed, displaced, direct]
         XFRB  AU,AL      2175 ; [Transfer AU to AL]
         LDBB= X'0C'      2177 ; =12 [Load BL with immediate]
         ANDB  BL,AL      2179 ; [BL & AL -> AL]
         SLAB             217b ; [Left shift AL]
         SLAB             217c ; [Left shift AL]
         LDBB= X'04'      217d ; =4 [Load BL with immediate]
         AABB             217f ; [AL + BL -> BL]
         STBB/ @B2229+1   2180 ; =0x222a =8746 [Store BL direct]
         LDA+  S+         2183 ; [Pop A from the stack]
         STA   @W21E1     2185 ; =+90 [Store A relative]
         LDAB+ S+         2187 ; [Pop AL from the stack]
         STAB/ @B2218+1   2189 ; =0x2219 =8729 [Store AL direct]
         STX-  S-         218c ; [Push X to the stack]
@J218E   LDB   @W21DF     218e ; =+79 [Load B relative]
         STB   @W21E3     2190 ; =+81 [Store B relative]
         LDA=  X'001F'    2192 ; =0x001f =31 [Load A with immediate]
         NAB              2195 ; [A & B -> B]
         INA              2196 ; [Increment A]
         SAB              2197 ; [A - B -> B]
         XFR   B,X        2198 ; [Transfer B to X]
         LDA   @W21E1     219a ; =+69 [Load A relative]
         STA   @W21E7     219c ; =+73 [Store A relative]
@D219E   LDB+  Y,16       219e ; [Load B indexed, displaced, direct]
         LDA   @W21E3     21a1 ; =+64 [Load A relative]
         JSR/  BSTLU      21a3 ; [external symbol] [Jump to subroutine direct]
         LDB   @W21E3     21a6 ; =+59 [Load B relative]
         SAB              21a8 ; [A - B -> B]
         BNZ   @D21EE     21a9 ; =+67 [Branch if not zero]
         INA              21ab ; [Increment A]
         STA   @W21E3     21ac ; =+53 [Store A relative]
         DCA              21ae ; [Decrement A]
         JSR/  @F2536     21af ; =0x2536 =9526 [Jump to subroutine direct]
         STA   @W21EB     21b2 ; =+55 [Store A relative]
         LDA   @W21E7     21b4 ; =+49 [Load A relative]
         LDB=  X'0190'    21b6 ; =0x0190 =400 [Load B with immediate]
         SAB              21b9 ; [A - B -> B]
         STB   @W21E7     21ba ; =+43 [Store B relative]
         BZ    @D21C4     21bc ; =+6 [Branch if zero]
         BNL   @D21C4     21be ; =+4 [Branch on no link]
         DCX              21c0 ; [Decrement X]
         BGZ   @D219E     21c1 ; =-37 [Branch if greater than zero]
@D21C3   SL               21c3 ; [Set link]
@D21C4   LDA   @W21E1     21c4 ; =+27 [Load A relative]
         LDB   @W21E7     21c6 ; =+31 [Load B relative]
         BL    @D21CC     21c8 ; =+2 [Branch on link]
         CLR   B          21ca ; [Clear B]
@D21CC   SAB              21cc ; [A - B -> B]
         STB   @W21E7     21cd ; =+24 [Store B relative]
         LDA   @W21E3     21cf ; =+18 [Load A relative]
         LDB   @W21DF     21d1 ; =+12 [Load B relative]
         STB   @W21E3     21d3 ; =+14 [Store B relative]
         SAB              21d5 ; [A - B -> B]
         STB   @W21E9     21d6 ; =+17 [Store B relative]
         CLAB             21d8 ; [Clear AL]
         STAB  @B2240+1   21d9 ; =+102 [Store AL relative]
         JMP   @D2213     21db ; =+54 [Jump relative]
*
@B21DD   DB    X'00'      21dd ; =0x00 =0 =NUL
@B21DE   DB    X'00'      21de ; =0x00 =0 =NUL
@W21DF   DW    X'0000'    21df ; =0x0000 =0 =NUL,NUL
@W21E1   DW    X'0000'    21e1 ; =0x0000 =0 =NUL,NUL
@W21E3   DW    X'0000'    21e3 ; =0x0000 =0 =NUL,NUL
@W21E5   DW    X'0000'    21e5 ; =0x0000 =0 =NUL,NUL
@W21E7   DW    X'0000'    21e7 ; =0x0000 =0 =NUL,NUL
@W21E9   DW    X'0000'    21e9 ; =0x0000 =0 =NUL,NUL
@W21EB   DW    X'0000'    21eb ; =0x0000 =0 =NUL,NUL
@B21ED   DB    X'00'      21ed ; =0x00 =0 =NUL
*
@D21EE   STA   @W21F7+1   21ee ; =+8 [Store A relative]
         LDA   @W21E3     21f0 ; =-15 [Load A relative]
         LDB   @W21DF     21f2 ; =-21 [Load B relative]
         SAB              21f4 ; [A - B -> B]
         BNZ   @D21C3     21f5 ; =-52 [Branch if not zero]
@W21F7   LDA=  X'0000'    21f7 ; =0x0000 =0 =NUL,NUL [Load A with immediate]
         STA   @W21E3     21fa ; =-25 [Store A relative]
         JSR/  @F2536     21fc ; =0x2536 =9526 [Jump to subroutine direct]
         STA   @W21EB     21ff ; =-22 [Store A relative]
         LDA=  X'0001'    2201 ; =0x0001 =1 [Load A with immediate]
         STA   @W21E9     2204 ; =-29 [Store A relative]
         LDA   @W21E1     2206 ; =-39 [Load A relative]
         LDB=  X'0190'    2208 ; =0x0190 =400 [Load B with immediate]
         SAB              220b ; [A - B -> B]
         BNL   @D2213     220c ; =+5 [Branch on no link]
         LDA=  X'0190'    220e ; =0x0190 =400 [Load A with immediate]
         STA   @W21E7     2211 ; =-44 [Store A relative]
@D2213   LDAB= X'0D'      2213 ; =13 [Load AL with immediate]
         STAB/ @B24EC     2215 ; =0x24ec =9452 [Store AL direct]
@B2218   LDAB= X'00'      2218 ; =0 =NUL [Load AL with immediate]
         BNZ   @D221E     221a ; =+2 [Branch if not zero]
         LDAB= X'0D'      221c ; =13 [Load AL with immediate]
@D221E   STAB/ @B22F1+1   221e ; =0x22f2 =8946 [Store AL direct]
         STAB  @B223C+1   2221 ; =+26 [Store AL relative]
         LDA=  >HKIS1     2223 ; =0x22e5 =8933 [Load A with immediate]
         STA/  X'002E'    2226 ; =0x002e =46 [Store A direct]
@B2229   DMA   SDV,0      2229 ; [Set DMA device]
         DMA   EAB        222b ; [Enable DMA]
         LDA/  X'0028'    222d ; =0x0028 =40 [Load A direct]
         STAB+ A,14       2230 ; [Store AL indexed, displaced, direct]
         STAB+ A,12       2233 ; [Store AL indexed, displaced, direct]
         LDA=  X'7530'    2236 ; =0x7530 =30000 [Load A with immediate]
@W2239   STA=  X'0000'    2239 ; =0x0000 =0 =NUL,NUL [Store A immediate]
@B223C   LDBB= X'00'      223c ; =0 =NUL [Load BL with immediate]
         BM    @D2266     223e ; =+38 [Branch on minus]
@B2240   LDAB= X'00'      2240 ; =0 =NUL [Load AL with immediate]
         BZ    @D224B     2242 ; =+7 [Branch if zero]
         LDAB  @B2218+1   2244 ; =-45 [Load AL relative]
         BNZ   @D2288     2246 ; =+64 [Branch if not zero]
         JMP/  @J24B6     2248 ; =0x24b6 =9398 [Jump direct]
@D224B   JSR/  WAIT       224b ; [external symbol] [Jump to subroutine direct]
         LDA   @W2239+1   224e ; =-22 [Load A relative]
         DCA              2250 ; [Decrement A]
         STA   @W2239+1   2251 ; =-25 [Store A relative]
         BNZ   @B223C     2253 ; =-25 [Branch if not zero]
         JSR/  @F23D4     2255 ; =0x23d4 =9172 [Jump to subroutine direct]
         LDAB= X'1D'      2258 ; =29 [Load AL with immediate]
         STAB/ @B24EC     225a ; =0x24ec =9452 [Store AL direct]
         LDA=  @W2591     225d ; =0x2591 =9617 [Load A with immediate]
         STA/  @W24B9     2260 ; =0x24b9 =9401 [Store A direct]
         JMP/  @J24B6     2263 ; =0x24b6 =9398 [Jump direct]
@D2266   LDA   @W21E9     2266 ; =-127 [Load A relative]
         LDB/  @W21DF     2268 ; =0x21df =8671 [Load B direct]
         AAB              226b ; [A + B -> B]
         STB/  @W21DF     226c ; =0x21df =8671 [Store B direct]
         LDA/  @W21E7     226f ; =0x21e7 =8679 [Load A direct]
         LDB/  @W21E5     2272 ; =0x21e5 =8677 [Load B direct]
         AAB              2275 ; [A + B -> B]
         STB/  @W21E5     2276 ; =0x21e5 =8677 [Store B direct]
         LDB/  @W21E1     2279 ; =0x21e1 =8673 [Load B direct]
         SUB   B,A        227c ; [B - A -> A]
         STA/  @W21E1     227e ; =0x21e1 =8673 [Store A direct]
         BZ    @D2288     2281 ; =+5 [Branch if zero]
         BNL   @D2288     2283 ; =+3 [Branch on no link]
         JMP/  @J218E     2285 ; =0x218e =8590 [Jump direct]
@D2288   LDBB= X'FF'      2288 ; =255(-1) [Load BL with immediate]
         STBB/ OSN0+31    228a ; [external symbol] [Store BL direct]
         LDX+  S+         228d ; [Pop X from the stack]
         LDA+  S+         228f ; [Pop A from the stack]
         XAY              2291 ; [Transfer A to Y]
         CLA              2292 ; [Clear A]
         LDBB  @B2240+1   2293 ; =-84 [Load BL relative]
         BZ    @D229A     2295 ; =+3 [Branch if zero]
         LDA/  @B23DD+1   2297 ; =0x23de =9182 [Load A direct]
@D229A   STA-  S-         229a ; [Push A to the stack]
         LDA/  @B23D7+1   229c ; =0x23d8 =9176 [Load A direct]
         STA-  S-         229f ; [Push A to the stack]
         JSR/  WAIT       22a1 ; [external symbol] [Jump to subroutine direct]
         LDB+  S+         22a4 ; [Pop B from the stack]
         LDA+  S+         22a6 ; [Pop A from the stack]
         RSR              22a8 ; [Return from subroutine]
*
* Function IOD1S (OSNLB5)
*
* I/O driver for Hawk disk.
* Status.
*
*
IOD1S    CLAB             22a9 ; [Clear AL]
         DCAB             22aa ; [Decrement AL]
@P22AB   STAB/ OSN0+31    22ab ; [external symbol] [Store AL direct]
         LDB+  Y,19       22ae ; [Load B indexed, displaced, direct]
         LDAB+ Y,15       22b1 ; [Load AL indexed, displaced, direct]
         STAB+ B          22b4 ; [Store AL to address in B]
         LDA+  B,4        22b5 ; [Load A indexed, displaced, direct]
         LDB=  X'0010'    22b8 ; =0x0010 =16 [Load B with immediate]
         NAB              22bb ; [A & B -> B]
         RSR              22bc ; [Return from subroutine]
*
* Function IOD1RS (OSNLB5)
*
* I/O driver for Hawk disk.
* Reset.
*
*
IOD1RS   CLAB             22bd ; [Clear AL]
         DCAB             22be ; [Decrement AL]
         STAB* @P22AB+1   22bf ; =-21 [Store AL relative indirect]
         LDBB/ @B223C+1   22c1 ; =0x223d =8765 [Load BL direct]
         BM    @D22CC     22c4 ; =+6 [Branch on minus]
         LDA+  Y,19       22c6 ; [Load A indexed, displaced, direct]
         STBB+ A,11       22c9 ; [Store BL indexed, displaced, direct]
@D22CC   RSR              22cc ; [Return from subroutine]
*
@D22CD   JSR/  @F24A6     22cd ; =0x24a6 =9382 [Jump to subroutine direct]
         DW    @W254A     22d0 ; =0x254a =9546
*
@J22D2   LDAB= X'FF'      22d2 ; =255(-1) [Load AL with immediate]
         STAB/ @B223C+1   22d4 ; =0x223d =8765 [Store AL direct]
@J22D7   STAB+ Z,3        22d7 ; [Store AL indexed, displaced, direct]
         STAB+ Z,13       22da ; [Store AL indexed, displaced, direct]
         DMA   DAB        22dd ; [Disable DMA]
         STAB+ Z,15       22df ; [Store AL indexed, displaced, direct]
         RI               22e2 ; [Return from interrupt]
*
* Function >HIJMP
*
*
>HIJMP   JMP   @J22D7     22e3 ; =-14 [Jump relative]
*
* Function >HKIS1
*
*
>HKIS1   STAB+ Z,15       22e5 ; [Store AL indexed, displaced, direct]
         STAB+ Z,14       22e8 ; [Store AL indexed, displaced, direct]
         CLR   X          22eb ; [Clear X]
         LDA=  IOD2R      22ed ; =0x25b0 =9648 [Load A with immediate]
         XAS              22f0 ; [Transfer A to S]
@B22F1   LDAB= X'00'      22f1 ; =0 =NUL [Load AL with immediate]
         DCAB             22f3 ; [Decrement AL]
         STAB  @B22F1+1   22f4 ; =-4 [Store AL relative]
         BM    @D22CD     22f6 ; =-43 [Branch on minus]
         JSR/  @F2526     22f8 ; =0x2526 =9510 [Jump to subroutine direct]
         STAB+ Z          22fb ; [Store AL to address in Z]
         JSR/  @F23C5     22fc ; =0x23c5 =9157 [Jump to subroutine direct]
         JSR/  @F23B2     22ff ; =0x23b2 =9138 [Jump to subroutine direct]
         LDB=  X'0400'    2302 ; =0x0400 =1024 [Load B with immediate]
         NAB              2305 ; [A & B -> B]
         BNZ   @D237E     2306 ; =+118 [Branch if not zero]
         LDB=  X'0020'    2308 ; =0x0020 =32 [Load B with immediate]
         NAB              230b ; [A & B -> B]
         BNZ   @D2310     230c ; =+2 [Branch if not zero]
         JSR   @F238F     230e ; =+127 [Jump to subroutine relative]
@D2310   LDAB= X'02'      2310 ; =2 [Load AL with immediate]
         STAB+ Z,8        2312 ; [Store AL indexed, displaced, direct]
         JSR   @F238F     2315 ; =+120 [Jump to subroutine relative]
         JSR/  @F23B2     2317 ; =0x23b2 =9138 [Jump to subroutine direct]
         LDB=  X'0400'    231a ; =0x0400 =1024 [Load B with immediate]
         NAB              231d ; [A & B -> B]
         BNZ   @D237E     231e ; =+94 [Branch if not zero]
         LDB=  X'0020'    2320 ; =0x0020 =32 [Load B with immediate]
         NAB              2323 ; [A & B -> B]
         BZ    @D237E     2324 ; =+88 [Branch if zero]
         LDAB/ @B21DE     2326 ; =0x21de =8670 [Load AL direct]
         BZ    @D2374     2329 ; =+73 [Branch if zero]
         DCAB             232b ; [Decrement AL]
         BZ    @D235A     232c ; =+44 [Branch if zero]
         LDAB/ @B2533+1   232e ; =0x2534 =9524 [Load AL direct]
         JSR   @F23A7     2331 ; =+116 [Jump to subroutine relative]
@B2333   STBB= X'00'      2333 ; =0 =NUL [Store BL immediate]
         IVRB  BL         2335 ; [Invert BL]
         STBB+ Z,3        2337 ; [Store BL indexed, displaced, direct]
         JSR   @F23B2     233a ; =+118 [Jump to subroutine relative]
         LDB=  X'0040'    233c ; =0x0040 =64 [Load B with immediate]
         NAB              233f ; [A & B -> B]
         BNZ   @D2377     2340 ; =+53 [Branch if not zero]
         LDAB  @B2333+1   2342 ; =-16 [Load AL relative]
         STAB+ Z,3        2344 ; [Store AL indexed, displaced, direct]
         JSR   @F23B2     2347 ; =+105 [Jump to subroutine relative]
         LDB=  X'0040'    2349 ; =0x0040 =64 [Load B with immediate]
         NAB              234c ; [A & B -> B]
         BZ    @D2377     234d ; =+40 [Branch if zero]
         LDB=  X'0080'    234f ; =0x0080 =128 [Load B with immediate]
         NAB              2352 ; [A & B -> B]
         BZ    @D2358     2353 ; =+3 [Branch if zero]
         JMP/  @J2437     2355 ; =0x2437 =9271 [Jump direct]
@D2358   LDAB= X'01'      2358 ; =1 [Load AL with immediate]
@D235A   STAB+ Z,8        235a ; [Store AL indexed, displaced, direct]
         JSR/  @F23E3     235d ; =0x23e3 =9187 [Jump to subroutine direct]
         LDAB/ @B21DE     2360 ; =0x21de =8670 [Load AL direct]
         DCAB             2363 ; [Decrement AL]
         BZ    @D2374     2364 ; =+14 [Branch if zero]
         JSR   @F23C5     2366 ; =+93 [Jump to subroutine relative]
         JSR   @F23B2     2368 ; =+72 [Jump to subroutine relative]
         JSR/  @F2526     236a ; =0x2526 =9510 [Jump to subroutine direct]
         LDAB= X'04'      236d ; =4 [Load AL with immediate]
         STAB+ Z,8        236f ; [Store AL indexed, displaced, direct]
         JSR   @F23E3     2372 ; =+111 [Jump to subroutine relative]
@D2374   JMP/  @J22D2     2374 ; =0x22d2 =8914 [Jump direct]
@D2377   JSR   @F23D4     2377 ; =+91 [Jump to subroutine relative]
         JSR/  @F24A6     2379 ; =0x24a6 =9382 [Jump to subroutine direct]
         DW    @W2550     237c ; =0x2550 =9552
*
@D237E   JSR   @F2383     237e ; =+3 [Jump to subroutine relative]
         JMP/  @J242D     2380 ; =0x242d =9261 [Jump direct]
*
* Function @F2383
*
@F2383   JSR   @F23B2     2383 ; =+45 [Jump to subroutine relative]
*
* Function @F2385
*
@F2385   JSR   @F23D4     2385 ; =+77 [Jump to subroutine relative]
         LDAB= X'03'      2387 ; =3 [Load AL with immediate]
         STAB+ Z,8        2389 ; [Store AL indexed, displaced, direct]
         JSR   @F238F     238c ; =+1 [Jump to subroutine relative]
         RSR              238e ; [Return from subroutine]
*
* Function @F238F
*
@F238F   XFR   X,Y        238f ; [Transfer X to Y]
         LDX+  S+         2391 ; [Pop X from the stack]
@D2393   RI               2393 ; [Return from interrupt]
*
* Function >HKIS2
*
*
>HKIS2   STAB+ Z,15       2394 ; [Store AL indexed, displaced, direct]
         JSR   @F23B2     2397 ; =+25 [Jump to subroutine relative]
         LDAB/ @B21DD     2399 ; =0x21dd =8669 [Load AL direct]
         SRAB             239c ; [Arithmetic right shift AL]
         JSR   @F23A7     239d ; =+8 [Jump to subroutine relative]
         LDA+  Z,4        239f ; [Load A indexed, displaced, direct]
         NABB             23a2 ; [AL & BL -> BL]
         BZ    @D2393     23a3 ; =-18 [Branch if zero]
         JMP+  Y          23a5 ; [Jump indexed, direct]
*
* Function @F23A7
*
@F23A7   LDBB= X'01'      23a7 ; =1 [Load BL with immediate]
         JMP   @D23AE     23a9 ; =+3 [Jump relative]
@D23AB   RL               23ab ; [Reset link]
         RLRB  BL         23ac ; [Left rotate BL by 1]
@D23AE   DCAB             23ae ; [Decrement AL]
         BP    @D23AB     23af ; =-6 [Branch on plus]
         RSR              23b1 ; [Return from subroutine]
*
* Function @F23B2
*
@F23B2   LDA+  Z,4        23b2 ; [Load A indexed, displaced, direct]
         LDB=  X'0200'    23b5 ; =0x0200 =512 [Load B with immediate]
         NAB              23b8 ; [A & B -> B]
         BNZ   @D23E1     23b9 ; =+38 [Branch if not zero]
         LDB=  X'0010'    23bb ; =0x0010 =16 [Load B with immediate]
         NAB              23be ; [A & B -> B]
         BNZ   @D23C4     23bf ; =+3 [Branch if not zero]
         JMP/  @J248E     23c1 ; =0x248e =9358 [Jump direct]
@D23C4   RSR              23c4 ; [Return from subroutine]
*
* Function @F23C5
*
@F23C5   LDA/  @W21E7     23c5 ; =0x21e7 =8679 [Load A direct]
         IVA              23c8 ; [Invert A]
         DMA   SCT,A      23c9 ; [Store A register to DMA count register]
         LDB/  @W21E5     23cb ; =0x21e5 =8677 [Load B direct]
         DMA   SAD,B      23ce ; [Store B register to DMA address register]
         SAB              23d0 ; [A - B -> B]
         STB   @W2412+1   23d1 ; =+64 [Store B relative]
         RSR              23d3 ; [Return from subroutine]
*
* Function @F23D4
*
@F23D4   LDA+  Z,1        23d4 ; [Load A indexed, displaced, direct]
@B23D7   STA=  X'0000'    23d7 ; =0x0000 =0 =NUL,NUL [Store A immediate]
         LDA+  Z,4        23da ; [Load A indexed, displaced, direct]
@B23DD   STA=  X'0000'    23dd ; =0x0000 =0 =NUL,NUL [Store A immediate]
         RSR              23e0 ; [Return from subroutine]
*
@D23E1   JMP   @B2451     23e1 ; =+110 [Jump relative]
*
* Function @F23E3
*
@F23E3   XFR   X,Y        23e3 ; [Transfer X to Y]
         LDX+  S+         23e5 ; [Pop X from the stack]
@D23E7   RI               23e7 ; [Return from interrupt]
*
* Function >HKIS3
*
*
>HKIS3   STAB+ Z,15       23e8 ; [Store AL indexed, displaced, direct]
         JSR   @F23B2     23eb ; =-59 [Jump to subroutine relative]
         LDB=  X'0100'    23ed ; =0x0100 =256 [Load B with immediate]
         NAB              23f0 ; [A & B -> B]
         BNZ   @D23E7     23f1 ; =-12 [Branch if not zero]
         LDB=  X'F000'    23f3 ; =0xf000 =61440(-4096) ='p',NUL [Load B with immediate]
         NAB              23f6 ; [A & B -> B]
         BZ    @D2402     23f7 ; =+9 [Branch if zero]
         LDB=  X'2000'    23f9 ; =0x2000 =8192 [Load B with immediate]
         NAB              23fc ; [A & B -> B]
         BZ    @D242B     23fd ; =+44 [Branch if zero]
         JMP/  @D237E     23ff ; =0x237e =9086 [Jump direct]
@D2402   LDA+  Z,1        2402 ; [Load A indexed, displaced, direct]
         LDB/  @W21EB     2405 ; =0x21eb =8683 [Load B direct]
         SAB              2408 ; [A - B -> B]
         BZ    @W2412     2409 ; =+7 [Branch if zero]
         JSR   @F23D4     240b ; =-57 [Jump to subroutine relative]
         JSR/  @F24A6     240d ; =0x24a6 =9382 [Jump to subroutine direct]
         DW    @W2588     2410 ; =0x2588 =9608
@W2412   LDA=  X'0000'    2412 ; =0x0000 =0 =NUL,NUL [Load A with immediate]
         DMA   RAD,B      2415 ; [Read DMA address register to B register]
         AAB              2417 ; [A + B -> B]
         DMA   RCT,A      2418 ; [Read DMA count register to A register]
         SAB              241a ; [A - B -> B]
         BZ    @D2424     241b ; =+7 [Branch if zero]
@D241D   JSR   @F23D4     241d ; =-75 [Jump to subroutine relative]
         JSR/  @F24A6     241f ; =0x24a6 =9382 [Jump to subroutine direct]
         DW    @W2545     2422 ; =0x2545 =9541
*
@D2424   INA              2424 ; [Increment A]
         BGZ   @D241D     2425 ; =-10 [Branch if greater than zero]
         BM    @D242B+1   2427 ; =+3 [Branch on minus]
         JMP+  Y          2429 ; [Jump indexed, direct]
@D242B   JSR   @F23D4     242b ; =-89 [Jump to subroutine relative]
@J242D   STAB+ Z,11       242d ; [Store AL indexed, displaced, direct]
         CLA              2430 ; [Clear A]
         STA/  @W2239+1   2431 ; =0x223a =8762 [Store A direct]
         JMP/  >HKIS1     2434 ; =0x22e5 =8933 [Jump direct]
@J2437   JSR   @F2493     2437 ; =+90 [Jump to subroutine relative]
         STA/  @S2559     2439 ; =0x2559 =9561 [Store A direct]
         JSR/  @F24F8     243c ; =0x24f8 =9464 [Jump to subroutine direct]
         DW    @W2554     243f ; =0x2554 =9556
         LDB=  X'0080'    2441 ; =0x0080 =128 [Load B with immediate]
         NAB              2444 ; [A & B -> B]
         BNZ   @J2437     2445 ; =-16 [Branch if not zero]
         LDAB/ @B22F1+1   2447 ; =0x22f2 =8946 [Load AL direct]
         INAB             244a ; [Increment AL]
         STAB/ @B22F1+1   244b ; =0x22f2 =8946 [Store AL direct]
         JMP/  >HKIS1     244e ; =0x22e5 =8933 [Jump direct]
@B2451   LDAB= X'00'      2451 ; =0 =NUL [Load AL with immediate]
         BNZ   @D245D     2453 ; =+8 [Branch if not zero]
         INAB             2455 ; [Increment AL]
         STAB  @B2451+1   2456 ; =-6 [Store AL relative]
         JSR/  @F2385     2458 ; =0x2385 =9093 [Jump to subroutine direct]
         JMP   @D247D     245b ; =+32 [Jump relative]
@D245D   CLAB             245d ; [Clear AL]
         STAB  @B2451+1   245e ; =-14 [Store AL relative]
         LDA=  @W255D     2460 ; =0x255d =9565 [Load A with immediate]
@D2463   STA   @W246F     2463 ; =+10 [Store A relative]
         JSR   @F2493     2465 ; =+44 [Jump to subroutine relative]
         LDB   @W246F     2467 ; =+6 [Load B relative]
         STA+  B,6        2469 ; [Store A indexed, displaced, direct]
@D246C   JSR/  @F24F8     246c ; =0x24f8 =9464 [Jump to subroutine direct]
@W246F   DW    X'0000'    246f ; =0x0000 =0 =NUL,NUL
         LDB=  X'0200'    2471 ; =0x0200 =512 [Load B with immediate]
         NAB              2474 ; [A & B -> B]
         BNZ   @D246C     2475 ; =-11 [Branch if not zero]
         LDB=  X'0010'    2477 ; =0x0010 =16 [Load B with immediate]
         NAB              247a ; [A & B -> B]
         BZ    @D246C     247b ; =-17 [Branch if zero]
@D247D   CLAB             247d ; [Clear AL]
         STAB  @B2451+1   247e ; =-46 [Store AL relative]
@D2480   LDX+  S+         2480 ; [Pop X from the stack]
         BNZ   @D2480     2482 ; =-4 [Branch if not zero]
         LDAB/ @B22F1+1   2484 ; =0x22f2 =8946 [Load AL direct]
         INAB             2487 ; [Increment AL]
         STAB/ @B22F1+1   2488 ; =0x22f2 =8946 [Store AL direct]
         JMP/  >HKIS1     248b ; =0x22e5 =8933 [Jump direct]
@J248E   LDA=  @W2567     248e ; =0x2567 =9575 [Load A with immediate]
         JMP   @D2463     2491 ; =-48 [Jump relative]
*
* Function @F2493
*
@F2493   LDAB= X'A0'      2493 ; =160(-96) =' ' [Load AL with immediate]
         STAB  @S24A4     2495 ; =+13 [Store AL relative]
         CLA              2497 ; [Clear A]
         LDAB/ @B21ED     2498 ; =0x21ed =8685 [Load AL direct]
         JSR/  CVR16      249b ; [external symbol] [Jump to subroutine direct]
         DW    @S24A5     249e ; =0x24a5 =9381
         LDA   @S24A4     24a0 ; =+2 [Load A relative]
         RSR              24a2 ; [Return from subroutine]
*
         DB    X'00'      24a3 ; =0x00 =0 =NUL
@S24A4   DC    ' '        24a4 ; hex:a0 dec:160(-96)
@S24A5   DC    ' '        24a5 ; hex:a0 dec:160(-96)
*
* Function @F24A6
*
@F24A6   LDA+  X+         24a6 ; [Load A indexed, direct, post-incremented]
         STA   @W24B9     24a8 ; =+15 [Store A relative]
         LDAB= X'01'      24aa ; =1 [Load AL with immediate]
         STAB/ @B2240+1   24ac ; =0x2241 =8769 [Store AL direct]
@D24AF   LDX+  S+         24af ; [Pop X from the stack]
         BNZ   @D24AF     24b1 ; =-4 [Branch if not zero]
         JMP/  @J22D7     24b3 ; =0x22d7 =8919 [Jump direct]
@J24B6   JSR/  SYMSG      24b6 ; [external symbol] [Jump to subroutine direct]
@W24B9   DW    X'0000'    24b9 ; =0x0000 =0 =NUL,NUL
         LDAB/ @B23DD+1   24bb ; =0x23de =9182 [Load AL direct]
         JSR/  @HEX       24be ; [external symbol] [Jump to subroutine direct]
         STA/  @S2582     24c1 ; =0x2582 =9602 [Store A direct]
         LDAB/ @B23DD+2   24c4 ; =0x23df =9183 [Load AL direct]
         JSR/  @HEX       24c7 ; [external symbol] [Jump to subroutine direct]
         STA/  @S2584     24ca ; =0x2584 =9604 [Store A direct]
         JSR   @F2493     24cd ; =-60 [Jump to subroutine relative]
         STA/  @S257A     24cf ; =0x257a =9594 [Store A direct]
         LDAB/ @B23D7+1   24d2 ; =0x23d8 =9176 [Load AL direct]
         JSR/  @HEX       24d5 ; [external symbol] [Jump to subroutine direct]
         STA/  @S257D     24d8 ; =0x257d =9597 [Store A direct]
         LDAB/ @B23D7+2   24db ; =0x23d9 =9177 [Load AL direct]
         JSR/  @HEX       24de ; [external symbol] [Jump to subroutine direct]
         STA/  @S257F     24e1 ; =0x257f =9599 [Store A direct]
         JSR/  SYMSG      24e4 ; [external symbol] [Jump to subroutine direct]
         DW    @W2571     24e7 ; =0x2571 =9585
*
         JSR/  ABRT       24e9 ; [external symbol] [Jump to subroutine direct]
@B24EC   DB    X'0D'      24ec ; =0x0d =13
*
*
* Function @F24ED
*
@F24ED   CLA              24ed ; [Clear A]
         LDAB/ OSN0+31    24ee ; [external symbol] [Load AL direct]
         SLA              24f1 ; [Left shift A]
         LDB/  OSN0+7     24f2 ; [external symbol] [Load B direct]
         AAB              24f5 ; [A + B -> B]
         LDA+  B          24f6 ; [Load A from address in B]
         RSR              24f7 ; [Return from subroutine]
*
* Function @F24F8
*
@F24F8   LDA+  X+         24f8 ; [Load A indexed, direct, post-incremented]
         STA   @W2501     24fa ; =+5 [Store A relative]
         JSR   @F24ED     24fc ; =-17 [Jump to subroutine relative]
         JSR/  SYMSGA     24fe ; [external symbol] [Jump to subroutine direct]
@W2501   DW    X'0000'    2501 ; =0x0000 =0 =NUL,NUL
         LDA=  X'0370'    2503 ; =0x0370 =880 [Load A with immediate]
         CLRB  BL         2506 ; [Clear BL]
@D2508   DLY              2508 ; [Delay 4.55 ms]
         STBB/ OSN0+65    2509 ; [external symbol] [Store BL direct]
         DCA              250c ; [Decrement A]
         BGZ   @D2508     250d ; =-7 [Branch if greater than zero]
         JSR   @F24ED     250f ; =-36 [Jump to subroutine relative]
         LDB+  A,8        2511 ; [Load B indexed, displaced, direct]
         LDAB+ B,15       2514 ; [Load AL indexed, displaced, direct]
         BZ    @D2522     2517 ; =+9 [Branch if zero]
         LDAB/ OSN0+5     2519 ; [external symbol] [Load AL direct]
         LDBB/ @B21DD     251c ; =0x21dd =8669 [Load BL direct]
         SABB             251f ; [AL - BL -> BL]
         BNZ   @D24AF     2520 ; =-115 [Branch if not zero]
@D2522   LDA+  Z,4        2522 ; [Load A indexed, displaced, direct]
         RSR              2525 ; [Return from subroutine]
*
* Function @F2526
*
@F2526   LDAB/ @B21DD     2526 ; =0x21dd =8669 [Load AL direct]
         STAB  @B2533+1   2529 ; =+9 [Store AL relative]
         LDA/  @W21E3     252b ; =0x21e3 =8675 [Load A direct]
         JSR   @F2536     252e ; =+6 [Jump to subroutine relative]
         STA+  Z,1        2530 ; [Store A indexed, displaced, direct]
@B2533   LDAB= X'00'      2533 ; =0 =NUL [Load AL with immediate]
         RSR              2535 ; [Return from subroutine]
*
* Function @F2536
*
@F2536   LDB=  X'32C0'    2536 ; =0x32c0 =12992 [Load B with immediate]
         SAB              2539 ; [A - B -> B]
         BM    @D2544     253a ; =+8 [Branch on minus]
         XFR   B,A        253c ; [Transfer B to A]
         LDBB  @B2533+1   253e ; =-12 [Load BL relative]
         INRB  BL         2540 ; [Increment BL by 1]
         STBB  @B2533+1   2542 ; =-16 [Store BL relative]
@D2544   RSR              2544 ; [Return from subroutine]
*
@W2545   DW    X'0003'    2545 ; =0x0003 =3
         DC    'DMA'      2547 ; hex:c4cdc1
@W254A   DW    X'0004'    254a ; =0x0004 =4
         DC    'DISK'     254c ; hex:c4c9d3cb
@W2550   DW    X'0002'    2550 ; =0x0002 =2
         DC    'WE'       2552 ; hex:d7c5 dec:55237(-59)
@W2554   DW    X'0007'    2554 ; =0x0007 =7
         DC    'WP '      2556 ; hex:d7d0a0
@S2559   DC    '  '       2559 ; hex:a0a0 dec:41120(-96)
         DW    X'878D'    255b ; =0x878d =34701(-30835) =BEL,CR
@W255D   DW    X'0008'    255d ; =0x0008 =8
         DC    'FLT NN'   255f ; hex:c6ccd4a0cece
         DW    X'878D'    2565 ; =0x878d =34701(-30835) =BEL,CR
@W2567   DW    X'0008'    2567 ; =0x0008 =8
         DC    'ATN NN'   2569 ; hex:c1d4cea0cece
         DW    X'878D'    256f ; =0x878d =34701(-30835) =BEL,CR
@W2571   DW    X'0015'    2571 ; =0x0015 =21
         DC    ' FAIL: '  2573 ; hex:a0c6c1c9ccbaa0
@S257A   DC    ' X '      257a ; hex:a0d8a0
@S257D   DC    'XX'       257d ; hex:d8d8 dec:55512(-40)
@S257F   DC    'XX '      257f ; hex:d8d8a0
@S2582   DC    'XX'       2582 ; hex:d8d8 dec:55512(-40)
@S2584   DC    'XX'       2584 ; hex:d8d8 dec:55512(-40)
         DW    X'878D'    2586 ; =0x878d =34701(-30835) =BEL,CR
@W2588   DW    X'0007'    2588 ; =0x0007 =7
         DC    'DMA LAG'  258a ; hex:c4cdc1a0ccc1c7
@W2591   DW    X'0009'    2591 ; =0x0009 =9
         DC    'INTERRUPT' 2593 ; hex:c9ced4c5d2d2d5d0d4
         DW    X'FFFF'    259c ; =0xffff =65535(-1)
         DW    X'FFFF'    259e ; =0xffff =65535(-1)
         DW    X'FFFF'    25a0 ; =0xffff =65535(-1)
         DW    X'FFFF'    25a2 ; =0xffff =65535(-1)
         DW    X'FFFF'    25a4 ; =0xffff =65535(-1)
         DW    X'FFFF'    25a6 ; =0xffff =65535(-1)
         DW    X'FFFF'    25a8 ; =0xffff =65535(-1)
         DW    X'FFFF'    25aa ; =0xffff =65535(-1)
         DW    X'FFFF'    25ac ; =0xffff =65535(-1)
         DW    X'FFFF'    25ae ; =0xffff =65535(-1)
*
*
* Function IOD2R (OSNLB4/OSNLB5)
*
* I/O driver for dummy (null device).
* Read from the null device.
*
*
IOD2R    XAY              25b0 ; [Transfer A to Y]
         LDAB= X'01'      25b1 ; =1 [Load AL with immediate]
         JMP   @D25B7     25b3 ; =+2 [Jump relative]
*
* Function IOD2W (OSNLB4/OSNLB5)
*
* I/O driver for dummy (null device).
* Write to the null device.
*
*
IOD2W    XAY              25b5 ; [Transfer A to Y]
         CLAB             25b6 ; [Clear AL]
@D25B7   STAB+ Z          25b7 ; [Store AL to address in Z]
         CLAB             25b8 ; [Clear AL]
         STAB+ *Y,3       25b9 ; [Store AL indexed, displaced, indirect]
         STAB+ *Y,5       25bc ; [Store AL indexed, displaced, indirect]
         LDX+  S+         25bf ; [Pop X from the stack]
         LDA+  S+         25c1 ; [Pop A from the stack]
         XAY              25c3 ; [Transfer A to Y]
         LDA+  S+         25c4 ; [Pop A from the stack]
         XAZ              25c6 ; [Transfer A to Z]
         RSR              25c7 ; [Return from subroutine]
*
* Function IODFR (OSNLB5)
*
* I/O driver for 4-port MUX.
* Read from the 4-port MUX.
*
*
* Exts:
*   WAIT
*   OSN0
*
IODFR    XAY              25c8 ; [Transfer A to Y]
         CLAB             25c9 ; [Clear AL]
         STAB+ *Y,5       25ca ; [Store AL indexed, displaced, indirect]
         JSR   @F262A     25cd ; =+91 [Jump to subroutine relative]
         STBB+ A,8        25cf ; [Store BL indexed, displaced, direct]
         XFR   Z,A        25d2 ; [Transfer Z to A]
         STA+  Y,16       25d4 ; [Store A indexed, displaced, direct]
         CLA              25d7 ; [Clear A]
         STA+  *Z,6       25d8 ; [Store A indexed, displaced, indirect]
         INAB             25db ; [Increment AL]
         STAB+ Y,13       25dc ; [Store AL indexed, displaced, direct]
         JSR   @F262A     25df ; =+73 [Jump to subroutine relative]
         STBB+ A,8        25e1 ; [Store BL indexed, displaced, direct]
@D25E4   LDX+  S+         25e4 ; [Pop X from the stack]
         LDA+  S+         25e6 ; [Pop A from the stack]
         XAY              25e8 ; [Transfer A to Y]
         LDA+  S+         25e9 ; [Pop A from the stack]
         XAZ              25eb ; [Transfer A to Z]
         RSR              25ec ; [Return from subroutine]
*
* Function IODFW (OSNLB5)
*
* I/O driver for 4-port MUX.
* Write to the 4-port MUX.
*
*
IODFW    XAY              25ed ; [Transfer A to Y]
         LDA+  Y,29       25ee ; [Load A indexed, displaced, direct]
         BZ    @D25F5     25f1 ; =+2 [Branch if zero]
         JSR+  A          25f3 ; [Jump to subroutine indexed, direct]
@D25F5   XFR   Z,A        25f5 ; [Transfer Z to A]
         STA+  Y,16       25f7 ; [Store A indexed, displaced, direct]
         CLA              25fa ; [Clear A]
         STAB+ *Y,5       25fb ; [Store AL indexed, displaced, indirect]
         STA+  Z,8        25fe ; [Store A indexed, displaced, direct]
         DCAB             2601 ; [Decrement AL]
         STAB+ Y,13       2602 ; [Store AL indexed, displaced, direct]
         JSR   @F262A     2605 ; =+35 [Jump to subroutine relative]
         INRB  BL         2607 ; [Increment BL by 1]
         STBB+ A,8        2609 ; [Store BL indexed, displaced, direct]
@D260C   LDAB= X'20'      260c ; =32 [Load AL with immediate]
         LDBB+ *Y,21      260e ; [Load BL indexed, displaced, indirect]
         NABB             2611 ; [AL & BL -> BL]
         BNZ   @D2619     2612 ; =+5 [Branch if not zero]
         JSR/  WAIT       2614 ; [external symbol] [Jump to subroutine direct]
         JMP   @D260C     2617 ; =-13 [Jump relative]
@D2619   LDAB+ *Y,21      2619 ; [Load AL indexed, displaced, indirect]
         SRAB             261c ; [Arithmetic right shift AL]
         SRAB             261d ; [Arithmetic right shift AL]
         BNL   @D25E4     261e ; =-60 [Branch on no link]
         LDB+  Y,21       2620 ; [Load B indexed, displaced, direct]
         LDAB= X'94'      2623 ; =148(-108) [Load AL with immediate]
         STAB+ B,1        2625 ; [Store AL indexed, displaced, direct]
         JMP   @D25E4     2628 ; =-70 [Jump relative]
*
* Function @F262A
*
@F262A   LDA+  Y,21       262a ; [Load A indexed, displaced, direct]
         LDBB= X'06'      262d ; =6 [Load BL with immediate]
         NABB             262f ; [AL & BL -> BL]
         OREB  BL,AL      2630 ; [BL ^ AL -> AL]
         RSR              2632 ; [Return from subroutine]
*
* Function >MUXISR
*
*
>MUXISR  LDA=  X'F20F'    2633 ; =0xf20f =61967(-3569) [Load A with immediate]
         LDAB+ A          2636 ; [Load AL from address in A]
         XAZ              2637 ; [Transfer A to Z]
         LDA=  X'06F0'    2638 ; =0x06f0 =1776 [Load A with immediate]
         ANDB  ZL,AU      263b ; [ZL & AU -> AU]
         ANDB  ZL,AL      263d ; [ZL & AL -> AL]
         SRAB             263f ; [Arithmetic right shift AL]
         ORIB  AU,AL      2640 ; [AU | AL -> AL]
         CLRB  AU         2642 ; [Clear AU]
         LDB/  OSN0+11    2644 ; [external symbol] [Load B direct]
         LDX+  B+         2647 ; [Load X indexed, direct, post-incremented]
         SUB   A,X        2649 ; [A - X -> X]
         BM    @D2650     264b ; =+3 [Branch on minus]
         LDA+  Z          264d ; [Load A from address in Z]
         JMP   @D26BC     264e ; =+108 [Jump relative]
@D2650   AAB              2650 ; [A + B -> B]
         LDA+  B          2651 ; [Load A from address in B]
         XAY              2652 ; [Transfer A to Y]
         LDAB+ Y          2653 ; [Load AL from address in Y]
         BZ    @D26C6     2654 ; =+112 [Branch if zero]
         LDA+  Y,27       2656 ; [Load A indexed, displaced, direct]
         BZ    @D265F     2659 ; =+4 [Branch if zero]
         JSR+  A          265b ; [Jump to subroutine indexed, direct]
         JMP   @D26BC     265d ; =+93 [Jump relative]
@D265F   LDAB= X'01'      265f ; =1 [Load AL with immediate]
         ANDB  ZL,AL      2661 ; [ZL & AL -> AL]
         BZ    @D2668     2663 ; =+3 [Branch if zero]
         JMP/  @J2741     2665 ; =0x2741 =10049 [Jump direct]
@D2668   LDA+  Z          2668 ; [Load A from address in Z]
         LDBB= X'80'      2669 ; =128(-128) [Load BL with immediate]
         ORIB  BL,AL      266b ; [BL | AL -> AL]
         LDBB= X'1C'      266d ; =28 [Load BL with immediate]
         ANDB  AU,BL      266f ; [AU & BL -> BL]
         BNZ   >MIBEL     2671 ; =+77 [Branch if not zero]
         STAB/ @B272D+1   2673 ; =0x272e =10030 [Store AL direct]
         LDX+  Y,29       2676 ; [Load X indexed, displaced, direct]
         BZ    @D2686     2679 ; =+11 [Branch if zero]
         INX              267b ; [Increment X]
         INX              267c ; [Increment X]
@D267D   LDB+  X+         267d ; [Load B indexed, direct, post-incremented]
         BZ    @D2686     267f ; =+5 [Branch if zero]
         SABB             2681 ; [AL - BL -> BL]
         BNZ   @D267D     2682 ; =-7 [Branch if not zero]
         XFRB  BU,AL      2684 ; [Transfer BU to AL]
@D2686   LDBB+ Y,19       2686 ; [Load BL indexed, displaced, direct]
         SABB             2689 ; [AL - BL -> BL]
         BNZ   @D2696     268a ; =+10 [Branch if not zero]
         LDAB= X'01'      268c ; =1 [Load AL with immediate]
         STAB+ Y,15       268e ; [Store AL indexed, displaced, direct]
         STAB/ OSN0+62    2691 ; [external symbol] [Store AL direct]
         JMP   @D26BC     2694 ; =+38 [Jump relative]
@D2696   LDBB= X'82'      2696 ; =130(-126) [Load BL with immediate]
         SABB             2698 ; [AL - BL -> BL]
         BNZ   @D26C8     2699 ; =+45 [Branch if not zero]
         XFRB  AL,AU      269b ; [Transfer AL to AU]
         LDAB$ X'001A'    269d ; =0x001a =26 [Load AL indirect]
         LDBB= X'73'      26a0 ; =115 [Load BL with immediate]
         SABB             26a2 ; [AL - BL -> BL]
         BNZ   >MIBEL     26a3 ; =+27 [Branch if not zero]
         LDB=  X'00FE'    26a5 ; =0x00fe =254 =NUL,'~' [Load B with immediate]
         LDAB= X'0E'      26a8 ; =14 [Load AL with immediate]
         ORIB  CU,AL      26aa ; [CU | AL -> AL]
         NABB             26ac ; [AL & BL -> BL]
         STB-  S-         26ad ; [Push B to the stack]
         LDA/  X'001A'    26af ; =0x001a =26 [Load A direct]
         INA              26b2 ; [Increment A]
         INA              26b3 ; [Increment A]
         LDB+  *S         26b4 ; [Load B indexed, indirect]
         STB+  A+         26b6 ; [Store B indexed, direct, post-incremented]
         STA+  *S         26b8 ; [Store A indexed, indirect]
         LDA+  S+         26ba ; [Pop A from the stack]
@D26BC   RI               26bc ; [Return from interrupt]
*
* Function >MIJMP
*
*
>MIJMP   JMP/  >MUXISR    26bd ; =0x2633 =9779 [Jump direct]
*
* Function >MIBEL
*
*
>MIBEL   LDAB= X'87'      26c0 ; =135(-121) =BEL [Load AL with immediate]
@D26C2   JSR   >MWAIT     26c2 ; =+109 [Jump to subroutine relative]
         JMP   @D26BC     26c4 ; =-10 [Jump relative]
@D26C6   JMP   @D2722     26c6 ; =+90 [Jump relative]
@D26C8   LDBB+ Y,13       26c8 ; [Load BL indexed, displaced, direct]
         BLE   >MIBEL     26cb ; =-13 [Branch if less than or equal to zero]
         XABB             26cd ; [Transfer AL to BL]
         BM    @D2707     26ce ; =+55 [Branch on minus]
         DCAB             26d0 ; [Decrement AL]
         BZ    @D26BC     26d1 ; =-23 [Branch if zero]
         DCAB             26d3 ; [Decrement AL]
         BNZ   @D26F3     26d4 ; =+29 [Branch if not zero]
         LDB+  Y,29       26d6 ; [Load B indexed, displaced, direct]
         LDAB+ B,3        26d9 ; [Load AL indexed, displaced, direct]
         STAB  @B26EC+1   26dc ; =+15 [Store AL relative]
         LDB+  Y,16       26de ; [Load B indexed, displaced, direct]
         LDB+  *B,6       26e1 ; [Load B indexed, displaced, indirect]
         BZ    @D26BC     26e4 ; =-42 [Branch if zero]
         JSR   >MWAIT     26e6 ; =+73 [Jump to subroutine relative]
         LDAB= X'A0'      26e8 ; =160(-96) =' ' [Load AL with immediate]
         JSR   >MWAIT     26ea ; =+69 [Jump to subroutine relative]
@B26EC   LDAB= X'88'      26ec ; =136(-120) =BS [Load AL with immediate]
         JSR   >MWAIT     26ee ; =+65 [Jump to subroutine relative]
         CLAB             26f0 ; [Clear AL]
         JMP   @D2709     26f1 ; =+22 [Jump relative]
@D26F3   DCAB             26f3 ; [Decrement AL]
         BNZ   @D26FA     26f4 ; =+4 [Branch if not zero]
         LDAB= X'AB'      26f6 ; =171(-85) ='+' [Load AL with immediate]
         JMP   @D26FF     26f8 ; =+5 [Jump relative]
@D26FA   DCAB             26fa ; [Decrement AL]
         BNZ   @D272A     26fb ; =+45 [Branch if not zero]
         LDAB= X'AD'      26fd ; =173(-83) ='-' [Load AL with immediate]
@D26FF   JSR/  >MWAIT     26ff ; =0x2731 =10033 [Jump to subroutine direct]
         JSR/  ICHR       2702 ; =0x27a5 =10149 [Jump to subroutine direct]
         LDAB= X'8D'      2705 ; =141(-115) =CR [Load AL with immediate]
@D2707   JSR   >MWAIT     2707 ; =+40 [Jump to subroutine relative]
@D2709   JSR/  ICHR       2709 ; =0x27a5 =10149 [Jump to subroutine direct]
         BNZ   @D2728     270c ; =+26 [Branch if not zero]
         LDBB+ Y,14       270e ; [Load BL indexed, displaced, direct]
         BZ    @D26BC     2711 ; =-87 [Branch if zero]
         LDAB= X'8A'      2713 ; =138(-118) =LF [Load AL with immediate]
         SABB             2715 ; [AL - BL -> BL]
         BZ    @D271A     2716 ; =+2 [Branch if zero]
         JSR   >MWAIT     2718 ; =+23 [Jump to subroutine relative]
@D271A   BNZ   @D26BC     271a ; =-96 [Branch if not zero]
         LDAB= X'8D'      271c ; =141(-115) =CR [Load AL with immediate]
         JSR   >MWAIT     271e ; =+17 [Jump to subroutine relative]
         JMP   @D26BC     2720 ; =-102 [Jump relative]
@D2722   LDB+  Y,21       2722 ; [Load B indexed, displaced, direct]
         LDAB+ B,1        2725 ; [Load AL indexed, displaced, direct]
@D2728   JMP   @D26BC     2728 ; =-110 [Jump relative]
@D272A   DCAB             272a ; [Decrement AL]
         BNZ   @D26BC     272b ; =-113 [Branch if not zero]
@B272D   LDAB= X'00'      272d ; =0 =NUL [Load AL with immediate]
         JMP   @D26C2     272f ; =-111 [Jump relative]
*
* Function >MWAIT
*
*
>MWAIT   LDBB+ *Y,21      2731 ; [Load BL indexed, displaced, indirect]
         SRRB  BL         2734 ; [Arithmetic right shift BL by 1]
         SRRB  BL         2736 ; [Arithmetic right shift BL by 1]
         BNL   >MWAIT     2738 ; =-9 [Branch on no link]
         LDB+  Y,21       273a ; [Load B indexed, displaced, direct]
         STAB+ B,1        273d ; [Store AL indexed, displaced, direct]
         RSR              2740 ; [Return from subroutine]
*
@J2741   LDAB+ *Y,21      2741 ; [Load AL indexed, displaced, indirect]
         SRAB             2744 ; [Arithmetic right shift AL]
         SRAB             2745 ; [Arithmetic right shift AL]
         BNL   @D2728     2746 ; =-32 [Branch on no link]
         LDBB+ Y,13       2748 ; [Load BL indexed, displaced, direct]
         BP    @D2728     274b ; =-37 [Branch on plus]
         JSR   OCHR       274d ; =+43 [Jump to subroutine relative]
         BZ    @D2728     274f ; =-41 [Branch if zero]
         JSR   >MWAIT     2751 ; =-34 [Jump to subroutine relative]
         STAB+ Y,14       2753 ; [Store AL indexed, displaced, direct]
         LDBB= X'8C'      2756 ; =140(-116) =FF [Load BL with immediate]
         SABB             2758 ; [AL - BL -> BL]
         BNZ   @D275E     2759 ; =+3 [Branch if not zero]
         DLY              275b ; [Delay 4.55 ms]
         JMP   @D2772     275c ; =+20 [Jump relative]
@D275E   INAB             275e ; [Increment AL]
         BNZ   @D2764     275f ; =+3 [Branch if not zero]
         DLY              2761 ; [Delay 4.55 ms]
         JMP   @D2728     2762 ; =-60 [Jump relative]
@D2764   LDBB= X'8E'      2764 ; =142(-114) [Load BL with immediate]
         SABB             2766 ; [AL - BL -> BL]
         BNZ   @D2728     2767 ; =-65 [Branch if not zero]
         LDAB= X'8A'      2769 ; =138(-118) =LF [Load AL with immediate]
         JSR   >MWAIT     276b ; =-60 [Jump to subroutine relative]
         LDAB= X'8D'      276d ; =141(-115) =CR [Load AL with immediate]
         STAB+ Y,14       276f ; [Store AL indexed, displaced, direct]
@D2772   LDA=  X'0FA0'    2772 ; =0x0fa0 =4000 [Load A with immediate]
         STA+  Z,8        2775 ; [Store A indexed, displaced, direct]
         JMP   @D2728     2778 ; =-82 [Jump relative]
*
* Function OCHR (OSNLB5)
*
* Output character to the 4-port MUX.
*
*
OCHR     LDA+  Y,16       277a ; [Load A indexed, displaced, direct]
         XAZ              277d ; [Transfer A to Z]
         STX-  S-         277e ; [Push X to the stack]
         LDA+  Z,8        2780 ; [Load A indexed, displaced, direct]
         LDX+  Z,6        2783 ; [Load X indexed, displaced, direct]
         LDB+  X+         2786 ; [Load B indexed, direct, post-incremented]
         ADD   A,X        2788 ; [A + X -> X]
         INA              278a ; [Increment A]
         SAB              278b ; [A - B -> B]
         BLE   @D2799     278c ; =+11 [Branch if less than or equal to zero]
         LDX+  S+         278e ; [Pop X from the stack]
@D2790   CLAB             2790 ; [Clear AL]
         STAB+ Y,13       2791 ; [Store AL indexed, displaced, direct]
         STAB+ *Y,3       2794 ; [Store AL indexed, displaced, indirect]
         STAB+ Z          2797 ; [Store AL to address in Z]
         RSR              2798 ; [Return from subroutine]
*
@D2799   STA+  Z,8        2799 ; [Store A indexed, displaced, direct]
         LDAB+ X          279c ; [Load AL from address in X]
         LDX+  S+         279d ; [Pop X from the stack]
         LDBB= X'84'      279f ; =132(-124) =EOT [Load BL with immediate]
         SABB             27a1 ; [AL - BL -> BL]
         BZ    @D2790     27a2 ; =-20 [Branch if zero]
         RSR              27a4 ; [Return from subroutine]
*
* Function ICHR (OSNLB5)
*
* Input character from the 4-port MUX.
*
*
ICHR     LDB+  Y,16       27a5 ; [Load B indexed, displaced, direct]
         XFR   B,Z        27a8 ; [Transfer B to Z]
         LDBB= X'8D'      27aa ; =141(-115) =CR [Load BL with immediate]
         SABB             27ac ; [AL - BL -> BL]
         BZ    @D27B4     27ad ; =+5 [Branch if zero]
         LDBB= X'8A'      27af ; =138(-118) =LF [Load BL with immediate]
         SABB             27b1 ; [AL - BL -> BL]
         BNZ   @D27C1     27b2 ; =+13 [Branch if not zero]
@D27B4   STAB+ Y,14       27b4 ; [Store AL indexed, displaced, direct]
@D27B7   LDB+  Z,6        27b7 ; [Load B indexed, displaced, direct]
         LDA+  B+         27ba ; [Load A indexed, direct, post-incremented]
         AAB              27bc ; [A + B -> B]
         CLAB             27bd ; [Clear AL]
         STAB+ B          27be ; [Store AL to address in B]
         JMP   @D2790     27bf ; =-49 [Jump relative]
@D27C1   STX-  S-         27c1 ; [Push X to the stack]
         LDX+  Z,6        27c3 ; [Load X indexed, displaced, direct]
         XABB             27c6 ; [Transfer AL to BL]
         BM    @D27D1     27c7 ; =+8 [Branch on minus]
         LDA+  X          27c9 ; [Load A from address in X]
         BLE   @D27CE     27ca ; =+2 [Branch if less than or equal to zero]
         DCA              27cc ; [Decrement A]
         STA+  X          27cd ; [Store A to address in X]
@D27CE   LDX+  S+         27ce ; [Pop X from the stack]
         RSR              27d0 ; [Return from subroutine]
*
@D27D1   XABB             27d1 ; [Transfer AL to BL]
         LDA+  X          27d2 ; [Load A from address in X]
         INA              27d3 ; [Increment A]
         STA+  X+         27d4 ; [Store A indexed, direct, post-incremented]
         ADD   A,X        27d6 ; [A + X -> X]
         STBB- X-         27d8 ; [Store BL indexed, pre-decremented, direct]
         LDB+  Z,4        27da ; [Load B indexed, displaced, direct]
         SAB              27dd ; [A - B -> B]
         BM    @D27CE     27de ; =-18 [Branch on minus]
         LDX+  S+         27e0 ; [Pop X from the stack]
         CLAB             27e2 ; [Clear AL]
         STAB+ Y,14       27e3 ; [Store AL indexed, displaced, direct]
         JMP   @D27B7     27e6 ; =-49 [Jump relative]
*
* Function IODFI (OSNLB5)
*
* I/O driver for 4-port MUX.
* Initialize the 4-port MUX.
*
*
IODFI    LDA=  IODJBT     27e8 ; =0x282f =10287 [Load A with immediate]
         STA/  X'006A'    27eb ; =0x006a =106 [Store A direct]
         LDA=  >MUXISR    27ee ; =0x2633 =9779 [Load A with immediate]
         STA/  X'006E'    27f1 ; =0x006e =110 [Store A direct]
         XFR   Y,A        27f4 ; [Transfer Y to A]
         STA-  S-         27f6 ; [Push A to the stack]
         STX-  S-         27f8 ; [Push X to the stack]
         LDA/  OSN0+11    27fa ; [external symbol] [Load A direct]
         LDX+  A+         27fd ; [Load X indexed, direct, post-incremented]
         SRR   X          27ff ; [Arithmetic right shift X by 1]
         XAY              2801 ; [Transfer A to Y]
@D2802   LDA+  Y+         2802 ; [Load A indexed, direct, post-incremented]
         LDBB+ A          2804 ; [Load BL from address in A]
         BZ    @D2826     2805 ; =+31 [Branch if zero]
         LDBB+ A,23       2807 ; [Load BL indexed, displaced, direct]
         STBB+ *A,21      280a ; [Store BL indexed, displaced, indirect]
         LDA+  A,21       280d ; [Load A indexed, displaced, direct]
         LDBB= X'94'      2810 ; =148(-108) [Load BL with immediate]
         STBB+ A,1        2812 ; [Store BL indexed, displaced, direct]
         LDBB= X'F0'      2815 ; =240(-16) ='p' [Load BL with immediate]
         ANDB  BL,AL      2817 ; [BL & AL -> AL]
         LDBB= X'06'      2819 ; =6 [Load BL with immediate]
         STBB+ A,10       281b ; [Store BL indexed, displaced, direct]
         STBB+ A,14       281e ; [Store BL indexed, displaced, direct]
         LDBB= X'E0'      2821 ; =224(-32) ='`' [Load BL with immediate]
         STBB+ A,11       2823 ; [Store BL indexed, displaced, direct]
@D2826   DCX              2826 ; [Decrement X]
         BGZ   @D2802     2827 ; =-39 [Branch if greater than zero]
         LDX+  S+         2829 ; [Pop X from the stack]
         LDA+  S+         282b ; [Pop A from the stack]
         XAY              282d ; [Transfer A to Y]
         RSR              282e ; [Return from subroutine]
*
* Function IODJBT (OSNLB4/OSNLB5)
*
* SVC GB - get binary time
* Loads the timestamp to a 32-bit integer.
*
* ASM:
*   Clobbers: A, B
*     JSR/ IODJBT
*     DW INT      ; address of 32-bit integer
*
* Exts:
*   OSN0
*   DATE
*   ABRT
*   @HEX16
*   @HEX
*   SYMSG
*
IODJBT   LDA+  X+         282f ; [Load A indexed, direct, post-incremented]
@W2831   LDB=  X'0000'    2831 ; =0x0000 =0 =NUL,NUL [Load B with immediate]
         STB+  A+         2834 ; [Store B indexed, direct, post-incremented]
         LDB/  X'00A6'    2836 ; =0x00a6 =166 =NUL,'&' [Load B direct]
         STB+  A          2839 ; [Store B to address in A]
         RSR              283a ; [Return from subroutine]
*
* Function IODJCT (OSNLB4/OSNLB5)
*
* SVC GC - get character time
* Loads the time as hh:mm:ss into a string.
*
* ASM:
*   Clobbers: A, B
*     JSR/ IODJCT
*     DW STR      ; address of string
*
IODJCT   XFR   Y,A        283b ; [Transfer Y to A]
         STA-  S-         283d ; [Push A to the stack]
         LDA+  X+         283f ; [Load A indexed, direct, post-incremented]
         XAY              2841 ; [Transfer A to Y]
         LDB=  IODJT      2842 ; =0x2858 =10328 [Load B with immediate]
         LDA+  B+         2845 ; [Load A indexed, direct, post-incremented]
@D2847   STA+  Y+         2847 ; [Store A indexed, direct, post-incremented]
         LDAB= X'BA'      2849 ; =186(-70) =':' [Load AL with immediate]
         STAB+ Y+         284b ; [Store AL indexed, direct, post-incremented]
         LDA+  B+         284d ; [Load A indexed, direct, post-incremented]
         BNZ   @D2847     284f ; =-10 [Branch if not zero]
         CLAB             2851 ; [Clear AL]
         STAB- Y-         2852 ; [Store AL indexed, pre-decremented, direct]
         LDA+  S+         2854 ; [Pop A from the stack]
         XAY              2856 ; [Transfer A to Y]
         RSR              2857 ; [Return from subroutine]
*
* Function IODJT (OSNLB4/OSNLB5)
*
* Character time hhmmss string.
*
*
IODJT    DC    '00'       2858 ; hex:b0b0 dec:45232(-80)
@S285A   DC    '00'       285a ; hex:b0b0 dec:45232(-80)
@S285C   DC    '00'       285c ; hex:b0b0 dec:45232(-80)
         DB    X'00'      285e ; =0x00 =0 =NUL
         DB    X'00'      285f ; =0x00 =0 =NUL
*
*
* Function IODJI (OSNLB4/OSNLB5)
*
* Initializes the timer device subsystem.
*
*
IODJI    LDA=  >CKISR     2860 ; =0x2898 =10392 [Load A with immediate]
         STA/  X'00AE'    2863 ; level 10 register P
         LDA=  >CKRI      2866 ; =0x2887 =10375 [Load A with immediate]
         STA/  X'00AA'    2869 ; level 10 register S
         LDA=  >ABISR     286c ; =0x290d =10509 [Load A with immediate]
         STA/  X'00FE'    286f ; level 15 register P
         CLA              2872 ; [Clear A]
         STA/  X'00A8'    2873 ; level 10 register Z
         LDA=  X'7FFF'    2876 ; =0x7fff =32767 [Load A with immediate]
         STA/  X'00A4'    2879 ; level 10 register X
         CLRB  AU,1       287c ; AU=1 on CPU-6, 0 on 5
         BNZ   @D2885     287e ; =+5 [Branch if not zero]
         LDA=  X'0101'    2880 ; =0x0101 =257 [Load A with immediate]
         STA   @D288D     2883 ; =+8 [Store A relative]
@D2885   ECK              2885 ; [Enable clock]
         RSR              2886 ; [Return from subroutine]
*
* Function >CKRI
*
>CKRI    LDX=  X'000A'    2887 ; =0x000a =10 [Load X with immediate]
@D288A   LDA=  X'0006'    288a ; =0x0006 =6 [Load A with immediate]
@D288D   INRB  ZL         288d ; [Increment ZL by 1]
         BP    @D2897     288f ; =+6 [Branch on plus]
         CLRB  BL         2891 ; [Clear BL]
         STBB* @P28A8+1   2893 ; =+20 [Store BL relative indirect]
         JMP   >CKISR     2895 ; =+1 [Jump relative]
@D2897   RI               2897 ; [Return from interrupt]
*
* Function >CKISR
*
>CKISR   DCA              2898 ; [Decrement A]
         BGZ   @D288D     2899 ; =-14 [Branch if greater than zero]
         INA              289b ; [Increment A]
         ADD   A,Y        289c ; [A + Y -> Y]
         BNL   @D28A5     289e ; =+5 [Branch on no link]
         LDA   @W2831+1   28a0 ; =-112 [Load A relative]
         INA              28a2 ; [Increment A]
         STA   @W2831+1   28a3 ; =-115 [Store A relative]
@D28A5   DCX              28a5 ; [Decrement X]
         BGZ   @D288A     28a6 ; =-30 [Branch if greater than zero]
@P28A8   LDAB/ OSN0+65    28a8 ; [external symbol] [Load AL direct]
         BZ    @D28B9     28ab ; =+12 [Branch if zero]
         LDAB= X'F0'      28ad ; =240(-16) ='p' [Load AL with immediate]
         ANDB  CU,AL      28af ; [CU & AL -> AL]
         BNZ   @D28B9     28b1 ; =+6 [Branch if not zero]
         LDA=  >ABRT0     28b3 ; =0x2909 =10505 [Load A with immediate]
         STA/  X'000E'    28b6 ; =0x000e =14 [Store A direct]
@D28B9   DCAB             28b9 ; [Decrement AL]
         STAB* @P28A8+1   28ba ; =-19 [Store AL relative indirect]
         LDA   @S285C     28bc ; =-98 [Load A relative]
         LDX=  X'B6B0'    28be ; =0xb6b0 =46768(-18768) ='6','0' [Load X with immediate]
         JSR   @F28EF     28c1 ; =+44 [Jump to subroutine relative]
         STA   @S285C     28c3 ; =-105 [Store A relative]
         LDA   @D2903+1   28c5 ; =+61 [Load A relative]
         BNZ   >CKRI      28c7 ; =-66 [Branch if not zero]
         LDA   @S285A     28c9 ; =-113 [Load A relative]
         JSR   @F28EF     28cb ; =+34 [Jump to subroutine relative]
         STA   @S285A     28cd ; =-117 [Store A relative]
         LDA   @D2903+1   28cf ; =+51 [Load A relative]
         BNZ   >CKRI      28d1 ; =-76 [Branch if not zero]
         LDA   IODJT      28d3 ; =-125 [Load A relative]
         LDX=  X'B2B4'    28d5 ; =0xb2b4 =45748(-19788) ='2','4' [Load X with immediate]
         JSR   @F28EF     28d8 ; =+21 [Jump to subroutine relative]
         STA/  IODJT      28da ; =0x2858 =10328 [Store A direct]
         LDA   @D2903+1   28dd ; =+37 [Load A relative]
         BNZ   >CKRI      28df ; =-90 [Branch if not zero]
         CLA              28e1 ; [Clear A]
         XAY              28e2 ; [Transfer A to Y]
         STA/  @W2831+1   28e3 ; =0x2832 =10290 [Store A direct]
         LDA/  DATE       28e6 ; [external symbol] [Load A direct]
         INA              28e9 ; [Increment A]
         STA/  DATE       28ea ; [external symbol] [Store A direct]
         JMP   >CKRI      28ed ; =-104 [Jump relative]
*
* Function @F28EF
*
@F28EF   INA              28ef ; [Increment A]
         LDBB= X'B9'      28f0 ; =185(-71) ='9' [Load BL with immediate]
         SABB             28f2 ; [AL - BL -> BL]
         BLE   @D28FA     28f3 ; =+5 [Branch if less than or equal to zero]
         LDB=  X'00F6'    28f5 ; =0x00f6 =246 =NUL,'v' [Load B with immediate]
         ADD   B,A        28f8 ; [B + A -> A]
@D28FA   LDB+  S          28fa ; [Load B from address in S]
         SAB              28fb ; [A - B -> B]
         BM    @D2903     28fc ; =+5 [Branch on minus]
         LDA=  X'B0B0'    28fe ; =0xb0b0 =45232(-20304) ='0','0' [Load A with immediate]
         CLR   B          2901 ; [Clear B]
@D2903   STB=  X'0000'    2903 ; =0x0000 =0 =NUL,NUL [Store B immediate]
         RSR              2906 ; [Return from subroutine]
*
* Function IODJZ (OSNLB4/OSNLB5)
*
* Timer interrupt level Z register address.
*
*
IODJZ    DW    X'00A8'    2907 ; =0x00a8 =168 =NUL,'('
*
*
* Function >ABRT0
*
>ABRT0   JSR/  ABRT       2909 ; [external symbol] [Jump to subroutine direct]
         DB    X'21'      290c ; =0x21 =33
*
*
* Function >ABISR
*
>ABISR   STAB  @B2934+1   290d ; =+38 [Store AL relative]
         LDA=  X'00F0'    290f ; =0x00f0 =240 =NUL,'p' [Load A with immediate]
         ANDB  CU,AL      2912 ; [CU & AL -> AL]
         LDB+  A,14       2914 ; [Load B indexed, displaced, direct]
         STB   @W292C+1   2917 ; =+20 [Store B relative]
         LDB=  @W292C     2919 ; =0x292c =10540 [Load B with immediate]
         STB/  X'000E'    291c ; =0x000e =14 [Store B direct]
         SLA              291f ; [Left shift A]
         SLA              2920 ; [Left shift A]
         SLA              2921 ; [Left shift A]
         SLA              2922 ; [Left shift A]
         XFRB  AU,AL      2923 ; [Transfer AU to AL]
         STAB  @B293B+1   2925 ; =+21 [Store AL relative]
         CLR   C          2927 ; [Clear C]
         RI               2929 ; [Return from interrupt]
*
         JMP   >ABISR     292a ; =-31 [Jump relative]
@W292C   LDA=  X'0000'    292c ; =0x0000 =0 =NUL,NUL [Load A with immediate]
         JSR/  @HEX16     292f ; [external symbol] [Jump to subroutine direct]
         DW    @S2962     2932 ; =0x2962 =10594
@B2934   LDAB= X'00'      2934 ; =0 =NUL [Load AL with immediate]
         JSR/  @HEX       2936 ; [external symbol] [Jump to subroutine direct]
         STA   @S2954     2939 ; =+25 [Store A relative]
@B293B   LDAB= X'00'      293b ; =0 =NUL [Load AL with immediate]
         JSR/  @HEX       293d ; [external symbol] [Jump to subroutine direct]
         STAB  @S295B     2940 ; =+25 [Store AL relative]
         JSR/  SYMSG      2942 ; [external symbol] [Jump to subroutine direct]
         DW    @W2949     2945 ; =0x2949 =10569
         JMP   >ABRT0     2947 ; =-64 [Jump relative]
*
@W2949   DW    X'001C'    2949 ; =0x001c =28
         DC    'LVL15 CD:' 294b ; hex:ccd6ccb1b5a0c3c4ba
@S2954   DC    '@@ LVL:'  2954 ; hex:c0c0a0ccd6ccba
@S295B   DC    '@ ADDR:'  295b ; hex:c0a0c1c4c4d2ba
@S2962   DC    '@@@@'     2962 ; hex:c0c0c0c0
         DB    X'8D'      2966 ; =0x8d =141(-115) =CR
*
*
* Function IODS (OSNLB4/OSNLB5)
*
* I/O driver for the print spooler.
*
* ASM:
*     JSR/ IODS
*
IODS     LDA   IODSI+1    2967 ; =+17 [Load A relative]
         BZ    @D2971     2969 ; =+6 [Branch if zero]
         JSR   @F29AF     296b ; =+66 [Jump to subroutine relative]
         BZ    @D2971     296d ; =+2 [Branch if zero]
         JMP*  IODSI+1    296f ; =+9 [Jump relative]
@D2971   CLA              2971 ; [Clear A]
         STA   @F29AF+1   2972 ; =+60 [Store A relative]
         JSR$  X'005A'    2974 ; =0x005a =90 [Jump to subroutine indirect]
         DW    X'0914'    2977 ; =0x0914 =2324
*
*
* Function IODSI (OSNLB4/OSNLB5)
*
* I/O driver for the print spooler.
*
* ASM:
*     JSR/ IODSI
*
IODSI    LDA=  X'0000'    2979 ; =0x0000 =0 =NUL,NUL [Load A with immediate]
         BZ    @D2982     297c ; =+4 [Branch if zero]
         JSR   @F29AF     297e ; =+47 [Jump to subroutine relative]
         BNZ   @D298C     2980 ; =+10 [Branch if not zero]
@D2982   LDA+  Z,8        2982 ; [Load A indexed, displaced, direct]
         STA   IODSI+1    2985 ; =-13 [Store A relative]
         LDA+  Z,6        2987 ; [Load A indexed, displaced, direct]
         STA   @F29AF+1   298a ; =+36 [Store A relative]
@D298C   CLAB             298c ; [Clear AL]
         STAB+ *X,3       298d ; [Store AL indexed, displaced, indirect]
         STAB+ *X,5       2990 ; [Store AL indexed, displaced, indirect]
         STAB+ Z          2993 ; [Store AL to address in Z]
         LDX+  S+         2994 ; [Pop X from the stack]
         LDA+  S+         2996 ; [Pop A from the stack]
         XAY              2998 ; [Transfer A to Y]
         LDA+  S+         2999 ; [Pop A from the stack]
         XAZ              299b ; [Transfer A to Z]
         RSR              299c ; [Return from subroutine]
*
* Function IODSV (OSNLB4/OSNLB5)
*
* I/O driver for the print spooler.
*
* ASM:
*     JSR/ IODSV
*
IODSV    CLA              299d ; [Clear A]
         STAB+ *X,3       299e ; [Store AL indexed, displaced, indirect]
         STAB+ *X,5       29a1 ; [Store AL indexed, displaced, indirect]
         LDX+  S+         29a4 ; [Pop X from the stack]
         LDA+  S+         29a6 ; [Pop A from the stack]
         XAY              29a8 ; [Transfer A to Y]
         LDA+  S+         29a9 ; [Pop A from the stack]
         XAZ              29ab ; [Transfer A to Z]
         JSR   @F29AF     29ac ; =+1 [Jump to subroutine relative]
         RSR              29ae ; [Return from subroutine]
*
* Function @F29AF
*
@F29AF   LDA=  X'0000'    29af ; =0x0000 =0 =NUL,NUL [Load A with immediate]
         BZ    @D29BA     29b2 ; =+6 [Branch if zero]
         LDAB+ A,18       29b4 ; [Load AL indexed, displaced, direct]
         LDBB= X'08'      29b7 ; =8 [Load BL with immediate]
         NABB             29b9 ; [AL & BL -> BL]
@D29BA   RSR              29ba ; [Return from subroutine]
*
* Function SYMSG (OSNLB4/OSNLB5)
*
* Prints a system message.
* The message is printed to the current task console.
* If there is no current task it is printed to the first console.
*
* ASM:
*   Clobbers: A, B
*     JSR/ SYMSG
*     DW STR     ; address of word length-prefixed string
*
* Exts:
*   OSN0
*   OSN3B
*   WAIT
*
SYMSG    JSR   @F29E1     29bb ; =+36 [Jump to subroutine relative]
         LDA/  OSN0+3     29bd ; [external symbol] [Load A direct]
         BNZ   @D29C5     29c0 ; =+3 [Branch if not zero]
         LDA$  OSN0+7     29c2 ; [external symbol] [Load A indirect]
@D29C5   LDA+  A,8        29c5 ; [Load A indexed, displaced, direct]
         LDB+  X+         29c8 ; [Load B indexed, direct, post-incremented]
         STB   @S29F8     29ca ; =+44 [Store B relative]
         LDB=  @W29F2     29cc ; =0x29f2 =10738 [Load B with immediate]
         JSR/  OSN3B      29cf ; [external symbol] [Jump to subroutine direct]
@D29D2   LDAB  @W29F2     29d2 ; =+30 [Load AL relative]
         BM    @D29D2     29d4 ; =-4 [Branch on minus]
         STAB  @B29FC     29d6 ; =+36 [Store AL relative]
         RSR              29d8 ; [Return from subroutine]
*
* Function SYMSGA (OSNLB4/OSNLB5)
*
* Prints a system message.
* The message is printed to the console of the TIB in A.
*
* ASM:
*   Clobbers: A, B
*     JSR/ SYMSGA
*     DW STR      ; address of word length-prefixed string
*
SYMSGA   STA-  S-         29d9 ; [Push A to the stack]
         JSR   @F29E1     29db ; =+4 [Jump to subroutine relative]
         LDA+  S+         29dd ; [Pop A from the stack]
         JMP   @D29C5     29df ; =-28 [Jump relative]
*
* Function @F29E1
*
@F29E1   DI               29e1 ; [Disable interrupt system]
         LDAB  @B29FC     29e2 ; =+24 [Load AL relative]
         BP    @D29EC     29e4 ; =+6 [Branch on plus]
         EI               29e6 ; [Enable interrupt system]
         JSR/  WAIT       29e7 ; [external symbol] [Jump to subroutine direct]
         JMP   @F29E1     29ea ; =-11 [Jump relative]
@D29EC   LDAB= X'FF'      29ec ; =255(-1) [Load AL with immediate]
         STAB  @B29FC     29ee ; =+12 [Store AL relative]
         EI               29f0 ; [Enable interrupt system]
         RSR              29f1 ; [Return from subroutine]
*
@W29F2   DW    X'0082'    29f2 ; =0x0082 =130
         DB    X'00'      29f4 ; =0x00 =0 =NUL
         DW    X'0200'    29f5 ; =0x0200 =512
         DB    X'50'      29f7 ; =0x50 =80
@S29F8   DB    0,4        29f8 ; =0x00,0x0004
@B29FC   DB    X'00'      29fc ; =0x00 =0 =NUL
*
*
* Function IODMW (OSNLB4/OSNLB5)
*
* I/O driver for the TI-810 serial printer.
* Write to the printer.
*
*
* Exts:
*   WAIT
*   SYMSG
*
IODMW    STA-  S-         29fd ; [Push A to the stack]
         LDA+  Z,6        29ff ; [Load A indexed, displaced, direct]
         XAY              2a02 ; [Transfer A to Y]
         CLAB             2a03 ; [Clear AL]
         STAB+ *X,5       2a04 ; [Store AL indexed, displaced, indirect]
         XFR   Z,A        2a07 ; [Transfer Z to A]
         STA-  S-         2a09 ; [Push A to the stack]
         LDA+  X,21       2a0b ; [Load A indexed, displaced, direct]
         XAZ              2a0e ; [Transfer A to Z]
         LDAB+ X,23       2a0f ; [Load AL indexed, displaced, direct]
         STAB+ Z          2a12 ; [Store AL to address in Z]
         LDX+  Y+         2a13 ; [Load X indexed, direct, post-incremented]
         BGZ   @D2A2A     2a15 ; =+19 [Branch if greater than zero]
@D2A17   LDA+  S+         2a17 ; [Pop A from the stack]
         XAZ              2a19 ; [Transfer A to Z]
         LDB+  S+         2a1a ; [Pop B from the stack]
         CLAB             2a1c ; [Clear AL]
         STAB+ *B,3       2a1d ; [Store AL indexed, displaced, indirect]
         STAB+ Z          2a20 ; [Store AL to address in Z]
         LDX+  S+         2a21 ; [Pop X from the stack]
         LDA+  S+         2a23 ; [Pop A from the stack]
         XAY              2a25 ; [Transfer A to Y]
         LDA+  S+         2a26 ; [Pop A from the stack]
         XAZ              2a28 ; [Transfer A to Z]
         RSR              2a29 ; [Return from subroutine]
*
@D2A2A   LDAB+ Y+         2a2a ; [Load AL indexed, direct, post-incremented]
         LDBB= X'8D'      2a2c ; =141(-115) =CR [Load BL with immediate]
         SABB             2a2e ; [AL - BL -> BL]
         BZ    @D2A39     2a2f ; =+8 [Branch if zero]
         LDBB= X'A0'      2a31 ; =160(-96) =' ' [Load BL with immediate]
         SABB             2a33 ; [AL - BL -> BL]
         BNZ   @D2A3B     2a34 ; =+5 [Branch if not zero]
         DCX              2a36 ; [Decrement X]
         BGZ   @D2A2A     2a37 ; =-15 [Branch if greater than zero]
@D2A39   JMP   @D2A7F     2a39 ; =+68 [Jump relative]
@D2A3B   LDA+  S          2a3b ; [Load A from address in S]
         LDA+  A,6        2a3c ; [Load A indexed, displaced, direct]
         XAY              2a3f ; [Transfer A to Y]
         LDX+  Y+         2a40 ; [Load X indexed, direct, post-incremented]
@D2A42   LDAB+ Y+         2a42 ; [Load AL indexed, direct, post-incremented]
         LDBB= X'84'      2a44 ; =132(-124) =EOT [Load BL with immediate]
         SABB             2a46 ; [AL - BL -> BL]
         BZ    @D2A17     2a47 ; =-50 [Branch if zero]
         LDBB= X'8C'      2a49 ; =140(-116) =FF [Load BL with immediate]
         SABB             2a4b ; [AL - BL -> BL]
         BZ    @D2A81     2a4c ; =+51 [Branch if zero]
         LDBB= X'8B'      2a4e ; =139(-117) =VT [Load BL with immediate]
         SABB             2a50 ; [AL - BL -> BL]
         BZ    @D2A81     2a51 ; =+46 [Branch if zero]
         LDBB= X'8E'      2a53 ; =142(-114) [Load BL with immediate]
         SABB             2a55 ; [AL - BL -> BL]
         BZ    @D2A7A     2a56 ; =+34 [Branch if zero]
         LDBB= X'8D'      2a58 ; =141(-115) =CR [Load BL with immediate]
         SABB             2a5a ; [AL - BL -> BL]
         BZ    @D2A7F     2a5b ; =+34 [Branch if zero]
         LDBB= X'8A'      2a5d ; =138(-118) =LF [Load BL with immediate]
         SABB             2a5f ; [AL - BL -> BL]
         BZ    @D2A81     2a60 ; =+31 [Branch if zero]
         LDB+  S          2a62 ; [Load B from address in S]
         LDBB+ B,2        2a63 ; [Load BL indexed, displaced, direct]
         XFRB  BL,BU      2a66 ; [Transfer BL to BU]
         LDBB= X'08'      2a68 ; =8 [Load BL with immediate]
         ANDB  BU,BL      2a6a ; [BU & BL -> BL]
         BNZ   @D2A7A     2a6c ; =+12 [Branch if not zero]
         LDBB= X'A0'      2a6e ; =160(-96) =' ' [Load BL with immediate]
         SABB             2a70 ; [AL - BL -> BL]
         BL    @D2A75     2a71 ; =+2 [Branch on link]
         LDAB= X'DF'      2a73 ; =223(-33) =DEL [Load AL with immediate]
@D2A75   LDBB= X'FF'      2a75 ; =255(-1) [Load BL with immediate]
         SABB             2a77 ; [AL - BL -> BL]
         BZ    @D2A7C     2a78 ; =+2 [Branch if zero]
@D2A7A   JSR   @F2A85     2a7a ; =+9 [Jump to subroutine relative]
@D2A7C   DCX              2a7c ; [Decrement X]
         BGZ   @D2A42     2a7d ; =-61 [Branch if greater than zero]
@D2A7F   LDAB= X'8D'      2a7f ; =141(-115) =CR [Load AL with immediate]
@D2A81   JSR   @F2A85     2a81 ; =+2 [Jump to subroutine relative]
         DW    X'7392'    2a83 ; =0x7392 =29586
*
* Function @F2A85
*
@F2A85   STAB- S-         2a85 ; [Push AL to the stack]
         LDB=  X'2EE0'    2a87 ; =0x2ee0 =12000 [Load B with immediate]
         STB-  S-         2a8a ; [Push B to the stack]
@D2A8C   JSR/  WAIT       2a8c ; [external symbol] [Jump to subroutine direct]
         LDAB= X'22'      2a8f ; =34 [Load AL with immediate]
         LDBB+ Z          2a91 ; [Load BL from address in Z]
         NABB             2a92 ; [AL & BL -> BL]
         SABB             2a93 ; [AL - BL -> BL]
         BZ    @D2AAD     2a94 ; =+23 [Branch if zero]
         LDB+  S          2a96 ; [Load B from address in S]
         DCR   B          2a97 ; [Decrement B by 1]
         STB+  S          2a99 ; [Store B to address in S]
         BP    @D2A8C     2a9a ; =-16 [Branch on plus]
         JSR/  SYMSG      2a9c ; [external symbol] [Jump to subroutine direct]
         DW    @W2AB5     2a9f ; =0x2ab5 =10933
*
@D2AA1   LDAB= X'22'      2aa1 ; =34 [Load AL with immediate]
         LDBB+ Z          2aa3 ; [Load BL from address in Z]
         NABB             2aa4 ; [AL & BL -> BL]
         SABB             2aa5 ; [AL - BL -> BL]
         BZ    @D2AAD     2aa6 ; =+5 [Branch if zero]
         JSR/  WAIT       2aa8 ; [external symbol] [Jump to subroutine direct]
         JMP   @D2AA1     2aab ; =-12 [Jump relative]
@D2AAD   LDA+  S+         2aad ; [Pop A from the stack]
         LDAB+ S+         2aaf ; [Pop AL from the stack]
         STAB+ Z,1        2ab1 ; [Store AL indexed, displaced, direct]
         RSR              2ab4 ; [Return from subroutine]
*
@W2AB5   DW    X'000B'    2ab5 ; =0x000b =11
         DC    'ATTN PRINT' 2ab7 ; hex:c1d4d4cea0d0d2c9ced4
         DB    X'8D'      2ac1 ; =0x8d =141(-115) =CR
*
*
* Function DIO (OSNLB4/OSNLB5)
*
* SVC DIO - disk I/O call
*
*
* Exts:
*   ABRT
*   OSN0
*   FLGWT
*
DIO      XFR   Y,A        2ac2 ; [Transfer Y to A]
         STA-  S-         2ac4 ; [Push A to the stack]
         CLAB             2ac6 ; [Clear AL]
         STAB- S-         2ac7 ; [Push AL to the stack]
         LDA=  X'0190'    2ac9 ; =0x0190 =400 [Load A with immediate]
@D2ACC   STA-  S-         2acc ; [Push A to the stack]
         LDAB+ X+         2ace ; [Load AL indexed, direct, post-incremented]
         JSR   LOCDNO     2ad0 ; =+121 [Jump to subroutine relative]
         BNZ   DSETUP     2ad2 ; =+4 [Branch if not zero]
         JSR/  ABRT       2ad4 ; [external symbol] [Jump to subroutine direct]
         DB    X'06'      2ad7 ; =0x06 =6
*
*
* Function DSETUP (OSNLB4/OSNLB5)
*
*
DSETUP   LDAB+ Y,15       2ad8 ; [Load AL indexed, displaced, direct]
         STAB- S-         2adb ; [Push AL to the stack]
         LDB+  X+         2add ; [Load B indexed, direct, post-incremented]
         LDA+  Y,13       2adf ; [Load A indexed, displaced, direct]
         SLA              2ae2 ; [Left shift A]
         SLA              2ae3 ; [Left shift A]
         SLA              2ae4 ; [Left shift A]
         SLA              2ae5 ; [Left shift A]
         SUB   B,A        2ae6 ; [B - A -> A]
         BM    @D2AEE     2ae8 ; =+4 [Branch on minus]
         JSR/  ABRT       2aea ; [external symbol] [Jump to subroutine direct]
         DB    X'05'      2aed ; =0x05 =5
*
@D2AEE   STB-  S-         2aee ; [Push B to the stack]
         LDA+  X+         2af0 ; [Load A indexed, direct, post-incremented]
         STA-  S-         2af2 ; [Push A to the stack]
         LDAB+ X+         2af4 ; [Load AL indexed, direct, post-incremented]
         STAB- S-         2af6 ; [Push AL to the stack]
         BP    @D2AFE     2af8 ; =+4 [Branch on plus]
@D2AFA   JSR/  ABRT       2afa ; [external symbol] [Jump to subroutine direct]
         DB    X'08'      2afd ; =0x08 =8
*
@D2AFE   DCAB             2afe ; [Decrement AL]
         DCAB             2aff ; [Decrement AL]
         BGZ   @D2AFA     2b00 ; =-8 [Branch if greater than zero]
         BNZ   @D2B13     2b02 ; =+15 [Branch if not zero]
         LDA=  X'0020'    2b04 ; =0x0020 =32 [Load A with immediate]
         SAB              2b07 ; [A - B -> B]
         BLE   @D2B13     2b08 ; =+9 [Branch if less than or equal to zero]
         LDAB/ OSN0+28    2b0a ; [external symbol] [Load AL direct]
         BP    @D2B13     2b0d ; =+4 [Branch on plus]
         JSR/  ABRT       2b0f ; [external symbol] [Jump to subroutine direct]
         DB    X'05'      2b12 ; =0x05 =5
*
@D2B13   LDAB= X'04'      2b13 ; =4 [Load AL with immediate]
@D2B15   STAB- S-         2b15 ; [Push AL to the stack]
         JSR/  FLGWT      2b17 ; [external symbol] [Jump to subroutine direct]
         DB    X'1F'      2b1a ; =0x1f =31
         XFR   Y,A        2b1b ; [Transfer Y to A]
@P2B1D   STA/  OSN0+63    2b1d ; [external symbol] [Store A direct]
         CLA              2b20 ; [Clear A]
         LDAB+ S+         2b21 ; [Pop AL from the stack]
         SLA              2b23 ; [Left shift A]
@D2B24   LDB+  Y,5        2b24 ; [Load B indexed, displaced, direct]
         AAB              2b27 ; [A + B -> B]
         JMP+  *B         2b28 ; [Jump indexed, indirect]
*
* Function DIOLF (OSNLB4/OSNLB5)
*
* SVC DIOLF - DIO with return on error
*
*
DIOLF    CLAB             2b2a ; [Clear AL]
         INAB             2b2b ; [Increment AL]
         JMP   @D2B2F     2b2c ; =+1 [Jump relative]
*
* Function DIOL (OSNLB4/OSNLB5)
*
* SVC DIOL - disk I/O with length spec.
*
*
DIOL     CLAB             2b2e ; [Clear AL]
@D2B2F   XFR   Y,B        2b2f ; [Transfer Y to B]
         STB-  S-         2b31 ; [Push B to the stack]
         STAB- S-         2b33 ; [Push AL to the stack]
         LDA+  X+         2b35 ; [Load A indexed, direct, post-incremented]
         JMP   @D2ACC     2b37 ; =-109 [Jump relative]
*
* Function DIO1 (OSNLB4/OSNLB5)
*
* SVC DRDY - disk ready check
*
*
DIO1     JSR   LOCDNO     2b39 ; =+16 [Jump to subroutine relative]
         BNZ   @D2B3F     2b3b ; =+2 [Branch if not zero]
         XAB              2b3d ; [Transfer A to B]
         RSR              2b3e ; [Return from subroutine]
*
@D2B3F   LDAB= X'05'      2b3f ; =5 [Load AL with immediate]
         JMP   @D2B15     2b41 ; =-46 [Jump relative]
*
* Function DIORST (OSNLB4/OSNLB5)
*
*
DIORST   LDA*  @P2B1D+1   2b43 ; =-39 [Load A relative indirect]
         XAY              2b45 ; [Transfer A to Y]
         LDA=  X'000C'    2b46 ; =0x000c =12 [Load A with immediate]
         JMP   @D2B24     2b49 ; =-39 [Jump relative]
*
* Function LOCDNO (OSNLB4/OSNLB5)
*
* SVC GDPUB - locate pub for disk specified in AL
*
*
LOCDNO   LDBB/ OSN0+6     2b4b ; [external symbol] [Load BL direct]
         SABB             2b4e ; [AL - BL -> BL]
         BGZ   @D2B5E     2b4f ; =+13 [Branch if greater than zero]
         STX-  S-         2b51 ; [Push X to the stack]
         LDX/  OSN0+9     2b53 ; [external symbol] [Load X direct]
@D2B56   LDB+  X+         2b56 ; [Load B indexed, direct, post-incremented]
         XFR   B,Y        2b58 ; [Transfer B to Y]
         BNZ   @D2B60     2b5a ; =+4 [Branch if not zero]
         LDX+  S+         2b5c ; [Pop X from the stack]
@D2B5E   CLA              2b5e ; [Clear A]
         RSR              2b5f ; [Return from subroutine]
*
@D2B60   LDBB+ Y          2b60 ; [Load BL from address in Y]
         BZ    @D2B56     2b61 ; =-13 [Branch if zero]
         LDB+  Y,1        2b63 ; [Load B indexed, displaced, direct]
         LDBB= X'04'      2b66 ; =4 [Load BL with immediate]
         SUBB  BU,BL      2b68 ; [BU - BL -> BL]
         BNZ   @D2B56     2b6a ; =-22 [Branch if not zero]
         LDBB+ Y,2        2b6c ; [Load BL indexed, displaced, direct]
         SABB             2b6f ; [AL - BL -> BL]
         BNZ   @D2B56     2b70 ; =-28 [Branch if not zero]
         LDX+  S+         2b72 ; [Pop X from the stack]
         RSR              2b74 ; [Return from subroutine]
*
* Function DIOR (OSNLB4/OSNLB5)
*
* Disk I/O read.
*
*
DIOR     XAY              2b75 ; [Transfer A to Y]
         LDA=  X'0190'    2b76 ; =0x0190 =400 [Load A with immediate]
         LDB+  Z,4        2b79 ; [Load B indexed, displaced, direct]
         SAB              2b7c ; [A - B -> B]
         BLE   @D2B92     2b7d ; =+19 [Branch if less than or equal to zero]
         LDAB= X'05'      2b7f ; =5 [Load AL with immediate]
@D2B81   STAB+ Z          2b81 ; [Store AL to address in Z]
         CLAB             2b82 ; [Clear AL]
         STAB+ *Y,3       2b83 ; [Store AL indexed, displaced, indirect]
         STAB+ *Y,5       2b86 ; [Store AL indexed, displaced, indirect]
         LDX+  S+         2b89 ; [Pop X from the stack]
         LDA+  S+         2b8b ; [Pop A from the stack]
         XAY              2b8d ; [Transfer A to Y]
         LDA+  S+         2b8e ; [Pop A from the stack]
         XAZ              2b90 ; [Transfer A to Z]
         RSR              2b91 ; [Return from subroutine]
*
@D2B92   LDB+  Z,6        2b92 ; [Load B indexed, displaced, direct]
         STA+  B+         2b95 ; [Store A indexed, direct, post-incremented]
         AAB              2b97 ; [A + B -> B]
         CLAB             2b98 ; [Clear AL]
         STAB+ B          2b99 ; [Store AL to address in B]
         JSR   @F2BA5     2b9a ; =+9 [Jump to subroutine relative]
         DB    X'01'      2b9c ; =0x01 =1
         JMP   @D2B81     2b9d ; =-30 [Jump relative]
*
* Function DIOW (OSNLB4/OSNLB5)
*
* Disk I/O write.
*
*
DIOW     XAY              2b9f ; [Transfer A to Y]
         JSR   @F2BA5     2ba0 ; =+3 [Jump to subroutine relative]
         DB    X'02'      2ba2 ; =0x02 =2
         JMP   @D2B81     2ba3 ; =-36 [Jump relative]
*
* Function @F2BA5
*
@F2BA5   LDAB+ Y,2        2ba5 ; [Load AL indexed, displaced, direct]
         STAB  @B2BBD     2ba8 ; =+19 [Store AL relative]
         LDA+  Z,8        2baa ; [Load A indexed, displaced, direct]
         STA   @W2BBE     2bad ; =+15 [Store A relative]
         LDA+  Z,6        2baf ; [Load A indexed, displaced, direct]
         INA              2bb2 ; [Increment A]
         INA              2bb3 ; [Increment A]
         STA   @W2BC0     2bb4 ; =+10 [Store A relative]
         LDAB+ X+         2bb6 ; [Load AL indexed, direct, post-incremented]
         STAB  @B2BC2     2bb8 ; =+8 [Store AL relative]
         JSR/  DIO        2bba ; =0x2ac2 =10946 [Jump to subroutine direct]
@B2BBD   DB    X'00'      2bbd ; =0x00 =0 =NUL
@W2BBE   DW    X'0000'    2bbe ; =0x0000 =0 =NUL,NUL
@W2BC0   DW    X'0000'    2bc0 ; =0x0000 =0 =NUL,NUL
@B2BC2   DB    X'00'      2bc2 ; =0x00 =0 =NUL
         CLAB             2bc3 ; [Clear AL]
         RSR              2bc4 ; [Return from subroutine]
*
* Function PD001 (OSNLB4/OSNLB5)
*
* Predriver for ADDS 520/580
*
*
PD001    JMP   @D2BD3     2bc5 ; =+12 [Jump relative]
*
         DW    X'0295'    2bc7 ; =0x0295 =661
         DW    X'02FF'    2bc9 ; =0x02ff =767
         DW    X'0386'    2bcb ; =0x0386 =902
         DW    X'049A'    2bcd ; =0x049a =1178
         DW    X'0181'    2bcf ; =0x0181 =385
         DW    X'0000'    2bd1 ; =0x0000 =0 =NUL,NUL
*
@D2BD3   STX-  S-         2bd3 ; [Push X to the stack]
         LDB+  Z,6        2bd5 ; [Load B indexed, displaced, direct]
         LDX+  B+         2bd8 ; [Load X indexed, direct, post-incremented]
         LDA=  X'8800'    2bda ; =0x8800 =34816(-30720) =BS,NUL [Load A with immediate]
@D2BDD   LDAB+ B+         2bdd ; [Load AL indexed, direct, post-incremented]
         SUBB  AU,AL      2bdf ; [AU - AL -> AL]
         BNZ   @D2BE9     2be1 ; =+6 [Branch if not zero]
         LDAB= X'95'      2be3 ; =149(-107) [Load AL with immediate]
         STAB- B-         2be5 ; [Store AL indexed, pre-decremented, direct]
         INR   B          2be7 ; [Increment B by 1]
@D2BE9   DCX              2be9 ; [Decrement X]
         BGZ   @D2BDD     2bea ; =-15 [Branch if greater than zero]
         LDX+  Z,6        2bec ; [Load X indexed, displaced, direct]
         INX              2bef ; [Increment X]
         INX              2bf0 ; [Increment X]
         LDA+  X          2bf1 ; [Load A from address in X]
         LDB=  X'9BB1'    2bf2 ; =0x9bb1 =39857(-25679) [Load B with immediate]
         SAB              2bf5 ; [A - B -> B]
         BNZ   @D2C1B     2bf6 ; =+35 [Branch if not zero]
         LDAB+ X,3        2bf8 ; [Load AL indexed, displaced, direct]
         DCAB             2bfb ; [Decrement AL]
         STAB  @B2C21     2bfc ; =+35 [Store AL relative]
         CLA              2bfe ; [Clear A]
         LDAB+ X,2        2bff ; [Load AL indexed, displaced, direct]
         DCA              2c02 ; [Decrement A]
         LDB=  X'000A'    2c03 ; =0x000a =10 [Load B with immediate]
         JSR$  X'005A'    2c06 ; =0x005a =90 [Jump to OPSYS (SVC)]
         DB    X'2C'      2c09 ; =0x2c =44 [Service call DIV16 - 16-bit divide]
         SLR   B          2c0a ; [Left shift B by 1]
         SLR   B          2c0c ; [Left shift B by 1]
         SLR   B          2c0e ; [Left shift B by 1]
         SLR   B          2c10 ; [Left shift B by 1]
         AABB             2c12 ; [AL + BL -> BL]
         STBB  @B2C24     2c13 ; =+15 [Store BL relative]
         LDA=  @W2C1E     2c15 ; =0x2c1e =11294 [Load A with immediate]
         STA+  Z,6        2c18 ; [Store A indexed, displaced, direct]
@D2C1B   LDX+  S+         2c1b ; [Pop X from the stack]
         RSR              2c1d ; [Return from subroutine]
*
@W2C1E   DW    X'0006'    2c1e ; =0x0006 =6
         DB    X'8B'      2c20 ; =0x8b =139(-117) =VT
@B2C21   DW    X'00FF'    2c21 ; =0x00ff =255
         DB    X'90'      2c23 ; =0x90 =144(-112)
@B2C24   DW    X'00FF'    2c24 ; =0x00ff =255
*
*
* Function @HEX16 (OSLIB/P.OSLIB5/OSNLB4/OSNLB5/?.VLIB)
*
* Converts a word value to four ASCII digits in hexadecimal.
* Additional identical copies in OSNLB4 and OSNLB5.
*
* ASM:
*   Input: A = word value to convert to ASCII hex
*     JSR/ @HEX16
*     DW addr     ; address of string
*
* Exts:
*   @HEX
*
@HEX16   XABB             2c26 ; [Transfer AL to BL]
         XFRB  AU,AL      2c27 ; [Transfer AU to AL]
         JSR/  @HEX       2c29 ; [external symbol] [Jump to subroutine direct]
         STA+  *X         2c2c ; [Store A indexed, indirect]
         XFRB  BL,AL      2c2e ; [Transfer BL to AL]
         JSR/  @HEX       2c30 ; [external symbol] [Jump to subroutine direct]
         LDB+  X+         2c33 ; [Load B indexed, direct, post-incremented]
         STA+  B,2        2c35 ; [Store A indexed, displaced, direct]
         RSR              2c38 ; [Return from subroutine]
*
* Function CVD16 (OSLIB/P.OSLIB5/OSNLB4/OSNLB5/?.VLIB)
*
* SVC CVD16 - 16-bit convert to decimal from memory
* Additional identical copies in OSNLB4 and OSNLB5.
*
* ASM:
*   Clobbers: A, B
*     JSR/ CVD16
*     DW VALUE   ; value to convert
*     DW STRLAST ; address of the last byte of the string
*
* Exts:
*   DIV16
*
CVD16    LDA+  X+         2c39 ; [Load A indexed, direct, post-incremented]
*
* Function CVR16 (OSLIB/P.OSLIB5/OSNLB4/OSNLB5/?.VLIB)
*
* SVC CVR16 - 16-bit convert to decimal from A register
*
* ASM:
*   Input: A = value to convert
*   Clobbers: A, B
*     JSR/ CVR16
*     DW STRLAST ; address of the last byte of the string
*
CVR16    LDBB= X'A0'      2c3b ; =160(-96) =' ' [Load BL with immediate]
         STBB- S-         2c3d ; [Push BL to the stack]
         XFR   A,A        2c3f ; [Transfer A to A]
         BZ    @D2C76     2c41 ; =+51 [Branch if zero]
         BP    @D2C4A     2c43 ; =+5 [Branch on plus]
         IVA              2c45 ; [Invert A]
         INA              2c46 ; [Increment A]
         LDBB= X'AD'      2c47 ; =173(-83) ='-' [Load BL with immediate]
         STBB+ S          2c49 ; [Store BL to address in S]
@D2C4A   LDB+  X+         2c4a ; [Load B indexed, direct, post-incremented]
         STX-  S-         2c4c ; [Push X to the stack]
         XFR   B,X        2c4e ; [Transfer B to X]
         INX              2c50 ; [Increment X]
@D2C51   LDB=  X'000A'    2c51 ; =0x000a =10 [Load B with immediate]
         JSR/  DIV16      2c54 ; [external symbol] [Jump to subroutine direct]
         STB-  S-         2c57 ; [Push B to the stack]
         BZ    @D2C64     2c59 ; =+9 [Branch if zero]
         LDBB= X'B0'      2c5b ; =176(-80) ='0' [Load BL with immediate]
         AABB             2c5d ; [AL + BL -> BL]
         STBB- X-         2c5e ; [Store BL indexed, pre-decremented, direct]
         LDA+  S+         2c60 ; [Pop A from the stack]
         JMP   @D2C51     2c62 ; =-19 [Jump relative]
@D2C64   XABB             2c64 ; [Transfer AL to BL]
         BZ    @D2C6C     2c65 ; =+5 [Branch if zero]
         LDAB= X'B0'      2c67 ; =176(-80) ='0' [Load AL with immediate]
         AABB             2c69 ; [AL + BL -> BL]
         STBB- X-         2c6a ; [Store BL indexed, pre-decremented, direct]
@D2C6C   LDB+  S+         2c6c ; [Pop B from the stack]
         LDA+  S+         2c6e ; [Pop A from the stack]
         LDBB+ S+         2c70 ; [Pop BL from the stack]
         STBB- X-         2c72 ; [Store BL indexed, pre-decremented, direct]
         XAX              2c74 ; [Transfer A to X]
         RSR              2c75 ; [Return from subroutine]
*
@D2C76   LDAB= X'B0'      2c76 ; =176(-80) ='0' [Load AL with immediate]
         STAB+ *X         2c78 ; [Store AL indexed, indirect]
         INX              2c7a ; [Increment X]
         INX              2c7b ; [Increment X]
         LDBB+ S+         2c7c ; [Pop BL from the stack]
         RSR              2c7e ; [Return from subroutine]
*
* Function DIV16 (OSLIB/P.OSLIB5/OSNLB4/OSNLB5/?.VLIB)
*
* SVC DIV16 - 16-bit divide
* Divides two words in registers.
* Additional identical copies in OSNLB4 and OSNLB5.
*
* ASM:
*   Input: A = dividend
*   Input: B = divisor
*   Output: A = remainder
*   Output: B = quotient
*     JSR/ DIV16
*
DIV16    STX-  S-         2c7f ; [Push X to the stack]
         XAX              2c81 ; [Transfer A to X]
         XFR   Z,A        2c82 ; [Transfer Z to A]
         STA-  S-         2c84 ; [Push A to the stack]
         CLR   Z          2c86 ; [Clear Z]
         INR   Z          2c88 ; [Increment Z by 1]
         CLAB             2c8a ; [Clear AL]
         STAB- S-         2c8b ; [Push AL to the stack]
         XFR   X,X        2c8d ; [Transfer X to X]
         BP    @D2C97     2c8f ; =+6 [Branch on plus]
         IVR   X          2c91 ; [Invert X]
         INX              2c93 ; [Increment X]
         LDAB+ S          2c94 ; [Load AL from address in S]
         IVAB             2c95 ; [Invert AL]
         STAB+ S          2c96 ; [Store AL to address in S]
@D2C97   XFR   B,B        2c97 ; [Transfer B to B]
         BP    @D2CA2     2c99 ; =+7 [Branch on plus]
         IVR   B          2c9b ; [Invert B]
         INR   B          2c9d ; [Increment B by 1]
         LDAB+ S          2c9f ; [Load AL from address in S]
         IVAB             2ca0 ; [Invert AL]
         STAB+ S          2ca1 ; [Store AL to address in S]
@D2CA2   XFR   X,A        2ca2 ; [Transfer X to A]
         CLR   X          2ca4 ; [Clear X]
@D2CA6   STB-  S-         2ca6 ; [Push B to the stack]
         SAB              2ca8 ; [A - B -> B]
         BNL   @D2CB7     2ca9 ; =+12 [Branch on no link]
         ADD   Z,X        2cab ; [Z + X -> X]
         XFR   B,A        2cad ; [Transfer B to A]
         LDB+  S+         2caf ; [Pop B from the stack]
         SLR   B          2cb1 ; [Left shift B by 1]
         SLR   Z          2cb3 ; [Left shift Z by 1]
         JMP   @D2CA6     2cb5 ; =-17 [Jump relative]
@D2CB7   LDB+  S+         2cb7 ; [Pop B from the stack]
         RL               2cb9 ; [Reset link]
         RRR   B          2cba ; [Right rotate B by 1]
         RL               2cbc ; [Reset link]
         RRR   Z          2cbd ; [Right rotate Z by 1]
         BNZ   @D2CA6     2cbf ; =-27 [Branch if not zero]
         LDBB+ S+         2cc1 ; [Pop BL from the stack]
         BZ    @D2CC8     2cc3 ; =+3 [Branch if zero]
         IVR   X          2cc5 ; [Invert X]
         INX              2cc7 ; [Increment X]
@D2CC8   XFR   X,B        2cc8 ; [Transfer X to B]
         LDX+  S+         2cca ; [Pop X from the stack]
         XFR   X,Z        2ccc ; [Transfer X to Z]
         LDX+  S+         2cce ; [Pop X from the stack]
         RSR              2cd0 ; [Return from subroutine]
*
* Function MUL16 (OSLIB/P.OSLIB5/OSNLB4/OSNLB5/?.VLIB)
*
* SVC MUL16 - 16-bit multiply
* Multiplies two words in registers.
* Additional identical copies in OSNLB4 and OSNLB5.
*
* ASM:
*   Input: A = multiplicand
*   Input: B = multiplicand
*   Output: A = high word of product
*   Output: B = low word of product
*     JSR/ MUL16
*
MUL16    STX-  S-         2cd1 ; [Push X to the stack]
         XFR   Y,X        2cd3 ; [Transfer Y to X]
         STX-  S-         2cd5 ; [Push X to the stack]
         XFR   Z,X        2cd7 ; [Transfer Z to X]
         STX-  S-         2cd9 ; [Push X to the stack]
         LDX=  X'8000'    2cdb ; =0x8000 =32768(-32768) [Load X with immediate]
         XFR   X,Y        2cde ; [Transfer X to Y]
         CLR   X          2ce0 ; [Clear X]
         CLR   Z          2ce2 ; [Clear Z]
         XFR   A,A        2ce4 ; [Transfer A to A]
         BP    @D2CEE     2ce6 ; =+6 [Branch on plus]
         IVA              2ce8 ; [Invert A]
         INA              2ce9 ; [Increment A]
         IVR   B          2cea ; [Invert B]
         INR   B          2cec ; [Increment B by 1]
@D2CEE   IVA              2cee ; [Invert A]
@D2CEF   XFR   A,A        2cef ; [Transfer A to A]
         BZ    @D2D10     2cf1 ; =+29 [Branch if zero]
         RL               2cf3 ; [Reset link]
         RRR   A          2cf4 ; [Right rotate A by 1]
         BL    @D2CFA     2cf6 ; =+2 [Branch on link]
         ADD   B,X        2cf8 ; [B + X -> X]
@D2CFA   RL               2cfa ; [Reset link]
         RRR   Z          2cfb ; [Right rotate Z by 1]
         RL               2cfd ; [Reset link]
         RRR   X          2cfe ; [Right rotate X by 1]
         BNL   @D2D04     2d00 ; =+2 [Branch on no link]
         ADD   Y,Z        2d02 ; [Y + Z -> Z]
@D2D04   XFR   B,B        2d04 ; [Transfer B to B]
         BP    @D2CEF     2d06 ; =-25 [Branch on plus]
         XFR   X,X        2d08 ; [Transfer X to X]
         BZ    @D2CEF     2d0a ; =-29 [Branch if zero]
         ADD   Y,X        2d0c ; [Y + X -> X]
         JMP   @D2CEF     2d0e ; =-33 [Jump relative]
@D2D10   XFR   Z,B        2d10 ; [Transfer Z to B]
         XFR   X,A        2d12 ; [Transfer X to A]
         LDX+  S+         2d14 ; [Pop X from the stack]
         XFR   X,Z        2d16 ; [Transfer X to Z]
         LDX+  S+         2d18 ; [Pop X from the stack]
         XFR   X,Y        2d1a ; [Transfer X to Y]
         LDX+  S+         2d1c ; [Pop X from the stack]
         RSR              2d1e ; [Return from subroutine]
*
* Function COMP (OSLIB/P.OSLIB5/OSNLB4/OSNLB5/?.VLIB)
*
* Compares two buffers of a given length.Additional identical copies in OSNLB4 and OSNLB5.
*
* ASM:
*   Output: BL = 0 if equal or non-0 if not
*   Clobbers: A, BU
*     JSR/ COMP
*     DW LEnN   ; length of buffers
*     DW BUFF1  ; address of first buffer
*     DW BUFF2  ; address of second buffer
*
COMP     LDB+  X+         2d1f ; [Load B indexed, direct, post-incremented]
         XFR   Z,A        2d21 ; [Transfer Z to A]
         STA-  S-         2d23 ; [Push A to the stack]
         XFR   Y,A        2d25 ; [Transfer Y to A]
         STA-  S-         2d27 ; [Push A to the stack]
         LDA+  X+         2d29 ; [Load A indexed, direct, post-incremented]
         XAZ              2d2b ; [Transfer A to Z]
         LDA+  X+         2d2c ; [Load A indexed, direct, post-incremented]
         XAY              2d2e ; [Transfer A to Y]
         STX-  S-         2d2f ; [Push X to the stack]
         XFR   B,X        2d31 ; [Transfer B to X]
         BZ    @D2D3F     2d33 ; =+10 [Branch if zero]
@D2D35   LDAB+ Z+         2d35 ; [Load AL indexed, direct, post-incremented]
         LDBB+ Y+         2d37 ; [Load BL indexed, direct, post-incremented]
         SABB             2d39 ; [AL - BL -> BL]
         BNZ   @D2D3F     2d3a ; =+3 [Branch if not zero]
         DCX              2d3c ; [Decrement X]
         BNZ   @D2D35     2d3d ; =-10 [Branch if not zero]
@D2D3F   LDX+  S+         2d3f ; [Pop X from the stack]
         LDA+  S+         2d41 ; [Pop A from the stack]
         XAY              2d43 ; [Transfer A to Y]
         LDA+  S+         2d44 ; [Pop A from the stack]
         XAZ              2d46 ; [Transfer A to Z]
         RSR              2d47 ; [Return from subroutine]
*
* Function @HEX (OSLIB/P.OSLIB5/OSNLB4/OSNLB5/?.VLIB)
*
* Converts a byte value to two ASCII digits in hexadecimal.
* Additional identical copies in OSNLB4 and OSNLB5.
*
* ASM:
*   Input: AL = byte value to convert to ASCII hex
*   Output: A = two ASCII hex digits
*     JSR/ @HEX
*
@HEX     STB-  S-         2d48 ; [Push B to the stack]
         XFRB  AL,AU      2d4a ; [Transfer AL to AU]
         SRAB             2d4c ; [Arithmetic right shift AL]
         SRAB             2d4d ; [Arithmetic right shift AL]
         SRAB             2d4e ; [Arithmetic right shift AL]
         SRAB             2d4f ; [Arithmetic right shift AL]
         LDB=  X'0F0F'    2d50 ; =0x0f0f =3855 [Load B with immediate]
         NAB              2d53 ; [A & B -> B]
         XFRB  BL,AL      2d54 ; [Transfer BL to AL]
         JSR   @HXNIB     2d56 ; =+11 [Jump to subroutine relative]
         XFRB  BL,AU      2d58 ; [Transfer BL to AU]
         XFRB  BU,AL      2d5a ; [Transfer BU to AL]
         JSR   @HXNIB     2d5c ; =+5 [Jump to subroutine relative]
         XFRB  BL,AL      2d5e ; [Transfer BL to AL]
         LDB+  S+         2d60 ; [Pop B from the stack]
         RSR              2d62 ; [Return from subroutine]
*
* Function @HXNIB
*
@HXNIB   LDBB= X'0A'      2d63 ; =10 [Load BL with immediate]
         SABB             2d65 ; [AL - BL -> BL]
         BM    @D2D6C     2d66 ; =+4 [Branch on minus]
         LDBB= X'07'      2d68 ; =7 [Load BL with immediate]
         ADDB  BL,AL      2d6a ; [BL + AL -> AL]
@D2D6C   LDBB= X'B0'      2d6c ; =176(-80) ='0' [Load BL with immediate]
         AABB             2d6e ; [AL + BL -> BL]
         RSR              2d6f ; [Return from subroutine]
*
* Function OSNZ (OSNLB5)
*
* Initialize and boot the operating system.
* Clobbers X so it does not return.
*
* ASM:
*     JMP/ OSNZ ; Jump instead of JSR because it cannot return
*
* Exts:
*   OSN0
*   TRTBL
*   SYSBUF
*   OSNMSG
*   DIO1
*   LOCDNO
*   CVR16
*   OSN5
*   OSN4B
*   HICORE
*   OSN4A
*   WAIT
*   UCSTR
*   TRTAD
*   TRPNT
*   TSIZE
*   DIO
*   DATE
*   TX004
*   TX005
*   @DC
*   FLGWT
*   IODJZ
*   IODJUW
*   @NC
*   IODJT
*   LOD32
*   MUL32
*   ADD32
*   STO32
*   IODJY
*
OSNZ     CLA              2d70 ; [Clear A]
         STA/  X'000C'    2d71 ; =0x000c =12 [Store A direct]
         STA/  X'002C'    2d74 ; =0x002c =44 [Store A direct]
         STA/  X'006C'    2d77 ; =0x006c =108 [Store A direct]
         STA/  X'00AC'    2d7a ; =0x00ac =172 =NUL,',' [Store A direct]
         STA/  X'00FC'    2d7d ; =0x00fc =252 =NUL,'|' [Store A direct]
*
* Function BST0 (OSNLB5)
*
*
BST0     STAB/ X'FFF8'    2d80 ; =0xfff8 =65528(-8) [Store AL direct]
         JMP/  @J3391     2d83 ; =0x3391 =13201 [Jump direct]
*
         DS    1547       2d86 ; [Uninitialized memory]
*
@J3391   LDA=  X'FFFF'    3391 ; =0xffff =65535(-1) [Load A with immediate]
         LDB=  BST0       3394 ; =0x2d80 =11648 [Load B with immediate]
         LDX=  X'0308'    3397 ; =0x0308 =776 [Load X with immediate]
@D339A   STA+  B+         339a ; [Store A indexed, direct, post-incremented]
         DCX              339c ; [Decrement X]
         BGZ   @D339A     339d ; =-5 [Branch if greater than zero]
         LDA=  OSN0       339f ; [external symbol] [Load A with immediate]
         STA/  X'005A'    33a2 ; =0x005a =90 [Store A direct]
         LDA=  OSNMSG     33a5 ; =0x3bcc =15308 [Load A with immediate]
         INA              33a8 ; [Increment A]
         SRA              33a9 ; [Arithmetic right shift A]
         XAX              33aa ; [Transfer A to X]
         SLA              33ab ; [Left shift A]
@D33AC   LDB-  A-         33ac ; [Load B indexed, pre-decremented, direct]
         STB+  A          33ae ; [Store B to address in A]
         DCX              33af ; [Decrement X]
         BGZ   @D33AC     33b0 ; =-6 [Branch if greater than zero]
         LDA=  OSNMSG     33b2 ; =0x3bcc =15308 [Load A with immediate]
         XAY              33b5 ; [Transfer A to Y]
@D33B6   LDBB+ Y          33b6 ; [Load BL from address in Y]
         LDAB= X'01'      33b7 ; =1 [Load AL with immediate]
         STAB+ Y          33b9 ; [Store AL to address in Y]
         LDAB+ Y          33ba ; [Load AL from address in Y]
         STBB+ Y+         33bb ; [Store BL indexed, direct, post-incremented]
         DCAB             33bd ; [Decrement AL]
         BZ    @D33B6     33be ; =-10 [Branch if zero]
         XFR   Y,A        33c0 ; [Transfer Y to A]
         DCA              33c2 ; [Decrement A]
         DCA              33c3 ; [Decrement A]
         BS1   @D33C8     33c4 ; =+2 [Branch if Sense Switch 1 set]
         JMP   @D33D4     33c6 ; =+12 [Jump relative]
@D33C8   BS2   @D33CC     33c8 ; =+2 [Branch if Sense Switch 2 set]
         JMP   @D33D4     33ca ; =+8 [Jump relative]
@D33CC   LDB/  X'003A'    33cc ; =0x003a =58 [Load B direct]
         LDA=  X'0014'    33cf ; =0x0014 =20 [Load A with immediate]
         SUB   B,A        33d2 ; [B - A -> A]
@D33D4   LDB$  OSN0+7     33d4 ; [external symbol] [Load B indirect]
         STA+  B,12       33d7 ; [Store A indexed, displaced, direct]
         LDA+  B,8        33da ; [Load A indexed, displaced, direct]
         XAZ              33dd ; [Transfer A to Z]
         LDB=  TRTBL      33de ; [external symbol] [Load B with immediate]
         LDX=  @W39CA     33e1 ; =0x39ca =14794 [Load X with immediate]
@D33E4   LDA+  B+         33e4 ; [Load A indexed, direct, post-incremented]
         STA+  X+         33e6 ; [Store A indexed, direct, post-incremented]
         BNZ   @D33E4     33e8 ; =-6 [Branch if not zero]
         LDX/  OSN0+38    33ea ; [external symbol] [Load X direct]
@D33ED   LDA+  X+         33ed ; [Load A indexed, direct, post-incremented]
         BZ    @D33F5     33ef ; =+4 [Branch if zero]
         JSR+  A          33f1 ; [Jump to subroutine indexed, direct]
         JMP   @D33ED     33f3 ; =-8 [Jump relative]
@D33F5   EI               33f5 ; [Enable interrupt system]
         LDA=  SYSBUF     33f6 ; [external symbol] [Load A with immediate]
         STA   @W340D     33f9 ; =+18 [Store A relative]
         JSR/  @F354E     33fb ; =0x354e =13646 [Jump to subroutine direct]
         DW    @W3902     33fe ; =0x3902 =14594
*
         JSR/  @F354E     3400 ; =0x354e =13646 [Jump to subroutine direct]
         DW    OSNMSG     3403 ; =0x3bcc =15308
*
         JSR/  @F354E     3405 ; =0x354e =13646 [Jump to subroutine direct]
         DW    @W39C7     3408 ; =0x39c7 =14791
*
         JSR/  @F354E     340a ; =0x354e =13646 [Jump to subroutine direct]
@W340D   DW    X'0000'    340d ; =0x0000 =0 =NUL,NUL
*
         JSR/  @F354E     340f ; =0x354e =13646 [Jump to subroutine direct]
         DW    @W39C7     3412 ; =0x39c7 =14791
         CLA              3414 ; [Clear A]
         STA/  X'001A'    3415 ; =0x001a =26 [Store A direct]
         LDAB/ OSN0+6     3418 ; [external symbol] [Load AL direct]
         XAX              341b ; [Transfer A to X]
@D341C   XFR   X,A        341c ; [Transfer X to A]
         JSR/  DIO1       341e ; [external symbol] [Jump to subroutine direct]
         BNZ   @D3426     3421 ; =+3 [Branch if not zero]
         DCX              3423 ; [Decrement X]
         JMP   @D341C     3424 ; =-10 [Jump relative]
@D3426   XFR   X,A        3426 ; [Transfer X to A]
         STAB/ @B3536+1   3428 ; =0x3537 =13623 [Store AL direct]
@D342B   JSR/  LOCDNO     342b ; [external symbol] [Jump to subroutine direct]
         LDA=  BST0       342e ; =0x2d80 =11648 [Load A with immediate]
         STA+  Y,16       3431 ; [Store A indexed, displaced, direct]
         DCX              3434 ; [Decrement X]
         XFRB  XL,AL      3435 ; [Transfer XL to AL]
         BP    @D342B     3437 ; =-14 [Branch on plus]
@J3439   LDA=  X'A0A0'    3439 ; =0xa0a0 =41120(-24416) =' ',' ' [Load A with immediate]
         STA/  @S3915     343c ; =0x3915 =14613 [Store A direct]
         STA/  @S3929     343f ; =0x3929 =14633 [Store A direct]
         CLA              3442 ; [Clear A]
         LDAB/ @B3536+1   3443 ; =0x3537 =13623 [Load AL direct]
         JSR/  CVR16      3446 ; [external symbol] [Jump to subroutine direct]
         DW    @S3916     3449 ; =0x3916 =14614
         CLA              344b ; [Clear A]
         LDAB/ OSN0+5     344c ; [external symbol] [Load AL direct]
         JSR/  CVR16      344f ; [external symbol] [Jump to subroutine direct]
         DW    @S392A     3452 ; =0x392a =14634
         LDAB= X'BD'      3454 ; =189(-67) ='=' [Load AL with immediate]
         STAB/ @S3914     3456 ; =0x3914 =14612 [Store AL direct]
         STAB/ @S3928     3459 ; =0x3928 =14632 [Store AL direct]
         JSR/  @F354E     345c ; =0x354e =13646 [Jump to subroutine direct]
         DW    @W3905     345f ; =0x3905 =14597
*
         JSR/  @F3579     3461 ; =0x3579 =13689 [Jump to subroutine direct]
         LDA+  Y+         3464 ; [Load A indexed, direct, post-incremented]
         BNZ   @D3475     3466 ; =+13 [Branch if not zero]
         JMP/  @B3536     3468 ; =0x3536 =13622 [Jump direct]
*
* Function @F346B
*
@F346B   LDAB= X'A0'      346b ; =160(-96) =' ' [Load AL with immediate]
@D346D   LDBB+ Y+         346d ; [Load BL indexed, direct, post-incremented]
         SABB             346f ; [AL - BL -> BL]
         BZ    @D346D     3470 ; =-5 [Branch if zero]
         DCR   Y          3472 ; [Decrement Y by 1]
         RSR              3474 ; [Return from subroutine]
*
@D3475   JSR   @F346B     3475 ; =-12 [Jump to subroutine relative]
         LDA+  Y+         3477 ; [Load A indexed, direct, post-incremented]
         LDB=  X'CDBD'    3479 ; =0xcdbd =52669(-12867) ='M','=' [Load B with immediate]
         SAB              347c ; [A - B -> B]
         BZ    @D3496     347d ; =+23 [Branch if zero]
         LDB=  X'CCBD'    347f ; =0xccbd =52413(-13123) ='L','=' [Load B with immediate]
         SAB              3482 ; [A - B -> B]
         BZ    @D34A9     3483 ; =+36 [Branch if zero]
         LDB=  X'D3BD'    3485 ; =0xd3bd =54205(-11331) ='S','=' [Load B with immediate]
         SAB              3488 ; [A - B -> B]
         BNZ   @D349B     3489 ; =+16 [Branch if not zero]
         JSR/  @F373C     348b ; =0x373c =14140 [Jump to subroutine direct]
         BM    @D349B     348e ; =+11 [Branch on minus]
         STAB/ OSN0+5     3490 ; [external symbol] [Store AL direct]
         JMP/  @J351E     3493 ; =0x351e =13598 [Jump direct]
@D3496   JSR/  @F373C     3496 ; =0x373c =14140 [Jump to subroutine direct]
         BP    @D349E     3499 ; =+3 [Branch on plus]
@D349B   JMP/  @J352E     349b ; =0x352e =13614 [Jump direct]
@D349E   LDBB/ OSN0+6     349e ; [external symbol] [Load BL direct]
         SABB             34a1 ; [AL - BL -> BL]
         BGZ   @D349B     34a2 ; =-9 [Branch if greater than zero]
         STAB/ @B3536+1   34a4 ; =0x3537 =13623 [Store AL direct]
         JMP   @J351E     34a7 ; =+117 [Jump relative]
@D34A9   JSR/  @F346B     34a9 ; =0x346b =13419 [Jump to subroutine direct]
         LDA=  X'A0A0'    34ac ; =0xa0a0 =41120(-24416) =' ',' ' [Load A with immediate]
         STA/  @S36D0     34af ; =0x36d0 =14032 [Store A direct]
         STA/  @S36D2     34b2 ; =0x36d2 =14034 [Store A direct]
         STA/  @S36D4     34b5 ; =0x36d4 =14036 [Store A direct]
         LDA=  @S36D0     34b8 ; =0x36d0 =14032 [Load A with immediate]
         XAZ              34bb ; [Transfer A to Z]
         LDA=  X'0006'    34bc ; =0x0006 =6 [Load A with immediate]
@D34BF   LDB=  X'ACA0'    34bf ; =0xaca0 =44192(-21344) =',',' ' [Load B with immediate]
         LDBB+ Y+         34c2 ; [Load BL indexed, direct, post-incremented]
         BZ    @D34CF     34c4 ; =+9 [Branch if zero]
         SUBB  BL,BU      34c6 ; [BL - BU -> BU]
         BZ    @D34CF     34c8 ; =+5 [Branch if zero]
         STBB+ Z+         34ca ; [Store BL indexed, direct, post-incremented]
         DCA              34cc ; [Decrement A]
         BGZ   @D34BF     34cd ; =-16 [Branch if greater than zero]
@D34CF   XFR   Y,A        34cf ; [Transfer Y to A]
         DCA              34d1 ; [Decrement A]
@W34D2   STA=  X'0000'    34d2 ; =0x0000 =0 =NUL,NUL [Store A immediate]
         LDA/  OSN0+3     34d5 ; [external symbol] [Load A direct]
         XAY              34d8 ; [Transfer A to Y]
         LDAB/ OSN0+5     34d9 ; [external symbol] [Load AL direct]
         LDB=  @S36D0     34dc ; =0x36d0 =14032 [Load B with immediate]
         JSR/  OSN5       34df ; [external symbol] [Jump to subroutine direct]
         DW    SYSBUF     34e2 ; =0x0848 =2120
         BZ    @J352E     34e4 ; =+72 [Branch if zero]
         LDB+  A,7        34e6 ; [Load B indexed, displaced, direct]
         LDAB/ OSN0+5     34e9 ; [external symbol] [Load AL direct]
         STAB  @B3505     34ec ; =+23 [Store AL relative]
         JSR/  OSN4B      34ee ; [external symbol] [Jump to subroutine direct]
@W34F1   DW    HICORE     34f1 ; =0x3d88 =15752
         DB    X'01'      34f3 ; =0x01 =1
         LDA+  Y,14       34f4 ; [Load A indexed, displaced, direct]
         LDB   @W34F1     34f7 ; =-8 [Load B relative]
         SAB              34f9 ; [A - B -> B]
         LDA+  Y,12       34fa ; [Load A indexed, displaced, direct]
         SAB              34fd ; [A - B -> B]
         STB   @W3508     34fe ; =+8 [Store B relative]
         XFR   B,S        3500 ; [Transfer B to S]
         JSR/  OSN4A      3502 ; [external symbol] [Jump to subroutine direct]
@B3505   DB    X'00'      3505 ; =0x00 =0 =NUL
         DW    @S36D0     3506 ; =0x36d0 =14032
@W3508   DW    X'0000'    3508 ; =0x0000 =0 =NUL,NUL
         DB    X'01'      350a ; =0x01 =1
         STB/  X'001A'    350b ; =0x001a =26 [Store B direct]
         LDA=  X'FFEC'    350e ; =0xffec =65516(-20) [Load A with immediate]
         AAB              3511 ; [A + B -> B]
         STB+  Y,12       3512 ; [Store B indexed, displaced, direct]
         XFR   B,S        3515 ; [Transfer B to S]
         CLA              3517 ; [Clear A]
         STA+  Y,14       3518 ; [Store A indexed, displaced, direct]
         LDA   @W34D2+1   351b ; =-74 [Load A relative]
         XAY              351d ; [Transfer A to Y]
@J351E   JSR/  @F346B     351e ; =0x346b =13419 [Jump to subroutine direct]
         LDAB+ Y+         3521 ; [Load AL indexed, direct, post-incremented]
         LDBB= X'AC'      3523 ; =172(-84) =',' [Load BL with immediate]
         SABB             3525 ; [AL - BL -> BL]
         BZ    @D352B     3526 ; =+3 [Branch if zero]
         JMP/  @J3439     3528 ; =0x3439 =13369 [Jump direct]
@D352B   JMP/  @D3475     352b ; =0x3475 =13429 [Jump direct]
@J352E   JSR/  @F354E     352e ; =0x354e =13646 [Jump to subroutine direct]
         DW    @W3953     3531 ; =0x3953 =14675
         JMP/  @J3439     3533 ; =0x3439 =13369 [Jump direct]
@B3536   LDAB= X'00'      3536 ; =0 =NUL [Load AL with immediate]
         STAB/ OSN0+6     3538 ; [external symbol] [Store AL direct]
         LDBB/ OSN0+5     353b ; [external symbol] [Load BL direct]
         STBB/ @B377D     353e ; =0x377d =14205 [Store BL direct]
         STBB/ @B382C     3541 ; =0x382c =14380 [Store BL direct]
         SABB             3544 ; [AL - BL -> BL]
         BP    @D358C     3545 ; =+69 [Branch on plus]
         JSR   @F354E     3547 ; =+5 [Jump to subroutine relative]
         DW    @W396B     3549 ; =0x396b =14699
         JMP/  @J3439     354b ; =0x3439 =13369 [Jump direct]
*
* Function @F354E
*
@F354E   LDA+  X+         354e ; [Load A indexed, direct, post-incremented]
         STA   @S355D     3550 ; =+11 [Store A relative]
         JSR   @F3561     3552 ; =+13 [Jump to subroutine relative]
         DW    @W3557     3554 ; =0x3557 =13655
         RSR              3556 ; [Return from subroutine]
*
@W3557   DW    X'0082'    3557 ; =0x0082 =130
         DB    X'00'      3559 ; =0x00 =0 =NUL
         DW    X'0200'    355a ; =0x0200 =512
         DB    X'50'      355c ; =0x50 =80
@S355D   DB    0,4        355d ; =0x00,0x0004
*
* Function @F3561
*
@F3561   LDB+  X          3561 ; [Load B from address in X]
         LDA/  X'005A'    3562 ; =0x005a =90 [Load A direct]
         LDA+  A,3        3565 ; [Load A indexed, displaced, direct]
         LDA+  A,8        3568 ; [Load A indexed, displaced, direct]
         JSR$  X'005A'    356b ; =0x005a =90 [Jump to OPSYS (SVC)]
         DB    X'0F'      356e ; =0x0f =15 [Service call CONIO - console I/O]
*
@D356F   JSR/  WAIT       356f ; [external symbol] [Jump to subroutine direct]
         LDB+  X          3572 ; [Load B from address in X]
         LDAB+ B          3573 ; [Load AL from address in B]
         BM    @D356F     3574 ; =-7 [Branch on minus]
         LDA+  X+         3576 ; [Load A indexed, direct, post-incremented]
         RSR              3578 ; [Return from subroutine]
*
* Function @F3579
*
@F3579   JSR   @F3561     3579 ; =-26 [Jump to subroutine relative]
         DW    @W36D6     357b ; =0x36d6 =14038
         LDA   @W3583     357d ; =+4 [Load A relative]
         XAY              357f ; [Transfer A to Y]
         JSR/  UCSTR      3580 ; [external symbol] [Jump to subroutine direct]
@W3583   DW    @W36E9     3583 ; =0x36e9 =14057
         RSR              3585 ; [Return from subroutine]
*
@S3586   DC    '@'        3586 ; hex:c0 dec:192(-64)
@S3587   DC    'TXLI'     3587 ; hex:d4d8ccc9
@S358B   DC    'B'        358b ; hex:c2 dec:194(-62)
*
@D358C   CLRB  AU         358c ; [Clear AU]
         XAX              358e ; [Transfer A to X]
         LDA=  BST0       358f ; =0x2d80 =11648 [Load A with immediate]
         XAZ              3592 ; [Transfer A to Z]
@D3593   XFR   X,A        3593 ; [Transfer X to A]
         JSR/  LOCDNO     3595 ; [external symbol] [Jump to subroutine direct]
         BZ    @D35A7     3598 ; =+13 [Branch if zero]
         XFR   Z,A        359a ; [Transfer Z to A]
         STA+  Y,16       359c ; [Store A indexed, displaced, direct]
         CLA              359f ; [Clear A]
         LDAB+ Y,18       35a0 ; [Load AL indexed, displaced, direct]
         INAB             35a3 ; [Increment AL]
         INAB             35a4 ; [Increment AL]
         ADD   A,Z        35a5 ; [A + Z -> Z]
@D35A7   DCX              35a7 ; [Decrement X]
         BP    @D3593     35a8 ; =-23 [Branch on plus]
         XFR   Z,A        35aa ; [Transfer Z to A]
         STA/  TRTAD      35ac ; [external symbol] [Store A direct]
         XAY              35af ; [Transfer A to Y]
         INR   Y          35b0 ; [Increment Y by 1]
         LDB=  @W39CA     35b2 ; =0x39ca =14794 [Load B with immediate]
@D35B5   LDA+  B+         35b5 ; [Load A indexed, direct, post-incremented]
         BZ    @D35BD     35b7 ; =+4 [Branch if zero]
         STA+  Y+         35b9 ; [Store A indexed, direct, post-incremented]
         JMP   @D35B5     35bb ; =-8 [Jump relative]
@D35BD   LDA/  TRTAD      35bd ; [external symbol] [Load A direct]
         INA              35c0 ; [Increment A]
         XAY              35c1 ; [Transfer A to Y]
         LDAB/ @B377D     35c2 ; =0x377d =14205 [Load AL direct]
         LDB=  @S3586     35c5 ; =0x3586 =13702 [Load B with immediate]
         LDX$  OSN0+24    35c8 ; [external symbol] [Load X indirect]
         JSR$  X'005A'    35cb ; =0x005a =90 [Jump to OPSYS (SVC)]
         DB    X'0E'      35ce ; =0x0e =14 [Service call DIRNM - search directory for file name specified]
         DW    SYSBUF     35cf ; =0x0848 =2120 [arg 1]
         BZ    @D35D6     35d1 ; =+3 [Branch if zero]
         LDX+  A,7        35d3 ; [Load X indexed, displaced, direct]
@D35D6   STX   @W35F8     35d6 ; =+32 [Store X relative]
         CLR   X          35d8 ; [Clear X]
@D35DA   LDA+  Y          35da ; [Load A from address in Y]
         INA              35db ; [Increment A]
         BNZ   @D3602     35dc ; =+36 [Branch if not zero]
         LDA=  X'03E8'    35de ; =0x03e8 =1000 [Load A with immediate]
         ADD   X,A        35e1 ; [X + A -> A]
         JSR$  X'005A'    35e3 ; =0x005a =90 [Jump to OPSYS (SVC)]
         DB    X'2E'      35e6 ; =0x2e =46 [Service call CVR16 - 16-bit convert to decimal from A register]
         DW    @S358B     35e7 ; =0x358b =13707 [address of end of string]
         LDA=  X'D4D8'    35e9 ; =0xd4d8 =54488(-11048) ='T','X' [Load A with immediate]
         STA   @S3587     35ec ; =-103 [Store A relative]
         LDAB/ @B377D     35ee ; =0x377d =14205 [Load AL direct]
         LDB=  @S3586     35f1 ; =0x3586 =13702 [Load B with immediate]
         JSR$  X'005A'    35f4 ; =0x005a =90 [Jump to OPSYS (SVC)]
         DB    X'0D'      35f7 ; =0x0d =13 [Service call DIRPD - search pri dir]
@W35F8   DW    X'0000'    35f8 ; =0x0000 =0 =NUL,NUL [arg 1]
         DW    SYSBUF     35fa ; =0x0848 =2120 [arg 2]
         BZ    @D3609     35fc ; =+11 [Branch if zero]
         LDA+  A,7        35fe ; [Load A indexed, displaced, direct]
         STA+  Y          3601 ; [Store A to address in Y]
@D3602   INR   Y          3602 ; [Increment Y by 1]
         INR   Y          3604 ; [Increment Y by 1]
         INX              3606 ; [Increment X]
         JMP   @D35DA     3607 ; =-47 [Jump relative]
@D3609   XFRB  XL,AL      3609 ; [Transfer XL to AL]
         STAB$ TRTAD      360b ; [external symbol] [Store AL indirect]
         CLA              360e ; [Clear A]
         STA+  Y          360f ; [Store A to address in Y]
         LDAB= X'7F'      3610 ; =127 [Load AL with immediate]
         STAB+ Y,4        3612 ; [Store AL indexed, displaced, direct]
         LDAB= X'FF'      3615 ; =255(-1) [Load AL with immediate]
         STAB+ Y,9        3617 ; [Store AL indexed, displaced, direct]
         XFR   Y,A        361a ; [Transfer Y to A]
         STA+  Y,5        361c ; [Store A indexed, displaced, direct]
         LDB=  X'0005'    361f ; =0x0005 =5 [Load B with immediate]
         STB+  Y,2        3622 ; [Store B indexed, displaced, direct]
         ADD   B,A        3625 ; [B + A -> A]
         STA/  TRPNT      3627 ; [external symbol] [Store A direct]
         LDA=  TSIZE      362a ; [external symbol] [Load A with immediate]
         SAB              362d ; [A - B -> B]
         STB+  Y,7        362e ; [Store B indexed, displaced, direct]
         ADD   Y,A        3631 ; [Y + A -> A]
         LDB$  OSN0+7     3633 ; [external symbol] [Load B indirect]
         STA+  B,10       3636 ; [Store A indexed, displaced, direct]
         STA+  B,14       3639 ; [Store A indexed, displaced, direct]
         JSR/  @F376E     363c ; =0x376e =14190 [Jump to subroutine direct]
         LDA/  OSN0+22    363f ; [external symbol] [Load A direct]
         XAY              3642 ; [Transfer A to Y]
         LDA$  OSN0+24    3643 ; [external symbol] [Load A indirect]
         STA   @W368B     3646 ; =+67 [Store A relative]
         LDAB/ @B377D     3648 ; =0x377d =14205 [Load AL direct]
         LDB=  @S36CA     364b ; =0x36ca =14026 [Load B with immediate]
         JSR$  X'005A'    364e ; =0x005a =90 [Jump to OPSYS (SVC)]
         DB    X'0E'      3651 ; =0x0e =14 [Service call DIRNM - search directory for file name specified]
         DW    SYSBUF     3652 ; =0x0848 =2120 [arg 1]
         BZ    @D365B     3654 ; =+5 [Branch if zero]
         LDB+  A,7        3656 ; [Load B indexed, displaced, direct]
         STB   @W368B     3659 ; =+48 [Store B relative]
@D365B   LDAB= X'A0'      365b ; =160(-96) =' ' [Load AL with immediate]
         STAB/ @S36C8     365d ; =0x36c8 =14024 [Store AL direct]
         CLA              3660 ; [Clear A]
@D3661   LDB/  OSN0+20    3661 ; [external symbol] [Load B direct]
         SAB              3664 ; [A - B -> B]
         BGZ   @D369F     3665 ; =+56 [Branch if greater than zero]
         STA   @W366D     3667 ; =+4 [Store A relative]
         JSR$  X'005A'    3669 ; =0x005a =90 [Jump to OPSYS (SVC)]
         DB    X'2D'      366c ; =0x2d =45 [Service call CVD16 - 16-bit convert to decimal from memory]
@W366D   DW    X'0000'    366d ; =0x0000 =0 =NUL,NUL [value]
         DW    @S36C9     366f ; =0x36c9 =14025 [address of end of string]
         LDA=  X'CAD8'    3671 ; =0xcad8 =51928(-13608) ='J','X' [Load A with immediate]
         STA   @S36C6     3674 ; =+80 [Store A relative]
         LDAB  @S36C8     3676 ; =+80 [Load AL relative]
         LDBB= X'A0'      3678 ; =160(-96) =' ' [Load BL with immediate]
         SABB             367a ; [AL - BL -> BL]
         BNZ   @D3681     367b ; =+4 [Branch if not zero]
         LDAB= X'B0'      367d ; =176(-80) ='0' [Load AL with immediate]
         STAB  @S36C8     367f ; =+71 [Store AL relative]
@D3681   LDAB/ @B377D     3681 ; =0x377d =14205 [Load AL direct]
         LDB=  @S36C4     3684 ; =0x36c4 =14020 [Load B with immediate]
         JSR$  X'005A'    3687 ; =0x005a =90 [Jump to OPSYS (SVC)]
         DB    X'0D'      368a ; =0x0d =13 [Service call DIRPD - search pri dir]
@W368B   DW    X'0000'    368b ; =0x0000 =0 =NUL,NUL [arg 1]
         DW    SYSBUF     368d ; =0x0848 =2120 [arg 2]
         BZ    @D369A     368f ; =+9 [Branch if zero]
         LDB+  A,7        3691 ; [Load B indexed, displaced, direct]
         LDA   @W366D     3694 ; =-41 [Load A relative]
         SLA              3696 ; [Left shift A]
         ADD   Y,A        3697 ; [Y + A -> A]
         STB+  A          3699 ; [Store B to address in A]
@D369A   LDA   @W366D     369a ; =-47 [Load A relative]
         INA              369c ; [Increment A]
         JMP   @D3661     369d ; =-62 [Jump relative]
@D369F   LDA$  OSN0+7     369f ; [external symbol] [Load A indirect]
         XAZ              36a2 ; [Transfer A to Z]
         LDB+  Z,8        36a3 ; [Load B indexed, displaced, direct]
         STA+  B,25       36a6 ; [Store A indexed, displaced, direct]
         LDAB+ B,24       36a9 ; [Load AL indexed, displaced, direct]
         STAB+ Z,36       36ac ; [Store AL indexed, displaced, direct]
         CLAB             36af ; [Clear AL]
         STAB+ B,15       36b0 ; [Store AL indexed, displaced, direct]
         INAB             36b3 ; [Increment AL]
         STAB+ Z          36b4 ; [Store AL to address in Z]
         LDAB+ Z,18       36b5 ; [Load AL indexed, displaced, direct]
         LDBB= X'02'      36b8 ; =2 [Load BL with immediate]
         ORIB  AL,BL      36ba ; [AL | BL -> BL]
         STBB+ Z,18       36bc ; [Store BL indexed, displaced, direct]
         JSR$  X'005A'    36bf ; =0x005a =90 [Jump to OPSYS (SVC)]
         DB    X'0A'      36c2 ; =0x0a =10 [Service call EXIT - exit to OJX00]
         DB    X'FF'      36c3 ; =0xff =255(-1) [completion code]
@S36C4   DC    '@O'       36c4 ; hex:c0cf dec:49359(-49)
@S36C6   DC    'JX'       36c6 ; hex:cad8 dec:51928(-40)
@S36C8   DC    'N'        36c8 ; hex:ce dec:206(-50)
@S36C9   DC    'N'        36c9 ; hex:ce dec:206(-50)
@S36CA   DC    '@JXLIB'   36ca ; hex:c0cad8ccc9c2
@S36D0   DC    '  '       36d0 ; hex:a0a0 dec:41120(-96)
@S36D2   DC    '  '       36d2 ; hex:a0a0 dec:41120(-96)
@S36D4   DC    '  '       36d4 ; hex:a0a0 dec:41120(-96)
@W36D6   DW    X'0080'    36d6 ; =0x0080 =128
         DB    X'00'      36d8 ; =0x00 =0 =NUL
         DW    X'0100'    36d9 ; =0x0100 =256
         DB    X'50'      36db ; =0x50 =80
         DW    @W36E9     36dc ; =0x36e9 =14057
         DW    X'0000'    36de ; =0x0000 =0 =NUL,NUL
@W36E0   DW    @W36E7     36e0 ; =0x36e7 =14055
         DB    0,5        36e2 ; =0x00,0x0005
@W36E7   DW    X'0050'    36e7 ; =0x0050 =80
@W36E9   DS    2          36e9 ; [Uninitialized memory]
@W36EB   DS    80         36eb ; [Uninitialized memory]
         DB    X'00'      373b ; =0x00 =0 =NUL
*
*
* Function @F373C
*
@F373C   LDAB+ Y          373c ; [Load AL from address in Y]
         JSR   @F3762     373d ; =+35 [Jump to subroutine relative]
         BP    @D3744     373f ; =+3 [Branch on plus]
         CLA              3741 ; [Clear A]
         DCA              3742 ; [Decrement A]
         RSR              3743 ; [Return from subroutine]
*
@D3744   CLA              3744 ; [Clear A]
         STA-  S-         3745 ; [Push A to the stack]
@D3747   LDAB+ Y+         3747 ; [Load AL indexed, direct, post-incremented]
         JSR   @F3762     3749 ; =+23 [Jump to subroutine relative]
         BP    @D3755     374b ; =+8 [Branch on plus]
         DCR   Y          374d ; [Decrement Y by 1]
         JSR/  @F346B     374f ; =0x346b =13419 [Jump to subroutine direct]
         LDA+  S+         3752 ; [Pop A from the stack]
         RSR              3754 ; [Return from subroutine]
*
@D3755   LDA+  S          3755 ; [Load A from address in S]
         STBB+ S          3756 ; [Store BL to address in S]
         SLA              3757 ; [Left shift A]
         XAB              3758 ; [Transfer A to B]
         SLA              3759 ; [Left shift A]
         SLA              375a ; [Left shift A]
         AAB              375b ; [A + B -> B]
         CLA              375c ; [Clear A]
         LDAB+ S          375d ; [Load AL from address in S]
         AAB              375e ; [A + B -> B]
         STB+  S          375f ; [Store B to address in S]
         JMP   @D3747     3760 ; =-27 [Jump relative]
*
* Function @F3762
*
@F3762   LDBB= X'B9'      3762 ; =185(-71) ='9' [Load BL with immediate]
         SABB             3764 ; [AL - BL -> BL]
         BLE   @D376A     3765 ; =+3 [Branch if less than or equal to zero]
         LDBB= X'FF'      3767 ; =255(-1) [Load BL with immediate]
         RSR              3769 ; [Return from subroutine]
*
@D376A   LDBB= X'B0'      376a ; =176(-80) ='0' [Load BL with immediate]
         SABB             376c ; [AL - BL -> BL]
         RSR              376d ; [Return from subroutine]
*
* Function @F376E
*
@F376E   STX-  S-         376e ; [Push X to the stack]
         LDB=  X'000E'    3770 ; =0x000e =14 [Load B with immediate]
         LDAB  @B377D     3773 ; =+8 [Load AL relative]
         STB   @W377E     3775 ; =+7 [Store B relative]
         STB/  @W382D     3777 ; =0x382d =14381 [Store B direct]
         JSR/  DIO        377a ; [external symbol] [Jump to subroutine direct]
@B377D   DB    X'00'      377d ; =0x00 =0 =NUL
@W377E   DW    X'0000'    377e ; =0x0000 =0 =NUL,NUL
         DW    SYSBUF     3780 ; =0x0848 =2120
         DB    X'01'      3782 ; =0x01 =1
         LDA/  SYSBUF     3783 ; [external symbol] [Load A direct]
         BNZ   @D3789     3786 ; =+1 [Branch if not zero]
         INA              3788 ; [Increment A]
@D3789   STA/  SYSBUF     3789 ; [external symbol] [Store A direct]
         STA/  DATE       378c ; [external symbol] [Store A direct]
         JSR/  TX004      378f ; [external symbol] [Jump to subroutine direct]
         DW    @W399B     3792 ; =0x399b =14747
         LDA/  OSN0+3     3794 ; [external symbol] [Load A direct]
         LDB=  @W36E0     3797 ; =0x36e0 =14048 [Load B with immediate]
         STB+  A,25       379a ; [Store B indexed, displaced, direct]
         JSR/  @F354E     379d ; =0x354e =13646 [Jump to subroutine direct]
         DW    @W3983     37a0 ; =0x3983 =14723
*
         JSR/  @F354E     37a2 ; =0x354e =13646 [Jump to subroutine direct]
         DW    @W39C7     37a5 ; =0x39c7 =14791
*
@D37A7   LDA$  OSN0+7     37a7 ; [external symbol] [Load A indirect]
         LDA+  A,8        37aa ; [Load A indexed, displaced, direct]
         XAZ              37ad ; [Transfer A to Z]
         JSR/  @F354E     37ae ; =0x354e =13646 [Jump to subroutine direct]
         DW    @W392C     37b1 ; =0x392c =14636
         JSR/  @F3579     37b3 ; =0x3579 =13689 [Jump to subroutine direct]
         LDBB+ Z,14       37b6 ; [Load BL indexed, displaced, direct]
         LDA/  X'005A'    37b9 ; =0x005a =90 [Load A direct]
         XAZ              37bc ; [Transfer A to Z]
         LDAB= X'8A'      37bd ; =138(-118) =LF [Load AL with immediate]
         SABB             37bf ; [AL - BL -> BL]
         BZ    @D37F7     37c0 ; =+53 [Branch if zero]
         LDA+  Y+         37c2 ; [Load A indexed, direct, post-incremented]
         BZ    @D37A7     37c4 ; =-31 [Branch if zero]
         JSR/  TX005      37c6 ; [external symbol] [Jump to subroutine direct]
         DW    @W36EB     37c9 ; =0x36eb =14059
         XAB              37cb ; [Transfer A to B]
         BZ    @D37A7     37cc ; =-39 [Branch if zero]
         STA/  DATE       37ce ; [external symbol] [Store A direct]
         JMP   @D37F7     37d1 ; =+36 [Jump relative]
*
@W37D3   DW    X'0000'    37d3 ; =0x0000 =0 =NUL,NUL
@W37D5   DW    X'0000'    37d5 ; =0x0000 =0 =NUL,NUL
@S37D7   DB    0,4        37d7 ; =0x00,0x0004
@S37DB   DB    0,4        37db ; =0x00,0x0004
@S37DF   DB    0,4        37df ; =0x00,0x0004
@S37E3   DC    '  '       37e3 ; hex:a0a0 dec:41120(-96)
@S37E5   DC    '  '       37e5 ; hex:a0a0 dec:41120(-96)
@S37E7   DC    '  '       37e7 ; hex:a0a0 dec:41120(-96)
@W37E9   DW    X'0300'    37e9 ; =0x0300 =768
         DW    X'0600'    37eb ; =0x0600 =1536
@W37ED   DW    X'0300'    37ed ; =0x0300 =768
         DW    X'0203'    37ef ; =0x0203 =515
         DB    X'00'      37f1 ; =0x00 =0 =NUL
         DW    X'0203'    37f2 ; =0x0203 =515
         DB    X'00'      37f4 ; =0x00 =0 =NUL
         DW    X'0200'    37f5 ; =0x0200 =512
*
@D37F7   LDA/  DATE       37f7 ; [external symbol] [Load A direct]
         JSR/  TX004      37fa ; [external symbol] [Jump to subroutine direct]
         DW    OSN0+48    37fd ; =0x0130 =304
         LDA/  OSN0+48    37ff ; [external symbol] [Load A direct]
         STA   @S37E3     3802 ; =-33 [Store A relative]
         LDA/  OSN0+51    3804 ; [external symbol] [Load A direct]
         STA   @S37E5     3807 ; =-36 [Store A relative]
         LDA/  OSN0+54    3809 ; [external symbol] [Load A direct]
         STA   @S37E7     380c ; =-39 [Store A relative]
         JSR/  @DC        380e ; [external symbol] [Jump to subroutine direct]
         DW    @S37E3     3811 ; =0x37e3 =14307
         DW    @W37E9     3813 ; =0x37e9 =14313
         DW    OSN0+44    3815 ; =0x012c =300
         DW    X'0000'    3817 ; =0x0000 =0 =NUL,NUL
         LDA/  DATE       3819 ; [external symbol] [Load A direct]
         LDB/  SYSBUF     381c ; [external symbol] [Load B direct]
         SAB              381f ; [A - B -> B]
         BZ    @D3837     3820 ; =+21 [Branch if zero]
         STA/  SYSBUF     3822 ; [external symbol] [Store A direct]
         JSR/  FLGWT      3825 ; [external symbol] [Jump to subroutine direct]
         DB    X'1C'      3828 ; =0x1c =28
*
         JSR/  DIO        3829 ; [external symbol] [Jump to subroutine direct]
@B382C   DB    X'00'      382c ; =0x00 =0 =NUL
@W382D   DW    X'0000'    382d ; =0x0000 =0 =NUL,NUL
         DW    SYSBUF     382f ; =0x0848 =2120
         DB    X'02'      3831 ; =0x02 =2
         LDAB= X'FF'      3832 ; =255(-1) [Load AL with immediate]
         STAB/ OSN0+28    3834 ; [external symbol] [Store AL direct]
@D3837   JSR/  @F354E     3837 ; =0x354e =13646 [Jump to subroutine direct]
         DW    @W39C7     383a ; =0x39c7 =14791
*
         JSR/  @F354E     383c ; =0x354e =13646 [Jump to subroutine direct]
         DW    @W39A4     383f ; =0x39a4 =14756
         JSR/  @F3579     3841 ; =0x3579 =13689 [Jump to subroutine direct]
         LDB/  IODJZ      3844 ; [external symbol] [Load B direct]
         CLA              3847 ; [Clear A]
         STAB/ OSN0+65    3848 ; [external symbol] [Store AL direct]
         STA/  IODJUW     384b ; [external symbol] [Store A direct]
         STA+  B          384e ; [Store A to address in B]
         STA-  B-         384f ; [Store A indexed, pre-decremented, direct]
         LDA=  X'000A'    3851 ; =0x000a =10 [Load A with immediate]
         STA-  B-         3854 ; [Store A indexed, pre-decremented, direct]
         STA-  B-         3856 ; [Store A indexed, pre-decremented, direct]
         LDA=  X'0006'    3858 ; =0x0006 =6 [Load A with immediate]
         STA-  B-         385b ; [Store A indexed, pre-decremented, direct]
         LDA+  Y+         385d ; [Load A indexed, direct, post-incremented]
         XFR   Y,B        385f ; [Transfer Y to B]
         STB   @W388A     3861 ; =+39 [Store B relative]
         LDB/  OSN0+7     3863 ; [external symbol] [Load B direct]
         XFR   B,Y        3866 ; [Transfer B to Y]
         LDB=  X'0001'    3868 ; =0x0001 =1 [Load B with immediate]
         SAB              386b ; [A - B -> B]
         BGZ   @D3871     386c ; =+3 [Branch if greater than zero]
         CLAB             386e ; [Clear AL]
         JMP   @D3873     386f ; =+2 [Jump relative]
@D3871   LDAB= X'20'      3871 ; =32 [Load AL with immediate]
@D3873   LDX+  Y+         3873 ; [Load X indexed, direct, post-incremented]
         BZ    @D3887     3875 ; =+16 [Branch if zero]
         LDBB+ X,18       3877 ; [Load BL indexed, displaced, direct]
         ORIB  AL,BL      387a ; [AL | BL -> BL]
         STBB+ X,18       387c ; [Store BL indexed, displaced, direct]
         LDBB/ OSN0+5     387f ; [external symbol] [Load BL direct]
         STBB+ X,45       3882 ; [Store BL indexed, displaced, direct]
         JMP   @D3873     3885 ; =-20 [Jump relative]
@D3887   JSR/  @DC        3887 ; [external symbol] [Jump to subroutine direct]
@W388A   DW    X'0000'    388a ; =0x0000 =0 =NUL,NUL
         DW    @W37E9     388c ; =0x37e9 =14313
         DW    @S37D7     388e ; =0x37d7 =14295
         DW    X'0000'    3890 ; =0x0000 =0 =NUL,NUL
*
         JSR/  @NC        3892 ; [external symbol] [Jump to subroutine direct]
         DW    IODJT      3895 ; =0x2858 =10328
         DW    @W37E9     3897 ; =0x37e9 =14313
         DW    @S37D7     3899 ; =0x37d7 =14295
         DW    X'0000'    389b ; =0x0000 =0 =NUL,NUL
         LDA=  X'B0B0'    389d ; =0xb0b0 =45232(-20304) ='0','0' [Load A with immediate]
         STA/  @S37E3     38a0 ; =0x37e3 =14307 [Store A direct]
         STA/  @S37E5     38a3 ; =0x37e5 =14309 [Store A direct]
         JSR/  @NC        38a6 ; [external symbol] [Jump to subroutine direct]
         DW    @S37E3     38a9 ; =0x37e3 =14307
         DW    @W37E9     38ab ; =0x37e9 =14313
         DW    @S37D7     38ad ; =0x37d7 =14295
         DW    X'0000'    38af ; =0x0000 =0 =NUL,NUL
*
         JSR/  @DC        38b1 ; [external symbol] [Jump to subroutine direct]
         DW    @S37E3     38b4 ; =0x37e3 =14307
         DW    @W37ED     38b6 ; =0x37ed =14317
         DW    @S37D7     38b8 ; =0x37d7 =14295
         DW    @S37DB     38ba ; =0x37db =14299
         DW    @S37DF     38bc ; =0x37df =14303
         DW    X'0000'    38be ; =0x0000 =0 =NUL,NUL
*
         JSR/  LOD32      38c0 ; [external symbol] [Jump to subroutine direct]
         DW    @S37D7     38c3 ; =0x37d7 =14295
*
         JSR/  MUL32      38c5 ; [external symbol] [Jump to subroutine direct]
         DW    X'003C'    38c8 ; =0x003c =60
*
         JSR/  ADD32      38ca ; [external symbol] [Jump to subroutine direct]
         DW    @S37DB     38cd ; =0x37db =14299
*
         JSR/  MUL32      38cf ; [external symbol] [Jump to subroutine direct]
         DW    X'003C'    38d2 ; =0x003c =60
*
         JSR/  ADD32      38d4 ; [external symbol] [Jump to subroutine direct]
         DW    @S37DF     38d7 ; =0x37df =14303
*
         JSR/  MUL32      38d9 ; [external symbol] [Jump to subroutine direct]
         DW    X'000A'    38dc ; =0x000a =10
*
         JSR/  STO32      38de ; [external symbol] [Jump to subroutine direct]
         DW    @W37D3     38e1 ; =0x37d3 =14291
         LDA/  @W37D5     38e3 ; =0x37d5 =14293 [Load A direct]
         LDB$  IODJY      38e6 ; [external symbol] [Load B indirect]
         AAB              38e9 ; [A + B -> B]
         LDA/  @W37D3     38ea ; =0x37d3 =14291 [Load A direct]
         BNL   @D38F0     38ed ; =+1 [Branch on no link]
         INA              38ef ; [Increment A]
@D38F0   STB$  IODJY      38f0 ; [external symbol] [Store B indirect]
         LDB/  IODJUW     38f3 ; [external symbol] [Load B direct]
         AAB              38f6 ; [A + B -> B]
         STB/  IODJUW     38f7 ; [external symbol] [Store B direct]
         JSR/  @F354E     38fa ; =0x354e =13646 [Jump to subroutine direct]
         DW    @W39C7     38fd ; =0x39c7 =14791
         LDX+  S+         38ff ; [Pop X from the stack]
         RSR              3901 ; [Return from subroutine]
*
@W3902   DW    X'0001'    3902 ; =0x0001 =1
         DB    X'8C'      3904 ; =0x8c =140(-116) =FF
@W3905   DW    X'0025'    3905 ; =0x0025 =37
         DC    'MAX DISK# (M)' 3907
@S3914   DC    '='        3914 ; hex:bd dec:189(-67)
@S3915   DC    'X'        3915 ; hex:d8 dec:216(-40)
@S3916   DC    'X, SYSTEM DISK (S)' 3916
@S3928   DC    '='        3928 ; hex:bd dec:189(-67)
@S3929   DC    'X'        3929 ; hex:d8 dec:216(-40)
@S392A   DC    'X'        392a ; hex:d8 dec:216(-40)
         DB    X'8D'      392b ; =0x8d =141(-115) =CR
@W392C   DW    X'0025'    392c ; =0x0025 =37
         DC    'ENTER NEW SYSTEM DATE: MMDDYY ' 392e
         DW    X'8888'    394c ; =0x8888 =34952(-30584) =BS,BS
         DW    X'8888'    394e ; =0x8888 =34952(-30584) =BS,BS
         DW    X'8888'    3950 ; =0x8888 =34952(-30584) =BS,BS
         DB    X'88'      3952 ; =0x88 =136(-120) =BS
@W3953   DW    X'0016'    3953 ; =0x0016 =22
         DC    'ILLEGAL SET STATEMENT' 3955
         DB    X'8D'      396a ; =0x8d =141(-115) =CR
@W396B   DW    X'0016'    396b ; =0x0016 =22
         DC    'ILLOGICAL SYSTEM DISK' 396d
         DB    X'8D'      3982 ; =0x8d =141(-115) =CR
@W3983   DW    X'001F'    3983 ; =0x001f =31
         DC    'PREVIOUS SYSTEM DATE: ' 3985
@W399B   DW    X'0000'    399b ; =0x0000 =0 =NUL,NUL
         DC    '/'        399d ; hex:af dec:175(-81)
         DB    X'00'      399e ; =0x00 =0 =NUL
         DB    X'00'      399f ; =0x00 =0 =NUL
         DC    '/'        39a0 ; hex:af dec:175(-81)
         DB    X'00'      39a1 ; =0x00 =0 =NUL
         DW    X'008D'    39a2 ; =0x008d =141 =NUL,CR
@W39A4   DW    X'0021'    39a4 ; =0x0021 =33
         DC    'ENTER SYSTEM TIME: HHMMSS ' 39a6
         DW    X'8888'    39c0 ; =0x8888 =34952(-30584) =BS,BS
         DW    X'8888'    39c2 ; =0x8888 =34952(-30584) =BS,BS
         DW    X'8888'    39c4 ; =0x8888 =34952(-30584) =BS,BS
         DB    X'88'      39c6 ; =0x88 =136(-120) =BS
@W39C7   DW    X'0001'    39c7 ; =0x0001 =1
         DB    X'8D'      39c9 ; =0x8d =141(-115) =CR
@W39CA   DS    514        39ca ; [Uninitialized memory]
*
* Function OSNMSG (OSNLB5)
*
* OSN version message.
*
*
OSNMSG   DW    X'000B'    3bcc ; =0x000b =11
         DC    'DOS 5.6 - D' 3bce
*
*
* Function TX004 (OSNLB4/OSNLB5)
*
* Convert date in A to string.
* Additional identical copies in OSNLB4 and OSNLB5.
*
* ASM:
*   Input: A = input date
*   Clobbers: A, B
*     JSR/ TX004
*     DW STR     ; address of string
*
TX004    XAB              3bd9 ; [Transfer A to B]
         BNZ   @D3BFD     3bda ; =+33 [Branch if not zero]
         LDA/  X'005A'    3bdc ; =0x005a =90 [Load A direct]
         LDA+  A,3        3bdf ; [Load A indexed, displaced, direct]
         LDA+  A,25       3be2 ; [Load A indexed, displaced, direct]
         BZ    @D3BEC     3be5 ; =+5 [Branch if zero]
         LDBB= X'02'      3be7 ; =2 [Load BL with immediate]
         STBB+ A,6        3be9 ; [Store BL indexed, displaced, direct]
@D3BEC   LDA+  X+         3bec ; [Load A indexed, direct, post-incremented]
         LDB=  X'A0A0'    3bee ; =0xa0a0 =41120(-24416) =' ',' ' [Load B with immediate]
         STB+  A+         3bf1 ; [Store B indexed, direct, post-incremented]
         STB+  A+         3bf3 ; [Store B indexed, direct, post-incremented]
         STB+  A+         3bf5 ; [Store B indexed, direct, post-incremented]
         STB+  A          3bf7 ; [Store B to address in A]
         JSR$  X'005A'    3bf8 ; =0x005a =90 [Jump to OPSYS (SVC)]
         DB    X'01'      3bfb ; =0x01 =1 [Service call TRTN - transient return]
         DB    X'FF'      3bfc ; =0xff =255(-1) [return code]
*
@D3BFD   DCA              3bfd ; [Decrement A]
         LDB=  X'FA4B'    3bfe ; =0xfa4b =64075(-1461) [Load B with immediate]
         STX-  S-         3c01 ; [Push X to the stack]
         LDX=  X'FFFF'    3c03 ; =0xffff =65535(-1) [Load X with immediate]
@D3C06   INX              3c06 ; [Increment X]
         ADD   B,A        3c07 ; [B + A -> A]
         BL    @D3C06     3c09 ; =-5 [Branch on link]
         SAB              3c0b ; [A - B -> B]
         SLR   X          3c0c ; [Left shift X by 1]
         SLR   X          3c0e ; [Left shift X by 1]
         LDAB= X'E3'      3c10 ; =227(-29) ='c' [Load AL with immediate]
         STAB  @B3C77     3c12 ; =+99 [Store AL relative]
         LDA=  X'FE93'    3c14 ; =0xfe93 =65171(-365) [Load A with immediate]
         AAB              3c17 ; [A + B -> B]
         BLE   @D3C26     3c18 ; =+12 [Branch if less than or equal to zero]
         LDAB= X'E4'      3c1a ; =228(-28) ='d' [Load AL with immediate]
         STAB  @B3C77     3c1c ; =+89 [Store AL relative]
         LDAB= X'93'      3c1e ; =147(-109) [Load AL with immediate]
         DCR   B          3c20 ; [Decrement B by 1]
@D3C22   INX              3c22 ; [Increment X]
         AAB              3c23 ; [A + B -> B]
         BP    @D3C22     3c24 ; =-4 [Branch on plus]
@D3C26   SUB   B,A        3c26 ; [B - A -> A]
         STA-  S-         3c28 ; [Push A to the stack]
         JSR   @F3C69     3c2a ; =+61 [Jump to subroutine relative]
         LDA+  *S,2       3c2c ; [Load A indexed, displaced, indirect]
         STB+  A,6        3c2f ; [Store B indexed, displaced, direct]
         LDA=  X'FFFF'    3c32 ; =0xffff =65535(-1) [Load A with immediate]
         LDB+  S+         3c35 ; [Pop B from the stack]
         LDX=  @W3C76     3c37 ; =0x3c76 =15478 [Load X with immediate]
@D3C3A   LDAB+ X+         3c3a ; [Load AL indexed, direct, post-incremented]
         AAB              3c3c ; [A + B -> B]
         BL    @D3C3A     3c3d ; =-5 [Branch on link]
         SUBB  BL,AL      3c3f ; [BL - AL -> AL]
         STAB- S-         3c41 ; [Push AL to the stack]
         LDA=  @W3C76     3c43 ; =0x3c76 =15478 [Load A with immediate]
         SUB   X,A        3c46 ; [X - A -> A]
         XAX              3c48 ; [Transfer A to X]
         JSR   @F3C69     3c49 ; =+30 [Jump to subroutine relative]
         LDA+  *S,1       3c4b ; [Load A indexed, displaced, indirect]
         STB+  A          3c4e ; [Store B to address in A]
         CLA              3c4f ; [Clear A]
         LDAB+ S+         3c50 ; [Pop AL from the stack]
         INA              3c52 ; [Increment A]
         XAX              3c53 ; [Transfer A to X]
         JSR   @F3C69     3c54 ; =+19 [Jump to subroutine relative]
         LDX+  S+         3c56 ; [Pop X from the stack]
         LDA+  X+         3c58 ; [Load A indexed, direct, post-incremented]
         STB+  A+,3       3c5a ; [Store B indexed, displaced, direct, post-incremented]
         LDBB= X'AF'      3c5d ; =175(-81) ='/' [Load BL with immediate]
         STBB+ A          3c5f ; [Store BL to address in A]
         STBB+ A,3        3c60 ; [Store BL indexed, displaced, direct]
         JSR$  X'005A'    3c63 ; =0x005a =90 [Jump to OPSYS (SVC)]
         DB    X'01'      3c66 ; =0x01 =1 [Service call TRTN - transient return]
         DB    X'FF'      3c67 ; =0xff =255(-1) [return code]
         DB    X'FF'      3c68 ; =0xff =255(-1)
*
*
* Function @F3C69
*
@F3C69   LDB+  S          3c69 ; [Load B from address in S]
         LDAB= X'F6'      3c6a ; =246(-10) ='v' [Load AL with immediate]
@D3C6C   INRB  BU         3c6c ; [Increment BU by 1]
         AABB             3c6e ; [AL + BL -> BL]
         BL    @D3C6C     3c6f ; =-5 [Branch on link]
         LDA=  X'AEBA'    3c71 ; =0xaeba =44730(-20806) ='.',':' [Load A with immediate]
         AAB              3c74 ; [A + B -> B]
         RSR              3c75 ; [Return from subroutine]
*
@W3C76   DB    X'E1'      3c76 ; =0xe1 =225(-31) ='a'
@B3C77   DW    X'E4E1'    3c77 ; =0xe4e1 =58593(-6943) ='d','a'
         DW    X'E2E1'    3c79 ; =0xe2e1 =58081(-7455) ='b','a'
         DW    X'E2E1'    3c7b ; =0xe2e1 =58081(-7455) ='b','a'
         DW    X'E1E2'    3c7d ; =0xe1e2 =57826(-7710) ='a','b'
         DW    X'E1E2'    3c7f ; =0xe1e2 =57826(-7710) ='a','b'
         DB    X'E1'      3c81 ; =0xe1 =225(-31) ='a'
*
*
* Function TX005 (OSNLB4/OSNLB5)
*
* Additional identical copies in OSNLB4 and OSNLB5.
*
*
TX005    XFR   Y,A        3c82 ; [Transfer Y to A]
         STA-  S-         3c84 ; [Push A to the stack]
         LDA+  X+         3c86 ; [Load A indexed, direct, post-incremented]
         STX-  S-         3c88 ; [Push X to the stack]
         XFR   S,B        3c8a ; [Transfer S to B]
@W3C8C   STB=  X'0000'    3c8c ; =0x0000 =0 =NUL,NUL [Store B immediate]
         LDB=  X'FFFA'    3c8f ; =0xfffa =65530(-6) [Load B with immediate]
         ADD   B,S        3c92 ; [B + S -> S]
         XAY              3c94 ; [Transfer A to Y]
         CLR   X          3c95 ; [Clear X]
@D3C97   INX              3c97 ; [Increment X]
         LDBB+ Y+         3c98 ; [Load BL indexed, direct, post-incremented]
         BNZ   @D3C97     3c9a ; =-5 [Branch if not zero]
         DCR   Y          3c9c ; [Decrement Y by 1]
         JSR/  @F3D1C     3c9e ; =0x3d1c =15644 [Jump to subroutine direct]
         LDBB= X'1C'      3ca1 ; =28 [Load BL with immediate]
@P3CA3   STBB/ @B3D56     3ca3 ; =0x3d56 =15702 [Store BL direct]
         LDBB= X'03'      3ca6 ; =3 [Load BL with immediate]
         NABB             3ca8 ; [AL & BL -> BL]
         BNZ   @D3CAF     3ca9 ; =+4 [Branch if not zero]
         LDBB= X'1D'      3cab ; =29 [Load BL with immediate]
         STBB* @P3CA3+1   3cad ; =-11 [Store BL relative indirect]
@D3CAF   XAB              3caf ; [Transfer A to B]
         DCA              3cb0 ; [Decrement A]
         SRA              3cb1 ; [Arithmetic right shift A]
         SRA              3cb2 ; [Arithmetic right shift A]
         INA              3cb3 ; [Increment A]
         STA+  S          3cb4 ; [Store A to address in S]
         XFR   B,A        3cb5 ; [Transfer B to A]
         SLA              3cb7 ; [Left shift A]
         SLA              3cb8 ; [Left shift A]
         AAB              3cb9 ; [A + B -> B]
         XFR   B,A        3cba ; [Transfer B to A]
         SLA              3cbc ; [Left shift A]
         SLA              3cbd ; [Left shift A]
         SLA              3cbe ; [Left shift A]
         AAB              3cbf ; [A + B -> B]
         SLA              3cc0 ; [Left shift A]
         SLA              3cc1 ; [Left shift A]
         SLA              3cc2 ; [Left shift A]
         AAB              3cc3 ; [A + B -> B]
         LDA+  S          3cc4 ; [Load A from address in S]
         AAB              3cc5 ; [A + B -> B]
         STB+  S          3cc6 ; [Store B to address in S]
         JSR   @F3D1C     3cc7 ; =+83 [Jump to subroutine relative]
         STA+  S,4        3cc9 ; [Store A indexed, displaced, direct]
         JSR   @F3D1C     3ccc ; =+78 [Jump to subroutine relative]
         DCA              3cce ; [Decrement A]
         LDB=  X'000C'    3ccf ; =0x000c =12 [Load B with immediate]
         SAB              3cd2 ; [A - B -> B]
         BL    @D3D4F     3cd3 ; =+122 [Branch on link]
         LDX=  @W3D55     3cd5 ; =0x3d55 =15701 [Load X with immediate]
         ADD   A,X        3cd8 ; [A + X -> X]
         CLA              3cda ; [Clear A]
         LDAB+ X          3cdb ; [Load AL from address in X]
         STA+  S,2        3cdc ; [Store A indexed, displaced, direct]
         LDB+  S          3cdf ; [Load B from address in S]
@D3CE0   LDAB- X-         3ce0 ; [Load AL indexed, pre-decremented, direct]
         BZ    @D3CE7     3ce2 ; =+3 [Branch if zero]
         AAB              3ce4 ; [A + B -> B]
         JMP   @D3CE0     3ce5 ; =-7 [Jump relative]
@D3CE7   STB+  S          3ce7 ; [Store B to address in S]
         LDA+  S,4        3ce8 ; [Load A indexed, displaced, direct]
         DCA              3ceb ; [Decrement A]
         LDB+  S,2        3cec ; [Load B indexed, displaced, direct]
         SAB              3cef ; [A - B -> B]
         BL    @D3D4F     3cf0 ; =+93 [Branch on link]
         INA              3cf2 ; [Increment A]
         LDB+  S+         3cf3 ; [Pop B from the stack]
         ADD   B,A        3cf5 ; [B + A -> A]
         LDBB= X'00'      3cf7 ; =0 =NUL [Load BL with immediate]
@D3CF9   STA-  S-         3cf9 ; [Push A to the stack]
         LDA/  X'005A'    3cfb ; =0x005a =90 [Load A direct]
         LDA+  A,3        3cfe ; [Load A indexed, displaced, direct]
         LDA+  A,25       3d01 ; [Load A indexed, displaced, direct]
         BZ    @D3D09     3d04 ; =+3 [Branch if zero]
         STBB+ A,6        3d06 ; [Store BL indexed, displaced, direct]
@D3D09   LDA+  S+         3d09 ; [Pop A from the stack]
         LDB/  @W3C8C+1   3d0b ; =0x3c8d =15501 [Load B direct]
         XFR   B,S        3d0e ; [Transfer B to S]
         LDX+  S+         3d10 ; [Pop X from the stack]
         LDB+  S+         3d12 ; [Pop B from the stack]
         XFR   B,Y        3d14 ; [Transfer B to Y]
         JSR$  X'005A'    3d16 ; =0x005a =90 [Jump to OPSYS (SVC)]
         DB    X'01'      3d19 ; =0x01 =1 [Service call TRTN - transient return]
         DB    X'FF'      3d1a ; =0xff =255(-1) [return code]
         DB    X'FF'      3d1b ; =0xff =255(-1)
*
* Function @F3D1C
*
@F3D1C   STX   @W3D3D+1   3d1c ; =+32 [Store X relative]
         LDX+  S+         3d1e ; [Pop X from the stack]
@D3D20   DCX              3d20 ; [Decrement X]
         BZ    @D3D4F     3d21 ; =+44 [Branch if zero]
         LDAB- Y-         3d23 ; [Load AL indexed, pre-decremented, direct]
         JSR   @F3D40     3d25 ; =+25 [Jump to subroutine relative]
         BZ    @D3D20     3d27 ; =-9 [Branch if zero]
         STA-  S-         3d29 ; [Push A to the stack]
         LDAB- Y-         3d2b ; [Load AL indexed, pre-decremented, direct]
         DCX              3d2d ; [Decrement X]
         BNZ   @D3D32     3d2e ; =+2 [Branch if not zero]
         LDAB= X'B0'      3d30 ; =176(-80) ='0' [Load AL with immediate]
@D3D32   JSR   @F3D40     3d32 ; =+12 [Jump to subroutine relative]
         SLA              3d34 ; [Left shift A]
         XAB              3d35 ; [Transfer A to B]
         SLA              3d36 ; [Left shift A]
         SLA              3d37 ; [Left shift A]
         AAB              3d38 ; [A + B -> B]
         LDA+  S+         3d39 ; [Pop A from the stack]
         ADD   B,A        3d3b ; [B + A -> A]
@W3D3D   JMP/  X'0000'    3d3d ; =0x0000 =0 =NUL,NUL [Jump direct]
*
* Function @F3D40
*
@F3D40   LDBB= X'50'      3d40 ; =80 [Load BL with immediate]
         ADDB  BL,AL      3d42 ; [BL + AL -> AL]
         BM    @D3D4D     3d44 ; =+7 [Branch on minus]
         CLRB  AU         3d46 ; [Clear AU]
         LDBB= X'0A'      3d48 ; =10 [Load BL with immediate]
         SABB             3d4a ; [AL - BL -> BL]
         BM    @D3D4E     3d4b ; =+1 [Branch on minus]
@D3D4D   CLA              3d4d ; [Clear A]
@D3D4E   RSR              3d4e ; [Return from subroutine]
*
@D3D4F   LDBB= X'02'      3d4f ; =2 [Load BL with immediate]
         CLA              3d51 ; [Clear A]
         JMP   @D3CF9     3d52 ; =-91 [Jump relative]
*
         DB    X'00'      3d54 ; =0x00 =0 =NUL
@W3D55   DB    X'1F'      3d55 ; =0x1f =31
@B3D56   DW    X'1C1F'    3d56 ; =0x1c1f =7199
         DW    X'1E1F'    3d58 ; =0x1e1f =7711
         DW    X'1E1F'    3d5a ; =0x1e1f =7711
         DW    X'1F1E'    3d5c ; =0x1f1e =7966
         DW    X'1F1E'    3d5e ; =0x1f1e =7966
         DB    X'1F'      3d60 ; =0x1f =31
*
*
* Function UCSTR (OSLIB/P.OSLIB5/P.OSLIB6/OSNLB4/OSNLB5)
*
* Converts a string to uppercase.
* Additional identical copies in OSNLB4 and OSNLB5.
*
* ASM:
*   Clobbers: A, BL
*     JSR/ UCSTR
*     DW STRADDR ; address of length-prefixed string (length is a word)
*
UCSTR    LDA+  X+         3d61 ; [Load A indexed, direct, post-incremented]
         STX-  S-         3d63 ; [Push X to the stack]
         XFR   Y,X        3d65 ; [Transfer Y to X]
         STX-  S-         3d67 ; [Push X to the stack]
         LDX+  A+         3d69 ; [Load X indexed, direct, post-incremented]
         XAY              3d6b ; [Transfer A to Y]
@D3D6C   DCX              3d6c ; [Decrement X]
         BM    @D3D82     3d6d ; =+19 [Branch on minus]
         LDAB+ Y          3d6f ; [Load AL from address in Y]
         LDBB= X'FA'      3d70 ; =250(-6) ='z' [Load BL with immediate]
         SABB             3d72 ; [AL - BL -> BL]
         BGZ   @D3D7E     3d73 ; =+9 [Branch if greater than zero]
         LDBB= X'E1'      3d75 ; =225(-31) ='a' [Load BL with immediate]
         SABB             3d77 ; [AL - BL -> BL]
         BM    @D3D7E     3d78 ; =+4 [Branch on minus]
         LDAB= X'C1'      3d7a ; =193(-63) ='A' [Load AL with immediate]
         ADDB  BL,AL      3d7c ; [BL + AL -> AL]
@D3D7E   STAB+ Y+         3d7e ; [Store AL indexed, direct, post-incremented]
         JMP   @D3D6C     3d80 ; =-22 [Jump relative]
@D3D82   LDA+  S+         3d82 ; [Pop A from the stack]
         XAY              3d84 ; [Transfer A to Y]
         LDX+  S+         3d85 ; [Pop X from the stack]
         RSR              3d87 ; [Return from subroutine]
*
HICORE   END ENTRY
