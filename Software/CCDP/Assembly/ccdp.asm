; --- EQUATES ---

combuf		equ 0x01C0
crc_poly	equ 10100111b

; --- VARIABLES ---

; System variable block base
v_base		equ textop


; Save registers
v_asave		equ v_base
v_bsave		equ v_base+2

; CRC variable
v_crc		equ v_base+4

; Execution variables
v_execbuf	equ v_base+5

; Image top

top			equ	v_base+15

; --- TEXT ---

stack: ; stack pointer symbol, bottom of image for now
start: ; bottom of image

; -- COLD BOOT OPERATIONS --

	; set stack pointer
	ld		a,stack
	xfr		a,s ; this right <- left syntax is *super* annoying
	
	; start post-bootstrap init
	ld		b,str_hello
	jsr		tty_puts
	
	; print system vectors 
	ld		bl,9
	jsr		tty_putc
	ld		b,start
	jsr		tty_putw
	ld		b,str_start
	jsr		tty_puts
	
	ld		bl,9
	jsr		tty_putc
	ld		b,con_prompt
	jsr		tty_putw
	ld		b,str_prompt
	jsr		tty_puts
	
	ld		bl,9
	jsr		tty_putc
	ld		b,top
	jsr		tty_putw
	ld		b,str_top
	jsr		tty_puts
	
	ld		bl,9
	jsr		tty_putc
	ld		b,stack
	jsr		tty_putw
	ld		b,str_stack
	jsr		tty_puts
	
	ld		b,autoexec
	xfr		b,y
	ld		b,combuf
	ld		al,64
	jsr		gen_memcpy
	jmp		con_exec

autoexec:
	.ascii	"TYPE WELCOME.TXT"
	.byte	0x00
	
; --- CONSOLE OPERATIONS ---

; Prompts the user for a command
con_prompt:
	ld		b,str_ready
	jsr		tty_puts
	ld		b,combuf
	ld		al,63
	jsr		tty_gets
	ld		bl,0x0A
	jsr		tty_putc
	ld		bl,0x0D
	jsr		tty_putc
	
; Executes whatever is in the combuf
con_exec:
	ld		b,combuf
	xfr		b,z
	ld		b,v_execbuf
	xfr		b,y
	ld		bl,9
	xfr		bl,bh
con_exec_fn:
	ld		al,(z+)
	ld		bl,0x21
	sub		al,bl
	bm		con_exec_bin
	st		al,(y+)
	dcr		bh
	bnz		con_exec_fn
con_exec_bin:
	xfr		y,b
	ld		a,str_bin
	xfr		a,y
	ld		al,5
	jsr		gen_memcpy
	
	ld		b,v_execbuf
	jsr		fs_open
	xfr		al,al
	bm		con_exec_err ; Check for errors
	
	clr		z ; Start at block zero
con_exec_ld:
	xfr		zl,bl
	ld		al,0x02 ; Program image base is 0x0200
	add		al,bl
	bz		con_exec_err ; Overflow, this is bad!
	xfr		bl,bh
	clr		bl
	xfr		z,a
	jsr		fs_read ; Read that block into memory
	ld		bl,255
	sub		al,bl
	bz		con_exec_ld ; If communication error, retry
	ori		al,al
	bm		con_exec_run ; General failure, we must be done loading (hopefully)
	inr		zl
	jmp		con_exec_ld
con_exec_run:
	ld		b,vec_tab
	xfr		b,y
	ld		b,0x0100 ; Vector table location is 0x0100
	ld		al,48
	jsr		gen_memcpy
	jsr		fs_close
	
	jsr		0x0200 ; and execute!
	
con_exec_done:
	
	jsr		fs_close ; close stray files
	ld		a,stack	; set stack pointer
	xfr		a,s
	jmp		con_prompt

	
	
	
con_exec_err:
	ld		b,str_nocmd
	jsr		tty_puts
	jmp		con_prompt
	
; --- GENERAL OPERATIONS ---

; Copies one part of memory to another
; AL = # bytes
; B = Destination
; Y = Source
; Destroys, A, B, Y
gen_memcpy:
	xfr		al,ah
gen_memcpy_l:
	ld		al,(y+)
	st		al,(b+)
	dcr		ah
	bnz		gen_memcpy_l
	rsr
	
; Turns a hex number in ASCII into a value
; AL = Returned value
; B = Hex value
; Destroys: A, B
gen_htoi:
	jsr		gen_htoi_n
	xfr		al,ah
	xfr		bh,bl
	jsr		gen_htoi_n
	slr		al
	slr		al
	slr		al
	slr		al
	ori		ah,al
	rsr
