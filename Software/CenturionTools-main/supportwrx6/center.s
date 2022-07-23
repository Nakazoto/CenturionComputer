		.code
		.export center
		.export center0
		.export center1
		.export center2
		.export center_va

center2:
	lda	-2
	bra	centern
center1:
	cla
	dca	; -1
	bra	centern
center0:
	cla
	bra	centern
	; The act of calling this pushed x for us for free, and set x to
	; point to the size info. We go back via jmp (x) as we don't want to
	; undo the work done by jsr
center:
	lda	(x+)
centern:
	xfr	z,b
	stb	(-s)
	xfr	s,z
	add	a,s
	jmp	(x)

center_va:
	xfr	z,a
	sta	(-s)
	xfr	s,z
	add	b,z
	jmp	(x)
