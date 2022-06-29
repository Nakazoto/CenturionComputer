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
	ld		b,str_hello
	jsr		tty_puts
	
config:
	; Get file name
	ld		b,str_file
	jsr		tty_puts
	ld		b,output
	ld		al,13
	jsr		tty_gets
	
getunit:
	; Get unit #
	ld		b,str_unit
	jsr		tty_puts
	ld		b,single_buffer
	ld		al,1
	jsr		tty_gets
	ld		b,(single_buffer_h)
	jsr		gen_htoi
	st		al,(unit)
	
	; check
	ld		bl,8
	sub		al,bl
	bm		getcyl
	ld		b,str_uniterr
	jsr		tty_puts
	jmp		getunit
	
	
	
	; Get cylinder
getcyl:
	ld		b,str_cyl
	jsr		tty_puts
	ld		b,quad_buffer
	ld		al,4
	jsr		tty_gets
	ld		b,(quad_buffer)
	jsr		gen_htoi
	st		al,(cylinder)
	ld		b,(quad_buffer+2)
	jsr		gen_htoi
	st		al,(cylinder+1)
	
	ld		a,(cylinder)
	bm		cylerr
	ld		b,406
	sub		a,b
	bm		getready
cylerr:
	ld		b,str_cylerr
	jsr		tty_puts
	jmp		getcyl

	
getready:
	ld		b,str_ready
	jsr		tty_puts
	ld		b,single_buffer
	ld		al,1
	jsr		tty_gets
	ld		al,(single_buffer)
	ld		bl,'Y'
	sub		al,bl
	bnz		config
	
	; Make the file
	ld		b,output
	jsr		fs_open
	ori		al,al
	bp		skipmake
	ld		b,output
	jsr		fs_make
skipmake:

	; Select the unit
	ld		al,(unit)
	st		al,(0xF140)
	ld		a,(0xF144)
	ld		b,0x0010
	and		b,a
	bz		hawkerr_t
	
	; Finish init
	ld		b,heap
	xfr		b,y
	ld		b,512
	clr		al
	dcr		al
clear:
	st		al,(y+)
	dcr		b
	bnz		clear
	ld		b,str_starting
	jsr		tty_puts
	
	; RTZ
	clr		a
	st		a,(0xF141)
	ld		al,3
	jsr		hawkcmd
	bnz		hawkerr_t
	
	; Position to track
	jsr		getaddr
	jsr		position
	
	
	jmp		dumpcyl
	
hawkerr_t:
	jmp		hawkerr
	
; File error
filerr:
	ld		b,str_filerr
	jsr		tty_puts
	jmp		sys_done
	
; Dumps a cylinder
dumpcyl:
	; Print out current cylinder
	ld		b,str_cylstat
	jsr		tty_puts
	ld		b,(cylinder)
	jsr		tty_putw
	ld		bl,' '
	jsr		tty_putc

	; Reset sector counter
	clr		al
	st		al,(sector)
	
	; Seek to cylinder
	jsr		getaddr
	st		b,(0xF141)
	jsr		hawkseek
	
	; Open file
	ld		bl,6
	xfr		bl,zl
open:
	dcr		zl
	bz		filerr
	ld		b,output
	jsr		fs_open
	ori		al,al
	bm		open
	
; Dumps a sector
dumpsect:
	; Set read retry counter
	ld		bl,3
	xfr		bl,zl

	; Check for spacebar
	jsr		tty_next
	ori		al,al
	bz		readsect
	jsr		tty_getc
	ld		bl,' '
	sub		al,bl
	bnz		readsect
	ld		b,str_inter
	jmp		tty_puts

readsect:
	; Check read counts
	dcr		zl
	bz		readfail

	; Read from disk
	jsr		getaddr
	st		b,(0xF141)
	
	; DMA stuff
	.byte	0x2F,0x04	; dma_set_mode 0
	.byte	0x2F,0x06	; dma_enable
	ld		a,heap
	.byte	0x2F,0x00	; dma_load_addr A
	ld		a,0xFE6F
	.byte	0x2F,0x02	; dma_load_count A
	
	; Call hawk command
	ld		al,0
	jsr		hawkcmd
	bz		write
	
	; Error handler code
	; RTZ
	clr		a
	st		a,(0xF141)
	ld		al,3
	jsr		hawkcmd
	bnz		hawkerr_t
	
	; Seek to cylinder again
	jsr		getaddr
	jsr		position
	jmp		readsect
	
; Read file condition
readfail:
	ld		bl,'X'
	jsr		tty_putc
	jmp		nextsect
	
	
write:
	; Write to file
	ld		bl,6
	xfr		bl,zl
write_a:
	dcr		zl
	bz		filerr_t
	ld		a,(address)
	slr		a
	ld		b,heap
	jsr		fs_write
	ori		al,al
	bm		write_a
	
	ld		bl,6
	xfr		bl,zl
