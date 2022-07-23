;
;	Right shift 32bit signed
;
	.export tosasreax

	.setcpu 4
	.code

tosasreax:
	ldb	32
	sab
	bl	ret0
	ori	a,a
	bz	noshift
	xab
	lda	2(s)
	xay
	lda	4(s)
loop:
	srr	y
	rrr	a
	dcrb	bl
	bnz	loop
noshift:
	; Throw 4 bytes
	ldb	(s+)
	ldb	(s+)
	rsr
ret0:
	cla
	clr	y
	bra	noshift
