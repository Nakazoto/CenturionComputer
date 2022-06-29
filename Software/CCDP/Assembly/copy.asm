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

combuf		equ 0x01C0
	
;	Program starts at 0x0200
	
; --- TEXT ---

	ld		b,combuf
	xfr		b,y
arg_loop1:
	ld		al,(y+)
	bnz		arg_space1
	rsr		; no argument, done
arg_space1:
	ld		bl,' '
	sub		al,bl
	bnz		arg_loop1
	xfr		y,b
	st		b,(fname_src)
arg_loop2:
	ld		al,(y+)
	bnz		arg_space2
	rsr		; no argument, done
arg_space2:
	ld		bl,' '
	sub		al,bl
	bnz		arg_loop2
	xfr		y,b
	st		b,(fname_dst)
	clr		al
	st		al,(-y)
	
copy_make:
	jsr		fs_make
	ori		al,al
	bp		copy_start
	rsr		; cannot make destination
	
copy_start:
	clr		z
copy_loop:
	ld		b,(fname_src)
	jsr		fs_open
	ori		al,al
	bp		copy_readsrc
	rsr	
copy_readsrc:
	xfr		z,a
	ld		b,buffer
	jsr		fs_read
	ori		al,al
	bp		copy_opendst
	rsr
copy_opendst:
	ld		b,(fname_dst)
	jsr		fs_open
	ori		al,al
	bp		copy_writedst
	rsr
copy_writedst:
	xfr		z,a
	ld		b,buffer
	jsr		fs_write
	ori		al,al
	bp		copy_next
	rsr
copy_next:
	inr		z
	bnz		copy_loop
	rsr
	
; --- VARIABLES ---
	
fname_src:
	.byte 0x00, 0x00
	
fname_dst:
	.byte 0x00, 0x00
	
buffer:
	.byte 0x00
