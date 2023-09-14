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
9800:      DB    X'02'      ; =0x02 =2
9801:      DC    'N01133 CMD AUX MEMORY TEST'
981b:      DB    X'8D'      ; =0x8d =141(-115) =CR
981c:      DW    X'8A00'    ; =0x8a00 =35328(-30208) =LF,NUL
981e:      DB    X'03'      ; =0x03 =3
981f:      DC    'Y01133 CMD SEEK TEST'
9833:      DB    X'8D'      ; =0x8d =141(-115) =CR
9834:      DW    X'8A00'    ; =0x8a00 =35328(-30208) =LF,NUL
9836:      DW    X'049D'    ; =0x049d =1181
9838:      DC    '01133 CMD READ TEST'
984b:      DB    X'8D'      ; =0x8d =141(-115) =CR
984c:      DW    X'8A00'    ; =0x8a00 =35328(-30208) =LF,NUL
984e:      DB    X'02'      ; =0x02 =2
984f:      DC    'YFINCH AUX MEMORY TEST'
9865:      DB    X'8D'      ; =0x8d =141(-115) =CR
9866:      DW    X'8A00'    ; =0x8a00 =35328(-30208) =LF,NUL
9868:      DW    X'053C'    ; =0x053c =1340
986a:      DC    'FINCH SEEK TEST'
9879:      DB    X'8D'      ; =0x8d =141(-115) =CR
987a:      DW    X'8A00'    ; =0x8a00 =35328(-30208) =LF,NUL
987c:      DW    X'05FF'    ; =0x05ff =1535
987e:      DC    'FINCH READ TEST'
988d:      DB    X'8D'      ; =0x8d =141(-115) =CR
988e:      DW    X'8A00'    ; =0x8a00 =35328(-30208) =LF,NUL
9890:      DW    X'069E'    ; =0x069e =1694
9892:      DC    'ROM SELF TEST'
989f:      DB    X'8D'      ; =0x8d =141(-115) =CR
98a0:      DW    X'8A8A'    ; =0x8a8a =35466(-30070) =LF,LF
98a2:      DB    0,3        ; =0x00,0x0003
*
98a5:D98A5 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
98a7:      BNZ   D98AA      ; =+1 [Branch if not zero]
98a9:      RSR              ; [Return from subroutine]
*
98aa:D98AA JSR   D98AE      ; =+2 [Jump to subroutine relative]
98ac:      JMP   D98A5      ; =-9 [Jump relative]
98ae:D98AE LDBB/ X'F200'    ; =0xf200 =61952(-3584) ='r',NUL [Load BL direct]
98b1:      SRRB  BL         ; [Arithmetic right shift BL by 1]
98b3:      SRRB  BL         ; [Arithmetic right shift BL by 1]
98b5:      BNL   D98AE      ; =-9 [Branch on no link]
98b7:      STAB/ X'F201'    ; =0xf201 =61953(-3583) [Store AL direct]
98ba:      RSR              ; [Return from subroutine]
*
98bb:D98BB LDAB/ X'F200'    ; =0xf200 =61952(-3584) ='r',NUL [Load AL direct]
98be:      SRAB             ; [Arithmetic right shift AL]
98bf:      BNL   D98BB      ; =-6 [Branch on no link]
98c1:      LDAB/ X'F201'    ; =0xf201 =61953(-3583) [Load AL direct]
98c4:      RSR              ; [Return from subroutine]
*
98c5:      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
98c7:      XFRB  AU,AL      ; [Transfer AU to AL]
98c9:      JSR   F98D0      ; =+5 [Jump to subroutine relative]
98cb:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
98cd:      JSR   F98D0      ; =+1 [Jump to subroutine relative]
98cf:      RSR              ; [Return from subroutine]
*
* Function F98D0
*
98d0:F98D0 STAB- S-         ; [Store AL indexed, pre-decremented, direct]
98d2:      LDBB= X'F0'      ; =240(-16) ='p' [Load BL with immediate]
98d4:      ANDB  BL,AL      ; [BL & AL -> AL]
98d6:      RL               ; [Reset link]
98d7:      RRRB  AL         ; [Right rotate AL by 1]
98d9:      SRAB             ; [Arithmetic right shift AL]
98da:      SRAB             ; [Arithmetic right shift AL]
98db:      SRAB             ; [Arithmetic right shift AL]
98dc:      LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
98de:      ADDB  BL,AL      ; [BL + AL -> AL]
98e0:      LDBB= X'B9'      ; =185(-71) ='9' [Load BL with immediate]
98e2:      SABB             ; [AL - BL -> BL]
98e3:      BLE   D98E9      ; =+4 [Branch if less than or equal to zero]
98e5:      LDBB= X'07'      ; =7 [Load BL with immediate]
98e7:      ADDB  BL,AL      ; [BL + AL -> AL]
98e9:D98E9 JSR   D98AE      ; =-61 [Jump to subroutine relative]
98eb:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
98ed:      LDBB= X'0F'      ; =15 [Load BL with immediate]
98ef:      ANDB  BL,AL      ; [BL & AL -> AL]
98f1:      LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
98f3:      ADDB  BL,AL      ; [BL + AL -> AL]
98f5:      LDBB= X'B9'      ; =185(-71) ='9' [Load BL with immediate]
98f7:      SABB             ; [AL - BL -> BL]
98f8:      BLE   D98FE      ; =+4 [Branch if less than or equal to zero]
98fa:      LDBB= X'07'      ; =7 [Load BL with immediate]
98fc:      ADDB  BL,AL      ; [BL + AL -> AL]
98fe:D98FE JSR   D98AE      ; =-82 [Jump to subroutine relative]
9900:      RSR              ; [Return from subroutine]
*
9901:      STAB/ X'F10A'    ; =0xf10a =61706(-3830) [Store AL direct]
9904:      LDAB/ X'F200'    ; =0xf200 =61952(-3584) ='r',NUL [Load AL direct]
9907:      SRAB             ; [Arithmetic right shift AL]
9908:      BNL   D9961      ; =+87 [Branch on no link]
990a:      LDAB/ X'F201'    ; =0xf201 =61953(-3583) [Load AL direct]
990d:      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
990f:      ORIB  BL,AL      ; [BL | AL -> AL]
9911:      LDBB= X'83'      ; =131(-125) [Load BL with immediate]
9913:      SABB             ; [AL - BL -> BL]
9914:      BNZ   D9961      ; =+75 [Branch if not zero]
9916:      LDAB/ X'0108'    ; =0x0108 =264 [Load AL direct]
9919:      BZ    D994D      ; =+50 [Branch if zero]
991b:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
991e:      DW    X'8D8A'    ; =0x8d8a =36234(-29302) =CR,LF
9920:      DC    '*** FAIL ***'
992c:      DB    X'00'      ; =0x00 =0 =NUL
992d:      STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
9930:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
9933:D9933 JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9936:      DW    X'8D8A'    ; =0x8d8a =36234(-29302) =CR,LF
9938:      DC    'PRESS SPACE'
9943:      DW    X'878D'    ; =0x878d =34701(-30835) =BEL,CR
9945:      DW    X'8A00'    ; =0x8a00 =35328(-30208) =LF,NUL
9947:      JSR$  X'0102'    ; =0x0102 =258 [Jump to subroutine indirect]
994a:      JMP$  X'0100'    ; =0x0100 =256 [Jump indirect]
994d:D994D JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9950:      DW    X'8D8A'    ; =0x8d8a =36234(-29302) =CR,LF
9952:      DC    '*** PASS ***'
995e:      DB    X'00'      ; =0x00 =0 =NUL
995f:      JMP   D9933      ; =-46 [Jump relative]
9961:D9961 LDA=  X'C000'    ; =0xc000 =49152(-16384) ='@',NUL [Load A with immediate]
9964:      XAS              ; [Transfer A to S]
9965:      LDA/  X'011A'    ; =0x011a =282 [Load A direct]
9968:      XAZ              ; [Transfer A to Z]
9969:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
996b:      ADD   Z,A        ; [Z + A -> A]
996d:      JMP+  A          ; [Jump indexed, direct]
996f:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9972:      DW    X'8D8A'    ; =0x8d8a =36234(-29302) =CR,LF
9974:      DC    '(CONTROL-C TO EXIT)'
9987:      DB    X'8D'      ; =0x8d =141(-115) =CR
9988:      DW    X'8A00'    ; =0x8a00 =35328(-30208) =LF,NUL
998a:      RSR              ; [Return from subroutine]
*
998b:      CLA              ; [Clear A]
998c:      STA/  X'0108'    ; =0x0108 =264 [Store A direct]
998f:      LDA=  X'01EE'    ; =0x01ee =494 [Load A with immediate]
9992:      ADD   Z,A        ; [Z + A -> A]
9994:      STA/  X'0118'    ; =0x0118 =280 [Store A direct]
9997:      LDA=  X'00D0'    ; =0x00d0 =208 =NUL,'P' [Load A with immediate]
999a:      ADD   Z,A        ; [Z + A -> A]
999c:      STA/  X'010A'    ; =0x010a =266 [Store A direct]
999f:      LDA=  X'0291'    ; =0x0291 =657 [Load A with immediate]
99a2:      ADD   Z,A        ; [Z + A -> A]
99a4:      STA/  X'010C'    ; =0x010c =268 [Store A direct]
99a7:      LDA=  X'016F'    ; =0x016f =367 [Load A with immediate]
99aa:      ADD   Z,A        ; [Z + A -> A]
99ac:      STA/  X'0106'    ; =0x0106 =262 [Store A direct]
99af:      LDA=  X'00BB'    ; =0x00bb =187 =NUL,';' [Load A with immediate]
99b2:      ADD   Z,A        ; [Z + A -> A]
99b4:      STA/  X'0102'    ; =0x0102 =258 [Store A direct]
99b7:      LDA=  X'00A5'    ; =0x00a5 =165 =NUL,'%' [Load A with immediate]
99ba:      ADD   Z,A        ; [Z + A -> A]
99bc:      STA/  X'0112'    ; =0x0112 =274 [Store A direct]
99bf:      LDA=  X'00C5'    ; =0x00c5 =197 =NUL,'E' [Load A with immediate]
99c2:      ADD   Z,A        ; [Z + A -> A]
99c4:      STA/  X'0110'    ; =0x0110 =272 [Store A direct]
99c7:      LDA=  X'0101'    ; =0x0101 =257 [Load A with immediate]
99ca:      ADD   Z,A        ; [Z + A -> A]
99cc:      STA/  X'0104'    ; =0x0104 =260 [Store A direct]
99cf:      LDA=  X'0133'    ; =0x0133 =307 [Load A with immediate]
99d2:      ADD   Z,A        ; [Z + A -> A]
99d4:      STA/  X'010E'    ; =0x010e =270 [Store A direct]
99d7:      XFR   Z,A        ; [Transfer Z to A]
99d9:      STA/  X'011A'    ; =0x011a =282 [Store A direct]
99dc:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
99de:      STA/  X'0114'    ; =0x0114 =276 [Store A direct]
99e1:      INA              ; [Increment A]
99e2:      STA/  X'0116'    ; =0x0116 =278 [Store A direct]
99e5:      XFR   X,A        ; [Transfer X to A]
99e7:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
99e9:      STX/  X'0100'    ; =0x0100 =256 [Store X direct]
99ec:      JMP+  A          ; [Jump indexed, direct]
99ee:      JSR$  X'010C'    ; =0x010c =268 [Jump to subroutine indirect]
99f1:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
99f3:      LDX=  X'03E8'    ; =0x03e8 =1000 [Load X with immediate]
99f6:D99F6 LDAB$ X'0116'    ; =0x0116 =278 [Load AL indirect]
99f9:      LDBB= X'08'      ; =8 [Load BL with immediate]
99fb:      NABB             ; [AL & BL -> BL]
99fc:      BZ    D9A29      ; =+43 [Branch if zero]
99fe:      DLY              ; [Delay 4.55 ms]
99ff:      DCX              ; [Decrement X]
9a00:      BNZ   D99F6      ; =-12 [Branch if not zero]
9a02:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9a05:      DC    '*** BUSY DID NOT CLEAR ***'
9a1f:      DB    X'00'      ; =0x00 =0 =NUL
9a20:      STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
9a23:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
9a26:      JMP$  X'010E'    ; =0x010e =270 [Jump indirect]
9a29:D9A29 LDX=  X'03E8'    ; =0x03e8 =1000 [Load X with immediate]
9a2c:D9A2C SRAB             ; [Arithmetic right shift AL]
9a2d:      BL    D9A5A      ; =+43 [Branch on link]
9a2f:      DLY              ; [Delay 4.55 ms]
9a30:      DCX              ; [Decrement X]
9a31:      BNZ   D9A2C      ; =-7 [Branch if not zero]
9a33:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9a36:      DC    '*** FOUT NEVER CAME ON ***'
9a50:      DB    X'00'      ; =0x00 =0 =NUL
9a51:      STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
9a54:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
9a57:      JMP$  X'010E'    ; =0x010e =270 [Jump indirect]
9a5a:D9A5A RF               ; [Reset fault]
9a5b:      LDAB$ X'0114'    ; =0x0114 =276 [Load AL indirect]
9a5e:      BNZ   D9A63      ; =+3 [Branch if not zero]
9a60:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
9a62:      RSR              ; [Return from subroutine]
*
9a63:D9A63 STAB- S-         ; [Store AL indexed, pre-decremented, direct]
9a65:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9a68:      DC    '*** '     ; hex:aaaaaaa0
9a6c:      DB    X'00'      ; =0x00 =0 =NUL
9a6d:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
9a6f:      JSR$  X'010A'    ; =0x010a =266 [Jump to subroutine indirect]
9a72:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9a75:      DC    ' ERROR ***' ; hex:a0c5d2d2cfd2a0aaaaaa
9a7f:      DB    X'8D'      ; =0x8d =141(-115) =CR
9a80:      DW    X'8A00'    ; =0x8a00 =35328(-30208) =LF,NUL
9a82:      LDAB= X'01'      ; =1 [Load AL with immediate]
9a84:      STAB/ X'0108'    ; =0x0108 =264 [Store AL direct]
9a87:      STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
9a8a:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
9a8d:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
9a8f:      SF               ; [Set fault]
9a90:      RSR              ; [Return from subroutine]
*
9a91:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
9a93:      DLY              ; [Delay 4.55 ms]
9a94:      LDX=  X'03E8'    ; =0x03e8 =1000 [Load X with immediate]
9a97:D9A97 LDAB$ X'0116'    ; =0x0116 =278 [Load AL indirect]
9a9a:      SRAB             ; [Arithmetic right shift AL]
9a9b:      SRAB             ; [Arithmetic right shift AL]
9a9c:      BNL   D9ACB      ; =+45 [Branch on no link]
9a9e:      DLY              ; [Delay 4.55 ms]
9a9f:      DCX              ; [Decrement X]
9aa0:      BNZ   D9A97      ; =-11 [Branch if not zero]
9aa2:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9aa5:      DC    '*** FIN DID NOT GO OFF ***'
9abf:      DB    X'8D'      ; =0x8d =141(-115) =CR
9ac0:      DW    X'8A00'    ; =0x8a00 =35328(-30208) =LF,NUL
9ac2:      STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
9ac5:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
9ac8:      JMP$  X'010E'    ; =0x010e =270 [Jump indirect]
9acb:D9ACB LDX+  S+         ; [Load X indexed, direct, post-incremented]
9acd:      RSR              ; [Return from subroutine]
*
9ace:      LDA=  X'018B'    ; =0x018b =395 [Load A with immediate]
9ad1:      ADD   Z,A        ; [Z + A -> A]
9ad3:      JSR+  A          ; [Jump to subroutine indexed, direct]
9ad5:      DC    'x'        ; hex:f8 dec:248(-8)
9ad6:      DB    X'08'      ; =0x08 =8
9ad7:      JMP   D9AE2      ; =+9 [Jump relative]
9ad9:      LDA=  X'018B'    ; =0x018b =395 [Load A with immediate]
9adc:      ADD   Z,A        ; [Z + A -> A]
9ade:      JSR+  A          ; [Jump to subroutine indexed, direct]
9ae0:      DC    'x'        ; hex:f8 dec:248(-8)
9ae1:      DB    X'00'      ; =0x00 =0 =NUL
*
9ae2:D9AE2 JSR$  X'0106'    ; =0x0106 =262 [Jump to subroutine indirect]
9ae5:      CLR   Y          ; [Clear Y]
9ae7:      LDX=  X'0F00'    ; =0x0f00 =3840 [Load X with immediate]
9aea:      XFR   Y,A        ; [Transfer Y to A]
9aec:      LDB=  X'011C'    ; =0x011c =284 [Load B with immediate]
9aef:D9AEF STAB+ B+         ; [Store AL indexed, direct, post-incremented]
9af1:      INAB             ; [Increment AL]
9af2:      INAB             ; [Increment AL]
9af3:      INAB             ; [Increment AL]
9af4:      DCX              ; [Decrement X]
9af5:      BNZ   D9AEF      ; =-8 [Branch if not zero]
9af7:      LDA=  X'F0FF'    ; =0xf0ff =61695(-3841) [Load A with immediate]
9afa:      DMA   SCT,A      ; [Store A register to DMA count register]
9afc:      LDA=  X'011C'    ; =0x011c =284 [Load A with immediate]
9aff:      DMA   SAD,A      ; [Store A register to DMA address register]
9b01:      DMA   SDV,3      ; [Set DMA device]
9b03:      DMA   EAB        ; [Enable DMA]
9b05:      LDAB= X'46'      ; =70 [Load AL with immediate]
9b07:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9b0a:      JSR$  X'010C'    ; =0x010c =268 [Jump to subroutine indirect]
9b0d:      LDAB= X'01'      ; =1 [Load AL with immediate]
9b0f:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9b12:      JSR$  X'010C'    ; =0x010c =268 [Jump to subroutine indirect]
9b15:      CLAB             ; [Clear AL]
9b16:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9b19:      JSR$  X'010C'    ; =0x010c =268 [Jump to subroutine indirect]
9b1c:      LDAB= X'0F'      ; =15 [Load AL with immediate]
9b1e:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9b21:      JSR$  X'010C'    ; =0x010c =268 [Jump to subroutine indirect]
9b24:      CLAB             ; [Clear AL]
9b25:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9b28:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
9b2b:      LDX=  X'0F00'    ; =0x0f00 =3840 [Load X with immediate]
9b2e:      CLA              ; [Clear A]
9b2f:      LDB=  X'011C'    ; =0x011c =284 [Load B with immediate]
9b32:D9B32 STAB+ B+         ; [Store AL indexed, direct, post-incremented]
9b34:      DCX              ; [Decrement X]
9b35:      BNZ   D9B32      ; =-5 [Branch if not zero]
9b37:      LDA=  X'F0FF'    ; =0xf0ff =61695(-3841) [Load A with immediate]
9b3a:      DMA   SCT,A      ; [Store A register to DMA count register]
9b3c:      LDA=  X'011C'    ; =0x011c =284 [Load A with immediate]
9b3f:      DMA   SAD,A      ; [Store A register to DMA address register]
9b41:      DMA   SDV,3      ; [Set DMA device]
9b43:      DMA   EAB        ; [Enable DMA]
9b45:      LDAB= X'47'      ; =71 [Load AL with immediate]
9b47:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9b4a:      JSR$  X'010C'    ; =0x010c =268 [Jump to subroutine indirect]
9b4d:      LDAB= X'01'      ; =1 [Load AL with immediate]
9b4f:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9b52:      JSR$  X'010C'    ; =0x010c =268 [Jump to subroutine indirect]
9b55:      CLAB             ; [Clear AL]
9b56:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9b59:      JSR$  X'010C'    ; =0x010c =268 [Jump to subroutine indirect]
9b5c:      LDAB= X'0F'      ; =15 [Load AL with immediate]
9b5e:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9b61:      JSR$  X'010C'    ; =0x010c =268 [Jump to subroutine indirect]
9b64:      CLAB             ; [Clear AL]
9b65:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9b68:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
9b6b:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
9b6d:      LDX=  X'0F00'    ; =0x0f00 =3840 [Load X with immediate]
9b70:      LDB=  X'011C'    ; =0x011c =284 [Load B with immediate]
9b73:      XFR   Y,A        ; [Transfer Y to A]
9b75:      XFRB  AL,AU      ; [Transfer AL to AU]
9b77:D9B77 LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
9b79:      STA+  S          ; [Store A to address in S]
9b7a:      SUBB  AU,AL      ; [AU - AL -> AL]
9b7c:      BNZ   D9B90      ; =+18 [Branch if not zero]
9b7e:      INRB  AU         ; [Increment AU by 1]
9b80:      INRB  AU         ; [Increment AU by 1]
9b82:      INRB  AU         ; [Increment AU by 1]
9b84:      DCX              ; [Decrement X]
9b85:      BNZ   D9B77      ; =-16 [Branch if not zero]
9b87:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
9b89:      INRB  YL         ; [Increment YL by 1]
9b8b:      JSR$  X'0104'    ; =0x0104 =260 [Jump to subroutine indirect]
9b8e:      DB    X'02'      ; =0x02 =2
9b8f:      DC    'e'        ; hex:e5 dec:229(-27)
*
9b90:D9B90 STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
9b93:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
9b96:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
9b98:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9b9b:      DC    '*** ERROR, ADDR='
9bab:      DB    X'00'      ; =0x00 =0 =NUL
9bac:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
9bae:      DCA              ; [Decrement A]
9baf:      JSR$  X'0110'    ; =0x0110 =272 [Jump to subroutine indirect]
9bb2:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9bb5:      DC    ' EXP='    ; hex:a0c5d8d0bd
9bba:      DB    X'00'      ; =0x00 =0 =NUL
9bbb:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
9bbd:      JSR$  X'010A'    ; =0x010a =266 [Jump to subroutine indirect]
9bc0:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9bc3:      DC    ' ACT='    ; hex:a0c1c3d4bd
9bc8:      DB    X'00'      ; =0x00 =0 =NUL
9bc9:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
9bcb:      JSR$  X'010A'    ; =0x010a =266 [Jump to subroutine indirect]
9bce:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9bd1:      DC    ' ***'     ; hex:a0aaaaaa
9bd5:      DB    X'00'      ; =0x00 =0 =NUL
9bd6:      JMP$  X'010E'    ; =0x010e =270 [Jump indirect]
9bd9:      LDA=  X'018B'    ; =0x018b =395 [Load A with immediate]
9bdc:      ADD   Z,A        ; [Z + A -> A]
9bde:      JSR+  A          ; [Jump to subroutine indexed, direct]
9be0:      DC    'x'        ; hex:f8 dec:248(-8)
9be1:      DB    X'08'      ; =0x08 =8
9be2:      JSR$  X'0106'    ; =0x0106 =262 [Jump to subroutine indirect]
9be5:      LDB=  X'414D'    ; =0x414d =16717 [Load B with immediate]
9be8:      LDA=  X'8100'    ; =0x8100 =33024(-32512) [Load A with immediate]
9beb:      STA+  B+         ; [Store A indexed, direct, post-incremented]
9bed:      LDA=  X'82FF'    ; =0x82ff =33535(-32001) [Load A with immediate]
9bf0:      STA+  B          ; [Store A to address in B]
9bf1:      LDA=  X'FFFB'    ; =0xfffb =65531(-5) [Load A with immediate]
9bf4:      DMA   SCT,A      ; [Store A register to DMA count register]
9bf6:      LDA=  X'414D'    ; =0x414d =16717 [Load A with immediate]
9bf9:      DMA   SAD,A      ; [Store A register to DMA address register]
9bfb:      DMA   SDV,3      ; [Set DMA device]
9bfd:      DMA   EAB        ; [Enable DMA]
9bff:      LDAB= X'43'      ; =67 [Load AL with immediate]
9c01:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9c04:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
9c07:      BNF   D9C12      ; =+9 [Branch on no fault]
9c09:D9C09 STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
9c0c:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
9c0f:      JMP$  X'010E'    ; =0x010e =270 [Jump indirect]
9c12:D9C12 LDAB= X'45'      ; =69 [Load AL with immediate]
9c14:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9c17:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
9c1a:      BF    D9C09      ; =-19 [Branch on fault]
9c1c:      LDB=  X'414F'    ; =0x414f =16719 [Load B with immediate]
9c1f:      LDA=  X'8400'    ; =0x8400 =33792(-31744) =EOT,NUL [Load A with immediate]
9c22:      STA+  B+         ; [Store A indexed, direct, post-incremented]
9c24:      LDAB= X'83'      ; =131(-125) [Load AL with immediate]
9c26:      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
9c28:      CLA              ; [Clear A]
9c29:      STA+  B+         ; [Store A indexed, direct, post-incremented]
9c2b:      DCA              ; [Decrement A]
9c2c:      STAB+ B          ; [Store AL to address in B]
9c2d:      INA              ; [Increment A]
9c2e:      INA              ; [Increment A]
9c2f:      STA/  X'41B1'    ; =0x41b1 =16817 [Store A direct]
9c32:D9C32 LDA=  X'414D'    ; =0x414d =16717 [Load A with immediate]
9c35:      DMA   SAD,A      ; [Store A register to DMA address register]
9c37:      LDA=  X'FFF7'    ; =0xfff7 =65527(-9) [Load A with immediate]
9c3a:      DMA   SCT,A      ; [Store A register to DMA count register]
9c3c:      DMA   SDV,3      ; [Set DMA device]
9c3e:      DMA   EAB        ; [Enable DMA]
9c40:      LDAB= X'43'      ; =67 [Load AL with immediate]
9c42:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9c45:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
9c48:      BF    D9C09      ; =-65 [Branch on fault]
9c4a:      LDAB= X'45'      ; =69 [Load AL with immediate]
9c4c:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9c4f:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
9c52:      BNF   D9C70      ; =+28 [Branch on no fault]
9c54:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9c57:      DC    'TRACK='   ; hex:d4d2c1c3cbbd
9c5d:      DB    X'00'      ; =0x00 =0 =NUL
9c5e:      LDA/  X'4152'    ; =0x4152 =16722 [Load A direct]
9c61:      JSR$  X'0110'    ; =0x0110 =272 [Jump to subroutine indirect]
9c64:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9c67:      DW    X'8D8A'    ; =0x8d8a =36234(-29302) =CR,LF
9c69:      DB    X'00'      ; =0x00 =0 =NUL
9c6a:      STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
9c6d:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
9c70:D9C70 LDA/  X'41B1'    ; =0x41b1 =16817 [Load A direct]
9c73:      BM    D9C8F      ; =+26 [Branch on minus]
9c75:      LDB/  X'4152'    ; =0x4152 =16722 [Load B direct]
9c78:      ADD   B,A        ; [B + A -> A]
9c7a:      STA/  X'4152'    ; =0x4152 =16722 [Store A direct]
9c7d:      LDB=  X'0336'    ; =0x0336 =822 [Load B with immediate]
9c80:      SAB              ; [A - B -> B]
9c81:      BNZ   D9C32      ; =-81 [Branch if not zero]
9c83:      CLA              ; [Clear A]
9c84:      DCA              ; [Decrement A]
9c85:      STA/  X'41B1'    ; =0x41b1 =16817 [Store A direct]
9c88:      LDAB= X'10'      ; =16 [Load AL with immediate]
9c8a:      STAB/ X'4150'    ; =0x4150 =16720 [Store AL direct]
9c8d:      JMP   D9C32      ; =-93 [Jump relative]
9c8f:D9C8F LDA/  X'4152'    ; =0x4152 =16722 [Load A direct]
9c92:      DCA              ; [Decrement A]
9c93:      STA/  X'4152'    ; =0x4152 =16722 [Store A direct]
9c96:      BP    D9C32      ; =-102 [Branch on plus]
9c98:      JSR$  X'0104'    ; =0x0104 =260 [Jump to subroutine indirect]
9c9b:      DB    X'03'      ; =0x03 =3
9c9c:      DC    'e'        ; hex:e5 dec:229(-27)
*
9c9d:      LDA=  X'018B'    ; =0x018b =395 [Load A with immediate]
9ca0:      ADD   Z,A        ; [Z + A -> A]
9ca2:      JSR+  A          ; [Jump to subroutine indexed, direct]
9ca4:      DC    'x'        ; hex:f8 dec:248(-8)
9ca5:      DB    X'08'      ; =0x08 =8
9ca6:      JSR$  X'0106'    ; =0x0106 =262 [Jump to subroutine indirect]
9ca9:      LDA=  X'414D'    ; =0x414d =16717 [Load A with immediate]
9cac:      XAY              ; [Transfer A to Y]
9cad:      LDA=  X'8100'    ; =0x8100 =33024(-32512) [Load A with immediate]
9cb0:      STA+  Y+         ; [Store A indexed, direct, post-incremented]
9cb2:      LDA=  X'8400'    ; =0x8400 =33792(-31744) =EOT,NUL [Load A with immediate]
9cb5:      STA+  Y+         ; [Store A indexed, direct, post-incremented]
9cb7:      LDAB= X'83'      ; =131(-125) [Load AL with immediate]
9cb9:      STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
9cbb:      CLA              ; [Clear A]
9cbc:      STA+  Y+         ; [Store A indexed, direct, post-incremented]
9cbe:      LDAB= X'85'      ; =133(-123) [Load AL with immediate]
9cc0:      STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
9cc2:      LDB=  X'1000'    ; =0x1000 =4096 [Load B with immediate]
9cc5:D9CC5 STBB+ Y+         ; [Store BL indexed, direct, post-incremented]
9cc7:      LDA=  X'0190'    ; =0x0190 =400 [Load A with immediate]
9cca:      STA+  Y+         ; [Store A indexed, direct, post-incremented]
9ccc:      INRB  BL         ; [Increment BL by 1]
9cce:      DCRB  BU         ; [Decrement BU by 1]
9cd0:      BNZ   D9CC5      ; =-13 [Branch if not zero]
9cd2:      LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
9cd4:      STAB+ Y          ; [Store AL to address in Y]
9cd5:D9CD5 LDA=  X'FFC3'    ; =0xffc3 =65475(-61) [Load A with immediate]
9cd8:      DMA   SCT,A      ; [Store A register to DMA count register]
9cda:      LDA=  X'414D'    ; =0x414d =16717 [Load A with immediate]
9cdd:      DMA   SAD,A      ; [Store A register to DMA address register]
9cdf:      DMA   SDV,3      ; [Set DMA device]
9ce1:      DMA   EAB        ; [Enable DMA]
9ce3:      LDAB= X'43'      ; =67 [Load AL with immediate]
9ce5:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9ce8:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
9ceb:      BNF   D9CF6      ; =+9 [Branch on no fault]
9ced:      STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
9cf0:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
9cf3:      JMP$  X'010E'    ; =0x010e =270 [Jump indirect]
9cf6:D9CF6 LDA=  X'E6FF'    ; =0xe6ff =59135(-6401) [Load A with immediate]
9cf9:      DMA   SCT,A      ; [Store A register to DMA count register]
9cfb:      LDA=  X'011C'    ; =0x011c =284 [Load A with immediate]
9cfe:      DMA   SAD,A      ; [Store A register to DMA address register]
9d00:      DMA   SDV,3      ; [Set DMA device]
9d02:      DMA   EAB        ; [Enable DMA]
9d04:      LDAB= X'45'      ; =69 [Load AL with immediate]
9d06:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9d09:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
9d0c:      BNF   D9D24      ; =+22 [Branch on no fault]
9d0e:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9d11:      DC    'TRACK='   ; hex:d4d2c1c3cbbd
9d17:      DB    X'00'      ; =0x00 =0 =NUL
9d18:      LDA/  X'4152'    ; =0x4152 =16722 [Load A direct]
9d1b:      JSR$  X'0110'    ; =0x0110 =272 [Jump to subroutine indirect]
9d1e:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9d21:      DW    X'8D8A'    ; =0x8d8a =36234(-29302) =CR,LF
9d23:      DB    X'00'      ; =0x00 =0 =NUL
*
9d24:D9D24 LDA/  X'4152'    ; =0x4152 =16722 [Load A direct]
9d27:      BNZ   D9D2A      ; =+1 [Branch if not zero]
9d29:      INA              ; [Increment A]
9d2a:D9D2A SLA              ; [Left shift A]
9d2b:      STA/  X'4152'    ; =0x4152 =16722 [Store A direct]
9d2e:      LDB=  X'0336'    ; =0x0336 =822 [Load B with immediate]
9d31:      SAB              ; [A - B -> B]
9d32:      BLE   D9CD5      ; =-95 [Branch if less than or equal to zero]
9d34:      STAB/ X'F10A'    ; =0xf10a =61706(-3830) [Store AL direct]
9d37:      JSR$  X'0104'    ; =0x0104 =260 [Jump to subroutine indirect]
9d3a:      DB    X'04'      ; =0x04 =4
9d3b:      DC    ')'        ; hex:a9 dec:169(-87)
*
9d3c:      LDA=  X'018B'    ; =0x018b =395 [Load A with immediate]
9d3f:      ADD   Z,A        ; [Z + A -> A]
9d41:      JSR+  A          ; [Jump to subroutine indexed, direct]
9d43:      DC    'x'        ; hex:f8 dec:248(-8)
9d44:      DB    X'00'      ; =0x00 =0 =NUL
9d45:      JSR$  X'0106'    ; =0x0106 =262 [Jump to subroutine indirect]
9d48:      LDB=  X'414D'    ; =0x414d =16717 [Load B with immediate]
9d4b:      LDA=  X'8102'    ; =0x8102 =33026(-32510) [Load A with immediate]
9d4e:      STA+  B+         ; [Store A indexed, direct, post-incremented]
9d50:      LDA=  X'8400'    ; =0x8400 =33792(-31744) =EOT,NUL [Load A with immediate]
9d53:      STA+  B+         ; [Store A indexed, direct, post-incremented]
9d55:      LDA=  X'82FF'    ; =0x82ff =33535(-32001) [Load A with immediate]
9d58:      STA+  B          ; [Store A to address in B]
9d59:      LDA=  X'FFF9'    ; =0xfff9 =65529(-7) [Load A with immediate]
9d5c:      DMA   SCT,A      ; [Store A register to DMA count register]
9d5e:      LDA=  X'414D'    ; =0x414d =16717 [Load A with immediate]
9d61:      DMA   SAD,A      ; [Store A register to DMA address register]
9d63:      DMA   SDV,3      ; [Set DMA device]
9d65:      DMA   EAB        ; [Enable DMA]
9d67:      LDAB= X'43'      ; =67 [Load AL with immediate]
9d69:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9d6c:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
9d6f:      BNF   D9D7A      ; =+9 [Branch on no fault]
9d71:D9D71 STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
9d74:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
9d77:      JMP$  X'010E'    ; =0x010e =270 [Jump indirect]
9d7a:D9D7A LDAB= X'45'      ; =69 [Load AL with immediate]
9d7c:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9d7f:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
9d82:      BF    D9D71      ; =-19 [Branch on fault]
9d84:      LDB=  X'414F'    ; =0x414f =16719 [Load B with immediate]
9d87:      LDA=  X'8400'    ; =0x8400 =33792(-31744) =EOT,NUL [Load A with immediate]
9d8a:      STA+  B+         ; [Store A indexed, direct, post-incremented]
9d8c:      LDAB= X'83'      ; =131(-125) [Load AL with immediate]
9d8e:      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
9d90:      CLA              ; [Clear A]
9d91:      STA+  B+         ; [Store A indexed, direct, post-incremented]
9d93:      DCA              ; [Decrement A]
9d94:      STAB+ B          ; [Store AL to address in B]
9d95:      INA              ; [Increment A]
9d96:      INA              ; [Increment A]
9d97:      STA/  X'41B1'    ; =0x41b1 =16817 [Store A direct]
9d9a:D9D9A LDA=  X'414D'    ; =0x414d =16717 [Load A with immediate]
9d9d:      DMA   SAD,A      ; [Store A register to DMA address register]
9d9f:      LDA=  X'FFF7'    ; =0xfff7 =65527(-9) [Load A with immediate]
9da2:      DMA   SCT,A      ; [Store A register to DMA count register]
9da4:      DMA   SDV,3      ; [Set DMA device]
9da6:      DMA   EAB        ; [Enable DMA]
9da8:      LDAB= X'43'      ; =67 [Load AL with immediate]
9daa:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9dad:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
9db0:      BF    D9D71      ; =-65 [Branch on fault]
9db2:      LDAB= X'45'      ; =69 [Load AL with immediate]
9db4:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9db7:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
9dba:      BNF   D9DD8      ; =+28 [Branch on no fault]
9dbc:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9dbf:      DC    'TRACK='   ; hex:d4d2c1c3cbbd
9dc5:      DB    X'00'      ; =0x00 =0 =NUL
9dc6:      LDA/  X'4152'    ; =0x4152 =16722 [Load A direct]
9dc9:      JSR$  X'0110'    ; =0x0110 =272 [Jump to subroutine indirect]
9dcc:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9dcf:      DW    X'8D8A'    ; =0x8d8a =36234(-29302) =CR,LF
9dd1:      DB    X'00'      ; =0x00 =0 =NUL
9dd2:      STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
9dd5:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
9dd8:D9DD8 LDA/  X'41B1'    ; =0x41b1 =16817 [Load A direct]
9ddb:      BM    D9DF1      ; =+20 [Branch on minus]
9ddd:      LDA/  X'4152'    ; =0x4152 =16722 [Load A direct]
9de0:      INA              ; [Increment A]
9de1:      STA/  X'4152'    ; =0x4152 =16722 [Store A direct]
9de4:      LDB=  X'025C'    ; =0x025c =604 [Load B with immediate]
9de7:      SAB              ; [A - B -> B]
9de8:      BNZ   D9D9A      ; =-80 [Branch if not zero]
9dea:      CLA              ; [Clear A]
9deb:      DCA              ; [Decrement A]
9dec:      STA/  X'41B1'    ; =0x41b1 =16817 [Store A direct]
9def:      JMP   D9D9A      ; =-87 [Jump relative]
9df1:D9DF1 LDA/  X'4152'    ; =0x4152 =16722 [Load A direct]
9df4:      DCA              ; [Decrement A]
9df5:      STA/  X'4152'    ; =0x4152 =16722 [Store A direct]
9df8:      BP    D9D9A      ; =-96 [Branch on plus]
9dfa:      JSR$  X'0104'    ; =0x0104 =260 [Jump to subroutine indirect]
9dfd:      DW    X'0548'    ; =0x0548 =1352
*
9dff:      LDA=  X'018B'    ; =0x018b =395 [Load A with immediate]
9e02:      ADD   Z,A        ; [Z + A -> A]
9e04:      JSR+  A          ; [Jump to subroutine indexed, direct]
9e06:      DC    'x'        ; hex:f8 dec:248(-8)
9e07:      DB    X'00'      ; =0x00 =0 =NUL
9e08:      JSR$  X'0106'    ; =0x0106 =262 [Jump to subroutine indirect]
9e0b:      LDA=  X'414D'    ; =0x414d =16717 [Load A with immediate]
9e0e:      XAY              ; [Transfer A to Y]
9e0f:      LDA=  X'8102'    ; =0x8102 =33026(-32510) [Load A with immediate]
9e12:      STA+  Y+         ; [Store A indexed, direct, post-incremented]
9e14:      LDA=  X'8400'    ; =0x8400 =33792(-31744) =EOT,NUL [Load A with immediate]
9e17:      STA+  Y+         ; [Store A indexed, direct, post-incremented]
9e19:      LDAB= X'83'      ; =131(-125) [Load AL with immediate]
9e1b:      STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
9e1d:      CLA              ; [Clear A]
9e1e:      STA+  Y+         ; [Store A indexed, direct, post-incremented]
9e20:      LDAB= X'8A'      ; =138(-118) =LF [Load AL with immediate]
9e22:      STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
9e24:      LDB=  X'1000'    ; =0x1000 =4096 [Load B with immediate]
9e27:D9E27 STBB+ Y+         ; [Store BL indexed, direct, post-incremented]
9e29:      LDA=  X'0190'    ; =0x0190 =400 [Load A with immediate]
9e2c:      STA+  Y+         ; [Store A indexed, direct, post-incremented]
9e2e:      INRB  BL         ; [Increment BL by 1]
9e30:      DCRB  BU         ; [Decrement BU by 1]
9e32:      BNZ   D9E27      ; =-13 [Branch if not zero]
9e34:      LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
9e36:      STAB+ Y          ; [Store AL to address in Y]
9e37:D9E37 LDA=  X'FFC3'    ; =0xffc3 =65475(-61) [Load A with immediate]
9e3a:      DMA   SCT,A      ; [Store A register to DMA count register]
9e3c:      LDA=  X'414D'    ; =0x414d =16717 [Load A with immediate]
9e3f:      DMA   SAD,A      ; [Store A register to DMA address register]
9e41:      DMA   SDV,3      ; [Set DMA device]
9e43:      DMA   EAB        ; [Enable DMA]
9e45:      LDAB= X'43'      ; =67 [Load AL with immediate]
9e47:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9e4a:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
9e4d:      BNF   D9E58      ; =+9 [Branch on no fault]
9e4f:      STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
9e52:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
9e55:      JMP$  X'010E'    ; =0x010e =270 [Jump indirect]
9e58:D9E58 LDA=  X'E6FF'    ; =0xe6ff =59135(-6401) [Load A with immediate]
9e5b:      DMA   SCT,A      ; [Store A register to DMA count register]
9e5d:      LDA=  X'011C'    ; =0x011c =284 [Load A with immediate]
9e60:      DMA   SAD,A      ; [Store A register to DMA address register]
9e62:      DMA   SDV,3      ; [Set DMA device]
9e64:      DMA   EAB        ; [Enable DMA]
9e66:      LDAB= X'45'      ; =69 [Load AL with immediate]
9e68:      STAB$ X'0114'    ; =0x0114 =276 [Store AL indirect]
9e6b:      JSR$  X'0118'    ; =0x0118 =280 [Jump to subroutine indirect]
9e6e:      BNF   D9E86      ; =+22 [Branch on no fault]
9e70:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9e73:      DC    'TRACK='   ; hex:d4d2c1c3cbbd
9e79:      DB    X'00'      ; =0x00 =0 =NUL
9e7a:      LDA/  X'4152'    ; =0x4152 =16722 [Load A direct]
9e7d:      JSR$  X'0110'    ; =0x0110 =272 [Jump to subroutine indirect]
9e80:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9e83:      DW    X'8D8A'    ; =0x8d8a =36234(-29302) =CR,LF
9e85:      DB    X'00'      ; =0x00 =0 =NUL
*
9e86:D9E86 LDA/  X'4152'    ; =0x4152 =16722 [Load A direct]
9e89:      BNZ   D9E8C      ; =+1 [Branch if not zero]
9e8b:      INA              ; [Increment A]
9e8c:D9E8C SLA              ; [Left shift A]
9e8d:      STA/  X'4152'    ; =0x4152 =16722 [Store A direct]
9e90:      LDB=  X'025D'    ; =0x025d =605 [Load B with immediate]
9e93:      SAB              ; [A - B -> B]
9e94:      BLE   D9E37      ; =-95 [Branch if less than or equal to zero]
9e96:      STAB/ X'F10A'    ; =0xf10a =61706(-3830) [Store AL direct]
9e99:      JSR$  X'0104'    ; =0x0104 =260 [Jump to subroutine indirect]
9e9c:      DW    X'060B'    ; =0x060b =1547
*
*
* Function ENTRY
*
9e9e:ENTRY LDA=  X'018B'    ; =0x018b =395 [Load A with immediate]
9ea1:      ADD   Z,A        ; [Z + A -> A]
9ea3:      JSR+  A          ; [Jump to subroutine indexed, direct]
9ea5:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9ea7:      XFR   Z,Y        ; [Transfer Z to Y]
9ea9:      CLA              ; [Clear A]
9eaa:D9EAA LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
9eac:      ADDB  AL,AU      ; [AL + AU -> AU]
9eae:      LDB=  X'06ED'    ; =0x06ed =1773 [Load B with immediate]
9eb1:      ADD   Z,B        ; [Z + B -> B]
9eb3:      SUB   Y,B        ; [Y - B -> B]
9eb5:      BNZ   D9EAA      ; =-13 [Branch if not zero]
9eb7:      LDAB+ Y          ; [Load AL from address in Y]
9eb8:      SUBB  AU,AL      ; [AU - AL -> AL]
9eba:      BNZ   D9ED4      ; =+24 [Branch if not zero]
9ebc:      JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9ebf:      DW    X'8A8D'    ; =0x8a8d =35469(-30067) =LF,CR
9ec1:      DC    '*** PASS ***'
9ecd:      DB    X'00'      ; =0x00 =0 =NUL
9ece:      STAB/ X'F10A'    ; =0xf10a =61706(-3830) [Store AL direct]
9ed1:      JMP$  X'010E'    ; =0x010e =270 [Jump indirect]
9ed4:D9ED4 JSR$  X'0112'    ; =0x0112 =274 [Jump to subroutine indirect]
9ed7:      DC    '*** FAIL ***'
9ee3:      DB    X'00'      ; =0x00 =0 =NUL
9ee4:      STAB/ X'F10B'    ; =0xf10b =61707(-3829) [Store AL direct]
9ee7:      STAB/ X'F10C'    ; =0xf10c =61708(-3828) [Store AL direct]
9eea:      JMP$  X'010E'    ; =0x010e =270 [Jump indirect]
*
9eed:      DC    'E'        ; hex:c5 dec:197(-59)
9eee:      DB    X'00'      ; =0x00 =0 =NUL
9eef:      DB    0,273      ; =0x00,0x0111
a000:ENDPT
