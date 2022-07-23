;
;	Right shift unsigned  TOS >> D
;

	.export tosshrax

	.setcpu 4
	.code

tosshrax:
	ldb	15
	sab
	bl	ret0		; shift over sized
	ldb	2(s)
loop:
	bz	retdone
	srr	b
	dca
	bra	loop
ret0:
	clr	b
retdone:
	xfr	b,a		; result
	ldb	(s+)		; throw a word
	rsr			; corrupts the old x but that is fine
