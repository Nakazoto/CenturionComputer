
	.export	shreax8
	.setcpu 4

	.code

shreax8:
	xfr	ah,al
	xfr	yl,ah
	xfr	yh,yl
	clr	yh
	rsr
