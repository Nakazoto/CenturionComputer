/*
 *	We are not clear yet how the registers are mapped into the RAM
 *
 *	We know from f1 that
 *
 *	0xA is SP
 *	0xE is PC	(or some kind of syscall vector)
 *	0xC is AX	(otherwise the code wouldn't appear)
 *
 */

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#include "cpu6.h"

static unsigned cpu_ipl = 0;
static uint16_t pc = 0x8001;	/* Hack for now */
static uint8_t op;
static uint8_t alu_out;
static uint8_t switches = 0xF0;

#define BS1	0x80
#define BS2	0x40
#define BS3	0x20
#define BS4	0x10

static uint16_t dma_addr;
static uint16_t dma_count;
static uint8_t dma_mode;
static uint8_t dma_enable;
/*
 *	We don't know of any more direct access to these as a register
 *	by some other means so our order is arbitrary. Given the 4 switches
 *	and the way Bxx is encoded it may be the switches make up a byte
 *	with this somewhere
 */
#define ALU_C	1
#define ALU_N	2
#define ALU_Z	4
#define ALU_I	8

/*
 *	System memory access
 *
 *	For the moment we assume the accesses occur in address order.
 *
 *	For a more serious emulation there are some lurking horrors here.
 *	Not only do we need to know the order of the accesses but we need
 *	to know the logic of the postinc/predec operators and how a fault
 *	is handled half way through an access.
 */

uint16_t mem_read16(uint16_t addr)
{
	uint16_t r = mem_read8(addr) << 8;
	r |= mem_read8(addr + 1);
	return r;
}

void mem_write16(uint16_t addr, uint16_t val)
{
	mem_write8(addr, val >> 8);
	mem_write8(addr + 1, val);
}

/*
 *	We know from the start address that the processor microsteps begin
 *	inc pc
 *	load opcode from (pc)
 *
 *	however it's not clear this is observable or matters for the moment
 *	because the cases that seem to matter like branches appear to do
 *
 *	inc pc
 *	load opcode
 *	inc pc
 *	load offset
 *	add offset
 *
 *	and then the inc of pc before the next instruction works. What
 *	does need a hard look here is the behaviour of RT.
 */
uint8_t fetch(void)
{
	/* Do the pc++ after so that tracing is right */
	uint8_t r = mem_read8(pc);
	pc++;
	return r;
}

uint16_t fetch16(void)
{
	uint16_t r;
	r = mem_read8(pc) << 8;
	pc++;
	r |= mem_read8(pc);
	pc++;
	return r;
}

/* We don't know the true mapping between the registers and the
   memory yet */

static uint8_t reg_read(uint8_t r)
{
	return mem_read8((cpu_ipl << 4) | r);
}

static void reg_write(uint8_t r, uint8_t v)
{
	mem_write8((cpu_ipl << 4) | r, v);
}

static uint16_t regpair_read(uint8_t r)
{
	if (r > 7) {
		fprintf(stderr, "Bad regpair encoding %02X %04X\n", op,
			pc);
		exit(1);
	}
	r <<= 1;
	return (reg_read(r) << 8) | reg_read(r + 1);
}

static void regpair_write(uint8_t r, uint16_t v)
{
	if (r > 7) {
		fprintf(stderr, "Bad regpair encoding %02X %04X\n", op,
			pc);
		exit(1);
	}
	r <<= 1;
	reg_write(r, v >> 8);
	reg_write(r + 1, v);
}

/*
 *	Stack helpers
 *
 *	Diag uses -SP and SP+ for stack operations so assume that this is
 *	the case for internal ones
 */

void push(uint16_t val)
{
	uint16_t addr = regpair_read(SP);
	addr -= 2;
	mem_write16(addr, val);
	regpair_write(SP, addr);
}

uint16_t pop(void)
{
	uint16_t addr = regpair_read(SP);
	uint16_t d = mem_read16(addr);
	regpair_write(SP, addr + 2);
	return d;
}

