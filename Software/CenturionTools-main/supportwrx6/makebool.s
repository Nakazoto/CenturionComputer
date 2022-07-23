	.setcpu 4
	.code

	.export booleq
	.export boolne
	.export boolle
	.export boollt
	.export boolge
	.export boolgt
	.export boolule
	.export boolult
	.export booluge
	.export boolugt

;
;	Turn  val op test into 1 for true 0 for false. Ensure the Z flag
;	is appropriately set
;

booleq:
	bnz	ret0
ret1:
	lda	1
	rsr

boolne:
	bnz	ret1
ret0:
	cla
	rsr

boollt:
	bz	ret0
boolle:
	ble	ret1
	cla
	rsr

boolge:
	bz	ret1
boolgt:	bgz	ret1
	cla
	rsr

boolult:
	bz	ret0
boolule:
	bnl	ret1
	cla
	rsr

booluge:
	bz	ret1
boolugt:			; use C flag
	lda	0		; doesn't affect carry unlike clr
	rlrb	al
	rsr
