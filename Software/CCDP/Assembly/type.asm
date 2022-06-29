; --- EQUATES ---

sys_done	equ	0x0100
tty_putc	equ	0x0103
tty_putb	equ	0x0106
tty_putw	equ	0x0109
tty_puts	equ	0x010C
tty_getc	equ 0x010F
tty_gets	equ 0x0112
fs_open		equ 0x0115
fs_close	equ 0x0118
fs_make		equ 0x011B
fs_delete	equ 0x011E
fs_list		equ 0x0121
fs_read		equ 0x0124
fs_write	equ 0x0127

combuf		equ	0x01C0
	
; --- TEXT ---

	ld		b,combuf
	xfr		b,y
arg_loop:
	ld		al,(y+)
	bnz		arg_space
	rsr		; no argument, done
arg_space:
	ld		bl,' '
	sub		al,bl
	bnz		arg_loop
	xfr		y,b ; open file
	jsr		fs_open
	ori		al,al
	bp		type_read
	rsr		; cannot read file
type_read:
	clr		z
type_read_l:
	xfr		z,a
	ld		b,buffer
	jsr		fs_read
	ld		bl,255
	sub		al,bl
	bz		type_read_l ; communication issues
	ori		al,al
	bp		type_print
	rsr		; no more blocks to read
type_print:
	clr		al
	st		al,(buffer + 256) ; zero termination
	ld		b,buffer
	jsr		tty_puts
	inr		z
	jmp		type_read_l
	
; --- VARIABLES ---
	
buffer:
	.byte 0x00
