;
;	Signed 32bit divide TOS by sreg:d
;
;	The result shall be negative if the signs differ
;

		.export tosdiveax
		.setcpu 4
		.code

tosdiveax:
		stx	(-s)
		clr	x
		xfr	y,y
		bp	signfixed
		inx			; track sign toggle
		; negate ya
		iva
		ivr	y
		ina
		bnz	signfixed
		inr	y
signfixed:
		; Stack the 32bit working register
		; Arrange stack for the divide helper. TOS is already right
		; so push the other 4 bytes we need. The divide helper knows
		; about the fact there is junk (return address) between the
		; two
		sta	(-s)
		xfr	y,a
		sta	(-s)

		sta	(-s)
		ldb	10(s)		; top of TOS
		bp	signfixed2
		lda	12(s)		; rest of argument
		iva
		ivr	b
		ina
		bnz	noripple
		inr	b
noripple:
		stb	10(s)
		sta	12(s)
		dcx
signfixed2:
		lda	(s+)
		;	Do a 32bit unsigned divide
		jsr div32x32
		ldb	(s+)
		ldb	(s+)
		;	Result is now in TOS from before our call
		ori	x,x
		bz	nosignfix3
		lda	8(s)
		xay
		lda	10(s)
		iva
		ivr	y
		ina
		bnz	noripple2
		inr	y
noripple2:
		ldx	(s+)
		ldb	(s+)
		ldb	(s+)
		rsr

nosignfix3:
		lda	8(s)
		xay
		lda	10(s)
		bra	noripple2

