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

	ld		b,str_hello
	jsr		tty_puts
	rsr

; --- STRINGS ---
str_hello:
	.ascii "HELLORLD!"
	.byte	0x0D,0x0A,0x00
