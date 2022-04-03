8000:    00           HALT

DiagEntryPoint:
8001:    3a           clr.w! WX
8002:    b1 b8 00     st.w WX, (0xb800) ; This is the first word in Diag's 1KB of RAM
8005:    05           fci
8006:    0e           delay 4.5ms
8007:    a1 f1 4f     st.b X, (0xf14f)
800a:    a1 f2 0d     st.b X, (0xf20d)
800d:    a1 f2 0f     st.b X, (0xf20f)
8010:    90 c0 00     ld.w WX, #0xc000
8013:    5f           mov.w SP, WX ; Set stack pointer just beyond top of Diag's 1KB of RAM
8014:    22 32        cpu_id
8016:    14 0b        bz L_8023
8018:    90 80 77     ld.w WX, #0x8077
801b:    b1 00 fe     st.w WX, (0x00fe) ; This is writing a pointer directly into registers.
801e:    3a           clr.w! WX
801f:    b1 00 fc     st.w WX, (0x00fc) ; Something really funky is going on here.
8022:    76           syscall ; I assume this is calling or jumpting to that function

L_8023:
8023:    3a           clr.w! WX
8024:    a1 f1 09     st.b X, (0xf109) ; Turn Decimal Point 1 off
8027:    a1 f1 0b     st.b X, (0xf10b) ; Turn Decimal Point 2 off
802a:    a1 f1 0d     st.b X, (0xf10d) ; Turn Decimal Point 3 off
802d:    a1 f1 0f     st.b X, (0xf10f) ; Turn Decimal Point 4 off
8030:    81 f1 10     ld.b X, (0xf110) ; A = Dip swiches value
8033:    c0 0f        ld.b Z, #0x0f
8035:    42 31        and.b X, Z ; A = A & 0x0f
8037:    a1 f1 10     st.b X, (0xf110) ; Write A to hex displays
803a:    a1 f1 06     st.b X, (0xf106) ; Unblank the hex displys
803d:    c0 0d        ld.b Z, #0x0d
803f:    49           sub.b! Z, X ; Compare with 0b1011
8040:    15 03        bnz L_8045
8042:    71 87 28     jump #0x8728 AuxiliaryTestMenu ; If dipswitches == 0xb111: 
                                                     ;     Display Auxiliary Test Menu

L_8045:
8045:    c1 f1 10     ld.b Z, (0xf110)
8048:    16 b7        blt DiagEntryPoint
804a:    3d           sll.w! WX
804b:    d0 80 55     ld.w YZ, #0x8055
804e:    58           add.w! YZ, WX
804f:    99           ld.w WX, (YZ)
8050:    a1 f1 08     st.b X, (0xf108)
8053:    75 00        jump (A + 0x00)

TestFunctions:
    ; This is the table of test functions
    ; The above code indexes into it based on DIP switches
8055:    80 01        (0x8001) ; DiagEntryPoint
8057:    80 8e        (0x808e) ; Test_01
8059:    81 1b        (0x811b) ; Test_02
805b:    81 83        (0x8183) ; Test_03
805d:    81 dc        (0x81dc) ; Test_04
805f:    82 03        (0x8203) ; Test_05
8061:    82 47        (0x8247) ; MuxInterruptTest: Test06: Tests interrupts on something at Mux's MMIO ports
                               ; This machine has the 4 port MUX, which doesn't do interrupts.
                               ; But there is a 16 port "Smart" Mux that does, but DIAG is too
                               ; old to know about it. 
8063:    82 84        (0x8284) ; Test_07
8065:    82 e3        (0x82e3) ; Test_08
8067:    83 7f        (0x837f) ; HawkTest: Test_09: Tests Hawk and DMA
8069:    84 6f        (0x846f) ; TOS_Entry: TestOS: This is a Monitor that operates over serial console
806b:    85 9d        (0x859d) ; Test_0b
806d:    86 b2        (0x86b2) ; Test_0c
806f:    87 28        (0x8728) ; AuxiliaryTestMenu
8071:    80 01        (0x8001) ; DiagEntryPoint
8073:    80 01        (0x8001) ; DiagEntryPoint

L_8075:
8075:    73 8a        jump (PC-0x76) DiagEntryPoint

Fail:
    ; Takes 4 bit error code, displays ((error code << 4) | 0xf) on hex displays
8077:    2d           sll.b! X
8078:    2d           sll.b! X
8079:    2d           sll.b! X
807a:    2d           sll.b! X
807b:    c0 0f        ld.b Z, #0x0f
807d:    48           add.b! Z, X

L_807e:
807e:    e1 f1 10     st.b Z, (0xf110)
8081:    a1 f1 0c     st.b X, (0xf10c)
8084:    a1 f1 0b     st.b X, (0xf10b)
8087:    a1 f1 06     st.b X, (0xf106)
808a:    3a           clr.w! WX
808b:    71 00 00     jump #0x0000 L_0000

Test_01:
808e:    32 40        clr.w RT

L_8090:
8090:    c0 11        ld.b Z, #0x11
8092:    2f 42        dma_load_count.w RT
8094:    2f 03        dma_store_count.w WX
8096:    51 40        sub.w WX, RT
8098:    15 43        bnz L_80dd
809a:    c0 21        ld.b Z, #0x21
809c:    2f 40        dma_load_addr.w RT
809e:    2f 01        dma_store_addr.w WX
80a0:    51 40        sub.w WX, RT
80a2:    15 39        bnz L_80dd
80a4:    20 50        inc.b T
80a6:    20 40        inc.b R
80a8:    15 e6        bnz L_8090
80aa:    90 00 12     ld.w WX, #0x0012
80ad:    5c           mov.w KL, WX

L_80ae:
80ae:    55 60        mov.w WX, KL
80b0:    bb           st.w WX, (KL)
80b1:    20 70        inc.b L
80b3:    20 70        inc.b L
80b5:    15 f7        bnz L_80ae
80b7:    90 00 12     ld.w WX, #0x0012
80ba:    5c           mov.w KL, WX

L_80bb:
80bb:    80 a8        ld.b X, #0xa8
80bd:    41 71        sub.b X, L
80bf:    14 05        bz L_80c6
80c1:    9b           ld.w WX, (KL)
80c2:    51 60        sub.w WX, KL
80c4:    15 15        bnz L_80db

L_80c6:
80c6:    20 70        inc.b L
80c8:    20 70        inc.b L
80ca:    15 ef        bnz L_80bb
80cc:    a1 f1 0a     st.b X, (0xf10a)

L_80cf:
80cf:    81 f1 10     ld.b X, (0xf110)
80d2:    c0 0f        ld.b Z, #0x0f
80d4:    42 31        and.b X, Z
80d6:    29           dec.b! X
80d7:    15 9c        bnz L_8075
80d9:    73 b3        jump (PC-0x4d) Test_01

