;
;	Complement the 32bit working register
;
	.setcpu 4
	.export compleax

	.code
;
;	Two's complement - invert bits and add one
;
compleax:
	iva
	ivr	y
	ina
	bnz	nocarry
	inr	y
nocarry:
	rsr
