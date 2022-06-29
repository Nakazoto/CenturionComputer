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
options:
	ld		b,str_opt
	jsr		tty_puts
	ld		al,1
	ld		b,sel_buffer
	jsr		tty_gets
	ld		al,(sel_buffer)

	ld		bl,'0'
	sub		al,bl
	bz		init
	
	ld		bl,'1'
	sub		al,bl
	bz		seek
	
	ld		bl,'2'
	sub		al,bl
	bz		read
	
	ld		bl,'3'
	sub		al,bl
	bz		exit
	
	
	jmp		options
	
; Exit the program
exit:
	rsr
	
; Init test
init:
	ld		b,str_crlf
	jsr		tty_puts
	ld		a,0xFFF9
	ld		b,cmd_seek_a
	jsr		set_ac
	jsr		exec_start
	jsr		exec_end
	ld		b,str_cmdfinish
	jsr		tty_puts
	jmp		options
	
	
; Seek test
seek:
	jsr		seltrack
	ld		a,(track)
	st		a,(cmd_seek_b_track)
	ld		a,0xFFF7
	ld		b,cmd_seek_b
	jsr		set_ac
	jsr		exec_start
	jsr		exec_end
	ld		b,str_cmdfinish
	jsr		tty_puts
	jmp		options
	
; Read test
read:
	jsr		seltrack
	ld		a,(track)
	st		a,(cmd_read_track)
	ld		b,str_short
	jsr		tty_puts
	ld		al,1
	ld		b,sel_buffer
	jsr		tty_gets
	ld		al,(sel_buffer)
	ld		bl,'Y'
	sub		al,bl
	bz		read_short
	ld		a,0xFFC3
	jmp		read_cmd
read_short:
	ld		a,0xFFC6
read_cmd:
	ld		b,cmd_read
	jsr		set_ac
	ld		b,str_crlf
	jsr		tty_puts
	jsr		exec_start
	ld		a,0xE6FF
	ld		b,heap
	jsr		exec_end_dma
	ld		b,str_cmdfinish
	jsr		tty_puts
	jsr		heapdump
	jmp		options

; Dumps the heap into a file	
heapdump:
	ld		b,str_output
	jsr		fs_make
	ld		b,str_output
	jsr		fs_open
	ori		al,al
	bp		heapdump_w
	ld		b,str_filerr
	jmp		tty_puts
heapdump_w:
	ld		b,heap
	xfr		b,z
	clr		a
heapdump_l:
	st		a,(-s)
	xfr		z,b
	jsr		fs_write
	ld		a,(s+)
	ld		b,256
	add		b,z
	inr		al
	ld		bl,25
	sub		al,bl
	bnz		heapdump_l
	jmp		fs_close

	

; Select a track
seltrack:
	ld		b,str_track
	jsr		tty_puts
	ld		b,hex_buffer
	ld		al,4
	jsr		tty_gets		
	ld		b,(hex_buffer)
	jsr		gen_htoi
	st		al,(-s)
	ld		b,(hex_buffer+2)
	jsr		gen_htoi
	ld		bl,(s+)
	xfr		bl,ah
	ori		a,a
	bm		seltrack_e
	ld		b,0x025D
	sub		a,b
	bp		seltrack_e
	st		a,(track)
	ld		b,str_showtrack
	jsr		tty_puts
	ld		b,(track)
	jsr		tty_putw
	ld		b,str_crlf
	jmp		tty_puts
seltrack_e:
	ld		b,str_trackerr
	jsr		tty_puts
	jmp		seltrack

	
; Sets DMA Addr/Cnt
; A = Count
; B = Address
set_ac:
	.byte	0x2F,0x02 ; dma_load_count A
	xfr		b,a
	.byte	0x2F,0x00 ; dma_load_addr B
	rsr
	
	
; Starts a command
exec_start:
	ld		b,str_cmdstart
	jsr		tty_puts
	.byte	0x2F,0x34 ; dma_set_mode 3
	.byte	0x2F,0x06 ; dma_enable
	ld		al,0x43
	st		al,(0xF800)
	jmp		wait_done
	
exec_end_dma:
	ld		b,str_cmdend
	jsr		tty_puts
	.byte	0x2F,0x34 ; dma_set_mode 3
	.byte	0x2F,0x06 ; dma_enable
	ld		al,0x45
	st		al,(0xF800)
	jmp		wait_done
	
; Ends a command
exec_end:
	ld		b,str_cmdend
	jsr		tty_puts
	ld		al,0x45
	st		al,(0xF800)
	
; Waits for a command to complete
wait_done:
	jsr		wait_done_fin
	st		x,(-s)
	ld		x,0x03E8
wait_done_l:
	ld		al,(0xF801)
	ld		bl,0x08
	and		al,bl
	bz		wait_done_f
	dly
	dcr		x
	bnz		wait_done_l
	ld		b,str_busyerr
	jsr		tty_puts
	ld		x,(s+)
	rsr