L_80db:
80db:    c0 31        ld.b Z, #0x31

L_80dd:
80dd:    7b 04        call (PC+0x04) FlashFail
80df:    73 ee        jump (PC-0x12) L_80cf

L_80e1:
80e1:    73 92        jump (PC-0x6e) L_8075

FlashFail:
    ; Takes a error code, sets the fail decimal places and flashes the error
    ; code until button is pressed (450ms on, 450ms off)
    ; continues execution
80e3:    e1 f1 10     st.b Z, (0xf110)
80e6:    a1 f1 0b     st.b X, (0xf10b)
80e9:    a1 f1 0c     st.b X, (0xf10c)
80ec:    81 f1 10     ld.b X, (0xf110)
80ef:    2d           sll.b! X
80f0:    16 20        blt L_8112
80f2:    a1 f1 07     st.b X, (0xf107)
80f5:    90 00 64     ld.w WX, #0x0064

L_80f8:
80f8:    0e           delay 4.5ms
80f9:    39           dec.w! WX
80fa:    15 fc        bnz L_80f8
80fc:    a1 f1 06     st.b X, (0xf106)
80ff:    90 00 64     ld.w WX, #0x0064

L_8102:
8102:    0e           delay 4.5ms
8103:    39           dec.w! WX
8104:    15 fc        bnz L_8102
8106:    90 0f 00     ld.w WX, #0x0f00
8109:    81 f1 10     ld.b X, (0xf110)
810c:    42 01        and.b X, W
810e:    15 d3        bnz FlashFail
8110:    73 cf        jump (PC-0x31) L_80e1

L_8112:
8112:    81 f1 10     ld.b X, (0xf110)
8115:    c0 0f        ld.b Z, #0x0f
8117:    4a           and.b! Z, X
8118:    14 c7        bz L_80e1
811a:    09           ret

Test_02:
811b:    90 81 71     ld.w WX, #0x8171
811e:    b1 00 fe     st.w WX, (0x00fe)
8121:    90 0f 00     ld.w WX, #0x0f00
8124:    81 f1 10     ld.b X, (0xf110)
8127:    42 01        and.b X, W
8129:    29           dec.b! X
812a:    29           dec.b! X
812b:    15 b4        bnz L_80e1
812d:    90 01 00     ld.w WX, #0x0100

L_8130:
8130:    5d           mov.w YZ, WX
8131:    16 06        blt L_8139
8133:    f5 01        st.w YZ, (WX)+
8135:    73 f9        jump (PC-0x07) L_8130

L_8137:
8137:    73 aa        jump (PC-0x56) FlashFail

L_8139:
8139:    90 01 00     ld.w WX, #0x0100

L_813c:
813c:    d8           ld.w YZ, (WX)
813d:    59           sub.w! YZ, WX
813e:    15 26        bnz L_8166
8140:    38           inc.w! WX
8141:    38           inc.w! WX
8142:    17 f8        ble L_813c
8144:    90 01 00     ld.w WX, #0x0100
8147:    5c           mov.w KL, WX

L_8148:
8148:    55 60        mov.w WX, KL
814a:    3b           not.w! WX
814b:    b5 61        st.w WX, (KL)+
814d:    55 66        mov.w KL, KL
814f:    17 f7        ble L_8148
8151:    90 01 00     ld.w WX, #0x0100
8154:    5c           mov.w KL, WX

L_8155:
8155:    9b           ld.w WX, (KL)
8156:    5d           mov.w YZ, WX
8157:    33 20        not.w YZ
8159:    51 62        sub.w YZ, KL
815b:    15 09        bnz L_8166
815d:    95 61        ld.w WX, (KL)+
815f:    17 f4        ble L_8155
8161:    a1 f1 0a     st.b X, (0xf10a)
8164:    73 b5        jump (PC-0x4b) Test_02

L_8166:
8166:    80 f0        ld.b X, #0xf0
8168:    42 01        and.b X, W
816a:    28           inc.b! X
816b:    28           inc.b! X
816c:    4d           mov.b! Z, X
816d:    7b c8        call (PC-0x38) L_8137
816f:    73 aa        jump (PC-0x56) Test_02

Test02_Vector:
8171:    c0 04        ld.b Z, #0x04
8173:    49           sub.b! Z, X
8174:    14 03        bz L_8179
8176:    71 80 77     jump #0x8077 Fail

L_8179:
8179:    80 f0        ld.b X, #0xf0
817b:    42 81        and.b X, M
817d:    28           inc.b! X
817e:    28           inc.b! X
817f:    4d           mov.b! Z, X
8180:    71 80 7e     jump #0x807e L_807e

Test_03:
8183:    60 00 10     ld.w RT, #0x0010

L_8186:
8186:    90 10 00     ld.w WX, #0x1000
8189:    40 50        add.b W, T
818b:    b5 48 0c     st.w WX, +0xc(RT)+
818e:    90 81 a3     ld.w WX, #0x81a3
8191:    b5 48 0e     st.w WX, +0xe(RT)+
8194:    90 00 10     ld.w WX, #0x0010
8197:    40 15        add.b T, X
8199:    15 eb        bnz L_8186
819b:    90 10 00     ld.w WX, #0x1000
819e:    55 0c        mov.w GH, WX
81a0:    0a           reti
81a1:    73 03        jump (PC+0x03) L_81a6

Test03_Vector:
81a3:    55 c4        mov.w RT, GH
81a5:    0a           reti

L_81a6:
81a6:    60 00 10     ld.w RT, #0x0010

L_81a9:
81a9:    95 48 04     ld.w WX, +0x4(RT)+
81ac:    80 f0        ld.b X, #0xf0
81ae:    42 10        and.b W, X
81b0:    45 51        mov.b X, T
81b2:    c0 10        ld.b Z, #0x10
81b4:    40 31        add.b X, Z
81b6:    41 10        sub.b W, X
81b8:    15 17        bnz L_81d1
81ba:    40 35        add.b T, Z
81bc:    15 eb        bnz L_81a9
81be:    a1 f1 0a     st.b X, (0xf10a)
81c1:    90 0f 00     ld.w WX, #0x0f00
81c4:    81 f1 10     ld.b X, (0xf110)
81c7:    42 01        and.b X, W
81c9:    29           dec.b! X
81ca:    29           dec.b! X
81cb:    29           dec.b! X
81cc:    14 b5        bz Test_03
81ce:    71 80 01     jump #0x8001 DiagEntryPoint

L_81d1:
81d1:    45 51        mov.b X, T
81d3:    28           inc.b! X
81d4:    28           inc.b! X
81d5:    28           inc.b! X
81d6:    4d           mov.b! Z, X
81d7:    79 80 e3     call #0x80e3 FlashFail
81da:    73 a7        jump (PC-0x59) Test_03

Test_04:
81dc:    80 c5        ld.b X, #0xc5
81de:    a1 f2 00     st.b X, (0xf200)

