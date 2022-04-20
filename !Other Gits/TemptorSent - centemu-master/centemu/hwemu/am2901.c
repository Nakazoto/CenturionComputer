#include <stdio.h>
#include "am2901.h"

uint8_t am2901_read_Rmux(am2901_device_t *dev) {
	switch(dev->Rmux) {
		case 0: case 'Z': case '0': return(0);
		case 1: case 'D': return( *(dev->D) & 0xf );
		case 2: case 'A': return( dev->A & 0xf );
	}
}

uint8_t am2901_read_Smux(am2901_device_t *dev) {
	switch(dev->Smux) {
		case 0: case 'Z': case '0': return(0);
		case 1: case 'A': return(dev->A);
		case 2: case 'B': return(dev->B);
		case 3: case 'Q': return(dev->Q);
	}
}

uint8_t am2901_read_RAMmux(am2901_device_t *dev) {
	switch(dev->RAMmux) {
		case 0: case 'X': return(0);
		case 1: case 'D': return( ( (dev->F>>1) | ((*(dev->RAM3)&0x1)<<3) ) & 0xf ); 
		case 2: case 'N': return( (dev->F) & 0xf );
		case 3: case 'U': return( ( (dev->F<<1) | (*(dev->RAM0)&0x1) ) & 0xf );
	}
}

uint8_t am2901_read_Qmux(am2901_device_t *dev) {
	switch(dev->Qmux) {
		case 0: case 'X': return(0);
		case 1: case 'D': return( ( (dev->Q>>1) | ((*(dev->Q3)&0x1)<<3) ) & 0xf); 
		case 2: case 'N': return( (dev->F) & 0xf );
		case 3: case 'U': return( ( (dev->Q<<1) | (*(dev->Q0)&0x1) ) & 0xf);
	}
}

uint8_t am2901_readYmux(am2901_device_t *dev) {
	return( (dev->Ymux=='A'?dev->A:dev->F) & 0xf);
}


char *am2901_alu_source_operand_decode(am2901_device_t *dev) {
	uint8_t I210=*(dev->I210);
	/* Set MUX connections for R (0,A,D) and S (0,A,B,Q) operands */
	dev->Rmux=am2901_alu_source_operands[I210][0];
	dev->Smux=am2901_alu_source_operands[I210][1];
	return(am2901_alu_source_operand_mnemonics[I210]);
}

char *am2901_alu_destination_decode(am2901_device_t *dev) {
	uint8_t I876=*(dev->I876);
	/* Set output source ('A' or 'F') */
	dev->Ymux=am2901_alu_destinations[I876][0];

	/* Set RAM enable, mux, and RAM0/RAM3 directions */
	dev->RAM_EN=am2901_alu_destinations[I876][1];
	dev->RAMmux=am2901_alu_destinations[I876][2];
	dev->RAM0_DIR=am2901_alu_destinations[I876][3];
	dev->RAM3_DIR=am2901_alu_destinations[I876][4];

	/* Set Q enable, mux, and RAM0/RAM3 directions */
	dev->Q_EN=am2901_alu_destinations[I876][5];
	dev->Qmux=am2901_alu_destinations[I876][6];
	dev->Q0_DIR=am2901_alu_destinations[I876][7];
	dev->Q3_DIR=am2901_alu_destinations[I876][8];

	/* Return the mnemonic */
	return(am2901_alu_destination_mnemonics[I876]);
}