/*
 *	ALU - logic should be close, but the flags are speculative.
 *
 *	This is implemented using AM2901 ALU slices in the real
 *	hardware. The ALU provides carry in and out but it doesn't
 *	appear the CPU has any 'with carry' instructions beyond internal
 *	carry and carry visibility.
 *
 *	We should however expect that the likely "flags" are going to be
 *	carry, zero, negative and overflow.
 */

static void flags(unsigned r)
{
	alu_out &= ~(ALU_Z | ALU_N);
	if (r == 0)
		alu_out |= ALU_Z;
	if (r & 0x80)
		alu_out |= ALU_N;
}

static void arith_flags(unsigned r)
{
	alu_out &= ~(ALU_C | ALU_N | ALU_Z);
	if (r == 0)
		alu_out |= ALU_Z;
	if (r & 0x100)
		alu_out |= ALU_C;
	if (r & 0x80)
		alu_out |= ALU_N;
}

static void logic_flags(unsigned r)
{
	alu_out &= ~(ALU_C | ALU_N | ALU_Z);
	if (r == 0)
		alu_out |= ALU_Z;
	if (r & 0x80)
		alu_out |= ALU_N;
}

static void shift_flags(unsigned c, unsigned r)
{
	alu_out &= ~(ALU_C | ALU_N | ALU_Z);
	if (r == 0)
		alu_out |= ALU_Z;
	if (c)
		alu_out |= ALU_C;
	if (r & 0x80)
		alu_out |= ALU_N;
}

static void flags16(unsigned r)
{
	alu_out &= ~(ALU_Z|ALU_N);
	if (r == 0)
		alu_out |= ALU_Z;
	/* N maybe ? but not it seems C */
	if (r & 0x8000)
		alu_out |= ALU_N;
}

static void arith_flags16(unsigned r)
{
	alu_out &= ~(ALU_C | ALU_N | ALU_Z);
	if (r == 0)
		alu_out |= ALU_Z;
	if (r & 0x10000)
		alu_out |= ALU_C;
	if (r & 0x8000)
		alu_out |= ALU_N;
}

static void logic_flags16(unsigned r)
{
	alu_out &= ~(ALU_C | ALU_N | ALU_Z);
	if (r == 0)
		alu_out |= ALU_Z;
	if (r & 0x8000)
		alu_out |= ALU_N;
}

static void shift_flags16(unsigned c, unsigned r)
{
	alu_out &= ~(ALU_C | ALU_N | ALU_Z);
	if (r == 0)
		alu_out |= ALU_Z;
	if (c)
		alu_out |= ALU_C;
	if (r & 0x8000)
		alu_out |= ALU_N;
}

static int inc(unsigned reg)
{
	unsigned r = reg_read(reg) + 1;
	reg_write(reg, r);
	flags(r);
	return 0;
}

static int dec(unsigned reg)
{
	unsigned r = reg_read(reg) - 1;
	reg_write(reg, r);
	flags(r);
	return 0;
}

static int clr(unsigned reg)
{
	reg_write(reg, 0);
	flags(0);
	return 0;
}

static int not(unsigned reg)
{
	uint8_t r = ~reg_read(reg);
	reg_write(reg, r);
	flags(r);
	return 0;
}

static int srl(unsigned reg)
{
	uint8_t r = reg_read(reg);
	reg_write(reg, r >> 1);
	shift_flags(r & 1, r >> 1);
	return 0;
}

static int sll(unsigned reg)
{
	uint8_t r = reg_read(reg);
	reg_write(reg, r << 1);
	shift_flags((r & 0x80), r << 1);
	return 0;
}

static int rrc(unsigned reg)
{
	uint8_t r = reg_read(reg);
	uint8_t c = r & 1;

	r >>= 1;
	r |= (alu_out & ALU_C) ? 0x80 : 0;

	reg_write(reg, r);
	shift_flags(c, r);
	return 0;
}

static int rlc(unsigned reg)
{
	uint8_t r = reg_read(reg);
	uint8_t c = r & 0x80;

	r <<= 1;
	r |= (alu_out & ALU_C) ? 1 : 0;

	reg_write(reg, r);
	shift_flags(c, r);
	return 0;
}

