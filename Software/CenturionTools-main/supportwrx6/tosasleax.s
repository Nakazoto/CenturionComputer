;
;	Left shift 32bit
;
	.export tosasleax
	.export tosshleax

	.setcpu 4
	.code

;
;	TODO: optimize 8, 16 steps on asl and asr cases
;
tosasleax:
tosshleax:
	ldb	32
	sab
	bnl	ret0
	ldb	16
	sab
	bnl	shleax16
	xab
	ld	a,2(s)
	xay
	ld	a,4(s)
	ori	b,b
	bz	retpop
loop:
	sla
	rlr	y
	dcrb	bl
	bnz	loop
	; Throw 4 bytes off the stack, we will corrupt the caller X but
	; the caller doesn't expect it saved
retpop:
	ldb	(s+)
	ldb	(s+)
	rsr
ret0:
	cla
	clr	y
	bra	retpop

;
;	Common fast path
;
shleax16:
	xab
	lda	8
	sab
	lda	4(s)
	xay
	cla
	ori	b,b
	bz	retpop
loop2:
	slr	y
	dcr	b
	bnz	loop2
	bra	retpop
