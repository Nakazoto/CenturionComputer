;
;	Unsigned 32bit remainder TOS by sreg:d
;

		.export tosumodeax
		.setcpu 4
		.code

tosumodeax:
		; Arrange stack for the divide helper.
		stx	(-s)
		sta	(-s)
		xfr	y,a
		sta	(-s)
		jsr div32x32
		; Result is in YA
		ldb	(s+)	; throw the stuff we stacked
		ldb	(s+)
		ldx	(s+)	; Get our X back
		ldb	(s+)	; Throw away two
		ldb	(s+)
		rsr
