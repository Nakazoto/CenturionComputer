;
;	Signed 32bit mod TOS by YA
;
;	The result shall be negative if the dividend was
;
		.export tosmodeax

		.setcpu 4
		.code

tosmodeax:
		stx	(-s)
		clr	x
		xfr	y,y
		bp	signfixed
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

		ldb	8(s)		; top of TOS
		bp	signfixed2

		ldx	10(s)		; rest of argument
		ivr	x
		ivr	b
		inx
		bnz	noripple
		inr	b
		ldx	1
noripple:
		stb	8(s)
		stx	10(s)
signfixed2:
		;	Do a 32bit unsigned divide
		jsr div32x32
		ldb	(s+)
		ldb	(s+)
		;	Result is now in YA
		ori	x,x
		bz	nosignfix3
		iva
		ivr	y
		ina
		bnz	noripple2
		inr	y
noripple2:
nosignfix3:
		ldx	(s+)
		ldb	(s+)
		ldb	(s+)
		rsr
