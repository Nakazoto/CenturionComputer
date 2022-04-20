#include <stdio.h>
#include "am2909.h"


char *am2909_clock_edge_LH(am2909_device_t *dev) {
	uint8_t O,SP;

	/* Latch Ri into AR if RE_ is LOW */
	if( !(*(dev->RE_)) ){ dev->AR=*(dev->Ri); }

	/* Select source to temp output O */
	switch(*(dev->S)) {
		case uPC: O=dev->uPC; break;
		case AR: O=dev->AR; break;
		case STK0: O=dev->STK[dev->SP]; break;
		case Di: O=*(dev->Di); break;
	}

	/* Apply ZERO_ and ORi to O */
	O=(*(dev->ZERO_)?O|*(dev->ORi):0);

	/* Increment our uPC based on Cn and set Co if needed */
	dev->uPC=(O+*(dev->Cn))&0xf;
	*(dev->Co)=(*(dev->Cn)&&O==0xf)?1:0;


	/* Push/Pop as indicated by FE_ and PUP */
	if(!*(dev->FE_)) {
		SP=dev->SP;
		if(*(dev->PUP)) {
			dev->SP=(SP+1)&0x3;
			dev->STK[dev->SP]=uPC;
		} else {
			dev->SP=SP?SP-1:0x3;
		}
	}

	/* Set output values Y if OE_ is LOW (HiZ=1) */
	if(!*(dev->OE_)){*dev->Y=O;}
}
//	am2909_seq_init(seq0,&S,&FE_,&PUP,&Di,&Ri,&RE_,&Cn,&Co,&ORi,&ZERO_,&OE_,&Y);
int am2909_seq_init(am2909_device_t *dev,
	enum am2909_source_code *S, uint8_t *FE_, uint8_t *PUP, /* Select operation */
	uint8_t *Di, uint8_t *Ri, uint8_t *RE_, /* Direct and AR (when RE_ is LO) inputs */
	uint8_t *Cn, uint8_t *Co, /* Incrementer carry in and carry out, Cn=1 increments uPC, Cn=0 repeats current op */
	uint8_t *ORi, uint8_t *ZERO_, uint8_t *OE_, /* Outputs overrides: OE_=1->HiZ, ZERO_=0->Y=0, ORi=1->Yi=1 */
	uint8_t *Y /* Outputs Yi of Y if not overridden by above */) {
	dev->S=S;
	dev->FE_=FE_;
	dev->PUP=PUP;
	dev->Cn=Cn;
	dev->Di=Di;
	dev->RE_=RE_;
	dev->Ri=Ri;

	dev->Co=Co;
	dev->ORi=ORi;
	dev->ZERO_=ZERO_;
	dev->OE_=OE_;
	dev->Y=Y;
}

int main() {
	am2909_device_t d0a={}, *seq0;
	enum am2909_source_code S;
	uint8_t FE_, PUP, Cn, Di, RE_, Ri;
	uint8_t Co, ORi, ZERO_, OE_,Y;
	seq0=&d0a;
	
	am2909_seq_init(seq0,&S,&FE_,&PUP,&Di,&Ri,&RE_,&Cn,&Co,&ORi,&ZERO_,&OE_,&Y);
/*
	seq0->S=&S;
	seq0->FE_=&FE_;
	seq0->PUP=&PUP;
	seq0->Cn=&Cn;
	seq0->Di=&Di;
	seq0->RE_=&RE_;
	seq0->Ri=&Ri;

	seq0->Co=&Co;
	seq0->ORi=&ORi;
	seq0->ZERO_=&ZERO_;
	seq0->OE_=&OE_;
	seq0->Y=&Y;
*/
	am2909_clock_edge_LH(seq0);
	return(0);
}
