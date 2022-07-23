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
regedit:
	ld		b,str_hello
	jsr		tty_puts
	
	ld		b,str_unit
	jsr		tty_puts
	ld		b,unit_buffer
	ld		al,2
	jsr		tty_gets
	
	ld		b,str_sector
	jsr		tty_puts
	ld		b,sec_buffer
	ld		al,4
	jsr		tty_gets
	
	ld		b,str_cmd
	jsr		tty_puts
	ld		b,cmd_buffer
	ld		al,2
	jsr		tty_gets
	
	ld		b,str_insr
	jsr		tty_puts
	
exec:
	ld		b,(unit_buffer)
	jsr		gen_htoi
	st		al,(0xF140)
	
	ld		b,(sec_buffer)
	jsr		gen_htoi
	st		al,(0xF141)
	
	ld		b,(sec_buffer+2)
	jsr		gen_htoi
	st		al,(0xF142)
	
	ld		b,(cmd_buffer)
	jsr		gen_htoi
	st		al,(0xF148)
	
print:
	ld		b,str_status
	jsr		tty_puts
	
	ld		b,(0xF144)
	ld		al,16
	xfr		al,ah
	
put_bin:
	ld		al,0x80
	st		b,(-s)
	and		bh,al
	
	bz		put_bin_z
	
	ld		bl,'1'
	jmp		put_bin_c
	
put_bin_z:
	ld		bl,'0'
put_bin_c:
	jsr		tty_putc
	ld		b,(s+)
	
	slr		b
	dcr		ah
	bnz		put_bin
	
	; Check for commands
	jsr		tty_next
	ori		al,al
	
	bz		print
	
	jsr		tty_getc
	
	ld		bl,0x20
	sub		al,bl
	bnz		check_n
	jmp		regedit
	
check_n:
	ld		bl,0x0D
	sub		al,bl
	bz		exec
	
	ld		b,0x0A
	sub		al,bl
	bz		exec
	
	ld		b,'E'
	sub		al,bl
	bnz		print
	
	rsr

; --- STRINGS ---

str_hello:
	.byte	0x0C
	.ascii "HAWK DRIVE MONITOR UTILITY V0.1.1"
	.byte	0x00
str_crlf:
	.byte	0x0D,0x0A,0x00

str_unit:
	.byte	0x0D,0x0A
	.ascii "UNIT REG (XX)? "
	.byte	0x00
	
str_sector:
	.byte	0x0D,0x0A
	.ascii "SECTOR REG (XXXX)? "
	.byte	0x00
	
str_cmd:
	.byte	0x0D,0x0A
	.ascii "COMMAND REG (XX)? "
	.byte	0x00
	
str_insr:
	.byte	0x0D,0x0A
	.ascii "[SPACE] = EDIT REG, [ENTER] = RERUN LAST, [E] = EXIT"
	.byte	0x0D,0x0A,0x00
	
str_status:
	.byte	0x0D
	.ascii "STATUS = "
	.byte	0x00

; --- VARIABLES ---

sec_buffer:
	.ascii	"0000"
	.byte	0x0 
	
unit_buffer:
	.ascii	"00"
	.byte	0x0 

cmd_buffer:
	.ascii	"00"
	.byte	0x0 
