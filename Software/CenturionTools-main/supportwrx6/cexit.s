
		.code
		.export cexit
		.export cexitn
		.export cexit3
		.export cexit4
		.export cexit5
		.export cexit6
		.setcpu 6

cexit3:
	ld	x,3
	bra	cexitn
cexit5:
	ld	x,5
	bra	cexitn
cexit6:
	ld	x,6
	bra	cexitn
cexit4:
	ld	x,4
cexitn:
	add	x,s
cexit:
	ldx	(s+)
	xfr	x,z
	ldx	(s+)
	rsr

