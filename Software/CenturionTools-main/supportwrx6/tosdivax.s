;
;	D = TOS / D signed
;
;	The rules for signed divide are
;	Dividend and remainder have the same sign
;	Quotient is negative if signs disagree
;
;	Our helper does unsigned div/mod of A / B into B r A
;
;
;	So we do the maths in unsigned then fix up
;
	.export tosdivax
	.export tosmodax

	.setcpu 4

;
;	The sign of the remainder of a division is not defined until C99.
;	C99 says it's the sign of the dividend.
;
tosdivax:
	xab
	stx	(-s)
	clr	x
	ori	a,a
	bp	plusmod
	ivr	b
	inr	b		; change sign
	inx			; remember sign
plusmod:
	lda	4(s)
	bp	plusmod2
	iva
	ina
	dcx			; track sign
plusmod2:
	jsr div16x16		; do the unsigned divide
				; A = quotient, B remainder
signfix:
	ori	x,x
	bz	sign_good
	iva
	ina
sign_good:
	ldx	(s+)
	ldb	(s+)		; throw TOS value
	rsr

;
;	The sign of the remainder of a division is not defined until C99.
;	C99 says it's the sign of the dividend.
;
tosmodax:
	xab
	stx	(-s)
	clr	x
	ori	a,a
	bp	plusdiv
	ivr	b
	inr	b		; change sign
	inx			; remember sign
plusdiv:
	lda	4(s)
	bp	plusdiv2
	iva
	ina
plusdiv2:
	jsr div16x16		; do the unsigned divide
				; A = quotient, B remainder
	xfr	b,a
	bra	signfix
