#include <stdint.h>

enum am2909_source_code { uPC=00, AR=01, STK0=02, Di=03 };
static char *am2901_source_mnemonics[4] = { "uPC", "AR", "STK0", "Di" };

enum am2909_stack_control_code { POP=00, PUSH=01, HOLD=02, HOLD2=03 };
static char *am2909_stact_control_mnemonics[4] = {"POP","PUSH","HOLD","HOLD2"};

typedef struct am2909_device_t {

	enum am2909_source_code *S; /* Source (S1,S0) select */
	uint8_t *FE_; /* File Enable (Active LO)  - Stack HOLD when high, Push/Pop occur when low */
	uint8_t *PUP; /* When enabled by FE_, increment SP and Push when high, Pop and decrement SP when low */

	uint8_t *Cn; /* Carry-in to incrementer */

	uint8_t *Di; /* Di Direct inputs to MUX */

	uint8_t *RE_; /* Enable line for internal address register */
	uint8_t *Ri; /* Ri Inputs to internal address register */

	uint8_t uPC; /* Microprogram counter */
	uint8_t AR; /* Address/holding register */
	uint8_t STK[4]; /* Stack (circular buffer) */
	uint8_t SP; /* Stack pointer */


	uint8_t *Co; /* Carry-out from incrementer */

	uint8_t *Y; /* Output value */
	uint8_t *ORi; /* ORi output controls (set Yi high if outputs enabled and not zeroed) */
	uint8_t *ZERO_; /* Force all Yi output bits to 0 if outputs enabled when low (Active LO)*/
	uint8_t *OE_; /* Enable Yi outputs when low (Active LO), High-Z when high */


} am2909_device_t;

