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
	
; --- TEXT ---

	clr		z
dir_loop:
	xfr		z,a
	ld		b,buffer
	jsr		fs_list
	ori		al,al
	bm		dir_loop ; See if there is an error
	ld		al,(buffer)
	bnz		dir_print
	rsr		; All done
dir_print:
	ld		bl,14
	xfr		bl,ah
	ld		b,buffer
	xfr		b,y
dir_print_l:
	ld		bl,(y+)
	bnz		dir_print_put
	ld		bl,' '
	dcr		y
dir_print_put:
	jsr		tty_putc
	dcr		ah
	bnz		dir_print_l
	ld		b,(file_size)
	jsr		tty_putw
	ld		b,str_blocks
	jsr		tty_puts
	inr		z
	jmp		dir_loop
	
	
; --- STRINGS ---
str_blocks:
	.ascii " BLOCKS"
	.byte	0x0D,0x0A,0x00

	
buffer:
	.ascii	"              "

file_size:
	.byte	0x00, 0x00