static int add(unsigned dst, unsigned src)
{
	uint16_t r = reg_read(dst) + reg_read(src);
	reg_write(dst, r);
	arith_flags(r);
	return 0;
}

static int sub(unsigned dst, unsigned src)
{
	uint16_t r = reg_read(dst) - reg_read(src);
	reg_write(dst, r);
	arith_flags(r);
	return 0;
}

static int and(unsigned dst, unsigned src)
{
	uint8_t r = reg_read(dst) & reg_read(src);
	reg_write(dst, r);
	logic_flags(r);
	return 0;
}

static int or(unsigned dst, unsigned src)
{
	uint8_t r = reg_read(dst) | reg_read(src);
	reg_write(dst, r);
	logic_flags(r);
	return 0;
}

static int xor(unsigned dst, unsigned src)
{
	uint8_t r = reg_read(dst) ^ reg_read(src);
	reg_write(dst, r);
	logic_flags(r);
	return 0;
}

static int mov(unsigned dst, unsigned src)
{
	uint8_t r = reg_read(src);
	reg_write(dst, r);
	flags(r);
	return 0;
}


/* 16bit versions */

static int inc16(unsigned reg)
{
	unsigned r = regpair_read(reg) + 1;
	regpair_write(reg, r);
	flags16(r);
	return 0;
}

static int dec16(unsigned reg)
{
	unsigned r = regpair_read(reg) - 1;
	regpair_write(reg, r);
	flags16(r);
	return 0;
}

static int clr16(unsigned reg)
{
	regpair_write(reg, 0);
	flags16(0);
	return 0;
}

static int not16(unsigned reg)
{
	uint16_t r = ~regpair_read(reg);
	regpair_write(reg, r);
	flags16(r);
	return 0;
}

static int srl16(unsigned reg)
{
	uint16_t r = regpair_read(reg);
	regpair_write(reg, r >> 1);
	shift_flags16(r & 1, r >> 1);
	return 0;
}

static int sll16(unsigned reg)
{
	uint16_t r = regpair_read(reg);
	regpair_write(reg, r << 1);
	shift_flags16((r & 0x8000), r << 1);
	return 0;
}

static int rrc16(unsigned reg)
{
	uint16_t r = regpair_read(reg);
	uint16_t c = r & 1;

	r >>= 1;
	r |= (alu_out & ALU_C) ? 0x8000 : 0;

	regpair_write(reg, r);
	shift_flags16(c, r);
	return 0;
}

static int rlc16(unsigned reg)
{
	uint16_t r = regpair_read(reg);
	uint16_t c = r & 0x8000;

	r <<= 1;
	r |= (alu_out & ALU_C) ? 1 : 0;

	regpair_write(reg, r);
	shift_flags16(c, r);
	return 0;
}

static int add16(unsigned dst, unsigned src)
{
	unsigned r = regpair_read(dst) + regpair_read(src);
	regpair_write(dst, r);
	arith_flags16(r);
	return 0;
}

static int sub16(unsigned dst, unsigned src)
{
	unsigned r = regpair_read(dst) - regpair_read(src);
	regpair_write(dst, r);
	arith_flags16(r);
	return 0;
}

static int and16(unsigned dst, unsigned src)
{
	uint16_t r = regpair_read(dst) & regpair_read(src);
	regpair_write(dst, r);
	logic_flags16(r);
	return 0;
}

static int or16(unsigned dst, unsigned src)
{
	uint16_t r = regpair_read(dst) | regpair_read(src);
	regpair_write(dst, r);
	logic_flags16(r);
	return 0;
}

static int xor16(unsigned dst, unsigned src)
{
	uint16_t r = regpair_read(dst) ^ regpair_read(src);
	regpair_write(dst, r);
	logic_flags16(r);
	return 0;
}

static int mov16(unsigned dst, unsigned src)
{
	uint16_t r = regpair_read(src);
	regpair_write(dst, r);
	flags(r);
	return 0;
}

/*
 *	Address generator (with side effects). We don't know when the
 *	pre-dec/post-inc hits the register
 */

