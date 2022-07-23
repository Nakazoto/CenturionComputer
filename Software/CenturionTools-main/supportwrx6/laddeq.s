;
;	On entry B points to the object
;
	.code
	.export laddeqysp
	.export laddeq

	.setcpu 4

; In this form B is the stack offset. Turn that into a pointer and
; fall into the static form
laddeqysp:
	add s,b
;
;	Add the 32bit Y:A to the variable pointed to by B
;
laddeq:
	stx	(-s)
	ldx	(b)
	add	x,y
	stx	(b)
	xfr	x,y
	ldx	2(b)
	add	x,a
	stx	2(b)
	xfr	x,a
	bl	ripple		; One in 64K times so can be slower
	ldx	(s+)
	rsr
ripple:
	ldx	(b)
	inx
	stx	(b)
	inr	y
	ldx	(s+)
	rsr
