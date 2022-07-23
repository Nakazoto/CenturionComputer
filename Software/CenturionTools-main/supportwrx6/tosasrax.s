;
;	Shift TOS right by A
;
	.export tosasrax		; unsigned

	.setcpu 4
	.code

tosasrax:
	ldb	15			; shift of > 15 is meaningless
	sab
	bl	shiftout
	xab
	lda	2(s)
	; We could self modify ?
shloop:
	sra
	dcr	b
	bnz	shloop
	ldb	(s+)		; Throw 2 bytes
	rsr
shiftout:
	cla
	ldb	(s+)
	rsr
