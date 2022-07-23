;
;	Boolean negation
;
	.setcpu 4

	.code

	.export bnega
	.export bnegax

bnegax:	xfr	y,b
	ori	a,b
	bz	ret1
ret0:
	cla
	rsr

bnega:	ori	a,a
	bnz	ret0
ret1:
	lda	1
	rsr
