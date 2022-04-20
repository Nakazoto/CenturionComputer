#include <stdio.h>
#include <inttypes.h>
#define NUMROMS 7
#define ROMSIZE 2048

/* Utility functions to extract ranges of bits, with _R reversing the bit order returned */
#define BITRANGE(d,s,n) ((d>>s) & ((2LL<<(n-1))-1) )
#define BITRANGE_R(d,s,n) (bitreverse_64(BITRANGE(d,s,n)) >>(64-n))

uint8_t allrom[NUMROMS][ROMSIZE];
uint8_t mergedrom[ROMSIZE][NUMROMS];
uint64_t iws[ROMSIZE];
//char iws_binarytext[ROMSIZE][NUMROMS*10];
static char *ROM_files[NUMROMS] = {
	"CPU_5.rom", /* MWK3.11 - A3.11 */
	"CPU_2.rom", /* MWF3.11 - B3.11 */
	"CPU_3.rom", /* MWH3.11 - C3.11 */
	"CPU_6.rom", /* MWL3.11 - D3.11 */
	"CPU_7.rom", /* MWM3.11 - E3.11 */
	"CPU_4.rom", /* MWJ3.11 - F3.11 */
	"CPU_1.rom"  /* MWE3.11 - ??3.11 */
};
/*static char *ROM_files[NUMROMS] = {
	"CPU_1.rom",
	"CPU_2.rom",
	"CPU_3.rom",
	"CPU_4.rom",
	"CPU_5.rom",
	"CPU_6.rom",
	"CPU_7.rom"
};
*/
uint64_t concat_bytes(uint8_t bytes[]){
	uint64_t out=0,in;
	for(int i=0;i<NUMROMS;i++) {
		in=bytes[i];
		//printf(" in[%u]=%x ",i,in);
		out = out | (in<<(i*8));
	}
	return(out);
}
uint64_t bitreverse_64(uint64_t in) {
	uint64_t out=0;
	for(int i=63;i>=0;i--) {
		//printf("%u %#018"PRIx64" %#018"PRIx64"\n",i,in,out);
		out |= in&0x1;
		if(!i){return(out);}
		out <<= 1;
		in >>= 1;
		//printf("%u %#018"PRIx64" %#018"PRIx64"\n",i,in,out);
	}
}

uint16_t bitsalad_16(uint64_t order, uint16_t d) {
	uint8_t pos;
	uint16_t out;
	for(int i=0; i<16; i++) {
		pos=BITRANGE(order,i*4,4);
		if(d&1<<i){out |= 1<<pos;}
	}
	return(out);
}

uint8_t bitsalad_8(uint32_t order, uint8_t d) {
	uint8_t pos;
	uint8_t out;
	for(int i=0; i<16; i++) {
		pos=BITRANGE(order,i*4,4);
		if(d&1<<i){out |= 1<<pos;}
	}
	return(out);
}

int read_roms() {
	FILE *fp;
	size_t ret_code;

	for(int  i=0; i<NUMROMS; i++) {
		fp=fopen(ROM_files[i],"rb");
		ret_code=fread(allrom[i],1,ROMSIZE,fp);
		if(ret_code != ROMSIZE) {
			if(feof(fp)) {
				printf("Unexpected EOF while reading %s: Only got %u byte of an expected %s.\n",
					ROM_files[i], ret_code, ROMSIZE);
			} else if(ferror(fp)){
				printf("Failed while reading %s!\n",ROM_files[i]);
			}
			fclose(fp);
			return(-1);
		}
		fclose(fp);

	}
	return(NUMROMS*ROMSIZE);

}

int merge_roms() {
	uint64_t iw;
	for(int i=0; i<ROMSIZE; i++) {
		printf("\n%04x",i);
		for(int j=1; j<=NUMROMS; j++) {
			mergedrom[i][NUMROMS-j]=allrom[j][i];
			printf(" %02x",mergedrom[i][NUMROMS-j]);
		}
		iw=concat_bytes(mergedrom[i]);
		iws[i]=iw;
		/*
		printf("\tI:%03o A':%x A:%x  %#018"PRIx64"",
			BITRANGE(iw,34,9),
			BITRANGE(iw,44,4),
			BITRANGE_R(iw,44,4),
			iw
		);
		*/
	}

	return(ROMSIZE);
}

char  *int64_bits_to_binary_string(char *out, uint64_t in, uint8_t bits, uint8_t grouping) {
	char *p;
	p=out;
	bits=bits<65?bits:64;
	for(int i=bits-1; i>=0; i--) {
		*(p++)=(in&(1LL<<i))?'1':'0';
		if(i&&!(i%grouping)&&grouping){ *(p++)=' '; }
	}
	*p='\0';
	return(out);
}

int main() {
	uint16_t tmp;
	uint64_t salad;
	char binstr[100];
	read_roms();
	merge_roms();

	for(int i=0; i<ROMSIZE; i++) {
		printf("\n%04x",i);
		int64_bits_to_binary_string(binstr, iws[i], NUMROMS*8,4);
		printf(" %#016"PRIx64" %s",iws[i],binstr);
		printf(" 2901H: I=%03o",BITRANGE(iws[i],10,9));
		printf(" 2909H: FE_PUP=%01o",BITRANGE_R(iws[i],28,2));
	}
	tmp=0xfc18;
	salad=0xfedcba9765843210LL;

	printf("\n\nbitsald tossing:\n%04x -%llx> %04x\n",tmp,salad,bitsalad_16(salad,tmp));

}
