#include <stdio.h>


struct centinst {
	uint8_t opcode;
	uint8_t arg1;
	uint8_t arg2;
	uint8_t argc;
	uint8_t amode;
} centinst;

typedef struct mnem_operation {
	char *mnemonic;
	uint8_t argb;
	char description[64];
} op;

struct centamode {
	char mode[16];
	char mnem_format[32];
};



static char* mn_misc[]={"hlt","nop","f2?","f3?","f4?","f5?","f6?","fcc","f8?","ret","u?a","u?b","u?c","u?d","dly","u?f",0};
static char* mn_b[]={"bcs","bcc","bss","bsc","bzs","bzc","blt","bge","bgt","ble","bxs0","bxs1","bxs2","bxs3","b??0","b??1",0};
static char* mn_alub[]={"addb","subb","andb","orb","alu4b","alu5b","alu6b","alu7b",0};
static char* mn_aluw[]={"addw","subw","andw","orw","alu4w","alu5w","alu6w","alu7w",0};
static char* mn_jc[]={"jump","call",0};
static char* mn_ldst[]={"stxb","stxw","ldxb","ldxw","styb","styw","ldyb","ldyw",0};
static char* none="";
static char* unknown="????";

char * mn_list[0x10][0x10]={
	{"hlt","nop","f2?","f3?","f4?","f5?","f6?","fcc","f8?","ret","u?a","u?b","u?c","u?d","dly","u?f"},
	{"bcs","bcc","bss","bsc","bzs","bzc","blt","bge","bgt","ble","bxs0","bxs1","bxs2","bxs3","b??0","b??1"},
	{"incb","decb","clrb","notb","lsrb","lslb","rrcb","rlcb", 0,0,0,0, 0,0,0,0},
	{"incw","decw","clrw","notw","lsrw","lslw","rrcw","rlcw", 0,0,0,0, 0,0,0,0},
	{"addb!","subb!","andb!","orb!","alu4b!","alu5b!","alu6b!","alu7b!","addb","subb","andb","orb","alu4b","alu5b","alu6b","alu7b"},
	{"addw!","subw!","andw!","orw!","alu4w!","alu5w!","alu6w!","alu7w!","addw","subw","andw","orw","alu4w","alu5w","alu6w","alu7w"},
	{"stzw","ldzw",0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0},
	{"jump","call",0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0},
	{"stxb",0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0},
	{"stxw",0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0},
	{"ldxb",0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0},
	{"ldxw",0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0},
	{"styb",0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0},
	{"styw",0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0},
	{"ldyb",0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0},
	{"ldyw",0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0}

};

char *am_mem_list[0x10] = {"#D","A","[A]","PC+X","[PC+X]","_[R]_","?R?","?R?","R0","R1","R2","R3","R4","R5","R6","R7"};
char *am_alu_list[0x02] = {"","R, R"};
char *am_br = "X";
int parse_opcode(uint8_t op, char **mn, char **am) {
	uint8_t oph=(op >> 4);
	unsigned char argb=0;
	*mn=unknown;
	*am=unknown;
	switch( oph ) {
		case 0xf:
		case 0xe:
		case 0xd:
		case 0xc:
		case 0xb:
		case 0xa:
		case 0x9:
		case 0x8:
			*mn=mn_list[oph][0];
			*am=am_mem_list[(op&0xf)];
			argb=(op&0x08)?0:(op&0x07)>2?1:(op&0x03)?2:(op&0x10)?2:1;
			break;
		case 0x7:
			*mn=mn_list[oph][(op&0x08)>>3];
			*am=am_mem_list[(op&0x7)];
			argb=(op&0x07)>3?1:2;
			break;
		case 0x6:
			*mn=mn_list[oph][(op&0x08)>>3];
			*am=am_mem_list[(op&0x7)];
			argb=(op&0x07)>2?1:2;
			break;
		case 0x5:
		case 0x4:
			*mn=mn_list[oph][(op&0x0f)];
			*am=am_alu_list[(op&0x8)>>3];
			argb=(op&0x08)?1:0;
			break;
		case 0x3:
		case 0x2:
			*mn=mn_list[oph][(op&0x07)];
			*am=am_alu_list[(op&0x8)>>3];
			argb=(op&0x08)?1:0;
			break;
		case 0x1:
			argb=1;
			*am=am_br;
		case 0x0:
			*mn=mn_list[oph][(op&0x0f)];
			*am=none;
			break;
	}
	return(argb);
}

#define nibble2bcdb(n) ( (((n&0x8)>>3) * 1000) + (((n&0x4)>>2) * 100) + (((n&0x2)>>1) * 10) + (n&0x1))

int main() {
	char **mn, **am;
	unsigned int i,args;
	unsigned short h,l;
	for(i=0; i<=0xff; i++) {
		h=nibble2bcdb(i>>4);
		l=nibble2bcdb(i&0xf);
		args=parse_opcode(i,mn,am);
		printf("0x%02x\t %04u %04u\t%u\t%s\t%s\n", i, h,l,args, *mn, *am);
	}
	return(0);
}
