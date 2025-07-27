 TITLE 'SMCB'
SMCB BEGIN 0
*
*
* Function ENTRY
*
8000(91005A )ENTRY LDA/  X'005A'    ; =0x005a =90 [Load A direct]
8003(5E     )      XAZ              ; [Transfer A to Z]
8004(D08017 )      LDB=  W8017      ; =0x8017 =32791(-32745) [Load B with immediate]
8007(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
8009(0C     )      DB    X'0C'      ; =0x0c =12 [Service call GIOB - get I/O block]
800a(D58803 )      LDB+  Z,3        ; [Load B indexed, displaced, direct]
800d(C52815 )      LDBB+ B,21       ; [Load BL indexed, displaced, direct]
8010(E50817 )      STBB+ A,23       ; [Store BL indexed, displaced, direct]
8013(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
8015(0A     )      DB    X'0A'      ; =0x0a =10 [Service call EXIT - exit to OJX00]
8016(FF     )      DB    X'FF'      ; =0xff =255(-1) [completion code]
8017(0000   )W8017 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8019:ENDPT
