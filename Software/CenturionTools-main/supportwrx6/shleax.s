;
;	Shift the 32bit primary left 1-4 bits
;

	.export shleax1
	.export shleax2
	.export shleax3
	.export shleax4
	.export asleax1
	.export asleax2
	.export asleax3
	.export asleax4

	.setcpu 4
	.code

shleax4:
asleax4:
	sla
	rlr	y
shleax3:
asleax3:
	sla
	rlr	y
shleax2:
asleax2:
	sla
	rlr	y
shleax1:
asleax1:
	sla
	rlr	y
	rsr