L_81e1:
81e1:    90 0f 00     ld.w WX, #0x0f00
81e4:    81 f1 10     ld.b X, (0xf110)
81e7:    42 01        and.b X, W
81e9:    29           dec.b! X
81ea:    29           dec.b! X
81eb:    29           dec.b! X
81ec:    29           dec.b! X
81ed:    14 03        bz L_81f2
81ef:    71 80 01     jump #0x8001 DiagEntryPoint

L_81f2:
81f2:    81 f2 00     ld.b X, (0xf200)
81f5:    2c           srl.b! X
81f6:    2c           srl.b! X
81f7:    11 e8        bnc L_81e1
81f9:    80 d5        ld.b X, #0xd5
81fb:    a1 f2 01     st.b X, (0xf201)
81fe:    7b 29        call (PC+0x29) CheckUart
8200:    04           fsi
8201:    73 de        jump (PC-0x22) L_81e1

Test_05:
8203:    80 c5        ld.b X, #0xc5
8205:    a1 f2 00     st.b X, (0xf200)

L_8208:
8208:    90 0f 00     ld.w WX, #0x0f00
820b:    81 f1 10     ld.b X, (0xf110)
820e:    42 01        and.b X, W
8210:    c0 05        ld.b Z, #0x05
8212:    49           sub.b! Z, X
8213:    14 03        bz L_8218
8215:    71 80 01     jump #0x8001 DiagEntryPoint

L_8218:
8218:    81 f2 00     ld.b X, (0xf200)
821b:    2c           srl.b! X
821c:    11 ea        bnc L_8208
821e:    81 f2 01     ld.b X, (0xf201)
8221:    a1 f2 01     st.b X, (0xf201)
8224:    7b 03        call (PC+0x03) CheckUart
8226:    05           fci
8227:    73 df        jump (PC-0x21) L_8208

CheckUart:
    ; Check (UART_status & 0x1c == 0); Pass/Fail
8229:    81 f2 00     ld.b X, (0xf200)
822c:    c0 1c        ld.b Z, #0x1c
822e:    4a           and.b! Z, X
822f:    15 05        bnz L_8236
8231:    a1 f1 0a     st.b X, (0xf10a)
8234:    3e           inc RT
8235:    09           ret

L_8236:
8236:    45 31        mov.b X, Z
8238:    2d           sll.b! X
8239:    2d           sll.b! X
823a:    c5 41        ld.b Z, (RT)+
823c:    48           add.b! Z, X
823d:    a1 f1 0b     st.b X, (0xf10b)
8240:    a1 f1 0c     st.b X, (0xf10c)
8243:    e1 f1 10     st.b Z, (0xf110)
8246:    09           ret

MuxInterruptTest:
    ; Test06: Tests interrupts on something at Mux's MMIO ports
    ; This machine has the 4 port MUX, which doesn't do interrupts.
    ; But there is a 16 port "Smart" Mux that does, but DIAG is too
    ; old to know about it. 
8247:    80 c5        ld.b X, #0xc5
8249:    a1 f2 00     st.b X, (0xf200)
824c:    80 06        ld.b X, #0x06
824e:    a1 f2 0a     st.b X, (0xf20a)
8251:    90 82 6f     ld.w WX, #0x826f
8254:    b1 00 6e     st.w WX, (0x006e)
8257:    3a           clr.w! WX
8258:    b1 00 6c     st.w WX, (0x006c)
825b:    04           fsi
825c:    a1 f2 0e     st.b X, (0xf20e)

L_825f:
825f:    90 0f 00     ld.w WX, #0x0f00
8262:    81 f1 10     ld.b X, (0xf110)
8265:    42 01        and.b X, W
8267:    c0 06        ld.b Z, #0x06
8269:    49           sub.b! Z, X
826a:    14 f3        bz L_825f
826c:    71 80 01     jump #0x8001 DiagEntryPoint

Test06_Vector:
826f:    81 f2 0f     ld.b X, (0xf20f)
8272:    15 0d        bnz L_8281
8274:    91 f2 00     ld.w WX, (0xf200)
8277:    a1 f2 01     st.b X, (0xf201)
827a:    91 00 0a     ld.w WX, (0x000a)
827d:    5f           mov.w SP, WX
827e:    7b a9        call (PC-0x57) CheckUart
8280:    06           fsc

L_8281:
8281:    0a           reti
8282:    73 eb        jump (PC-0x15) Test06_Vector

Test_07:
8284:    32 40        clr.w RT

L_8286:
8286:    55 46        mov.w KL, RT
8288:    45 51        mov.b X, T
828a:    a1 f1 40     st.b X, (0xf140)
828d:    28           inc.b! X
828e:    a1 f1 41     st.b X, (0xf141)
8291:    28           inc.b! X
8292:    a1 f1 42     st.b X, (0xf142)
8295:    28           inc.b! X
8296:    a1 f1 43     st.b X, (0xf143)
8299:    c1 f1 40     ld.b Z, (0xf140)
829c:    80 07        ld.b X, #0x07
829e:    4a           and.b! Z, X
829f:    42 71        and.b X, L
82a1:    49           sub.b! Z, X
82a2:    15 38        bnz L_82dc
82a4:    20 70        inc.b L
82a6:    c0 27        ld.b Z, #0x27
82a8:    81 f1 41     ld.b X, (0xf141)
82ab:    41 71        sub.b X, L
82ad:    15 2f        bnz L_82de
82af:    20 70        inc.b L
82b1:    c0 37        ld.b Z, #0x37
82b3:    81 f1 42     ld.b X, (0xf142)
82b6:    41 71        sub.b X, L
82b8:    15 24        bnz L_82de
82ba:    20 70        inc.b L
82bc:    c0 47        ld.b Z, #0x47
82be:    81 f1 43     ld.b X, (0xf143)
82c1:    41 71        sub.b X, L
82c3:    15 19        bnz L_82de
82c5:    80 0f        ld.b X, #0x0f
82c7:    c1 f1 10     ld.b Z, (0xf110)
82ca:    4a           and.b! Z, X
82cb:    80 07        ld.b X, #0x07
82cd:    49           sub.b! Z, X
82ce:    14 03        bz L_82d3
82d0:    71 80 01     jump #0x8001 DiagEntryPoint

L_82d3:
82d3:    20 50        inc.b T
82d5:    15 af        bnz L_8286
82d7:    a1 f1 0a     st.b X, (0xf10a)
82da:    73 aa        jump (PC-0x56) L_8286

L_82dc:
82dc:    c0 17        ld.b Z, #0x17

L_82de:
82de:    79 80 e3     call #0x80e3 FlashFail
82e1:    73 a3        jump (PC-0x5d) L_8286