gen_htoi_n:
	xfr		bl,al
	ld		bl,'0'
	sub		al,bl
	bp		gen_htoi_i
gen_htoi_e:
	clr		al
	rsr
gen_htoi_i:
	ld		al,10
	sub		bl,al
	bp		gen_htoi_a
	xfr		bl,al
	rsr
gen_htoi_a:
	ld		al,7
	sub		bl,al
	ld		bl,16
	sub		al,bl
	bp 		gen_htoi_e
	rsr

; --- FILESYSTEM OPERATIONS ---

; Required external functions:
; fs_open, fs_close, fs_make, fs_delete, fs_list, fs_read, fs_write

; Opens up a file for use
; B = Filename string
; AL = Returned status
; Destroys: A, B, Y 
fs_open:
	xfr		b,y
	jsr		fs_res_crc
	ld		bl,2
fs_filecom:
	jsr		fs_com_noblk
	ld		al,16
	xfr		al,bh
fs_open_l: ; Read in 16 bytes of filename
	ld		bl,(y+)
	jsr		fs_send
	dcr		bh
	bnz		fs_open_l
	jmp		fs_recv_stat

; Closes the currently open file
; AL = Returned status
; Destroys; A, B
fs_close:
	jsr		fs_res_crc
	ld		bl,3
	jsr		fs_com_noblk
fs_recv_stat:
	ld		bl,(v_crc)
	jsr		fs_send ; CRC
	jsr		fs_res_crc ; Prepare to receive
	jsr		fs_recv ; Receive status
	xfr		al,ah
fs_recv_crc: ; status should be in ah
	ld		al,(v_crc)
	xfr		al,bh
	jsr		fs_recv ; Recieve CRC
	sub		al,bh
	bnz		fs_close_mis ; CRC mismatch
	xfr		ah,al
	rsr
fs_close_mis:
	ld		al,255
	rsr
	
; Makes a new file, but does not open it
; B = Filename string
; AL = Returned status
; Destroys: A, B, Y 
fs_make:
	xfr		b,y
	jsr		fs_res_crc
	ld		bl,4
	jmp		fs_filecom
	
; Deletes an existing file
; B = Filename string
; AL = Returned status
; Destroys: A, B, Y 
fs_delete:
	xfr		b,y
	jsr		fs_res_crc
	ld		bl,5
	jmp		fs_filecom

; Lists a filename and size from the directory
; A = Entry number
; B = Result buffer
; AL = Returned status
; Destroys: A, B, Y
fs_list:
	xfr		b,y
	xfr		al,bh
	jsr		fs_res_crc
	ld		bl,6
	jsr		fs_com_blk
	bm		fs_recv_crc ; Just receive the CRC and be done with it
	ld		bl,16
	xfr		bl,bh
fs_list_l:
	jsr		fs_recv
	st		al,(y+)
	dcr		bh
	bz		fs_recv_crc
	jmp		fs_list_l
	
	
; Reads a block from a file
; A = Block number
; B = Result buffer
; AL = Returned status
; Destroys: A, B, Y
fs_read:
	xfr		b,y
	xfr		al,bh
	jsr		fs_res_crc
	ld		bl,7
	jsr		fs_com_blk
	bm		fs_recv_crc ; Just receive the CRC and be done with it
	clr		bh
fs_read_l:
	jsr		fs_recv
	st		al,(y+)
	inr		bh
	bz		fs_recv_crc
	jmp		fs_read_l
	
; Writes a block to a file
; A = Block number
; B = Source address
; AL = Returned status
; Destroys: A, B, Y
fs_write:
	xfr		b,y
	xfr		al,bh
	jsr		fs_res_crc
	ld		bl,8
	jsr		fs_send ; Command
	xfr		ah,bl
	jsr		fs_send ; Block High
	xfr		bh,bl
	jsr		fs_send ; Block Low
	clr		bh
fs_write_l:
	ld		bl,(y+)
	jsr		fs_send
	inr		bh
	bnz		fs_write_l
	jmp		fs_recv_stat

fs_com_blk:
	jsr		fs_send ; Command
	xfr		ah,bl
	jsr		fs_send ; Block High
	xfr		bh,bl
	jsr		fs_send ; Block Low
	ld		bl,(v_crc)
	jsr		fs_send ; CRC
	jsr		fs_res_crc ; Prepare to receive
	jsr		fs_recv ; Receive status
	xfr		al,ah
	rsr
	

; Sends a command with an empty block field
; BL = Byte to send
; Destroys: AL, BL
fs_com_noblk:
	jsr		fs_send ; Command
	jsr		fs_send ; Block High
	; Block Low (falls through)

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

