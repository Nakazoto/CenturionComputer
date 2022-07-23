; --- TEXT ---

start:
	; Set up MUX0
	ld		al,0xC5
	st		al,(0xF200)

	; Set stack to 0x8000 if in ROM
	ld		a,start
	bp		prompt_p
	ld		a,0x8000
	xfr		a,s
	ld		b,start
	st		b,(-s)
	bnz		prompt_p
	
	; UTOS prompt
prompt:
	jsr		tty_crlf 
prompt_p:
	ld		bl,'/'
	jsr		tty_putc
	jsr		tty_getc
	ld		bl,'M'
	sub		al,bl
	bz		modify
	ld		bl,'G'
	sub		al,bl
	bz		gosub
	ld		bl,'B'
	sub		al,bl
	bz		boot
	ld		b,'R'
	sub		al,bl
	bnz		prompt
	rsr
	

gosub:
	; Get the address
	clr		y
	jsr		tty_getc
gosub_a:
	xfr		al,bl
	jsr		gen_hton
	bp		gosub_pa
	jmp		prompt
gosub_pa:
	slr		y
	slr		y
	slr		y
	slr		y
	ori		al,yl
	jsr		tty_getc
	ld		bl,0x0D
	sub		al,bl
	bnz		gosub_a
	jsr		(y)
	jmp		prompt

boot:
	jmp		boot_t

	
modify:
	; Get the address
	clr		y
	jsr		tty_getc
modify_a:
	xfr		al,bl
	jsr		gen_hton
	bp		modify_pa
	jmp		prompt
modify_pa:
	slr		y
	slr		y
	slr		y
	slr		y
	ori		al,yl
	jsr		tty_getc
	ld		bl,' '
	sub		al,bl
	bnz		modify_a
	
modify_l:
	ld		bl,(y)
	jsr		tty_putb
	
	; Get the byte
	clr		zl
	jsr		tty_getc
	ld		bl,' '
	sub		al,bl
	bz		modify_n
modify_b:
	xfr		al,bl
	jsr		gen_hton
	bp		modify_pb
	jmp		prompt
modify_pb:
	slr		zl
	slr		zl
	slr		zl
	slr		zl
	ori		al,zl
	jsr		tty_getc
	ld		bl,' '
	sub		al,bl
	bz		modify_nw
	ld		bl,0x0D
	sub		al,bl
	bnz		modify_b
	xfr		zl,bl
	st		bl,(y)
	jmp		prompt
	

modify_nw:
	xfr		zl,bl
	st		bl,(y)
modify_n:
	inr		y
	jmp		modify_l
	
	
; --- GENERAL OPERATIONS ---

; Turns a hex number in ASCII into a value
; AL = Returned value
; BL = Hex value
; Destroys: AL, BL
gen_hton:
	xfr		bl,al
	ld		bl,'0'
	sub		al,bl
	bp		gen_hton_i
gen_hton_e:
	ld		al,0xFF
	rsr
gen_hton_i:
	ld		al,10
	sub		bl,al
	bp		gen_hton_a
	xfr		bl,al
	rsr
gen_hton_a:
	ld		al,7
	sub		bl,al
	ld		bl,16
	sub		al,bl
	bp 		gen_hton_e
	ori		al,al
	rsr

; --- TTY OPERATIONS ---


; Does a CRLF operation
; Destorys: Al, BL
tty_crlf:
	ld		bl,0x0A
	jsr		tty_putc
	ld		bl,0x0D

; Puts a character on the terminal
; BL = ASCII to print
; Destroys: AL, BL
tty_putc:
	ld		al,(0xF200)
	srr		al
	srr		al
	bnl		tty_putc
	ld		al,0x80
	ori		al,bl
	st		bl,(0xF201)
	rsr

; Gets a character from the terminal
; AL = Returned ASCII character
; Destroys: A, BL
tty_getc:
	jsr		tty_getc_c
	xfr		al,ah
	xfr		al,bl
	jsr		tty_putc
	xfr		ah,al
	rsr
tty_getc_c:
	ld		al,(0xF200)
	srr		al
	bnl		tty_getc_c
	ld		al,(0xF201)
	ld		bl,0x7F
	and		bl,al
	ld		bl,'a'
	sub		al,bl
	bp		tty_getc_ov
	rsr
tty_getc_ov:
	ld		bl,'z'+1
	sub		al,bl
	bm		tty_getc_lu
	rsr
tty_getc_lu:
	ld		bl,0xDF
	and		bl,al
	rsr
	
; Puts a byte in hex on the terminal
; BL = Byte to print
; Destroys: A, BL
tty_putb:
	xfr		bl,ah
	srr		bl
	srr		bl
	srr		bl
	srr		bl
	jsr		tty_putb_nib
	xfr		ah,bl
tty_putb_nib:
	ld		al,0x0F
	and		al,bl
	ld		al,'0'
	add		al,bl
	ld		al,'9'+1
	sub		bl,al
	bp		tty_putb_alp
	jmp		tty_putc
tty_putb_alp:
	ld		al,7
	add		al,bl
	jmp		tty_putc
	
; --- BOOTSTRAP ---
; Putting this up here is hacky, but it works

boot_t:
	; Set up MUX3
	ld		bl,0xF6
	st		bl,(0xF206)
	
	; Clear MUX3
	ld		al,(0xF207)
	
	; Send bootstrap 
	ld		bl,01
	st		bl,(0xF207)
	ld		b,0x0200
	xfr		b,s
boot_l:
	ld		al,(0xF206)
	srr		al
	bnl		boot_l
	ld		al,(0xF207)
	st		al,(b)
	inr		bl
	bnz		boot_l
	jmp		0x0200