char *am2901_alu_function_decode(am2901_device_t *dev) {
	uint8_t I543=*(dev->I543);
	uint8_t R=am2901_read_Rmux(dev);
	uint8_t S=am2901_read_Smux(dev);

	uint8_t F,P,P_,P3,P2,P1,P0,Pall,G,G_,G3,G2,G1,G0,Gany,Cn,Co,C4,C3,OVR;
	Cn=*(dev->Cn);

	/* Complement R or S before calculating P and G as required */
	switch(I543) {
		case SUBR: case NOTRS: case EXOR: R = ~R; break;
		case SUBS: S = ~S;
	}

	P=(R|S)&0xf;
	G=(R&S)&0xf;

	P0=(P&0x1)?1:0;
	P1=(P&0x2)?1:0;
	P2=(P&0x4)?1:0;
	P3=(P&0x8)?1:0;
	Pall=(P3&P2&P1&P0);

	G0=(G&0x1)?1:0;
	G1=(G&0x2)?1:0;
	G2=(G&0x4)?1:0;
	G3=(G&0x8)?1:0;
	Gany=(G3|G2|G1|G0);

	C4=G3|(P3&G2)|(P3&P2&G1)|(P3&P2&P1&G0)|(P3&P2&P1&P0&Cn);
	C3=G2|(P2&G1)|(P2&P1&G0)|(P2&P1&P0&Cn);

	switch(I543) {
		case ADD:
		case SUBR:
		case SUBS:
			F=( R + S + Cn ) & 0xf;
			P_=~Pall & 0x1;
			G_=~((G3)|(P3&G2)|(P3&P2&G1)|(P3&P2&P1&G0)) & 0x1;
			Co=C4;
			OVR=C3^C4;
			break;
		case OR:
			F=( R | S ) & 0xf;
			P_=0;
			G_=Pall;
			Co=( ~Pall | Cn) & 0x1;
			OVR=Co;
			break;
		case AND:
		case NOTRS:
			F=( R & S ) & 0xf;
			P_=0;
			G_= ~Gany & 0x1;
			Co= Gany | Cn;
			OVR=Co;
			break;
		case EXOR:
		case EXNOR:
			F=( ( R & S ) | ( ~R & ~S ) ) & 0xf;
			P_=Gany;
			G_= G3 | (P3&G2) | (P3&P2&G1) | Pall;
			Co= ~( G_ & ( G0 | (~Cn&0x1) ) ) & 0x1;
			OVR=( ( ~P2 | (~G2&~P1) | (~G2&~G1&~P0) | (~G2&~G1&~G0&Cn) )
			    ^ ( ~P3 | (~G3&~P2) | (~G3&~G2&~P1) | (~G3&~G2&~G1&~P0) | (~G3&~G2&~G1&~G0&Cn) )
			    ) & 0x1;
			break;
	}
	dev->F=F;
	*(dev->P_)=P_;
	*(dev->G_)=G_;
	*(dev->Co)=Co;
	*(dev->OVR)=OVR;
	return(am2901_alu_function_mnemonics[I543]);
}

char *am2901_update(am2901_device_t *dev) {

	/* Update shifter outputs */
	if(dev->Q0_DIR=='O') { *(dev->Q0)=dev->Q&0x1; }
	if(dev->Q3_DIR=='O') { *(dev->Q3)=(dev->Q>>3)&0x1; }
	if(dev->RAM0_DIR=='O') { *(dev->RAM0)=dev->F&0x1; }
	if(dev->RAM3_DIR=='O') { *(dev->RAM3)=(dev->F>>3)&0x1; }

	/* Zero flag - must be "pulled high" externally, this acts as an open-collector output*/
	if(dev->F&0xf){*(dev->FZ)=0;}

	/* F3 flag - set if MSB of F is 1 (sign bit if MSB of word)*/
	*(dev->F3)=dev->F&0x8?1:0;

	/* Update Y outputs if enabled */
	if(!*(dev->OE_)){*(dev->Y)=am2901_readYmux(dev);}


}


char *am2901_clock_state_setup_H(am2901_device_t *dev){
	/* Decode destination portion of instruction */
	printf("Dest: %s\n",am2901_alu_destination_decode(dev));
}

char *am2901_clock_state_edge_HL(am2901_device_t *dev) {
	/* Latch A & B from RAM address on A0-A3 */
	dev->A=dev->RAM[*(dev->ADDR_A)];
	dev->B=dev->RAM[*(dev->ADDR_B)];
}


char *am2901_clock_state_hold_L(am2901_device_t *dev){

}

char *am2901_clock_state_setup_L(am2901_device_t *dev){
	/* Decode source operands portion of instruction */
	printf("Src:  %s\n",am2901_alu_source_operand_decode(dev));

	/* Decode ALU operation */
	printf("Func: %s\n",am2901_alu_function_decode(dev));

	/* Update RAM at address in ADDR_B if RAM_EN is high */
	if(dev->RAM_EN) { dev->RAM[*(dev->ADDR_B)]=am2901_read_RAMmux(dev); }
}

char *am2901_clock_state_edge_LH(am2901_device_t *dev) {
	/* Update Q regsister if Q_EN is high */
	if(dev->Q_EN) { dev->Q=am2901_read_Qmux(dev); }

}

char *am2901_clock_state_hold_H(am2901_device_t *dev){

}

