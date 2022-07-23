	.export __setjmp
	.code

;
;	The call path saved x automatically in hardware and set x to the
;	return linkage
;
;	Save the return address. frame and stack pointer. Everything else is
;	expected to be trashed.
;
__setjmp:
	ld y,2(s)
	st s,(y)
	st x,2(y)
	st z,4(y)
	ret

	
