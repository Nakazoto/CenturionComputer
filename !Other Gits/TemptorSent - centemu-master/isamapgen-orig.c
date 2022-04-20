#include <stdio.h>

void print_ins(unsigned char i);
unsigned char print_mnemonic(unsigned char i);
unsigned char print_amode(unsigned char i, unsigned char l, unsigned char m);
unsigned char print_branch(unsigned char i, unsigned char t);	
unsigned char print_alu(unsigned char i, unsigned char t);

int main() {
	unsigned int i,h,l;
	for(i=0; i<=0xff; i++) {
		print_ins((unsigned char)(i&0xff));
	}
	return(0);
}

void print_ins(unsigned char i) {
	unsigned char argb=0;
	unsigned int h,l;
	h=1000*(i>>7 & 1)+100*(i>>6 & 1)+10*(i>>5 & 1)+(i>>4 & 1);
	l=1000*(i>>3 & 1)+100*(i>>2 & 1)+10*(i>>1 & 1)+(i & 1);
	printf("0x%02hhx\t%04u %04u\t", i,h,l);
	argb=print_mnemonic(i);
	printf("\t:%u\n",argb);
	return;
}

unsigned char print_mnemonic(unsigned char i) {
	unsigned char argb=0;
	/* Utility functions */
	if((i&0xf0) == 0x00) {
		if(i == 0x00) {
			printf("hlt\thalt execution");
		} else if (i==0x01) {
			printf("nop\tno-op");
		} else if (i<0x9) {
			/* Flag bits */
			switch(i&0x0f) {
				case 0x07:
					printf("fcc\tclear carry flag");
					break;
				default:
					printf("f%u\tflag%u",i-0x02, i-0x02);
			}
		} else if (i==0x9) {
			printf("ret\treturn from subroutine");
		} else if (i==0x0e) {
			printf("dly\tdelay 4.5ms");
		}	
	}

	/* conditional branch instructions */
	if((i&0xf0) == 0x10) {
		argb=1;
		printf("b");
		argb=print_branch(i&0xf,1);
		printf(" PC+<exp>\trelative branch if ");
		print_branch(i&0xf,0);

	}

	/* ALU instructions */
	if((i&0xe0) == 0x40) {
		argb=(i&0x08)?1:0;
		print_alu(i&0x7,1);
		argb?printf(" r<exp:4-7>, r<exp:0-3>\t"):printf(" B, A\t");
		print_alu(i&0x7,0);
		argb?printf(" register <high nibble of exp> "):printf(" accumulator B ");
		if((i&0x7)==0) { printf("to"); }
		else if((i&0x7==1)) { printf("from"); }
		else { printf("with");}

		argb?printf(" register <low nibble of exp> "):printf(" accumulator A ");
	}

	/* jump/call instructions) */
	if((i&0xf0) == 0x70) {
		i&0x08?printf("call"):printf("jump");
		printf(" ");
		argb=print_amode(i&0x7,1,1);
		printf("\t");
		print_amode(i&0x7,1,0);
		i&0x08?printf(" call"):printf(" jump");
	}

	/* load/store instructions */
	if(i&0x80) {
		i&0x20?printf("ld"):printf("st");
		i&0x10?printf("w"):printf("b");
		i&0x40?printf(" B, "):printf(" A, ");
		argb=print_amode(i&0xf,i&0x10?2:1,1);
		printf("\t");
		i&0x20?printf("load "):printf("store ");
		i&0x10?printf("word "):printf("byte ");
		if(i&0x20) {
			i&0x40?printf("accumulator B from "):printf("accumulator A from ");
			print_amode(i&0xf,i&0x10?2:1,0);
		} else {
			i&0x40?printf("accumulator B to "):printf("accumulator A to ");
			print_amode(i&0xf,i&0x10?2:1,0);
		}
	}
	return(argb);
}

/* pass three bit address mode m, data length l, and output type t (0/1) */
unsigned char print_amode(unsigned char m, unsigned char l, unsigned char t) {
	unsigned char argb=1;
	if( m&0x8 ) {
		argb=0;
		printf("r%u", m&0x7);
	}	
	else {
			switch(m) {
			case 0x0:
				t?printf("#<exp>"):printf("immediate");
				argb=l;
				break;
			case 0x1:
				t?printf("<exp>"):printf("direct absolute");
				argb=2;
				break;
			case 0x2:
				t?printf("[<exp>]"):printf("indirect absolute");
				argb=2;
				break;
			case 0x3:
				t?printf("PC+<exp>"):printf("direct PC relative");
				break;
			case 0x4:
				t?printf("[PC+<exp>]"):printf("indirect PC relative");
				break;
			case 0x5:
				t?printf("<-/+>[<exp>]<+/->"):printf("autoincremented indexed indirect");
				printf("??");
				break;
			case 0x6:
				printf("??");
				break;
			case 0x7:
				printf("??");
				break;
		}
	}
	return(argb);
}

unsigned char print_branch(unsigned char i, unsigned char t) {
	unsigned char argb=1;
	switch(i&0xf) {
		case 0x0:
			t?printf("cs"):printf("carry flag set");
			break;
		case 0x1:
			t?printf("cc"):printf("carry flag clear");
			break;
		case 0x2:
			t?printf("ss"):printf("carry flag set");
			break;
		case 0x3:
			t?printf("sc"):printf("carry flag clear");
			break;
		case 0x4:
			t?printf("zs"):printf("zero flag set");
			break;
		case 0x5:
			t?printf("zc"):printf("zero flag clear");
			break;
		case 0x6:
			t?printf("lt"):printf("less than");
			break;
		case 0x7:
			t?printf("ge"):printf("greater than or equal");
			break;
		case 0x8:
			t?printf("gt"):printf("greater than");
			break;
		case 0x9:
			t?printf("le"):printf("less than or equal");
			break;
		case 0xa:
		case 0xb:
		case 0xc:
		case 0xd:
			t?printf("xs%u",(i&0x07)-0x2):printf("external sense %u",(i&0x07)-0x2);
			break;
		default:
			printf("??");
			break;
	}
	return(argb);
}

unsigned char print_alu(unsigned char i, unsigned char t) {
	switch(i&0x7) {
		case 0x0:
			printf("add");
			break;
		case 0x1:
			t?printf("sub"):printf("subtract");
			break;
		case 0x2:
			printf("and");
			break;
		case 0x3:
			printf("or");
			break;
		default:
			printf("??");
			break;
	}
	return(1);
}