static uint16_t indexed_address(unsigned size)
{
	uint8_t idx = fetch();
	unsigned r = idx >> 5;		/* No idea what happens if low bit set */
	unsigned addr;
	uint8_t offset = 0;		/* Signed or not ? */

	if (idx & 0x10)
		fprintf(stderr, "indexed address with reg low bit %02X at %04X\n", idx, pc);
	if (idx & 0x08)
		offset = fetch();
	switch(idx & 0x07)
	{
		case 0:
			return regpair_read(r) + offset;
		case 1:
			addr = regpair_read(r);
			regpair_write(r, addr + size);
			return addr + offset;
		case 2:
			addr = regpair_read(r);
			addr -= size;
			regpair_write(r, addr);
			return addr + offset;
		default:
			fprintf(stderr, "Unknown indexing mode %02X at %04X\n", idx, pc);
			exit(1);
	}
}

static uint16_t decode_address(unsigned size, unsigned mode)
{
	uint16_t addr;
	uint16_t indir = 0;

	switch(mode) {
	case 0:
		addr = pc;
		pc += size;
		indir = 0;
		break;
	case 1:
		addr = pc;
		pc += 2;
		indir = 1;
		break;
	case 2:
		addr = pc;
		pc += 2;
		indir = 2;
		break;
	case 3:
		addr = pc + fetch();	/* signed ? */
		indir = 1;
		break;
	case 4:
		addr = pc + fetch();
		indir = 2;
		break;
	case 5:
		/* Indexed modes */
		addr = indexed_address(size);
		indir = 0;
		break;
	case 6:
	case 7:
		fprintf(stderr, "unknown address indexing %X at %04X\n", mode, pc);
		break;
	default:
		/* indexed off a register */
		addr = regpair_read(mode & 7);
		indir = 0;
		break;
	}
	while(indir--)
		addr = mem_read16(addr);
	return addr;
}

static int branch_op(void)
{
	unsigned t;
	int8_t off;

	switch (op & 0x0F) {
	case 0:	/* bcs */
		t = (alu_out & ALU_C);
		break;
	case 1:	/* bcc */
		t = !(alu_out & ALU_C);
		break;
	/* Question: is this a sign or arithmetic overflow in fact - ie is
	   it an N or V ? */
	case 2:	/* bns */
		t = (alu_out & ALU_N);
		break;
	case 3:	/* bnc */
		t = !(alu_out & ALU_N);
		break;
	case 4:	/* bz	- known right */
		t = (alu_out & ALU_Z);
		break;
	case 5:	/* bnz - known right */
		t = !(alu_out & ALU_Z);
		break;
	case 6:	/* maybe blt - see 8048, 856D */
		t = !(alu_out & (ALU_C|ALU_Z));
		break;
	case 7:	/* bge ? 8572 */
		t = alu_out & ALU_C;
		break;
	case 8: /* bgt bge ? neg or zero  875x implies that 19xx is <= 0 and
		   18xx is a signed comparison of some form */
		t = (alu_out & (ALU_Z|ALU_N));
		break;
	case 9: /* used at 8751 seems to check Z . .speculating on N */
		t = (alu_out & (ALU_Z|ALU_N));
		break;
		/* Switches */
	case 10:
		t = (switches & BS1);
		break;
	case 11:
		t = (switches & BS2);
		break;
	case 12:
		t = (switches & BS3);
		break;
	case 13:
		t = (switches & BS4);
		break;
	case 14:
	case 15:
		fprintf(stderr, "Unknown branch %02X at %04X\n", op, pc);
		t = 0;
		break;
	}
	/* We'll keep pc and reg separate until we know if/how it fits memory */
	off = fetch();
	/* Offset is applied after fetch leaves PC at next instruction */
	if (t)
		pc += off;
	return 0;
}

