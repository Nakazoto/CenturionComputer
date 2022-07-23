;
;	Perform the classic bit shift multiply
;
;	We need to keep everything in registers
;
;	TODO: rework register assignments for speed
;
		.export tosmulax
		.export tosumulax

		.setcpu 4

		.code
tosmulax:
tosumulax:
		stx	(-s)
		xfr	y,x
		stx	(-s)

		clr	y		; Work register
		ldb	6(s)		; Going to do A * B
		ldx	16		; counter
		; Rotate through the number
nextbit:
		slr	y
		sla
		bnl	noadd
		add	b,y
noadd:		dcrb	xl
		bnz	nextbit

		; Y is now the result
		xfr	y,a
		ldx	(s+)
		xfr	x,y
		ldx	(s+)
		; Throw away a word
		inr	s
		inr	s

		rsr
