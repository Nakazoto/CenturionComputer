; --- EQUATES ---

sys_done	equ 0x0100
tty_putc	equ 0x0103
tty_putb	equ 0x0106
tty_putw	equ 0x0109
tty_puts	equ 0x010C
tty_getc	equ 0x010F
tty_gets	equ 0x0112
fs_open		equ 0x0115
fs_close	equ 0x0118
fs_make		equ 0x011B
fs_delete	equ 0x011E
fs_list		equ 0x0121
fs_read		equ 0x0124
fs_write	equ 0x0127
gen_htoi	equ 0x012A
tty_next	equ 0x012D

combuf		equ 0x01C0
	
;	Program starts at 0x0200
	
; --- TEXT ---

	; Print intro message
	ld		b,str_hello
	jsr		tty_puts
	
	; Set up interrupt vectors
	ld		a,irq01
	st		a,(0x001E)
	ld		a,irq02
	st		a,(0x002E)
	ld		a,irq03
	st		a,(0x003E)
	ld		a,irq04
	st		a,(0x004E)
	ld		a,irq05
	st		a,(0x005E)
	ld		a,irq06
	st		a,(0x006E)
	ld		a,irq07
	st		a,(0x007E)
	ld		a,irq08
	st		a,(0x008E)
	ld		a,irq09
	st		a,(0x009E)
	ld		a,irq10
	st		a,(0x00AE)
	ld		a,irq11
	st		a,(0x00BE)
	ld		a,irq12
	st		a,(0x00CE)
	ld		a,irq13
	st		a,(0x00DE)
	ld		a,irq14
	st		a,(0x00EE)
	ld		a,irq15
	st		a,(0x00FE)
	
	; Set up Z registers, I guess
	ld		a,1
	st		a,(0x0018)
	st		a,(0x0028)
	st		a,(0x0038)
	st		a,(0x0048)
	st		a,(0x0058)
	st		a,(0x0068)
	st		a,(0x0078)
	st		a,(0x0088)
	st		a,(0x0098)
	st		a,(0x00A8)
	st		a,(0x00B8)
	st		a,(0x00C8)
	st		a,(0x00D8)
	st		a,(0x00E8)
	st		a,(0x00F8)
	
	clr		a
	st		a,(0x001C)
	st		a,(0x002C)
	st		a,(0x003C)
	st		a,(0x004C)
	st		a,(0x005C)
	st		a,(0x006C)
	st		a,(0x007C)
	st		a,(0x008C)
	st		a,(0x009C)
	st		a,(0x00AC)
	st		a,(0x00BC)
	st		a,(0x00CC)
	st		a,(0x00DC)
	st		a,(0x00EC)
	st		a,(0x00FC)
	
	; Print the instructions
	ld		b,str_help
	jsr		tty_puts
	
	; Wait for char
	jsr		tty_getc
	
	; Start the test
	ld		b,str_begin
	jsr		tty_puts
	ei
	
	; Wait for char
	jsr		tty_getc
	
	; End test
	di
	ld		b,str_done
	jsr		tty_puts
	
	; Print results
	clr		z
loop:
	ld		al,30
	sub		zl,al
	bz		exit
	
	ld		b,str_level
	jsr		tty_puts
	xfr		zl,bl
	srr		bl
	inr		bl
	jsr		tty_putb
	
	ld		bl,':'
	jsr		tty_putc
	ld		bl,' '
	jsr		tty_putc
	
	ld		a,count01
	add		z,a
	ld		b,(a)
	jsr		tty_putw
	
	ld		b,str_crlf
	jsr		tty_puts
	inr		zl
	inr		zl
	jmp		loop
	
	; End program
exit:
	di
	jmp		sys_done
	
; --- INTERRUPT VECTORS ---
	
irq01:
	ld		a,(count01)
	inr		a
	st		a,(count01)
	ld		a,1
	xfr		a,z
	ri
	jmp		irq01
	
irq02:
	ld		a,(count02)
	inr		a
	st		a,(count02)
	ld		a,1
	xfr		a,z
	ri
	jmp		irq02
	
irq03:
	ld		a,(count03)
	inr		a
	st		a,(count03)
	ld		a,1
	xfr		a,z
	ri
	jmp		irq03
	
irq04:
	ld		a,(count04)
	inr		a
	st		a,(count04)
	ld		a,1
	xfr		a,z
	ri
	jmp		irq04
	
irq05:
	ld		a,(count05)
	inr		a
	st		a,(count05)
	ld		a,1
	xfr		a,z
	ri
	jmp		irq05
	
irq06:
	ld		a,(count06)
	inr		a
	st		a,(count06)
	ld		a,1
	xfr		a,z
	ri
	jmp		irq06
	
irq07:
	ld		a,(count07)
	inr		a
	st		a,(count07)
	ld		a,1
	xfr		a,z
	ri
	jmp		irq07
	
irq08:
	ld		a,(count08)
	inr		a
	st		a,(count08)
	ld		a,1
	xfr		a,z
	ri
	jmp		irq08

irq09:
	ld		a,(count09)
	inr		a
	st		a,(count09)
	ld		a,1
	xfr		a,z
	ri
	jmp		irq09
	
irq10:
	ld		a,(count10)
	inr		a
	st		a,(count10)
	ld		a,1
	xfr		a,z
	ri
	jmp		irq10
	
irq11:
	ld		a,(count11)
	inr		a
	st		a,(count11)
	ld		a,1
	xfr		a,z
	ri
	jmp		irq11

irq12:
	ld		a,(count12)
	inr		a
	st		a,(count12)
	ld		a,1
	xfr		a,z
	ri
	jmp		irq12

irq13:
	ld		a,(count13)
	inr		a
	st		a,(count13)
	ld		a,1
	xfr		a,z
	ri
	jmp		irq13
	
irq14:
	ld		a,(count14)
	inr		a
	st		a,(count14)
	ld		a,1
	xfr		a,z
	ri
	jmp		irq14

irq15:
	ld		a,(count15)
	inr		a
	st		a,(count15)
	ld		a,1
	xfr		a,z
	ri
	jmp		irq15

; --- STRINGS ---

str_hello:
	.ascii "INTERRUPT ACTIVITY PROBE V0.1.3"
str_crlf:
	.byte	0x0D,0x0A,0x00
	
str_help:
	.byte	0x0D,0x0A
	.ascii "PRESS ANY KEY TO BEGIN THE TEST"
	.byte	0x0D,0x0A
	.ascii "DURING TEST, PRESS THE KEY AGAIN TO END THE TEST AND PRINT REPORT"
	.byte	0x0D,0x0A,0x00
	
str_begin:
	.ascii "TEST IS RUNNING..."
	.byte	0x0D,0x0A,0x00
	
str_done:
	.ascii "TEST COMPLETE"
	.byte	0x0D,0x0A,0x00
	
str_level:
	.ascii "LEVEL #"
	.byte	0x00

; --- VARIABLES ---

count01:
	.byte	0x00,0x00
	
count02:
	.byte	0x00,0x00

count03:
	.byte	0x00,0x00

count04:
	.byte	0x00,0x00
	
count05:
	.byte	0x00,0x00
	
count06:
	.byte	0x00,0x00

count07:
	.byte	0x00,0x00

count08:
	.byte	0x00,0x00
	
count09:
	.byte	0x00,0x00
	
count10:
	.byte	0x00,0x00

count11:
	.byte	0x00,0x00

count12:
	.byte	0x00,0x00
	
count13:
	.byte	0x00,0x00
	
count14:
	.byte	0x00,0x00

count15:
	.byte	0x00,0x00
