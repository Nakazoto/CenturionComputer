/*
 *	A very minimal centurion system for testing
 */

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <signal.h>
#include <termios.h>
#include <sys/select.h>

#include "cpu6.h"

volatile unsigned int emulator_done;

#define TRACE_MEM	1
#define TRACE_MEM_REG	2
unsigned int trace = 0;

unsigned int switches;

/* Utility functions for the mux */
static unsigned int check_chario(void)
{
	fd_set i, o;
	struct timeval tv;
	unsigned int r = 0;

	FD_ZERO(&i);
	FD_SET(0, &i);
	FD_ZERO(&o);
	FD_SET(1, &o);
	tv.tv_sec = 0;
	tv.tv_usec = 0;

	if (select(2, &i, NULL, NULL, &tv) == -1) {
		if (errno == EINTR)
			return 0;
		perror("select");
		exit(1);
	}
	if (FD_ISSET(0, &i))
		r |= 1;
	if (FD_ISSET(1, &o))
		r |= 2;
	return r;
}

static unsigned int next_char(void)
{
	char c;
	if (read(0, &c, 1) != 1) {
		fprintf(stderr, "(tty read without ready byte)\n");
		return 0xFF;
	}
	if (c == 0x0A)
		c = '\r';
	fprintf(stderr, "[read]%02X\n", c);
	return c;
}

static uint8_t mem[65536];

static uint8_t hexdigits;
static unsigned hexblank;
static unsigned hexdots[4];

static void hexdisplay(uint16_t addr, uint8_t val)
{
	const char *hexstr = "0123456789ABCDEF";
	uint8_t onoff = addr & 1;
	if (addr == 0xF110)
		hexdigits = val;
	else if (addr >= 0xF108) {
		addr -= 0xF108;
		addr >>= 1;
		hexdots[addr] = onoff;
	} else {
		hexblank = onoff;
	}
	if (hexblank) {
		printf("[OFF]\n");
		return;
	}
	printf("[");
	if (hexdots[0])
		printf("*");
	else
		printf(".");
	printf("%c", hexstr[hexdigits >> 4]);
	if (hexdots[1])
		printf("*");
	else
		printf(".");
	if (hexdots[2])
		printf("*");
	else
		printf(".");
	printf("%c", hexstr[hexdigits & 0x0F]);
	if (hexdots[3])
		printf("*");
	else
		printf(".");
	printf("]\n");
	fflush(stdout);
}

/* Bit 0 of control is char pending. The real system uses mark parity so
   we erm ignore that */
static void mux_write(uint16_t addr, uint8_t val)
{
	unsigned mux, data;
	addr &= 0xFF;
	mux = addr >> 1;
	data = addr & 1;

	if (mux == 0 && data) {
		val &= 0x7F;
		if (val != 0x0A && val != 0x0D && (val < 0x20 || val == 0x7F))
			printf("[%02X]", val);
		else
			putchar(val);
		fflush(stdout);
	}
}

static uint8_t mux_read(uint16_t addr)
{
	unsigned mux, data;
	unsigned ttystate;
	uint8_t ctrl = 0;

	addr &= 0xFF;
	mux = addr >> 1;
	data = addr & 1;

	if (mux != 0)
		return 0;

	if (data == 1)
		return next_char();
	ttystate = check_chario();
	if (ttystate & 1)
		ctrl |= 1;
	if (ttystate & 2)
		ctrl |= 2;
	return ctrl;
}

static uint8_t io_read8(uint16_t addr)
{
	if (addr == 0xF110)
		return switches;
	if (addr >= 0xF200 && addr <= 0xF21F)
		return mux_read(addr);
	return 0;
}

static void io_write8(uint16_t addr, uint8_t val)
{
	if (addr >= 0xF106 && addr <= 0xF110) {
		hexdisplay(addr, val);
		return;
	}
	if (addr >= 0xF200 && addr <= 0xF21F) {
		mux_write(addr, val);
		return;
	}
}

static uint8_t do_mem_read8(uint16_t addr, int dis)
{
	if (addr >= 0xF000) {
		if (dis)
			return 0xFF;
		else
			return io_read8(addr);
	} else
		return mem[addr];
}

uint8_t mem_read8(uint16_t addr)
{
	uint8_t r = do_mem_read8(addr, 0);
	if (trace & TRACE_MEM)
		if (addr > 0xFF || (trace & TRACE_MEM_REG))
			fprintf(stderr, "%04X: %04X R %02X\n", cpu6_pc(),
				addr, r);
	return r;
}

void mem_write8(uint16_t addr, uint8_t val)
{
	if (trace & TRACE_MEM)
		if (addr > 0xFF || (trace & TRACE_MEM_REG))
			fprintf(stderr, "%04X: %04X W %02X\n", cpu6_pc(),
				addr, val);
	if (addr >= 0xF000) {
		io_write8(addr, val);
		return;
	}

	if (addr >= 0x8000 && addr < 0xB800) {
		fprintf(stderr, "Write to ROM\n");
		return;
	}
	mem[addr] = val;
}

static struct termios saved_term, term;

static void cleanup(int sig)
{
	tcsetattr(0, TCSADRAIN, &saved_term);
	emulator_done = 1;
}

static void exit_cleanup(void)
{
	tcsetattr(0, TCSADRAIN, &saved_term);
}

void halt_system(void)
{
	printf("System halted at %04X\n", cpu6_pc());
	emulator_done = 1;
}

static void load_rom(const char *name, uint16_t addr, uint16_t len)
{
	FILE *fp = fopen(name, "r");
	if (fp == NULL) {
		perror(name);
		exit(1);
	}
	if (fread(mem + addr, len, 1, fp) != 1) {
		fprintf(stderr, "%s: read error.\n", name);
		exit(1);
	}
	fclose(fp);
}

void usage(void)
{
	fprintf(stderr, "centurion [-s diagswitches] [-d debug]\n");
	exit(1);
}

int main(int argc, char *argv[])
{
	int opt;
	while ((opt = getopt(argc, argv, "d:s:")) != -1) {
		switch (opt) {
		case 'd':
			trace = atoi(optarg);
			break;
		case 's':
			switches = atoi(optarg);
			break;
		default:
			usage();
		}
	}
	if (optind < argc)
		usage();

	if (tcgetattr(0, &term) == 0) {
		saved_term = term;
		atexit(exit_cleanup);
		signal(SIGINT, cleanup);
		signal(SIGQUIT, cleanup);
		signal(SIGPIPE, cleanup);
		term.c_lflag &= ~(ICANON | ECHO);
		term.c_cc[VMIN] = 0;
		term.c_cc[VTIME] = 1;
		term.c_cc[VINTR] = 0;
		term.c_cc[VSUSP] = 0;
		term.c_cc[VSTOP] = 0;
		tcsetattr(0, TCSADRAIN, &term);
	}
	load_rom("Diag_F1_Rev_1.0.BIN", 0x8000, 0x0800);
	load_rom("Diag_F2_Rev_1.0.BIN", 0x8800, 0x0800);
	load_rom("Diag_F3_Rev_1.0.BIN", 0x9000, 0x0800);
	load_rom("Diag_F4_1133CMD.BIN", 0x9800, 0x0800);

	while (!emulator_done)
		cpu6_execute_one();
	return 0;
}