write_b:
	dcr		zl
	bz		filerr_t
	ld		a,(address) 
	slr		a
	inr		a
	ld		b,heap+256
	jsr		fs_write
	ori		al,al
	bm		write_b
	
	ld		bl,'.'
	jsr		tty_putc
	
; Increment sector
nextsect:
	ld		al,(sector)
	ld		bl,32
	inr		al
	sub		al,bl
	bz		nextcyl
	st		al,(sector)
	jmp		dumpsect
	
nextcyl:
	ld		a,(cylinder)
	ld		b,406
	inr		a
	sub		a,b
	bz		done
	st		a,(cylinder)
	jmp		dumpcyl
	
	
done:
	ld		b,str_done
	jsr		tty_puts
		
	; Exit
	rsr
	
	; File error tramp
filerr_t:
	jmp		filerr
	
; Hawk drive error
hawkerr:
	ld		b,str_hwkerr
	jsr		tty_puts
	ld		b,(0xF144)
	jsr		tty_putw
	jmp		sys_done
	
; Gets the current address
getaddr:
	ld		b,(cylinder)
	slr		b
	slr		b
	slr		b
	slr		b
	slr		b
	ld		al,(sector)
	ori		al,bl
	st		b,(address)
	rsr

	
; Executes a hawk command
; AL = Hawk command
hawkcmd:
	st		al,(0xF148)
hawkcmd_w:
	ld		al,(0xF144)
	srr		al
	bl		hawkcmd_w
	ld		al,(0xF144)
	rsr
	
hawkseek:
	ld		al,2
	st		al,(0xF148)
	ld		a,0x0190
hawkseek_l:
	ld		b,0x2000
	ld		bl,(0xF145)
	and		bh,bl
	bnz		hawkseek_s
	dly
	dcr		a
	bnz		hawkseek_l
	ld		b,str_timeout
	jsr		tty_puts
	jmp		sys_done
hawkseek_s:
	ld		al,(0xF144)
	bnz		hawkerr
	rsr

; Slow position
position:
	clr		y
position_l:
	ld		b,(address)
	sub		y,b
	bm		position_s
	rsr
position_s:
	xfr		y,b
	st		b,(0xF141)
	jsr		hawkseek
	ld		a,8
	add		a,y
	jmp		position_l
	
; --- STRINGS ---

str_hello:
	.ascii "HAWK DRIVE DUMP UTILITY V0.1.7"
	.byte	0x00
str_crlf:
	.byte	0x0D,0x0A,0x00
	
str_file:
	.byte	0x0D,0x0A
	.ascii "OUTPUT FILE NAME? "
	.byte	0x00
	
str_unit:
	.byte	0x0D,0x0A
	.ascii "UNIT # (X)? "
	.byte	0x00
	
str_uniterr:
	.byte	0x0D,0x0A
	.ascii "BAD UNIT"
	.byte	0x0D,0x0A,0x00
	
str_cyl:
	.byte	0x0D,0x0A
	.ascii "STARTING CYLINDER # (XXXX)? "
	.byte	0x00
	
str_cylerr:
	.byte	0x0D,0x0A
	.ascii "BAD CYLINDER"
	.byte	0x0D,0x0A,0x00
	
str_ready:
	.byte	0x0D,0x0A
	.ascii "READY TO BEGIN? (Y/N)? "
	.byte	0x00
	
str_starting:
	.byte	0x0D,0x0A
	.ascii "STARTING DUMP"
	.byte	0x0D,0x0A
	.ascii "PRESS [SPACE] TO INTERRUPT"
	.byte	0x00
	
str_cylstat:
	.byte	0x0D,0x0A
	.ascii "CYLINDER #"
	.byte	0x00
	
str_done:
	.byte	0x0D,0x0A
	.ascii "DUMP COMPLETE"
	.byte	0x00
	
str_hwkerr:
	.byte	0x0D,0x0A
	.ascii "HAWK ERROR "
	.byte	0x00
	
str_timeout:
	.byte	0x0D,0x0A
	.ascii "TIMED OUT"
	.byte	0x00
	
str_inter:
	.byte	0x0D,0x0A
	.ascii "INTERRUPTED"
	.byte	0x00
	
str_filerr:
	.byte	0x0D,0x0A
	.ascii "FILE I/O ERROR"
	.byte	0x00
	
	
; --- VARIABLES ---

; Input buffers
single_buffer_h:
	.ascii	"0"
single_buffer:
	.ascii	"0"
	.byte	0x0 

quad_buffer:
	.ascii	"0000"
	.byte	0x0 
	
; Output filename

output:
	.ascii "XXXXXXXXXXXXXXXX"

; Positioning variables

unit:
	.byte 	0x00

cylinder:
	.byte	0x00,0x00
	
sector:
	.byte	0x00
	
address:
	.byte	0x00,0x00
	
heap:

