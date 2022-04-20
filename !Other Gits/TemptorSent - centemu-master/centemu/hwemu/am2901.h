#include <stdint.h>

enum am2901_alu_source_operand_code { AQ=00, AB=01, ZQ=02, ZB=03, ZA=04, DA=05, DQ=06, DZ=07 };
static char am2901_alu_source_operands[8][2] = { {'A','Q'},{'A','B'},{'0','Q'},{'0','B'},{'0','A'},{'D','A'},{'D','Q'},{'D','0'}};
static char *am2901_alu_source_operand_mnemonics[8] = { "AQ", "AB", "ZQ", "ZB", "ZA", "DA", "DQ", "DZ" };

enum am2901_alu_function_code { ADD=00, SUBR=01, SUBS=02, OR=03, AND=04, NOTRS=05, EXOR=06, EXNOR=07 };
static char *am2901_alu_function_mnemonics[8]= {"ADD","SUBR","SUBS","OR","AND","NOTRS","EXOR","EXNOR"};
static char *am2901_alu_function_symbol_c[8] = {"R+S+Cn","S-R-1+Cn","R-S-1+Cn","R|S","R&S","(~R)&S","R^S","~(R^S)"};

enum am2901_alu_destination_code { QREG=00, NOP=01, RAMA=02, RAMF=03, RAMQD=04, RAMD=05, RAMQU=06, RAMU=07};
static char *am2901_alu_destination_mnemonics[8] = {"QREG","NOP", "RAMA","RAMF","RAMQD","RAMD","RAMQU","RAMU"};

// enum am2901_alu_destination_fields { Ymux, RAM_EN, RAMmux, RAM0_DIR, RAM3_DIR, Q_EN, Qmux, Q0_DIR, Q3_DIR };
static char am2901_alu_destinations[8][9] = {
	{'F', 0,'N','Z','Z', 1,'N','Z','Z'}, /* QREG, F->Q, Y=F */
	{'F', 0,'N','Z','Z', 0,'N','Z','Z'}, /* NOP Y=F */
	{'A', 1,'N','Z','Z', 0,'N','Z','Z'}, /* RAMA, F->B, Y=A */
	{'F', 1,'N','Z','Z', 0,'N','Z','Z'}, /* RAMF, F->B, Y=F */
	{'F', 1,'D','O','I', 1,'D','O','I'}, /* RAMQD, F/2->B, Q/2->Q, Y=F */
	{'F', 1,'D','O','I', 0,'D','O','Z'}, /* RAMD, F/2->B, Y=F */
	{'F', 1,'U','I','O', 1,'U','I','O'}, /* RAMQU, F*2->B, Q*2->Q, Y=F */
	{'F', 1,'U','I','O', 0,'U','Z','O'} /* RAMU, F*2->B, Y=F */
};


typedef struct am2901_device_t {
	/* Instruction word of 9 bits in 3 groups of 3 bit (octal) values */
	enum am2901_alu_source_operand_code *I210; /* Source operand octal value */
	enum am2901_alu_function_code *I543; /* ALU function octal value */
	enum am2901_alu_destination_code *I876; /* Destination octal value */

	/* RAM input shifter */
	uint8_t *RAM0; /* LSB in RAM data input shift line */
	uint8_t *RAM3; /* MSB in RAM data input shift line */
	unsigned char RAM0_DIR; /* Hi'Z', 'I'n, or 'O'ut */
	unsigned char RAM3_DIR; /* Hi'Z', 'I'n, or 'O'ut */
	unsigned char RAMmux; /* RAM MUX shift select ('D'own,'N'one,'U'p) */
	uint8_t RAM_EN; /* RAM data input enable */

	/* RAM Register file */
	uint8_t RAM[16]; /* Register file with 16 x 4-bit words of RAM */
	uint8_t *ADDR_A; /* Address in RAM to use for "A" (read) */
	uint8_t *ADDR_B; /* Address in RAM to use for "B" (read/write) */
	uint8_t A; /* Value in A Latch */
	uint8_t B; /* Value in B Latch */

	/* External data input */
	uint8_t *D; /* Direct data input */

	/* ALU */
	uint8_t *Cn; /* Carry-in */
	unsigned char Rmux; /* R Operand MUX select ('Z'ero (0),'D','A') */
	unsigned char Smux; /* S Operand MUX select ('Z'ero (0),'A','B','Q') */
	uint8_t F; /* Result from ALU */
	uint8_t *P_; /* Propagate signal */
	uint8_t *G_; /* Generate signal */
	uint8_t *Co; /* Carry-out */
	uint8_t *OVR; /* Overflow flag */

	/* Q input shifter */
	uint8_t *Q0; /* LSB in Q shift line */
	uint8_t *Q3; /* MSB in Q shift line */
	unsigned char Q0_DIR; /* Hi'Z', 'I'n, or 'O'ut */
	unsigned char Q3_DIR; /* Hi'Z', 'I'n, or 'O'ut */
	unsigned char Qmux; /* Q MUX shift select ('D'own,'N'one (F->Q),'U'p) */
	uint8_t Q_EN; /* Q data input enable */
	uint8_t Q; /* Output data from Q Register */

	/* Outputs */
	uint8_t *FZ; /* Zero flag output */
	uint8_t *F3; /* High bit set (Negitive) flag output */
	unsigned char Ymux; /* Y MUX output source select ('F' or 'A') */
	uint8_t *Y; /* Output value */
	uint8_t *OE_; /* Output Enable (Active LOW) HiZ=1 */
} am2901_device_t;

