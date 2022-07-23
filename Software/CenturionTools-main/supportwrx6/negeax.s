;
;	Negate the working register
;
	.export negeax

	.setcpu 4
	.code

negeax:
	iva
	ivr	y
	ina
	bnz	noripple
	inr	y
noripple:
	rsr