Test_08:
82e3:    a1 f1 4d     st.b X, (0xf14d)
82e6:    32 40        clr.w RT
82e8:    90 ff ff     ld.w WX, #0xffff
82eb:    7b 52        call (PC+0x52) L_833f
82ed:    15 44        bnz L_8333

L_82ef:
82ef:    55 40        mov.w WX, RT
82f1:    3d           sll.w! WX
82f2:    3d           sll.w! WX
82f3:    3d           sll.w! WX
82f4:    3d           sll.w! WX
82f5:    7b 48        call (PC+0x48) L_833f
82f7:    15 3a        bnz L_8333
82f9:    81 f1 10     ld.b X, (0xf110)
82fc:    c0 0f        ld.b Z, #0x0f
82fe:    4a           and.b! Z, X
82ff:    80 08        ld.b X, #0x08
8301:    49           sub.b! Z, X
8302:    14 03        bz L_8307
8304:    71 80 01     jump #0x8001 DiagEntryPoint

L_8307:
8307:    3e           inc RT
8308:    3e           inc RT
8309:    90 03 2c     ld.w WX, #0x032c
830c:    51 40        sub.w WX, RT
830e:    15 df        bnz L_82ef
8310:    3f           dec RT
8311:    3f           dec RT

L_8312:
8312:    55 40        mov.w WX, RT
8314:    3d           sll.w! WX
8315:    3d           sll.w! WX
8316:    3d           sll.w! WX
8317:    3d           sll.w! WX
8318:    7b 25        call (PC+0x25) L_833f
831a:    15 17        bnz L_8333
831c:    81 f1 10     ld.b X, (0xf110)
831f:    c0 0f        ld.b Z, #0x0f
8321:    4a           and.b! Z, X
8322:    80 08        ld.b X, #0x08
8324:    49           sub.b! Z, X
8325:    14 03        bz L_832a
8327:    71 80 01     jump #0x8001 DiagEntryPoint

L_832a:
832a:    3f           dec RT
832b:    3f           dec RT
832c:    17 e4        ble L_8312
832e:    a1 f1 0a     st.b X, (0xf10a)
8331:    73 b0        jump (PC-0x50) Test_08

L_8333:
8333:    2d           sll.b! X
8334:    2d           sll.b! X
8335:    2d           sll.b! X
8336:    2d           sll.b! X
8337:    c0 08        ld.b Z, #0x08
8339:    48           add.b! Z, X
833a:    79 80 e3     call #0x80e3 FlashFail
833d:    73 a4        jump (PC-0x5c) Test_08

L_833f:
833f:    5d           mov.w YZ, WX
8340:    17 0b        ble L_834d
8342:    3a           clr.w! WX
8343:    a1 f1 40     st.b X, (0xf140)
8346:    b1 f1 41     st.w WX, (0xf141)
8349:    80 03        ld.b X, #0x03
834b:    73 09        jump (PC+0x09) L_8356

L_834d:
834d:    b1 f1 41     st.w WX, (0xf141)
8350:    2a           clr.b! X
8351:    a1 f1 40     st.b X, (0xf140)
8354:    80 02        ld.b X, #0x02

L_8356:
8356:    a1 f1 48     st.b X, (0xf148)
8359:    90 01 90     ld.w WX, #0x0190

L_835c:
835c:    d0 20 00     ld.w YZ, #0x2000
835f:    c1 f1 45     ld.b Z, (0xf145)
8362:    42 23        and.b Z, Y
8364:    15 08        bnz L_836e
8366:    0e           delay 4.5ms
8367:    39           dec.w! WX
8368:    15 f2        bnz L_835c
836a:    80 09        ld.b X, #0x09
836c:    73 05        jump (PC+0x05) L_8373

L_836e:
836e:    81 f1 44     ld.b X, (0xf144)
8371:    7b 01        call (PC+0x01) L_8374

L_8373:
8373:    09           ret

L_8374:
8374:    4d           mov.b! Z, X
8375:    15 01        bnz L_8378
8377:    09           ret

L_8378:
8378:    2a           clr.b! X

L_8379:
8379:    28           inc.b! X
837a:    24 30        srl.b Z
837c:    11 fb        bnc L_8379
837e:    09           ret

HawkTest:
    ; Test_09: Tests Hawk and DMA
837f:    a1 f1 4d     st.b X, (0xf14d)
8382:    90 ff ff     ld.w WX, #0xffff
8385:    7b b8        call (PC-0x48) L_833f
8387:    15 2a        bnz L_83b3
8389:    90 32 bf     ld.w WX, #0x32bf
838c:    b1 f1 41     st.w WX, (0xf141)
838f:    90 fe 6f     ld.w WX, #0xfe6f
8392:    2f 02        dma_load_count.w WX
8394:    90 01 00     ld.w WX, #0x0100
8397:    2f 00        dma_load_addr.w WX
8399:    2f 04        dma_set_mode 0
839b:    2f 06        dma_enable
839d:    2a           clr.b! X
839e:    a1 f1 48     st.b X, (0xf148)
83a1:    79 84 52     call #0x8452 L_8452
83a4:    c0 20        ld.b Z, #0x20
83a6:    4a           and.b! Z, X
83a7:    15 19        bnz L_83c2
83a9:    4d           mov.b! Z, X
83aa:    15 04        bnz L_83b0
83ac:    c0 a9        ld.b Z, #0xa9
83ae:    73 0d        jump (PC+0x0d) L_83bd

L_83b0:
83b0:    79 83 74     call #0x8374 L_8374

L_83b3:
83b3:    a1 f1 4d     st.b X, (0xf14d)
83b6:    2d           sll.b! X
83b7:    2d           sll.b! X
83b8:    2d           sll.b! X
83b9:    2d           sll.b! X
83ba:    c0 09        ld.b Z, #0x09
83bc:    48           add.b! Z, X

L_83bd:
83bd:    79 80 e3     call #0x80e3 FlashFail
83c0:    73 bd        jump (PC-0x43) HawkTest

L_83c2:
83c2:    90 84 67     ld.w WX, #0x8467
83c5:    b1 00 2e     st.w WX, (0x002e)
83c8:    3a           clr.w! WX
83c9:    b1 00 2c     st.w WX, (0x002c)
83cc:    a1 f1 4f     st.b X, (0xf14f)
83cf:    a1 f1 4e     st.b X, (0xf14e)
83d2:    04           fsi
83d3:    60 00 01     ld.w RT, #0x0001

L_83d6:
83d6:    d0 0f 09     ld.w YZ, #0x0f09
83d9:    81 f1 10     ld.b X, (0xf110)
83dc:    42 21        and.b X, Y
83de:    49           sub.b! Z, X
83df:    14 03        bz L_83e4
83e1:    71 80 01     jump #0x8001 DiagEntryPoint

L_83e4:
83e4:    2a           clr.b! X
83e5:    a1 00 20     st.b X, (0x0020)
83e8:    55 40        mov.w WX, RT
83ea:    79 83 3f     call #0x833f L_833f
83ed:    15 c4        bnz L_83b3
83ef:    81 00 20     ld.b X, (0x0020)
83f2:    15 04        bnz L_83f8
83f4:    c0 b9        ld.b Z, #0xb9
83f6:    73 c5        jump (PC-0x3b) L_83bd

L_83f8:
83f8:    2a           clr.b! X
83f9:    a1 00 20     st.b X, (0x0020)
83fc:    90 e6 ff     ld.w WX, #0xe6ff
83ff:    2f 02        dma_load_count.w WX
8401:    90 01 00     ld.w WX, #0x0100
8404:    2f 00        dma_load_addr.w WX
8406:    2f 06        dma_enable
8408:    2a           clr.b! X
8409:    a1 f1 48     st.b X, (0xf148)
840c:    7b 44        call (PC+0x44) L_8452
840e:    15 a0        bnz L_83b0
8410:    81 00 20     ld.b X, (0x0020)
8413:    15 04        bnz L_8419
8415:    c0 c9        ld.b Z, #0xc9
8417:    73 a4        jump (PC-0x5c) L_83bd

L_8419:
8419:    2f 03        dma_store_count.w WX
841b:    38           inc.w! WX
841c:    14 04        bz L_8422
841e:    c0 d9        ld.b Z, #0xd9

L_8420:
8420:    73 9b        jump (PC-0x65) L_83bd

L_8422:
8422:    2f 01        dma_store_addr.w WX
8424:    d0 1a 00     ld.w YZ, #0x1a00
8427:    59           sub.w! YZ, WX
8428:    14 04        bz L_842e
842a:    c0 e9        ld.b Z, #0xe9
842c:    73 8f        jump (PC-0x71) L_83bd

L_842e:
842e:    90 00 0f     ld.w WX, #0x000f
8431:    50 40        add.w WX, RT
8433:    d1 f1 41     ld.w YZ, (0xf141)
8436:    59           sub.w! YZ, WX
8437:    14 04        bz L_843d
8439:    c0 f9        ld.b Z, #0xf9
843b:    73 e3        jump (PC-0x1d) L_8420

L_843d:
843d:    35 40        sll.w RT
843f:    80 19        ld.b X, #0x19

L_8441:
8441:    0e           delay 4.5ms
8442:    29           dec.b! X
8443:    15 fc        bnz L_8441
8445:    90 40 00     ld.w WX, #0x4000
8448:    51 40        sub.w WX, RT
844a:    15 8a        bnz L_83d6
844c:    a1 f1 0a     st.b X, (0xf10a)
844f:    71 83 7f     jump #0x837f HawkTest

L_8452:
8452:    90 01 90     ld.w WX, #0x0190

L_8455:
8455:    c1 f1 44     ld.b Z, (0xf144)
8458:    24 30        srl.b Z
845a:    11 07        bnc L_8463
845c:    0e           delay 4.5ms
845d:    39           dec.w! WX
845e:    15 f5        bnz L_8455
8460:    80 09        ld.b X, #0x09
8462:    09           ret

L_8463:
8463:    81 f1 44     ld.b X, (0xf144)
8466:    09           ret

Test09_Vector:
8467:    20 00        inc.b W
8469:    a1 f1 4f     st.b X, (0xf14f)
846c:    0a           reti
846d:    73 f8        jump (PC-0x08) Test09_Vector

TOS_Entry:
    ; TestOS: This is a Monitor that operates over serial console
846f:    b5 a2        st.w WX, -(SP)
8471:    a1 f1 0a     st.b X, (0xf10a)
8474:    b1 00 10     st.w WX, (0x0010)
8477:    90 00 12     ld.w WX, #0x0012
847a:    f5 01        st.w YZ, (WX)+
847c:    6d 01        st.w RT, (WX)+
847e:    55 62        mov.w YZ, KL
8480:    f5 01        st.w YZ, (WX)+
8482:    55 82        mov.w YZ, MN
8484:    f5 01        st.w YZ, (WX)+
8486:    55 a2        mov.w YZ, SP
8488:    30 20        inc.w YZ
848a:    30 20        inc.w YZ
848c:    f5 01        st.w YZ, (WX)+
848e:    55 c2        mov.w YZ, GH
8490:    f5 01        st.w YZ, (WX)+
8492:    55 e2        mov.w YZ, IJ
8494:    f5 01        st.w YZ, (WX)+
8496:    80 c5        ld.b X, #0xc5
8498:    a1 f2 00     st.b X, (0xf200) ; Configure UART
849b:    85 a1        ld.b X, (SP)+
849d:    7b 7a        call (PC+0x7a) WriteHexByte
849f:    85 a1        ld.b X, (SP)+
84a1:    7b 76        call (PC+0x76) WriteHexByte

TOS_PromptLoop:
84a3:    c0 5c        ld.b Z, #0x5c ; ''
84a5:    7b 67        call (PC+0x67) WriteByte
84a7:    7b 57        call (PC+0x57) ReadByteWithEcho
84a9:    45 31        mov.b X, Z
84ab:    c0 4d        ld.b Z, #0x4d ; 'M'
84ad:    49           sub.b! Z, X
84ae:    14 33        bz M_Command
84b0:    c0 47        ld.b Z, #0x47 ; 'G'
84b2:    49           sub.b! Z, X
84b3:    14 0a        bz G_Command
84b5:    c0 51        ld.b Z, #0x51 ; 'Q'
84b7:    49           sub.b! Z, X
84b8:    15 e9        bnz TOS_PromptLoop
84ba:    90 80 01     ld.w WX, #0x8001 ; Start of ROM
84bd:    73 04        jump (PC+0x04) Q_Command

G_Command:
    ; Go: Takes a 
84bf:    7b 79        call (PC+0x79) ReadHexWord
84c1:    55 80        mov.w WX, MN

Q_Command:
84c3:    b1 00 20     st.w WX, (0x0020)
84c6:    d0 00 1e     ld.w YZ, #0x001e
84c9:    99           ld.w WX, (YZ)
84ca:    55 0e        mov.w IJ, WX
84cc:    95 22        ld.w WX, -(YZ)
84ce:    55 0c        mov.w GH, WX
84d0:    95 22        ld.w WX, -(YZ)
84d2:    5f           mov.w SP, WX
84d3:    95 22        ld.w WX, -(YZ)
84d5:    5e           mov.w MN, WX
84d6:    95 22        ld.w WX, -(YZ)
84d8:    5c           mov.w KL, WX
84d9:    65 22        ld.w RT, -(YZ)
84db:    d5 22        ld.w YZ, -(YZ)
84dd:    91 00 10     ld.w WX, (0x0010)
84e0:    72 00 20     jump @(0x0020) ;

M_Command:
84e3:    7b 55        call (PC+0x55) ReadHexWord
84e5:    55 86        mov.w KL, MN

L_84e7:
84e7:    8b           ld.b X, (KL)
84e8:    7b 2f        call (PC+0x2f) WriteHexByte

L_84ea:
84ea:    7b 4e        call (PC+0x4e) ReadHexWord
84ec:    45 91        mov.b X, N
84ee:    c1 bf 92     ld.b Z, (0xbf92)
84f1:    14 01        bz L_84f4
84f3:    ab           st.b X, (KL)

L_84f4:
84f4:    13 04        bnn L_84fa
84f6:    30 60        inc.w KL
84f8:    73 f0        jump (PC-0x10) L_84ea

L_84fa:
84fa:    11 a7        bnc TOS_PromptLoop
84fc:    30 60        inc.w KL
84fe:    73 e7        jump (PC-0x19) L_84e7

ReadByteWithEcho:
8500:    7b 55        call (PC+0x55) CheckForReset ; Jumps back to the start of F1 if some condition is met
8502:    81 f2 00     ld.b X, (0xf200)
8505:    2c           srl.b! X
8506:    11 f8        bnc ReadByteWithEcho
8508:    81 f2 01     ld.b X, (0xf201)
850b:    c0 7f        ld.b Z, #0x7f
850d:    4a           and.b! Z, X

WriteByte:
850e:    81 f2 00     ld.b X, (0xf200)
8511:    2c           srl.b! X
8512:    2c           srl.b! X
8513:    11 f9        bnc WriteByte
8515:    e1 f2 01     st.b Z, (0xf201)
8518:    09           ret

WriteHexByte:
8519:    7b 05        call (PC+0x05) WriteHexNibble
851b:    45 01        mov.b X, W
851d:    7b 01        call (PC+0x01) WriteHexNibble
851f:    09           ret

WriteHexNibble:
8520:    22 00        clr.b W
8522:    36 00        rrc.w WX
8524:    36 00        rrc.w WX
8526:    36 00        rrc.w WX
8528:    36 00        rrc.w WX
852a:    26 00        rrc.b W
852c:    c0 0a        ld.b Z, #0x0a
852e:    49           sub.b! Z, X
852f:    16 05        blt L_8536
8531:    c0 37        ld.b Z, #0x37

L_8533:
8533:    48           add.b! Z, X
8534:    73 d8        jump (PC-0x28) WriteByte

L_8536:
8536:    c0 30        ld.b Z, #0x30
8538:    73 f9        jump (PC-0x07) L_8533

ReadHexWord:
853a:    3a           clr.w! WX
853b:    5e           mov.w MN, WX
853c:    a1 bf 92     st.b X, (0xbf92) ; Diag SRAM

L_853f:
853f:    7b bf        call (PC-0x41) ReadByteWithEcho
8541:    7b 25        call (PC+0x25) AsciiToHexNibble
8543:    17 01        ble L_8546
8545:    09           ret

L_8546:
8546:    35 80        sll.w MN
8548:    35 80        sll.w MN
854a:    35 80        sll.w MN
854c:    35 80        sll.w MN
854e:    43 19        or.b N, X
8550:    80 01        ld.b X, #0x01
8552:    a1 bf 92     st.b X, (0xbf92)
8555:    73 e8        jump (PC-0x18) L_853f

CheckForReset:
8557:    80 0f        ld.b X, #0x0f
8559:    c1 f1 10     ld.b Z, (0xf110)
855c:    4a           and.b! Z, X
855d:    80 0a        ld.b X, #0x0a
855f:    49           sub.b! Z, X
8560:    15 01        bnz L_8563
8562:    09           ret

L_8563:
8563:    71 80 01     jump #0x8001 DiagEntryPoint

WriteByteTramp:
8566:    73 a6        jump (PC-0x5a) WriteByte

AsciiToHexNibble:
8568:    45 31        mov.b X, Z
856a:    c0 30        ld.b Z, #0x30
856c:    49           sub.b! Z, X
856d:    16 13        blt L_8582
856f:    c0 47        ld.b Z, #0x47
8571:    49           sub.b! Z, X
8572:    17 1e        ble L_8592
8574:    c0 40        ld.b Z, #0x40
8576:    4a           and.b! Z, X
8577:    14 04        bz L_857d
8579:    c0 09        ld.b Z, #0x09
857b:    40 31        add.b X, Z

L_857d:
857d:    c0 0f        ld.b Z, #0x0f
857f:    42 31        and.b X, Z
8581:    09           ret

L_8582:
8582:    c0 20        ld.b Z, #0x20
8584:    49           sub.b! Z, X
8585:    15 02        bnz L_8589
8587:    2b           not.b! X
8588:    09           ret

L_8589:
8589:    c0 2c        ld.b Z, #0x2c
858b:    49           sub.b! Z, X
858c:    15 04        bnz L_8592
858e:    02           fsn
858f:    07           fcc
8590:    2b           not.b! X
8591:    09           ret

L_8592:
8592:    c0 0a        ld.b Z, #0x0a ; '\n'
8594:    7b d0        call (PC-0x30) WriteByteTramp
8596:    c0 7f        ld.b Z, #0x7f ; This is the ascii DEL charater
8598:    7b cc        call (PC-0x34) WriteByteTramp
859a:    2a           clr.b! X
859b:    2b           not.b! X
859c:    09           ret

Test_0b:
859d:    a1 f2 0d     st.b X, (0xf20d)
85a0:    a1 f1 4d     st.b X, (0xf14d)
85a3:    a1 f1 0a     st.b X, (0xf10a)
85a6:    80 c5        ld.b X, #0xc5
85a8:    a4 7a        st.b X, @(PC+0x7a)
85aa:    80 8c        ld.b X, #0x8c
85ac:    a1 f2 01     st.b X, (0xf201)
85af:    0e           delay 4.5ms
85b0:    0e           delay 4.5ms

L_85b1:
85b1:    7b 70        call (PC+0x70) WriteString
85b3:    "D=\0"
85b6:    7b 7c        call (PC+0x7c) ReadChar
85b8:    c0 c8        ld.b Z, #0xc8
85ba:    49           sub.b! Z, X
85bb:    e5 a2        st.b Z, -(SP)
85bd:    14 05        bz L_85c4
85bf:    c0 c6        ld.b Z, #0xc6
85c1:    49           sub.b! Z, X
85c2:    15 4e        bnz L_8612

