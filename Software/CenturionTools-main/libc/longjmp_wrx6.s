
	.export	_longjmp

	.code

_longjmp:
	ld	y,2(s)			; buffer
	ld	a,4(s)			; return code
	bnz	retgood
	inc	a
retgood:
	ld	s,(y)
	ld	x,2(y)
	ld	z,4(y)
	ret
