;	Program starts at 0x0200
	
crc_poly	equ 10100111b

; --- VARIABLES ---

; Save registers
v_asave		equ 0x0400
v_bsave		equ 0x0402

; CRC variable
v_crc		equ 0x0404

; Execution vector
v_exec		equ 0x0405

; File name
fname		equ open_com+3		

; Block buffer
buffer		equ 0x0300

; --- TEXT ---

start:
	ld		bl,0x0D
	jsr		tty_putc
	ld		bl,0x0A
	jsr		tty_putc
	ld		bl,'@'
	jsr		tty_putc
	ld		b,fname
	xfr		b,y
getstr:
	jsr		tty_getc
	ld		bl,0x20
	sub		al,bl
	bm		bootstr
	st		al,(y+)
	jmp		getstr
bootstr:
	clr		al
	st		al,(y)
	
	jsr		fs_res_crc ; Reset CRC
	ld		a,0x1300
	ld		b,open_com
	xfr		b,y
open_body:
	ld		bl,(y+)
	jsr		fs_send
	dcr		ah
	bnz		open_body
	ld		bl,(v_crc)
	jsr		fs_send ; send out the CRC
	jsr		fs_recv ; get status
	xfr		al,ah
	jsr		fs_recv ; get CRC, we don't care about it
	ori		ah,ah
	bm		start ; if error, restart
	ld		b,buffer
	xfr		b,y
	clr		bh
	jsr		fs_read
	ld		b,(buffer)
	st		b,(v_exec)
	xfr		b,y
	clr		bh
load_loop:
	inr		bh
	jsr		fs_read
	jmp		load_loop
	
execute:
	jsr		fs_recv
	.byte	0x72
	.word	v_exec
	
; --- FILESYSTEM OPERATIONS ---

; Mini-fied read command
; BH = Block #
; Y = Result buffer
fs_read:
	jsr		fs_res_crc
	ld		bl,7
	jsr		fs_send
	clr		bl
	jsr		fs_send
	xfr		bh,bl
	jsr		fs_send
	ld		bl,(v_crc)
	jsr		fs_send
	jsr		fs_recv
	xfr		al,bl
	bm		execute ; nothing more to read, time to exec
	clr		ah
fs_read_l:
	jsr		fs_recv
	st		al,(y+)
	inr		ah
	bnz		fs_read_l
	jsr		fs_recv ; get the CRC, but we don't care
	rsr
	



; Sends a byte though the SerialDir MUX port
; BL = Byte to send
; Destroys: AL, BL
fs_send:
	ld		al,(0xF206)
	srr		al
	srr		al
	bnl		fs_send
	st		bl,(0xF207)
	jsr		fs_crc
	rsr
	
; Gets a byte from the SerialDir MUX port
; AL = Returned byte
; Destroys: AL, BL
fs_recv:
	ld		al,(0xF206)
	srr		al
	bnl		fs_recv
	ld		al,(0xF207)
	xfr		al,bl
	jsr		fs_crc
	rsr
	
; Resets the CRC
; Destroys: AL
fs_res_crc:
	ld		al,251
	st		al,(v_crc)
	rsr
	
; Updates the CRC
; BL: Value to encode
; Destroys: Nothing
fs_crc:
	st		b,(v_bsave) ; save register B
	st		a,(v_asave) ; save register A
	ld		al,8
	xfr		al,ah
	ld		al,(v_crc)
fs_crc_l:
	slr		bl
	rlr		al
	bnl		fs_crc_lc
	xfr		bl,bh
	ld		bl,crc_poly
	ore		bl,al
	xfr		bh,bl
fs_crc_lc:
	dcr		ah
	bnz		fs_crc_l
	st		al,(v_crc)
	ld		a,(v_asave) ; restore register A
	ld		b,(v_bsave) ; restore register B
	rsr

; --- TTY OPERATIONS ---

; Puts a character on the terminal
; BL = ASCII to print
; Destroys: AL, BL
tty_putc:
	dly		; poor man's wait
	ld		al,0x80
	ori		al,bl
	st		bl,(0xF201)
	rsr

; Gets a character from the terminal
; AL = Returned ASCII character
; Destroys: AL, BL
tty_getc:
	ld		al,(0xF200)
	srr		al
	bnl		tty_getc
	ld		bl,(0xF201)
	jsr		tty_putc
	ld		al,0x7F
	and		bl,al
	rsr

; --- DATA ---
	
; Special fun byte ;)
open_com:
	.byte		0x02