L_85c4:
85c4:    7b 6e        call (PC+0x6e) ReadChar
85c6:    c0 50        ld.b Z, #0x50
85c8:    40 31        add.b X, Z
85ca:    16 46        blt L_8612
85cc:    c5 a1        ld.b Z, (SP)+
85ce:    14 7d        bz L_864d
85d0:    c0 03        ld.b Z, #0x03
85d2:    49           sub.b! Z, X
85d3:    18 3d        bgt L_8612
85d5:    d0 0f 00     ld.w YZ, #0x0f00
85d8:    f5 a2        st.w YZ, -(SP)
85da:    32 20        clr.w YZ
85dc:    f5 a2        st.w YZ, -(SP)
85de:    c0 88        ld.b Z, #0x88
85e0:    e5 a2        st.b Z, -(SP)
85e2:    d0 83 00     ld.w YZ, #0x8300
85e5:    f5 a2        st.w YZ, -(SP)
85e7:    d0 81 00     ld.w YZ, #0x8100
85ea:    06           fsc

L_85eb:
85eb:    27 30        rlc.b Z
85ed:    29           dec.b! X
85ee:    17 fb        ble L_85eb
85f0:    f5 a2        st.w YZ, -(SP)
85f2:    2f 14        dma_set_mode 1
85f4:    2f 06        dma_enable
85f6:    2f a0        dma_load_addr.w SP
85f8:    90 ff f6     ld.w WX, #0xfff6
85fb:    2f 02        dma_load_count.w WX
85fd:    7b 22        call (PC+0x22) L_8621
85ff:    43 90        or.b W, N
8601:    01           nop
8602:    00           HALT
8603:    2f 00        dma_load_addr.w WX
8605:    90 f0 ff     ld.w WX, #0xf0ff
8608:    2f 02        dma_load_count.w WX
860a:    7b 7e        call (PC+0x7e) L_868a
860c:    45 15        mov.b T, X
860e:    03           fcn

L_860f:
860f:    71 01 03     jump #0x0103 L_0103

L_8612:
8612:    7b 0f        call (PC+0x0f) WriteString
8614:    "\r\nERROR\r\n\0"
861e:    07           fcc
861f:    73 90        jump (PC-0x70) L_85b1

L_8621:
8621:    73 67        jump (PC+0x67) L_868a

WriteString:
8623:    81 f2 00     ld.b X, (0xf200)
8626:    2c           srl.b! X
8627:    2c           srl.b! X
8628:    11 f9        bnc WriteString
862a:    85 41        ld.b X, (RT)+
862c:    15 01        bnz L_862f
862e:    09           ret

L_862f:
862f:    a1 f2 01     st.b X, (0xf201)
8632:    73 ef        jump (PC-0x11) WriteString

ReadChar:
8634:    7b 6d        call (PC+0x6d) L_86a3
8636:    84 ec        ld.b X, @(PC-0x14)
8638:    2c           srl.b! X
8639:    11 f9        bnc ReadChar
863b:    84 f3        ld.b X, @(PC-0xd)
863d:    c0 80        ld.b Z, #0x80
863f:    43 31        or.b X, Z
8641:    c0 e0        ld.b Z, #0xe0
8643:    49           sub.b! Z, X
8644:    16 04        blt L_864a
8646:    c0 df        ld.b Z, #0xdf
8648:    42 31        and.b X, Z

L_864a:
864a:    a4 e4        st.b X, @(PC-0x1c)
864c:    09           ret

L_864d:
864d:    c0 07        ld.b Z, #0x07
864f:    49           sub.b! Z, X
8650:    18 c0        bgt L_8612
8652:    a1 f1 40     st.b X, (0xf140)
8655:    94 2d        ld.w WX, @(PC+0x2d)
8657:    d0 00 10     ld.w YZ, #0x0010
865a:    5a           and.w! YZ, WX
865b:    14 b5        bz L_8612
865d:    3a           clr.w! WX
865e:    b1 f1 41     st.w WX, (0xf141)
8661:    7b 35        call (PC+0x35) L_8698
8663:    03           fcn

L_8664:
8664:    94 1e        ld.w WX, @(PC+0x1e)
8666:    d0 04 00     ld.w YZ, #0x0400
8669:    5a           and.w! YZ, WX
866a:    15 a6        bnz L_8612
866c:    d0 00 20     ld.w YZ, #0x0020
866f:    5a           and.w! YZ, WX
8670:    14 f2        bz L_8664
8672:    2f 04        dma_set_mode 0
8674:    2f 06        dma_enable
8676:    90 01 00     ld.w WX, #0x0100
8679:    2f 00        dma_load_addr.w WX
867b:    90 ea 1f     ld.w WX, #0xea1f
867e:    2f 02        dma_load_count.w WX
8680:    7b 16        call (PC+0x16) L_8698
8682:    00           HALT
8683:    81 f1 44     ld.b X, (0xf144)
8686:    15 8a        bnz L_8612
8688:    73 85        jump (PC-0x7b) L_860f

L_868a:
868a:    85 41        ld.b X, (RT)+
868c:    a1 f8 00     st.b X, (0xf800)

L_868f:
868f:    81 f8 01     ld.b X, (0xf801)
8692:    29           dec.b! X
8693:    15 fa        bnz L_868f
8695:    84 f6        ld.b X, @(PC-0xa)
8697:    09           ret

L_8698:
8698:    85 41        ld.b X, (RT)+
869a:    a1 f1 48     st.b X, (0xf148)

L_869d:
869d:    84 e5        ld.b X, @(PC-0x1b)
869f:    2c           srl.b! X
86a0:    10 fb        bc L_869d
86a2:    09           ret

L_86a3:
86a3:    80 0f        ld.b X, #0x0f
86a5:    c1 f1 10     ld.b Z, (0xf110)
86a8:    4a           and.b! Z, X
86a9:    80 0b        ld.b X, #0x0b
86ab:    49           sub.b! Z, X
86ac:    15 01        bnz L_86af
86ae:    09           ret

L_86af:
86af:    71 80 01     jump #0x8001 DiagEntryPoint

Test_0c:
86b2:    d0 0f 0c     ld.w YZ, #0x0f0c
86b5:    81 f1 10     ld.b X, (0xf110)
86b8:    42 21        and.b X, Y
86ba:    49           sub.b! Z, X
86bb:    14 03        bz L_86c0
86bd:    71 80 01     jump #0x8001 DiagEntryPoint

L_86c0:
86c0:    60 80 00     ld.w RT, #0x8000
86c3:    3a           clr.w! WX

L_86c4:
86c4:    85 41        ld.b X, (RT)+
86c6:    40 10        add.b W, X
86c8:    d0 87 f9     ld.w YZ, #0x87f9
86cb:    51 42        sub.w YZ, RT
86cd:    15 f5        bnz L_86c4
86cf:    8a           ld.b X, (RT)
86d0:    41 01        sub.b X, W
86d2:    15 49        bnz L_871d
86d4:    90 b8 00     ld.w WX, #0xb800
86d7:    5b           or.w! YZ, WX
86d8:    5c           mov.w KL, WX
86d9:    d0 04 00     ld.w YZ, #0x0400

