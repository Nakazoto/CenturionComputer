
#define AH		0
#define AL		1
#define BH		2
#define BL		3
#define RH		4
#define RL		5
#define DH		6
#define DL		7
#define EH		8
#define EL		9
#define SH		10
#define SL		11
#define GH		12
#define GL		13
#define HL		14
#define HH		15

#define AX		0
#define BX		1
#define RT		2
#define DX		3
#define EX		4
#define SP		5	/* Just a convention it seems */
#define GX		6
#define HX		7

extern uint8_t mem_read8(uint16_t addr);
extern void mem_write8(uint16_t addr, uint8_t val);
extern void halt_system(void);
extern uint16_t cpu6_pc(void);
extern unsigned cpu6_execute_one(void);
