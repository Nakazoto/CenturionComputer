;
;	Shift TOS left by A
;
	.export tosshlax		; unsigned
	.export tosaslax		; signed

	.setcpu 4
	.code

tosaslax:				; negative shift is not defined
					; anyway
tosshlax:
	ldb	15			; shift of > 15 is meaningless
	sab
	bl	shiftout
	xab
	lda	2(s)
	; We could self modify ?
shloop:
	sla
	dcr	b
	bnz	shloop
	ldb	(s+)		; Throw 2 bytes
	rsr
shiftout:
	cla
	ldb	(s+)
	rsr