/* Low operations - not all known */
static int low_op(void)
{
	switch (op) {
	case 0x00:		/* HALT */
		halt_system();
		break;
	case 0x01:		/* NOP */
		break;
	case 0x02:		/* FSN */
		alu_out |= ALU_N;
		break;
	case 0x03:		/* FCN */
		alu_out &= ~ALU_N;
		break;
	case 0x04:		/* FSI *//* Interrupt flag */
		alu_out |= ALU_I;
		break;
	case 0x05:		/* FCI */
		alu_out &= ~ALU_I;
		break;
	case 0x06:		/* FSC */
		alu_out |= ALU_C;
		break;
	case 0x07:		/* FCC */
		alu_out &= ~ALU_C;
		break;
	case 0x08:		/* FCA */
		alu_out &= ~(ALU_C | ALU_Z | ALU_N);
		break;
	case 0x09:		/* RET */
		/* RET - see notes on call */
		pc = regpair_read(RT);
		regpair_write(RT, pop());
		break;
	case 0x0A:		/* RETI - no idea */
		break;
	case 0x0E:		/* DELAY */
		break;
	case 0x0B:
	case 0x0C:
	case 0x0D:
	case 0x0F:
		fprintf(stderr, "Unknown op %02X at %04X\n", op, pc);
	}
	return 0;
}

/* We only know some of this - it would be logical to expect DMA disable in here */
static int dma_op(void)
{
	unsigned rp;
	/* operations 2Fxx */
	op = fetch();
	rp = (op >> 4);

	switch (op & 0x0F) {
	case 0:
		dma_addr = regpair_read(rp);
		break;
	case 1:
		regpair_write(rp, dma_addr);
		break;
	case 2:
		dma_count = regpair_read(rp);
		break;
	case 3:
		regpair_write(rp, dma_count);
		break;
	case 4:
		dma_mode = rp;
		break;
	case 6:
		dma_enable = 1;
		break;
	default:
		fprintf(stderr, "Unknown DMA operations 2F%02X at %04X\n",
			op, pc);
		break;
	}
	return 0;
}

static int move_op(void)
{
	op = fetch();
	if (op & 0x11) {
		fprintf(stderr, "Unknown reg encoding %02X for 16bit move at %04X\n",
			op, pc);
		exit(1);
	}
	mov16(op >> 5, (op & 0x0F) >> 1);
	return 0;
}

static int jump_op(void)
{
	uint16_t new_pc;
	if (op == 0x76) {	/* syscall is a mystery */
		cpu_ipl = 15;
		return 0;
	}
	switch (op & 7) {
	case 1:		/* Immediate */
		new_pc = fetch16();
		break;
	case 2:		/* Apparently indirected which isn't what would be expected */
		new_pc = mem_read16(fetch16());
		break;
	case 3:
		new_pc = (int8_t) fetch() + pc;	/* TODO: signed or unsigned */
		break;
	case 5:
		new_pc = fetch() + regpair_read(AX);	/* Again signed ? */
		break;
	default:
		fprintf(stderr, "Invalid jump/call 0x%02X at 0x%04X\n", op,
			pc);
		return 0;
	}
	if (op & 0x08) {
		/* guesswork time. 8500 implies it is not a simple branch and link */
		/* the use of rt+ implies it's also not pc stacking, so try rt stacking */
		push(regpair_read(RT));
		regpair_write(RT, pc);
	}
	pc = new_pc;
	return 0;
}

static int rt_op(void)
{
	uint16_t addr = decode_address(2, op & 7);
	uint16_t r;
	if (op & 0x08) {
		r = regpair_read(RT);
		mem_write16(addr, r);
		flags16(r);
	} else {
		r = mem_read16(addr);
		regpair_write(RT, r);
		flags16(r);
	}
	return 0;
}

static int loadbyte_op(void)
{
	uint16_t addr = decode_address(1, op & 0x0F);
	uint8_t r = mem_read8(addr);

	if (op & 0x40)
		reg_write(BL, r);
	else
		reg_write(AL, r);
	flags(r);
	return 0;
}

static int loadword_op(void)
{
	uint16_t addr = decode_address(2, op & 0x0F);
	uint16_t r = mem_read16(addr);

	if (op & 0x40)
		regpair_write(BX, r);
	else
		regpair_write(AX, r);
	flags16(r);
	return 0;
}

static int storebyte_op(void)
{
	uint16_t addr = decode_address(1, op & 0x0F);
	uint8_t r;

	if (op & 0x40)
		r = reg_read(BL);
	else
		r = reg_read(AL);

	mem_write8(addr, r);

	return 0;
}