; Required external functions:
; tty_putc, tty_putb, tty_putw, tty_puts, tty_getc, tty_gets

; Puts a word in hex on the terminal
; B = Word to print
; Destroys: A, B
tty_putw:
	; swap bl and bh
	xfr		bl,ah
	xfr		bh,bl
	xfr		ah,bh
	jsr		tty_putb
	xfr		bh,bl

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
	

; Puts a string on the terminal (zero terminated)
; B = Address of ASCII string
; Destroys: AL, B, Y
tty_puts:
	xfr		b,y ;
tty_puts_l:
	ld		al,(y+)
	bz		tty_puts_ex
	xfr		al,bl
	jsr		tty_putc
	jmp		tty_puts_l
tty_puts_ex:
	rsr

	
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
; Destroys: AL, BL
tty_getc:
	ld		al,(0xF200)
	srr		al
	bnl		tty_getc
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

; Gets a line of characters from the terminal
; AL = Buffer size - 1
; B = Buffer location
; Destroys: A, B, Y
tty_gets:
	; Set up variables (ah = bufsize, bh = bufinx)
	xfr		b,y
	xfr		al,ah
	clr		bh
tty_gets_l:
	jsr		tty_getc
	
	; Check for backspaces
	ld		bl,8
	sub		al,bl
	bz		tty_gets_bs
	ld		bl,127
	sub		al,bl
	bz		tty_gets_bs
	
	; Check for return conditions
	ld		bl,10
	sub		al,bl
	bz		tty_gets_rt
	ld		bl,13
	sub		al,bl
	bz		tty_gets_rt
	
	; Ignore all other lower ASCII codes
	ld		bl,' '
	sub		al,bl
	bm		tty_gets_l
	
	; Add it to the buffer
	xfr		ah,bl
	sub		bh,bl
	bz		tty_gets_l
	inr		bh
	st		al,(y+)
	xfr		al,bl
	jsr		tty_putc
	jmp		tty_gets_l
tty_gets_bs:
	ori		bh,bh
	bz		tty_gets_l
	dcr		y
	dcr		bh
	ld		bl,127
	jsr		tty_putc
	jmp		tty_gets_l
tty_gets_rt:
	clr		al
	st		al,(y)
	rsr
	
; Returns if there is a character to read or not
; AL = Returns 0 if no character
; Destroys: AL
tty_next:
	ld		al,(0xF200)
	srr		al
	bnl		tty_next_n
	ld		al,1
	rsr
tty_next_n:
	clr		al
	rsr
	

; --- CONSTANTS ---

str_hello:
	.byte	0x0A,0x0D
	.ascii "CCDP BOOTSTRAP COMPLETE"
	.byte	0x0A,0x0D,0x00
	
str_start:
	.ascii ": COLD BOOT VECTOR"
	.byte	0x0A,0x0D,0x00
	
str_prompt:
	.ascii ": CONSOLE PROMPT VECTOR"
	.byte	0x0A,0x0D,0x00
	
str_top:
	.ascii ": IMAGE TOP"
	.byte	0x0A,0x0D,0x00
	
str_stack:
	.ascii ": STACK TOP"
	.byte	0x0A,0x0D,0x00
	
str_ready:
	.byte	0x0A,0x0D
	.ascii "READY"
	.byte	0x0A,0x0D
	.ascii "."
	.byte	0x00
	
str_bin:
	.ascii ".BIN"
	.byte	0x00
	
str_nocmd:
	.ascii "NOT FOUND"
	.byte	0x0A,0x0D,0x00
	
; --- VECTOR TABLE ---
vec_tab:
	jmp		con_exec_done	; 0 - SYS_DONE
	jmp		tty_putc		; 1 - TTY_PUTC
	jmp		tty_putb		; 2 - TTY_PUTB
	jmp		tty_putw		; 3 - TTY_PUTW
	jmp		tty_puts		; 4 - TTY_PUTS
	jmp		tty_getc		; 5 - TTY_GETC
	jmp		tty_gets		; 6 - TTY_GETS
	jmp		fs_open			; 7 - FS_OPEN
	jmp		fs_close		; 8 - FS_CLOSE
	jmp		fs_make			; 9 - FS_MAKE
	jmp		fs_delete		; A - FS_DELETE
	jmp		fs_list			; B - FS_LIST
	jmp		fs_read			; C - FS_READ
	jmp		fs_write		; D - FS_WRITE
	jmp		gen_htoi		; E - GEN_HTOI
	jmp		tty_next		; F - TTY_NEXT

; --- TEXT TOP ---
textop:
; Do not program beyond this point
