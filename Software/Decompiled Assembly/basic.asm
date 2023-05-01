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
*
* Function ENTRY
*
3000:ENTRY JSR/  F493C      ; =0x493c =18748 [Jump to subroutine direct]
3003:W3003 LDX=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load X with immediate]
3006:      LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
3008:      STAB+ X,41       ; [Store AL indexed, displaced, direct]
300b:D300B LDAB/ B36AC      ; =0x36ac =13996 [Load AL direct]
300e:      BZ    D301D      ; =+13 [Branch if zero]
3010:      JSR/  F42B7      ; =0x42b7 =17079 [Jump to subroutine direct]
3013:      DB    X'07'      ; =0x07 =7
3014:      LDAB+ X,41       ; [Load AL indexed, displaced, direct]
3017:      DCAB             ; [Decrement AL]
3018:      STAB+ X,41       ; [Store AL indexed, displaced, direct]
301b:      BNZ   D300B      ; =-18 [Branch if not zero]
301d:D301D CLAB             ; [Clear AL]
301e:      DCAB             ; [Decrement AL]
301f:      STAB/ B36AC      ; =0x36ac =13996 [Store AL direct]
3022:      JSR/  F337B      ; =0x337b =13179 [Jump to subroutine direct]
3025:      CLA              ; [Clear A]
3026:      JSR/  F41F9      ; =0x41f9 =16889 [Jump to subroutine direct]
3029:      DW    X'0900'    ; =0x0900 =2304
302b:      DB    X'03'      ; =0x03 =3
302c:      JMP/  W3644      ; =0x3644 =13892 [Jump direct]
*
* Function F302F
*
302f:F302F STK   A,4        ; [Push A B to the stack]
3031:      LDAB/ X'0141'    ; =0x0141 =321 [Load AL direct]
3034:      BZ    D303A      ; =+4 [Branch if zero]
3036:      JSR/  F42B7      ; =0x42b7 =17079 [Jump to subroutine direct]
3039:      DB    X'07'      ; =0x07 =7
*
303a:D303A POP   A,4        ; [Pop B A from the stack]
303c:      RSR              ; [Return from subroutine]
*
* Function F303D
*
303d:F303D STX-  S-         ; [Store X indexed, pre-decremented, direct]
303f:      LDX/  W3003+1    ; =0x3004 =12292 [Load X direct]
3042:      LDB=  X'1000'    ; =0x1000 =4096 [Load B with immediate]
3045:      NAB              ; [A & B -> B]
3046:      BNZ   D305B      ; =+19 [Branch if not zero]
3048:      LDB=  X'2000'    ; =0x2000 =8192 [Load B with immediate]
304b:      NAB              ; [A & B -> B]
304c:      BNZ   D3069      ; =+27 [Branch if not zero]
304e:      JSR/  F31B5      ; =0x31b5 =12725 [Jump to subroutine direct]
3051:      LDB+  X,4        ; [Load B indexed, displaced, direct]
3054:      AAB              ; [A + B -> B]
3055:      JSR   F3078      ; =+33 [Jump to subroutine relative]
3057:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
3059:      CLAB             ; [Clear AL]
305a:      RSR              ; [Return from subroutine]
*
305b:D305B ORE   B,A        ; [B ^ A -> A]
305d:      SLA              ; [Left shift A]
305e:      LDB+  X,6        ; [Load B indexed, displaced, direct]
3061:      AAB              ; [A + B -> B]
3062:      JSR   F3078      ; =+20 [Jump to subroutine relative]
3064:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
3066:      LDAB= X'01'      ; =1 [Load AL with immediate]
3068:      RSR              ; [Return from subroutine]
*
3069:D3069 ORE   B,A        ; [B ^ A -> A]
306b:      SLR   A,2        ; [Left shift A by 2]
306d:      LDB+  X,8        ; [Load B indexed, displaced, direct]
3070:      AAB              ; [A + B -> B]
3071:      JSR   F3078      ; =+5 [Jump to subroutine relative]
3073:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
3075:      LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
3077:      RSR              ; [Return from subroutine]
*
* Function F3078
*
3078:F3078 SUB=  X'7FFF',B,P ; =0x7fff =32767 [32767 - B -> P]
307c:      BL    D3086      ; =+8 [Branch on link]
307e:      STK   B,2        ; [Push B to the stack]
3080:      AAB              ; [A + B -> B]
3081:      BL    D3086      ; =+3 [Branch on link]
3083:      POP   B,2        ; [Pop B from the stack]
3085:      RSR              ; [Return from subroutine]
*
3086:D3086 JSR/  F35BA      ; =0x35ba =13754 [Jump to subroutine direct]
3089:      DB    X'08'      ; =0x08 =8
*
*
* Function F308A
*
308a:F308A JSR   F3096      ; =+10 [Jump to subroutine relative]
308c:      MVF   (4)/W3632,/W3638 ; =0x3632 =13874,=0x3638 =13880 [Move fixed-length, direct, direct]
3093:      JSR   F3096      ; =+1 [Jump to subroutine relative]
3095:      RSR              ; [Return from subroutine]
*
* Function F3096
*
3096:F3096 LDAB+ Z          ; [Load AL from address in Z]
3097:      BP    D30A1      ; =+8 [Branch on plus]
3099:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
309b:      JSR/  F3168      ; =0x3168 =12648 [Jump to subroutine direct]
309e:      DW    W3632      ; =0x3632 =13874
30a0:      RSR              ; [Return from subroutine]
*
30a1:D30A1 JSR/  F3470      ; =0x3470 =13424 [Jump to subroutine direct]
30a4:      JSR   F3104      ; =+94 [Jump to subroutine relative]
30a6:      BZ    D30AD      ; =+5 [Branch if zero]
30a8:      JSR/  F33B3      ; =0x33b3 =13235 [Jump to subroutine direct]
30ab:      JMP   D30B0      ; =+3 [Jump relative]
30ad:D30AD JSR/  F33F3      ; =0x33f3 =13299 [Jump to subroutine direct]
30b0:D30B0 STK   X,6        ; [Push X Y Z to the stack]
30b2:      LDA/  W3003+1    ; =0x3004 =12292 [Load A direct]
30b5:      XAY              ; [Transfer A to Y]
30b6:      LDA=  S33E2      ; =0x33e2 =13282 [Load A with immediate]
30b9:      XAZ              ; [Transfer A to Z]
30ba:      LDX+  Y,57       ; [Load X indexed, displaced, direct]
30bd:      JSR/  F335B      ; =0x335b =13147 [Jump to subroutine direct]
30c0:D30C0 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
30c2:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
30c4:      SABB             ; [AL - BL -> BL]
30c5:      BZ    D30CB      ; =+4 [Branch if zero]
30c7:      STAB+ X+         ; [Store AL indexed, direct, post-incremented]
30c9:      JMP   D30C0      ; =-11 [Jump relative]
30cb:D30CB LDAB/ B33E1      ; =0x33e1 =13281 [Load AL direct]
30ce:      BZ    D30D2      ; =+2 [Branch if zero]
30d0:      STAB+ X+         ; [Store AL indexed, direct, post-incremented]
30d2:D30D2 LDA+  Y,57       ; [Load A indexed, displaced, direct]
30d5:      STA/  W3634      ; =0x3634 =13876 [Store A direct]
30d8:      SUB   X,A        ; [X - A -> A]
30da:      STA/  W3632      ; =0x3632 =13874 [Store A direct]
30dd:      STX+  Y,57       ; [Store X indexed, displaced, direct]
30e0:      POP   X,6        ; [Pop Z Y X from the stack]
30e2:      RSR              ; [Return from subroutine]
*
* Function F30E3
*
30e3:F30E3 JSR   F30EC      ; =+7 [Jump to subroutine relative]
30e5:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
30e7:      JSR   F30EC      ; =+3 [Jump to subroutine relative]
30e9:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
30eb:      RSR              ; [Return from subroutine]
*
* Function F30EC
*
30ec:F30EC LDAB+ Z          ; [Load AL from address in Z]
30ed:      BP    D30F9      ; =+10 [Branch on plus]
30ef:      JSR   F3096      ; =-91 [Jump to subroutine relative]
30f1:      JSR/  F31F5      ; =0x31f5 =12789 [Jump to subroutine direct]
30f4:      DW    W3632      ; =0x3632 =13874
*
30f6:D30F6 LDA+  Y+         ; [Load A indexed, direct, post-incremented]
30f8:      RSR              ; [Return from subroutine]
*
30f9:D30F9 JSR   F3104      ; =+9 [Jump to subroutine relative]
30fb:      BGZ   D30F6      ; =-7 [Branch if greater than zero]
30fd:      JSR/  F31A0      ; =0x31a0 =12704 [Jump to subroutine direct]
3100:      DW    W3632      ; =0x3632 =13874
3102:      JMP   D30F6      ; =-14 [Jump relative]
*
* Function F3104
*
3104:F3104 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
3106:      BZ    D3116      ; =+14 [Branch if zero]
3108:      BM    D310B      ; =+1 [Branch on minus]
310a:      RSR              ; [Return from subroutine]
*
310b:D310B JSR   F3168      ; =+91 [Jump to subroutine relative]
310d:      DW    W3632      ; =0x3632 =13874
*
310f:      JSR/  F31FB      ; =0x31fb =12795 [Jump to subroutine direct]
3112:      DW    W3632      ; =0x3632 =13874
3114:      CLAB             ; [Clear AL]
3115:      RSR              ; [Return from subroutine]
*
3116:D3116 JSR   F3140      ; =+40 [Jump to subroutine relative]
3118:      DW    W3632      ; =0x3632 =13874
311a:      CLAB             ; [Clear AL]
311b:      RSR              ; [Return from subroutine]
*
* Function F311C
*
311c:F311C JSR   F3104      ; =-26 [Jump to subroutine relative]
311e:      BZ    D3124      ; =+4 [Branch if zero]
3120:      JSR   F3190      ; =+110 [Jump to subroutine relative]
3122:      DW    W3632      ; =0x3632 =13874
*
3124:D3124 RSR              ; [Return from subroutine]
*
* Function F3125
*
3125:F3125 JSR   F3104      ; =-35 [Jump to subroutine relative]
3127:      BGZ   D3134      ; =+11 [Branch if greater than zero]
3129:      MVF   (6)/W3632,/W3638 ; =0x3632 =13874,=0x3638 =13880 [Move fixed-length, direct, direct]
3130:D3130 JSR   F311C      ; =-22 [Jump to subroutine relative]
3132:      CLAB             ; [Clear AL]
3133:      RSR              ; [Return from subroutine]
*
3134:D3134 LDAB+ Z          ; [Load AL from address in Z]
3135:      BGZ   D313D      ; =+6 [Branch if greater than zero]
3137:      JSR   F3190      ; =+87 [Jump to subroutine relative]
3139:      DW    W3638      ; =0x3638 =13880
313b:      JMP   D3130      ; =-13 [Jump relative]
313d:D313D LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
313f:      RSR              ; [Return from subroutine]
*
* Function F3140
*
3140:F3140 LDB+  X+         ; [Load B indexed, direct, post-incremented]
3142:      STK   X,2        ; [Push X to the stack]
3144:      LDX/  W3003+1    ; =0x3004 =12292 [Load X direct]
3147:      LDA+  X,55       ; [Load A indexed, displaced, direct]
314a:      MVF   (6)-A,-B   ; [Move fixed-length, indexed, indexed]
314e:      INR   A,6        ; [Increment A by 6]
3150:D3150 STA+  X,55       ; [Store A indexed, displaced, direct]
3153:      POP   X,2        ; [Pop X from the stack]
3155:      RSR              ; [Return from subroutine]
*
* Function F3156
*
3156:F3156 LDB+  X+         ; [Load B indexed, direct, post-incremented]
*
* Function F3158
*
3158:F3158 STK   X,2        ; [Push X to the stack]
315a:      LDX/  W3003+1    ; =0x3004 =12292 [Load X direct]
315d:      LDA+  X,55       ; [Load A indexed, displaced, direct]
3160:      DCR   A,6        ; [Decrement A by 6]
3162:      MVF   (6)-B,-A   ; [Move fixed-length, indexed, indexed]
3166:      JMP   D3150      ; =-24 [Jump relative]
*
* Function F3168
*
3168:F3168 LDB+  X+         ; [Load B indexed, direct, post-incremented]
316a:      STK   X,2        ; [Push X to the stack]
316c:      LDX/  W3003+1    ; =0x3004 =12292 [Load X direct]
316f:      LDA+  X,53       ; [Load A indexed, displaced, direct]
3172:      DCR   A,4        ; [Decrement A by 4]
3174:      MVF   (4)-A,-B   ; [Move fixed-length, indexed, indexed]
3178:D3178 STA+  X,53       ; [Store A indexed, displaced, direct]
317b:      POP   X,2        ; [Pop X from the stack]
317d:      RSR              ; [Return from subroutine]
*
* Function F317E
*
317e:F317E LDB+  X+         ; [Load B indexed, direct, post-incremented]
*
* Function F3180
*
3180:F3180 STK   X,2        ; [Push X to the stack]
3182:      LDX/  W3003+1    ; =0x3004 =12292 [Load X direct]
3185:      LDA+  X,53       ; [Load A indexed, displaced, direct]
3188:      MVF   (4)-B,-A   ; [Move fixed-length, indexed, indexed]
318c:      INR   A,4        ; [Increment A by 4]
318e:      JMP   D3178      ; =-24 [Jump relative]
*
* Function F3190
*
3190:F3190 LDB+  X+         ; [Load B indexed, direct, post-incremented]
3192:      ZAD   -Y(2),-B(6) ; [Zero-add bignum, indexed, indexed]
3196:      INR   Y,2        ; [Increment Y by 2]
3198:      M     =1000000,-B(6) ; [Multiply bignums, literal=0x0f4240, indexed]
319f:      RSR              ; [Return from subroutine]
*
* Function F31A0
*
31a0:F31A0 LDB+  X+         ; [Load B indexed, direct, post-incremented]
31a2:      D     =1000000,-B(6) ; [Divide bignums, literal=0x0f4240, indexed]
31a9:      DCR   Y,2        ; [Decrement Y by 2]
31ab:      ZAD   -B(6),-Y(2) ; [Zero-add bignum, indexed, indexed]
31af:      BNF   D31B4      ; =+3 [Branch on no fault]
31b1:      JSR/  F32DA      ; =0x32da =13018 [Jump to subroutine direct]
31b4:D31B4 RSR              ; [Return from subroutine]
*
* Function F31B5
*
31b5:F31B5 STB-  S-         ; [Store B indexed, pre-decremented, direct]
31b7:      SLA              ; [Left shift A]
31b8:      XAB              ; [Transfer A to B]
31b9:      SLA              ; [Left shift A]
31ba:      ADD   B,A        ; [B + A -> A]
31bc:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
31be:      RSR              ; [Return from subroutine]
*
* Function F31BF
*
31bf:F31BF LDB+  X+         ; [Load B indexed, direct, post-incremented]
31c1:      STK   X,6        ; [Push X Y Z to the stack]
31c3:      LDA/  W3003+1    ; =0x3004 =12292 [Load A direct]
31c6:      XAY              ; [Transfer A to Y]
31c7:      LDX+  B+         ; [Load X indexed, direct, post-incremented]
31c9:      BLE   D31F2      ; =+39 [Branch if less than or equal to zero]
31cb:      LDA+  B          ; [Load A from address in B]
31cc:      XAZ              ; [Transfer A to Z]
31cd:      SUB=  X'7FFF',Z,P ; =0x7fff =32767 [32767 - Z -> P]
31d1:      BNL   D31D6      ; =+3 [Branch on no link]
31d3:D31D3 JMP/  D3086      ; =0x3086 =12422 [Jump direct]
31d6:D31D6 ADD   X,A        ; [X + A -> A]
31d8:      BL    D31D3      ; =-7 [Branch on link]
31da:      LDA+  Y,57       ; [Load A indexed, displaced, direct]
31dd:      STA+  B          ; [Store A to address in B]
31de:      ADD   X,A        ; [X + A -> A]
31e0:      LDB+  Y          ; [Load B from address in Y]
31e1:      SAB              ; [A - B -> B]
31e2:      BP    D31F2      ; =+14 [Branch on plus]
31e4:      LDB+  Y,57       ; [Load B indexed, displaced, direct]
31e7:      XFR   X,A        ; [Transfer X to A]
31e9:      DCA              ; [Decrement A]
31ea:      MVFR  -Z,-B      ; [Move fixed-length (len in AL), indexed, indexed]
31ed:      ADD   X,B        ; [X + B -> B]
31ef:      STB+  Y,57       ; [Store B indexed, displaced, direct]
31f2:D31F2 POP   X,6        ; [Pop Z Y X from the stack]
31f4:      RSR              ; [Return from subroutine]
*
* Function F31F5
*
31f5:F31F5 LDB+  X+         ; [Load B indexed, direct, post-incremented]
31f7:      LDAB= X'01'      ; =1 [Load AL with immediate]
31f9:      JMP   D31FE      ; =+3 [Jump relative]
*
* Function F31FB
*
31fb:F31FB LDB+  X+         ; [Load B indexed, direct, post-incremented]
31fd:      CLAB             ; [Clear AL]
31fe:D31FE STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
3200:      STK   Z,2        ; [Push Z to the stack]
3202:      LDA+  B+         ; [Load A indexed, direct, post-incremented]
3204:      LDB+  B          ; [Load B from address in B]
3205:      XFR   B,Z        ; [Transfer B to Z]
3207:      AAB              ; [A + B -> B]
3208:      LDAB+ B          ; [Load AL from address in B]
3209:      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
320b:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
320d:      CLAB             ; [Clear AL]
320e:      STAB+ B          ; [Store AL to address in B]
320f:      JSR/  F335B      ; =0x335b =13147 [Jump to subroutine direct]
3212:      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
3214:      BNZ   D321A      ; =+4 [Branch if not zero]
3216:      JSR   F323C      ; =+36 [Jump to subroutine relative]
3218:      JMP   D321D      ; =+3 [Jump relative]
321a:D321A JSR/  F32E7      ; =0x32e7 =13031 [Jump to subroutine direct]
321d:D321D LDB+  S+         ; [Load B indexed, direct, post-incremented]
321f:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
3221:      STAB+ B          ; [Store AL to address in B]
3222:      POP   Z,2        ; [Pop Z from the stack]
3224:      RSR              ; [Return from subroutine]
*
* Function F3225
*
3225:F3225 CLAB             ; [Clear AL]
3226:      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
3228:      LDAB+ Z          ; [Load AL from address in Z]
3229:      LDBB= X'AB'      ; =171(-85) ='+' [Load BL with immediate]
322b:      SABB             ; [AL - BL -> BL]
322c:      BZ    D3234      ; =+6 [Branch if zero]
322e:      LDBB= X'AD'      ; =173(-83) ='-' [Load BL with immediate]
3230:      SABB             ; [AL - BL -> BL]
3231:      BNZ   D3239      ; =+6 [Branch if not zero]
3233:      STAB+ S          ; [Store AL to address in S]
3234:D3234 INR   Z          ; [Increment Z by 1]
3236:      JSR/  F335B      ; =0x335b =13147 [Jump to subroutine direct]
3239:D3239 LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
323b:      RSR              ; [Return from subroutine]
*
* Function F323C
*
323c:F323C FIL   (6)=X'00',/W3632 ; =0x3632 =13874 [Fill with byte, literal=0, direct]
3242:      FIL   (6)=X'00',/W363E ; =0x363e =13886 [Fill with byte, literal=0, direct]
3248:      JSR   F3225      ; =-37 [Jump to subroutine relative]
324a:      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
324c:P324C JSR/  F331B      ; =0x331b =13083 [Jump to subroutine direct]
324f:      DW    W3632      ; =0x3632 =13874
3251:      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
3253:      LDBB= X'09'      ; =9 [Load BL with immediate]
3255:      SABB             ; [AL - BL -> BL]
3256:      BM    D325B      ; =+3 [Branch on minus]
3258:      JSR/  F32DA      ; =0x32da =13018 [Jump to subroutine direct]
325b:D325B M     =1000000,/W3632(6) ; =0x3632 =13874 [Multiply bignums, literal=0x0f4240, direct]
3263:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
3265:      LDBB= X'AE'      ; =174(-82) ='.' [Load BL with immediate]
3267:      SABB             ; [AL - BL -> BL]
3268:      BZ    D326E      ; =+4 [Branch if zero]
326a:      DCR   Z          ; [Decrement Z by 1]
326c:      JMP   D32BD      ; =+79 [Jump relative]
326e:D326E JSR*  P324C+1    ; =-35 [Jump to subroutine relative indirect]
3270:      DW    W363E      ; =0x363e =13886
3272:      LDBB+ S          ; [Load BL from address in S]
3273:      AABB             ; [AL + BL -> BL]
3274:      STBB+ S          ; [Store BL to address in S]
3275:      LDBB= X'06'      ; =6 [Load BL with immediate]
3277:      SABB             ; [AL - BL -> BL]
3278:      BZ    D32B6      ; =+60 [Branch if zero]
327a:      BGZ   D329B      ; =+31 [Branch if greater than zero]
327c:      IVRB  BL         ; [Invert BL]
327e:      INRB  BL         ; [Increment BL by 1]
3280:      CLRB  BU         ; [Clear BU]
3282:      CLA              ; [Clear A]
3283:      STA   W32D6      ; =+81 [Store A relative]
3285:      INA              ; [Increment A]
3286:      STA   W32D8      ; =+80 [Store A relative]
3288:D3288 M     =10,/W32D6(4) ; =0x32d6 =13014 [Multiply bignums, literal=0x0a, direct]
328e:      DCR   B          ; [Decrement B by 1]
3290:      BGZ   D3288      ; =-10 [Branch if greater than zero]
3292:      M     /W32D6(4),/W363E(6) ; =0x32d6 =13014,=0x363e =13886 [Multiply bignums, direct, direct]
3299:      JMP   D32B6      ; =+27 [Jump relative]
329b:D329B JSR   F32DA      ; =+61 [Jump to subroutine relative]
329d:      CLRB  BU         ; [Clear BU]
329f:      CLA              ; [Clear A]
32a0:      STA   W32D6      ; =+52 [Store A relative]
32a2:      INA              ; [Increment A]
32a3:      STA   W32D8      ; =+51 [Store A relative]
32a5:D32A5 M     =10,/W32D6(4) ; =0x32d6 =13014 [Multiply bignums, literal=0x0a, direct]
32ab:      DCR   B          ; [Decrement B by 1]
32ad:      BGZ   D32A5      ; =-10 [Branch if greater than zero]
32af:      D     /W32D6(4),/W363E(6) ; =0x32d6 =13014,=0x363e =13886 [Divide bignums, direct, direct]
32b6:D32B6 A     /W363E(6),/W3632(6) ; =0x363e =13886,=0x3632 =13874 [Add bignums, direct, direct]
32bd:D32BD LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
32bf:      BGZ   D32C3      ; =+2 [Branch if greater than zero]
32c1:      JSR   F32DA      ; =+23 [Jump to subroutine relative]
32c3:D32C3 JSR/  F3225      ; =0x3225 =12837 [Jump to subroutine direct]
32c6:      LDBB+ S+         ; [Load BL indexed, direct, post-incremented]
32c8:      AABB             ; [AL + BL -> BL]
32c9:      BZ    D32D2      ; =+7 [Branch if zero]
32cb:      ZSU   /W3632(6),/W3632(6) ; =0x3632 =13874,=0x3632 =13874 [Zero-subtract bignum, direct, direct]
32d2:D32D2 JSR/  F335B      ; =0x335b =13147 [Jump to subroutine direct]
32d5:      RSR              ; [Return from subroutine]
*
32d6:W32D6 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
32d8:W32D8 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
*
* Function F32DA
*
32da:F32DA STK   A,4        ; [Push A B to the stack]
32dc:      CLR   A,1        ; [Set A to 1]
32de:      LDB/  W3003+1    ; =0x3004 =12292 [Load B direct]
32e1:      STAB+ B,61       ; [Store AL indexed, displaced, direct]
32e4:      POP   A,4        ; [Pop B A from the stack]
32e6:      RSR              ; [Return from subroutine]
*
* Function F32E7
*
32e7:F32E7 CLA              ; [Clear A]
32e8:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
32ea:      JSR/  F3225      ; =0x3225 =12837 [Jump to subroutine direct]
32ed:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
32ef:      JSR   F3344      ; =+83 [Jump to subroutine relative]
32f1:      BM    D3313      ; =+32 [Branch on minus]
32f3:D32F3 STBB+ S          ; [Store BL to address in S]
32f4:      LDA+  Y          ; [Load A from address in Y]
32f5:      MUL=  X'000A',A  ; =0x000a =10 [10 * A -> A,B]
32f9:      BF    D3313      ; =+24 [Branch on fault]
32fb:      CLA              ; [Clear A]
32fc:      LDAB+ S          ; [Load AL from address in S]
32fd:      AAB              ; [A + B -> B]
32fe:      BF    D3313      ; =+19 [Branch on fault]
3300:      STB+  Y          ; [Store B to address in Y]
3301:      JSR   F3344      ; =+65 [Jump to subroutine relative]
3303:      BP    D32F3      ; =-18 [Branch on plus]
3305:D3305 JSR/  F3225      ; =0x3225 =12837 [Jump to subroutine direct]
3308:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
330a:      AABB             ; [AL + BL -> BL]
330b:      BZ    D32D2      ; =-59 [Branch if zero]
330d:      LDA+  Y          ; [Load A from address in Y]
330e:      IVA              ; [Invert A]
330f:      INA              ; [Increment A]
3310:      STA+  Y          ; [Store A to address in Y]
3311:      JMP   D32D2      ; =-65 [Jump relative]
3313:D3313 JSR   F3344      ; =+47 [Jump to subroutine relative]
3315:      BP    D3313      ; =-4 [Branch on plus]
3317:      JSR   F32DA      ; =-63 [Jump to subroutine relative]
3319:      JMP   D3305      ; =-22 [Jump relative]
*
* Function F331B
*
331b:F331B LDA+  X+         ; [Load A indexed, direct, post-incremented]
331d:      STK   X,4        ; [Push X Y to the stack]
331f:      XAY              ; [Transfer A to Y]
3320:      CLA              ; [Clear A]
3321:      XAX              ; [Transfer A to X]
3322:D3322 JSR   F3344      ; =+32 [Jump to subroutine relative]
3324:      BP    D332B      ; =+5 [Branch on plus]
3326:      XFR   X,A        ; [Transfer X to A]
3328:      POP   X,4        ; [Pop Y X from the stack]
332a:      RSR              ; [Return from subroutine]
*
332b:D332B M     =10,-Y(6)  ; [Multiply bignums, literal=0x0a, indexed]
3330:      BNF   D3334      ; =+2 [Branch on no fault]
3332:      JSR   F32DA      ; =-90 [Jump to subroutine relative]
3334:D3334 STBB  B3343      ; =+13 [Store BL relative]
3336:      A     /B3343(1),-Y(6) ; =0x3343 =13123, [Add bignums, direct, indexed]
333c:      BNF   D3340      ; =+2 [Branch on no fault]
333e:      JSR   F32DA      ; =-102 [Jump to subroutine relative]
3340:D3340 INX              ; [Increment X]
3341:      JMP   D3322      ; =-33 [Jump relative]
*
3343:B3343 DB    X'00'      ; =0x00 =0 =NUL
*
*
* Function F3344
*
3344:F3344 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
3346:      JSR   F334F      ; =+7 [Jump to subroutine relative]
3348:      BP    D334E      ; =+4 [Branch on plus]
334a:      DCR   Z          ; [Decrement Z by 1]
334c:      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
334e:D334E RSR              ; [Return from subroutine]
*
* Function F334F
*
334f:F334F LDBB= X'B9'      ; =185(-71) ='9' [Load BL with immediate]
3351:      SABB             ; [AL - BL -> BL]
3352:      BLE   D3357      ; =+3 [Branch if less than or equal to zero]
3354:      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
3356:      RSR              ; [Return from subroutine]
*
3357:D3357 LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
3359:      SABB             ; [AL - BL -> BL]
335a:      RSR              ; [Return from subroutine]
*
* Function F335B
*
335b:F335B LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
335d:D335D LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
335f:      SABB             ; [AL - BL -> BL]
3360:      BZ    D335D      ; =-5 [Branch if zero]
3362:      DCR   Z          ; [Decrement Z by 1]
3364:      RSR              ; [Return from subroutine]
*
* Function F3365
*
3365:F3365 LDB/  W3003+1    ; =0x3004 =12292 [Load B direct]
3368:      LDA+  B,25       ; [Load A indexed, displaced, direct]
336b:      STA   W3379      ; =+12 [Store A relative]
336d:      CLA              ; [Clear A]
336e:      LDAB+ B,22       ; [Load AL indexed, displaced, direct]
3371:      LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
3373:      STBB  B3378      ; =+3 [Store BL relative]
3375:      JSR/  F41F9      ; =0x41f9 =16889 [Jump to subroutine direct]
3378:B3378 DB    X'00'      ; =0x00 =0 =NUL
3379:W3379 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
*
* Function F337B
*
337b:F337B STX-  S-         ; [Store X indexed, pre-decremented, direct]
337d:      LDX/  W3003+1    ; =0x3004 =12292 [Load X direct]
3380:      LDB+  X,25       ; [Load B indexed, displaced, direct]
3383:      CLA              ; [Clear A]
3384:      STA+  B+         ; [Store A indexed, direct, post-incremented]
3386:      LDA+  X,32       ; [Load A indexed, displaced, direct]
3389:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
338b:      DCA              ; [Decrement A]
338c:      FILR  =' ',-B    ; [Fill with byte (len in AL), literal=0xa0(160,-96), indexed]
3390:      RSR              ; [Return from subroutine]
*
* Function F3391
*
3391:F3391 JSR/  F30EC      ; =0x30ec =12524 [Jump to subroutine direct]
3394:      CLRB  AU         ; [Clear AU]
3396:      XABB             ; [Transfer AL to BL]
3397:      BGZ   D339B      ; =+2 [Branch if greater than zero]
3399:D3399 CLAB             ; [Clear AL]
339a:      RSR              ; [Return from subroutine]
*
339b:D339B LDB/  W3003+1    ; =0x3004 =12292 [Load B direct]
339e:      LDBB+ B,29       ; [Load BL indexed, displaced, direct]
33a1:      SABB             ; [AL - BL -> BL]
33a2:      BP    D3399      ; =-11 [Branch on plus]
33a4:      RSR              ; [Return from subroutine]
*
* Function F33A5
*
33a5:F33A5 STA-  S-         ; [Store A indexed, pre-decremented, direct]
33a7:      SLR   A,3        ; [Left shift A by 3]
33a9:      LDB/  W3003+1    ; =0x3004 =12292 [Load B direct]
33ac:      LDB+  B,30       ; [Load B indexed, displaced, direct]
33af:      AAB              ; [A + B -> B]
33b0:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
33b2:      RSR              ; [Return from subroutine]
*
* Function F33B3
*
33b3:F33B3 JSR   F33D7      ; =+34 [Jump to subroutine relative]
33b5:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
33b7:      JSR/  F4E42      ; =0x4e42 =20034 [Jump to subroutine direct]
33ba:      DW    S33EA      ; =0x33ea =13290
33bc:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
33be:      LDX=  S33E2      ; =0x33e2 =13282 [Load X with immediate]
33c1:      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
33c3:D33C3 LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
33c5:      SABB             ; [AL - BL -> BL]
33c6:      BZ    D33C3      ; =-5 [Branch if zero]
33c8:      LDBB- X-         ; [Load BL indexed, pre-decremented, direct]
33ca:      LDAB= X'AD'      ; =173(-83) ='-' [Load AL with immediate]
33cc:      SABB             ; [AL - BL -> BL]
33cd:      BNZ   D33D4      ; =+5 [Branch if not zero]
33cf:      STAB  B33E1      ; =+16 [Store AL relative]
33d1:      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
33d3:      STAB+ X          ; [Store AL to address in X]
33d4:D33D4 LDX+  S+         ; [Load X indexed, direct, post-incremented]
33d6:      RSR              ; [Return from subroutine]
*
* Function F33D7
*
33d7:F33D7 FIL   (17)=' ',/S33E2 ; =0x33e2 =13282 [Fill with byte, literal=0xa0(160,-96), direct]
33dd:      CLAB             ; [Clear AL]
33de:      STAB  B33E1      ; =+1 [Store AL relative]
33e0:      RSR              ; [Return from subroutine]
*
33e1:B33E1 DB    X'00'      ; =0x00 =0 =NUL
33e2:S33E2 DC    '        ' ; hex:a0a0a0a0a0a0a0a0
33ea:S33EA DC    ' '        ; hex:a0 dec:160(-96)
33eb:S33EB DC    '.      '  ; hex:aea0a0a0a0a0a0
33f2:S33F2 DC    ' '        ; hex:a0 dec:160(-96)
*
*
* Function F33F3
*
33f3:F33F3 JSR   F33D7      ; =-30 [Jump to subroutine relative]
33f5:      XFR   Z,A        ; [Transfer Z to A]
33f7:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
33f9:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
33fb:      LDA/  W3632      ; =0x3632 =13874 [Load A direct]
33fe:      BP    D340B      ; =+11 [Branch on plus]
3400:      LDAB= X'AD'      ; =173(-83) ='-' [Load AL with immediate]
3402:      STAB  B33E1      ; =-35 [Store AL relative]
3404:      ZSU   /W3632(6),/W3632(6) ; =0x3632 =13874,=0x3632 =13874 [Zero-subtract bignum, direct, direct]
340b:D340B ZAD   /W3632(6),/W3632(6) ; =0x3632 =13874,=0x3632 =13874 [Zero-add bignum, direct, direct]
3412:      BNZ   D341E      ; =+10 [Branch if not zero]
3414:      LDAB= X'B0'      ; =176(-80) ='0' [Load AL with immediate]
3416:      STAB  S33EA      ; =-46 [Store AL relative]
3418:D3418 LDX+  S+         ; [Load X indexed, direct, post-incremented]
341a:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
341c:      XAZ              ; [Transfer A to Z]
341d:      RSR              ; [Return from subroutine]
*
341e:D341E LDA=  S33F2      ; =0x33f2 =13298 [Load A with immediate]
3421:      XAZ              ; [Transfer A to Z]
3422:      LDX=  X'0006'    ; =0x0006 =6 [Load X with immediate]
3425:D3425 LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
3427:      DCX              ; [Decrement X]
3428:      BM    D3440      ; =+22 [Branch on minus]
342a:      JSR   F344F      ; =+35 [Jump to subroutine relative]
342c:      LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
342e:      SABB             ; [AL - BL -> BL]
342f:      BNZ   D3435      ; =+4 [Branch if not zero]
3431:      DCR   Z          ; [Decrement Z by 1]
3433:      JMP   D3425      ; =-16 [Jump relative]
3435:D3435 STAB- Z-         ; [Store AL indexed, pre-decremented, direct]
3437:      DCX              ; [Decrement X]
3438:      BM    D343E      ; =+4 [Branch on minus]
343a:      JSR   F344F      ; =+19 [Jump to subroutine relative]
343c:      JMP   D3435      ; =-9 [Jump relative]
343e:D343E LDAB= X'AE'      ; =174(-82) ='.' [Load AL with immediate]
3440:D3440 STAB- Z-         ; [Store AL indexed, pre-decremented, direct]
3442:      ZAD   /W3632(6),/W3632(6) ; =0x3632 =13874,=0x3632 =13874 [Zero-add bignum, direct, direct]
3449:      BZ    D3418      ; =-51 [Branch if zero]
344b:      JSR   F344F      ; =+2 [Jump to subroutine relative]
344d:      JMP   D3440      ; =-15 [Jump relative]
*
* Function F344F
*
344f:F344F LDA=  W3458+1    ; =0x3459 =13401 [Load A with immediate]
3452:      DRM   =10,/W3632(6) ; =0x3632 =13874 [Divide bignums with remainder, literal=0x0a, direct]
3458:W3458 LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
345a:      LDAB= X'B0'      ; =176(-80) ='0' [Load AL with immediate]
345c:      ADDB  BL,AL      ; [BL + AL -> AL]
345e:      RSR              ; [Return from subroutine]
*
* Function F345F
*
345f:F345F STX-  S-         ; [Store X indexed, pre-decremented, direct]
3461:      LDX/  W3003+1    ; =0x3004 =12292 [Load X direct]
3464:      LDB+  X,32       ; [Load B indexed, displaced, direct]
3467:      SAB              ; [A - B -> B]
3468:      BLE   D346D      ; =+3 [Branch if less than or equal to zero]
346a:      LDA+  X,32       ; [Load A indexed, displaced, direct]
346d:D346D LDX+  S+         ; [Load X indexed, direct, post-incremented]
346f:      RSR              ; [Return from subroutine]
*
* Function F3470
*
3470:F3470 JSR   F3494      ; =+34 [Jump to subroutine relative]
3472:      BGZ   D3475      ; =+1 [Branch if greater than zero]
3474:D3474 RSR              ; [Return from subroutine]
*
3475:D3475 LDB/  W3003+1    ; =0x3004 =12292 [Load B direct]
3478:      LDA+  B,10       ; [Load A indexed, displaced, direct]
347b:      STA+  B,57       ; [Store A indexed, displaced, direct]
347e:      JSR   F34A7      ; =+39 [Jump to subroutine relative]
3480:      JSR   F3494      ; =+18 [Jump to subroutine relative]
3482:      BLE   D3474      ; =-16 [Branch if less than or equal to zero]
3484:      JSR/  F42B7      ; =0x42b7 =17079 [Jump to subroutine direct]
3487:      DB    X'59'      ; =0x59 =89
3488:      LDA/  W3003+1    ; =0x3004 =12292 [Load A direct]
348b:      A     =2048,-A,0(2) ; [Add bignums, literal=0x0800, displaced indexed]
3492:      JMP   D3474      ; =-32 [Jump relative]
*
* Function F3494
*
3494:F3494 STX-  S-         ; [Store X indexed, pre-decremented, direct]
3496:      LDX/  W3003+1    ; =0x3004 =12292 [Load X direct]
3499:      LDA+  X          ; [Load A from address in X]
349a:      LDB+  X,57       ; [Load B indexed, displaced, direct]
349d:      SAB              ; [A - B -> B]
349e:      LDA+  X,32       ; [Load A indexed, displaced, direct]
34a1:      INR   A,3        ; [Increment A by 3]
34a3:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
34a5:      SAB              ; [A - B -> B]
34a6:      RSR              ; [Return from subroutine]
*
* Function F34A7
*
34a7:F34A7 STK   X,6        ; [Push X Y Z to the stack]
34a9:J34A9 JSR/  F302F      ; =0x302f =12335 [Jump to subroutine direct]
34ac:      LDX/  W3003+1    ; =0x3004 =12292 [Load X direct]
34af:      LDA+  X,8        ; [Load A indexed, displaced, direct]
34b2:      XAY              ; [Transfer A to Y]
34b3:      LDA+  X          ; [Load A from address in X]
34b4:      XAZ              ; [Transfer A to Z]
34b5:D34B5 LDA+  X,53       ; [Load A indexed, displaced, direct]
34b8:      SUB   Y,A        ; [Y - A -> A]
34ba:      BP    D34E4      ; =+40 [Branch on plus]
34bc:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
34be:      BGZ   D34CA      ; =+10 [Branch if greater than zero]
34c0:      BZ    D34C6      ; =+4 [Branch if zero]
34c2:      IVA              ; [Invert A]
34c3:      STA+  Y,-2       ; [Store A indexed, displaced, direct]
34c6:D34C6 LDA+  Y+         ; [Load A indexed, direct, post-incremented]
34c8:      JMP   D34B5      ; =-21 [Jump relative]
34ca:D34CA LDA+  Y+         ; [Load A indexed, direct, post-incremented]
34cc:      LDB+  X,57       ; [Load B indexed, displaced, direct]
34cf:      SAB              ; [A - B -> B]
34d0:      BM    D34B5      ; =-29 [Branch on minus]
34d2:      LDB+  X          ; [Load B from address in X]
34d3:      SAB              ; [A - B -> B]
34d4:      BGZ   D34B5      ; =-33 [Branch if greater than zero]
34d6:      XAB              ; [Transfer A to B]
34d7:      SUB   Z,B        ; [Z - B -> B]
34d9:      BLE   D34B5      ; =-38 [Branch if less than or equal to zero]
34db:      XAZ              ; [Transfer A to Z]
34dc:      LDB+  Y,-4       ; [Load B indexed, displaced, direct]
34df:      AAB              ; [A + B -> B]
34e0:      STB   W350A+2    ; =+42 [Store B relative]
34e2:      JMP   D34B5      ; =-47 [Jump relative]
34e4:D34E4 LDA+  X          ; [Load A from address in X]
34e5:      SUB   Z,A        ; [Z - A -> A]
34e7:      BNZ   D34EC      ; =+3 [Branch if not zero]
34e9:      POP   X,6        ; [Pop Z Y X from the stack]
34eb:      RSR              ; [Return from subroutine]
*
34ec:D34EC LDA   W350A+2    ; =+30 [Load A relative]
34ee:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
34f0:      JSR/  F302F      ; =0x302f =12335 [Jump to subroutine direct]
34f3:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
34f5:      STA   W350A+2    ; =+21 [Store A relative]
34f7:      LDA+  X,53       ; [Load A indexed, displaced, direct]
34fa:      XAY              ; [Transfer A to Y]
34fb:D34FB LDA+  X,8        ; [Load A indexed, displaced, direct]
34fe:      SUB   Y,A        ; [Y - A -> A]
3500:      BLE   D3534      ; =+50 [Branch if less than or equal to zero]
3502:      LDA-  Y-         ; [Load A indexed, pre-decremented, direct]
3504:      XAB              ; [Transfer A to B]
3505:      SUB   Z,B        ; [Z - B -> B]
3507:      BGZ   D3510      ; =+7 [Branch if greater than zero]
3509:      XAB              ; [Transfer A to B]
350a:W350A SUB=  X'0000',B  ; =0x0000 =0 =NUL,NUL [0 - B -> B]
350e:      BP    D3514      ; =+4 [Branch on plus]
3510:D3510 LDA-  Y-         ; [Load A indexed, pre-decremented, direct]
3512:      JMP   D34FB      ; =-25 [Jump relative]
3514:D3514 XAB              ; [Transfer A to B]
3515:      LDA-  Y-         ; [Load A indexed, pre-decremented, direct]
3517:      BLE   D34FB      ; =-30 [Branch if less than or equal to zero]
3519:      AAB              ; [A + B -> B]
351a:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
351c:      IVA              ; [Invert A]
351d:      STA+  Y+         ; [Store A indexed, direct, post-incremented]
351f:      LDB+  X,57       ; [Load B indexed, displaced, direct]
3522:      SUB   Z,B        ; [Z - B -> B]
3524:      LDA+  Y          ; [Load A from address in Y]
3525:      SAB              ; [A - B -> B]
3526:      STB+  Y          ; [Store B to address in Y]
3527:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
3529:      XAB              ; [Transfer A to B]
352a:      SUB/  W350A+2,B  ; =0x350c =13580 [Direct - B -> B]
352e:      BP    D3510      ; =-32 [Branch on plus]
3530:      STA   W350A+2    ; =-38 [Store A relative]
3532:      JMP   D34EC      ; =-72 [Jump relative]
3534:D3534 LDA+  X,57       ; [Load A indexed, displaced, direct]
3537:      XAY              ; [Transfer A to Y]
3538:      XFR   Z,A        ; [Transfer Z to A]
353a:      SUB/  W350A+2,A  ; =0x350c =13580 [Direct - A -> A]
353e:      DCA              ; [Decrement A]
353f:      XFR   Z,B        ; [Transfer Z to B]
3541:      MVL              ; [Move long (len in A, src in B, dst in Y)]
3542:      INA              ; [Increment A]
3543:      ADD   Y,A        ; [Y + A -> A]
3545:      STA+  X,57       ; [Store A indexed, displaced, direct]
3548:      JMP/  J34A9      ; =0x34a9 =13481 [Jump direct]
*
* Function F354B
*
354b:F354B STK   X,6        ; [Push X Y Z to the stack]
354d:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
354f:      LDX/  W3003+1    ; =0x3004 =12292 [Load X direct]
3552:      LDA+  X,4        ; [Load A indexed, displaced, direct]
3555:      XAZ              ; [Transfer A to Z]
3556:      LDX+  X,2        ; [Load X indexed, displaced, direct]
3559:D3559 XFR   X,A        ; [Transfer X to A]
355b:      SUB   Z,A        ; [Z - A -> A]
355d:      BLE   D3582      ; =+35 [Branch if less than or equal to zero]
355f:      SRA              ; [Right shift A]
3560:      LDBB= X'FC'      ; =252(-4) ='|' [Load BL with immediate]
3562:      ANDB  BL,AL      ; [BL & AL -> AL]
3564:      ADD   X,A        ; [X + A -> A]
3566:      XAY              ; [Transfer A to Y]
3567:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
3569:      LDB+  S          ; [Load B from address in S]
356a:      SAB              ; [A - B -> B]
356b:      BZ    D357B      ; =+14 [Branch if zero]
356d:      BGZ   D3575      ; =+6 [Branch if greater than zero]
356f:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
3571:      XFR   Y,X        ; [Transfer Y to X]
3573:      JMP   D3559      ; =-28 [Jump relative]
3575:D3575 LDA-  Y-         ; [Load A indexed, pre-decremented, direct]
3577:      XFR   Y,Z        ; [Transfer Y to Z]
3579:      JMP   D3559      ; =-34 [Jump relative]
357b:D357B XFR   Y,B        ; [Transfer Y to B]
357d:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
357f:      POP   X,6        ; [Pop Z Y X from the stack]
3581:      RSR              ; [Return from subroutine]
*
3582:D3582 JSR   F35BA      ; =+54 [Jump to subroutine relative]
3584:      DB    X'01'      ; =0x01 =1
*
*
* Function F3585
*
3585:F3585 STX-  S-         ; [Store X indexed, pre-decremented, direct]
3587:      LDX/  W3003+1    ; =0x3004 =12292 [Load X direct]
358a:      LDA+  X,4        ; [Load A indexed, displaced, direct]
358d:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
358f:      LDB+  X,59       ; [Load B indexed, displaced, direct]
3592:      LDX+  X,2        ; [Load X indexed, displaced, direct]
3595:W3595 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
3598:      SUB   B,A        ; [B - A -> A]
359a:D359A LDB+  S          ; [Load B from address in S]
359b:      SUB   X,B        ; [X - B -> B]
359d:      BM    D35A7      ; =+8 [Branch on minus]
359f:      LDA=  X'7FFF'    ; =0x7fff =32767 [Load A with immediate]
35a2:D35A2 LDB+  S+         ; [Load B indexed, direct, post-incremented]
35a4:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
35a6:      RSR              ; [Return from subroutine]
*
35a7:D35A7 LDB+  X+         ; [Load B indexed, direct, post-incremented]
35a9:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
35ab:      SAB              ; [A - B -> B]
35ac:      BGZ   D359A      ; =-20 [Branch if greater than zero]
35ae:      BZ    D35B5      ; =+5 [Branch if zero]
35b0:      LDA+  X,-8       ; [Load A indexed, displaced, direct]
35b3:      JMP   D35A2      ; =-19 [Jump relative]
35b5:D35B5 LDA+  X,-4       ; [Load A indexed, displaced, direct]
35b8:      JMP   D35A2      ; =-24 [Jump relative]
*
* Function F35BA
*
35ba:F35BA JSR   F35EA      ; =+46 [Jump to subroutine relative]
35bc:      STB   W35C3      ; =+5 [Store B relative]
35be:      CLA              ; [Clear A]
35bf:      LDAB+ X          ; [Load AL from address in X]
35c0:      JSR/  F4E42      ; =0x4e42 =20034 [Jump to subroutine direct]
35c3:W35C3 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
35c5:      LDB/  W3003+1    ; =0x3004 =12292 [Load B direct]
35c8:      DEC-  B,59       ; [Decrement word at B+59 by 1]
35cc:      JSR   F3585      ; =-73 [Jump to subroutine relative]
35ce:      LDB/  W3003+1    ; =0x3004 =12292 [Load B direct]
35d1:      STA+  B,12       ; [Store A indexed, displaced, direct]
35d4:      LDA+  B,39       ; [Load A indexed, displaced, direct]
35d7:      LDB=  X'C5D2'    ; =0xc5d2 =50642(-14894) ='E','R' [Load B with immediate]
35da:      STB+  A,3        ; [Store B indexed, displaced, direct]
35dd:      CLA              ; [Clear A]
35de:      JSR   F3618      ; =+56 [Jump to subroutine relative]
35e0:      CLA              ; [Clear A]
35e1:      JSR   F3601      ; =+30 [Jump to subroutine relative]
35e3:      CLA              ; [Clear A]
35e4:      DCA              ; [Decrement A]
35e5:      LDB=  X'005A'    ; =0x005a =90 [Load B with immediate]
35e8:      SVC   X'6B'      ; =107 [Service call ABRTR - abort with abort code in AL]
*
* Function F35EA
*
35ea:F35EA LDA/  W3003+1    ; =0x3004 =12292 [Load A direct]
35ed:      LDB+  A,39       ; [Load B indexed, displaced, direct]
35f0:      LDA=  X'0008'    ; =0x0008 =8 [Load A with immediate]
35f3:      STA+  B+         ; [Store A indexed, direct, post-incremented]
35f5:      DCA              ; [Decrement A]
35f6:      FILR  =' ',-B    ; [Fill with byte (len in AL), literal=0xa0(160,-96), indexed]
35fa:      AAB              ; [A + B -> B]
35fb:      LDAB= X'C0'      ; =192(-64) ='@' [Load AL with immediate]
35fd:      STAB+ B,-7       ; [Store AL indexed, displaced, direct]
3600:      RSR              ; [Return from subroutine]
*
* Function F3601
*
3601:F3601 STA-  S-         ; [Store A indexed, pre-decremented, direct]
3603:      JSR   F35EA      ; =-27 [Jump to subroutine relative]
3605:      STB   W3614      ; =+13 [Store B relative]
3607:      LDB/  W3003+1    ; =0x3004 =12292 [Load B direct]
360a:      LDA+  B,12       ; [Load A indexed, displaced, direct]
360d:      STA   W3612      ; =+3 [Store A relative]
360f:      JSR/  F4E40      ; =0x4e40 =20032 [Jump to subroutine direct]
3612:W3612 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
3614:W3614 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
3616:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
*
* Function F3618
*
3618:F3618 LDB/  W3003+1    ; =0x3004 =12292 [Load B direct]
361b:      LDB+  B,39       ; [Load B indexed, displaced, direct]
361e:      STB   W3624      ; =+4 [Store B relative]
3620:      JSR/  F41F9      ; =0x41f9 =16889 [Jump to subroutine direct]
3623:      DB    X'02'      ; =0x02 =2
3624:W3624 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
3626:      RSR              ; [Return from subroutine]
*
* Function F3627
*
3627:F3627 SLR   A,2        ; [Left shift A by 2]
3629:      LDB/  W3003+1    ; =0x3004 =12292 [Load B direct]
362c:      LDB+  B,34       ; [Load B indexed, displaced, direct]
362f:      ADD   B,A        ; [B + A -> A]
3631:      RSR              ; [Return from subroutine]
*
3632:W3632 DS    2          ; =0x0002 [Uninitialized memory]
3634:W3634 DS    1          ; =0x0001 [Uninitialized memory]
3635:W3635 DS    3          ; =0x0003 [Uninitialized memory]
3638:W3638 DS    2          ; =0x0002 [Uninitialized memory]
363a:W363A DS    4          ; =0x0004 [Uninitialized memory]
363e:W363E DS    6          ; =0x0006 [Uninitialized memory]
3644:W3644 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
3647:      BNZ   D3658      ; =+15 [Branch if not zero]
3649:      LDAB+ X,36       ; [Load AL indexed, displaced, direct]
364c:      BNZ   D3658      ; =+10 [Branch if not zero]
364e:      LDAB+ X,52       ; [Load AL indexed, displaced, direct]
3651:      BP    D3676      ; =+35 [Branch on plus]
3653:      SLAB             ; [Left shift AL]
3654:      SRAB             ; [Right shift AL]
3655:      STA+  X,37       ; [Store A indexed, displaced, direct]
3658:D3658 JSR/  F3585      ; =0x3585 =13701 [Jump to subroutine direct]
365b:      LDB+  X,12       ; [Load B indexed, displaced, direct]
365e:      SAB              ; [A - B -> B]
365f:      BZ    D3676      ; =+21 [Branch if zero]
3661:      STA+  X,12       ; [Store A indexed, displaced, direct]
3664:      LDB   W3644+1    ; =-33 [Load B relative]
3666:      BZ    D3670      ; =+8 [Branch if zero]
3668:      SAB              ; [A - B -> B]
3669:      BNZ   D3676      ; =+11 [Branch if not zero]
366b:      JSR$  X'001A'    ; =0x001a =26 [Jump to subroutine indirect]
366e:      DW    X'7306'    ; =0x7306 =29446
*
3670:D3670 LDA+  X,37       ; [Load A indexed, displaced, direct]
3673:      JSR/  F3601      ; =0x3601 =13825 [Jump to subroutine direct]
3676:D3676 CLAB             ; [Clear AL]
3677:      STAB  B36AC      ; =+51 [Store AL relative]
3679:      LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
367b:      STAB+ X,41       ; [Store AL indexed, displaced, direct]
367e:D367E JSR/  F42B7      ; =0x42b7 =17079 [Jump to subroutine direct]
3681:      DB    X'07'      ; =0x07 =7
3682:      LDAB  B36AC      ; =+40 [Load AL relative]
3684:      BZ    D368F      ; =+9 [Branch if zero]
3686:      LDAB+ X,41       ; [Load AL indexed, displaced, direct]
3689:      DCAB             ; [Decrement AL]
368a:      STAB+ X,41       ; [Store AL indexed, displaced, direct]
368d:      BNZ   D367E      ; =-17 [Branch if not zero]
368f:D368F CLAB             ; [Clear AL]
3690:      DCAB             ; [Decrement AL]
3691:      STAB  B36AC      ; =+25 [Store AL relative]
3693:      LDB+  X,59       ; [Load B indexed, displaced, direct]
3696:D3696 CLA              ; [Clear A]
3697:      LDAB+ B          ; [Load AL from address in B]
3698:      BM    D36A0      ; =+6 [Branch on minus]
369a:      LDA+  B+         ; [Load A indexed, direct, post-incremented]
369c:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
369e:      JMP   D3696      ; =-10 [Jump relative]
36a0:D36A0 SLAB             ; [Left shift AL]
36a1:      INR   B          ; [Increment B by 1]
36a3:      STB+  X,59       ; [Store B indexed, displaced, direct]
36a6:      LDB=  W410A      ; =0x410a =16650 [Load B with immediate]
36a9:      AAB              ; [A + B -> B]
36aa:      JMP+  *B         ; [Jump indexed, indirect]
*
36ac:B36AC DB    X'00'      ; =0x00 =0 =NUL
*
36ad:W36AD LDA+  *X,59      ; [Load A indexed, displaced, indirect]
36b0:      JMP   D36CE      ; =+28 [Jump relative]
36b2:W36B2 JSR/  F30EC      ; =0x30ec =12524 [Jump to subroutine direct]
36b5:      BNZ   D36BC      ; =+5 [Branch if not zero]
36b7:      LDA+  *X,59      ; [Load A indexed, displaced, indirect]
36ba:      JMP   D36CE      ; =+18 [Jump relative]
36bc:D36BC LDA+  X,59       ; [Load A indexed, displaced, direct]
36bf:      INR   A,2        ; [Increment A by 2]
36c1:      STA+  X,59       ; [Store A indexed, displaced, direct]
36c4:      JMP/  W3644      ; =0x3644 =13892 [Jump direct]
36c7:W36C7 JSR*  W36B2+1    ; =-22 [Jump to subroutine relative indirect]
36c9:      XAB              ; [Transfer A to B]
36ca:D36CA JSR/  F354B      ; =0x354b =13643 [Jump to subroutine direct]
36cd:      LDA+  B          ; [Load A from address in B]
36ce:D36CE LDB/  W3595+1    ; =0x3596 =13718 [Load B direct]
36d1:      AAB              ; [A + B -> B]
36d2:      STB+  X,59       ; [Store B indexed, displaced, direct]
36d5:      JMP/  W3644      ; =0x3644 =13892 [Jump direct]
36d8:W36D8 JSR*  W36B2+1    ; =-39 [Jump to subroutine relative indirect]
36da:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
36dc:D36DC JSR   F371F      ; =+65 [Jump to subroutine relative]
36de:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
36e0:      JMP   D36CA      ; =-24 [Jump relative]
36e2:W36E2 CLAB             ; [Clear AL]
36e3:      STAB  B36F6+1    ; =+18 [Store AL relative]
36e5:D36E5 STX-  S-         ; [Store X indexed, pre-decremented, direct]
36e7:      LDX+  X,59       ; [Load X indexed, displaced, direct]
36ea:      JSR*  W36B2+1    ; =-57 [Jump to subroutine relative indirect]
36ec:      BLE   D36FE      ; =+16 [Branch if less than or equal to zero]
36ee:      LDB+  X          ; [Load B from address in X]
36ef:      SAB              ; [A - B -> B]
36f0:      BGZ   D36FE      ; =+12 [Branch if greater than zero]
36f2:      SLA              ; [Left shift A]
36f3:      ADD   X,A        ; [X + A -> A]
36f5:      LDB+  A          ; [Load B from address in A]
36f6:B36F6 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
36f8:      BNZ   D3711      ; =+23 [Branch if not zero]
36fa:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
36fc:      JMP   D36CA      ; =-52 [Jump relative]
36fe:D36FE LDA+  X          ; [Load A from address in X]
36ff:      INA              ; [Increment A]
3700:      SLA              ; [Left shift A]
3701:      ADD   X,A        ; [X + A -> A]
3703:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
3705:      STA+  X,59       ; [Store A indexed, displaced, direct]
3708:P3708 JMP/  W3644      ; =0x3644 =13892 [Jump direct]
370b:W370B LDAB= X'01'      ; =1 [Load AL with immediate]
370d:      STAB  B36F6+1    ; =-24 [Store AL relative]
370f:      JMP   D36E5      ; =-44 [Jump relative]
3711:D3711 LDA+  S          ; [Load A from address in S]
3712:      STB+  S          ; [Store B to address in S]
3713:      XFR   X,B        ; [Transfer X to B]
3715:      XAX              ; [Transfer A to X]
3716:      LDA+  B+         ; [Load A indexed, direct, post-incremented]
3718:      SLA              ; [Left shift A]
3719:      AAB              ; [A + B -> B]
371a:      STB+  X,59       ; [Store B indexed, displaced, direct]
371d:      JMP   D36DC      ; =-67 [Jump relative]
*
* Function F371F
*
371f:F371F STX-  S-         ; [Store X indexed, pre-decremented, direct]
3721:      LDX/  W3003+1    ; =0x3004 =12292 [Load X direct]
3724:      LDAB+ X,20       ; [Load AL indexed, displaced, direct]
3727:      LDBB= X'0C'      ; =12 [Load BL with immediate]
3729:      SABB             ; [AL - BL -> BL]
372a:      BM    D3730      ; =+4 [Branch on minus]
372c:      JSR/  F35BA      ; =0x35ba =13754 [Jump to subroutine direct]
372f:      DB    X'4B'      ; =0x4b =75
*
3730:D3730 INAB             ; [Increment AL]
3731:      STAB+ X,20       ; [Store AL indexed, displaced, direct]
3734:      LDB+  X,18       ; [Load B indexed, displaced, direct]
3737:      LDA+  X,59       ; [Load A indexed, displaced, direct]
373a:      STA-  B-         ; [Store A indexed, pre-decremented, direct]
373c:      STB+  X,18       ; [Store B indexed, displaced, direct]
373f:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
3741:      RSR              ; [Return from subroutine]
*
3742:W3742 LDAB+ X,20       ; [Load AL indexed, displaced, direct]
3745:      BGZ   D374B      ; =+4 [Branch if greater than zero]
3747:      JSR/  F35BA      ; =0x35ba =13754 [Jump to subroutine direct]
374a:      DB    X'4C'      ; =0x4c =76
*
374b:D374B DCAB             ; [Decrement AL]
374c:      STAB+ X,20       ; [Store AL indexed, displaced, direct]
374f:      LDB+  X,18       ; [Load B indexed, displaced, direct]
3752:      LDA+  B+         ; [Load A indexed, direct, post-incremented]
3754:      STA+  X,59       ; [Store A indexed, displaced, direct]
3757:      STB+  X,18       ; [Store B indexed, displaced, direct]
375a:      JMP*  P3708+1    ; =-83 [Jump relative]
375c:W375C CLAB             ; [Clear AL]
375d:      STAB- Z-         ; [Store AL indexed, pre-decremented, direct]
375f:      STK   Y,4        ; [Push Y Z to the stack]
3761:      LDA/  W3003+1    ; =0x3004 =12292 [Load A direct]
3764:      XAY              ; [Transfer A to Y]
3765:      LDA+  Y,59       ; [Load A indexed, displaced, direct]
3768:      XAZ              ; [Transfer A to Z]
3769:      JSR/  F323C      ; =0x323c =12860 [Jump to subroutine direct]
376c:      JSR/  F3156      ; =0x3156 =12630 [Jump to subroutine direct]
376f:      DW    W3632      ; =0x3632 =13874
3771:      XFR   Z,A        ; [Transfer Z to A]
3773:      INA              ; [Increment A]
3774:      STA+  Y,59       ; [Store A indexed, displaced, direct]
3777:      POP   Y,4        ; [Pop Z Y from the stack]
3779:      JMP*  P3708+1    ; =-114 [Jump relative]
377b:W377B LDB/  W3003+1    ; =0x3004 =12292 [Load B direct]
377e:      LDA+  *B,59      ; [Load A indexed, displaced, indirect]
3781:      INC-  B,59,2     ; [Increment word at B+59 by 2]
3785:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
3787:      LDAB= X'01'      ; =1 [Load AL with immediate]
3789:D3789 STAB- Z-         ; [Store AL indexed, pre-decremented, direct]
378b:      JMP/  W3644      ; =0x3644 =13892 [Jump direct]
378e:W378E STK   X,2        ; [Push X to the stack]
3790:      LDX/  W3003+1    ; =0x3004 =12292 [Load X direct]
3793:      LDA+  X,59       ; [Load A indexed, displaced, direct]
3796:      LDB+  A+         ; [Load B indexed, direct, post-incremented]
3798:      STB/  W3632      ; =0x3632 =13874 [Store B direct]
379b:      STA/  W3634      ; =0x3634 =13876 [Store A direct]
379e:      AAB              ; [A + B -> B]
379f:      STB+  X,59       ; [Store B indexed, displaced, direct]
37a2:      JSR/  F317E      ; =0x317e =12670 [Jump to subroutine direct]
37a5:      DW    W3632      ; =0x3632 =13874
37a7:      POP   X,2        ; [Pop X from the stack]
37a9:      LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
37ab:      JMP   D3789      ; =-36 [Jump relative]
37ad:W37AD XFR   Y,A        ; [Transfer Y to A]
37af:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
37b1:      XFR   Z,A        ; [Transfer Z to A]
37b3:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
37b5:      LDA=  ENDPT      ; =0x4eaa =20138 [Load A with immediate]
37b8:      SRA              ; [Right shift A]
37b9:      SLA              ; [Left shift A]
37ba:      XAZ              ; [Transfer A to Z]
37bb:      LDA=  X'0100'    ; =0x0100 =256 [Load A with immediate]
37be:      XAY              ; [Transfer A to Y]
37bf:      LDB/  X'00A8'    ; =0x00a8 =168 =NUL,'(' [Load B direct]
37c2:D37C2 LDA+  Y+         ; [Load A indexed, direct, post-incremented]
37c4:      ORE   A,B        ; [A ^ B -> B]
37c6:      CL               ; [Complement link]
37c7:      RRR   B          ; [Right rotate B by 1]
37c9:      BNL   D37D0      ; =+5 [Branch on no link]
37cb:      LDA=  X'8000'    ; =0x8000 =32768(-32768) [Load A with immediate]
37ce:      ORI   A,B        ; [A | B -> B]
37d0:D37D0 XFR   Y,A        ; [Transfer Y to A]
37d2:      SUB   Z,A        ; [Z - A -> A]
37d4:      BNZ   D37C2      ; =-20 [Branch if not zero]
37d6:      LDA=  X'7FFF'    ; =0x7fff =32767 [Load A with immediate]
37d9:      NAB              ; [A & B -> B]
37da:      SUB   B,A        ; [B - A -> A]
37dc:      BNZ   D37E0      ; =+2 [Branch if not zero]
37de:      DCR   B          ; [Decrement B by 1]
37e0:D37E0 LDA+  S+         ; [Load A indexed, direct, post-incremented]
37e2:      XAZ              ; [Transfer A to Z]
37e3:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
37e5:      XAY              ; [Transfer A to Y]
37e6:      STB+  X,46       ; [Store B indexed, displaced, direct]
37e9:      JMP/  W3644      ; =0x3644 =13892 [Jump direct]
37ec:W37EC LDAB+ Z          ; [Load AL from address in Z]
37ed:      BM    D37F8      ; =+9 [Branch on minus]
37ef:      JSR/  F3104      ; =0x3104 =12548 [Jump to subroutine direct]
37f2:      BZ    D37FB      ; =+7 [Branch if zero]
37f4:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
37f6:      JMP   D37FB      ; =+3 [Jump relative]
37f8:D37F8 JSR/  F3096      ; =0x3096 =12438 [Jump to subroutine direct]
37fb:D37FB JMP/  W3644      ; =0x3644 =13892 [Jump direct]
37fe:W37FE JSR/  F3104      ; =0x3104 =12548 [Jump to subroutine direct]
3801:      BZ    D383C      ; =+57 [Branch if zero]
3803:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
3805:      DCA              ; [Decrement A]
3806:      BGZ   D3814      ; =+12 [Branch if greater than zero]
3808:      BZ    D3814      ; =+10 [Branch if zero]
380a:      INA              ; [Increment A]
380b:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
380d:      JSR/  F3190      ; =0x3190 =12688 [Jump to subroutine direct]
3810:      DW    W3632      ; =0x3632 =13874
3812:      JMP   D383C      ; =+40 [Jump relative]
3814:D3814 STX-  S-         ; [Store X indexed, pre-decremented, direct]
3816:      XAX              ; [Transfer A to X]
3817:      JSR*  W37FE+1    ; =-26 [Jump to subroutine relative indirect]
3819:      BZ    D3829      ; =+14 [Branch if zero]
381b:      LDB=  X'0001'    ; =0x0001 =1 [Load B with immediate]
381e:D381E LDA+  Y          ; [Load A from address in Y]
381f:      MUL   B,A        ; [B * A -> A,B]
3821:      DCX              ; [Decrement X]
3822:      BP    D381E      ; =-6 [Branch on plus]
3824:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
3826:      JMP/  D388E      ; =0x388e =14478 [Jump direct]
3829:D3829 MVF   (6)/W3632,/W3638 ; =0x3632 =13874,=0x3638 =13880 [Move fixed-length, direct, direct]
3830:D3830 DCX              ; [Decrement X]
3831:      BM    D3837      ; =+4 [Branch on minus]
3833:      JSR   W3865      ; =+48 [Jump to subroutine relative]
3835:      JMP   D3830      ; =-7 [Jump relative]
3837:D3837 LDX+  S+         ; [Load X indexed, direct, post-incremented]
3839:      JMP/  W3879      ; =0x3879 =14457 [Jump direct]
383c:D383C MVF   (6)/W3632,/W385F ; =0x3632 =13874,=0x385f =14431 [Move fixed-length, direct, direct]
3843:      JSR*  W37FE+1    ; =-70 [Jump to subroutine relative indirect]
3845:      BZ    D384C      ; =+5 [Branch if zero]
3847:      JSR/  F3190      ; =0x3190 =12688 [Jump to subroutine direct]
384a:      DW    W3632      ; =0x3632 =13874
*
384c:D384C JSR/  F47A4      ; =0x47a4 =18340 [Jump to subroutine direct]
384f:      DW    X'4740'    ; =0x4740 =18240
3851:      DB    X'05'      ; =0x05 =5
3852:      DW    W385F      ; =0x385f =14431
3854:      DW    W3632      ; =0x3632 =13874
3856:      DB    X'79'      ; =0x79 =121
3857:      DW    W3865      ; =0x3865 =14437
3859:      DB    X'79'      ; =0x79 =121
385a:      DW    W4862      ; =0x4862 =18530
385c:      DB    X'71'      ; =0x71 =113
385d:      DW    W3879      ; =0x3879 =14457
385f:W385F DW    W4194      ; =0x4194 =16788
3861:      DS    4          ; =0x0004 [Uninitialized memory]
*
3865:W3865 JSR/  W4194      ; =0x4194 =16788 [Jump to subroutine direct]
3868:      DW    W3632      ; =0x3632 =13874
386a:      DW    W3638      ; =0x3638 =13880
386c:      RSR              ; [Return from subroutine]
*
386d:W386D JSR/  F3125      ; =0x3125 =12581 [Jump to subroutine direct]
3870:      BGZ   D3884      ; =+18 [Branch if greater than zero]
3872:      JSR/  F41BA      ; =0x41ba =16826 [Jump to subroutine direct]
3875:      DW    W3632      ; =0x3632 =13874
3877:      DW    W3638      ; =0x3638 =13880
*
3879:W3879 JSR/  F3156      ; =0x3156 =12630 [Jump to subroutine direct]
387c:      DW    W3632      ; =0x3632 =13874
387e:      CLAB             ; [Clear AL]
387f:D387F STAB- Z-         ; [Store AL indexed, pre-decremented, direct]
3881:      JMP/  W3644      ; =0x3644 =13892 [Jump direct]
3884:D3884 LDB+  Y+         ; [Load B indexed, direct, post-incremented]
3886:      LDA+  Y          ; [Load A from address in Y]
3887:      DIV   B,A        ; [B / A -> A,B]
3889:D3889 BNF   D388E      ; =+3 [Branch on no fault]
388b:      JSR/  F41E0      ; =0x41e0 =16864 [Jump to subroutine direct]
388e:D388E STB+  Y          ; [Store B to address in Y]
388f:      LDAB= X'01'      ; =1 [Load AL with immediate]
3891:      JMP   D387F      ; =-20 [Jump relative]
3893:W3893 JSR*  W386D+1    ; =-39 [Jump to subroutine relative indirect]
3895:      BGZ   D389C      ; =+5 [Branch if greater than zero]
3897:      JSR/  W3865      ; =0x3865 =14437 [Jump to subroutine direct]
389a:      JMP   W3879      ; =-35 [Jump relative]
389c:D389C LDB+  Y+         ; [Load B indexed, direct, post-incremented]
389e:      LDA+  Y          ; [Load A from address in Y]
389f:      MUL   B,A        ; [B * A -> A,B]
38a1:      JMP   D3889      ; =-26 [Jump relative]
38a3:W38A3 JSR*  W386D+1    ; =-55 [Jump to subroutine relative indirect]
38a5:      BGZ   D38B5      ; =+14 [Branch if greater than zero]
38a7:      A     /W3638(6),/W3632(6) ; =0x3638 =13880,=0x3632 =13874 [Add bignums, direct, direct]
38ae:D38AE BNF   W3879      ; =-55 [Branch on no fault]
38b0:      JSR/  F41E0      ; =0x41e0 =16864 [Jump to subroutine direct]
38b3:      JMP   W3879      ; =-60 [Jump relative]
38b5:D38B5 LDB+  Y+         ; [Load B indexed, direct, post-incremented]
38b7:      LDA+  Y          ; [Load A from address in Y]
38b8:      AAB              ; [A + B -> B]
38b9:      JMP   D3889      ; =-50 [Jump relative]
38bb:W38BB JSR/  F3125      ; =0x3125 =12581 [Jump to subroutine direct]
38be:      BGZ   D38C9      ; =+9 [Branch if greater than zero]
38c0:      S     /W3638(6),/W3632(6) ; =0x3638 =13880,=0x3632 =13874 [Subtract bignums, direct, direct]
38c7:      JMP   D38AE      ; =-27 [Jump relative]
38c9:D38C9 LDB+  Y+         ; [Load B indexed, direct, post-incremented]
38cb:      LDA+  Y          ; [Load A from address in Y]
38cc:      SAB              ; [A - B -> B]
38cd:      JMP   D3889      ; =-70 [Jump relative]
38cf:W38CF JSR/  F3104      ; =0x3104 =12548 [Jump to subroutine direct]
38d2:      BZ    D38DA      ; =+6 [Branch if zero]
38d4:      LDA+  Y          ; [Load A from address in Y]
38d5:      IVR   A,1        ; [Negate A]
38d7:      XAB              ; [Transfer A to B]
38d8:      JMP   D3889      ; =-81 [Jump relative]
38da:D38DA ZSU   /W3632(6),/W3632(6) ; =0x3632 =13874,=0x3632 =13874 [Zero-subtract bignum, direct, direct]
38e1:      JMP   D38AE      ; =-53 [Jump relative]
38e3:W38E3 JSR/  F30E3      ; =0x30e3 =12515 [Jump to subroutine direct]
38e6:      NAB              ; [A & B -> B]
38e7:D38E7 STB-  Y-         ; [Store B indexed, pre-decremented, direct]
38e9:      LDAB= X'01'      ; =1 [Load AL with immediate]
38eb:      STAB- Z-         ; [Store AL indexed, pre-decremented, direct]
38ed:P38ED JMP/  W3644      ; =0x3644 =13892 [Jump direct]
38f0:W38F0 JSR*  W38E3+1    ; =-14 [Jump to subroutine relative indirect]
38f2:      ORE   A,B        ; [A ^ B -> B]
38f4:      JMP   D38E7      ; =-15 [Jump relative]
38f6:W38F6 JSR*  W38E3+1    ; =-20 [Jump to subroutine relative indirect]
38f8:      ORI   A,B        ; [A | B -> B]
38fa:      JMP   D38E7      ; =-21 [Jump relative]
38fc:W38FC JSR/  F30EC      ; =0x30ec =12524 [Jump to subroutine direct]
38ff:      IVA              ; [Invert A]
3900:      XAB              ; [Transfer A to B]
3901:      JMP   D38E7      ; =-28 [Jump relative]
3903:W3903 JSR*  W38FC+1    ; =-8 [Jump to subroutine relative indirect]
3905:      LDB+  Y          ; [Load B from address in Y]
3906:      AAB              ; [A + B -> B]
3907:      STB+  Y          ; [Store B to address in Y]
3908:      JMP*  P38ED+1    ; =-28 [Jump relative]
390a:W390A LDAB+ Z          ; [Load AL from address in Z]
390b:      BM    D3952      ; =+69 [Branch on minus]
390d:      JSR/  F3125      ; =0x3125 =12581 [Jump to subroutine direct]
3910:      BGZ   D3947      ; =+53 [Branch if greater than zero]
3912:      C     /W3638(6),/W3632(6) ; =0x3638 =13880,=0x3632 =13874 [Compare bignums, direct, direct]
3919:J3919 BM    D3927      ; =+12 [Branch on minus]
391b:      BZ    D3922      ; =+5 [Branch if zero]
391d:D391D JSR   F392C      ; =+13 [Jump to subroutine relative]
391f:      DB    X'04'      ; =0x04 =4
3920:      JMP*  P38ED+1    ; =-52 [Jump relative]
3922:D3922 JSR   F392C      ; =+8 [Jump to subroutine relative]
3924:      DB    X'01'      ; =0x01 =1
3925:      JMP*  P38ED+1    ; =-57 [Jump relative]
3927:D3927 JSR   F392C      ; =+3 [Jump to subroutine relative]
3929:      DB    X'02'      ; =0x02 =2
392a:      JMP*  P38ED+1    ; =-62 [Jump relative]
*
* Function F392C
*
392c:F392C LDB/  W3003+1    ; =0x3004 =12292 [Load B direct]
392f:      LDAB+ *B,59      ; [Load AL indexed, displaced, indirect]
3932:      INC-  B,59       ; [Increment word at B+59 by 1]
3936:      LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
3938:      NABB             ; [AL & BL -> BL]
3939:      BNZ   D393E      ; =+3 [Branch if not zero]
393b:      CLA              ; [Clear A]
393c:      JMP   D3940      ; =+2 [Jump relative]
393e:D393E CLA              ; [Clear A]
393f:      IVA              ; [Invert A]
3940:D3940 STA-  Y-         ; [Store A indexed, pre-decremented, direct]
3942:      LDAB= X'01'      ; =1 [Load AL with immediate]
3944:      STAB- Z-         ; [Store AL indexed, pre-decremented, direct]
3946:      RSR              ; [Return from subroutine]
*
3947:D3947 LDB+  Y+         ; [Load B indexed, direct, post-incremented]
3949:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
394b:      SAB              ; [A - B -> B]
394c:      BZ    D3922      ; =-44 [Branch if zero]
394e:      BGZ   D391D      ; =-51 [Branch if greater than zero]
3950:      JMP   D3927      ; =-43 [Jump relative]
3952:D3952 JSR/  F3470      ; =0x3470 =13424 [Jump to subroutine direct]
3955:      JSR/  F3096      ; =0x3096 =12438 [Jump to subroutine direct]
3958:      LDA/  W3632      ; =0x3632 =13874 [Load A direct]
395b:      BNZ   D3963      ; =+6 [Branch if not zero]
395d:      LDB=  X'8000'    ; =0x8000 =32768(-32768) [Load B with immediate]
3960:      STB/  W3634      ; =0x3634 =13876 [Store B direct]
3963:D3963 INA              ; [Increment A]
3964:      STA/  W3632      ; =0x3632 =13874 [Store A direct]
3967:      JSR/  F31BF      ; =0x31bf =12735 [Jump to subroutine direct]
396a:      DW    W3632      ; =0x3632 =13874
*
396c:      JSR/  F317E      ; =0x317e =12670 [Jump to subroutine direct]
396f:      DW    W3632      ; =0x3632 =13874
3971:      LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
3973:      STAB- Z-         ; [Store AL indexed, pre-decremented, direct]
3975:      JSR/  F3470      ; =0x3470 =13424 [Jump to subroutine direct]
3978:      JSR/  F3096      ; =0x3096 =12438 [Jump to subroutine direct]
397b:      MVF   (4)/W3632,/W3638 ; =0x3632 =13874,=0x3638 =13880 [Move fixed-length, direct, direct]
3982:      JSR/  F3096      ; =0x3096 =12438 [Jump to subroutine direct]
3985:      LDA/  W3632      ; =0x3632 =13874 [Load A direct]
3988:      BNZ   D3990      ; =+6 [Branch if not zero]
398a:      LDB=  X'8000'    ; =0x8000 =32768(-32768) [Load B with immediate]
398d:      STB/  W3634      ; =0x3634 =13876 [Store B direct]
3990:D3990 INA              ; [Increment A]
3991:      STA/  W3632      ; =0x3632 =13874 [Store A direct]
3994:      JSR/  F31BF      ; =0x31bf =12735 [Jump to subroutine direct]
3997:      DW    W3632      ; =0x3632 =13874
3999:      LDA/  W3632      ; =0x3632 =13874 [Load A direct]
399c:      DCA              ; [Decrement A]
399d:      LDB/  W3634      ; =0x3634 =13876 [Load B direct]
39a0:      AAB              ; [A + B -> B]
39a1:      CLAB             ; [Clear AL]
39a2:      STAB+ B          ; [Store AL to address in B]
39a3:      LDA/  W3638      ; =0x3638 =13880 [Load A direct]
39a6:      DCA              ; [Decrement A]
39a7:      LDB/  W363A      ; =0x363a =13882 [Load B direct]
39aa:      AAB              ; [A + B -> B]
39ab:      CLAB             ; [Clear AL]
39ac:      STAB+ B          ; [Store AL to address in B]
39ad:      LDA/  W3634      ; =0x3634 =13876 [Load A direct]
39b0:      LDB/  W363A      ; =0x363a =13882 [Load B direct]
39b3:      STK   Y,4        ; [Push Y Z to the stack]
39b5:      CPV   (0)-B,-A   ; [Compare variable-length, indexed, indexed]
39b9:      POP   Y,4        ; [Pop Z Y from the stack]
39bb:      JMP/  J3919      ; =0x3919 =14617 [Jump direct]
39be:W39BE JSR/  F3470      ; =0x3470 =13424 [Jump to subroutine direct]
39c1:      JSR/  F308A      ; =0x308a =12426 [Jump to subroutine direct]
39c4:      LDA/  W3638      ; =0x3638 =13880 [Load A direct]
39c7:      BLE   D39FD      ; =+52 [Branch if less than or equal to zero]
39c9:      LDA/  W3632      ; =0x3632 =13874 [Load A direct]
39cc:      BLE   D3A09      ; =+59 [Branch if less than or equal to zero]
39ce:      LDB/  W3634      ; =0x3634 =13876 [Load B direct]
39d1:      AAB              ; [A + B -> B]
39d2:      LDA/  W3003+1    ; =0x3004 =12292 [Load A direct]
39d5:      LDA+  A,57       ; [Load A indexed, displaced, direct]
39d8:      SAB              ; [A - B -> B]
39d9:      BZ    D39E0      ; =+5 [Branch if zero]
39db:      JSR/  F31BF      ; =0x31bf =12735 [Jump to subroutine direct]
39de:      DW    W3632      ; =0x3632 =13874
*
39e0:D39E0 JSR/  F31BF      ; =0x31bf =12735 [Jump to subroutine direct]
39e3:      DW    W3638      ; =0x3638 =13880
39e5:      LDB/  W3638      ; =0x3638 =13880 [Load B direct]
39e8:      LDA/  W3632      ; =0x3632 =13874 [Load A direct]
39eb:      ADD   B,A        ; [B + A -> A]
39ed:      JSR/  F345F      ; =0x345f =13407 [Jump to subroutine direct]
39f0:      STA/  W3632      ; =0x3632 =13874 [Store A direct]
39f3:      LDB/  W3634      ; =0x3634 =13876 [Load B direct]
39f6:      AAB              ; [A + B -> B]
39f7:      LDA/  W3003+1    ; =0x3004 =12292 [Load A direct]
39fa:      STB+  A,57       ; [Store B indexed, displaced, direct]
39fd:D39FD JSR/  F317E      ; =0x317e =12670 [Jump to subroutine direct]
3a00:      DW    W3632      ; =0x3632 =13874
*
3a02:D3A02 LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
3a04:      STAB- Z-         ; [Store AL indexed, pre-decremented, direct]
3a06:P3A06 JMP/  W3644      ; =0x3644 =13892 [Jump direct]
3a09:D3A09 JSR/  F317E      ; =0x317e =12670 [Jump to subroutine direct]
3a0c:      DW    W3638      ; =0x3638 =13880
3a0e:      JMP   D3A02      ; =-14 [Jump relative]
3a10:W3A10 LDA+  Y          ; [Load A from address in Y]
3a11:      LDB=  X'4000'    ; =0x4000 =16384 [Load B with immediate]
3a14:      NAB              ; [A & B -> B]
3a15:      BNZ   D3A44      ; =+45 [Branch if not zero]
3a17:      JSR/  F303D      ; =0x303d =12349 [Jump to subroutine direct]
3a1a:      STAB- Z-         ; [Store AL indexed, pre-decremented, direct]
3a1c:      BM    D3A2B      ; =+13 [Branch on minus]
3a1e:      BZ    D3A24      ; =+4 [Branch if zero]
3a20:      LDA+  B          ; [Load A from address in B]
3a21:      STA+  Y          ; [Store A to address in Y]
3a22:      JMP*  P3A06+1    ; =-29 [Jump relative]
3a24:D3A24 JSR/  F3158      ; =0x3158 =12632 [Jump to subroutine direct]
3a27:D3A27 LDA+  Y+         ; [Load A indexed, direct, post-incremented]
3a29:      JMP*  P3A06+1    ; =-36 [Jump relative]
3a2b:D3A2B JSR/  F3180      ; =0x3180 =12672 [Jump to subroutine direct]
3a2e:      JSR/  F3470      ; =0x3470 =13424 [Jump to subroutine direct]
3a31:      JSR/  F3096      ; =0x3096 =12438 [Jump to subroutine direct]
3a34:      JSR/  F31BF      ; =0x31bf =12735 [Jump to subroutine direct]
3a37:      DW    W3632      ; =0x3632 =13874
*
3a39:      JSR/  F317E      ; =0x317e =12670 [Jump to subroutine direct]
3a3c:      DW    W3632      ; =0x3632 =13874
3a3e:      LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
3a40:      STAB- Z-         ; [Store AL indexed, pre-decremented, direct]
3a42:      JMP   D3A27      ; =-29 [Jump relative]
3a44:D3A44 XABB             ; [Transfer AL to BL]
3a45:      BZ    D3A4A      ; =+3 [Branch if zero]
3a47:      JMP/  J445E      ; =0x445e =17502 [Jump direct]
3a4a:D3A4A JSR/  F371F      ; =0x371f =14111 [Jump to subroutine direct]
3a4d:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
3a4f:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
3a51:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
3a53:      LDB/  W3595+1    ; =0x3596 =13718 [Load B direct]
3a56:      AAB              ; [A + B -> B]
3a57:      LDA+  B+         ; [Load A indexed, direct, post-incremented]
3a59:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
3a5b:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
3a5d:      XAX              ; [Transfer A to X]
3a5e:      LDB+  Y+         ; [Load B indexed, direct, post-incremented]
3a60:      SAB              ; [A - B -> B]
3a61:      BZ    D3A67      ; =+4 [Branch if zero]
3a63:      JSR/  F35BA      ; =0x35ba =13754 [Jump to subroutine direct]
3a66:      DB    X'05'      ; =0x05 =5
*
3a67:D3A67 DCX              ; [Decrement X]
3a68:      BM    D3A72      ; =+8 [Branch on minus]
3a6a:      LDB+  S          ; [Load B from address in S]
3a6b:      LDA+  B+         ; [Load A indexed, direct, post-incremented]
3a6d:      STB+  S          ; [Store B to address in S]
3a6e:      JSR   F3A93      ; =+35 [Jump to subroutine relative]
3a70:      JMP   D3A67      ; =-11 [Jump relative]
3a72:D3A72 LDA+  S+         ; [Load A indexed, direct, post-incremented]
3a74:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
3a76:      STA+  X,59       ; [Store A indexed, displaced, direct]
3a79:      JMP*  P3A06+1    ; =-116 [Jump relative]
3a7b:W3A7B LDA+  Y          ; [Load A from address in Y]
3a7c:      LDBB+ Z          ; [Load BL from address in Z]
3a7d:      BLE   D3A82      ; =+3 [Branch if less than or equal to zero]
3a7f:      LDA+  Y,2        ; [Load A indexed, displaced, direct]
3a82:D3A82 LDB=  X'4000'    ; =0x4000 =16384 [Load B with immediate]
3a85:      NAB              ; [A & B -> B]
3a86:      BZ    D3A8C      ; =+4 [Branch if zero]
3a88:      JSR/  F35BA      ; =0x35ba =13754 [Jump to subroutine direct]
3a8b:      DB    X'07'      ; =0x07 =7
*
3a8c:D3A8C JSR   F3A93      ; =+5 [Jump to subroutine relative]
3a8e:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
3a90:      JMP/  W3644      ; =0x3644 =13892 [Jump direct]
*
* Function F3A93
*
3a93:F3A93 JSR/  F303D      ; =0x303d =12349 [Jump to subroutine direct]
3a96:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
3a98:      XABB             ; [Transfer AL to BL]
3a99:      BZ    D3AA4      ; =+9 [Branch if zero]
3a9b:      BM    D3AB0      ; =+19 [Branch on minus]
3a9d:P3A9D JSR/  F30EC      ; =0x30ec =12524 [Jump to subroutine direct]
3aa0:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
3aa2:      STA+  B          ; [Store A to address in B]
3aa3:      RSR              ; [Return from subroutine]
*
3aa4:D3AA4 JSR/  F311C      ; =0x311c =12572 [Jump to subroutine direct]
3aa7:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
3aa9:      MVF   (6)/W3632,-B ; =0x3632 =13874, [Move fixed-length, direct, indexed]
3aaf:      RSR              ; [Return from subroutine]
*
3ab0:D3AB0 JSR/  F3096      ; =0x3096 =12438 [Jump to subroutine direct]
3ab3:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
3ab5:      MVF   (4)/W3632,-B ; =0x3632 =13874, [Move fixed-length, direct, indexed]
3abb:      RSR              ; [Return from subroutine]
*
3abc:W3ABC JSR*  P3A9D+1    ; =-32 [Jump to subroutine relative indirect]
3abe:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
3ac0:      JSR/  F30E3      ; =0x30e3 =12515 [Jump to subroutine direct]
3ac3:      SAB              ; [A - B -> B]
3ac4:      BGZ   D3AD7      ; =+17 [Branch if greater than zero]
3ac6:      BM    D3AE9      ; =+33 [Branch on minus]
3ac8:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
3aca:D3ACA STA-  Y-         ; [Store A indexed, pre-decremented, direct]
3acc:      LDAB= X'01'      ; =1 [Load AL with immediate]
3ace:      STAB- Z-         ; [Store AL indexed, pre-decremented, direct]
3ad0:      INC-  X,59,2     ; [Increment word at X+59 by 2]
3ad4:P3AD4 JMP/  W3644      ; =0x3644 =13892 [Jump direct]
3ad7:D3AD7 LDB+  S+         ; [Load B indexed, direct, post-incremented]
3ad9:      BM    D3ACA      ; =-17 [Branch on minus]
3adb:D3ADB LDA+  Y+         ; [Load A indexed, direct, post-incremented]
3add:D3ADD LDB+  *X,59      ; [Load B indexed, displaced, indirect]
3ae0:      LDA/  W3595+1    ; =0x3596 =13718 [Load A direct]
3ae3:      AAB              ; [A + B -> B]
3ae4:      STB+  X,59       ; [Store B indexed, displaced, direct]
3ae7:      JMP*  P3AD4+1    ; =-20 [Jump relative]
3ae9:D3AE9 LDB+  S+         ; [Load B indexed, direct, post-incremented]
3aeb:      BM    D3ADB      ; =-18 [Branch on minus]
3aed:      JMP   D3ACA      ; =-37 [Jump relative]
3aef:W3AEF JMP   D3ADD      ; =-20 [Jump relative]
3af1:W3AF1 JSR/  F3470      ; =0x3470 =13424 [Jump to subroutine direct]
3af4:      XFR   Y,A        ; [Transfer Y to A]
3af6:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
3af8:      LDA+  X,23       ; [Load A indexed, displaced, direct]
3afb:      XAY              ; [Transfer A to Y]
3afc:      LDA+  X,57       ; [Load A indexed, displaced, direct]
3aff:      STA/  W3634      ; =0x3634 =13876 [Store A direct]
3b02:      LDB+  Y+         ; [Load B indexed, direct, post-incremented]
3b04:D3B04 LDBB+ Y+         ; [Load BL indexed, direct, post-incremented]
3b06:      BZ    D3B0C      ; =+4 [Branch if zero]
3b08:      STBB+ A+         ; [Store BL indexed, direct, post-incremented]
3b0a:      JMP   D3B04      ; =-8 [Jump relative]
3b0c:D3B0C LDB+  X,57       ; [Load B indexed, displaced, direct]
3b0f:      SAB              ; [A - B -> B]
3b10:      STB/  W3632      ; =0x3632 =13874 [Store B direct]
3b13:      STA+  X,57       ; [Store A indexed, displaced, direct]
3b16:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
3b18:      XAY              ; [Transfer A to Y]
3b19:      JSR/  F317E      ; =0x317e =12670 [Jump to subroutine direct]
3b1c:      DW    W3632      ; =0x3632 =13874
3b1e:      LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
3b20:      STAB- Z-         ; [Store AL indexed, pre-decremented, direct]
3b22:      JMP/  W3A7B      ; =0x3a7b =14971 [Jump direct]
3b25:W3B25 LDA+  X,16       ; [Load A indexed, displaced, direct]
3b28:      STA+  X,14       ; [Store A indexed, displaced, direct]
3b2b:      JMP*  P3AD4+1    ; =-88 [Jump relative]
3b2d:W3B2D LDA+  X,14       ; [Load A indexed, displaced, direct]
3b30:      BNZ   D3B38      ; =+6 [Branch if not zero]
3b32:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
3b34:      LDBB= X'01'      ; =1 [Load BL with immediate]
3b36:      JMP   D3B56      ; =+30 [Jump relative]
3b38:D3B38 XFR   Z,B        ; [Transfer Z to B]
3b3a:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
3b3c:      XAZ              ; [Transfer A to Z]
3b3d:      JSR   F3B76      ; =+55 [Jump to subroutine relative]
3b3f:      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
3b41:      XFR   Z,B        ; [Transfer Z to B]
3b43:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
3b45:      BNZ   D3B4E      ; =+7 [Branch if not zero]
3b47:      LDB+  Z          ; [Load B from address in Z]
3b48:      BZ    D3B4E      ; =+4 [Branch if zero]
3b4a:      LDA/  W3595+1    ; =0x3596 =13718 [Load A direct]
3b4d:      AAB              ; [A + B -> B]
3b4e:D3B4E STB+  X,14       ; [Store B indexed, displaced, direct]
3b51:D3B51 LDBB+ S+         ; [Load BL indexed, direct, post-incremented]
3b53:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
3b55:      XAZ              ; [Transfer A to Z]
3b56:D3B56 STBB- Z-         ; [Store BL indexed, pre-decremented, direct]
3b58:      JMP/  W3A7B      ; =0x3a7b =14971 [Jump direct]
3b5b:W3B5B XFR   Z,A        ; [Transfer Z to A]
3b5d:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
3b5f:      LDA+  X,23       ; [Load A indexed, displaced, direct]
3b62:      LDB+  A+         ; [Load B indexed, direct, post-incremented]
3b64:      AAB              ; [A + B -> B]
3b65:      XFR   B,Z        ; [Transfer B to Z]
3b67:      JSR   F3B76      ; =+13 [Jump to subroutine relative]
3b69:      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
3b6b:      LDA+  X,23       ; [Load A indexed, displaced, direct]
3b6e:      XAB              ; [Transfer A to B]
3b6f:      INR   A,2        ; [Increment A by 2]
3b71:      SUB   Z,A        ; [Z - A -> A]
3b73:      STA+  B          ; [Store A to address in B]
3b74:      JMP   D3B51      ; =-37 [Jump relative]
*
* Function F3B76
*
3b76:F3B76 JSR/  F335B      ; =0x335b =13147 [Jump to subroutine direct]
3b79:      LDA+  Y          ; [Load A from address in Y]
3b7a:      JSR/  F303D      ; =0x303d =12349 [Jump to subroutine direct]
3b7d:      XABB             ; [Transfer AL to BL]
3b7e:      BM    D3B96      ; =+22 [Branch on minus]
3b80:      BZ    D3B8A      ; =+8 [Branch if zero]
3b82:      JSR/  F32E7      ; =0x32e7 =13031 [Jump to subroutine direct]
3b85:      JSR   F3BE6      ; =+95 [Jump to subroutine relative]
3b87:      LDAB= X'01'      ; =1 [Load AL with immediate]
3b89:      RSR              ; [Return from subroutine]
*
3b8a:D3B8A JSR/  F323C      ; =0x323c =12860 [Jump to subroutine direct]
3b8d:      JSR/  F3156      ; =0x3156 =12630 [Jump to subroutine direct]
3b90:      DW    W3632      ; =0x3632 =13874
*
3b92:      JSR   F3BE6      ; =+82 [Jump to subroutine relative]
3b94:      CLAB             ; [Clear AL]
3b95:      RSR              ; [Return from subroutine]
*
3b96:D3B96 JSR/  F3470      ; =0x3470 =13424 [Jump to subroutine direct]
3b99:      LDB=  X'ACA0'    ; =0xaca0 =44192(-21344) =',',' ' [Load B with immediate]
3b9c:      LDAB+ Z          ; [Load AL from address in Z]
3b9d:      LDBB= X'A7'      ; =167(-89) =' [Load BL with immediate]
3b9f:      SABB             ; [AL - BL -> BL]
3ba0:      BZ    D3BA7      ; =+5 [Branch if zero]
3ba2:      LDBB= X'A2'      ; =162(-94) ='"' [Load BL with immediate]
3ba4:      SABB             ; [AL - BL -> BL]
3ba5:      BNZ   D3BB7      ; =+16 [Branch if not zero]
3ba7:D3BA7 INR   Z          ; [Increment Z by 1]
3ba9:      XFRB  AL,BU      ; [Transfer AL to BU]
3bab:      JSR   F3BBB      ; =+14 [Jump to subroutine relative]
3bad:      JSR   F3BE6      ; =+55 [Jump to subroutine relative]
3baf:D3BAF JSR/  F317E      ; =0x317e =12670 [Jump to subroutine direct]
3bb2:      DW    W3632      ; =0x3632 =13874
3bb4:      LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
3bb6:      RSR              ; [Return from subroutine]
*
3bb7:D3BB7 JSR   F3BBB      ; =+2 [Jump to subroutine relative]
3bb9:      JMP   D3BAF      ; =-12 [Jump relative]
*
* Function F3BBB
*
3bbb:F3BBB STK   X,4        ; [Push X Y to the stack]
3bbd:      LDA/  W3003+1    ; =0x3004 =12292 [Load A direct]
3bc0:      XAY              ; [Transfer A to Y]
3bc1:      LDX+  Y,57       ; [Load X indexed, displaced, direct]
3bc4:D3BC4 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
3bc6:      BZ    D3BD1      ; =+9 [Branch if zero]
3bc8:      XABB             ; [Transfer AL to BL]
3bc9:      SUBB  BU,BL      ; [BU - BL -> BL]
3bcb:      BZ    D3BD3      ; =+6 [Branch if zero]
3bcd:      STAB+ X+         ; [Store AL indexed, direct, post-incremented]
3bcf:      JMP   D3BC4      ; =-13 [Jump relative]
3bd1:D3BD1 DCR   Z          ; [Decrement Z by 1]
3bd3:D3BD3 LDB+  Y,57       ; [Load B indexed, displaced, direct]
3bd6:      STX+  Y,57       ; [Store X indexed, displaced, direct]
3bd9:      STB/  W3634      ; =0x3634 =13876 [Store B direct]
3bdc:      SUB   X,B        ; [X - B -> B]
3bde:      STB/  W3632      ; =0x3632 =13874 [Store B direct]
3be1:      POP   X,4        ; [Pop Y X from the stack]
3be3:      JSR*  F3B76+1    ; =-110 [Jump to subroutine relative indirect]
3be5:      RSR              ; [Return from subroutine]
*
* Function F3BE6
*
3be6:F3BE6 JSR*  F3B76+1    ; =-113 [Jump to subroutine relative indirect]
3be8:      LDAB+ Z          ; [Load AL from address in Z]
3be9:      BZ    D3BF4      ; =+9 [Branch if zero]
3beb:      LDBB= X'AC'      ; =172(-84) =',' [Load BL with immediate]
3bed:      SABB             ; [AL - BL -> BL]
3bee:      BNZ   D3BF4      ; =+4 [Branch if not zero]
3bf0:      INR   Z          ; [Increment Z by 1]
3bf2:      JSR*  F3B76+1    ; =-125 [Jump to subroutine relative indirect]
3bf4:D3BF4 RSR              ; [Return from subroutine]
*
3bf5:W3BF5 JSR/  F3391      ; =0x3391 =13201 [Jump to subroutine direct]
3bf8:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
3bfa:      JSR/  F30EC      ; =0x30ec =12524 [Jump to subroutine direct]
3bfd:      STA   W3C05      ; =+6 [Store A relative]
3bff:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
3c01:P3C01 JSR/  F41F9      ; =0x41f9 =16889 [Jump to subroutine direct]
3c04:      DB    X'09'      ; =0x09 =9
3c05:W3C05 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
3c07:P3C07 JMP/  W3644      ; =0x3644 =13892 [Jump direct]
3c0a:W3C0A JSR*  W3BF5+1    ; =-22 [Jump to subroutine relative indirect]
3c0c:      JSR*  P3C01+1    ; =-12 [Jump to subroutine relative indirect]
3c0e:      DW    X'0A00'    ; =0x0a00 =2560
3c10:      DB    X'00'      ; =0x00 =0 =NUL
3c11:      JMP*  P3C07+1    ; =-11 [Jump relative]
3c13:W3C13 JSR*  W3BF5+1    ; =-31 [Jump to subroutine relative indirect]
3c15:      STAB+ X,21       ; [Store AL indexed, displaced, direct]
3c18:      LDB+  X,23       ; [Load B indexed, displaced, direct]
3c1b:      STB   W3C25      ; =+8 [Store B relative]
3c1d:      LDB+  X,32       ; [Load B indexed, displaced, direct]
3c20:      STB*  W3C25      ; =+3 [Store B relative indirect]
3c22:      JSR*  P3C01+1    ; =-34 [Jump to subroutine relative indirect]
3c24:      DB    X'01'      ; =0x01 =1
3c25:W3C25 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
3c27:      CLA              ; [Clear A]
3c28:      STA+  *X,23      ; [Store A indexed, displaced, indirect]
3c2b:      JMP*  P3C07+1    ; =-37 [Jump relative]
3c2d:W3C2D JSR*  W3BF5+1    ; =-57 [Jump to subroutine relative indirect]
3c2f:      LDBB+ X,22       ; [Load BL indexed, displaced, direct]
3c32:      SABB             ; [AL - BL -> BL]
3c33:      BZ    D3C42      ; =+13 [Branch if zero]
3c35:      LDB+  *X,25      ; [Load B indexed, displaced, indirect]
3c38:      BZ    D3C42      ; =+8 [Branch if zero]
3c3a:      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
3c3c:      JSR/  F3365      ; =0x3365 =13157 [Jump to subroutine direct]
3c3f:      DB    X'02'      ; =0x02 =2
3c40:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
3c42:D3C42 STAB+ X,22       ; [Store AL indexed, displaced, direct]
3c45:      JMP*  P3C07+1    ; =-63 [Jump relative]
3c47:W3C47 JSR/  F3D03      ; =0x3d03 =15619 [Jump to subroutine direct]
3c4a:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
3c4c:      XAX              ; [Transfer A to X]
3c4d:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
3c4f:      STB   W3C56      ; =+5 [Store B relative]
3c51:      JSR*  W3BF5+1    ; =-93 [Jump to subroutine relative indirect]
3c53:      JSR*  P3C01+1    ; =-83 [Jump to subroutine relative indirect]
3c55:      DB    X'01'      ; =0x01 =1
3c56:W3C56 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
3c58:      JMP   D3C5F      ; =+5 [Jump relative]
3c5a:J3C5A STX-  S-         ; [Store X indexed, pre-decremented, direct]
3c5c:      XAX              ; [Transfer A to X]
3c5d:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
3c5f:D3C5F LDA+  S          ; [Load A from address in S]
3c60:      LDB+  A+         ; [Load B indexed, direct, post-incremented]
3c62:      STB+  S          ; [Store B to address in S]
3c63:      XFR   Z,B        ; [Transfer Z to B]
3c65:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
3c67:      XAZ              ; [Transfer A to Z]
3c68:D3C68 LDA+  X+         ; [Load A indexed, direct, post-incremented]
3c6a:      BM    D3CBE      ; =+82 [Branch on minus]
3c6c:      JSR/  F303D      ; =0x303d =12349 [Jump to subroutine direct]
3c6f:      BM    D3C95      ; =+36 [Branch on minus]
3c71:      BGZ   D3C7F      ; =+12 [Branch if greater than zero]
3c73:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
3c75:      BNZ   D3CC8      ; =+81 [Branch if not zero]
3c77:      MVF   (6)-Z,-B   ; [Move fixed-length, indexed, indexed]
3c7b:      INR   Z,6        ; [Increment Z by 6]
3c7d:      JMP   D3C68      ; =-23 [Jump relative]
3c7f:D3C7F LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
3c81:      BZ    D3C90      ; =+13 [Branch if zero]
3c83:      ZAD   -Z(4),-B(2) ; [Zero-add bignum, indexed, indexed]
3c87:      BNF   D3C8C      ; =+3 [Branch on no fault]
3c89:      JSR/  F32DA      ; =0x32da =13018 [Jump to subroutine direct]
3c8c:D3C8C INR   Z,4        ; [Increment Z by 4]
3c8e:      JMP   D3C68      ; =-40 [Jump relative]
3c90:D3C90 LDA+  Z+         ; [Load A indexed, direct, post-incremented]
3c92:      STA+  B          ; [Store A to address in B]
3c93:      JMP   D3C68      ; =-45 [Jump relative]
3c95:D3C95 XFR   Z,A        ; [Transfer Z to A]
3c97:      STA+  B,2        ; [Store A indexed, displaced, direct]
3c9a:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
3c9c:      ADD   A,Z        ; [A + Z -> Z]
3c9e:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
3ca0:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
3ca2:      BNZ   D3CE7      ; =+67 [Branch if not zero]
3ca4:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
3ca6:D3CA6 STB-  S-         ; [Store B indexed, pre-decremented, direct]
3ca8:      JSR/  F345F      ; =0x345f =13407 [Jump to subroutine direct]
3cab:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
3cad:      STA+  B          ; [Store A to address in B]
3cae:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
3cb0:      JSR/  F3470      ; =0x3470 =13424 [Jump to subroutine direct]
3cb3:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
3cb5:      STB   W3CBA      ; =+3 [Store B relative]
3cb7:      JSR/  F31BF      ; =0x31bf =12735 [Jump to subroutine direct]
3cba:W3CBA DW    X'0000'    ; =0x0000 =0 =NUL,NUL
3cbc:      JMP   D3C68      ; =-86 [Jump relative]
3cbe:D3CBE LDA+  S+         ; [Load A indexed, direct, post-incremented]
3cc0:      XAZ              ; [Transfer A to Z]
3cc1:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
3cc3:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
3cc5:      JMP/  W3644      ; =0x3644 =13892 [Jump direct]
3cc8:D3CC8 DCAB             ; [Decrement AL]
3cc9:      BZ    D3CD3      ; =+8 [Branch if zero]
3ccb:      ZAD   -Z(6),-B(6) ; [Zero-add bignum, indexed, indexed]
3ccf:      INR   Z,6        ; [Increment Z by 6]
3cd1:      JMP   D3CD9      ; =+6 [Jump relative]
3cd3:D3CD3 ZAD   -Z(4),-B(6) ; [Zero-add bignum, indexed, indexed]
3cd7:      INR   Z,4        ; [Increment Z by 4]
3cd9:D3CD9 M     =1000000,-B(6) ; [Multiply bignums, literal=0x0f4240, indexed]
3ce0:      BNF   D3C68      ; =-122 [Branch on no fault]
3ce2:      JSR/  F32DA      ; =0x32da =13018 [Jump to subroutine direct]
3ce5:      JMP   D3C68      ; =-127 [Jump relative]
3ce7:D3CE7 LDA+  S+         ; [Load A indexed, direct, post-incremented]
3ce9:      XFRB  AL,AU      ; [Transfer AL to AU]
3ceb:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
3ced:      LDB+  B,2        ; [Load B indexed, displaced, direct]
3cf0:D3CF0 LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
3cf2:      BZ    D3CF8      ; =+4 [Branch if zero]
3cf4:      DCRB  AU         ; [Decrement AU by 1]
3cf6:      BNZ   D3CF0      ; =-8 [Branch if not zero]
3cf8:D3CF8 LDA+  S          ; [Load A from address in S]
3cf9:      LDA+  A,2        ; [Load A indexed, displaced, direct]
3cfc:      SUB   B,A        ; [B - A -> A]
3cfe:      DCA              ; [Decrement A]
3cff:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
3d01:      JMP   D3CA6      ; =-93 [Jump relative]
*
* Function F3D03
*
3d03:F3D03 LDB/  W3003+1    ; =0x3004 =12292 [Load B direct]
3d06:      LDA+  *B,59      ; [Load A indexed, displaced, indirect]
3d09:      INC-  B,59,2     ; [Increment word at B+59 by 2]
3d0d:      LDB/  W3595+1    ; =0x3596 =13718 [Load B direct]
3d10:      AAB              ; [A + B -> B]
3d11:      LDA+  B+         ; [Load A indexed, direct, post-incremented]
3d13:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
3d15:      JSR/  F3627      ; =0x3627 =13863 [Jump to subroutine direct]
3d18:      LDB+  A+         ; [Load B indexed, direct, post-incremented]
3d1a:      LDA+  A          ; [Load A from address in A]
3d1b:      STA+  B          ; [Store A to address in B]
3d1c:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
3d1e:      RSR              ; [Return from subroutine]
*
3d1f:W3D1F LDAB= X'03'      ; =3 [Load AL with immediate]
3d21:      JMP   D3D25      ; =+2 [Jump relative]
3d23:W3D23 LDAB= X'02'      ; =2 [Load AL with immediate]
3d25:D3D25 STAB/ B3DA6      ; =0x3da6 =15782 [Store AL direct]
3d28:      JSR   F3D03      ; =-39 [Jump to subroutine relative]
3d2a:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
3d2c:      XFR   Y,X        ; [Transfer Y to X]
3d2e:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
3d30:      XFR   Z,X        ; [Transfer Z to X]
3d32:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
3d34:      XAY              ; [Transfer A to Y]
3d35:      STB   W3DA7      ; =+112 [Store B relative]
3d37:      LDA+  B+         ; [Load A indexed, direct, post-incremented]
3d39:      XFR   B,Z        ; [Transfer B to Z]
3d3b:D3D3B LDA+  Y+         ; [Load A indexed, direct, post-incremented]
3d3d:      BM    D3D90      ; =+81 [Branch on minus]
3d3f:      JSR/  F303D      ; =0x303d =12349 [Jump to subroutine direct]
3d42:      BM    D3D63      ; =+31 [Branch on minus]
3d44:      BGZ   D3D52      ; =+12 [Branch if greater than zero]
3d46:      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
3d48:      BNZ   D3DAC      ; =+98 [Branch if not zero]
3d4a:      MVF   (6)-B,-Z   ; [Move fixed-length, indexed, indexed]
3d4e:      INR   Z,6        ; [Increment Z by 6]
3d50:      JMP   D3D3B      ; =-23 [Jump relative]
3d52:D3D52 LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
3d54:      BZ    D3D5E      ; =+8 [Branch if zero]
3d56:      ZAD   -B(2),-Z(4) ; [Zero-add bignum, indexed, indexed]
3d5a:      INR   Z,4        ; [Increment Z by 4]
3d5c:      JMP   D3D3B      ; =-35 [Jump relative]
3d5e:D3D5E LDA+  B          ; [Load A from address in B]
3d5f:      STA+  Z+         ; [Store A indexed, direct, post-incremented]
3d61:      JMP   D3D3B      ; =-40 [Jump relative]
3d63:D3D63 LDA+  B+         ; [Load A indexed, direct, post-incremented]
3d65:      LDB+  B          ; [Load B from address in B]
3d66:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
3d68:      LDB+  Y          ; [Load B from address in Y]
3d69:      LDX+  Y+         ; [Load X indexed, direct, post-incremented]
3d6b:      SAB              ; [A - B -> B]
3d6c:      BP    D3D6F      ; =+1 [Branch on plus]
3d6e:      XAX              ; [Transfer A to X]
3d6f:D3D6F LDA+  S          ; [Load A from address in S]
3d70:      STB+  S          ; [Store B to address in S]
3d71:D3D71 DCX              ; [Decrement X]
3d72:      BM    D3D7A      ; =+6 [Branch on minus]
3d74:      LDBB+ A+         ; [Load BL indexed, direct, post-incremented]
3d76:      STBB+ Z+         ; [Store BL indexed, direct, post-incremented]
3d78:      JMP   D3D71      ; =-9 [Jump relative]
3d7a:D3D7A LDX+  S+         ; [Load X indexed, direct, post-incremented]
3d7c:      BP    D3D85      ; =+7 [Branch on plus]
3d7e:      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
3d80:D3D80 STAB+ Z+         ; [Store AL indexed, direct, post-incremented]
3d82:      INX              ; [Increment X]
3d83:      BM    D3D80      ; =-5 [Branch on minus]
3d85:D3D85 LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
3d87:      BZ    D3D3B      ; =-78 [Branch if zero]
3d89:      CLAB             ; [Clear AL]
3d8a:      DCR   Z          ; [Decrement Z by 1]
3d8c:      STAB+ Z+         ; [Store AL indexed, direct, post-incremented]
3d8e:      JMP   D3D3B      ; =-85 [Jump relative]
3d90:D3D90 LDA+  S+         ; [Load A indexed, direct, post-incremented]
3d92:      XAZ              ; [Transfer A to Z]
3d93:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
3d95:      XAY              ; [Transfer A to Y]
3d96:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
3d98:B3D98 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
3d9a:      BZ    D3DA0      ; =+4 [Branch if zero]
3d9c:      CLAB             ; [Clear AL]
3d9d:      STAB  B3D98+1    ; =-6 [Store AL relative]
3d9f:      RSR              ; [Return from subroutine]
*
3da0:D3DA0 JSR/  F3391      ; =0x3391 =13201 [Jump to subroutine direct]
3da3:      JSR/  F41F9      ; =0x41f9 =16889 [Jump to subroutine direct]
3da6:B3DA6 DB    X'00'      ; =0x00 =0 =NUL
3da7:W3DA7 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
3da9:P3DA9 JMP/  W3644      ; =0x3644 =13892 [Jump direct]
3dac:D3DAC MVF   (6)-B,/W3632 ; =0x3632 =13874 [Move fixed-length, indexed, direct]
3db2:      D     =1000000,/W3632(6) ; =0x3632 =13874 [Divide bignums, literal=0x0f4240, direct]
3dba:      DCAB             ; [Decrement AL]
3dbb:      BZ    D3DC8      ; =+11 [Branch if zero]
3dbd:      INR   Z,6        ; [Increment Z by 6]
3dbf:      ZAD   /W3632(6),-Z,-6(6) ; =0x3632 =13874, [Zero-add bignum, direct, displaced indexed]
3dc6:      JMP   D3DD1      ; =+9 [Jump relative]
3dc8:D3DC8 INR   Z,4        ; [Increment Z by 4]
3dca:      ZAD   /W3632(6),-Z,-4(4) ; =0x3632 =13874, [Zero-add bignum, direct, displaced indexed]
3dd1:D3DD1 BNF   D3DD6      ; =+3 [Branch on no fault]
3dd3:      JSR/  F32DA      ; =0x32da =13018 [Jump to subroutine direct]
3dd6:D3DD6 JMP/  D3D3B      ; =0x3d3b =15675 [Jump direct]
3dd9:W3DD9 LDA+  *X,25      ; [Load A indexed, displaced, indirect]
3ddc:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
3dde:      LDX=  W3DFC      ; =0x3dfc =15868 [Load X with immediate]
3de1:D3DE1 LDB+  X+         ; [Load B indexed, direct, post-incremented]
3de3:      BP    D3DED      ; =+8 [Branch on plus]
3de5:      JSR/  F3365      ; =0x3365 =13157 [Jump to subroutine direct]
3de8:      DB    X'02'      ; =0x02 =2
3de9:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
3deb:      JMP*  P3DA9+1    ; =-67 [Jump relative]
3ded:D3DED SAB              ; [A - B -> B]
3dee:      BGZ   D3DE1      ; =-15 [Branch if greater than zero]
3df0:      LDA-  X-         ; [Load A indexed, pre-decremented, direct]
3df2:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
3df4:      JSR/  F345F      ; =0x345f =13407 [Jump to subroutine direct]
3df7:      STA+  *X,25      ; [Store A indexed, displaced, indirect]
3dfa:      JMP*  P3DA9+1    ; =-82 [Jump relative]
*
3dfc:W3DFC DW    X'000F'    ; =0x000f =15
3dfe:      DB    X'00'      ; =0x00 =0 =NUL
3dff:      DW    X'1E00'    ; =0x1e00 =7680
3e01:      DW    X'2D00'    ; =0x2d00 =11520
3e03:      DW    X'3C00'    ; =0x3c00 =15360
3e05:      DW    X'4B00'    ; =0x4b00 =19200
3e07:      DW    X'5A00'    ; =0x5a00 =23040
3e09:      DW    X'6900'    ; =0x6900 =26880
3e0b:      DW    X'78FF'    ; =0x78ff =30975
3e0d:      DB    X'FF'      ; =0xff =255(-1)
*
3e0e:W3E0E LDA+  *X,25      ; [Load A indexed, displaced, indirect]
3e11:      INA              ; [Increment A]
3e12:      LDB+  X,32       ; [Load B indexed, displaced, direct]
3e15:      SAB              ; [A - B -> B]
3e16:      BGZ   D3E1E      ; =+6 [Branch if greater than zero]
3e18:      STA+  *X,25      ; [Store A indexed, displaced, indirect]
3e1b:P3E1B JMP/  W3644      ; =0x3644 =13892 [Jump direct]
3e1e:D3E1E JSR/  F3365      ; =0x3365 =13157 [Jump to subroutine direct]
3e21:      DB    X'02'      ; =0x02 =2
3e22:      JMP*  P3E1B+1    ; =-8 [Jump relative]
3e24:W3E24 JSR/  F3096      ; =0x3096 =12438 [Jump to subroutine direct]
3e27:      JSR   F3E2B      ; =+2 [Jump to subroutine relative]
3e29:      JMP*  P3E1B+1    ; =-15 [Jump relative]
*
* Function F3E2B
*
3e2b:F3E2B XFR   Z,A        ; [Transfer Z to A]
3e2d:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
3e2f:      XFR   Y,A        ; [Transfer Y to A]
3e31:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
3e33:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
3e35:      LDA/  W3634      ; =0x3634 =13876 [Load A direct]
3e38:      XAZ              ; [Transfer A to Z]
3e39:      LDA/  W3632      ; =0x3632 =13874 [Load A direct]
3e3c:      JSR/  F345F      ; =0x345f =13407 [Jump to subroutine direct]
3e3f:      XAX              ; [Transfer A to X]
3e40:D3E40 LDB/  W3003+1    ; =0x3004 =12292 [Load B direct]
3e43:      LDB+  B,25       ; [Load B indexed, displaced, direct]
3e46:      LDA+  B+         ; [Load A indexed, direct, post-incremented]
3e48:      AAB              ; [A + B -> B]
3e49:      XFR   B,Y        ; [Transfer B to Y]
3e4b:      ADD   X,A        ; [X + A -> A]
3e4d:      LDB/  W3003+1    ; =0x3004 =12292 [Load B direct]
3e50:      LDB+  B,32       ; [Load B indexed, displaced, direct]
3e53:      SAB              ; [A - B -> B]
3e54:      BLE   D3E5C      ; =+6 [Branch if less than or equal to zero]
3e56:      JSR/  F3365      ; =0x3365 =13157 [Jump to subroutine direct]
3e59:      DB    X'02'      ; =0x02 =2
3e5a:      JMP   D3E40      ; =-28 [Jump relative]
3e5c:D3E5C LDB/  W3003+1    ; =0x3004 =12292 [Load B direct]
3e5f:      STA+  *B,25      ; [Store A indexed, displaced, indirect]
3e62:D3E62 DCX              ; [Decrement X]
3e63:      BM    D3E6B      ; =+6 [Branch on minus]
3e65:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
3e67:      STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
3e69:      JMP   D3E62      ; =-9 [Jump relative]
3e6b:D3E6B LDX+  S+         ; [Load X indexed, direct, post-incremented]
3e6d:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
3e6f:      XAY              ; [Transfer A to Y]
3e70:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
3e72:      XAZ              ; [Transfer A to Z]
3e73:      RSR              ; [Return from subroutine]
*
3e74:W3E74 STX-  S-         ; [Store X indexed, pre-decremented, direct]
3e76:      LDX+  X,27       ; [Load X indexed, displaced, direct]
3e79:D3E79 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
3e7b:      BNZ   D3E87      ; =+10 [Branch if not zero]
3e7d:      XFR   X,A        ; [Transfer X to A]
3e7f:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
3e81:      DCA              ; [Decrement A]
3e82:      STA+  X,27       ; [Store A indexed, displaced, direct]
3e85:      JMP   W3E24      ; =-99 [Jump relative]
3e87:D3E87 DCAB             ; [Decrement AL]
3e88:      BZ    D3EE8      ; =+94 [Branch if zero]
3e8a:      DCAB             ; [Decrement AL]
3e8b:      BZ    D3EBA      ; =+45 [Branch if zero]
3e8d:      LDBB= X'02'      ; =2 [Load BL with immediate]
3e8f:      SABB             ; [AL - BL -> BL]
3e90:      BM    D3EA1      ; =+15 [Branch on minus]
3e92:      BZ    D3E9A      ; =+6 [Branch if zero]
3e94:      JSR/  F3365      ; =0x3365 =13157 [Jump to subroutine direct]
3e97:      DB    X'02'      ; =0x02 =2
3e98:      JMP   D3E79      ; =-33 [Jump relative]
3e9a:D3E9A CLA              ; [Clear A]
3e9b:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
3e9d:      JSR   F3EB0      ; =+17 [Jump to subroutine relative]
3e9f:      JMP   D3E79      ; =-40 [Jump relative]
3ea1:D3EA1 CLA              ; [Clear A]
3ea2:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
3ea4:      JSR   F3EA8      ; =+2 [Jump to subroutine relative]
3ea6:      JMP   D3E79      ; =-47 [Jump relative]
*
* Function F3EA8
*
3ea8:F3EA8 LDB/  W3003+1    ; =0x3004 =12292 [Load B direct]
3eab:      LDB+  *B,25      ; [Load B indexed, displaced, indirect]
3eae:      ADD   B,A        ; [B + A -> A]
*
* Function F3EB0
*
3eb0:F3EB0 JSR/  F345F      ; =0x345f =13407 [Jump to subroutine direct]
3eb3:      LDB/  W3003+1    ; =0x3004 =12292 [Load B direct]
3eb6:      STA+  *B,25      ; [Store A indexed, displaced, indirect]
3eb9:      RSR              ; [Return from subroutine]
*
3eba:D3EBA CLA              ; [Clear A]
3ebb:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
3ebd:      JSR/  F345F      ; =0x345f =13407 [Jump to subroutine direct]
3ec0:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
3ec2:      JSR/  F3096      ; =0x3096 =12438 [Jump to subroutine direct]
3ec5:      LDA+  S          ; [Load A from address in S]
3ec6:      LDB/  W3632      ; =0x3632 =13874 [Load B direct]
3ec9:      SAB              ; [A - B -> B]
3eca:      BLE   D3ED6      ; =+10 [Branch if less than or equal to zero]
3ecc:      STB+  S          ; [Store B to address in S]
3ecd:      JSR/  F3E2B      ; =0x3e2b =15915 [Jump to subroutine direct]
3ed0:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
3ed2:      JSR   F3EA8      ; =-44 [Jump to subroutine relative]
3ed4:      JMP   D3EDE      ; =+8 [Jump relative]
3ed6:D3ED6 LDA+  S+         ; [Load A indexed, direct, post-incremented]
3ed8:      STA/  W3632      ; =0x3632 =13874 [Store A direct]
3edb:      JSR/  F3E2B      ; =0x3e2b =15915 [Jump to subroutine direct]
3ede:D3EDE XFR   X,A        ; [Transfer X to A]
3ee0:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
3ee2:      STA+  X,27       ; [Store A indexed, displaced, direct]
3ee5:      JMP/  W3644      ; =0x3644 =13892 [Jump direct]
3ee8:D3EE8 JSR/  F3104      ; =0x3104 =12548 [Jump to subroutine direct]
3eeb:      BZ    D3EF2      ; =+5 [Branch if zero]
3eed:      JSR/  F33B3      ; =0x33b3 =13235 [Jump to subroutine direct]
3ef0:      JMP   D3EF5      ; =+3 [Jump relative]
3ef2:D3EF2 JSR/  F33F3      ; =0x33f3 =13299 [Jump to subroutine direct]
3ef5:D3EF5 XFR   Z,A        ; [Transfer Z to A]
3ef7:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
3ef9:      LDA=  S33EB      ; =0x33eb =13291 [Load A with immediate]
3efc:      XAZ              ; [Transfer A to Z]
3efd:      CLA              ; [Clear A]
3efe:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
3f00:      JSR   F3F69      ; =+103 [Jump to subroutine relative]
3f02:      DB    X'09'      ; =0x09 =9
3f03:      XAB              ; [Transfer A to B]
3f04:      LDAB= X'09'      ; =9 [Load AL with immediate]
3f06:      SABB             ; [AL - BL -> BL]
3f07:      LDA=  S33E2      ; =0x33e2 =13282 [Load A with immediate]
3f0a:      AAB              ; [A + B -> B]
3f0b:      STB/  W3634      ; =0x3634 =13876 [Store B direct]
3f0e:      CLA              ; [Clear A]
3f0f:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
3f11:      BZ    D3F2C      ; =+25 [Branch if zero]
3f13:      LDBB= X'AE'      ; =174(-82) ='.' [Load BL with immediate]
3f15:      STBB+ Z+         ; [Store BL indexed, direct, post-incremented]
3f17:      JSR   F3F69      ; =+80 [Jump to subroutine relative]
3f19:      DB    X'06'      ; =0x06 =6
3f1a:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
3f1c:      XAX              ; [Transfer A to X]
3f1d:D3F1D LDAB+ Z          ; [Load AL from address in Z]
3f1e:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
3f20:      SABB             ; [AL - BL -> BL]
3f21:      BNZ   D3F25      ; =+2 [Branch if not zero]
3f23:      LDAB= X'B0'      ; =176(-80) ='0' [Load AL with immediate]
3f25:D3F25 STAB+ Z+         ; [Store AL indexed, direct, post-incremented]
3f27:      DCX              ; [Decrement X]
3f28:      BGZ   D3F1D      ; =-13 [Branch if greater than zero]
3f2a:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
3f2c:D3F2C LDBB/ B33E1      ; =0x33e1 =13281 [Load BL direct]
3f2f:      BNZ   D3F33      ; =+2 [Branch if not zero]
3f31:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
3f33:D3F33 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
3f35:      BZ    D3F58      ; =+33 [Branch if zero]
3f37:      DCAB             ; [Decrement AL]
3f38:      BZ    D3F3E      ; =+4 [Branch if zero]
3f3a:      STBB+ Z+         ; [Store BL indexed, direct, post-incremented]
3f3c:      JMP   D3F58      ; =+26 [Jump relative]
3f3e:D3F3E STX-  S-         ; [Store X indexed, pre-decremented, direct]
3f40:      STBB- S-         ; [Store BL indexed, pre-decremented, direct]
3f42:      LDX/  W3634      ; =0x3634 =13876 [Load X direct]
3f45:      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
3f47:      STAB- X-         ; [Store AL indexed, pre-decremented, direct]
3f49:      STX/  W3634      ; =0x3634 =13876 [Store X direct]
3f4c:D3F4C LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
3f4e:      SABB             ; [AL - BL -> BL]
3f4f:      BZ    D3F4C      ; =-5 [Branch if zero]
3f51:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
3f53:      STAB+ X,-2       ; [Store AL indexed, displaced, direct]
3f56:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
3f58:D3F58 LDA/  W3634      ; =0x3634 =13876 [Load A direct]
3f5b:      SUB   Z,A        ; [Z - A -> A]
3f5d:      STA/  W3632      ; =0x3632 =13874 [Store A direct]
3f60:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
3f62:      XAZ              ; [Transfer A to Z]
3f63:      JSR/  F3E2B      ; =0x3e2b =15915 [Jump to subroutine direct]
3f66:      JMP/  D3EDE      ; =0x3ede =16094 [Jump direct]
*
* Function F3F69
*
3f69:F3F69 LDBB+ X          ; [Load BL from address in X]
3f6a:      SABB             ; [AL - BL -> BL]
3f6b:      BLE   D3F6E      ; =+1 [Branch if less than or equal to zero]
3f6d:      LDAB+ X          ; [Load AL from address in X]
3f6e:D3F6E INX              ; [Increment X]
3f6f:      RSR              ; [Return from subroutine]
*
3f70:W3F70 JSR/  F3365      ; =0x3365 =13157 [Jump to subroutine direct]
3f73:      DB    X'02'      ; =0x02 =2
*
3f74:J3F74 JMP/  W3644      ; =0x3644 =13892 [Jump direct]
3f77:W3F77 JSR*  W3F70+1    ; =-8 [Jump to subroutine relative indirect]
3f79:      DB    X'00'      ; =0x00 =0 =NUL
3f7a:      JMP*  J3F74+1    ; =-7 [Jump relative]
3f7c:W3F7C JSR*  W3F70+1    ; =-13 [Jump to subroutine relative indirect]
3f7e:      DB    X'03'      ; =0x03 =3
3f7f:      JMP*  J3F74+1    ; =-12 [Jump relative]
3f81:W3F81 LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
3f83:      STAB/ B3D98+1    ; =0x3d99 =15769 [Store AL direct]
3f86:      JSR/  W3D23      ; =0x3d23 =15651 [Jump to subroutine direct]
3f89:      JSR/  F3D03      ; =0x3d03 =15619 [Jump to subroutine direct]
3f8c:      LDB/  W3DA7      ; =0x3da7 =15783 [Load B direct]
3f8f:      JMP/  J3C5A      ; =0x3c5a =15450 [Jump direct]
3f92:W3F92 CLAB             ; [Clear AL]
3f93:      STAB+ X,61       ; [Store AL indexed, displaced, direct]
3f96:      STAB+ X,62       ; [Store AL indexed, displaced, direct]
3f99:      JMP/  W3644      ; =0x3644 =13892 [Jump direct]
3f9c:W3F9C CLAB             ; [Clear AL]
3f9d:      STAB/ B36AC      ; =0x36ac =13996 [Store AL direct]
3fa0:      DCAB             ; [Decrement AL]
3fa1:      STAB  B3FAE+1    ; =+12 [Store AL relative]
3fa3:P3FA3 JSR/  F30EC      ; =0x30ec =12524 [Jump to subroutine direct]
3fa6:      BM    B3FAE      ; =+6 [Branch on minus]
3fa8:      XFRB  AU,BU      ; [Transfer AU to BU]
3faa:      BNZ   B3FAE      ; =+2 [Branch if not zero]
3fac:      STAB  B3FAE+1    ; =+1 [Store AL relative]
3fae:B3FAE LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
3fb0:      SVC   X'6C'      ; =108 [Service call EXITR - exit with CC in AL]
*
3fb2:W3FB2 LDB/  W3003+1    ; =0x3004 =12292 [Load B direct]
3fb5:      LDA+  *B,59      ; [Load A indexed, displaced, indirect]
3fb8:      INC-  B,59,2     ; [Increment word at B+59 by 2]
3fbc:      XAB              ; [Transfer A to B]
3fbd:      JSR/  F354B      ; =0x354b =13643 [Jump to subroutine direct]
3fc0:      LDA+  B          ; [Load A from address in B]
3fc1:      LDB/  W3595+1    ; =0x3596 =13718 [Load B direct]
3fc4:      AAB              ; [A + B -> B]
3fc5:      LDA=  X'0003'    ; =0x0003 =3 [Load A with immediate]
3fc8:      AAB              ; [A + B -> B]
3fc9:      STB+  X,27       ; [Store B indexed, displaced, direct]
3fcc:      JMP*  J3F74+1    ; =-89 [Jump relative]
3fce:W3FCE JSR*  P3FA3+1    ; =-44 [Jump to subroutine relative indirect]
3fd0:      INAB             ; [Increment AL]
3fd1:      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
3fd3:      JSR*  P3FA3+1    ; =-49 [Jump to subroutine relative indirect]
3fd5:      INAB             ; [Increment AL]
3fd6:      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
3fd8:      LDB+  X,39       ; [Load B indexed, displaced, direct]
3fdb:      STB   W3FF4      ; =+23 [Store B relative]
3fdd:      CLR   A,4        ; [Set A to 4]
3fdf:      STA+  B+         ; [Store A indexed, direct, post-incremented]
3fe1:      LDA=  X'9BB1'    ; =0x9bb1 =39857(-25679) [Load A with immediate]
3fe4:      STA+  B+         ; [Store A indexed, direct, post-incremented]
3fe6:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
3fe8:      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
3fea:      XFRB  AU,AL      ; [Transfer AU to AL]
3fec:      STAB+ B          ; [Store AL to address in B]
3fed:P3FED JSR/  F3391      ; =0x3391 =13201 [Jump to subroutine direct]
3ff0:P3FF0 JSR/  F41F9      ; =0x41f9 =16889 [Jump to subroutine direct]
3ff3:      DB    X'00'      ; =0x00 =0 =NUL
3ff4:W3FF4 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
3ff6:      JMP$  J3F74+1    ; =0x3f75 =16245 [Jump indirect]
3ff9:W3FF9 LDAB= X'06'      ; =6 [Load AL with immediate]
3ffb:      JMP   D3FFF      ; =+2 [Jump relative]
3ffd:W3FFD LDAB= X'05'      ; =5 [Load AL with immediate]
3fff:D3FFF STAB  B4012      ; =+17 [Store AL relative]
4001:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
4003:      JSR/  F303D      ; =0x303d =12349 [Jump to subroutine direct]
4006:      BZ    D400C      ; =+4 [Branch if zero]
4008:      JSR/  F35BA      ; =0x35ba =13754 [Jump to subroutine direct]
400b:      DB    X'06'      ; =0x06 =6
*
400c:D400C STB   W4013      ; =+5 [Store B relative]
400e:      JSR*  P3FED+1    ; =-34 [Jump to subroutine relative indirect]
4010:      JSR*  P3FF0+1    ; =-33 [Jump to subroutine relative indirect]
4012:B4012 DB    X'00'      ; =0x00 =0 =NUL
4013:W4013 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
4015:P4015 JMP/  W3644      ; =0x3644 =13892 [Jump direct]
4018:W4018 LDAB= X'07'      ; =7 [Load AL with immediate]
401a:D401A STAB  S4020      ; =+4 [Store AL relative]
401c:      JSR*  P3FED+1    ; =-48 [Jump to subroutine relative indirect]
401e:      JSR*  P3FF0+1    ; =-47 [Jump to subroutine relative indirect]
4020:S4020 DB    0,3        ; =0x00,0x0003
4023:      JMP*  P4015+1    ; =-15 [Jump relative]
4025:W4025 LDAB= X'08'      ; =8 [Load AL with immediate]
4027:      JMP   D401A      ; =-15 [Jump relative]
4029:W4029 LDAB= X'0C'      ; =12 [Load AL with immediate]
402b:      JMP   D401A      ; =-19 [Jump relative]
402d:W402D LDAB= X'0D'      ; =13 [Load AL with immediate]
402f:      JMP   D401A      ; =-23 [Jump relative]
4031:W4031 LDAB= X'0E'      ; =14 [Load AL with immediate]
4033:      JMP   D401A      ; =-27 [Jump relative]
4035:W4035 LDAB= X'0F'      ; =15 [Load AL with immediate]
4037:      JMP   D401A      ; =-31 [Jump relative]
4039:W4039 JSR/  F3096      ; =0x3096 =12438 [Jump to subroutine direct]
403c:      LDA   W406D      ; =+47 [Load A relative]
403e:      STA+  X+         ; [Store A indexed, direct, post-incremented]
4040:      LDAB= X'09'      ; =9 [Load AL with immediate]
4042:      STAB+ X+         ; [Store AL indexed, direct, post-incremented]
4044:      LDA/  W3634      ; =0x3634 =13876 [Load A direct]
4047:      LDB/  W3632      ; =0x3632 =13874 [Load B direct]
404a:      AAB              ; [A + B -> B]
404b:      STA+  X+         ; [Store A indexed, direct, post-incremented]
404d:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
404f:      LDAB+ B          ; [Load AL from address in B]
4050:      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
4052:      CLAB             ; [Clear AL]
4053:      STAB+ B          ; [Store AL to address in B]
4054:      FIL   (5)=X'00',-X ; [Fill with byte, literal=0, indexed]
4059:      LDAB= X'09'      ; =9 [Load AL with immediate]
405b:      STAB+ X,5        ; [Store AL indexed, displaced, direct]
405e:      JSR+  X,-5       ; [Jump to subroutine indexed, displaced, direct]
4061:      LDX/  W3003+1    ; =0x3004 =12292 [Load X direct]
4064:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
4066:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
4068:      STAB+ B          ; [Store AL to address in B]
4069:      JSR/  F35BA      ; =0x35ba =13754 [Jump to subroutine direct]
406c:      DB    X'09'      ; =0x09 =9
406d:W406D DW    X'6605'    ; =0x6605 =26117
*
406f:W406F LDA+  X,44       ; [Load A indexed, displaced, direct]
4072:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
4074:      JMP*  P4015+1    ; =-96 [Jump relative]
4076:W4076 LDA+  Y+         ; [Load A indexed, direct, post-incremented]
4078:      JSR/  F303D      ; =0x303d =12349 [Jump to subroutine direct]
407b:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
407d:      XABB             ; [Transfer AL to BL]
407e:      BM    D4098      ; =+24 [Branch on minus]
4080:      BZ    D408B      ; =+9 [Branch if zero]
4082:      JSR/  F30EC      ; =0x30ec =12524 [Jump to subroutine direct]
4085:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
4087:      STA+  B          ; [Store A to address in B]
4088:D4088 JMP/  W3644      ; =0x3644 =13892 [Jump direct]
408b:D408B JSR/  F311C      ; =0x311c =12572 [Jump to subroutine direct]
408e:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
4090:      MVF   (6)/W3632,-B ; =0x3632 =13874, [Move fixed-length, direct, indexed]
4096:      JMP   D4088      ; =-16 [Jump relative]
4098:D4098 JSR/  F3096      ; =0x3096 =12438 [Jump to subroutine direct]
409b:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
409d:      MVF   (4)/W3632,-B ; =0x3632 =13874, [Move fixed-length, direct, indexed]
40a3:      JMP   D4088      ; =-29 [Jump relative]
*
40a5:W40A5 DW    X'6660'    ; =0x6660 =26208
40a7:B40A7 DB    X'00'      ; =0x00 =0 =NUL
40a8:W40A8 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
40aa:      DB    X'09'      ; =0x09 =9
*
40ab:W40AB JSR/  F3470      ; =0x3470 =13424 [Jump to subroutine direct]
40ae:      JSR/  F3096      ; =0x3096 =12438 [Jump to subroutine direct]
40b1:      LDA/  W3634      ; =0x3634 =13876 [Load A direct]
40b4:      STA   W40C8      ; =+18 [Store A relative]
40b6:      LDA=  X'000A'    ; =0x000a =10 [Load A with immediate]
40b9:      LDB+  X,57       ; [Load B indexed, displaced, direct]
40bc:      STB   W40C6      ; =+8 [Store B relative]
40be:      STB   W40A8      ; =-24 [Store B relative]
40c0:      LDB/  W3632      ; =0x3632 =13874 [Load B direct]
40c3:      JSR/  F4E85      ; =0x4e85 =20101 [Jump to subroutine direct]
40c6:W40C6 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
40c8:W40C8 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
40ca:      JSR/  F30EC      ; =0x30ec =12524 [Jump to subroutine direct]
40cd:      XFRB  AU,AU      ; [Transfer AU to AU]
40cf:      BZ    D40D3      ; =+2 [Branch if zero]
40d1:      LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
40d3:D40D3 STAB  B40A7      ; =-46 [Store AL relative]
40d5:      LDB/  W3595+1    ; =0x3596 =13718 [Load B direct]
40d8:      LDA   W40A5      ; =-53 [Load A relative]
40da:      STA+  B+         ; [Store A indexed, direct, post-incremented]
40dc:      MVF   (6)/B40A7,-B ; =0x40a7 =16551, [Move fixed-length, direct, indexed]
40e2:      JSR$  W3595+1    ; =0x3596 =13718 [Jump to subroutine indirect]
40e5:      DB    X'71'      ; =0x71 =113
40e6:      DW    W3644      ; =0x3644 =13892
*
40e8:W40E8 JSR/  F30EC      ; =0x30ec =12524 [Jump to subroutine direct]
40eb:      STAB  B4109      ; =+28 [Store AL relative]
40ed:      LDA/  W3595+1    ; =0x3596 =13718 [Load A direct]
40f0:      ADD=  X'0008',A,B ; =0x0008 =8 [8 + A -> B]
40f4:      STB   W4106      ; =+16 [Store B relative]
40f6:      MVF   (9)/W4101,-A ; =0x4101 =16641, [Move fixed-length, direct, indexed]
40fc:      JSR+  A          ; [Jump to subroutine indexed, direct]
40fe:      JMP/  W3644      ; =0x3644 =13892 [Jump direct]
*
4101:W4101 DW    X'665D'    ; =0x665d =26205
4103:      DB    X'00'      ; =0x00 =0 =NUL
4104:      DW    X'0115'    ; =0x0115 =277
4106:W4106 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
4108:      DB    X'09'      ; =0x09 =9
4109:B4109 DB    X'00'      ; =0x00 =0 =NUL
410a:W410A DW    W3F9C      ; =0x3f9c =16284
410c:      DW    W3F9C      ; =0x3f9c =16284
410e:      DW    W36AD      ; =0x36ad =13997
4110:      DW    W378E      ; =0x378e =14222
4112:      DW    W377B      ; =0x377b =14203
4114:      DW    W375C      ; =0x375c =14172
4116:      DW    W3B25      ; =0x3b25 =15141
4118:      DW    W36E2      ; =0x36e2 =14050
411a:      DW    W37FE      ; =0x37fe =14334
411c:      DW    W386D      ; =0x386d =14445
411e:      DW    W3893      ; =0x3893 =14483
4120:      DW    W38CF      ; =0x38cf =14543
4122:      DW    W38BB      ; =0x38bb =14523
4124:      DW    W38A3      ; =0x38a3 =14499
4126:      DW    W39BE      ; =0x39be =14782
4128:      DW    W390A      ; =0x390a =14602
412a:      DW    W38FC      ; =0x38fc =14588
412c:      DW    W38E3      ; =0x38e3 =14563
412e:      DW    W38F0      ; =0x38f0 =14576
4130:      DW    W38F6      ; =0x38f6 =14582
4132:      DW    W3903      ; =0x3903 =14595
4134:      DW    W3ABC      ; =0x3abc =15036
4136:      DW    W3A10      ; =0x3a10 =14864
4138:      DW    W3A7B      ; =0x3a7b =14971
413a:      DW    W3AEF      ; =0x3aef =15087
413c:      DW    W36B2      ; =0x36b2 =14002
413e:      DW    W36C7      ; =0x36c7 =14023
4140:      DW    W36D8      ; =0x36d8 =14040
4142:      DW    W3742      ; =0x3742 =14146
4144:      DW    W3F9C      ; =0x3f9c =16284
4146:      DW    W3C13      ; =0x3c13 =15379
4148:      DW    W3B5B      ; =0x3b5b =15195
414a:      DW    W3AF1      ; =0x3af1 =15089
414c:      DW    W3C2D      ; =0x3c2d =15405
414e:      DW    W3DD9      ; =0x3dd9 =15833
4150:      DW    W3E0E      ; =0x3e0e =15886
4152:      DW    W3E24      ; =0x3e24 =15908
4154:      DW    W3F70      ; =0x3f70 =16240
4156:      DW    W3F77      ; =0x3f77 =16247
4158:      DW    W3BF5      ; =0x3bf5 =15349
415a:      DW    W3C0A      ; =0x3c0a =15370
415c:      DW    W3B2D      ; =0x3b2d =15149
415e:      DW    W3FB2      ; =0x3fb2 =16306
4160:      DW    W3E74      ; =0x3e74 =15988
4162:      DW    W37EC      ; =0x37ec =14316
4164:      DW    W3C47      ; =0x3c47 =15431
4166:      DW    W3D23      ; =0x3d23 =15651
4168:      DW    W4018      ; =0x4018 =16408
416a:      DW    W4025      ; =0x4025 =16421
416c:      DB    0,4        ; =0x00,0x0004
4170:      DW    W3F7C      ; =0x3f7c =16252
4172:      DW    W3D1F      ; =0x3d1f =15647
4174:      DW    W3FFD      ; =0x3ffd =16381
4176:      DW    W3FF9      ; =0x3ff9 =16377
4178:      DW    W4029      ; =0x4029 =16425
417a:      DW    W402D      ; =0x402d =16429
417c:      DW    W4031      ; =0x4031 =16433
417e:      DW    W4039      ; =0x4039 =16441
4180:      DW    W37AD      ; =0x37ad =14253
4182:      DW    W370B      ; =0x370b =14091
4184:      DW    W406F      ; =0x406f =16495
4186:      DW    W4076      ; =0x4076 =16502
4188:      DW    W4035      ; =0x4035 =16437
418a:      DW    W3F81      ; =0x3f81 =16257
418c:      DW    W3F92      ; =0x3f92 =16274
418e:      DW    W3FCE      ; =0x3fce =16334
4190:      DW    W40AB      ; =0x40ab =16555
4192:      DW    W40E8      ; =0x40e8 =16616
4194:W4194 JSR/  F302F      ; =0x302f =12335 [Jump to subroutine direct]
4197:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
4199:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
419b:      ZAD   -A(6),/N41ED(12) ; =0x41ed =16877 [Zero-add bignum, indexed, direct]
41a1:      M     -B(6),/N41ED(12) ; =0x41ed =16877 [Multiply bignums, indexed, direct]
41a7:      D     =1000000,/N41ED(12) ; =0x41ed =16877 [Divide bignums, literal=0x0f4240, direct]
41af:      ZAD   /N41ED(12),-A(6) ; =0x41ed =16877, [Zero-add bignum, direct, indexed]
41b5:      BNF   D41B9      ; =+2 [Branch on no fault]
41b7:      JSR   F41E0      ; =+39 [Jump to subroutine relative]
41b9:D41B9 RSR              ; [Return from subroutine]
*
* Function F41BA
*
41ba:F41BA JSR/  F302F      ; =0x302f =12335 [Jump to subroutine direct]
41bd:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
41bf:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
41c1:      ZAD   -A(6),/N41ED(12) ; =0x41ed =16877 [Zero-add bignum, indexed, direct]
41c7:      M     =1000000,/N41ED(12) ; =0x41ed =16877 [Multiply bignums, literal=0x0f4240, direct]
41cf:      D     -B(6),/N41ED(12) ; =0x41ed =16877 [Divide bignums, indexed, direct]
41d5:      BNF   D41D9      ; =+2 [Branch on no fault]
41d7:      JSR   F41E0      ; =+7 [Jump to subroutine relative]
41d9:D41D9 ZAD   /N41ED(12),-A(6) ; =0x41ed =16877, [Zero-add bignum, direct, indexed]
41df:      RSR              ; [Return from subroutine]
*
* Function F41E0
*
41e0:F41E0 STK   A,4        ; [Push A B to the stack]
41e2:      LDB/  W3003+1    ; =0x3004 =12292 [Load B direct]
41e5:      CLR   A,1        ; [Set A to 1]
41e7:      STAB+ B,62       ; [Store AL indexed, displaced, direct]
41ea:      POP   A,4        ; [Pop B A from the stack]
41ec:      RSR              ; [Return from subroutine]
*
41ed:N41ED DS    12         ; =0x000c [Uninitialized memory]
*
*
* Function F41F9
*
41f9:F41F9 XFR   Z,B        ; [Transfer Z to B]
41fb:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
41fd:      XFR   Y,B        ; [Transfer Y to B]
41ff:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
4201:      JSR/  F33A5      ; =0x33a5 =13221 [Jump to subroutine direct]
4204:      XFR   B,Y        ; [Transfer B to Y]
4206:      LDA+  Y          ; [Load A from address in Y]
4207:      XAZ              ; [Transfer A to Z]
4208:      CLA              ; [Clear A]
4209:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
420b:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
420d:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
420f:      STA+  Z,16       ; [Store A indexed, displaced, direct]
4212:      LDB+  A          ; [Load B from address in A]
4213:      STB+  Z,14       ; [Store B indexed, displaced, direct]
4216:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
4218:      LDB=  X'000F'    ; =0x000f =15 [Load B with immediate]
421b:      SAB              ; [A - B -> B]
421c:      BLE   D4222      ; =+4 [Branch if less than or equal to zero]
421e:W421E JSR/  F35BA      ; =0x35ba =13754 [Jump to subroutine direct]
4221:      DB    X'5D'      ; =0x5d =93
*
4222:D4222 STAB+ Z,3        ; [Store AL indexed, displaced, direct]
4225:      SLA              ; [Left shift A]
4226:      LDB=  W43C7      ; =0x43c7 =17351 [Load B with immediate]
4229:      AAB              ; [A + B -> B]
422a:      JMP+  *B         ; [Jump indexed, indirect]
422c:W422C LDAB= X'02'      ; =2 [Load AL with immediate]
422e:      STAB+ Z,3        ; [Store AL indexed, displaced, direct]
4231:W4231 LDAB+ Z,2        ; [Load AL indexed, displaced, direct]
4234:      SRRB  AL,2       ; [Right shift AL by 2]
4236:      BL    D423B      ; =+3 [Branch on link]
4238:      JMP/  J42D1      ; =0x42d1 =17105 [Jump direct]
423b:D423B JSR/  F43BE      ; =0x43be =17342 [Jump to subroutine direct]
423e:      DW    W4403      ; =0x4403 =17411
*
4240:W4240 JSR/  F435D      ; =0x435d =17245 [Jump to subroutine direct]
4243:      JMP   D424C      ; =+7 [Jump relative]
*
4245:W4245 DW    X'8588'    ; =0x8588 =34184(-31352)
4247:      DW    X'0D21'    ; =0x0d21 =3361
4249:      DW    X'1214'    ; =0x1214 =4628
424b:      DC    't'        ; hex:f4 dec:244(-12)
*
424c:D424C JSR/  F4290      ; =0x4290 =17040 [Jump to subroutine direct]
424f:W424F CLA              ; [Clear A]
4250:      LDAB+ Z          ; [Load AL from address in Z]
4251:      LDB/  W3003+1    ; =0x3004 =12292 [Load B direct]
4254:      STA+  B,42       ; [Store A indexed, displaced, direct]
4257:      STAB+ Y,4        ; [Store AL indexed, displaced, direct]
425a:      LDA+  *Z,16      ; [Load A indexed, displaced, indirect]
425d:      STA+  B,44       ; [Store A indexed, displaced, direct]
4260:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
4262:      XAY              ; [Transfer A to Y]
4263:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
4265:      XAZ              ; [Transfer A to Z]
4266:      RSR              ; [Return from subroutine]
*
4267:W4267 JSR/  F43BE      ; =0x43be =17342 [Jump to subroutine direct]
426a:      DW    W4411      ; =0x4411 =17425
426c:W426C STK   Y,2        ; [Push Y to the stack]
426e:      LDA+  Z,16       ; [Load A indexed, displaced, direct]
4271:      XAY              ; [Transfer A to Y]
4272:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
4274:      ADD   A,Y        ; [A + Y -> Y]
4276:      LDB=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load B with immediate]
4279:D4279 DCA              ; [Decrement A]
427a:      BLE   D4284      ; =+8 [Branch if less than or equal to zero]
427c:      LDBB- Y-         ; [Load BL indexed, pre-decremented, direct]
427e:      SUBB  BU,BL      ; [BU - BL -> BL]
4280:      BZ    D4279      ; =-9 [Branch if zero]
4282:      INR   Y          ; [Increment Y by 1]
4284:D4284 LDBB= X'8D'      ; =141(-115) =CR [Load BL with immediate]
4286:      STBB+ Y          ; [Store BL to address in Y]
4287:      INR   A,2        ; [Increment A by 2]
4289:      STA+  *Z,16      ; [Store A indexed, displaced, indirect]
428c:      POP   Y,2        ; [Pop Y from the stack]
428e:      JMP   W4231      ; =-95 [Jump relative]
*
* Function F4290
*
4290:F4290 XFR   Z,B        ; [Transfer Z to B]
4292:      JSR   F42B7      ; =+35 [Jump to subroutine relative]
4294:      DB    X'18'      ; =0x18 =24
*
4295:D4295 JSR   F42B7      ; =+32 [Jump to subroutine relative]
4297:      DB    X'07'      ; =0x07 =7
4298:      LDAB+ Z          ; [Load AL from address in Z]
4299:      BM    D4295      ; =-6 [Branch on minus]
429b:      LDB=  W42A5      ; =0x42a5 =17061 [Load B with immediate]
429e:      CLRB  AU         ; [Clear AU]
42a0:      AAB              ; [A + B -> B]
42a1:      LDAB+ B          ; [Load AL from address in B]
42a2:      BM    D42AB      ; =+7 [Branch on minus]
42a4:      RSR              ; [Return from subroutine]
*
42a5:W42A5 DW    X'0001'    ; =0x0001 =1
42a7:      DW    X'01FF'    ; =0x01ff =511
42a9:      DW    X'FFFF'    ; =0xffff =65535(-1)
*
42ab:D42AB LDAB+ Z,1        ; [Load AL indexed, displaced, direct]
42ae:      LDBB= X'22'      ; =34 [Load BL with immediate]
42b0:      AABB             ; [AL + BL -> BL]
42b1:      STBB  B42B6      ; =+3 [Store BL relative]
42b3:      JSR/  F35BA      ; =0x35ba =13754 [Jump to subroutine direct]
42b6:B42B6 DB    X'00'      ; =0x00 =0 =NUL
*
* Function F42B7
*
42b7:F42B7 DCR   S,2        ; [Decrement S by 2]
42b9:      MVF   (2)/W3003+1,-S ; =0x3004 =12292, [Move fixed-length, direct, indexed]
42bf:      MVF   (1)-X,/W42C6+1 ; =0x42c7 =17095 [Move fixed-length, indexed, direct]
42c5:      INX              ; [Increment X]
42c6:W42C6 SVC   X'00'      ; =0 [Service call PIOC - physical i/o control]
42c8:      MVF   (2)-S,/W3003+1 ; =0x3004 =12292 [Move fixed-length, indexed, direct]
42ce:      INR   S,2        ; [Increment S by 2]
42d0:      RSR              ; [Return from subroutine]
*
42d1:J42D1 LDA+  Z          ; [Load A from address in Z]
42d2:      LDB=  X'0014'    ; =0x0014 =20 [Load B with immediate]
42d5:      SVC   X'6B'      ; =107 [Service call ABRTR - abort with abort code in AL]
*
42d7:W42D7 LDAB+ Z,2        ; [Load AL indexed, displaced, direct]
42da:      SRAB             ; [Right shift AL]
42db:      BNL   J42D1      ; =-12 [Branch on no link]
42dd:      JSR/  F43BE      ; =0x43be =17342 [Jump to subroutine direct]
42e0:      DW    W441F      ; =0x441f =17439
42e2:W42E2 LDAB+ Z          ; [Load AL from address in Z]
42e3:      BNZ   D42E8      ; =+3 [Branch if not zero]
42e5:      JSR/  F4290      ; =0x4290 =17040 [Jump to subroutine direct]
42e8:D42E8 LDAB+ Z          ; [Load AL from address in Z]
42e9:      BZ    D42F2      ; =+7 [Branch if zero]
42eb:      CLA              ; [Clear A]
42ec:      LDB+  Z,16       ; [Load B indexed, displaced, direct]
42ef:      STA+  B+         ; [Store A indexed, direct, post-incremented]
42f1:      STAB+ B          ; [Store AL to address in B]
42f2:D42F2 JMP/  W424F      ; =0x424f =16975 [Jump direct]
42f5:W42F5 JSR/  F435D      ; =0x435d =17245 [Jump to subroutine direct]
42f8:      JMP   D4301      ; =+7 [Jump relative]
*
42fa:W42FA DW    X'8588'    ; =0x8588 =34184(-31352)
42fc:      DW    X'0D21'    ; =0x0d21 =3361
42fe:      DW    X'1214'    ; =0x1214 =4628
4300:      DC    't'        ; hex:f4 dec:244(-12)
*
4301:D4301 JSR/  F4290      ; =0x4290 =17040 [Jump to subroutine direct]
4304:      JMP   D42E8      ; =-30 [Jump relative]
4306:W4306 LDA+  Z,16       ; [Load A indexed, displaced, direct]
4309:      STAB+ Z,2        ; [Store AL indexed, displaced, direct]
430c:      JSR/  F4290      ; =0x4290 =17040 [Jump to subroutine direct]
430f:      LDAB= X'09'      ; =9 [Load AL with immediate]
4311:      STAB+ Z,3        ; [Store AL indexed, displaced, direct]
4314:      JSR/  F43BE      ; =0x43be =17342 [Jump to subroutine direct]
4317:      DW    W43F5      ; =0x43f5 =17397
4319:W4319 LDAB+ Z,2        ; [Load AL indexed, displaced, direct]
431c:      SRRB  AL,2       ; [Right shift AL by 2]
431e:      BNL   W4352      ; =+50 [Branch on no link]
4320:      JSR/  F43BE      ; =0x43be =17342 [Jump to subroutine direct]
4323:      DW    W43E7      ; =0x43e7 =17383
4325:W4325 LDAB+ Z,12       ; [Load AL indexed, displaced, direct]
4328:      DCAB             ; [Decrement AL]
4329:      BZ    W4352      ; =+39 [Branch if zero]
432b:      LDA=  W4457      ; =0x4457 =17495 [Load A with immediate]
432e:      JMP   D4333      ; =+3 [Jump relative]
*
4330:W4330 DB    X'90'      ; =0x90 =144(-112)
4331:      DW    W445B      ; =0x445b =17499
*
4333:D4333 LDB/  W3595+1    ; =0x3596 =13718 [Load B direct]
4336:      MVF   (4)-A,-B   ; [Move fixed-length, indexed, indexed]
433a:      STB+  Z,16       ; [Store B indexed, displaced, direct]
433d:      LDAB= X'02'      ; =2 [Load AL with immediate]
433f:      STAB+ Z,3        ; [Store AL indexed, displaced, direct]
4342:      JSR/  F4290      ; =0x4290 =17040 [Jump to subroutine direct]
4345:      LDA+  Z,4        ; [Load A indexed, displaced, direct]
4348:      BZ    W4352      ; =+8 [Branch if zero]
434a:      LDAB= X'0B'      ; =11 [Load AL with immediate]
434c:      STAB+ Z,3        ; [Store AL indexed, displaced, direct]
434f:      JSR/  F4290      ; =0x4290 =17040 [Jump to subroutine direct]
4352:W4352 LDAB= X'0A'      ; =10 [Load AL with immediate]
4354:      STAB+ Z,3        ; [Store AL indexed, displaced, direct]
4357:      JSR/  F4290      ; =0x4290 =17040 [Jump to subroutine direct]
435a:      JMP/  W424F      ; =0x424f =16975 [Jump direct]
*
* Function F435D
*
435d:F435D LDA+  Y,2        ; [Load A indexed, displaced, direct]
4360:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
4362:      LDX+  Z,26       ; [Load X indexed, displaced, direct]
4365:      JSR/  F303D      ; =0x303d =12349 [Jump to subroutine direct]
4368:      BM    D4390      ; =+38 [Branch on minus]
436a:      BZ    D4373      ; =+7 [Branch if zero]
436c:      ZAD   -B(2),-X(4) ; [Zero-add bignum, indexed, indexed]
4370:D4370 LDX+  S+         ; [Load X indexed, direct, post-incremented]
4372:      RSR              ; [Return from subroutine]
*
4373:D4373 MVF   (6)-B,/W3632 ; =0x3632 =13874 [Move fixed-length, indexed, direct]
4379:      D     =1000000,/W3632(6) ; =0x3632 =13874 [Divide bignums, literal=0x0f4240, direct]
4381:      ZAD   /W3632(6),-X(4) ; =0x3632 =13874, [Zero-add bignum, direct, indexed]
4387:      BNF   D4370      ; =-25 [Branch on no fault]
4389:      FIL   (4)=X'FF',-X ; [Fill with byte, literal=255(-1), indexed]
438e:      JMP   D4370      ; =-32 [Jump relative]
4390:D4390 FIL   (4)=X'00',-X ; [Fill with byte, literal=0, indexed]
4395:      JMP   D4370      ; =-39 [Jump relative]
4397:W4397 JSR/  F43BE      ; =0x43be =17342 [Jump to subroutine direct]
439a:      DW    W442D      ; =0x442d =17453
439c:W439C JSR   F435D      ; =-65 [Jump to subroutine relative]
439e:W439E JSR/  F4290      ; =0x4290 =17040 [Jump to subroutine direct]
43a1:      JMP/  W424F      ; =0x424f =16975 [Jump direct]
43a4:W43A4 JSR   F43BE      ; =+24 [Jump to subroutine relative]
43a6:      DW    W443B      ; =0x443b =17467
*
43a8:W43A8 JSR/  F4BE7      ; =0x4be7 =19431 [Jump to subroutine direct]
43ab:      JMP/  W424F      ; =0x424f =16975 [Jump direct]
43ae:W43AE JSR   F43BE      ; =+14 [Jump to subroutine relative]
43b0:      DW    W4449      ; =0x4449 =17481
43b2:W43B2 LDA+  Z,16       ; [Load A indexed, displaced, direct]
43b5:      STA+  Z,8        ; [Store A indexed, displaced, direct]
43b8:      JSR/  F4290      ; =0x4290 =17040 [Jump to subroutine direct]
43bb:      JMP/  W424F      ; =0x424f =16975 [Jump direct]
*
* Function F43BE
*
43be:F43BE LDA+  Y,5        ; [Load A indexed, displaced, direct]
43c1:      SLA              ; [Left shift A]
43c2:      LDB+  X          ; [Load B from address in X]
43c3:      AAB              ; [A + B -> B]
43c4:      LDX+  B          ; [Load X indexed, direct]
43c6:      RSR              ; [Return from subroutine]
*
43c7:W43C7 DW    W422C      ; =0x422c =16940
43c9:      DW    W42D7      ; =0x42d7 =17111
43cb:      DW    W4267      ; =0x4267 =16999
43cd:      DW    W4267      ; =0x4267 =16999
43cf:      DW    W421E      ; =0x421e =16926
43d1:      DW    W43AE      ; =0x43ae =17326
43d3:      DW    W43AE      ; =0x43ae =17326
43d5:      DW    W4397      ; =0x4397 =17303
43d7:      DW    W4397      ; =0x4397 =17303
43d9:      DW    W4306      ; =0x4306 =17158
43db:      DW    W4319      ; =0x4319 =17177
43dd:      DW    W421E      ; =0x421e =16926
43df:      DW    W43A4      ; =0x43a4 =17316
43e1:      DW    W43A4      ; =0x43a4 =17316
43e3:      DW    W43A4      ; =0x43a4 =17316
43e5:      DW    W43A4      ; =0x43a4 =17316
43e7:W43E7 DW    W4325      ; =0x4325 =17189
43e9:      DW    W4325      ; =0x4325 =17189
43eb:      DW    W4352      ; =0x4352 =17234
43ed:      DW    W4352      ; =0x4352 =17234
43ef:      DW    W4330      ; =0x4330 =17200
43f1:      DW    W421E      ; =0x421e =16926
43f3:      DW    W4352      ; =0x4352 =17234
43f5:W43F5 DW    W424F      ; =0x424f =16975
43f7:      DW    W424F      ; =0x424f =16975
43f9:      DW    W424F      ; =0x424f =16975
43fb:      DW    W424F      ; =0x424f =16975
43fd:      DW    W424F      ; =0x424f =16975
43ff:      DW    W421E      ; =0x421e =16926
4401:      DW    W43A8      ; =0x43a8 =17320
4403:W4403 DW    W4245      ; =0x4245 =16965
4405:      DW    W4245      ; =0x4245 =16965
4407:      DW    W4240      ; =0x4240 =16960
4409:      DW    W4240      ; =0x4240 =16960
440b:      DW    W4245      ; =0x4245 =16965
440d:      DW    W421E      ; =0x421e =16926
440f:      DW    W4245      ; =0x4245 =16965
4411:W4411 DW    W426C      ; =0x426c =17004
4413:      DW    W426C      ; =0x426c =17004
4415:      DW    W4231      ; =0x4231 =16945
4417:      DW    W4231      ; =0x4231 =16945
4419:      DW    W4231      ; =0x4231 =16945
441b:      DW    W421E      ; =0x421e =16926
441d:      DW    W4231      ; =0x4231 =16945
441f:W441F DW    W42E2      ; =0x42e2 =17122
4421:      DW    W42E2      ; =0x42e2 =17122
4423:      DW    W42F5      ; =0x42f5 =17141
4425:      DW    W42F5      ; =0x42f5 =17141
4427:      DW    W42E2      ; =0x42e2 =17122
4429:      DW    W421E      ; =0x421e =16926
442b:      DW    W42FA      ; =0x42fa =17146
442d:W442D DW    W424F      ; =0x424f =16975
442f:      DW    W424F      ; =0x424f =16975
4431:      DW    W439C      ; =0x439c =17308
4433:      DW    W439C      ; =0x439c =17308
4435:      DW    W424F      ; =0x424f =16975
4437:      DW    W421E      ; =0x421e =16926
4439:      DW    W439E      ; =0x439e =17310
443b:W443B DW    W421E      ; =0x421e =16926
443d:      DW    W421E      ; =0x421e =16926
443f:      DW    W421E      ; =0x421e =16926
4441:      DW    W421E      ; =0x421e =16926
4443:      DW    W421E      ; =0x421e =16926
4445:      DW    W421E      ; =0x421e =16926
4447:      DW    W43A8      ; =0x43a8 =17320
4449:W4449 DW    W43B2      ; =0x43b2 =17330
444b:      DW    W43B2      ; =0x43b2 =17330
444d:      DW    W421E      ; =0x421e =16926
444f:      DW    W421E      ; =0x421e =16926
4451:      DW    W43B2      ; =0x43b2 =17330
4453:      DW    W421E      ; =0x421e =16926
4455:      DW    W43A8      ; =0x43a8 =17320
4457:W4457 DW    X'0002'    ; =0x0002 =2
4459:      DW    X'848D'    ; =0x848d =33933(-31603) =EOT,CR
445b:W445B DW    X'0001'    ; =0x0001 =1
445d:      DB    X'84'      ; =0x84 =132(-124) =EOT
*
445e:J445E LDA+  Y+         ; [Load A indexed, direct, post-incremented]
4460:W4460 STA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store A immediate]
4463:      LDBB= X'21'      ; =33 [Load BL with immediate]
4465:      SABB             ; [AL - BL -> BL]
4466:      BLE   D446C      ; =+4 [Branch if less than or equal to zero]
4468:D4468 JSR/  F35BA      ; =0x35ba =13754 [Jump to subroutine direct]
446b:      DB    X'04'      ; =0x04 =4
*
446c:D446C CLRB  AU         ; [Clear AU]
446e:      SLA              ; [Left shift A]
446f:      LDB=  W447D      ; =0x447d =17533 [Load B with immediate]
4472:      AAB              ; [A + B -> B]
4473:      LDA+  B          ; [Load A from address in B]
4474:      BZ    D4468      ; =-14 [Branch if zero]
4476:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
4478:      JSR/  F30EC      ; =0x30ec =12524 [Jump to subroutine direct]
447b:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
447d:W447D JMP+  A          ; [Jump indexed, direct]
*
447f:      DW    W44C1      ; =0x44c1 =17601
4481:      DW    W44F2      ; =0x44f2 =17650
4483:      DW    W44F6      ; =0x44f6 =17654
4485:      DW    W4532      ; =0x4532 =17714
4487:      DW    W455C      ; =0x455c =17756
4489:      DW    W45DB      ; =0x45db =17883
448b:      DW    W45ED      ; =0x45ed =17901
448d:      DW    W461A      ; =0x461a =17946
448f:      DW    W45F3      ; =0x45f3 =17907
4491:      DW    W4635      ; =0x4635 =17973
4493:      DW    W4602      ; =0x4602 =17922
4495:      DW    W459C      ; =0x459c =17820
4497:      DW    W45B7      ; =0x45b7 =17847
4499:      DW    W464D      ; =0x464d =17997
449b:      DW    W4573      ; =0x4573 =17779
449d:      DW    W46C0      ; =0x46c0 =18112
449f:      DW    W46B4      ; =0x46b4 =18100
44a1:      DB    0,4        ; =0x00,0x0004
44a5:      DW    W4716      ; =0x4716 =18198
44a7:      DB    0,4        ; =0x00,0x0004
44ab:      DW    W4668      ; =0x4668 =18024
44ad:      DW    W46CC      ; =0x46cc =18124
44af:      DW    W462E      ; =0x462e =17966
44b1:      DW    W4632      ; =0x4632 =17970
44b3:      DW    W46C6      ; =0x46c6 =18118
44b5:      DB    0,6        ; =0x00,0x0006
44bb:      DW    W46DC      ; =0x46dc =18140
44bd:      DW    W4778      ; =0x4778 =18296
44bf:      DW    W478E      ; =0x478e =18318
*
44c1:W44C1 JSR/  F30E3      ; =0x30e3 =12515 [Jump to subroutine direct]
44c4:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
44c6:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
44c8:P44C8 JSR/  F3096      ; =0x3096 =12438 [Jump to subroutine direct]
44cb:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
44cd:P44CD LDB/  W3634      ; =0x3634 =13876 [Load B direct]
44d0:      AAB              ; [A + B -> B]
44d1:      STB*  P44CD+1    ; =-5 [Store B relative indirect]
44d3:      XAB              ; [Transfer A to B]
44d4:P44D4 LDA/  W3632      ; =0x3632 =13874 [Load A direct]
44d7:      SAB              ; [A - B -> B]
44d8:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
44da:      STB*  P44D4+1    ; =-7 [Store B relative indirect]
44dc:      BGZ   D44E1      ; =+3 [Branch if greater than zero]
44de:      CLA              ; [Clear A]
44df:      JMP   D44E4      ; =+3 [Jump relative]
44e1:D44E1 SAB              ; [A - B -> B]
44e2:      BGZ   J44E6      ; =+2 [Branch if greater than zero]
44e4:D44E4 STA*  P44D4+1    ; =-17 [Store A relative indirect]
44e6:J44E6 JSR/  F317E      ; =0x317e =12670 [Jump to subroutine direct]
44e9:P44E9 DW    W3632      ; =0x3632 =13874
44eb:W44EB LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
44ed:J44ED STAB- Z-         ; [Store AL indexed, pre-decremented, direct]
44ef:      JMP/  W3644      ; =0x3644 =13892 [Jump direct]
44f2:W44F2 LDAB= X'01'      ; =1 [Load AL with immediate]
44f4:      JMP   B44F7      ; =+1 [Jump relative]
44f6:W44F6 CLAB             ; [Clear AL]
44f7:B44F7 STAB= X'00'      ; =0 =NUL [Store AL immediate]
44f9:      JSR*  P44C8+1    ; =-50 [Jump to subroutine relative indirect]
44fb:      XFR   Y,A        ; [Transfer Y to A]
44fd:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
44ff:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
4501:      LDX*  P44E9      ; =-26 [Load X relative indirect]
4503:      BLE   D452B      ; =+38 [Branch if less than or equal to zero]
4505:      LDA*  P44CD+1    ; =-57 [Load A relative indirect]
4507:      XAY              ; [Transfer A to Y]
4508:D4508 LDAB+ Y          ; [Load AL from address in Y]
4509:      LDBB  B44F7+1    ; =-19 [Load BL relative]
450b:      BZ    D4518      ; =+11 [Branch if zero]
450d:      LDBB= X'E1'      ; =225(-31) ='a' [Load BL with immediate]
450f:      SABB             ; [AL - BL -> BL]
4510:      BM    D4526      ; =+20 [Branch on minus]
4512:      LDBB= X'20'      ; =32 [Load BL with immediate]
4514:      OREB  BL,AL      ; [BL ^ AL -> AL]
4516:      JMP   D4526      ; =+14 [Jump relative]
4518:D4518 LDBB= X'DA'      ; =218(-38) ='Z' [Load BL with immediate]
451a:      SABB             ; [AL - BL -> BL]
451b:      BGZ   D4526      ; =+9 [Branch if greater than zero]
451d:      LDBB= X'C1'      ; =193(-63) ='A' [Load BL with immediate]
451f:      SABB             ; [AL - BL -> BL]
4520:      BM    D4526      ; =+4 [Branch on minus]
4522:      LDBB= X'20'      ; =32 [Load BL with immediate]
4524:      ORIB  BL,AL      ; [BL | AL -> AL]
4526:D4526 STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
4528:      DCX              ; [Decrement X]
4529:      BGZ   D4508      ; =-35 [Branch if greater than zero]
452b:D452B LDX+  S+         ; [Load X indexed, direct, post-incremented]
452d:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
452f:      XAY              ; [Transfer A to Y]
4530:      JMP   J44E6      ; =-76 [Jump relative]
4532:W4532 JSR/  F3470      ; =0x3470 =13424 [Jump to subroutine direct]
4535:P4535 JSR/  F30EC      ; =0x30ec =12524 [Jump to subroutine direct]
4538:      JSR/  F345F      ; =0x345f =13407 [Jump to subroutine direct]
453b:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
453d:      JSR*  P44C8+1    ; =-118 [Jump to subroutine relative indirect]
453f:      LDA+  S          ; [Load A from address in S]
4540:      STX+  S          ; [Store X indexed, direct]
4542:      LDX+  X,57       ; [Load X indexed, displaced, direct]
4545:P4545 LDBB$ W3634      ; =0x3634 =13876 [Load BL indirect]
4548:      STX*  P4545+1    ; =-4 [Store X relative indirect]
454a:      STA*  P44E9      ; =-99 [Store A relative indirect]
454c:D454C DCA              ; [Decrement A]
454d:      BM    D4553      ; =+4 [Branch on minus]
454f:      STBB+ X+         ; [Store BL indexed, direct, post-incremented]
4551:      JMP   D454C      ; =-7 [Jump relative]
4553:D4553 XFR   X,A        ; [Transfer X to A]
4555:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
4557:      STA+  X,57       ; [Store A indexed, displaced, direct]
455a:      JMP   J44E6      ; =-118 [Jump relative]
455c:W455C JSR/  F3470      ; =0x3470 =13424 [Jump to subroutine direct]
455f:      JSR*  P4535+1    ; =-43 [Jump to subroutine relative indirect]
4561:      LDB+  X,57       ; [Load B indexed, displaced, direct]
4564:      STB*  P4545+1    ; =-32 [Store B relative indirect]
4566:      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
4568:      STB+  X,57       ; [Store B indexed, displaced, direct]
456b:      CLA              ; [Clear A]
456c:      INA              ; [Increment A]
456d:D456D STA/  W3632      ; =0x3632 =13874 [Store A direct]
4570:      JMP/  J44E6      ; =0x44e6 =17638 [Jump direct]
4573:W4573 LDA/  W4460+1    ; =0x4461 =17505 [Load A direct]
4576:      LDB=  X'2000'    ; =0x2000 =8192 [Load B with immediate]
4579:      NAB              ; [A & B -> B]
457a:      BZ    D458A      ; =+14 [Branch if zero]
457c:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
457f:      LDB=  X'0028'    ; =0x0028 =40 [Load B with immediate]
4582:      AAB              ; [A + B -> B]
4583:      STB*  P4545+1    ; =-63 [Store B relative indirect]
4585:      LDA=  X'0008'    ; =0x0008 =8 [Load A with immediate]
4588:      JMP   D456D      ; =-29 [Jump relative]
458a:D458A FIL   (6)=X'00',/W3632 ; =0x3632 =13874 [Fill with byte, literal=0, direct]
4590:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
4593:      MVF   (3)-A,34,/W3635 ; =0x3635 =13877 [Move fixed-length, displaced indexed, direct]
459a:      JMP   D45C3      ; =+39 [Jump relative]
459c:W459C JSR/  F3104      ; =0x3104 =12548 [Jump to subroutine direct]
459f:      BZ    D45A9      ; =+8 [Branch if zero]
45a1:      LDA+  Y          ; [Load A from address in Y]
45a2:      BP    D45E8      ; =+68 [Branch on plus]
45a4:      IVA              ; [Invert A]
45a5:      INA              ; [Increment A]
45a6:      STA+  Y          ; [Store A to address in Y]
45a7:      JMP   D45E8      ; =+63 [Jump relative]
45a9:D45A9 LDAB/ W3632      ; =0x3632 =13874 [Load AL direct]
45ac:      BP    D45CB      ; =+29 [Branch on plus]
45ae:      ZSU   /W3632(6),/W3632(6) ; =0x3632 =13874,=0x3632 =13874 [Zero-subtract bignum, direct, direct]
45b5:      JMP   D45CB      ; =+20 [Jump relative]
45b7:W45B7 JSR*  W459C+1    ; =-28 [Jump to subroutine relative indirect]
45b9:      BGZ   D45E8      ; =+45 [Branch if greater than zero]
45bb:      D     =1000000,/W3632(6) ; =0x3632 =13874 [Divide bignums, literal=0x0f4240, direct]
45c3:D45C3 M     =1000000,/W3632(6) ; =0x3632 =13874 [Multiply bignums, literal=0x0f4240, direct]
45cb:D45CB JSR/  F3156      ; =0x3156 =12630 [Jump to subroutine direct]
45ce:P45CE DW    W3632      ; =0x3632 =13874
45d0:      CLAB             ; [Clear AL]
45d1:      JMP   D45EA      ; =+23 [Jump relative]
45d3:      FIL   (6)=X'00',/W3632 ; =0x3632 =13874 [Fill with byte, literal=0, direct]
45d9:      JMP   D45CB      ; =-16 [Jump relative]
45db:W45DB JSR/  F3096      ; =0x3096 =12438 [Jump to subroutine direct]
45de:      CLA              ; [Clear A]
45df:      LDB*  P45CE      ; =-19 [Load B relative indirect]
45e1:      BLE   D45E6      ; =+3 [Branch if less than or equal to zero]
45e3:P45E3 LDAB$ W3634      ; =0x3634 =13876 [Load AL indirect]
45e6:D45E6 STA-  Y-         ; [Store A indexed, pre-decremented, direct]
45e8:D45E8 LDAB= X'01'      ; =1 [Load AL with immediate]
45ea:D45EA JMP/  J44ED      ; =0x44ed =17645 [Jump direct]
45ed:W45ED JSR*  W45DB+1    ; =-19 [Jump to subroutine relative indirect]
45ef:      LDA*  P45CE      ; =-35 [Load A relative indirect]
45f1:      JMP   D45E6      ; =-13 [Jump relative]
45f3:W45F3 JSR/  F30EC      ; =0x30ec =12524 [Jump to subroutine direct]
45f6:      JSR/  F345F      ; =0x345f =13407 [Jump to subroutine direct]
45f9:      STA+  *X,25      ; [Store A indexed, displaced, indirect]
45fc:      CLA              ; [Clear A]
45fd:      STA*  P45E3+1    ; =-27 [Store A relative indirect]
45ff:      JMP/  D456D      ; =0x456d =17773 [Jump direct]
4602:W4602 JSR/  F3104      ; =0x3104 =12548 [Jump to subroutine direct]
4605:      BGZ   D4610      ; =+9 [Branch if greater than zero]
4607:      ZAD   /W3632(6),/W3632(6) ; =0x3632 =13874,=0x3632 =13874 [Zero-add bignum, direct, direct]
460e:      JMP   D4612      ; =+2 [Jump relative]
4610:D4610 LDA+  Y+         ; [Load A indexed, direct, post-incremented]
4612:D4612 BZ    D45E6      ; =-46 [Branch if zero]
4614:      BM    W462E      ; =+24 [Branch on minus]
4616:      CLA              ; [Clear A]
4617:      INA              ; [Increment A]
4618:      JMP   D45E6      ; =-52 [Jump relative]
461a:W461A JSR*  W45F3+1    ; =-40 [Jump to subroutine relative indirect]
461c:      XABB             ; [Transfer AL to BL]
461d:      BLE   D462B      ; =+12 [Branch if less than or equal to zero]
461f:      LDBB= X'04'      ; =4 [Load BL with immediate]
4621:      SABB             ; [AL - BL -> BL]
4622:      BGZ   D462B      ; =+7 [Branch if greater than zero]
4624:      LDBB= X'19'      ; =25 [Load BL with immediate]
4626:      AABB             ; [AL + BL -> BL]
4627:      STBB  B4629      ; =+0 [Store BL relative]
4629:B4629 BS1   W462E      ; =+3 [Branch if Sense Switch 1 set]
462b:D462B CLA              ; [Clear A]
462c:      JMP   D45E6      ; =-72 [Jump relative]
462e:W462E CLA              ; [Clear A]
462f:      IVA              ; [Invert A]
4630:J4630 JMP   D45E6      ; =-76 [Jump relative]
4632:W4632 CLA              ; [Clear A]
4633:      JMP   D45E6      ; =-79 [Jump relative]
4635:W4635 JSR/  F3391      ; =0x3391 =13201 [Jump to subroutine direct]
4638:      XFRB  AL,AL      ; [Transfer AL to AL]
463a:      BNZ   D4643      ; =+7 [Branch if not zero]
463c:      LDB+  X,14       ; [Load B indexed, displaced, direct]
463f:      BZ    W462E      ; =-19 [Branch if zero]
4641:      JMP   D462B      ; =-24 [Jump relative]
4643:D4643 JSR/  F33A5      ; =0x33a5 =13221 [Jump to subroutine direct]
4646:      LDAB+ B,4        ; [Load AL indexed, displaced, direct]
4649:      BNZ   W462E      ; =-29 [Branch if not zero]
464b:      JMP   D462B      ; =-34 [Jump relative]
464d:W464D JSR*  W45F3+1    ; =-91 [Jump to subroutine relative indirect]
464f:      LDA+  X,42       ; [Load A indexed, displaced, direct]
4652:      LDBB+ X,61       ; [Load BL indexed, displaced, direct]
4655:      BZ    D465B      ; =+4 [Branch if zero]
4657:      ADD=  X'000A',A  ; =0x000a =10 [10 + A -> A]
465b:D465B LDBB+ X,62       ; [Load BL indexed, displaced, direct]
465e:      BZ    D4664      ; =+4 [Branch if zero]
4660:      ADD=  X'0064',A  ; =0x0064 =100 [100 + A -> A]
4664:D4664 CLRB  AU         ; [Clear AU]
4666:      JMP   J4630      ; =-56 [Jump relative]
4668:W4668 JSR*  W45F3+1    ; =-118 [Jump to subroutine relative indirect]
466a:      LDA+  X,46       ; [Load A indexed, displaced, direct]
466d:      BNZ   D4672      ; =+3 [Branch if not zero]
466f:      LDA=  X'007B'    ; =0x007b =123 [Load A with immediate]
4672:D4672 STA+  X,46       ; [Store A indexed, displaced, direct]
4675:      LDA+  X,46       ; [Load A indexed, displaced, direct]
4678:      SRA              ; [Right shift A]
4679:      SL               ; [Set link]
467a:      RLR   A          ; [Left rotate A by 1]
467c:      XAB              ; [Transfer A to B]
467d:      SLR   A,3        ; [Left shift A by 3]
467f:      AAB              ; [A + B -> B]
4680:      SLA              ; [Left shift A]
4681:      AAB              ; [A + B -> B]
4682:      SLR   A,2        ; [Left shift A by 2]
4684:      AAB              ; [A + B -> B]
4685:      SLR   A,3        ; [Left shift A by 3]
4687:      AAB              ; [A + B -> B]
4688:      STB+  X,46       ; [Store B indexed, displaced, direct]
468b:      XFR   B,A        ; [Transfer B to A]
468d:      RL               ; [Reset link]
468e:      RRR   A          ; [Right rotate A by 1]
4690:      SRA              ; [Right shift A]
4691:      STA   W46AC      ; =+25 [Store A relative]
4693:      CLA              ; [Clear A]
4694:      STA   W46A8      ; =+18 [Store A relative]
4696:      STA   W46AA      ; =+18 [Store A relative]
4698:      JSR/  W4194      ; =0x4194 =16788 [Jump to subroutine direct]
469b:      DW    W46A8      ; =0x46a8 =18088
469d:      DW    W46AE      ; =0x46ae =18094
*
469f:      JSR/  F3156      ; =0x3156 =12630 [Jump to subroutine direct]
46a2:      DW    W46A8      ; =0x46a8 =18088
46a4:      CLAB             ; [Clear AL]
46a5:      JMP/  D45EA      ; =0x45ea =17898 [Jump direct]
*
46a8:W46A8 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
46aa:W46AA DW    X'0000'    ; =0x0000 =0 =NUL,NUL
46ac:W46AC DW    X'0000'    ; =0x0000 =0 =NUL,NUL
46ae:W46AE DW    X'0000'    ; =0x0000 =0 =NUL,NUL
46b0:      DB    X'03'      ; =0x03 =3
46b1:      DC    '#'        ; hex:a3 dec:163(-93)
46b2:      DW    X'5294'    ; =0x5294 =21140
*
46b4:W46B4 JSR/  F30EC      ; =0x30ec =12524 [Jump to subroutine direct]
46b7:      XABB             ; [Transfer AL to BL]
46b8:      LDAB+ X,36       ; [Load AL indexed, displaced, direct]
46bb:      STBB+ X,36       ; [Store BL indexed, displaced, direct]
46be:      JMP   D4664      ; =-92 [Jump relative]
46c0:W46C0 LDA+  X,42       ; [Load A indexed, displaced, direct]
46c3:      JMP/  J4630      ; =0x4630 =17968 [Jump direct]
46c6:W46C6 LDA+  X,44       ; [Load A indexed, displaced, direct]
46c9:D46C9 JMP/  J4630      ; =0x4630 =17968 [Jump direct]
46cc:W46CC JSR   F46D2      ; =+4 [Jump to subroutine relative]
46ce:      CLRB  AU         ; [Clear AU]
46d0:      JMP   D46C9      ; =-9 [Jump relative]
*
* Function F46D2
*
46d2:F46D2 LDA/  X'005A'    ; =0x005a =90 [Load A direct]
46d5:      LDA+  A,3        ; [Load A indexed, displaced, direct]
46d8:      LDAB+ A,21       ; [Load AL indexed, displaced, direct]
46db:      RSR              ; [Return from subroutine]
*
46dc:W46DC JSR/  F3470      ; =0x3470 =13424 [Jump to subroutine direct]
46df:      JSR/  F30EC      ; =0x30ec =12524 [Jump to subroutine direct]
46e2:      XFRB  AU,AU      ; [Transfer AU to AU]
46e4:      BZ    D46E8      ; =+2 [Branch if zero]
46e6:      LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
46e8:D46E8 STAB  B4712      ; =+40 [Store AL relative]
46ea:      LDA+  X,57       ; [Load A indexed, displaced, direct]
46ed:      STA   W4713      ; =+36 [Store A relative]
46ef:      STA/  W3634      ; =0x3634 =13876 [Store A direct]
46f2:      LDB=  X'000A'    ; =0x000a =10 [Load B with immediate]
46f5:      STB/  W3632      ; =0x3632 =13874 [Store B direct]
46f8:      AAB              ; [A + B -> B]
46f9:      STB+  X,57       ; [Store B indexed, displaced, direct]
46fc:      JSR/  F317E      ; =0x317e =12670 [Jump to subroutine direct]
46ff:      DW    W3632      ; =0x3632 =13874
4701:      LDB/  W3595+1    ; =0x3596 =13718 [Load B direct]
4704:      MVF   (6)/W4710,-B ; =0x4710 =18192, [Move fixed-length, direct, indexed]
470a:      JSR$  W3595+1    ; =0x3596 =13718 [Jump to subroutine indirect]
470d:      DB    X'71'      ; =0x71 =113
470e:      DW    W44EB      ; =0x44eb =17643
4710:W4710 DW    X'665F'    ; =0x665f =26207
4712:B4712 DB    X'00'      ; =0x00 =0 =NUL
4713:W4713 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
4715:      DB    X'09'      ; =0x09 =9
*
4716:W4716 JSR/  F308A      ; =0x308a =12426 [Jump to subroutine direct]
4719:      XFR   Y,A        ; [Transfer Y to A]
471b:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
471d:      XFR   Z,A        ; [Transfer Z to A]
471f:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
4721:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
4723:      LDA/  W3634      ; =0x3634 =13876 [Load A direct]
4726:W4726 STA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store A immediate]
4729:D4729 LDX/  W3638      ; =0x3638 =13880 [Load X direct]
472c:P472C LDA/  W3632      ; =0x3632 =13874 [Load A direct]
472f:      SUB   X,A        ; [X - A -> A]
4731:      BGZ   D4753      ; =+32 [Branch if greater than zero]
4733:P4733 LDA/  W3634      ; =0x3634 =13876 [Load A direct]
4736:      XAY              ; [Transfer A to Y]
4737:      LDA/  W363A      ; =0x363a =13882 [Load A direct]
473a:      XAZ              ; [Transfer A to Z]
473b:D473B LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
473d:      LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
473f:      SABB             ; [AL - BL -> BL]
4740:      BNZ   D4747      ; =+5 [Branch if not zero]
4742:      DCX              ; [Decrement X]
4743:      BNZ   D473B      ; =-10 [Branch if not zero]
4745:      JMP   D475E      ; =+23 [Jump relative]
4747:D4747 LDA*  P472C+1    ; =-28 [Load A relative indirect]
4749:      DCA              ; [Decrement A]
474a:      STA*  P472C+1    ; =-31 [Store A relative indirect]
474c:      LDA*  P4733+1    ; =-26 [Load A relative indirect]
474e:      INA              ; [Increment A]
474f:      STA*  P4733+1    ; =-29 [Store A relative indirect]
4751:      JMP   D4729      ; =-42 [Jump relative]
4753:D4753 LDX+  S+         ; [Load X indexed, direct, post-incremented]
4755:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
4757:      XAZ              ; [Transfer A to Z]
4758:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
475a:      XAY              ; [Transfer A to Y]
475b:      JMP/  W462E      ; =0x462e =17966 [Jump direct]
475e:D475E LDA*  P4733+1    ; =-44 [Load A relative indirect]
4760:      LDB   W4726+1    ; =-59 [Load B relative]
4762:      SAB              ; [A - B -> B]
4763:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
4765:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
4767:      XAZ              ; [Transfer A to Z]
4768:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
476a:      XAY              ; [Transfer A to Y]
476b:      XFR   B,A        ; [Transfer B to A]
476d:      JMP/  D45E6      ; =0x45e6 =17894 [Jump direct]
*
4770:      DW    X'0102'    ; =0x0102 =258
4772:      DW    X'0408'    ; =0x0408 =1032
4774:      DW    X'1020'    ; =0x1020 =4128
4776:      DW    X'4080'    ; =0x4080 =16512
*
4778:W4778 JSR/  F3104      ; =0x3104 =12548 [Jump to subroutine direct]
477b:      BZ    D4782      ; =+5 [Branch if zero]
477d:      JSR/  F3190      ; =0x3190 =12688 [Jump to subroutine direct]
4780:      DW    W3632      ; =0x3632 =13874
*
4782:D4782 JSR/  F47A4      ; =0x47a4 =18340 [Jump to subroutine direct]
4785:      JSR/  F3156      ; =0x3156 =12630 [Jump to subroutine direct]
4788:      DW    W3638      ; =0x3638 =13880
478a:      CLAB             ; [Clear AL]
478b:      JMP/  D45EA      ; =0x45ea =17898 [Jump direct]
478e:W478E JSR/  F3104      ; =0x3104 =12548 [Jump to subroutine direct]
4791:      BZ    D4798      ; =+5 [Branch if zero]
4793:      JSR/  F3190      ; =0x3190 =12688 [Jump to subroutine direct]
4796:      DW    W3632      ; =0x3632 =13874
*
4798:D4798 JSR/  W4862      ; =0x4862 =18530 [Jump to subroutine direct]
479b:      JMP/  D45CB      ; =0x45cb =17867 [Jump direct]
*
479e:S479E DB    0,3        ; =0x00,0x0003
47a1:      DW    X'297A'    ; =0x297a =10618
47a3:      DB    X'4A'      ; =0x4a =74
*
* Function F47A4
*
47a4:F47A4 FIL   (6)=X'00',/W3638 ; =0x3638 =13880 [Fill with byte, literal=0, direct]
47aa:D47AA MVF   (6)/W3632,/W482C ; =0x3632 =13874,=0x482c =18476 [Move fixed-length, direct, direct]
47b1:      S     /S479E(6),/W482C(6) ; =0x479e =18334,=0x482c =18476 [Subtract bignums, direct, direct]
47b8:      LDAB/ W482C      ; =0x482c =18476 [Load AL direct]
47bb:      BM    D47CD      ; =+16 [Branch on minus]
47bd:      A     /S4850(6),/W3638(6) ; =0x4850 =18512,=0x3638 =13880 [Add bignums, direct, direct]
47c4:      JSR/  F41BA      ; =0x41ba =16826 [Jump to subroutine direct]
47c7:      DW    W3632      ; =0x3632 =13874
47c9:      DW    S479E      ; =0x479e =18334
47cb:      JMP   D47AA      ; =-35 [Jump relative]
47cd:D47CD MVF   (6)/W3632,/W4832 ; =0x3632 =13874,=0x4832 =18482 [Move fixed-length, direct, direct]
47d4:      A     /S4850(6),/W4832(6) ; =0x4850 =18512,=0x4832 =18482 [Add bignums, direct, direct]
47db:      S     /S4850(6),/W3632(6) ; =0x4850 =18512,=0x3632 =13874 [Subtract bignums, direct, direct]
47e2:      JSR/  F41BA      ; =0x41ba =16826 [Jump to subroutine direct]
47e5:      DW    W3632      ; =0x3632 =13874
47e7:      DW    W4832      ; =0x4832 =18482
47e9:      MVF   (6)/S4850,/W4838 ; =0x4850 =18512,=0x4838 =18488 [Move fixed-length, direct, direct]
47f0:      MVF   (6)/W3632,/W483E ; =0x3632 =13874,=0x483e =18494 [Move fixed-length, direct, direct]
47f7:D47F7 MVF   (6)/W483E,/W4832 ; =0x483e =18494,=0x4832 =18482 [Move fixed-length, direct, direct]
47fe:      M     =2,/W4832(6) ; =0x4832 =18482 [Multiply bignums, literal=0x02, direct]
4804:      JSR/  F41BA      ; =0x41ba =16826 [Jump to subroutine direct]
4807:      DW    W4832      ; =0x4832 =18482
4809:      DW    W4838      ; =0x4838 =18488
480b:      BZ    D482B      ; =+30 [Branch if zero]
480d:      A     /W4832(6),/W3638(6) ; =0x4832 =18482,=0x3638 =13880 [Add bignums, direct, direct]
4814:      A     /N4856(6),/W4838(6) ; =0x4856 =18518,=0x4838 =18488 [Add bignums, direct, direct]
481b:      JSR/  W4194      ; =0x4194 =16788 [Jump to subroutine direct]
481e:      DW    W483E      ; =0x483e =18494
4820:      DW    W3632      ; =0x3632 =13874
*
4822:      JSR/  W4194      ; =0x4194 =16788 [Jump to subroutine direct]
4825:      DW    W483E      ; =0x483e =18494
4827:      DW    W3632      ; =0x3632 =13874
4829:      JMP   D47F7      ; =-52 [Jump relative]
482b:D482B RSR              ; [Return from subroutine]
*
482c:W482C DS    6          ; =0x0006 [Uninitialized memory]
4832:W4832 DS    6          ; =0x0006 [Uninitialized memory]
4838:W4838 DS    6          ; =0x0006 [Uninitialized memory]
483e:W483E DS    18         ; =0x0012 [Uninitialized memory]
4850:S4850 DB    0,3        ; =0x00,0x0003
4853:      DW    X'0F42'    ; =0x0f42 =3906
4855:      DB    X'40'      ; =0x40 =64
4856:N4856 DB    0,3        ; =0x00,0x0003
4859:      DW    X'1E84'    ; =0x1e84 =7812
485b:      DW    X'8000'    ; =0x8000 =32768(-32768)
485d:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
485f:      DB    X'2D'      ; =0x2d =45
4860:      DC    'F@'       ; hex:c6c0 dec:50880(-64)
4862:W4862 MVF   (6)/S4850,/W4912 ; =0x4850 =18512,=0x4912 =18706 [Move fixed-length, direct, direct]
4869:      MVF   (6)/W3632,/W4936 ; =0x3632 =13874,=0x4936 =18742 [Move fixed-length, direct, direct]
4870:      D     =1000000,/W4936(6) ; =0x4936 =18742 [Divide bignums, literal=0x0f4240, direct]
4878:      M     =1000000,/W4936(6) ; =0x4936 =18742 [Multiply bignums, literal=0x0f4240, direct]
4880:      S     /W4936(6),/W3632(6) ; =0x4936 =18742,=0x3632 =13874 [Subtract bignums, direct, direct]
4887:      MVF   (6)/W3632,/W4918 ; =0x3632 =13874,=0x4918 =18712 [Move fixed-length, direct, direct]
488e:      MVF   (6)/S4850,/W491E ; =0x4850 =18512,=0x491e =18718 [Move fixed-length, direct, direct]
4895:      MVF   (6)/S4850,/W4924 ; =0x4850 =18512,=0x4924 =18724 [Move fixed-length, direct, direct]
489c:D489C MVF   (6)/W4912,/W492A ; =0x4912 =18706,=0x492a =18730 [Move fixed-length, direct, direct]
48a3:      MVF   (6)/W3632,/W4930 ; =0x3632 =13874,=0x4930 =18736 [Move fixed-length, direct, direct]
48aa:      JSR/  F41BA      ; =0x41ba =16826 [Jump to subroutine direct]
48ad:      DW    W4930      ; =0x4930 =18736
48af:      DW    W491E      ; =0x491e =18718
48b1:      A     /W4930(6),/W4912(6) ; =0x4930 =18736,=0x4912 =18706 [Add bignums, direct, direct]
48b8:      MVF   (6)/W4912,/W4930 ; =0x4912 =18706,=0x4930 =18736 [Move fixed-length, direct, direct]
48bf:      S     /W492A(6),/W4930(6) ; =0x492a =18730,=0x4930 =18736 [Subtract bignums, direct, direct]
48c6:      BZ    D48DF      ; =+23 [Branch if zero]
48c8:      JSR/  W4194      ; =0x4194 =16788 [Jump to subroutine direct]
48cb:      DW    W3632      ; =0x3632 =13874
48cd:      DW    W4918      ; =0x4918 =18712
48cf:      A     /S4850(6),/W4924(6) ; =0x4850 =18512,=0x4924 =18724 [Add bignums, direct, direct]
48d6:      JSR/  W4194      ; =0x4194 =16788 [Jump to subroutine direct]
48d9:      DW    W491E      ; =0x491e =18718
48db:      DW    W4924      ; =0x4924 =18724
48dd:      JMP   D489C      ; =-67 [Jump relative]
48df:D48DF ZAD   /W4936(6),/W4936(6) ; =0x4936 =18742,=0x4936 =18742 [Zero-add bignum, direct, direct]
48e6:      BZ    D490A      ; =+34 [Branch if zero]
48e8:      BM    D48FA      ; =+16 [Branch on minus]
48ea:      S     /S4850(6),/W4936(6) ; =0x4850 =18512,=0x4936 =18742 [Subtract bignums, direct, direct]
48f1:      JSR/  W4194      ; =0x4194 =16788 [Jump to subroutine direct]
48f4:      DW    W4912      ; =0x4912 =18706
48f6:      DW    S479E      ; =0x479e =18334
48f8:      JMP   D48DF      ; =-27 [Jump relative]
48fa:D48FA A     /S4850(6),/W4936(6) ; =0x4850 =18512,=0x4936 =18742 [Add bignums, direct, direct]
4901:      JSR/  F41BA      ; =0x41ba =16826 [Jump to subroutine direct]
4904:      DW    W4912      ; =0x4912 =18706
4906:      DW    S479E      ; =0x479e =18334
4908:      JMP   D48DF      ; =-43 [Jump relative]
490a:D490A MVF   (6)/W4912,/W3632 ; =0x4912 =18706,=0x3632 =13874 [Move fixed-length, direct, direct]
4911:      RSR              ; [Return from subroutine]
*
4912:W4912 DS    6          ; =0x0006 [Uninitialized memory]
4918:W4918 DS    6          ; =0x0006 [Uninitialized memory]
491e:W491E DS    6          ; =0x0006 [Uninitialized memory]
4924:W4924 DS    6          ; =0x0006 [Uninitialized memory]
492a:W492A DS    6          ; =0x0006 [Uninitialized memory]
4930:W4930 DS    6          ; =0x0006 [Uninitialized memory]
4936:W4936 DS    6          ; =0x0006 [Uninitialized memory]
*
*
* Function F493C
*
493c:F493C STX-  S-         ; [Store X indexed, pre-decremented, direct]
493e:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
4941:      LDA+  A,3        ; [Load A indexed, displaced, direct]
4944:      LDA+  A,10       ; [Load A indexed, displaced, direct]
4947:      STA/  W3595+1    ; =0x3596 =13718 [Store A direct]
494a:      XAB              ; [Transfer A to B]
494b:      ADD=  X'008C',A  ; =0x008c =140 =NUL,FF [140 + A -> A]
494f:      STA/  W3003+1    ; =0x3004 =12292 [Store A direct]
4952:      XAZ              ; [Transfer A to Z]
4953:      XAX              ; [Transfer A to X]
4954:      INR   Z,15       ; [Increment Z by 15]
4956:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
4958:      AAB              ; [A + B -> B]
4959:      BL    D49BF      ; =+100 [Branch on link]
495b:      STB+  X,30       ; [Store B indexed, displaced, direct]
495e:      CLA              ; [Clear A]
495f:      LDAB+ X,29       ; [Load AL indexed, displaced, direct]
4962:      SLR   A,3        ; [Left shift A by 3]
4964:      AAB              ; [A + B -> B]
4965:      BL    D49BF      ; =+88 [Branch on link]
4967:      LDA+  X,34       ; [Load A indexed, displaced, direct]
496a:      STA/  W4B63+1    ; =0x4b64 =19300 [Store A direct]
496d:      STB+  X,34       ; [Store B indexed, displaced, direct]
4970:      SLR   A,2        ; [Left shift A by 2]
4972:      AAB              ; [A + B -> B]
4973:      BL    D49BF      ; =+74 [Branch on link]
4975:      STB+  X,2        ; [Store B indexed, displaced, direct]
4978:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
497a:      SLR   A,2        ; [Left shift A by 2]
497c:      AAB              ; [A + B -> B]
497d:      BL    D49BF      ; =+64 [Branch on link]
497f:      STB+  X,4        ; [Store B indexed, displaced, direct]
4982:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
4984:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
4986:      JSR/  F31B5      ; =0x31b5 =12725 [Jump to subroutine direct]
4989:      AAB              ; [A + B -> B]
498a:      BL    D49BF      ; =+51 [Branch on link]
498c:      STB+  X,6        ; [Store B indexed, displaced, direct]
498f:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
4991:      SLA              ; [Left shift A]
4992:      AAB              ; [A + B -> B]
4993:      BL    D49BF      ; =+42 [Branch on link]
4995:      STB+  X,8        ; [Store B indexed, displaced, direct]
4998:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
499a:      SLR   A,2        ; [Left shift A by 2]
499c:      AAB              ; [A + B -> B]
499d:      BL    D49BF      ; =+32 [Branch on link]
499f:      STB+  X,53       ; [Store B indexed, displaced, direct]
49a2:      LDA=  X'0020'    ; =0x0020 =32 [Load A with immediate]
49a5:      AAB              ; [A + B -> B]
49a6:      BL    D49BF      ; =+23 [Branch on link]
49a8:      STB+  X,39       ; [Store B indexed, displaced, direct]
49ab:      LDA/  W3595+1    ; =0x3596 =13718 [Load A direct]
49ae:      LDB+  Z+         ; [Load B indexed, direct, post-incremented]
49b0:      BZ    D49B5      ; =+3 [Branch if zero]
49b2:      AAB              ; [A + B -> B]
49b3:      BL    D49BF      ; =+10 [Branch on link]
49b5:D49B5 STB+  X,16       ; [Store B indexed, displaced, direct]
49b8:      STB+  X,14       ; [Store B indexed, displaced, direct]
49bb:      LDB+  Z          ; [Load B from address in Z]
49bc:      AAB              ; [A + B -> B]
49bd:      BNL   D49C6      ; =+7 [Branch on no link]
49bf:D49BF CLA              ; [Clear A]
49c0:      DCA              ; [Decrement A]
49c1:      LDB=  X'005B'    ; =0x005b =91 [Load B with immediate]
49c4:      SVC   X'6B'      ; =107 [Service call ABRTR - abort with abort code in AL]
*
49c6:D49C6 STB+  X,59       ; [Store B indexed, displaced, direct]
49c9:      LDB+  X,39       ; [Load B indexed, displaced, direct]
49cc:      LDA=  X'000B'    ; =0x000b =11 [Load A with immediate]
49cf:      AAB              ; [A + B -> B]
49d0:      BL    D49BF      ; =-19 [Branch on link]
49d2:      STB+  X,23       ; [Store B indexed, displaced, direct]
49d5:      LDA+  X,32       ; [Load A indexed, displaced, direct]
49d8:      INR   A,3        ; [Increment A by 3]
49da:      AAB              ; [A + B -> B]
49db:      BL    D49BF      ; =-30 [Branch on link]
49dd:      STB+  X,25       ; [Store B indexed, displaced, direct]
49e0:      LDA+  X,32       ; [Load A indexed, displaced, direct]
49e3:      INR   A,3        ; [Increment A by 3]
49e5:      AAB              ; [A + B -> B]
49e6:      BL    D49BF      ; =-41 [Branch on link]
49e8:      LDA=  X'0018'    ; =0x0018 =24 [Load A with immediate]
49eb:      AAB              ; [A + B -> B]
49ec:      BL    D49BF      ; =-47 [Branch on link]
49ee:      STB+  X,18       ; [Store B indexed, displaced, direct]
49f1:      LDA=  X'0030'    ; =0x0030 =48 [Load A with immediate]
49f4:      AAB              ; [A + B -> B]
49f5:      BL    D49BF      ; =-56 [Branch on link]
49f7:      STB+  X,55       ; [Store B indexed, displaced, direct]
49fa:      INR   B,16       ; [Increment B by 16]
49fc:      STB/  W4BE0+1    ; =0x4be1 =19425 [Store B direct]
49ff:      LDA=  X'002D'    ; =0x002d =45 [Load A with immediate]
4a02:      AAB              ; [A + B -> B]
4a03:      BL    D49BF      ; =-70 [Branch on link]
4a05:      STB/  W4BDC+1    ; =0x4bdd =19421 [Store B direct]
4a08:      XFR   B,Z        ; [Transfer B to Z]
4a0a:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
4a0d:      LDA+  A,3        ; [Load A indexed, displaced, direct]
4a10:      LDA+  A,12       ; [Load A indexed, displaced, direct]
4a13:      STA+  X          ; [Store A to address in X]
4a14:      LDAB+ X,29       ; [Load AL indexed, displaced, direct]
4a17:      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
4a19:      JSR/  F46D2      ; =0x46d2 =18130 [Jump to subroutine direct]
4a1c:      STAB+ X,52       ; [Store AL indexed, displaced, direct]
4a1f:      CLA              ; [Clear A]
4a20:      STA+  X,46       ; [Store A indexed, displaced, direct]
4a23:J4A23 CLA              ; [Clear A]
4a24:      LDAB+ S          ; [Load AL from address in S]
4a25:      BNZ   D4A2C      ; =+5 [Branch if not zero]
4a27:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
4a29:      JMP/  J4B62      ; =0x4b62 =19298 [Jump direct]
4a2c:D4A2C DCAB             ; [Decrement AL]
4a2d:      STAB+ S          ; [Store AL to address in S]
4a2e:      SLR   A,3        ; [Left shift A by 3]
4a30:      XAY              ; [Transfer A to Y]
4a31:      LDA+  X,30       ; [Load A indexed, displaced, direct]
4a34:      ADD   A,Y        ; [A + Y -> Y]
4a36:      CLR   B          ; [Clear B]
4a38:      LDA=  X'0C00'    ; =0x0c00 =3072 [Load A with immediate]
4a3b:      LDAB+ Y,5        ; [Load AL indexed, displaced, direct]
4a3e:      BM    D4A75      ; =+53 [Branch on minus]
4a40:      ANDB  AL,AU      ; [AL & AU -> AU]
4a42:      BZ    D4A62      ; =+30 [Branch if zero]
4a44:      LDA+  Y          ; [Load A from address in Y]
4a45:      BGZ   D4A4A      ; =+3 [Branch if greater than zero]
4a47:      LDA+  X,32       ; [Load A indexed, displaced, direct]
4a4a:D4A4A DCA              ; [Decrement A]
4a4b:      DIV=  X'0190',A,B ; =0x0190 =400 [A / 400 -> B]
4a4f:      INR   B,2        ; [Increment B by 2]
4a51:      MUL=  X'0190',B  ; =0x0190 =400 [400 * B -> B]
4a55:      STB   W4A9E+1    ; =+72 [Store B relative]
4a57:      INR   B,3        ; [Increment B by 3]
4a59:      XFR   Z,A        ; [Transfer Z to A]
4a5b:      ADD   B,Z        ; [B + Z -> Z]
4a5d:      BL    D4A72      ; =+19 [Branch on link]
4a5f:      XAB              ; [Transfer A to B]
4a60:      JMP   D4A75      ; =+19 [Jump relative]
4a62:D4A62 SRAB             ; [Right shift AL]
4a63:      BNL   D4A75      ; =+16 [Branch on no link]
4a65:      XFR   Z,B        ; [Transfer Z to B]
4a67:      LDA=  X'0190'    ; =0x0190 =400 [Load A with immediate]
4a6a:      STA   W4A9E+1    ; =+51 [Store A relative]
4a6c:      INR   A,3        ; [Increment A by 3]
4a6e:      ADD   A,Z        ; [A + Z -> Z]
4a70:      BNL   D4A75      ; =+3 [Branch on no link]
4a72:D4A72 JMP/  D49BF      ; =0x49bf =18879 [Jump direct]
4a75:D4A75 STB-  S-         ; [Store B indexed, pre-decremented, direct]
4a77:      XFR   Z,B        ; [Transfer Z to B]
4a79:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
4a7b:      INR   Z,4        ; [Increment Z by 4]
4a7d:D4A7D LDA+  X          ; [Load A from address in X]
4a7e:      DCR   A,16       ; [Decrement A by 16]
4a80:      DCR   A,15       ; [Decrement A by 15]
4a82:      SUB   Z,A        ; [Z - A -> A]
4a84:      BNL   D4A92      ; =+12 [Branch on no link]
4a86:      SVC   X'59'      ; =89 [Service call ASEG - add next free mem segment to CURTB [wait for comp]]
4a88:      SVC   X'07'      ; =7 [Service call WT - unconditional wait]
4a8a:      LDA+  X          ; [Load A from address in X]
4a8b:      LDB=  X'0800'    ; =0x0800 =2048 [Load B with immediate]
4a8e:      AAB              ; [A + B -> B]
4a8f:      STB+  X          ; [Store B to address in X]
4a90:      JMP   D4A7D      ; =-21 [Jump relative]
4a92:D4A92 LDB+  S+         ; [Load B indexed, direct, post-incremented]
4a94:      STB+  Z,26       ; [Store B indexed, displaced, direct]
4a97:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
4a99:      STB+  Z,6        ; [Store B indexed, displaced, direct]
4a9c:      BZ    D4AA1      ; =+3 [Branch if zero]
4a9e:W4A9E LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
4aa1:D4AA1 STB+  Z,4        ; [Store B indexed, displaced, direct]
4aa4:      CLA              ; [Clear A]
4aa5:      LDAB+ Y,4        ; [Load AL indexed, displaced, direct]
4aa8:      STA+  Z          ; [Store A to address in Z]
4aa9:      CLA              ; [Clear A]
4aaa:      STA+  Z,2        ; [Store A indexed, displaced, direct]
4aad:      LDAB+ Y,5        ; [Load AL indexed, displaced, direct]
4ab0:      BM    D4AEF      ; =+61 [Branch on minus]
4ab2:      SRAB             ; [Right shift AL]
4ab3:      BZ    D4AEF      ; =+58 [Branch if zero]
4ab5:      LDBB= X'02'      ; =2 [Load BL with immediate]
4ab7:      STBB+ Z,12       ; [Store BL indexed, displaced, direct]
4aba:      LDBB= X'03'      ; =3 [Load BL with immediate]
4abc:      STBB+ Z,13       ; [Store BL indexed, displaced, direct]
4abf:      LDA=  X'0003'    ; =0x0003 =3 [Load A with immediate]
4ac2:      LDB+  Z,4        ; [Load B indexed, displaced, direct]
4ac5:      BNZ   D4AC8      ; =+1 [Branch if not zero]
4ac7:      DCA              ; [Decrement A]
4ac8:D4AC8 STA+  Z,10       ; [Store A indexed, displaced, direct]
4acb:      LDB+  Y          ; [Load B from address in Y]
4acc:      BGZ   D4AD1      ; =+3 [Branch if greater than zero]
4ace:      LDB+  X,32       ; [Load B indexed, displaced, direct]
4ad1:D4AD1 STB+  Z,28       ; [Store B indexed, displaced, direct]
4ad4:      LDAB+ Y,5        ; [Load AL indexed, displaced, direct]
4ad7:      SRAB             ; [Right shift AL]
4ad8:      LDBB= X'06'      ; =6 [Load BL with immediate]
4ada:      NABB             ; [AL & BL -> BL]
4adb:      BZ    D4B25      ; =+72 [Branch if zero]
4add:      LDB=  X'0006'    ; =0x0006 =6 [Load B with immediate]
4ae0:      STB+  Z,10       ; [Store B indexed, displaced, direct]
4ae3:      LDBB= X'02'      ; =2 [Load BL with immediate]
4ae5:      SABB             ; [AL - BL -> BL]
4ae6:      BNZ   D4B25      ; =+61 [Branch if not zero]
4ae8:      LDAB= X'06'      ; =6 [Load AL with immediate]
4aea:      STAB+ Z,13       ; [Store AL indexed, displaced, direct]
4aed:      JMP   D4B25      ; =+54 [Jump relative]
4aef:D4AEF LDB+  Z,4        ; [Load B indexed, displaced, direct]
4af2:      BNZ   D4B08      ; =+20 [Branch if not zero]
4af4:      STB+  Z,10       ; [Store B indexed, displaced, direct]
4af7:      LDBB= X'02'      ; =2 [Load BL with immediate]
4af9:      STBB+ Z,13       ; [Store BL indexed, displaced, direct]
4afc:      LDAB+ Y,6        ; [Load AL indexed, displaced, direct]
4aff:      BP    D4B03      ; =+2 [Branch on plus]
4b01:      LDAB= X'01'      ; =1 [Load AL with immediate]
4b03:D4B03 STAB+ Z,12       ; [Store AL indexed, displaced, direct]
4b06:      JMP   D4B25      ; =+29 [Jump relative]
4b08:D4B08 LDBB= X'02'      ; =2 [Load BL with immediate]
4b0a:      STBB+ Z,12       ; [Store BL indexed, displaced, direct]
4b0d:      LDAB+ Y,7        ; [Load AL indexed, displaced, direct]
4b10:      LDBB= X'01'      ; =1 [Load BL with immediate]
4b12:      SABB             ; [AL - BL -> BL]
4b13:      BZ    D4B1C      ; =+7 [Branch if zero]
4b15:      LDAB= X'02'      ; =2 [Load AL with immediate]
4b17:      LDB=  X'0001'    ; =0x0001 =1 [Load B with immediate]
4b1a:      JMP   D4B1F      ; =+3 [Jump relative]
4b1c:D4B1C LDB=  X'0004'    ; =0x0004 =4 [Load B with immediate]
4b1f:D4B1F STAB+ Z,13       ; [Store AL indexed, displaced, direct]
4b22:      STB+  Z,10       ; [Store B indexed, displaced, direct]
4b25:D4B25 XFR   Z,A        ; [Transfer Z to A]
4b27:      STA+  Y          ; [Store A to address in Y]
4b28:      LDBB+ Y,5        ; [Load BL indexed, displaced, direct]
4b2b:      LDA+  Z,10       ; [Load A indexed, displaced, direct]
4b2e:      STA+  Y,5        ; [Store A indexed, displaced, direct]
4b31:      ADD=  X'001E',Z  ; =0x001e =30 [30 + Z -> Z]
4b35:      BL    D4B5C      ; =+37 [Branch on link]
4b37:      LDAB= X'04'      ; =4 [Load AL with immediate]
4b39:      NABB             ; [AL & BL -> BL]
4b3a:      BZ    D4B5F      ; =+35 [Branch if zero]
4b3c:D4B3C LDA+  X          ; [Load A from address in X]
4b3d:      ADD=  X'FFBD',A  ; =0xffbd =65469(-67) [65469 + A -> A]
4b41:      SUB   Z,A        ; [Z - A -> A]
4b43:      BNL   D4B51      ; =+12 [Branch on no link]
4b45:      SVC   X'59'      ; =89 [Service call ASEG - add next free mem segment to CURTB [wait for comp]]
4b47:      SVC   X'07'      ; =7 [Service call WT - unconditional wait]
4b49:      LDA+  X          ; [Load A from address in X]
4b4a:      LDB=  X'0800'    ; =0x0800 =2048 [Load B with immediate]
4b4d:      AAB              ; [A + B -> B]
4b4e:      STB+  X          ; [Store B to address in X]
4b4f:      JMP   D4B3C      ; =-21 [Jump relative]
4b51:D4B51 FIL   (67)=X'00',-Z ; [Fill with byte, literal=0, indexed]
4b56:      ADD=  X'0043',Z  ; =0x0043 =67 [67 + Z -> Z]
4b5a:      BNL   D4B5F      ; =+3 [Branch on no link]
4b5c:D4B5C JMP/  D49BF      ; =0x49bf =18879 [Jump direct]
4b5f:D4B5F JMP/  J4A23      ; =0x4a23 =18979 [Jump direct]
4b62:J4B62 CLA              ; [Clear A]
4b63:W4B63 LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
4b66:      SAB              ; [A - B -> B]
4b67:      BP    D4B88      ; =+31 [Branch on plus]
4b69:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
4b6b:P4B6B JSR/  F3627      ; =0x3627 =13863 [Jump to subroutine direct]
4b6e:      XAY              ; [Transfer A to Y]
4b6f:      LDA+  Y          ; [Load A from address in Y]
4b70:      BM    D4B77      ; =+5 [Branch on minus]
4b72:      JSR*  P4B6B+1    ; =-8 [Jump to subroutine relative indirect]
4b74:      LDB+  A          ; [Load B from address in A]
4b75:      JMP   D4B82      ; =+11 [Jump relative]
4b77:D4B77 LDA+  Y,2        ; [Load A indexed, displaced, direct]
4b7a:      INR   A,3        ; [Increment A by 3]
4b7c:      XFR   Z,B        ; [Transfer Z to B]
4b7e:      ADD   A,Z        ; [A + Z -> Z]
4b80:      BL    D4B5C      ; =-38 [Branch on link]
4b82:D4B82 STB+  Y          ; [Store B to address in Y]
4b83:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
4b85:      INA              ; [Increment A]
4b86:      JMP   W4B63      ; =-37 [Jump relative]
4b88:D4B88 XFR   Z,A        ; [Transfer Z to A]
4b8a:      STA+  X,10       ; [Store A indexed, displaced, direct]
4b8d:      STA+  X,57       ; [Store A indexed, displaced, direct]
4b90:      LDA+  X          ; [Load A from address in X]
4b91:      SUB   Z,A        ; [Z - A -> A]
4b93:      BNL   D4BA1      ; =+12 [Branch on no link]
4b95:      SVC   X'59'      ; =89 [Service call ASEG - add next free mem segment to CURTB [wait for comp]]
4b97:      SVC   X'07'      ; =7 [Service call WT - unconditional wait]
4b99:      LDA+  X          ; [Load A from address in X]
4b9a:      LDB=  X'0800'    ; =0x0800 =2048 [Load B with immediate]
4b9d:      AAB              ; [A + B -> B]
4b9e:      STB+  X          ; [Store B to address in X]
4b9f:      JMP   D4B88      ; =-25 [Jump relative]
4ba1:D4BA1 LDB+  X,39       ; [Load B indexed, displaced, direct]
4ba4:      LDA+  S          ; [Load A from address in S]
4ba5:      SUB   B,A        ; [B - A -> A]
4ba7:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
4ba9:      DCA              ; [Decrement A]
4baa:      XAY              ; [Transfer A to Y]
4bab:D4BAB CLRB  AU         ; [Clear AU]
4bad:      FILR  =X'00',-B  ; [Fill with byte (len in AL), literal=0, indexed]
4bb1:      INA              ; [Increment A]
4bb2:      AAB              ; [A + B -> B]
4bb3:      DCRB  YU         ; [Decrement YU by 1]
4bb5:      BM    D4BBB      ; =+4 [Branch on minus]
4bb7:      LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
4bb9:      JMP   D4BAB      ; =-16 [Jump relative]
4bbb:D4BBB XFR-  X,30,Y     ; [Transfer indexed-displaced to Y]
4bbf:      LDA+  X,29       ; [Load A indexed, displaced, direct]
4bc2:      LDAB= X'01'      ; =1 [Load AL with immediate]
4bc4:D4BC4 DCRB  AU         ; [Decrement AU by 1]
4bc6:      BM    D4BCF      ; =+7 [Branch on minus]
4bc8:      STAB+ Y,4        ; [Store AL indexed, displaced, direct]
4bcb:      INR   Y,8        ; [Increment Y by 8]
4bcd:      JMP   D4BC4      ; =-11 [Jump relative]
4bcf:D4BCF CLA              ; [Clear A]
4bd0:      STA+  X,37       ; [Store A indexed, displaced, direct]
4bd3:      STAB+ X,36       ; [Store AL indexed, displaced, direct]
4bd6:      STAB+ X,20       ; [Store AL indexed, displaced, direct]
4bd9:      STA+  X,12       ; [Store A indexed, displaced, direct]
4bdc:W4BDC LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
4bdf:      XAY              ; [Transfer A to Y]
4be0:W4BE0 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
4be3:      XAZ              ; [Transfer A to Z]
4be4:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
4be6:      RSR              ; [Return from subroutine]
*
* Function F4BE7
*
4be7:F4BE7 XFR   Y,A        ; [Transfer Y to A]
4be9:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
4beb:      CLA              ; [Clear A]
4bec:      LDAB+ Z,3        ; [Load AL indexed, displaced, direct]
4bef:      SLA              ; [Left shift A]
4bf0:      LDB=  W4DB9      ; =0x4db9 =19897 [Load B with immediate]
4bf3:      AAB              ; [A + B -> B]
4bf4:      JMP+  *B         ; [Jump indexed, indirect]
4bf6:W4BF6 CLAB             ; [Clear AL]
4bf7:      LDBB+ Z,13       ; [Load BL indexed, displaced, direct]
4bfa:      DCRB  BL,6       ; [Decrement BL by 6]
4bfc:      BNZ   J4C04      ; =+6 [Branch if not zero]
4bfe:      ZAD   =1,-Z,36(3) ; [Zero-add bignum, literal=0x01, displaced indexed]
4c04:J4C04 STAB/ B4DB8      ; =0x4db8 =19896 [Store AL direct]
4c07:      STAB+ Z          ; [Store AL to address in Z]
4c08:      JMP/  J4DB1      ; =0x4db1 =19889 [Jump direct]
4c0b:W4C0B STK   Z,2        ; [Push Z to the stack]
4c0d:      LDB=  W4DD9      ; =0x4dd9 =19929 [Load B with immediate]
4c10:      AAB              ; [A + B -> B]
4c11:      LDB+  B          ; [Load B from address in B]
4c12:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
4c14:      LDA+  Y,2        ; [Load A indexed, displaced, direct]
4c17:      LDB/  W3003+1    ; =0x3004 =12292 [Load B direct]
4c1a:      STA+  B,44       ; [Store A indexed, displaced, direct]
4c1d:      XFR=  W4DFE,Z    ; =0x4dfe =19966 [Transfer immediate to Z]
4c21:      XFR=  W4E00,Y    ; =0x4e00 =19968 [Transfer immediate to Y]
4c25:      JSR/  F303D      ; =0x303d =12349 [Jump to subroutine direct]
4c28:      STAB- Z-         ; [Store AL indexed, pre-decremented, direct]
4c2a:      BM    D4C38      ; =+12 [Branch on minus]
4c2c:      BZ    D4C33      ; =+5 [Branch if zero]
4c2e:      LDA+  B          ; [Load A from address in B]
4c2f:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
4c31:      JMP   D4C3E      ; =+11 [Jump relative]
4c33:D4C33 JSR/  F3158      ; =0x3158 =12632 [Jump to subroutine direct]
4c36:      JMP   D4C3E      ; =+6 [Jump relative]
4c38:D4C38 JSR/  F3180      ; =0x3180 =12672 [Jump to subroutine direct]
4c3b:      JSR/  F3470      ; =0x3470 =13424 [Jump to subroutine direct]
4c3e:D4C3E LDA+  S,2        ; [Load A indexed, displaced, direct]
4c41:      LDAB+ A,35       ; [Load AL indexed, displaced, direct]
4c44:      CLRB  AU         ; [Clear AU]
4c46:      DCRB  AL,2       ; [Decrement AL by 2]
4c48:      BZ    D4C89      ; =+63 [Branch if zero]
4c4a:      DCRB  AL,2       ; [Decrement AL by 2]
4c4c:      BZ    D4C97      ; =+73 [Branch if zero]
4c4e:      DCRB  AL,2       ; [Decrement AL by 2]
4c50:      BZ    D4CAB      ; =+89 [Branch if zero]
4c52:      INR   A,7        ; [Increment A by 7]
4c54:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
4c56:      JSR/  F3096      ; =0x3096 =12438 [Jump to subroutine direct]
4c59:      LDA/  W3632      ; =0x3632 =13874 [Load A direct]
4c5c:      LDB+  S          ; [Load B from address in S]
4c5d:      STB/  W3632      ; =0x3632 =13874 [Store B direct]
4c60:      DCR   B          ; [Decrement B by 1]
4c62:      STB+  S          ; [Store B to address in S]
4c63:      SAB              ; [A - B -> B]
4c64:      BP    D4C67      ; =+1 [Branch on plus]
4c66:      STA+  S          ; [Store A to address in S]
4c67:D4C67 JSR/  F31BF      ; =0x31bf =12735 [Jump to subroutine direct]
4c6a:      DW    W3632      ; =0x3632 =13874
*
4c6c:      JSR/  F317E      ; =0x317e =12670 [Jump to subroutine direct]
4c6f:      DW    W3632      ; =0x3632 =13874
4c71:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
4c73:      ADD/  W3634,A,B  ; =0x3634 =13876 [Direct + A -> B]
4c77:      CLAB             ; [Clear AL]
4c78:      STAB+ B          ; [Store AL to address in B]
4c79:      DCAB             ; [Decrement AL]
4c7a:      STAB- Z-         ; [Store AL indexed, pre-decremented, direct]
4c7c:      LDB/  W3634      ; =0x3634 =13876 [Load B direct]
4c7f:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
4c81:      JSR/  F4D8C      ; =0x4d8c =19852 [Jump to subroutine direct]
4c84:      JSR/  F3096      ; =0x3096 =12438 [Jump to subroutine direct]
4c87:      JMP   D4CCC      ; =+67 [Jump relative]
4c89:D4C89 JSR/  F30EC      ; =0x30ec =12524 [Jump to subroutine direct]
4c8c:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
4c8e:      XFR   Y,B        ; [Transfer Y to B]
4c90:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
4c92:      JSR/  F4D8C      ; =0x4d8c =19852 [Jump to subroutine direct]
4c95:      JMP   D4CCC      ; =+53 [Jump relative]
4c97:D4C97 JSR/  F311C      ; =0x311c =12572 [Jump to subroutine direct]
4c9a:      D     =1000000,/W3632(6) ; =0x3632 =13874 [Divide bignums, literal=0x0f4240, direct]
4ca2:      JSR/  F3156      ; =0x3156 =12630 [Jump to subroutine direct]
4ca5:      DW    W3632      ; =0x3632 =13874
4ca7:      INR   A,2        ; [Increment A by 2]
4ca9:      JMP   D4CBB      ; =+16 [Jump relative]
4cab:D4CAB JSR/  F311C      ; =0x311c =12572 [Jump to subroutine direct]
4cae:      D     =1000000,/W3632(6) ; =0x3632 =13874 [Divide bignums, literal=0x0f4240, direct]
4cb6:      JSR/  F3156      ; =0x3156 =12630 [Jump to subroutine direct]
4cb9:      DW    W3632      ; =0x3632 =13874
*
4cbb:D4CBB XAB              ; [Transfer A to B]
4cbc:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
4cbe:      JSR/  F4D8C      ; =0x4d8c =19852 [Jump to subroutine direct]
4cc1:      LDA/  W3003+1    ; =0x3004 =12292 [Load A direct]
4cc4:      LDB+  A,55       ; [Load B indexed, displaced, direct]
4cc7:      INR   B,6        ; [Increment B by 6]
4cc9:      STB+  A,55       ; [Store B indexed, displaced, direct]
4ccc:D4CCC POP   Z,2        ; [Pop Z from the stack]
4cce:      JMP/  D4D60      ; =0x4d60 =19808 [Jump direct]
4cd1:W4CD1 LDA+  Y,2        ; [Load A indexed, displaced, direct]
4cd4:      LDB/  W3003+1    ; =0x3004 =12292 [Load B direct]
4cd7:      STA+  B,44       ; [Store A indexed, displaced, direct]
4cda:      CLA              ; [Clear A]
4cdb:      LDAB+ Z,35       ; [Load AL indexed, displaced, direct]
4cde:      STK   Y,4        ; [Push Y Z to the stack]
4ce0:      XFR-  S,8,Y      ; [Transfer indexed-displaced to Y]
4ce4:      XFR-  S,10,Z     ; [Transfer indexed-displaced to Z]
4ce8:      DCRB  AL,2       ; [Decrement AL by 2]
4cea:      BZ    D4D12      ; =+38 [Branch if zero]
4cec:      DCRB  AL,2       ; [Decrement AL by 2]
4cee:      BZ    D4D2C      ; =+60 [Branch if zero]
4cf0:      DCRB  AL,2       ; [Decrement AL by 2]
4cf2:      BZ    D4D3C      ; =+72 [Branch if zero]
4cf4:      INR   A,6        ; [Increment A by 6]
4cf6:      STA/  W3632      ; =0x3632 =13874 [Store A direct]
4cf9:      LDA=  X'8000'    ; =0x8000 =32768(-32768) [Load A with immediate]
4cfc:      STA/  W3634      ; =0x3634 =13876 [Store A direct]
4cff:      JSR/  F31BF      ; =0x31bf =12735 [Jump to subroutine direct]
4d02:      DW    W3632      ; =0x3632 =13874
*
4d04:      JSR/  F317E      ; =0x317e =12670 [Jump to subroutine direct]
4d07:      DW    W3632      ; =0x3632 =13874
4d09:      LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
4d0b:      STAB- Z-         ; [Store AL indexed, pre-decremented, direct]
4d0d:      LDB/  W3634      ; =0x3634 =13876 [Load B direct]
4d10:      JMP   D4D1A      ; =+8 [Jump relative]
4d12:D4D12 CLA              ; [Clear A]
4d13:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
4d15:      INAB             ; [Increment AL]
4d16:      STAB- Z-         ; [Store AL indexed, pre-decremented, direct]
4d18:      XFR   Y,B        ; [Transfer Y to B]
4d1a:D4D1A STR-  S,8,Y      ; [Store Y indexed-displaced]
4d1e:      STR-  S,10,Z     ; [Store Z indexed-displaced]
4d22:      POP   Y,4        ; [Pop Z Y from the stack]
4d24:      LDA=  W4E24      ; =0x4e24 =20004 [Load A with immediate]
4d27:      JSR/  F4D97      ; =0x4d97 =19863 [Jump to subroutine direct]
4d2a:      JMP   D4D60      ; =+52 [Jump relative]
4d2c:D4D2C CLA              ; [Clear A]
4d2d:      STA/  W3632      ; =0x3632 =13874 [Store A direct]
4d30:      STAB- Z-         ; [Store AL indexed, pre-decremented, direct]
4d32:      JSR/  F3156      ; =0x3156 =12630 [Jump to subroutine direct]
4d35:      DW    W3632      ; =0x3632 =13874
4d37:      XAB              ; [Transfer A to B]
4d38:      INR   B,2        ; [Increment B by 2]
4d3a:      JMP   D4D45      ; =+9 [Jump relative]
4d3c:D4D3C CLAB             ; [Clear AL]
4d3d:      STAB- Z-         ; [Store AL indexed, pre-decremented, direct]
4d3f:      JSR/  F3156      ; =0x3156 =12630 [Jump to subroutine direct]
4d42:      DW    W3632      ; =0x3632 =13874
4d44:      XAB              ; [Transfer A to B]
4d45:D4D45 STR-  S,8,Y      ; [Store Y indexed-displaced]
4d49:      STR-  S,10,Z     ; [Store Z indexed-displaced]
4d4d:      POP   Y,4        ; [Pop Z Y from the stack]
4d4f:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
4d51:      LDA=  W4E24      ; =0x4e24 =20004 [Load A with immediate]
4d54:      JSR/  F4D97      ; =0x4d97 =19863 [Jump to subroutine direct]
4d57:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
4d59:      M     =1000000,-A(6) ; [Multiply bignums, literal=0x0f4240, indexed]
4d60:D4D60 LDAB+ Z          ; [Load AL from address in Z]
4d61:      DCRB  AL,2       ; [Decrement AL by 2]
4d63:      BM    D4D6B      ; =+6 [Branch on minus]
4d65:      BZ    D4D6E      ; =+7 [Branch if zero]
4d67:      INAB             ; [Increment AL]
4d68:      JMP/  J4C04      ; =0x4c04 =19460 [Jump direct]
4d6b:D4D6B JMP/  J4DB1      ; =0x4db1 =19889 [Jump direct]
4d6e:D4D6E JMP/  D42AB      ; =0x42ab =17067 [Jump direct]
4d71:W4D71 LDB+  Z,16       ; [Load B indexed, displaced, direct]
4d74:      ZAD   -B(6),-Z,36(3) ; [Zero-add bignum, indexed, displaced indexed]
4d7a:      JMP/  J4DB1      ; =0x4db1 =19889 [Jump direct]
4d7d:W4D7D LDB+  Z,16       ; [Load B indexed, displaced, direct]
4d80:      ZAD   -Z,36(3),-B(6) ; [Zero-add bignum, displaced indexed, indexed]
4d86:      JMP/  J4DB1      ; =0x4db1 =19889 [Jump direct]
4d89:W4D89 JMP/  J4DB1      ; =0x4db1 =19889 [Jump direct]
*
* Function F4D8C
*
4d8c:F4D8C STA   W4DA4+1    ; =+23 [Store A relative]
4d8e:      STB   W4DA9      ; =+25 [Store B relative]
4d90:      LDA+  S,2        ; [Load A indexed, displaced, direct]
4d93:      STA   W4DA7      ; =+18 [Store A relative]
4d95:      JMP   D4D9F      ; =+8 [Jump relative]
*
* Function F4D97
*
4d97:F4D97 STA   W4DA4+1    ; =+12 [Store A relative]
4d99:      STB   W4DA9      ; =+14 [Store B relative]
4d9b:      STR/  W4DA7,Z    ; =0x4da7 =19879 [Store Z direct]
4d9f:D4D9F LDB/  W3003+1    ; =0x3004 =12292 [Load B direct]
4da2:      STK   B,8        ; [Push B X Y Z to the stack]
4da4:W4DA4 JSR/  X'0000'    ; =0x0000 =0 =NUL,NUL [Jump to subroutine direct]
4da7:W4DA7 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
4da9:W4DA9 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
4dab:      POP   B,8        ; [Pop Z Y X B from the stack]
4dad:      STB/  W3003+1    ; =0x3004 =12292 [Store B direct]
4db0:      RSR              ; [Return from subroutine]
*
4db1:J4DB1 LDA+  S+         ; [Load A indexed, direct, post-incremented]
4db3:      XAY              ; [Transfer A to Y]
4db4:      RSR              ; [Return from subroutine]
*
4db5:      DB    0,3        ; =0x00,0x0003
4db8:B4DB8 DB    X'00'      ; =0x00 =0 =NUL
4db9:W4DB9 DW    W4D89      ; =0x4d89 =19849
4dbb:      DW    W4D89      ; =0x4d89 =19849
4dbd:      DW    W4D89      ; =0x4d89 =19849
4dbf:      DW    W4D89      ; =0x4d89 =19849
4dc1:      DW    W4D89      ; =0x4d89 =19849
4dc3:      DW    W4D7D      ; =0x4d7d =19837
4dc5:      DW    W4D71      ; =0x4d71 =19825
4dc7:      DW    W4D89      ; =0x4d89 =19849
4dc9:      DW    W4D89      ; =0x4d89 =19849
4dcb:      DW    W4BF6      ; =0x4bf6 =19446
4dcd:      DW    W4D89      ; =0x4d89 =19849
4dcf:      DW    W4D89      ; =0x4d89 =19849
4dd1:      DW    W4C0B      ; =0x4c0b =19467
4dd3:      DW    W4C0B      ; =0x4c0b =19467
4dd5:      DW    W4CD1      ; =0x4cd1 =19665
4dd7:      DW    W4C0B      ; =0x4c0b =19467
4dd9:W4DD9 DW    W4D89      ; =0x4d89 =19849
4ddb:      DW    W4D89      ; =0x4d89 =19849
4ddd:      DW    W4D89      ; =0x4d89 =19849
4ddf:      DW    W4D89      ; =0x4d89 =19849
4de1:      DW    W4D89      ; =0x4d89 =19849
4de3:      DW    W4D89      ; =0x4d89 =19849
4de5:      DW    W4D89      ; =0x4d89 =19849
4de7:      DW    W4D89      ; =0x4d89 =19849
4de9:      DW    W4D89      ; =0x4d89 =19849
4deb:      DW    W4D89      ; =0x4d89 =19849
4ded:      DW    W4D89      ; =0x4d89 =19849
4def:      DW    W4D89      ; =0x4d89 =19849
4df1:      DW    W4E00      ; =0x4e00 =19968
4df3:      DW    W4E0C      ; =0x4e0c =19980
4df5:      DW    W4E24      ; =0x4e24 =20004
4df7:      DW    W4E18      ; =0x4e18 =19992
4df9:      DB    0,5        ; =0x00,0x0005
4dfe:W4DFE DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
4e00:W4E00 STK   Y,2        ; [Push Y to the stack]
4e02:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
4e04:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
4e06:      XAY              ; [Transfer A to Y]
4e07:      CLR   A,13       ; [Set A to 13]
4e09:      JMP/  J4E30      ; =0x4e30 =20016 [Jump direct]
4e0c:W4E0C STK   Y,2        ; [Push Y to the stack]
4e0e:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
4e10:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
4e12:      XAY              ; [Transfer A to Y]
4e13:      CLR   A,12       ; [Set A to 12]
4e15:      JMP/  J4E30      ; =0x4e30 =20016 [Jump direct]
4e18:W4E18 STK   Y,2        ; [Push Y to the stack]
4e1a:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
4e1c:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
4e1e:      XAY              ; [Transfer A to Y]
4e1f:      CLR   A,14       ; [Set A to 14]
4e21:      JMP/  J4E30      ; =0x4e30 =20016 [Jump direct]
4e24:W4E24 STK   Y,2        ; [Push Y to the stack]
4e26:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
4e28:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
4e2a:      XAY              ; [Transfer A to Y]
4e2b:      CLR   A,15       ; [Set A to 15]
4e2d:      JMP/  J4E30      ; =0x4e30 =20016 [Jump direct]
4e30:J4E30 STB-  S-         ; [Store B indexed, pre-decremented, direct]
4e32:      STAB+ B,3        ; [Store AL indexed, displaced, direct]
4e35:      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
4e37:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
4e39:      LDAB+ B          ; [Load AL from address in B]
4e3a:      STAB/ B4DB8      ; =0x4db8 =19896 [Store AL direct]
4e3d:      POP   Y,2        ; [Pop Y from the stack]
4e3f:      RSR              ; [Return from subroutine]
*
* Function F4E40
*
4e40:F4E40 LDA+  X+         ; [Load A indexed, direct, post-incremented]
*
* Function F4E42
*
4e42:F4E42 LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
4e44:      STBB- S-         ; [Store BL indexed, pre-decremented, direct]
4e46:      XFR   A,A        ; [Transfer A to A]
4e48:      BZ    D4E7C      ; =+50 [Branch if zero]
4e4a:      BP    D4E51      ; =+5 [Branch on plus]
4e4c:      IVA              ; [Invert A]
4e4d:      INA              ; [Increment A]
4e4e:      LDBB= X'AD'      ; =173(-83) ='-' [Load BL with immediate]
4e50:      STBB+ S          ; [Store BL to address in S]
4e51:D4E51 LDB+  X+         ; [Load B indexed, direct, post-incremented]
4e53:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
4e55:      XFR   B,X        ; [Transfer B to X]
4e57:      INX              ; [Increment X]
4e58:D4E58 LDB=  X'000A'    ; =0x000a =10 [Load B with immediate]
4e5b:      DIV   B,A        ; [B / A -> A,B]
4e5d:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
4e5f:      BZ    D4E6A      ; =+9 [Branch if zero]
4e61:      LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
4e63:      AABB             ; [AL + BL -> BL]
4e64:      STBB- X-         ; [Store BL indexed, pre-decremented, direct]
4e66:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
4e68:      JMP   D4E58      ; =-18 [Jump relative]
4e6a:D4E6A XABB             ; [Transfer AL to BL]
4e6b:      BZ    D4E72      ; =+5 [Branch if zero]
4e6d:      LDAB= X'B0'      ; =176(-80) ='0' [Load AL with immediate]
4e6f:      AABB             ; [AL + BL -> BL]
4e70:      STBB- X-         ; [Store BL indexed, pre-decremented, direct]
4e72:D4E72 LDB+  S+         ; [Load B indexed, direct, post-incremented]
4e74:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
4e76:      LDBB+ S+         ; [Load BL indexed, direct, post-incremented]
4e78:      STBB- X-         ; [Store BL indexed, pre-decremented, direct]
4e7a:      XAX              ; [Transfer A to X]
4e7b:      RSR              ; [Return from subroutine]
*
4e7c:D4E7C LDAB= X'B0'      ; =176(-80) ='0' [Load AL with immediate]
4e7e:      STAB+ *X         ; [Store AL indexed, indirect]
4e80:      INR   X,2        ; [Increment X by 2]
4e82:      LDBB+ S+         ; [Load BL indexed, direct, post-incremented]
4e84:      RSR              ; [Return from subroutine]
*
* Function F4E85
*
4e85:F4E85 STK   Y,2        ; [Push Y to the stack]
4e87:      XFR-  X,0,Y      ; [Transfer indexed-displaced to Y]
4e8b:      INR   X,2        ; [Increment X by 2]
4e8d:      DCA              ; [Decrement A]
4e8e:      BP    D4E94      ; =+4 [Branch on plus]
4e90:      INR   X,2        ; [Increment X by 2]
4e92:      JMP   D4EA7      ; =+19 [Jump relative]
4e94:D4E94 FILR  =' ',-Y    ; [Fill with byte (len in AL), literal=0xa0(160,-96), indexed]
4e98:      INA              ; [Increment A]
4e99:      SAB              ; [A - B -> B]
4e9a:      BLE   D4E9F      ; =+3 [Branch if less than or equal to zero]
4e9c:      SAB              ; [A - B -> B]
4e9d:      XFR   B,A        ; [Transfer B to A]
4e9f:D4E9F LDB+  X+         ; [Load B indexed, direct, post-incremented]
4ea1:      DCA              ; [Decrement A]
4ea2:      BM    D4EA7      ; =+3 [Branch on minus]
4ea4:      MVFR  -B,-Y      ; [Move fixed-length (len in AL), indexed, indexed]
4ea7:D4EA7 POP   Y,2        ; [Pop Y from the stack]
4ea9:      RSR              ; [Return from subroutine]
*
4eaa:ENDPT