L_86dc:
86dc:    a8           st.b X, (WX)
86dd:    38           inc.w! WX
86de:    31 20        dec.w YZ
86e0:    15 fa        bnz L_86dc
86e2:    d0 04 00     ld.w YZ, #0x0400

L_86e5:
86e5:    8a           ld.b X, (RT)
86e6:    41 51        sub.b X, T
86e8:    15 3a        bnz L_8724
86ea:    3e           inc RT
86eb:    31 20        dec.w YZ
86ed:    15 f6        bnz L_86e5
86ef:    d0 04 00     ld.w YZ, #0x0400
86f2:    55 64        mov.w RT, KL

L_86f4:
86f4:    45 51        mov.b X, T
86f6:    2b           not.b! X
86f7:    a5 41        st.b X, (RT)+
86f9:    31 20        dec.w YZ
86fb:    15 f7        bnz L_86f4
86fd:    d0 04 00     ld.w YZ, #0x0400
8700:    55 64        mov.w RT, KL

L_8702:
8702:    8a           ld.b X, (RT)
8703:    2b           not.b! X
8704:    41 51        sub.b X, T
8706:    15 1c        bnz L_8724
8708:    3e           inc RT
8709:    31 20        dec.w YZ
870b:    15 f5        bnz L_8702
870d:    a1 f1 0c     st.b X, (0xf10c)
8710:    a1 f1 0a     st.b X, (0xf10a)
8713:    a1 f1 0e     st.b X, (0xf10e)
8716:    80 88        ld.b X, #0x88
8718:    a1 f1 10     st.b X, (0xf110)
871b:    73 95        jump (PC-0x6b) Test_0c

L_871d:
871d:    c0 1c        ld.b Z, #0x1c

L_871f:
871f:    79 80 e3     call #0x80e3 FlashFail
8722:    73 8e        jump (PC-0x72) Test_0c

L_8724:
8724:    c0 2c        ld.b Z, #0x2c
8726:    73 f7        jump (PC-0x09) L_871f

AuxiliaryTestMenu:
8728:    a1 f1 08     st.b X, (0xf108)
872b:    80 c5        ld.b X, #0xc5
872d:    a1 f2 00     st.b X, (0xf200)
8730:    0e           delay 4.5ms
8731:    79 86 23     call #0x8623 WriteString
8734:    "\x0c\x1b\x1cAUXILIARY TESTS\r\n\n\0"
874a:    60 88 00     ld.w RT, #0x8800
874d:    3a           clr.w! WX
874e:    5c           mov.w KL, WX

Aux_ReadTestEntry:
874f:    95 41        ld.w WX, (RT)+
8751:    19 21        ble NextRom
8753:    d0 07 ff     ld.w YZ, #0x07ff
8756:    59           sub.w! YZ, WX
8757:    18 1b        bgt NextRom
8759:    30 60        inc.w KL
875b:    d0 f8 00     ld.w YZ, #0xf800
875e:    52 42        and.w YZ, RT
8760:    50 20        add.w WX, YZ
8762:    b5 a2        st.w WX, -(SP)
8764:    55 60        mov.w WX, KL
8766:    79 85 19     call #0x8519 WriteHexByte ; Print the Test Number
8769:    c0 bd        ld.b Z, #0xbd ; '='

Aux_PrintTestName:
876b:    79 85 0e     call #0x850e WriteByte ; Print('=')
876e:    c5 41        ld.b Z, (RT)+
8770:    15 f9        bnz Aux_PrintTestName ; Print the Test Name
8772:    73 db        jump (PC-0x25) Aux_ReadTestEntry

NextRom:
8774:    d0 f8 00     ld.w YZ, #0xf800
8777:    52 24        and.w RT, YZ
8779:    90 08 00     ld.w WX, #0x0800
877c:    50 04        add.w RT, WX
877e:    90 f0 00     ld.w WX, #0xf000
8781:    51 40        sub.w WX, RT
8783:    15 ca        bnz Aux_ReadTestEntry
8785:    79 86 23     call #0x8623 WriteString
8788:    "\r\nENTER TEST NUMBER:\0"
879d:    32 40        clr.w RT

Aux_CheckDIPs:
    ; If the DIPs are nolonger configured for the Auxiliary Test Menu, then
    ; jump back to start of DIAG
879f:    80 0f        ld.b X, #0x0f
87a1:    c1 f1 10     ld.b Z, (0xf110) ; Read DIP switches
87a4:    4a           and.b! Z, X
87a5:    80 0d        ld.b X, #0x0d
87a7:    49           sub.b! Z, X
87a8:    14 03        bz Aux_CheckSerial
87aa:    71 80 01     jump #0x8001 DiagEntryPoint

Aux_CheckSerial:
87ad:    81 f2 00     ld.b X, (0xf200)
87b0:    2c           srl.b! X
87b1:    11 ec        bnc Aux_CheckDIPs
87b3:    c1 f2 01     ld.b Z, (0xf201)
87b6:    80 5f        ld.b X, #0x5f
87b8:    41 31        sub.b X, Z
87ba:    19 03        ble Aux_GotByte
87bc:    80 df        ld.b X, #0xdf
87be:    4a           and.b! Z, X

Aux_GotByte:
87bf:    e1 f2 01     st.b Z, (0xf201) ; Echo Testnum back to terminal
87c2:    79 85 68     call #0x8568 AsciiToHexNibble ; Convert to hex; Since there aren't many tests, this counts as convert to interger
87c5:    16 0c        blt L_87d3
87c7:    35 40        sll.w RT
87c9:    35 40        sll.w RT
87cb:    35 40        sll.w RT
87cd:    35 40        sll.w RT
87cf:    43 15        or.b T, X
87d1:    73 cc        jump (PC-0x34) Aux_CheckDIPs

L_87d3:
87d3:    55 40        mov.w WX, RT
87d5:    18 03        bgt L_87da

L_87d7:
87d7:    71 87 28     jump #0x8728 AuxiliaryTestMenu

L_87da:
87da:    51 60        sub.w WX, KL
87dc:    16 f9        blt L_87d7
87de:    55 40        mov.w WX, RT
87e0:    3d           sll.w! WX
87e1:    3b           not.w! WX
87e2:    38           inc.w! WX
87e3:    d0 c0 00     ld.w YZ, #0xc000
87e6:    50 20        add.w WX, YZ
87e8:    98           ld.w WX, (WX)
87e9:    55 2a        mov.w SP, YZ
87eb:    60 80 01     ld.w RT, #0x8001
87ee:    d0 f8 00     ld.w YZ, #0xf800
87f1:    5a           and.w! YZ, WX
87f2:    55 28        mov.w MN, YZ
87f4:    a1 f1 0e     st.b X, (0xf10e)
87f7:    75 00        jump (A + 0x00)
87f9:    3e
87fa:    00
87fb:    00
87fc:    00
87fd:    00
87fe:    00
87ff:    00
