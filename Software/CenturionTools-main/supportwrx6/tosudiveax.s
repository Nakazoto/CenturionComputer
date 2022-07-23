;
;	Unsigned 32bit divide TOS by sreg:d
;

		.export tosudiveax
		.setcpu 4
		.code

tosudiveax:
		; Arrange stack for the divide helper. TOS is already right
		; so push the other 4 bytes we need. The divide helper knows
		; about the fact there is junk (return address) between the
		; two
		stx	(-s)
		sta	(-s)
		xfr	y,a
		sta	(-s)
		jsr	div32x32
		ldb	(s+)		; Clean up stack arg
		ldb	(s+)
		; Extract the result
		lda	6(s)
		xay
		lda	8(s)
		; Fix up the stack
		ldx	(s+)
		ldb	(s+)
		ldb	(s+)
		rsr