static int storeword_op(void)
{
	uint16_t addr = decode_address(2, op & 0x0F);
	uint16_t r;

	if (op & 0x40)
		r = regpair_read(BL);
	else
		r = regpair_read(AL);

	mem_write16(addr, r);

	return 0;
}

/*
 *	This block of instructions does not seem to affect flags.
 *	See for example diag 8045/8048 but also 862a where Z is clearly
 *	changed.
 *
 *	Working theory Z only. Possible other option - it matters if A or B
 */
static int loadstore_op(void)
{
	switch (op & 0x30) {
	case 0x00:
		return loadbyte_op();
	case 0x10:
		return loadword_op();
	case 0x20:
		return storebyte_op();
	case 0x30:
		return storeword_op();
	default:
		fprintf(stderr, "internal error loadstore\n");
		exit(1);
	}
}

static int misc2x_special(uint8_t reg)
{
	/* The only code we know is 22 32 which seems ot be some kind of cpu
	   ident/status check */
	if (op == 0x22 && reg == 0x32) {
		/* CPU ID ?? */
		alu_out |= ALU_Z;
		return 0;
	}
	fprintf(stderr, "Unknown misc2x special %02X:%02X at %04X\n", op,
		reg, pc - 1);
	return 0;
}

static int misc2x_op(void)
{
	unsigned reg = AL;
	if (!(op & 8)) {
		reg = fetch();
		if (reg & 0x0F)
			return misc2x_special(reg);
		reg >>= 4;
	}

	switch (op) {
	case 0x20:
		return inc(reg);
	case 0x21:
		return dec(reg);
	case 0x22:
		return clr(reg);
	case 0x23:
		return not(reg);
	case 0x24:
		return srl(reg);
	case 0x25:
		return sll(reg);
	case 0x26:
		/* Logically this would be rrc reg, but we see use
		   of 26 00 in 8520-8531 that makes no sense if it is */
		return rrc(reg);
	case 0x27:
		return rlc(reg);
	case 0x28:
		return inc(AL);
	case 0x29:
		return dec(AL);
	case 0x2A:
		return clr(AL);
	case 0x2B:
		return not(AL);
	case 0x2C:
		return srl(AL);
	case 0x2D:
		return sll(AL);
	case 0x2E:
		return move_op();
	case 0x2F:
		return dma_op();
	default:
		fprintf(stderr, "internal error misc2\n");
		exit(1);
	}
}

/* Like misc2x but word */
static int misc3x_op(void)
{
	unsigned reg = AX;
	if (!(op & 8)) {
		reg = fetch();
		if (reg & 0x0F)
			return misc2x_special(reg);
		reg >>= 4;
		if (reg & 1) {
			fprintf(stderr, "Unknown misc3x reg encoding %02X at %04X\n", reg, pc);
			exit(1);
		}
		reg >>= 1;
	}

	switch (op) {
	case 0x30:
		return inc16(reg);
	case 0x31:
		return dec16(reg);
	case 0x32:
		return clr16(reg);
	case 0x33:
		return not16(reg);
	case 0x34:
		return srl16(reg);
	case 0x35:
		return sll16(reg);
	case 0x36:
		return rrc16(reg);
	case 0x37:
		return rlc16(reg);
	case 0x38:
		return inc16(AX);
	case 0x39:
		return dec16(AX);
	case 0x3A:
		return clr16(AX);
	case 0x3B:
		return not16(AX);
	case 0x3C:
		return srl16(AX);
	case 0x3D:
		return sll16(AX);
	case 0x3E:		/* To check */
		return inc16(RT);
	case 0x3F:
		return dec16(RT);
	default:
		fprintf(stderr, "internal error misc3\n");
		exit(1);
	}
}

