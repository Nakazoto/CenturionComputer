;
;	This is the classic division algorithm
;
;	On entry A holds the divisor and N holds the dividend
;
;	work = 0
;	loop for each bit in size (tracked in tmp)
;		shift dividend left (A)
;		rotate left into work (X)
;		set low bit of dividend (A)
;		subtract divisor (B) from work
;		if work < 0
;			add divisor (B) back to work
;			clear lsb of A
;		end
;	end loop
;
;	On exit B holds the quotient, A holds the remainder
;
;
	.export div16x16
	.setcpu 4

	.code

div16x16:
	; Save the registers X-Z

	stx	(-s)
	xfr	y,x
	stx	(-s)
	xfr	z,x
	stx	(-s)

	; Calculate A / B


	ldx	16		; bit count
	xfrb	xl,yl

	clr	x		; working register
loop:
	sla			; shift dividend left
	rlr	x		; rotate into work
	; if work >= divisor
	;		divisor -= work
	xfr	b,z
	sub	x,z		; Z = work - divisor
	bz	doadd
	bnl	skip
doadd:
	ina			; set low bit of A (we know it's 0 at this moment)
	xfr	z,x		; result back into divisor
	; work was < divisor so undo subtract
skip:
	dcrb	yl
	bnz	loop

	xfr	x,b

	; Restore the registers X to Z
	ldx	(s+)
	xfr	x,z
	ldx	(s+)
	xfr	x,y
	ldx	(s+)
	rsr