wait_done_f:
	ld		x,0x03E8
wait_done_fl:
	srr		al
	bl		wait_done_r
	dly
	dcr		x
	bnz		wait_done_fl
	ld		b,str_fouterr
	jsr		tty_puts
	ld		x,(s+)
	rsr
wait_done_r:
	rf
	ld		al,(0xF800)
	bnz		wait_done_err
	ld		x,(s+)
	rsr
wait_done_err:
	st		al,(-s)
	ld		b,str_err
	jsr		tty_puts
	ld		bl,(s+)
	jsr		tty_putb
	ld		x,(s+)
	sf
	rsr
	
wait_done_fin:
	st		x,(-s)
	dly
	ld		x,0x03E8
wait_done_fin_l:
	ld		al,(0xF801)
	srr		al
	srr		al
	bnl		wait_done_fin_e
	dly
	dcr		x
	bnz		wait_done_fin_l
	ld		b,str_finerr
	jsr		tty_puts
	ld		x,(s+)
	rsr
wait_done_fin_e:
	ld		x,(s+)
	rsr

; --- STRINGS ---
str_hello:
	.ascii "FFC MONITOR/DIAGNOSTIC UTILITY V0.1.1"
str_crlf:
	.byte	0x0D,0x0A,0x00

str_opt:
	.ascii "SELECT AN OPTION:"
	.byte	0x0D,0x0A
	.ascii	" 0: INIT FINCH DRIVE"
	.byte	0x0D,0x0A
	.ascii	" 1: SEEK FINCH DRIVE"
	.byte	0x0D,0x0A
	.ascii	" 2: READ FINCH DRIVE (16x400)"
	.byte	0x0D,0x0A
	.ascii	" 3: EXIT"
	.byte	0x0D,0x0A
	.ascii	">"
	.byte	0x00
	
str_track:
	.byte	0x0D,0x0A
	.ascii	"TRACK # (XXXX)? "
	.byte	0x00
	
str_short:
	.ascii	"SHORTEN CMD PACKET (Y/N)? "
	.byte	0x00
	
str_showtrack:
	.byte	0x0D,0x0A
	.ascii	"SELECTED TRACK "
	.byte	0x00
	
str_trackerr:
	.byte	0x0D,0x0A
	.ascii	"INVALID TRACK"
	.byte	0x0D,0x0A,0x00
	
str_cmdstart:
	.ascii	"STARTING COMMAND..."
	.byte	0x0D,0x0A,0x00
	
str_cmdend:
	.ascii	"ENDING COMMAND..."
	.byte	0x0D,0x0A,0x00
	
str_cmdfinish:
	.ascii	"COMMAND COMPLETE"
	.byte	0x0D,0x0A,0x00
	
str_finerr:
	.ascii	"FIN DID NOT GO OFF"
	.byte	0x0D,0x0A,0x00
	
str_busyerr:
	.ascii	"BUSY DID NOT CLEAR"
	.byte	0x0D,0x0A,0x00
	
str_fouterr:
	.ascii	"FOUT NEVER CAME ON"
	.byte	0x0D,0x0A,0x00
	
str_err:
	.ascii	"ERROR #"
	.byte	0x00

str_filerr:
	.ascii "CANNOT OPEN FILE"
	.byte	0x0D,0x0A,0x00

str_output:
	.ascii	"FFCDEBUG.DAT"
	.byte	0x00

; --- COMMANDS ---

cmd_seek_a:
	.byte	0x81,0x02,0x84,0x00,0x82,0xFF
	
cmd_seek_b:
	.byte	0x81,0x02,0x84,0x00,0x83
cmd_seek_b_track:
	.byte	0x00,0x00
	.byte 	0xFF
	
cmd_read:
	.byte	0x81,0x02,0x84,0x00,0x83
cmd_read_track:
	.byte	0x00,0x00
	.byte	0x8A
	.byte	0x00,0x01,0x90
	.byte	0x01,0x01,0x90
	.byte	0x02,0x01,0x90
	.byte	0x03,0x01,0x90
	.byte	0x04,0x01,0x90
	.byte	0x05,0x01,0x90
	.byte	0x06,0x01,0x90
	.byte	0x07,0x01,0x90
	.byte	0x08,0x01,0x90
	.byte	0x09,0x01,0x90
	.byte	0x0A,0x01,0x90
	.byte	0x0B,0x01,0x90
	.byte	0x0C,0x01,0x90
	.byte	0x0D,0x01,0x90
	.byte	0x0E,0x01,0x90
	.byte	0x0F,0x01,0x90
	.byte	0xFF 
	.byte	0x00,0x00,0x00
	

; --- VARIABLES ---

sel_buffer:
	.byte	0x00,0x00
	
hex_buffer:
	.byte	0x00,0x00,0x00,0x00,0x00
	
track:
	.byte	0x00,0x00
	
heap:
	.byte	0x00
	

