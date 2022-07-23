;
;	On entry B points to the object
;
	.code
	.export lsubeq
	.export lsubeqysp
	.setcpu 4

; In this form B is the stack offset. Turn that into B is a pointer and
; fall into the static form
lsubeqysp:
	add	s,b
;
;	In this form B is a pointer to the long
;
lsubeq:
	stx	(-s)
	ldx	2(b)
	sub	x,a		; A = X -A
	sta	2(b)
	bnl	nocarry
	inr	y
nocarry:
	ldx	(b)
	sub	x,y
	xfr	y,x		; so we can save it
	stx	(b)
	ldx	(s+)
	rsr
