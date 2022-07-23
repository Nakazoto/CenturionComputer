;
;	Right shift the 32bit working register by 8
;
	.export asreax8

	.setcpu 4

	.code

asreax8:
	xfrb	ah,al
	xfrb	yl,ah
	xfrb	yh,yl
	bp	nosign
	clrb	yh
	dcrb	yh
	rsr
nosign:
	clrb	yh
	rsr

