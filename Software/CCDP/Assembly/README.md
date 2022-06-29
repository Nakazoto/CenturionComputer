# CCDP User Application Interface

When running a user .BIN program, CCDP simply copies the contents of the file directly into 0x0200 of memory. There is no stat or relocation anywhere in the binaries, so one can expect anything in that file to show up directly into memory. Check out build.sh to see in detail how binaries are built.

CCDP gives user programs a small set of system calls to reduce the compexity of doing common tasks. In order to interface with these functions, the following should be included in the assembly source:

```

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
```

In total, there are currently 14 different functions that can be accessed. There is also the `combuf` symbol, which points to the command buffer. When a user program is invoked, the command used to invoke that program will be found in the command buffer. This will include arguments sent to the program, but they will need to be manually parsed first.

Do not modify values from 0x100 - 0x1FF, they may be used in future versions oF CCDP by the kernel.

For filesystem operations, refer to SerialDir.txt in the SerialDir directory for return code meanings.

Here are the descriptions for the different functions:

## SYS_DONE

Returns to the CCDP command prompt

Destroys: All

## TTY_PUTC

Puts a character on the terminal

BL = ASCII to print

Destroys: AL, BL

## TTY_PUTB

Puts a byte in hex on the terminal

BL = Byte to print

Destroys: A, BL

## TTY_PUTW

Puts a word in hex on the terminal

B = Word to print

Destroys: A, B

## TTY_PUTS

Puts a string on the terminal (zero terminated)

B = Address of ASCII string

Destroys: AL, B, Y

## TTY_GETC

Gets a character from the terminal

AL = Returned ASCII character

Destroys: AL, BL

## TTY_GETS

Gets a line of characters from the terminal

AL = Buffer size - 1 (max number of characters)

B = Buffer location

Destroys: A, B, Y

## TTY_NEXT

Returns if there is a character to read or not

AL = Returns 0 if no character

Destroys: AL

## FS_OPEN

Opens up a file for use, any currently opened file is closed

B = Filename string

AL = Returned status

Destroys: A, B, Y 

## FS_CLOSE 

Closes the currently open file

AL = Returned status

Destroys; A, B

## FS_MAKE

Makes a new file, but does not open it

B = Filename string

AL = Returned status

Destroys: A, B, Y 

## FS_DELETE

Deletes an existing file

B = Filename string

AL = Returned status

Destroys: A, B, Y 

## FS_LIST

Lists a filename and size from the directory

A = Entry number

B = Result buffer

AL = Returned status

Destroys: A, B, Y

## FS_READ

Reads a block from a file

A = Block number

B = Result buffer

AL = Returned status

Destroys: A, B, Y

## FS_WRITE

Writes a block to a file

A = Block number

B = Source address

AL = Returned status

Destroys: A, B, Y

## GEN_HTOI

Converts a hex number in ASCII into a value

AL = Returned value

B = Hex value

Destroys: A, B
