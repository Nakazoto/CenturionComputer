;
;	Shift TOS right by A
;
	.export tosshrax		; unsigned

	.setcpu 4
	.code

tosshrax:
	ldb	15			; shift of > 15 is meaningless
	sab
	bl	shiftout
	xab
	lda	2(s)
	; We could self modify ?
shloop:
	rl
	rrr	a
	dcr	b
	bnz	shloop
	ldb	(s+)		; Throw 2 bytes
	rsr
shiftout:
	cla
	ldb	(s+)
	rsr
