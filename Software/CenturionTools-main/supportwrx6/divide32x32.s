;
;	32bit unsigned divide. Used as the core for the actual C library
;	division routines. It expects to be called with the parameters
;	offsets from S
;
;	tmp2/tmp3 end up holding the remainder
;
;	On entry the stack frame referenced by S looks like this
;
;	6-9	32bit dividend (C compiler TOS)
;	4,5	A return address
;	0-3	32bit divisor
;
;	The one trick here is that to save space and time we start
;	with DIVID,x hoilding the 32bit input value (N in the usual
;	algorithm description). Each cycle we take the top bit of N,
;	we shift it left discarding this bit from DIVID,x and we shift the
;	resulting Q(n) bit into the bottom. After 32 cycles we throw N(0)
;	out and have shifted all of Q into the result.
;

DIVIS		.equ	6
;
;	There is a gap between these two so the call can push x and the
;	helper save its own x
;
DIVID		.equ	12

		.setcpu 4

		.export div32x32
		.code

div32x32:
		stx	(-s)
		xfr	z,a
		sta	(-s)

		ldb 	32		; 32 iterations for 32 bits

		; Clear the working register YZ
		; R = 0;
		clr	y
		clr	z

loop:		stb	(-s)

		; Shift the dividend left and set bit 0 assuming that
		; R >= D
		sl
		ldb	DIVID+2(s)
		rlr	b
		stb	DIVID+2(s)
		ldb	DIVID(s)
		rlr	b
		stb	DIVID(s)

		; N(i) is now in carry
		; R <<= 1; R(0) = N(i)
		; Capture into the working register

		rlr	z
		rlr	y

		; capturing high bit into the working register bottom

		; Do a 32bit subtract but skip writing the high 16bits
		; back until we know the comparison
		;
		; R - D
		;
		; FIXME: sab is an rsub so we need to rework these
		;
		xfr	z,b
		xfr	b,x
		lda	DIVIS+2(s)
		sab
		xfr	b,z
		xfr	y,b
		lda	DIVIS(s)
		bnl	noripple
		dcr	b
noripple:
		sab
		; Want to subtract (R - D >= 0)
		bl	skip
		bz	skip
		; No subtract, so put back the low 16bits we mushed
		xfr	x,z
		; We guessed the wrong way for Q(i). Clear Q(i) which is
		; in the lowest bit and we know is set so using dec is safe
		ldab	DIVID+3(s)
		dcab
		stab	DIVID+3(s)
done:
		ldb	(s+)
		dcr	b
		bnz	loop

		; Result is in ZY - move it
		;  FIXME: if we swapped over YZ use in the loop we could
		; save an instruction here. Worry about this once it's
		; debugged
		xfr	y,a
		xfr	z,y

		ldx	(s+)
		xfr	x,z
		ldx	(s+)
		rsr

		; We do want to subtract - write back the other bits
skip:
		; R -= D
		xfr	b,y
		bra	done

