* Label naming:
* ENTRY = Main entry point
* ENTnn = Additional entry point
* B = Byte
* D = Displaced branch/jump target
* F = Function JSR target
* I = 32-bit integer
* J = Jump target
* L = Label (generic)
* N = Bignum
* P = Pointer
* S = String
* W = Word
*
8000:      DS    100        ; =0x0064 [Uninitialized memory]
*
* Function ENTRY
*
8064:ENTRY XFR=  ENTRY,S    ; =0x8064 =32868(-32668) [Transfer immediate to S]
8068:      JSR/  F8284      ; =0x8284 =33412(-32124) [Jump to subroutine direct]
806b:J806B LDB=  W8503      ; =0x8503 =34051(-31485) [Load B with immediate]
806e:      SVC   X'5C'      ; =92 [Service call GBKV - get OS block value]
8070:      DB    X'01'      ; =0x01 =1 [TODO: arg1]
8071:      DB    X'01'      ; =0x01 =1 [TODO: arg2]
8072:      DB    X'01'      ; =0x01 =1 [TODO: arg3]
8073:      DW    W8542      ; =0x8542 =34114(-31422) [address to store block value]
8075:      LDB=  L84E5      ; =0x84e5 =34021(-31515) =EOT,'e' [Load B with immediate]
8078:      SVC   X'52'      ; =82 [Service call GIOB - unprotected GIOB]
807a:      DB    X'01'      ; =0x01 =1 [TODO: arg1]
807b:      DB    X'02'      ; =0x02 =2 [TODO: arg2]
807c:      DB    X'02'      ; =0x02 =2 [TODO: arg3]
807d:      DW    L8548      ; =0x8548 =34120(-31416) [TODO: address]
807f:      LDB=  L84E5      ; =0x84e5 =34021(-31515) =EOT,'e' [Load B with immediate]
8082:      SVC   X'52'      ; =82 [Service call GIOB - unprotected GIOB]
8084:      DB    X'01'      ; =0x01 =1 [TODO: arg1]
8085:      DB    X'15'      ; =0x15 =21 [TODO: arg2]
8086:      DB    X'09'      ; =0x09 =9 [TODO: arg3]
8087:      DW    S8466      ; =0x8466 =33894(-31642) [TODO: address]
8089:      MVF   (21)/S8466,/S8407 ; =0x8466 =33894(-31642),=0x8407 =33799(-31737) [Move fixed-length, direct, direct]
8090:      SVC   X'1C'      ; =28 [Service call GC - get character time]
8092:      DW    S8442      ; =0x8442 =33858(-31678) [address to put time]
8094:      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
8096:      STAB/ S844A      ; =0x844a =33866(-31670) [Store AL direct]
8099:      SVC   X'0B'      ; =11 [Service call DT - get binary date]
809b:      SVC   X'05'      ; =5 [Service call TS - load transient module]
809d:      DB    X'04'      ; =0x04 =4 [Selector: string date from date in A]
809e:      DW    S8436      ; =0x8436 =33846(-31690) [address of string date]
80a0:      LDB=  W8503      ; =0x8503 =34051(-31485) [Load B with immediate]
80a3:      LDAB= X'09'      ; =9 [Load AL with immediate]
80a5:      STAB+ B,3        ; [Store AL indexed, displaced, direct]
80a8:      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
80aa:      LDAB= X'02'      ; =2 [Load AL with immediate]
80ac:      STAB/ B8506      ; =0x8506 =34054(-31482) [Store AL direct]
80af:      LDAB/ W8542      ; =0x8542 =34114(-31422) [Load AL direct]
80b2:      DCRB  AL,2       ; [Decrement AL by 2]
80b4:      BZ    D80B9      ; =+3 [Branch if zero]
80b6:      JMP/  J81C1      ; =0x81c1 =33217(-32319) [Jump direct]
80b9:D80B9 JSR/  F832B      ; =0x832b =33579(-31957) [Jump to subroutine direct]
80bc:N80BC DB    0,3        ; =0x00,0x0003
80bf:      JSR/  F8166      ; =0x8166 =33126(-32410) [Jump to subroutine direct]
80c2:D80C2 JSR/  F82DA      ; =0x82da =33498(-32038) [Jump to subroutine direct]
80c5:      DW    W838D      ; =0x838d =33677(-31859)
80c7:      JSR/  F82F2      ; =0x82f2 =33522(-32014) [Jump to subroutine direct]
80ca:      JSR/  F8811      ; =0x8811 =34833(-30703) [Jump to subroutine direct]
80cd:      DW    W8559      ; =0x8559 =34137(-31399)
80cf:      LDAB/ S855B      ; =0x855b =34139(-31397) [Load AL direct]
80d2:      LDBB= X'C6'      ; =198(-58) ='F' [Load BL with immediate]
80d4:      SABB             ; [AL - BL -> BL]
80d5:      BZ    D811F      ; =+72 [Branch if zero]
80d7:      LDBB= X'D1'      ; =209(-47) ='Q' [Load BL with immediate]
80d9:      SABB             ; [AL - BL -> BL]
80da:      BZ    D812B      ; =+79 [Branch if zero]
80dc:      LDBB= X'CE'      ; =206(-50) ='N' [Load BL with immediate]
80de:      SABB             ; [AL - BL -> BL]
80df:      BZ    D814E      ; =+109 [Branch if zero]
80e1:      LDBB= X'D0'      ; =208(-48) ='P' [Load BL with immediate]
80e3:      SABB             ; [AL - BL -> BL]
80e4:      BZ    D8156      ; =+112 [Branch if zero]
80e6:      LDA/  W8559      ; =0x8559 =34137(-31399) [Load A direct]
80e9:      BZ    D80F4      ; =+9 [Branch if zero]
80eb:      CTB   /S855B(10),/N80BC(3) ; =0x855b =34139(-31397),=0x80bc =32956(-32580) [Convert to bignum, direct, direct]
80f2:      BNF   D8105      ; =+17 [Branch on no fault]
80f4:D80F4 JSR/  F82DA      ; =0x82da =33498(-32038) [Jump to subroutine direct]
80f7:      DW    W867A      ; =0x867a =34426(-31110)
*
80f9:      JSR/  F82DA      ; =0x82da =33498(-32038) [Jump to subroutine direct]
80fc:      DW    W83BC      ; =0x83bc =33724(-31812)
*
80fe:      JSR/  F82DA      ; =0x82da =33498(-32038) [Jump to subroutine direct]
8101:      DW    W867A      ; =0x867a =34426(-31110)
8103:      JMP   D80C2      ; =-67 [Jump relative]
8105:D8105 C     /N80BC(3),/N8547(3) ; =0x80bc =32956(-32580),=0x8547 =34119(-31417) [Compare bignums, direct, direct]
810c:      BP    D80B9      ; =-85 [Branch on plus]
810e:D810E JSR/  F82DA      ; =0x82da =33498(-32038) [Jump to subroutine direct]
8111:      DW    W867A      ; =0x867a =34426(-31110)
*
8113:      JSR/  F82DA      ; =0x82da =33498(-32038) [Jump to subroutine direct]
8116:      DW    W83CD      ; =0x83cd =33741(-31795)
*
8118:      JSR/  F82DA      ; =0x82da =33498(-32038) [Jump to subroutine direct]
811b:      DW    W867A      ; =0x867a =34426(-31110)
811d:      JMP   D80C2      ; =-93 [Jump relative]
811f:D811F ZAD   =0,/N80BC(3) ; =0x80bc =32956(-32580) [Zero-add bignum, literal=0x00, direct]
8125:      JSR/  F8284      ; =0x8284 =33412(-32124) [Jump to subroutine direct]
8128:      JMP/  J806B      ; =0x806b =32875(-32661) [Jump direct]
812b:D812B LDAB/ W8542      ; =0x8542 =34114(-31422) [Load AL direct]
812e:      DCRB  AL,4       ; [Decrement AL by 4]
8130:      BNZ   D8137      ; =+5 [Branch if not zero]
8132:      JSR/  F8312      ; =0x8312 =33554(-31982) [Jump to subroutine direct]
8135:      DW    W8555      ; =0x8555 =34133(-31403)
*
8137:D8137 LDA/  W8540      ; =0x8540 =34112(-31424) [Load A direct]
813a:      BNZ   D8146      ; =+10 [Branch if not zero]
813c:      LDAB= X'0A'      ; =10 [Load AL with immediate]
813e:      STAB/ B8506      ; =0x8506 =34054(-31482) [Store AL direct]
8141:      LDB=  W8503      ; =0x8503 =34051(-31485) [Load B with immediate]
8144:      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
8146:D8146 JSR/  F82DA      ; =0x82da =33498(-32038) [Jump to subroutine direct]
8149:      DW    W83E6      ; =0x83e6 =33766(-31770)
814b:      SVC   X'0A'      ; =10 [Service call EXIT - exit to OJX00]
814d:      DB    X'FF'      ; =0xff =255(-1) [completion code]
*
814e:D814E A     =1,/N80BC(3) ; =0x80bc =32956(-32580) [Add bignums, literal=0x01, direct]
8154:      JMP   D8105      ; =-81 [Jump relative]
8156:D8156 S     =1,/N80BC(3) ; =0x80bc =32956(-32580) [Subtract bignums, literal=0x01, direct]
815c:      BP    D8105      ; =-89 [Branch on plus]
815e:      ZAD   =0,/N80BC(3) ; =0x80bc =32956(-32580) [Zero-add bignum, literal=0x00, direct]
8164:      JMP   D810E      ; =-88 [Jump relative]
*
* Function F8166
*
8166:F8166 STK   X,6        ; [Push X Y Z to the stack]
8168:      MVF   (5)/S8550,/W842D ; =0x8550 =34128(-31408),=0x842d =33837(-31699) [Move fixed-length, direct, direct]
816f:      LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
8171:      CLR   A,5        ; [Set A to 5]
8173:      CFB   /W842D(10),/N80BC(3) ; =0x842d =33837(-31699),=0x80bc =32956(-32580) [Convert from bignum, direct, direct]
817a:      JSR/  F8312      ; =0x8312 =33554(-31982) [Jump to subroutine direct]
817d:      DW    W8677      ; =0x8677 =34423(-31113)
*
817f:      JSR/  F8312      ; =0x8312 =33554(-31982) [Jump to subroutine direct]
8182:      DW    W83F7      ; =0x83f7 =33783(-31753)
*
8184:      JSR/  F8312      ; =0x8312 =33554(-31982) [Jump to subroutine direct]
8187:      DW    W867A      ; =0x867a =34426(-31110)
8189:      LDX=  W8680      ; =0x8680 =34432(-31104) [Load X with immediate]
818c:      LDA=  X'0013'    ; =0x0013 =19 [Load A with immediate]
818f:      STA/  W854A      ; =0x854a =34122(-31414) [Store A direct]
8192:D8192 XFR=  S85AD,Y    ; =0x85ad =34221(-31315) [Transfer immediate to Y]
8196:      XFR=  S85E9,Z    ; =0x85e9 =34281(-31255) [Transfer immediate to Z]
819a:      LDA=  X'0013'    ; =0x0013 =19 [Load A with immediate]
819d:      STA/  W854C      ; =0x854c =34124(-31412) [Store A direct]
81a0:D81A0 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
81a2:      JSR/  F833E      ; =0x833e =33598(-31938) [Jump to subroutine direct]
81a5:      JSR/  F8355      ; =0x8355 =33621(-31915) [Jump to subroutine direct]
81a8:      DEC/  W854C      ; =0x854c =34124(-31412) [Decrement word at address by 1]
81ac:      BP    D81A0      ; =-14 [Branch on plus]
81ae:      JSR/  F8312      ; =0x8312 =33554(-31982) [Jump to subroutine direct]
81b1:      DW    W85AB      ; =0x85ab =34219(-31317)
81b3:      DEC/  W854A      ; =0x854a =34122(-31414) [Decrement word at address by 1]
81b7:      BP    D8192      ; =-39 [Branch on plus]
81b9:      JSR/  F8312      ; =0x8312 =33554(-31982) [Jump to subroutine direct]
81bc:      DW    W867A      ; =0x867a =34426(-31110)
81be:      POP   X,6        ; [Pop Z Y X from the stack]
81c0:      RSR              ; [Return from subroutine]
*
81c1:J81C1 JSR/  F832B      ; =0x832b =33579(-31957) [Jump to subroutine direct]
81c4:N81C4 DB    0,3        ; =0x00,0x0003
81c7:      JSR/  F8205      ; =0x8205 =33285(-32251) [Jump to subroutine direct]
81ca:      A     =1,/N81C4(3) ; =0x81c4 =33220(-32316) [Add bignums, literal=0x01, direct]
81d0:      C     /N81C4(3),/N8547(3) ; =0x81c4 =33220(-32316),=0x8547 =34119(-31417) [Compare bignums, direct, direct]
81d7:      BP    J81C1      ; =-24 [Branch on plus]
81d9:      LDAB/ W8542      ; =0x8542 =34114(-31422) [Load AL direct]
81dc:      DCRB  AL,4       ; [Decrement AL by 4]
81de:      BNZ   D81E5      ; =+5 [Branch if not zero]
81e0:      JSR/  F8312      ; =0x8312 =33554(-31982) [Jump to subroutine direct]
81e3:      DW    W8555      ; =0x8555 =34133(-31403)
*
81e5:D81E5 LDAB= X'0A'      ; =10 [Load AL with immediate]
81e7:      STAB/ B8506      ; =0x8506 =34054(-31482) [Store AL direct]
81ea:      LDB=  W8503      ; =0x8503 =34051(-31485) [Load B with immediate]
81ed:      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
81ef:      JSR/  F8284      ; =0x8284 =33412(-32124) [Jump to subroutine direct]
81f2:      ZAD   =0,/N81C4(3) ; =0x81c4 =33220(-32316) [Zero-add bignum, literal=0x00, direct]
81f8:      LDB=  W8503      ; =0x8503 =34051(-31485) [Load B with immediate]
81fb:      LDAB= X'09'      ; =9 [Load AL with immediate]
81fd:      STAB+ B,3        ; [Store AL indexed, displaced, direct]
8200:      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
8202:      JMP/  J806B      ; =0x806b =32875(-32661) [Jump direct]
*
* Function F8205
*
8205:F8205 STK   X,6        ; [Push X Y Z to the stack]
8207:      DEC/  W854E      ; =0x854e =34126(-31410) [Decrement word at address by 1]
820b:      BNZ   D822B      ; =+30 [Branch if not zero]
820d:      JSR/  F8312      ; =0x8312 =33554(-31982) [Jump to subroutine direct]
8210:      DW    W8677      ; =0x8677 =34423(-31113)
8212:      LDX=  X'0005'    ; =0x0005 =5 [Load X with immediate]
8215:D8215 JSR/  F8312      ; =0x8312 =33554(-31982) [Jump to subroutine direct]
8218:      DW    W867A      ; =0x867a =34426(-31110)
821a:      DCX              ; [Decrement X]
821b:      BNZ   D8215      ; =-8 [Branch if not zero]
821d:      JSR/  F8312      ; =0x8312 =33554(-31982) [Jump to subroutine direct]
8220:      DW    W8434      ; =0x8434 =33844(-31692)
*
8222:      JSR/  F8312      ; =0x8312 =33554(-31982) [Jump to subroutine direct]
8225:      DW    W867A      ; =0x867a =34426(-31110)
8227:      CAD/  W854E,2    ; [Set word at address to 2]
822b:D822B MVF   (5)/S8550,/W84B3 ; =0x8550 =34128(-31408),=0x84b3 =33971(-31565) =EOT,'3' [Move fixed-length, direct, direct]
8232:      LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
8234:      CLR   A,5        ; [Set A to 5]
8236:      CFB   /W84B3(10),/N81C4(3) ; =0x84b3 =33971(-31565) =EOT,'3',=0x81c4 =33220(-32316) [Convert from bignum, direct, direct]
823d:      JSR/  F8312      ; =0x8312 =33554(-31982) [Jump to subroutine direct]
8240:      DW    W847D      ; =0x847d =33917(-31619)
*
8242:      JSR/  F8312      ; =0x8312 =33554(-31982) [Jump to subroutine direct]
8245:      DW    W867A      ; =0x867a =34426(-31110)
8247:      LDX=  W8680      ; =0x8680 =34432(-31104) [Load X with immediate]
824a:      LDA=  X'0013'    ; =0x0013 =19 [Load A with immediate]
824d:      STA/  W854A      ; =0x854a =34122(-31414) [Store A direct]
8250:D8250 XFR=  S85FF,Y    ; =0x85ff =34303(-31233) [Transfer immediate to Y]
8254:      XFR=  S8650,Z    ; =0x8650 =34384(-31152) [Transfer immediate to Z]
8258:      LDA=  X'0013'    ; =0x0013 =19 [Load A with immediate]
825b:      STA/  W854C      ; =0x854c =34124(-31412) [Store A direct]
825e:D825E LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
8260:      JSR/  F833E      ; =0x833e =33598(-31938) [Jump to subroutine direct]
8263:      JSR/  F8355      ; =0x8355 =33621(-31915) [Jump to subroutine direct]
8266:      DEC/  W854C      ; =0x854c =34124(-31412) [Decrement word at address by 1]
826a:      BP    D825E      ; =-14 [Branch on plus]
826c:      JSR/  F8312      ; =0x8312 =33554(-31982) [Jump to subroutine direct]
826f:      DW    W85FD      ; =0x85fd =34301(-31235)
8271:      DEC/  W854A      ; =0x854a =34122(-31414) [Decrement word at address by 1]
8275:      BP    D8250      ; =-39 [Branch on plus]
8277:      JSR/  F8312      ; =0x8312 =33554(-31982) [Jump to subroutine direct]
827a:      DW    W867A      ; =0x867a =34426(-31110)
*
827c:      JSR/  F8312      ; =0x8312 =33554(-31982) [Jump to subroutine direct]
827f:      DW    W867A      ; =0x867a =34426(-31110)
8281:      POP   X,6        ; [Pop Z Y X from the stack]
8283:      RSR              ; [Return from subroutine]
*
* Function F8284
*
8284:F8284 JSR/  F82DA      ; =0x82da =33498(-32038) [Jump to subroutine direct]
8287:      DW    W84E2      ; =0x84e2 =34018(-31518) =EOT,'b'
*
8289:      JSR/  F82DA      ; =0x82da =33498(-32038) [Jump to subroutine direct]
828c:      DW    W836B      ; =0x836b =33643(-31893)
*
828e:      JSR/  F82DA      ; =0x82da =33498(-32038) [Jump to subroutine direct]
8291:      DW    W867A      ; =0x867a =34426(-31110)
*
8293:      JSR/  F82DA      ; =0x82da =33498(-32038) [Jump to subroutine direct]
8296:      DW    W84BA      ; =0x84ba =33978(-31558) =EOT,':'
*
8298:      JSR/  F82F2      ; =0x82f2 =33522(-32014) [Jump to subroutine direct]
829b:      LDA/  W8559      ; =0x8559 =34137(-31399) [Load A direct]
829e:      BNZ   D82A3      ; =+3 [Branch if not zero]
82a0:      JMP/  D812B      ; =0x812b =33067(-32469) [Jump direct]
82a3:D82A3 JSR/  F8811      ; =0x8811 =34833(-30703) [Jump to subroutine direct]
82a6:      DW    W8559      ; =0x8559 =34137(-31399)
82a8:      LDA/  W8559      ; =0x8559 =34137(-31399) [Load A direct]
82ab:      MVFR  /S855B,/S852B ; =0x855b =34139(-31397),=0x852b =34091(-31445) [Move fixed-length (len in AL), direct, direct]
82b1:D82B1 JSR/  F82DA      ; =0x82da =33498(-32038) [Jump to subroutine direct]
82b4:      DW    W84CD      ; =0x84cd =33997(-31539) =EOT,'M'
82b6:      JSR/  F82F2      ; =0x82f2 =33522(-32014) [Jump to subroutine direct]
82b9:      LDA/  W8559      ; =0x8559 =34137(-31399) [Load A direct]
82bc:      BNZ   D82C1      ; =+3 [Branch if not zero]
82be:      JMP/  D812B      ; =0x812b =33067(-32469) [Jump direct]
82c1:D82C1 LDA/  W8559      ; =0x8559 =34137(-31399) [Load A direct]
82c4:      CTB   /S855B(10),/N82D4(1) ; =0x855b =34139(-31397),=0x82d4 =33492(-32044) [Convert to bignum, direct, direct]
82cb:      BF    D82B1      ; =-28 [Branch on fault]
82cd:      SVC   X'05'      ; =5 [Service call TS - load transient module]
82cf:      DB    X'0E'      ; =0x0e =14 [Selector: open file by name/disk]
82d0:      DW    S852B      ; =0x852b =34091(-31445) [address of filename]
82d2:      DW    L84E5      ; =0x84e5 =34021(-31515) =EOT,'e' [address of FCB]
82d4:N82D4 DB    X'00'      ; =0x00 =0 =NUL [disk number]
82d5:      DB    X'02'      ; =0x02 =2 [TODO: arg 5]
82d6:      XAB              ; [Transfer A to B]
82d7:      BNZ   F8284      ; =-85 [Branch if not zero]
82d9:      RSR              ; [Return from subroutine]
*
* Function F82DA
*
82da:F82DA CLR   A,2        ; [Set A to 2]
82dc:      STAB/ B8524      ; =0x8524 =34084(-31452) [Store AL direct]
82df:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
82e1:      STA/  S8527      ; =0x8527 =34087(-31449) [Store A direct]
82e4:      LDA+  A          ; [Load A from address in A]
82e5:      STA/  W8525      ; =0x8525 =34085(-31451) [Store A direct]
82e8:      LDB=  W8521      ; =0x8521 =34081(-31455) [Load B with immediate]
82eb:      SVC   X'10'      ; =16 [Service call SYSIO - device-independent logical I/O [all units]]
82ed:      SVC   X'08'      ; =8 [Service call RBWT - wait for RCB to go ready]
82ef:      DW    W8521      ; =0x8521 =34081(-31455) [TODO: arg 1]
82f1:      RSR              ; [Return from subroutine]
*
* Function F82F2
*
82f2:F82F2 CLR   A,1        ; [Set A to 1]
82f4:      STAB/ B8524      ; =0x8524 =34084(-31452) [Store AL direct]
82f7:      LDA=  X'0050'    ; =0x0050 =80 [Load A with immediate]
82fa:      STA/  W8525      ; =0x8525 =34085(-31451) [Store A direct]
82fd:      LDA=  W8559      ; =0x8559 =34137(-31399) [Load A with immediate]
8300:      STA/  S8527      ; =0x8527 =34087(-31449) [Store A direct]
8303:      LDB=  W8521      ; =0x8521 =34081(-31455) [Load B with immediate]
8306:      SVC   X'10'      ; =16 [Service call SYSIO - device-independent logical I/O [all units]]
8308:D8308 LDAB/ W8521      ; =0x8521 =34081(-31455) [Load AL direct]
830b:      BP    D8311      ; =+4 [Branch on plus]
830d:      SVC   X'07'      ; =7 [Service call WT - unconditional wait]
830f:      JMP   D8308      ; =-9 [Jump relative]
8311:D8311 RSR              ; [Return from subroutine]
*
* Function F8312
*
8312:F8312 LDA+  X+         ; [Load A indexed, direct, post-incremented]
8314:      STA/  W8513      ; =0x8513 =34067(-31469) [Store A direct]
8317:      LDA+  A          ; [Load A from address in A]
8318:      STA/  W8511      ; =0x8511 =34065(-31471) [Store A direct]
831b:      LDB=  W8503      ; =0x8503 =34051(-31485) [Load B with immediate]
831e:      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
8320:      LDAB/ W8503      ; =0x8503 =34051(-31485) [Load AL direct]
8323:      BNZ   D8326      ; =+1 [Branch if not zero]
8325:      RSR              ; [Return from subroutine]
*
8326:D8326 LDBB= X'32'      ; =50 [Load BL with immediate]
8328:      AABB             ; [AL + BL -> BL]
8329:      SVC   X'6B'      ; =107 [Service call ABRTR - abort with abort code in AL]
*
* Function F832B
*
832b:F832B MVF   (3)-X,/S8544 ; =0x8544 =34116(-31420) [Move fixed-length, indexed, direct]
8331:      INR   X,3        ; [Increment X by 3]
8333:      LDB=  L84E5      ; =0x84e5 =34021(-31515) =EOT,'e' [Load B with immediate]
8336:      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
8338:      LDAB/ L84E5      ; =0x84e5 =34021(-31515) =EOT,'e' [Load AL direct]
833b:      BNZ   D8326      ; =-23 [Branch if not zero]
833d:      RSR              ; [Return from subroutine]
*
* Function F833E
*
833e:F833E STAB- S-         ; [Store AL indexed, pre-decremented, direct]
8340:      LDA=  X'C0C0'    ; =0xc0c0 =49344(-16192) ='@','@' [Load A with immediate]
8343:      STA+  Y          ; [Store A to address in Y]
8344:      CLR   A,2        ; [Set A to 2]
8346:      LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
8348:      CFB   -Y(16),-S(1) ; [Convert from bignum, indexed, indexed]
834c:      INR   Y,2        ; [Increment Y by 2]
834e:      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
8350:      STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
8352:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
8354:      RSR              ; [Return from subroutine]
*
* Function F8355
*
8355:F8355 CLRB  AU         ; [Clear AU]
8357:      LDB=  X'00A0'    ; =0x00a0 =160 =NUL,' ' [Load B with immediate]
835a:      SAB              ; [A - B -> B]
835b:      BM    D8364      ; =+7 [Branch on minus]
835d:      INAB             ; [Increment AL]
835e:      BZ    D8364      ; =+4 [Branch if zero]
8360:      DCAB             ; [Decrement AL]
8361:      STAB+ Z+         ; [Store AL indexed, direct, post-incremented]
8363:      RSR              ; [Return from subroutine]
*
8364:D8364 LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
8366:      LDAB= X'DF'      ; =223(-33) =DEL [Load AL with immediate]
8368:      STAB+ Z+         ; [Store AL indexed, direct, post-incremented]
836a:      RSR              ; [Return from subroutine]
*
836b:W836B DW    X'0020'    ; =0x0020 =32
836d:      DC    'ZHEXLST 10/19/82 DISK FILE DUMP'
838c:      DB    X'8D'      ; =0x8d =141(-115) =CR
838d:W838D DW    X'002D'    ; =0x002d =45
838f:      DC    'ENTER F, Q, N, P, OR RELATIVE SECTOR NUMBER /'
83bc:W83BC DW    X'000F'    ; =0x000f =15
83be:      DB    X'87'      ; =0x87 =135(-121) =BEL
83bf:      DC    'INVALID ENTRY'
83cc:      DB    X'8D'      ; =0x8d =141(-115) =CR
83cd:W83CD DW    X'0017'    ; =0x0017 =23
83cf:      DB    X'87'      ; =0x87 =135(-121) =BEL
83d0:      DC    'INVALID SECTOR NUMBER'
83e5:      DB    X'8D'      ; =0x8d =141(-115) =CR
83e6:W83E6 DW    X'000F'    ; =0x000f =15
83e8:      DC    'END OF PROGRAM'
83f6:      DB    X'8D'      ; =0x8d =141(-115) =CR
83f7:W83F7 DW    X'003B'    ; =0x003b =59
83f9:      DC    'DUMP OF FILE: '
8407:S8407 DC    '                       SECTOR NUMBER: '
842d:W842D DS    5          ; =0x0005 [Uninitialized memory]
8432:      DC    ' '        ; hex:a0 dec:160(-96)
8433:      DB    X'8D'      ; =0x8d =141(-115) =CR
8434:W8434 DW    X'0047'    ; =0x0047 =71
8436:S8436 DS    8          ; =0x0008 [Uninitialized memory]
843e:      DC    ' AT '     ; hex:a0c1d4a0
8442:S8442 DS    8          ; =0x0008 [Uninitialized memory]
844a:S844A DC    '          HEX DUMP OF FILE: '
8466:S8466 DC    '                      '
847c:      DB    X'8D'      ; =0x8d =141(-115) =CR
847d:W847D DW    X'003B'    ; =0x003b =59
847f:      DC    '                                     SECTOR NUMBER: '
84b3:W84B3 DS    5          ; =0x0005 [Uninitialized memory]
84b8:      DC    ' '        ; hex:a0 dec:160(-96)
84b9:      DB    X'8D'      ; =0x8d =141(-115) =CR
84ba:W84BA DW    X'0011'    ; =0x0011 =17
84bc:      DC    'ENTER FILE NAME /'
84cd:W84CD DW    X'0013'    ; =0x0013 =19
84cf:      DC    'ENTER DISK NUMBER /'
84e2:W84E2 DW    X'0001'    ; =0x0001 =1
84e4:      DB    X'8C'      ; =0x8c =140(-116) =FF
84e5:L84E5 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
84e7:      DW    X'2101'    ; =0x2101 =8449
84e9:      DW    X'0190'    ; =0x0190 =400
84eb:      DW    W867E      ; =0x867e =34430(-31106)
84ed:      DB    0,3        ; =0x00,0x0003
84f0:      DW    X'0502'    ; =0x0502 =1282
84f2:      DW    X'FF00'    ; =0xff00 =65280(-256)
84f4:      DB    0,11       ; =0x00,0x000b
84ff:      DW    W8543      ; =0x8543 =34115(-31421)
8501:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8503:W8503 DW    X'0083'    ; =0x0083 =131
8505:      DB    X'22'      ; =0x22 =34
8506:B8506 DW    X'0200'    ; =0x0200 =512
8508:      DB    0,7        ; =0x00,0x0007
850f:      DW    X'0102'    ; =0x0102 =258
8511:W8511 DW    X'0078'    ; =0x0078 =120
8513:W8513 DW    W85FD      ; =0x85fd =34301(-31235)
8515:      DB    0,12       ; =0x00,0x000c
8521:W8521 DW    X'0082'    ; =0x0082 =130
8523:      DB    X'23'      ; =0x23 =35
8524:B8524 DB    X'00'      ; =0x00 =0 =NUL
8525:W8525 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8527:S8527 DB    0,4        ; =0x00,0x0004
852b:S852B DB    0,21       ; =0x00,0x0015
8540:W8540 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8542:W8542 DS    1          ; =0x0001 [Uninitialized memory]
8543:W8543 DB    X'00'      ; =0x00 =0 =NUL
8544:S8544 DB    0,3        ; =0x00,0x0003
8547:N8547 DB    X'00'      ; =0x00 =0 =NUL
8548:L8548 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
854a:W854A DS    2          ; =0x0002 [Uninitialized memory]
854c:W854C DS    2          ; =0x0002 [Uninitialized memory]
854e:W854E DW    X'0001'    ; =0x0001 =1
8550:S8550 DC    '@@@@@'    ; hex:c0c0c0c0c0
8555:W8555 DW    X'0002'    ; =0x0002 =2
8557:      DW    X'848D'    ; =0x848d =33933(-31603) =EOT,CR
8559:W8559 DS    2          ; =0x0002 [Uninitialized memory]
855b:S855B DC    '                                                            '
8597:      DC    '                    '
85ab:W85AB DW    X'0050'    ; =0x0050 =80
85ad:S85AD DC    '                                                            '
85e9:S85E9 DC    '                    '
85fd:W85FD DW    X'0078'    ; =0x0078 =120
85ff:S85FF DC    '                                                            '
863b:      DC    '                    ('
8650:S8650 DC    '                    )                 '
8676:      DB    X'8D'      ; =0x8d =141(-115) =CR
8677:W8677 DW    X'0001'    ; =0x0001 =1
8679:      DB    X'8C'      ; =0x8c =140(-116) =FF
867a:W867A DW    X'0002'    ; =0x0002 =2
867c:      DC    ' '        ; hex:a0 dec:160(-96)
867d:      DB    X'8D'      ; =0x8d =141(-115) =CR
867e:W867E DW    X'0191'    ; =0x0191 =401
8680:W8680 DS    400        ; =0x0190 [Uninitialized memory]
8810:      DB    X'00'      ; =0x00 =0 =NUL
*
* Function F8811
*
8811:F8811 LDA+  X+         ; [Load A indexed, direct, post-incremented]
8813:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8815:      XFR   Y,X        ; [Transfer Y to X]
8817:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8819:      LDX+  A+         ; [Load X indexed, direct, post-incremented]
881b:      XAY              ; [Transfer A to Y]
881c:D881C DCX              ; [Decrement X]
881d:      BM    D8832      ; =+19 [Branch on minus]
881f:      LDAB+ Y          ; [Load AL from address in Y]
8820:      LDBB= X'FA'      ; =250(-6) ='z' [Load BL with immediate]
8822:      SABB             ; [AL - BL -> BL]
8823:      BGZ   D882E      ; =+9 [Branch if greater than zero]
8825:      LDBB= X'E1'      ; =225(-31) ='a' [Load BL with immediate]
8827:      SABB             ; [AL - BL -> BL]
8828:      BM    D882E      ; =+4 [Branch on minus]
882a:      LDAB= X'C1'      ; =193(-63) ='A' [Load AL with immediate]
882c:      ADDB  BL,AL      ; [BL + AL -> AL]
882e:D882E STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
8830:      JMP   D881C      ; =-22 [Jump relative]
8832:D8832 LDA+  S+         ; [Load A indexed, direct, post-incremented]
8834:      XAY              ; [Transfer A to Y]
8835:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8837:      RSR              ; [Return from subroutine]
*
8838:ENDPT