/* Mostly ALU operations on AL */
static int alu4x_op(void)
{
	unsigned src, dst;
	if (!(op & 0x08)) {
		dst = fetch();
		src = dst >> 4;
		dst &= 0x0F;
	}
	switch (op) {
	case 0x40:		/* add */
		return add(dst, src);
	case 0x41:		/* sub */
		return sub(dst, src);
	case 0x42:		/* and */
		return and(dst, src);
	case 0x43:		/* or */
		return or(dst, src);
	case 0x44:		/* xor */
		return xor(dst, src);
	case 0x45:		/* mov */
		return mov(dst, src);
	case 0x46:		/* unused */
	case 0x47:		/* unused */
		fprintf(stderr, "Unknown ALU4 op %02X at %04X\n", op,
			pc - 1);
		return 0;
	case 0x48:
		return add(BL, AL);
	case 0x49:
		return sub(BL, AL);
	case 0x4A:
		return and(BL, AL);
	case 0x4B:
		return or(BL, AL);
	case 0x4C:
		return xor(BL, AL);
	case 0x4D:
		return mov(BL, AL);
	case 0x4E:		/* unused */
	case 0x4F:		/* unused */
		fprintf(stderr, "Unknown ALU4 op %02X at %04X\n", op, pc);
		return 0;
	default:
		fprintf(stderr, "internal error alu4\n");
		exit(1);
	}
}

/* Much like ALU4x but word */
static int alu5x_op(void)
{
	unsigned src, dst;
	if (!(op & 0x08)) {
		dst = fetch();
		if (dst & 0x11) {
			fprintf(stderr, "ALU5 - unknown reg encoding %02X at %04X\n",
				dst, pc - 1);
			exit(1);
		}
		src = dst >> 4;
		dst &= 0x0F;
		src >>= 1;
		dst >>= 1;
	}
	switch (op) {
	case 0x50:		/* add */
		return add16(dst, src);
	case 0x51:		/* sub */
		return sub16(dst, src);
	case 0x52:		/* and */
		return and16(dst, src);
	case 0x53:		/* or */
		return or16(dst, src);
	case 0x54:		/* xor */
		return xor16(dst, src);
	case 0x55:		/* mov */
		return mov16(dst, src);
	case 0x56:		/* unused */
	case 0x57:		/* unused */
		fprintf(stderr, "Unknown ALU5 op %02X at %04X\n", op,
			pc - 1);
		return 0;
	case 0x58:
		return add16(BX, AX);
	case 0x59:
		return sub16(BX, AX);
	case 0x5A:
		return and16(BX, AX);
	case 0x5B:
		return or16(BX, AX);
	case 0x5C:
		return xor16(BX, AX);
	case 0x5D:
		return mov16(BX, AX);
	case 0x5E:		/* unused */
		fprintf(stderr, "Unknown ALU5 op %02X at %04X\n", op, pc);
		return 0;
	case 0x5F:		/* unused */
		mov16(SP, AX);
		return 0;
	default:
		fprintf(stderr, "internal error alu5\n");
		exit(1);
	}
}

static char *flagcode(void)
{
	static char buf[5];
	strcpy(buf, "----");
	if (alu_out & ALU_C)
		*buf = 'C';
	if (alu_out & ALU_I)
		buf[1] = 'I';
	if (alu_out & ALU_N)
		buf[2] = 'N';
	if (alu_out & ALU_Z)
		buf[3] = 'Z';
	return buf;
}

unsigned cpu6_execute_one(void)
{
	fprintf(stderr, "CPU %04X: ", pc);
	op = fetch();
	fprintf(stderr, "%02X %s AX:%04X  BX:%04X RT:%04X DX:%04X\n",
		op, flagcode(), regpair_read(AX), regpair_read(BX),
		regpair_read(RT), regpair_read(DX));
	if (op < 0x10)
		return low_op();
	if (op < 0x20)
		return branch_op();
	/* 20-5F is sort of ALU stuff but other things seem to have been shoved
	   into the same space */
	if (op < 0x30)
		return misc2x_op();
	if (op < 0x40)
		return misc3x_op();
	if (op < 0x50)
		return alu4x_op();
	if (op < 0x60)
		return alu5x_op();
	if (op < 0x70)
		return rt_op();
	if (op < 0x80)
		return jump_op();
	return loadstore_op();
}

uint16_t cpu6_pc(void)
{
	return pc;
}
