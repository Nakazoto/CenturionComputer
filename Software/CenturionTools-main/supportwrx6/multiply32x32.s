;
;	32bit multiply by addition
;
;	Multiply 3,x by Y:A
;
		.export tosumuleax
		.export tosmuleax
		.setcpu 4

		.code
;
;	Compute the 32 x 16 multiply of XB * Z into (Y)
;	Eats X A B Z
;
bits16:
		ori	z,z
		bz	done16
		slr	z
		bnl	noadd
		; tmp += XB
		lda	2(y)
		add	b,a
		sta	2(y)
		bnl	norip
		inr	x
norip:
		lda	(y)
		add	x,a
		sta	(y)
noadd:
		; XB >>= 1
		slr	b
		rlr	x
		bra	bits16
done16:		rsr

;
;	Compute stack top x YA (32bit x 32bit)
;
tosmuleax:
tosumuleax:
		stx	(-s)
		xfr	z,a
		sta	(-s)

		; Save YA
		sta	(tmp4)
		xfr	y,a
		sta	(tmp3)

		; Clear the 32bit workspace
		cla
		sta	(tmp)
		sta	(tmp2)

		lda	tmp
		xay

		lda	8(s)		; low half
		xaz
		ldx	(tmp3)
		ldb	(tmp4)
		jsr	bits16

		; First upper half
		ldb	(y+)		; inc y by 2

		lda	6(s)
		xaz
		ldx	(tmp4)
		ldb	(tmp3)
		jsr	bits16

		; Second upper half
		lda	(tmp3)
		xaz
		ldx	6(s)
		ldb	8(s)
		jsr	bits16

		; And upper 16 x upper 16 shifts by 32bits so is lost

		; At this point tmp/tmp2 holds the result
		lda	(tmp)
		xay
		lda	(tmp2)

		; Clean up
		lda	(s+)
		xaz
		ldx	(s+)
		; Throw the dword off the stack
		ldb	(s+)
		ldb	(s+)
		rsr