typedef struct alu_input_t {
	enum am2901_alu_source_operand_code I210;
	enum am2901_alu_function_code I543;
	enum am2901_alu_destination_code I876;
	uint8_t ADDR_A, ADDR_B;
	uint8_t Din;
	uint8_t Cin;
} alu_input_t;
	


int main() {
	am2901_device_t d0a={}, d1a={};
	am2901_device_t *alu0, *alu1;
	uint8_t din0=0xc, dout0, P_0, G_0, OVR0, FS0;
	uint8_t din1=0x5, dout1, P_1, G_1, OVR1, FS1;
	uint8_t RAM0,RAM3,RAM7, Q0,Q3,Q7, C0,C4,C8;
	uint8_t	aluA=0x0, aluB=0x0, OE_=0, Dout;
	uint8_t FZ, FN, FC, FV;
	enum am2901_alu_source_operand_code I210;
	enum am2901_alu_function_code I543;
	enum am2901_alu_destination_code I876;

	alu_input_t prog[4]={
		{DZ,OR,RAMF,0,0,0xf0,0},
		{DZ,OR,RAMF,0,1,0x55,0},
		{AB,EXNOR,RAMF,0,1,0,0},
		{DA,ADD,RAMQU,1,2,0x03,0}
	};

	alu0=&d0a;
	alu1=&d1a;

	/* Inputs */
	alu0->I210=&I210;
	alu0->I543=&I543;
	alu0->I876=&I876;
	alu0->ADDR_A=&aluA;
	alu0->ADDR_B=&aluB;
	alu0->OE_=&OE_;

	alu1->I210=&I210;
	alu1->I543=&I543;
	alu1->I876=&I876;
	alu1->ADDR_A=&aluA;
	alu1->ADDR_B=&aluB;
	alu1->OE_=&OE_;

	alu0->D=&din0;
	alu0->Cn=&C0;
	alu0->Co=&C4;
	alu0->Y=&dout0;
	alu0->P_=&P_0;
	alu0->G_=&G_0;
	alu0->OVR=&OVR0;
	alu0->FZ=&FZ;
	alu0->F3=&FS0;
	alu0->RAM0=&RAM0;
	alu0->RAM3=&RAM3;
	alu0->Q0=&Q0;
	alu0->Q3=&Q3;

	alu1->D=&din1;
	alu1->Y=&dout1;
	alu1->Cn=&C4;
	alu1->Co=&FC;
	alu1->P_=&P_1;
	alu1->G_=&G_1;
	alu1->OVR=&FV;
	alu1->FZ=&FZ;
	alu1->F3=&FN;
	alu1->RAM0=&RAM3;
	alu1->RAM3=&RAM7;
	alu1->Q0=&Q3;
	alu1->Q3=&Q7;


	for(int i=0; i<4; i++) {
		/* Pull the Zero flag high (open collector output) */
		FZ=1;

		I210=prog[i].I210;
		I543=prog[i].I543;
		I876=prog[i].I876;

		aluA=prog[i].ADDR_A;
		aluB=prog[i].ADDR_B;
		C0=prog[i].Cin;

		din0=prog[i].Din&0x0f;
		din1=(prog[i].Din&0xf0)>>4;

		am2901_clock_state_setup_H(alu0);
		am2901_clock_state_setup_H(alu1);

		am2901_clock_state_edge_HL(alu0);
		am2901_clock_state_edge_HL(alu1);

		am2901_clock_state_hold_L(alu0);
		am2901_clock_state_hold_L(alu1);

		am2901_clock_state_setup_L(alu0);
		am2901_clock_state_setup_L(alu1);

		am2901_clock_state_edge_LH(alu0);
		am2901_clock_state_edge_LH(alu1);

		am2901_clock_state_hold_H(alu0);
		am2901_clock_state_hold_H(alu1);
		am2901_update(alu0);
		am2901_update(alu1);
		Dout=dout1<<4|dout0;
		
		printf("%x  Flags: %c%c%c%c \n", Dout,FC?'Z':' ',FV?'V':' ',FN?'N':' ',FZ?'Z':' ');
		printf(
			"A[%x]:%x %x  B[%x]:%x %x\n\n",
			aluA, alu1->RAM[aluA], alu0->RAM[aluA],
			aluB,alu1->RAM[aluB],alu0->RAM[aluB]
		);
	}
	return(0);
}
