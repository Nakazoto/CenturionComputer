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
9000:      DW    X'036D'    ; =0x036d =877
9002:      DC    'CMD AUX MEMORY TEST'
9015:      DB    X'8D'      ; =0x8d =141(-115) =CR
9016:      DW    X'8A00'    ; =0x8a00 =35328(-30208) =LF,NUL
9018:      DW    X'046D'    ; =0x046d =1133
901a:      DC    'CMD SEEK TEST'
9027:      DB    X'8D'      ; =0x8d =141(-115) =CR
9028:      DW    X'8A00'    ; =0x8a00 =35328(-30208) =LF,NUL
902a:      DW    X'0531'    ; =0x0531 =1329
902c:      DC    'CMD READ TEST'
9039:      DB    X'8D'      ; =0x8d =141(-115) =CR
903a:      DW    X'8A00'    ; =0x8a00 =35328(-30208) =LF,NUL
903c:      DB    X'02'      ; =0x02 =2
903d:      DC    'NFLOPPY COMMAND BUFFER TEST'
9058:      DB    X'8D'      ; =0x8d =141(-115) =CR
9059:      DW    X'8A00'    ; =0x8a00 =35328(-30208) =LF,NUL
905b:      DB    X'05'      ; =0x05 =5
905c:      DC    'hFLOPPY SEEK TEST'
906d:      DB    X'8D'      ; =0x8d =141(-115) =CR
906e:      DW    X'8A00'    ; =0x8a00 =35328(-30208) =LF,NUL
9070:      DW    X'069B'    ; =0x069b =1691
9072:      DC    'FLOPPY READ TEST'
9082:      DB    X'8D'      ; =0x8d =141(-115) =CR
9083:      DW    X'8A00'    ; =0x8a00 =35328(-30208) =LF,NUL
9085:      DW    X'0747'    ; =0x0747 =1863
9087:      DC    'ROM SELF TEST'
9094:      DB    X'8D'      ; =0x8d =141(-115) =CR
9095:      DW    X'8A8A'    ; =0x8a8a =35466(-30070) =LF,LF
9097:      DB    0,3        ; =0x00,0x0003
*
909a:D909A LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
909c:      BNZ   D909F      ; =+1 [Branch if not zero]
909e:      RSR              ; [Return from subroutine]
*
909f:D909F JSR   D90A3      ; =+2 [Jump to subroutine relative]
90a1:      JMP   D909A      ; =-9 [Jump relative]
90a3:D90A3 LDBB/ X'F200'    ; =0xf200 =61952(-3584) ='r',NUL [Load BL direct]
90a6:      SRRB  BL         ; [Arithmetic right shift BL by 1]
90a8:      SRRB  BL         ; [Arithmetic right shift BL by 1]
90aa:      BNL   D90A3      ; =-9 [Branch on no link]
90ac:      STAB/ X'F201'    ; =0xf201 =61953(-3583) [Store AL direct]
90af:      RSR              ; [Return from subroutine]
*
90b0:D90B0 LDAB/ X'F200'    ; =0xf200 =61952(-3584) ='r',NUL [Load AL direct]
90b3:      SRAB             ; [Arithmetic right shift AL]
90b4:      BNL   D90B0      ; =-6 [Branch on no link]
90b6:      LDAB/ X'F201'    ; =0xf201 =61953(-3583) [Load AL direct]
90b9:      RSR              ; [Return from subroutine]
*
90ba:      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
90bc:      XFRB  AU,AL      ; [Transfer AU to AL]
90be:      JSR   F90C5      ; =+5 [Jump to subroutine relative]
90c0:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
90c2:      JSR   F90C5      ; =+1 [Jump to subroutine relative]
90c4:      RSR              ; [Return from subroutine]
*
* Function F90C5
*
90c5:F90C5 STAB- S-         ; [Store AL indexed, pre-decremented, direct]
90c7:      LDBB= X'F0'      ; =240(-16) ='p' [Load BL with immediate]
90c9:      ANDB  BL,AL      ; [BL & AL -> AL]
90cb:      RL               ; [Reset link]
90cc:      RRRB  AL         ; [Right rotate AL by 1]
90ce:      SRAB             ; [Arithmetic right shift AL]
90cf:      SRAB             ; [Arithmetic right shift AL]
90d0:      SRAB             ; [Arithmetic right shift AL]
90d1:      LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
90d3:      ADDB  BL,AL      ; [BL + AL -> AL]
90d5:      LDBB= X'B9'      ; =185(-71) ='9' [Load BL with immediate]
90d7:      SABB             ; [AL - BL -> BL]
90d8:      BLE   D90DE      ; =+4 [Branch if less than or equal to zero]
90da:      LDBB= X'07'      ; =7 [Load BL with immediate]
90dc:      ADDB  BL,AL      ; [BL + AL -> AL]
90de:D90DE JSR   D90A3      ; =-61 [Jump to subroutine relative]
90e0:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
90e2:      LDBB= X'0F'      ; =15 [Load BL with immediate]
90e4:      ANDB  BL,AL      ; [BL & AL -> AL]
90e6:      LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
90e8:      ADDB  BL,AL      ; [BL + AL -> AL]
90ea:      LDBB= X'B9'      ; =185(-71) ='9' [Load BL with immediate]
90ec:      SABB             ; [AL - BL -> BL]
90ed:      BLE   D90F3      ; =+4 [Branch if less than or equal to zero]
90ef:      LDBB= X'07'      ; =7 [Load BL with immediate]
90f1:      ADDB  BL,AL      ; [BL + AL -> AL]
90f3:D90F3 JSR   D90A3      ; =-82 [Jump to subroutine relative]
90f5:      RSR              ; [Return from subroutine]
*
90f6:      STAB/ X'F10A'    ; =0xf10a =61706(-3830) [Store AL direct]
90f9:      LDAB/ X'F200'    ; =0xf200 =61952(-3584) ='r',NUL [Load AL direct]
90fc:      SRAB             ; [Arithmetic right shift AL]
90fd:      BNL   D9156      ; =+87 [Branch on no link]
90ff:      LDAB/ X'F201'    ; =0xf201 =61953(-3583) [Load AL direct]
9102:      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
9104:      ORIB  BL,AL      ; [BL | AL -> AL]
9106:      LDBB= X'83'      ; =131(-125) [Load BL with immediate]
9108:      SABB             ; [AL - BL -> BL]
9109:      BNZ   D9156      ; =+75 [Branch if not zero]
910b:      LDAB/ X'0108'    ; =0x0108 =264 [Load AL direct]
910e:      BZ    D9142      ; =+50 [Branch if zero]
9110:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9113:      DW    X'8D8A'    ; =0x8d8a =36234(-29302) =CR,LF
9115:      DC    '*** FAIL ***'
9121:      DB    X'00'      ; =0x00 =0 =NUL
9122:      STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
9125:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
9128:D9128 JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
912b:      DW    X'8D8A'    ; =0x8d8a =36234(-29302) =CR,LF
912d:      DC    'PRESS SPACE'
9138:      DW    X'878D'    ; =0x878d =34701(-30835) =BEL,CR
913a:      DW    X'8A00'    ; =0x8a00 =35328(-30208) =LF,NUL
913c:      JSR$  X'0102'    ; =0x0102 =258 [Jump to subroutine indirect]
913f:      JMP$  X'0100'    ; =0x0100 =256 [Jump indirect]
9142:D9142 JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9145:      DW    X'8D8A'    ; =0x8d8a =36234(-29302) =CR,LF
9147:      DC    '*** PASS ***'
9153:      DB    X'00'      ; =0x00 =0 =NUL
9154:      JMP   D9128      ; =-46 [Jump relative]
9156:D9156 LDA=  X'C000'    ; =0xc000 =49152(-16384) ='@',NUL [Load A with immediate]
9159:      XAS              ; [Transfer A to S]
915a:      LDA/  X'011A'    ; =0x011a =282 [Load A direct]
915d:      XAZ              ; [Transfer A to Z]
915e:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
9160:      ADD   Z,A        ; [Z + A -> A]
9162:      JMP+  A          ; [Jump indexed, direct]
9164:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9167:      DW    X'8D8A'    ; =0x8d8a =36234(-29302) =CR,LF
9169:      DC    '(CONTROL-C TO EXIT)'
917c:      DB    X'8D'      ; =0x8d =141(-115) =CR
917d:      DW    X'8A00'    ; =0x8a00 =35328(-30208) =LF,NUL
917f:      RSR              ; [Return from subroutine]
*
9180:      CLA              ; [Clear A]
9181:      STA/  X'0108'    ; =0x0108 =264 [Store A direct]
9184:      LDA=  X'01E3'    ; =0x01e3 =483 [Load A with immediate]
9187:      ADD   Z,A        ; [Z + A -> A]
9189:      STA/  X'0118'    ; =0x0118 =280 [Store A direct]
918c:      LDA=  X'00C5'    ; =0x00c5 =197 =NUL,'E' [Load A with immediate]
918f:      ADD   Z,A        ; [Z + A -> A]
9191:      STA/  X'010A'    ; =0x010a =266 [Store A direct]
9194:      LDA=  X'0286'    ; =0x0286 =646 [Load A with immediate]
9197:      ADD   Z,A        ; [Z + A -> A]
9199:      STA/  X'010C'    ; =0x010c =268 [Store A direct]
919c:      LDA=  X'0164'    ; =0x0164 =356 [Load A with immediate]
919f:      ADD   Z,A        ; [Z + A -> A]
91a1:      STA/  X'0106'    ; =0x0106 =262 [Store A direct]
91a4:      LDA=  X'00B0'    ; =0x00b0 =176 =NUL,'0' [Load A with immediate]
91a7:      ADD   Z,A        ; [Z + A -> A]
91a9:      STA/  X'0102'    ; =0x0102 =258 [Store A direct]
91ac:      LDA=  X'009A'    ; =0x009a =154 [Load A with immediate]
91af:      ADD   Z,A        ; [Z + A -> A]
91b1:      STA/  X'0112'    ; =0x0112 =274 [Store A direct]
91b4:      LDA=  X'00BA'    ; =0x00ba =186 =NUL,':' [Load A with immediate]
91b7:      ADD   Z,A        ; [Z + A -> A]
91b9:      STA/  X'0110'    ; =0x0110 =272 [Store A direct]
91bc:      LDA=  X'00F6'    ; =0x00f6 =246 =NUL,'v' [Load A with immediate]
91bf:      ADD   Z,A        ; [Z + A -> A]
91c1:      STA/  X'0104'    ; =0x0104 =260 [Store A direct]
91c4:      LDA=  X'0128'    ; =0x0128 =296 [Load A with immediate]
91c7:      ADD   Z,A        ; [Z + A -> A]
91c9:      STA/  X'010E'    ; =0x010e =270 [Store A direct]
91cc:      XFR   Z,A        ; [Transfer Z to A]
91ce:      STA/  X'011A'    ; =0x011a =282 [Store A direct]
91d1:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
91d3:      STA/  X'0114'    ; =0x0114 =276 [Store A direct]
91d6:      INA              ; [Increment A]
91d7:      STA/  X'0116'    ; =0x0116 =278 [Store A direct]
91da:      XFR   X,A        ; [Transfer X to A]
91dc:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
91de:      STX/  X'0100'    ; =0x0100 =256 [Store X direct]
91e1:      JMP+  A          ; [Jump indexed, direct]
91e3:      JSR$  X'010C'    ; =0x010c =268 [Jump to subroutine indirect]
91e6:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
91e8:      LDX=  X'03E8'    ; =0x03e8 =1000 [Load X with immediate]
91eb:D91EB LDAB$ X'0116'    ; =0x0116 =278 [Load AL indirect]
91ee:      LDBB= X'08'      ; =8 [Load BL with immediate]
91f0:      NABB             ; [AL & BL -> BL]
91f1:      BZ    D921E      ; =+43 [Branch if zero]
91f3:      DLY              ; [Delay 4.55 ms]
91f4:      DCX              ; [Decrement X]
91f5:      BNZ   D91EB      ; =-12 [Branch if not zero]
91f7:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
91fa:      DC    '*** BUSY DID NOT CLEAR ***'
9214:      DB    X'00'      ; =0x00 =0 =NUL
9215:      STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
9218:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
921b:      JMP$  X'010E'    ; =0x010e =270 [Jump indirect]
921e:D921E LDX=  X'03E8'    ; =0x03e8 =1000 [Load X with immediate]
9221:D9221 SRAB             ; [Arithmetic right shift AL]
9222:      BL    D924F      ; =+43 [Branch on link]
9224:      DLY              ; [Delay 4.55 ms]
9225:      DCX              ; [Decrement X]
9226:      BNZ   D9221      ; =-7 [Branch if not zero]
9228:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
922b:      DC    '*** FOUT NEVER CAME ON ***'
9245:      DB    X'00'      ; =0x00 =0 =NUL
9246:      STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
9249:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
924c:      JMP$  X'010E'    ; =0x010e =270 [Jump indirect]
924f:D924F RF               ; [Reset fault]
9250:      LDAB$ X'0114'    ; =0x0114 =276 [Load AL indirect]
9253:      BNZ   D9258      ; =+3 [Branch if not zero]
9255:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
9257:      RSR              ; [Return from subroutine]
*
9258:D9258 STAB- S-         ; [Store AL indexed, pre-decremented, direct]
925a:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
925d:      DC    '*** '     ; hex:aaaaaaa0
9261:      DB    X'00'      ; =0x00 =0 =NUL
9262:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
9264:      JSR$  X'010A'    ; =0x010a =266 [Jump to subroutine indirect]
9267:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
926a:      DC    ' ERROR ***' ; hex:a0c5d2d2cfd2a0aaaaaa
9274:      DB    X'8D'      ; =0x8d =141(-115) =CR
9275:      DW    X'8A00'    ; =0x8a00 =35328(-30208) =LF,NUL
9277:      LDAB= X'01'      ; =1 [Load AL with immediate]
9279:      STAB/ X'0108'    ; =0x0108 =264 [Store AL direct]
927c:      STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
927f:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
9282:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
9284:      SF               ; [Set fault]
9285:      RSR              ; [Return from subroutine]
*
9286:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
9288:      DLY              ; [Delay 4.55 ms]
9289:      LDX=  X'03E8'    ; =0x03e8 =1000 [Load X with immediate]
928c:D928C LDAB$ X'0116'    ; =0x0116 =278 [Load AL indirect]
928f:      SRAB             ; [Arithmetic right shift AL]
9290:      SRAB             ; [Arithmetic right shift AL]
9291:      BNL   D92C0      ; =+45 [Branch on no link]
9293:      DLY              ; [Delay 4.55 ms]
9294:      DCX              ; [Decrement X]
9295:      BNZ   D928C      ; =-11 [Branch if not zero]
9297:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
929a:      DC    '*** FIN DID NOT GO OFF ***'
92b4:      DB    X'8D'      ; =0x8d =141(-115) =CR
92b5:      DW    X'8A00'    ; =0x8a00 =35328(-30208) =LF,NUL
92b7:      STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
92ba:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
92bd:      JMP$  X'010E'    ; =0x010e =270 [Jump indirect]
92c0:D92C0 LDX+  S+         ; [Load X indexed, direct, post-incremented]
92c2:      RSR              ; [Return from subroutine]
*
92c3:      DW    X'9001'    ; =0x9001 =36865(-28671)
92c5:      DW    X'8050'    ; =0x8050 =32848(-32688)
92c7:      DW    X'807D'    ; =0x807d =32893(-32643)
92c9:      DB    X'00'      ; =0x00 =0 =NUL
92ca:      DC    'x'        ; hex:f8 dec:248(-8)
92cb:      DW    X'0873'    ; =0x0873 =2163
92cd:      DB    X'09'      ; =0x09 =9
*
92ce:      LDA=  X'0180'    ; =0x0180 =384 [Load A with immediate]
92d1:      ADD   Z,A        ; [Z + A -> A]
92d3:      JSR+  A          ; [Jump to subroutine indexed, direct]
92d5:      DC    'x'        ; hex:f8 dec:248(-8)
92d6:      DB    X'00'      ; =0x00 =0 =NUL
92d7:      JSR$  X'0106'    ; =0x0106 =262 [Jump to subroutine indirect]
92da:      CLR   Y          ; [Clear Y]
92dc:      LDX=  X'00C8'    ; =0x00c8 =200 =NUL,'H' [Load X with immediate]
92df:      XFR   Y,A        ; [Transfer Y to A]
92e1:      LDB=  X'011C'    ; =0x011c =284 [Load B with immediate]
92e4:D92E4 STAB+ B+         ; [Store AL indexed, direct, post-incremented]
92e6:      INAB             ; [Increment AL]
92e7:      INAB             ; [Increment AL]
92e8:      INAB             ; [Increment AL]
92e9:      DCX              ; [Decrement X]
92ea:      BNZ   D92E4      ; =-8 [Branch if not zero]
92ec:      LDA=  X'FF37'    ; =0xff37 =65335(-201) [Load A with immediate]
92ef:      DMA   SCT,A      ; [Store A register to DMA count register]
92f1:      LDA=  X'011C'    ; =0x011c =284 [Load A with immediate]
92f4:      DMA   SAD,A      ; [Store A register to DMA address register]
92f6:      DMA   SDV,3      ; [Set DMA device]
92f8:      DMA   EAB        ; [Enable DMA]
92fa:      LDAB= X'43'      ; =67 [Load AL with immediate]
92fc:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
92ff:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
9302:      LDX=  X'00E6'    ; =0x00e6 =230 =NUL,'f' [Load X with immediate]
9305:      CLA              ; [Clear A]
9306:      LDB=  X'011C'    ; =0x011c =284 [Load B with immediate]
9309:D9309 STAB+ B+         ; [Store AL indexed, direct, post-incremented]
930b:      DCX              ; [Decrement X]
930c:      BNZ   D9309      ; =-5 [Branch if not zero]
930e:      LDA=  X'FF37'    ; =0xff37 =65335(-201) [Load A with immediate]
9311:      DMA   SCT,A      ; [Store A register to DMA count register]
9313:      LDA=  X'011C'    ; =0x011c =284 [Load A with immediate]
9316:      DMA   SAD,A      ; [Store A register to DMA address register]
9318:      DMA   SDV,3      ; [Set DMA device]
931a:      DMA   EAB        ; [Enable DMA]
931c:      LDAB= X'44'      ; =68 [Load AL with immediate]
931e:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9321:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
9324:      LDX=  X'00C8'    ; =0x00c8 =200 =NUL,'H' [Load X with immediate]
9327:      LDB=  X'011C'    ; =0x011c =284 [Load B with immediate]
932a:      XFR   Y,A        ; [Transfer Y to A]
932c:      XFRB  AL,AU      ; [Transfer AL to AU]
932e:D932E LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
9330:      SUBB  AU,AL      ; [AU - AL -> AL]
9332:      BNZ   D9344      ; =+16 [Branch if not zero]
9334:      INRB  AU         ; [Increment AU by 1]
9336:      INRB  AU         ; [Increment AU by 1]
9338:      INRB  AU         ; [Increment AU by 1]
933a:      DCX              ; [Decrement X]
933b:      BNZ   D932E      ; =-15 [Branch if not zero]
933d:      INRB  YL         ; [Increment YL by 1]
933f:      JSR$  X'0104'    ; =0x0104 =260 [Jump to subroutine indirect]
9342:      DB    X'02'      ; =0x02 =2
9343:      DC    'Z'        ; hex:da dec:218(-38)
*
9344:D9344 JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9347:      DC    '*** COMMAND BUFFER ERROR ***'
9363:      DB    X'00'      ; =0x00 =0 =NUL
9364:      STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
9367:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
936a:      JMP$  X'010E'    ; =0x010e =270 [Jump indirect]
936d:      LDA=  X'0180'    ; =0x0180 =384 [Load A with immediate]
9370:      ADD   Z,A        ; [Z + A -> A]
9372:      JSR+  A          ; [Jump to subroutine indexed, direct]
9374:      DC    'x'        ; hex:f8 dec:248(-8)
9375:      DB    X'08'      ; =0x08 =8
9376:      JSR$  X'0106'    ; =0x0106 =262 [Jump to subroutine indirect]
9379:      CLR   Y          ; [Clear Y]
937b:      LDX=  X'3FFF'    ; =0x3fff =16383 [Load X with immediate]
937e:      XFR   Y,A        ; [Transfer Y to A]
9380:      LDB=  X'011C'    ; =0x011c =284 [Load B with immediate]
9383:D9383 STAB+ B+         ; [Store AL indexed, direct, post-incremented]
9385:      INAB             ; [Increment AL]
9386:      INAB             ; [Increment AL]
9387:      INAB             ; [Increment AL]
9388:      DCX              ; [Decrement X]
9389:      BNZ   D9383      ; =-8 [Branch if not zero]
938b:      LDA=  X'C000'    ; =0xc000 =49152(-16384) ='@',NUL [Load A with immediate]
938e:      DMA   SCT,A      ; [Store A register to DMA count register]
9390:      LDA=  X'011C'    ; =0x011c =284 [Load A with immediate]
9393:      DMA   SAD,A      ; [Store A register to DMA address register]
9395:      DMA   SDV,3      ; [Set DMA device]
9397:      DMA   EAB        ; [Enable DMA]
9399:      LDAB= X'46'      ; =70 [Load AL with immediate]
939b:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
939e:      JSR$  X'010C'    ; =0x010c =268 [Jump to subroutine indirect]
93a1:      CLAB             ; [Clear AL]
93a2:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
93a5:      JSR$  X'010C'    ; =0x010c =268 [Jump to subroutine indirect]
93a8:      CLAB             ; [Clear AL]
93a9:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
93ac:      JSR$  X'010C'    ; =0x010c =268 [Jump to subroutine indirect]
93af:      LDAB= X'3F'      ; =63 [Load AL with immediate]
93b1:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
93b4:      JSR$  X'010C'    ; =0x010c =268 [Jump to subroutine indirect]
93b7:      LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
93b9:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
93bc:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
93bf:      LDX=  X'3FFF'    ; =0x3fff =16383 [Load X with immediate]
93c2:      CLA              ; [Clear A]
93c3:      LDB=  X'011C'    ; =0x011c =284 [Load B with immediate]
93c6:D93C6 STAB+ B+         ; [Store AL indexed, direct, post-incremented]
93c8:      DCX              ; [Decrement X]
93c9:      BNZ   D93C6      ; =-5 [Branch if not zero]
93cb:      LDA=  X'C000'    ; =0xc000 =49152(-16384) ='@',NUL [Load A with immediate]
93ce:      DMA   SCT,A      ; [Store A register to DMA count register]
93d0:      LDA=  X'011C'    ; =0x011c =284 [Load A with immediate]
93d3:      DMA   SAD,A      ; [Store A register to DMA address register]
93d5:      DMA   SDV,3      ; [Set DMA device]
93d7:      DMA   EAB        ; [Enable DMA]
93d9:      LDAB= X'47'      ; =71 [Load AL with immediate]
93db:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
93de:      JSR$  X'010C'    ; =0x010c =268 [Jump to subroutine indirect]
93e1:      CLAB             ; [Clear AL]
93e2:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
93e5:      JSR$  X'010C'    ; =0x010c =268 [Jump to subroutine indirect]
93e8:      CLAB             ; [Clear AL]
93e9:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
93ec:      JSR$  X'010C'    ; =0x010c =268 [Jump to subroutine indirect]
93ef:      LDAB= X'3F'      ; =63 [Load AL with immediate]
93f1:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
93f4:      JSR$  X'010C'    ; =0x010c =268 [Jump to subroutine indirect]
93f7:      LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
93f9:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
93fc:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
93ff:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
9401:      LDX=  X'3FFF'    ; =0x3fff =16383 [Load X with immediate]
9404:      LDB=  X'011C'    ; =0x011c =284 [Load B with immediate]
9407:      XFR   Y,A        ; [Transfer Y to A]
9409:      XFRB  AL,AU      ; [Transfer AL to AU]
940b:D940B LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
940d:      STA+  S          ; [Store A to address in S]
940e:      SUBB  AU,AL      ; [AU - AL -> AL]
9410:      BNZ   D9424      ; =+18 [Branch if not zero]
9412:      INRB  AU         ; [Increment AU by 1]
9414:      INRB  AU         ; [Increment AU by 1]
9416:      INRB  AU         ; [Increment AU by 1]
9418:      DCX              ; [Decrement X]
9419:      BNZ   D940B      ; =-16 [Branch if not zero]
941b:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
941d:      INRB  YL         ; [Increment YL by 1]
941f:      JSR$  X'0104'    ; =0x0104 =260 [Jump to subroutine indirect]
9422:      DW    X'0379'    ; =0x0379 =889
*
9424:D9424 STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
9427:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
942a:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
942c:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
942f:      DC    '*** ERROR, ADDR='
943f:      DB    X'00'      ; =0x00 =0 =NUL
9440:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
9442:      DCA              ; [Decrement A]
9443:      JSR$  X'0110'    ; =0x0110 =272 [Jump to subroutine indirect]
9446:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9449:      DC    ' EXP='    ; hex:a0c5d8d0bd
944e:      DB    X'00'      ; =0x00 =0 =NUL
944f:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
9451:      JSR$  X'010A'    ; =0x010a =266 [Jump to subroutine indirect]
9454:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9457:      DC    ' ACT='    ; hex:a0c1c3d4bd
945c:      DB    X'00'      ; =0x00 =0 =NUL
945d:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
945f:      JSR$  X'010A'    ; =0x010a =266 [Jump to subroutine indirect]
9462:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9465:      DC    ' ***'     ; hex:a0aaaaaa
9469:      DB    X'00'      ; =0x00 =0 =NUL
946a:      JMP$  X'010E'    ; =0x010e =270 [Jump indirect]
946d:      LDA=  X'0180'    ; =0x0180 =384 [Load A with immediate]
9470:      ADD   Z,A        ; [Z + A -> A]
9472:      JSR+  A          ; [Jump to subroutine indexed, direct]
9474:      DC    'x'        ; hex:f8 dec:248(-8)
9475:      DB    X'08'      ; =0x08 =8
9476:      JSR$  X'0106'    ; =0x0106 =262 [Jump to subroutine indirect]
9479:      LDB=  X'414D'    ; =0x414d =16717 [Load B with immediate]
947c:      LDA=  X'8100'    ; =0x8100 =33024(-32512) [Load A with immediate]
947f:      STA+  B+         ; [Store A indexed, direct, post-incremented]
9481:      LDA=  X'82FF'    ; =0x82ff =33535(-32001) [Load A with immediate]
9484:      STA+  B          ; [Store A to address in B]
9485:      LDA=  X'FFFB'    ; =0xfffb =65531(-5) [Load A with immediate]
9488:      DMA   SCT,A      ; [Store A register to DMA count register]
948a:      LDA=  X'414D'    ; =0x414d =16717 [Load A with immediate]
948d:      DMA   SAD,A      ; [Store A register to DMA address register]
948f:      DMA   SDV,3      ; [Set DMA device]
9491:      DMA   EAB        ; [Enable DMA]
9493:      LDAB= X'43'      ; =67 [Load AL with immediate]
9495:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9498:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
949b:      BNF   D94A6      ; =+9 [Branch on no fault]
949d:D949D STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
94a0:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
94a3:      JMP$  X'010E'    ; =0x010e =270 [Jump indirect]
94a6:D94A6 LDAB= X'45'      ; =69 [Load AL with immediate]
94a8:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
94ab:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
94ae:      BF    D949D      ; =-19 [Branch on fault]
94b0:      LDB=  X'414F'    ; =0x414f =16719 [Load B with immediate]
94b3:      LDA=  X'8400'    ; =0x8400 =33792(-31744) =EOT,NUL [Load A with immediate]
94b6:      STA+  B+         ; [Store A indexed, direct, post-incremented]
94b8:      LDAB= X'83'      ; =131(-125) [Load AL with immediate]
94ba:      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
94bc:      CLA              ; [Clear A]
94bd:      STA+  B+         ; [Store A indexed, direct, post-incremented]
94bf:      DCA              ; [Decrement A]
94c0:      STAB+ B          ; [Store AL to address in B]
94c1:      INA              ; [Increment A]
94c2:      INA              ; [Increment A]
94c3:      STA/  X'41B1'    ; =0x41b1 =16817 [Store A direct]
94c6:D94C6 LDA=  X'414D'    ; =0x414d =16717 [Load A with immediate]
94c9:      DMA   SAD,A      ; [Store A register to DMA address register]
94cb:      LDA=  X'FFF7'    ; =0xfff7 =65527(-9) [Load A with immediate]
94ce:      DMA   SCT,A      ; [Store A register to DMA count register]
94d0:      DMA   SDV,3      ; [Set DMA device]
94d2:      DMA   EAB        ; [Enable DMA]
94d4:      LDAB= X'43'      ; =67 [Load AL with immediate]
94d6:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
94d9:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
94dc:      BF    D949D      ; =-65 [Branch on fault]
94de:      LDAB= X'45'      ; =69 [Load AL with immediate]
94e0:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
94e3:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
94e6:      BNF   D9504      ; =+28 [Branch on no fault]
94e8:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
94eb:      DC    'TRACK='   ; hex:d4d2c1c3cbbd
94f1:      DB    X'00'      ; =0x00 =0 =NUL
94f2:      LDA/  X'4152'    ; =0x4152 =16722 [Load A direct]
94f5:      JSR$  X'0110'    ; =0x0110 =272 [Jump to subroutine indirect]
94f8:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
94fb:      DW    X'8D8A'    ; =0x8d8a =36234(-29302) =CR,LF
94fd:      DB    X'00'      ; =0x00 =0 =NUL
94fe:      STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
9501:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
9504:D9504 LDA/  X'41B1'    ; =0x41b1 =16817 [Load A direct]
9507:      BM    D9523      ; =+26 [Branch on minus]
9509:      LDB/  X'4152'    ; =0x4152 =16722 [Load B direct]
950c:      ADD   B,A        ; [B + A -> A]
950e:      STA/  X'4152'    ; =0x4152 =16722 [Store A direct]
9511:      LDB=  X'0336'    ; =0x0336 =822 [Load B with immediate]
9514:      SAB              ; [A - B -> B]
9515:      BNZ   D94C6      ; =-81 [Branch if not zero]
9517:      CLA              ; [Clear A]
9518:      DCA              ; [Decrement A]
9519:      STA/  X'41B1'    ; =0x41b1 =16817 [Store A direct]
951c:      LDAB= X'10'      ; =16 [Load AL with immediate]
951e:      STAB/ X'4150'    ; =0x4150 =16720 [Store AL direct]
9521:      JMP   D94C6      ; =-93 [Jump relative]
9523:D9523 LDA/  X'4152'    ; =0x4152 =16722 [Load A direct]
9526:      DCA              ; [Decrement A]
9527:      STA/  X'4152'    ; =0x4152 =16722 [Store A direct]
952a:      BP    D94C6      ; =-102 [Branch on plus]
952c:      JSR$  X'0104'    ; =0x0104 =260 [Jump to subroutine indirect]
952f:      DW    X'0479'    ; =0x0479 =1145
*
9531:      LDA=  X'0180'    ; =0x0180 =384 [Load A with immediate]
9534:      ADD   Z,A        ; [Z + A -> A]
9536:      JSR+  A          ; [Jump to subroutine indexed, direct]
9538:      DC    'x'        ; hex:f8 dec:248(-8)
9539:      DB    X'08'      ; =0x08 =8
953a:      JSR$  X'0106'    ; =0x0106 =262 [Jump to subroutine indirect]
953d:      LDAB= X'41'      ; =65 [Load AL with immediate]
953f:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9542:      JSR$  X'010C'    ; =0x010c =268 [Jump to subroutine indirect]
9545:      CLAB             ; [Clear AL]
9546:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9549:      JSR$  X'010C'    ; =0x010c =268 [Jump to subroutine indirect]
954c:      CLAB             ; [Clear AL]
954d:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9550:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
9553:      BF    D9599      ; =+68 [Branch on fault]
9555:      LDA=  X'414D'    ; =0x414d =16717 [Load A with immediate]
9558:      XAY              ; [Transfer A to Y]
9559:      LDA=  X'8100'    ; =0x8100 =33024(-32512) [Load A with immediate]
955c:      STA+  Y+         ; [Store A indexed, direct, post-incremented]
955e:      LDA=  X'8400'    ; =0x8400 =33792(-31744) =EOT,NUL [Load A with immediate]
9561:      STA+  Y+         ; [Store A indexed, direct, post-incremented]
9563:      LDAB= X'83'      ; =131(-125) [Load AL with immediate]
9565:      STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
9567:      CLA              ; [Clear A]
9568:      STA+  Y+         ; [Store A indexed, direct, post-incremented]
956a:      LDAB= X'85'      ; =133(-123) [Load AL with immediate]
956c:      STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
956e:      LDB=  X'1000'    ; =0x1000 =4096 [Load B with immediate]
9571:D9571 STBB+ Y+         ; [Store BL indexed, direct, post-incremented]
9573:      LDA=  X'0190'    ; =0x0190 =400 [Load A with immediate]
9576:      STA+  Y+         ; [Store A indexed, direct, post-incremented]
9578:      INRB  BL         ; [Increment BL by 1]
957a:      DCRB  BU         ; [Decrement BU by 1]
957c:      BNZ   D9571      ; =-13 [Branch if not zero]
957e:      LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
9580:      STAB+ Y          ; [Store AL to address in Y]
9581:D9581 LDA=  X'FFC3'    ; =0xffc3 =65475(-61) [Load A with immediate]
9584:      DMA   SCT,A      ; [Store A register to DMA count register]
9586:      LDA=  X'414D'    ; =0x414d =16717 [Load A with immediate]
9589:      DMA   SAD,A      ; [Store A register to DMA address register]
958b:      DMA   SDV,3      ; [Set DMA device]
958d:      DMA   EAB        ; [Enable DMA]
958f:      LDAB= X'43'      ; =67 [Load AL with immediate]
9591:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9594:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
9597:      BNF   D95A2      ; =+9 [Branch on no fault]
9599:D9599 STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
959c:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
959f:      JMP$  X'010E'    ; =0x010e =270 [Jump indirect]
95a2:D95A2 LDA=  X'E6FF'    ; =0xe6ff =59135(-6401) [Load A with immediate]
95a5:      DMA   SCT,A      ; [Store A register to DMA count register]
95a7:      LDA=  X'011C'    ; =0x011c =284 [Load A with immediate]
95aa:      DMA   SAD,A      ; [Store A register to DMA address register]
95ac:      DMA   SDV,3      ; [Set DMA device]
95ae:      DMA   EAB        ; [Enable DMA]
95b0:      LDAB= X'45'      ; =69 [Load AL with immediate]
95b2:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
95b5:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
95b8:      BNF   D95D0      ; =+22 [Branch on no fault]
95ba:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
95bd:      DC    'TRACK='   ; hex:d4d2c1c3cbbd
95c3:      DB    X'00'      ; =0x00 =0 =NUL
95c4:      LDA/  X'4152'    ; =0x4152 =16722 [Load A direct]
95c7:      JSR$  X'0110'    ; =0x0110 =272 [Jump to subroutine indirect]
95ca:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
95cd:      DW    X'8D8A'    ; =0x8d8a =36234(-29302) =CR,LF
95cf:      DB    X'00'      ; =0x00 =0 =NUL
*
95d0:D95D0 LDA/  X'4152'    ; =0x4152 =16722 [Load A direct]
95d3:      BNZ   D95D6      ; =+1 [Branch if not zero]
95d5:      INA              ; [Increment A]
95d6:D95D6 SLA              ; [Left shift A]
95d7:      STA/  X'4152'    ; =0x4152 =16722 [Store A direct]
95da:      LDB=  X'0336'    ; =0x0336 =822 [Load B with immediate]
95dd:      SAB              ; [A - B -> B]
95de:      BLE   D9581      ; =-95 [Branch if less than or equal to zero]
95e0:      STAB/ X'F10A'    ; =0xf10a =61706(-3830) [Store AL direct]
95e3:      JSR$  X'0104'    ; =0x0104 =260 [Jump to subroutine indirect]
95e6:      DW    X'053D'    ; =0x053d =1341
*
95e8:      LDA=  X'0180'    ; =0x0180 =384 [Load A with immediate]
95eb:      ADD   Z,A        ; [Z + A -> A]
95ed:      JSR+  A          ; [Jump to subroutine indexed, direct]
95ef:      DC    'x'        ; hex:f8 dec:248(-8)
95f0:      DB    X'00'      ; =0x00 =0 =NUL
95f1:      JSR$  X'0106'    ; =0x0106 =262 [Jump to subroutine indirect]
95f4:      LDB=  X'414D'    ; =0x414d =16717 [Load B with immediate]
95f7:      LDA=  X'8101'    ; =0x8101 =33025(-32511) [Load A with immediate]
95fa:      STA+  B+         ; [Store A indexed, direct, post-incremented]
95fc:      LDAB= X'82'      ; =130(-126) [Load AL with immediate]
95fe:      STAB+ B          ; [Store AL to address in B]
95ff:      LDA=  X'FFFC'    ; =0xfffc =65532(-4) [Load A with immediate]
9602:      DMA   SCT,A      ; [Store A register to DMA count register]
9604:      LDA=  X'414D'    ; =0x414d =16717 [Load A with immediate]
9607:      DMA   SAD,A      ; [Store A register to DMA address register]
9609:      DMA   SDV,3      ; [Set DMA device]
960b:      DMA   EAB        ; [Enable DMA]
960d:      LDAB= X'43'      ; =67 [Load AL with immediate]
960f:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9612:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
9615:      BNF   D9620      ; =+9 [Branch on no fault]
9617:D9617 STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
961a:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
961d:      JMP$  X'010E'    ; =0x010e =270 [Jump indirect]
9620:D9620 LDAB= X'45'      ; =69 [Load AL with immediate]
9622:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9625:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
9628:      BF    D9617      ; =-19 [Branch on fault]
962a:      LDB=  X'414F'    ; =0x414f =16719 [Load B with immediate]
962d:      LDA=  X'8301'    ; =0x8301 =33537(-31999) [Load A with immediate]
9630:      STA+  B          ; [Store A to address in B]
9631:      LDAB= X'01'      ; =1 [Load AL with immediate]
9633:      STAB/ X'41B1'    ; =0x41b1 =16817 [Store AL direct]
9636:D9636 LDA=  X'414D'    ; =0x414d =16717 [Load A with immediate]
9639:      DMA   SAD,A      ; [Store A register to DMA address register]
963b:      LDA=  X'FFFB'    ; =0xfffb =65531(-5) [Load A with immediate]
963e:      DMA   SCT,A      ; [Store A register to DMA count register]
9640:      DMA   SDV,3      ; [Set DMA device]
9642:      DMA   EAB        ; [Enable DMA]
9644:      LDAB= X'43'      ; =67 [Load AL with immediate]
9646:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9649:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
964c:      BF    D9617      ; =-55 [Branch on fault]
964e:      LDAB= X'45'      ; =69 [Load AL with immediate]
9650:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9653:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
9656:      BNF   D9674      ; =+28 [Branch on no fault]
9658:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
965b:      DC    'TRACK='   ; hex:d4d2c1c3cbbd
9661:      DB    X'00'      ; =0x00 =0 =NUL
9662:      LDAB/ X'4150'    ; =0x4150 =16720 [Load AL direct]
9665:      JSR$  X'010A'    ; =0x010a =266 [Jump to subroutine indirect]
9668:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
966b:      DW    X'8D8A'    ; =0x8d8a =36234(-29302) =CR,LF
966d:      DB    X'00'      ; =0x00 =0 =NUL
966e:      STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
9671:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
9674:D9674 LDAB/ X'41B1'    ; =0x41b1 =16817 [Load AL direct]
9677:      BM    D968D      ; =+20 [Branch on minus]
9679:      LDBB/ X'4150'    ; =0x4150 =16720 [Load BL direct]
967c:      ADDB  BL,AL      ; [BL + AL -> AL]
967e:      STAB/ X'4150'    ; =0x4150 =16720 [Store AL direct]
9681:      LDBB= X'4B'      ; =75 [Load BL with immediate]
9683:      SABB             ; [AL - BL -> BL]
9684:      BNZ   D9636      ; =-80 [Branch if not zero]
9686:      LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
9688:      STAB/ X'41B1'    ; =0x41b1 =16817 [Store AL direct]
968b:      JMP   D9636      ; =-87 [Jump relative]
968d:D968D LDAB/ X'4150'    ; =0x4150 =16720 [Load AL direct]
9690:      DCAB             ; [Decrement AL]
9691:      STAB/ X'4150'    ; =0x4150 =16720 [Store AL direct]
9694:      BP    D9636      ; =-96 [Branch on plus]
9696:      JSR$  X'0104'    ; =0x0104 =260 [Jump to subroutine indirect]
9699:      DB    X'05'      ; =0x05 =5
969a:      DC    't'        ; hex:f4 dec:244(-12)
*
969b:      LDA=  X'0180'    ; =0x0180 =384 [Load A with immediate]
969e:      ADD   Z,A        ; [Z + A -> A]
96a0:      JSR+  A          ; [Jump to subroutine indexed, direct]
96a2:      DC    'x'        ; hex:f8 dec:248(-8)
96a3:      DB    X'00'      ; =0x00 =0 =NUL
96a4:      JSR$  X'0106'    ; =0x0106 =262 [Jump to subroutine indirect]
96a7:      LDAB= X'41'      ; =65 [Load AL with immediate]
96a9:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
96ac:      JSR$  X'010C'    ; =0x010c =268 [Jump to subroutine indirect]
96af:      CLAB             ; [Clear AL]
96b0:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
96b3:      JSR$  X'010C'    ; =0x010c =268 [Jump to subroutine indirect]
96b6:      CLAB             ; [Clear AL]
96b7:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
96ba:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
96bd:      BF    D96FC      ; =+61 [Branch on fault]
96bf:      LDA=  X'414D'    ; =0x414d =16717 [Load A with immediate]
96c2:      XAY              ; [Transfer A to Y]
96c3:      LDA=  X'8101'    ; =0x8101 =33025(-32511) [Load A with immediate]
96c6:      STA+  Y+         ; [Store A indexed, direct, post-incremented]
96c8:      LDA=  X'8301'    ; =0x8301 =33537(-31999) [Load A with immediate]
96cb:      STA+  Y+         ; [Store A indexed, direct, post-incremented]
96cd:      LDB=  X'1000'    ; =0x1000 =4096 [Load B with immediate]
96d0:D96D0 LDAB= X'88'      ; =136(-120) [Load AL with immediate]
96d2:      STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
96d4:      STBB+ Y+         ; [Store BL indexed, direct, post-incremented]
96d6:      CLAB             ; [Clear AL]
96d7:      STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
96d9:      LDA=  X'0190'    ; =0x0190 =400 [Load A with immediate]
96dc:      STA+  Y+         ; [Store A indexed, direct, post-incremented]
96de:      INRB  BL         ; [Increment BL by 1]
96e0:      DCRB  BU         ; [Decrement BU by 1]
96e2:      BNZ   D96D0      ; =-20 [Branch if not zero]
96e4:D96E4 LDA=  X'FFAB'    ; =0xffab =65451(-85) [Load A with immediate]
96e7:      DMA   SCT,A      ; [Store A register to DMA count register]
96e9:      LDA=  X'414D'    ; =0x414d =16717 [Load A with immediate]
96ec:      DMA   SAD,A      ; [Store A register to DMA address register]
96ee:      DMA   SDV,3      ; [Set DMA device]
96f0:      DMA   EAB        ; [Enable DMA]
96f2:      LDAB= X'43'      ; =67 [Load AL with immediate]
96f4:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
96f7:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
96fa:      BNF   D9705      ; =+9 [Branch on no fault]
96fc:D96FC STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
96ff:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
9702:      JMP$  X'010E'    ; =0x010e =270 [Jump indirect]
9705:D9705 LDA=  X'E6FF'    ; =0xe6ff =59135(-6401) [Load A with immediate]
9708:      DMA   SCT,A      ; [Store A register to DMA count register]
970a:      LDA=  X'011C'    ; =0x011c =284 [Load A with immediate]
970d:      DMA   SAD,A      ; [Store A register to DMA address register]
970f:      DMA   SDV,3      ; [Set DMA device]
9711:      DMA   EAB        ; [Enable DMA]
9713:      LDAB= X'45'      ; =69 [Load AL with immediate]
9715:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9718:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
971b:      BNF   D9733      ; =+22 [Branch on no fault]
971d:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9720:      DC    'TRACK='   ; hex:d4d2c1c3cbbd
9726:      DB    X'00'      ; =0x00 =0 =NUL
9727:      LDAB/ X'4150'    ; =0x4150 =16720 [Load AL direct]
972a:      JSR$  X'010A'    ; =0x010a =266 [Jump to subroutine indirect]
972d:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9730:      DW    X'8D8A'    ; =0x8d8a =36234(-29302) =CR,LF
9732:      DB    X'00'      ; =0x00 =0 =NUL
*
9733:D9733 LDAB/ X'4150'    ; =0x4150 =16720 [Load AL direct]
9736:      SLAB             ; [Left shift AL]
9737:      STAB/ X'4150'    ; =0x4150 =16720 [Store AL direct]
973a:      LDBB= X'4B'      ; =75 [Load BL with immediate]
973c:      SABB             ; [AL - BL -> BL]
973d:      BLE   D96E4      ; =-91 [Branch if less than or equal to zero]
973f:      STAB/ X'F10A'    ; =0xf10a =61706(-3830) [Store AL direct]
9742:      JSR$  X'0104'    ; =0x0104 =260 [Jump to subroutine indirect]
9745:      DW    X'06A7'    ; =0x06a7 =1703
*
*
* Function ENTRY
*
9747:ENTRY LDA=  X'0180'    ; =0x0180 =384 [Load A with immediate]
974a:      ADD   Z,A        ; [Z + A -> A]
974c:      JSR+  A          ; [Jump to subroutine indexed, direct]
974e:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9750:      XFR   Z,Y        ; [Transfer Z to Y]
9752:      CLA              ; [Clear A]
9753:D9753 LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
9755:      ADDB  AL,AU      ; [AL + AU -> AU]
9757:      LDB=  X'0796'    ; =0x0796 =1942 [Load B with immediate]
975a:      ADD   Z,B        ; [Z + B -> B]
975c:      SUB   Y,B        ; [Y - B -> B]
975e:      BNZ   D9753      ; =-13 [Branch if not zero]
9760:      LDAB+ Y          ; [Load AL from address in Y]
9761:      SUBB  AU,AL      ; [AU - AL -> AL]
9763:      BNZ   D977D      ; =+24 [Branch if not zero]
9765:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9768:      DW    X'8A8D'    ; =0x8a8d =35469(-30067) =LF,CR
976a:      DC    '*** PASS ***'
9776:      DB    X'00'      ; =0x00 =0 =NUL
9777:      STAB/ X'F10A'    ; =0xf10a =61706(-3830) [Store AL direct]
977a:      JMP$  X'010E'    ; =0x010e =270 [Jump indirect]
977d:D977D JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9780:      DC    '*** FAIL ***'
978c:      DB    X'00'      ; =0x00 =0 =NUL
978d:      STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
9790:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
9793:      JMP$  X'010E'    ; =0x010e =270 [Jump indirect]
*
9796:      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
9798:      DB    0,104      ; =0x00,0x0068
9800:ENDPT
