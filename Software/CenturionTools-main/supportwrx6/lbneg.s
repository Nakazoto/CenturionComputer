;
;	Boolean negation for a long
;
	.export bnegeax

	.setcpu 4
	.code

bnegeax:
	ori	y,a
	bz	set1
	cla
	rsr
set1:
	ina
	rsr
