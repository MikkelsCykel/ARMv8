#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <inttypes.h>
#include <stdint.h>
#include <assert.h>
#include <signal.h>
#include <unistd.h>
#include <time.h>
#include <sys/time.h>
#define _GNU_SOURCE            
#define __USE_GNU
#include <sched.h>
#include <arm_neon.h>


#define REPEAT 100000
#define WARMUP REPEAT/4
uint64_t start_clk, end_clk;
double total_clk;


__inline uint64_t get_Clks(void) {
	struct timeval tv;
	gettimeofday(&tv, NULL);
	return (tv.tv_sec * 1e6 + tv.tv_usec); // usec
}

#define MEASURE(x)  for (int i=0; i< WARMUP; i++){x;}        \
					start_clk=get_Clks();                \
					for (int i = 0; i < REPEAT; i++)         \
					{                                    \
								 {x;}                    \
					}                                    \
					end_clk=get_Clks();                  \
					total_clk=(double)(end_clk-start_clk)*2.1e3/REPEAT;

#define TIME_IT(name, func, nbytes, MULTIPLE)            \
	printf("%s-%d: ", name, nbytes);                     \
	MEASURE(func);                                       \
	printf("%g cpb\n", total_clk/(nbytes)/(MULTIPLE));

void printblock(const unsigned char* x)
{
	for (int i = 0; i < 16; i++) {
		if(i%4 == 0 && i != 0){
			putchar(' ');
		}
		printf("%02x", x[i]);
	}
	putchar('\n');
}

struct Message{
	unsigned char* M;
	int l;
};

uint8x16_t aes_enc_rnd(uint8x16_t block, uint8x16_t rndKey){
	return vaesmcq_u8(vaeseq_u8(block, rndKey));
}

uint8x16_t aes_enc(uint8x16_t block, uint8x16_t *expkey)
{
	block = aes_enc_rnd(block, expkey[0]);
    block = aes_enc_rnd(block, expkey[1]);
    block = aes_enc_rnd(block, expkey[2]);
    block = aes_enc_rnd(block, expkey[3]);
    block = aes_enc_rnd(block, expkey[4]);
    block = aes_enc_rnd(block, expkey[5]);
    block = aes_enc_rnd(block, expkey[6]);
    block = aes_enc_rnd(block, expkey[7]);
    block = aes_enc_rnd(block, expkey[8]);
    block = vaeseq_u8(block, expkey[9]);   
	return veorq_u8(block, expkey[10]);
}

void aes_ecb(struct Message *M, int k, const char *expkey)
{
	uint8x16_t block;
	for (int i = 0; i < k; i++){
		for (int j = 0; j < M[i].l; j++){
			block = vld1q_u8(&((uint8_t*)M[i].M)[16*j]);
			block = aes_enc(block, (uint8x16_t *)expkey);
			vst1q_u8(&((uint8_t*)M[i].M)[16*j], block);
		}
	}
}

int main(void){
	cpu_set_t cpuset;
  	CPU_ZERO(&cpuset); CPU_SET(7, &cpuset);
  	if (sched_setaffinity(getpid(), sizeof cpuset, &cpuset) != 0) perror("setaffinity");

	// corresponding expanded key
	unsigned char expkey[11*16] = {
		0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c,
		0xa0,0xfa,0xfe,0x17,0x88,0x54,0x2c,0xb1,0x23,0xa3,0x39,0x39,0x2a,0x6c,0x76,0x05,
		0xf2,0xc2,0x95,0xf2,0x7a,0x96,0xb9,0x43,0x59,0x35,0x80,0x7a,0x73,0x59,0xf6,0x7f,
		0x3d,0x80,0x47,0x7d,0x47,0x16,0xfe,0x3e,0x1e,0x23,0x7e,0x44,0x6d,0x7a,0x88,0x3b,
		0xef,0x44,0xa5,0x41,0xa8,0x52,0x5b,0x7f,0xb6,0x71,0x25,0x3b,0xdb,0x0b,0xad,0x00,
		0xd4,0xd1,0xc6,0xf8,0x7c,0x83,0x9d,0x87,0xca,0xf2,0xb8,0xbc,0x11,0xf9,0x15,0xbc,
		0x6d,0x88,0xa3,0x7a,0x11,0x0b,0x3e,0xfd,0xdb,0xf9,0x86,0x41,0xca,0x00,0x93,0xfd,
		0x4e,0x54,0xf7,0x0e,0x5f,0x5f,0xc9,0xf3,0x84,0xa6,0x4f,0xb2,0x4e,0xa6,0xdc,0x4f,
		0xea,0xd2,0x73,0x21,0xb5,0x8d,0xba,0xd2,0x31,0x2b,0xf5,0x60,0x7f,0x8d,0x29,0x2f,
		0xac,0x77,0x66,0xf3,0x19,0xfa,0xdc,0x21,0x28,0xd1,0x29,0x41,0x57,0x5c,0x00,0x6e,
		0xd0,0x14,0xf9,0xa8,0xc9,0xee,0x25,0x89,0xe1,0x3f,0x0c,0xc8,0xb6,0x63,0x0c,0xa6
	};

	// NIST test message (4 blocks)
	srand(time(NULL));

	unsigned char message0[1*128];
	for(int i = 0; i < 128*1; i++){ message0[i] = random(); }
	struct Message m0 = { message0, 8 };
	unsigned char message1[1*128];
	for(int i = 0; i < 128*1; i++){ message1[i] = random(); }
	struct Message m1 = { message1, 8 };
	unsigned char message2[1*128];
	for(int i = 0; i < 128*1; i++){ message2[i] = random(); }
	struct Message m2 = { message2, 8 };
	unsigned char message3[16*128];
	for(int i = 0; i < 128*16; i++){ message3[i] = random(); }
	struct Message m3 = { message3, 128 };
	unsigned char message4[1*128];
	for(int i = 0; i < 128*1; i++){ message4[i] = random(); }
	struct Message m4 = { message4, 8 };
	unsigned char message5[1*128];
	for(int i = 0; i < 128*1; i++){ message5[i] = random(); }
	struct Message m5 = { message5, 8 };
	unsigned char message6[16*128];
	for(int i = 0; i < 128*16; i++){ message6[i] = random(); }
	struct Message m6 = { message6, 128 };
	unsigned char message7[14*128];
	for(int i = 0; i < 128*14; i++){ message7[i] = random(); }
	struct Message m7 = { message7, 112 };
	unsigned char message8[1*128];
	for(int i = 0; i < 128*1; i++){ message8[i] = random(); }
	struct Message m8 = { message8, 8 };
	unsigned char message9[1*128];
	for(int i = 0; i < 128*1; i++){ message9[i] = random(); }
	struct Message m9 = { message9, 8 };
	unsigned char message10[16*128];
	for(int i = 0; i < 128*16; i++){ message10[i] = random(); }
	struct Message m10 = { message10, 128 };
	unsigned char message11[1*128];
	for(int i = 0; i < 128*1; i++){ message11[i] = random(); }
	struct Message m11 = { message11, 8 };
	unsigned char message12[1*128];
	for(int i = 0; i < 128*1; i++){ message12[i] = random(); }
	struct Message m12 = { message12, 8 };
	unsigned char message13[1*128];
	for(int i = 0; i < 128*1; i++){ message13[i] = random(); }
	struct Message m13 = { message13, 8 };
	unsigned char message14[16*128];
	for(int i = 0; i < 128*16; i++){ message14[i] = random(); }
	struct Message m14 = { message14, 128 };
	unsigned char message15[1*128];
	for(int i = 0; i < 128*1; i++){ message15[i] = random(); }
	struct Message m15 = { message15, 8 };
	unsigned char message16[8*128];
	for(int i = 0; i < 128*8; i++){ message16[i] = random(); }
	struct Message m16 = { message16, 64 };
	unsigned char message17[6*128];
	for(int i = 0; i < 128*6; i++){ message17[i] = random(); }
	struct Message m17 = { message17, 48 };
	unsigned char message18[4*128];
	for(int i = 0; i < 128*4; i++){ message18[i] = random(); }
	struct Message m18 = { message18, 32 };
	unsigned char message19[16*128];
	for(int i = 0; i < 128*16; i++){ message19[i] = random(); }
	struct Message m19 = { message19, 128 };
	unsigned char message20[16*128];
	for(int i = 0; i < 128*16; i++){ message20[i] = random(); }
	struct Message m20 = { message20, 128 };
	unsigned char message21[13*128];
	for(int i = 0; i < 128*13; i++){ message21[i] = random(); }
	struct Message m21 = { message21, 104 };
	unsigned char message22[1*128];
	for(int i = 0; i < 128*1; i++){ message22[i] = random(); }
	struct Message m22 = { message22, 8 };
	unsigned char message23[1*128];
	for(int i = 0; i < 128*1; i++){ message23[i] = random(); }
	struct Message m23 = { message23, 8 };
	unsigned char message24[1*128];
	for(int i = 0; i < 128*1; i++){ message24[i] = random(); }
	struct Message m24 = { message24, 8 };
	unsigned char message25[15*128];
	for(int i = 0; i < 128*15; i++){ message25[i] = random(); }
	struct Message m25 = { message25, 120 };
	unsigned char message26[1*128];
	for(int i = 0; i < 128*1; i++){ message26[i] = random(); }
	struct Message m26 = { message26, 8 };
	unsigned char message27[1*128];
	for(int i = 0; i < 128*1; i++){ message27[i] = random(); }
	struct Message m27 = { message27, 8 };
	unsigned char message28[1*128];
	for(int i = 0; i < 128*1; i++){ message28[i] = random(); }
	struct Message m28 = { message28, 8 };
	unsigned char message29[1*128];
	for(int i = 0; i < 128*1; i++){ message29[i] = random(); }
	struct Message m29 = { message29, 8 };
	unsigned char message30[1*128];
	for(int i = 0; i < 128*1; i++){ message30[i] = random(); }
	struct Message m30 = { message30, 8 };
	unsigned char message31[1*128];
	for(int i = 0; i < 128*1; i++){ message31[i] = random(); }
	struct Message m31 = { message31, 8 };
	unsigned char message32[2*128];
	for(int i = 0; i < 128*2; i++){ message32[i] = random(); }
	struct Message m32 = { message32, 16 };
	unsigned char message33[1*128];
	for(int i = 0; i < 128*1; i++){ message33[i] = random(); }
	struct Message m33 = { message33, 8 };
	unsigned char message34[4*128];
	for(int i = 0; i < 128*4; i++){ message34[i] = random(); }
	struct Message m34 = { message34, 32 };
	unsigned char message35[14*128];
	for(int i = 0; i < 128*14; i++){ message35[i] = random(); }
	struct Message m35 = { message35, 112 };
	unsigned char message36[1*128];
	for(int i = 0; i < 128*1; i++){ message36[i] = random(); }
	struct Message m36 = { message36, 8 };
	unsigned char message37[16*128];
	for(int i = 0; i < 128*16; i++){ message37[i] = random(); }
	struct Message m37 = { message37, 128 };
	unsigned char message38[3*128];
	for(int i = 0; i < 128*3; i++){ message38[i] = random(); }
	struct Message m38 = { message38, 24 };
	unsigned char message39[1*128];
	for(int i = 0; i < 128*1; i++){ message39[i] = random(); }
	struct Message m39 = { message39, 8 };
	unsigned char message40[15*128];
	for(int i = 0; i < 128*15; i++){ message40[i] = random(); }
	struct Message m40 = { message40, 120 };
	unsigned char message41[16*128];
	for(int i = 0; i < 128*16; i++){ message41[i] = random(); }
	struct Message m41 = { message41, 128 };
	unsigned char message42[15*128];
	for(int i = 0; i < 128*15; i++){ message42[i] = random(); }
	struct Message m42 = { message42, 120 };
	unsigned char message43[1*128];
	for(int i = 0; i < 128*1; i++){ message43[i] = random(); }
	struct Message m43 = { message43, 8 };
	unsigned char message44[1*128];
	for(int i = 0; i < 128*1; i++){ message44[i] = random(); }
	struct Message m44 = { message44, 8 };
	unsigned char message45[12*128];
	for(int i = 0; i < 128*12; i++){ message45[i] = random(); }
	struct Message m45 = { message45, 96 };
	unsigned char message46[1*128];
	for(int i = 0; i < 128*1; i++){ message46[i] = random(); }
	struct Message m46 = { message46, 8 };
	unsigned char message47[2*128];
	for(int i = 0; i < 128*2; i++){ message47[i] = random(); }
	struct Message m47 = { message47, 16 };
	unsigned char message48[1*128];
	for(int i = 0; i < 128*1; i++){ message48[i] = random(); }
	struct Message m48 = { message48, 8 };
	unsigned char message49[1*128];
	for(int i = 0; i < 128*1; i++){ message49[i] = random(); }
	struct Message m49 = { message49, 8 };
	unsigned char message50[14*128];
	for(int i = 0; i < 128*14; i++){ message50[i] = random(); }
	struct Message m50 = { message50, 112 };
	unsigned char message51[1*128];
	for(int i = 0; i < 128*1; i++){ message51[i] = random(); }
	struct Message m51 = { message51, 8 };
	unsigned char message52[16*128];
	for(int i = 0; i < 128*16; i++){ message52[i] = random(); }
	struct Message m52 = { message52, 128 };
	unsigned char message53[15*128];
	for(int i = 0; i < 128*15; i++){ message53[i] = random(); }
	struct Message m53 = { message53, 120 };
	unsigned char message54[13*128];
	for(int i = 0; i < 128*13; i++){ message54[i] = random(); }
	struct Message m54 = { message54, 104 };
	unsigned char message55[1*128];
	for(int i = 0; i < 128*1; i++){ message55[i] = random(); }
	struct Message m55 = { message55, 8 };
	unsigned char message56[1*128];
	for(int i = 0; i < 128*1; i++){ message56[i] = random(); }
	struct Message m56 = { message56, 8 };
	unsigned char message57[1*128];
	for(int i = 0; i < 128*1; i++){ message57[i] = random(); }
	struct Message m57 = { message57, 8 };
	unsigned char message58[1*128];
	for(int i = 0; i < 128*1; i++){ message58[i] = random(); }
	struct Message m58 = { message58, 8 };
	unsigned char message59[16*128];
	for(int i = 0; i < 128*16; i++){ message59[i] = random(); }
	struct Message m59 = { message59, 128 };
	unsigned char message60[1*128];
	for(int i = 0; i < 128*1; i++){ message60[i] = random(); }
	struct Message m60 = { message60, 8 };
	unsigned char message61[1*128];
	for(int i = 0; i < 128*1; i++){ message61[i] = random(); }
	struct Message m61 = { message61, 8 };
	unsigned char message62[13*128];
	for(int i = 0; i < 128*13; i++){ message62[i] = random(); }
	struct Message m62 = { message62, 104 };
	unsigned char message63[1*128];
	for(int i = 0; i < 128*1; i++){ message63[i] = random(); }
	struct Message m63 = { message63, 8 };
	unsigned char message64[1*128];
	for(int i = 0; i < 128*1; i++){ message64[i] = random(); }
	struct Message m64 = { message64, 8 };
	unsigned char message65[13*128];
	for(int i = 0; i < 128*13; i++){ message65[i] = random(); }
	struct Message m65 = { message65, 104 };
	unsigned char message66[16*128];
	for(int i = 0; i < 128*16; i++){ message66[i] = random(); }
	struct Message m66 = { message66, 128 };
	unsigned char message67[1*128];
	for(int i = 0; i < 128*1; i++){ message67[i] = random(); }
	struct Message m67 = { message67, 8 };
	unsigned char message68[13*128];
	for(int i = 0; i < 128*13; i++){ message68[i] = random(); }
	struct Message m68 = { message68, 104 };
	unsigned char message69[1*128];
	for(int i = 0; i < 128*1; i++){ message69[i] = random(); }
	struct Message m69 = { message69, 8 };
	unsigned char message70[13*128];
	for(int i = 0; i < 128*13; i++){ message70[i] = random(); }
	struct Message m70 = { message70, 104 };
	unsigned char message71[15*128];
	for(int i = 0; i < 128*15; i++){ message71[i] = random(); }
	struct Message m71 = { message71, 120 };
	unsigned char message72[1*128];
	for(int i = 0; i < 128*1; i++){ message72[i] = random(); }
	struct Message m72 = { message72, 8 };
	unsigned char message73[1*128];
	for(int i = 0; i < 128*1; i++){ message73[i] = random(); }
	struct Message m73 = { message73, 8 };
	unsigned char message74[1*128];
	for(int i = 0; i < 128*1; i++){ message74[i] = random(); }
	struct Message m74 = { message74, 8 };
	unsigned char message75[4*128];
	for(int i = 0; i < 128*4; i++){ message75[i] = random(); }
	struct Message m75 = { message75, 32 };
	unsigned char message76[1*128];
	for(int i = 0; i < 128*1; i++){ message76[i] = random(); }
	struct Message m76 = { message76, 8 };
	unsigned char message77[16*128];
	for(int i = 0; i < 128*16; i++){ message77[i] = random(); }
	struct Message m77 = { message77, 128 };
	unsigned char message78[1*128];
	for(int i = 0; i < 128*1; i++){ message78[i] = random(); }
	struct Message m78 = { message78, 8 };
	unsigned char message79[15*128];
	for(int i = 0; i < 128*15; i++){ message79[i] = random(); }
	struct Message m79 = { message79, 120 };
	unsigned char message80[1*128];
	for(int i = 0; i < 128*1; i++){ message80[i] = random(); }
	struct Message m80 = { message80, 8 };
	unsigned char message81[13*128];
	for(int i = 0; i < 128*13; i++){ message81[i] = random(); }
	struct Message m81 = { message81, 104 };
	unsigned char message82[2*128];
	for(int i = 0; i < 128*2; i++){ message82[i] = random(); }
	struct Message m82 = { message82, 16 };
	unsigned char message83[15*128];
	for(int i = 0; i < 128*15; i++){ message83[i] = random(); }
	struct Message m83 = { message83, 120 };
	unsigned char message84[1*128];
	for(int i = 0; i < 128*1; i++){ message84[i] = random(); }
	struct Message m84 = { message84, 8 };
	unsigned char message85[1*128];
	for(int i = 0; i < 128*1; i++){ message85[i] = random(); }
	struct Message m85 = { message85, 8 };
	unsigned char message86[16*128];
	for(int i = 0; i < 128*16; i++){ message86[i] = random(); }
	struct Message m86 = { message86, 128 };
	unsigned char message87[1*128];
	for(int i = 0; i < 128*1; i++){ message87[i] = random(); }
	struct Message m87 = { message87, 8 };
	unsigned char message88[1*128];
	for(int i = 0; i < 128*1; i++){ message88[i] = random(); }
	struct Message m88 = { message88, 8 };
	unsigned char message89[16*128];
	for(int i = 0; i < 128*16; i++){ message89[i] = random(); }
	struct Message m89 = { message89, 128 };
	unsigned char message90[1*128];
	for(int i = 0; i < 128*1; i++){ message90[i] = random(); }
	struct Message m90 = { message90, 8 };
	unsigned char message91[1*128];
	for(int i = 0; i < 128*1; i++){ message91[i] = random(); }
	struct Message m91 = { message91, 8 };
	unsigned char message92[1*128];
	for(int i = 0; i < 128*1; i++){ message92[i] = random(); }
	struct Message m92 = { message92, 8 };
	unsigned char message93[16*128];
	for(int i = 0; i < 128*16; i++){ message93[i] = random(); }
	struct Message m93 = { message93, 128 };
	unsigned char message94[15*128];
	for(int i = 0; i < 128*15; i++){ message94[i] = random(); }
	struct Message m94 = { message94, 120 };
	unsigned char message95[1*128];
	for(int i = 0; i < 128*1; i++){ message95[i] = random(); }
	struct Message m95 = { message95, 8 };
	unsigned char message96[16*128];
	for(int i = 0; i < 128*16; i++){ message96[i] = random(); }
	struct Message m96 = { message96, 128 };
	unsigned char message97[15*128];
	for(int i = 0; i < 128*15; i++){ message97[i] = random(); }
	struct Message m97 = { message97, 120 };
	unsigned char message98[16*128];
	for(int i = 0; i < 128*16; i++){ message98[i] = random(); }
	struct Message m98 = { message98, 128 };
	unsigned char message99[1*128];
	for(int i = 0; i < 128*1; i++){ message99[i] = random(); }
	struct Message m99 = { message99, 8 };
	unsigned char message100[15*128];
	for(int i = 0; i < 128*15; i++){ message100[i] = random(); }
	struct Message m100 = { message100, 120 };
	unsigned char message101[1*128];
	for(int i = 0; i < 128*1; i++){ message101[i] = random(); }
	struct Message m101 = { message101, 8 };
	unsigned char message102[13*128];
	for(int i = 0; i < 128*13; i++){ message102[i] = random(); }
	struct Message m102 = { message102, 104 };
	unsigned char message103[1*128];
	for(int i = 0; i < 128*1; i++){ message103[i] = random(); }
	struct Message m103 = { message103, 8 };
	unsigned char message104[15*128];
	for(int i = 0; i < 128*15; i++){ message104[i] = random(); }
	struct Message m104 = { message104, 120 };
	unsigned char message105[6*128];
	for(int i = 0; i < 128*6; i++){ message105[i] = random(); }
	struct Message m105 = { message105, 48 };
	unsigned char message106[1*128];
	for(int i = 0; i < 128*1; i++){ message106[i] = random(); }
	struct Message m106 = { message106, 8 };
	unsigned char message107[1*128];
	for(int i = 0; i < 128*1; i++){ message107[i] = random(); }
	struct Message m107 = { message107, 8 };
	unsigned char message108[1*128];
	for(int i = 0; i < 128*1; i++){ message108[i] = random(); }
	struct Message m108 = { message108, 8 };
	unsigned char message109[16*128];
	for(int i = 0; i < 128*16; i++){ message109[i] = random(); }
	struct Message m109 = { message109, 128 };
	unsigned char message110[16*128];
	for(int i = 0; i < 128*16; i++){ message110[i] = random(); }
	struct Message m110 = { message110, 128 };
	unsigned char message111[12*128];
	for(int i = 0; i < 128*12; i++){ message111[i] = random(); }
	struct Message m111 = { message111, 96 };
	unsigned char message112[1*128];
	for(int i = 0; i < 128*1; i++){ message112[i] = random(); }
	struct Message m112 = { message112, 8 };
	unsigned char message113[16*128];
	for(int i = 0; i < 128*16; i++){ message113[i] = random(); }
	struct Message m113 = { message113, 128 };
	unsigned char message114[1*128];
	for(int i = 0; i < 128*1; i++){ message114[i] = random(); }
	struct Message m114 = { message114, 8 };
	unsigned char message115[4*128];
	for(int i = 0; i < 128*4; i++){ message115[i] = random(); }
	struct Message m115 = { message115, 32 };
	unsigned char message116[3*128];
	for(int i = 0; i < 128*3; i++){ message116[i] = random(); }
	struct Message m116 = { message116, 24 };
	unsigned char message117[16*128];
	for(int i = 0; i < 128*16; i++){ message117[i] = random(); }
	struct Message m117 = { message117, 128 };
	unsigned char message118[16*128];
	for(int i = 0; i < 128*16; i++){ message118[i] = random(); }
	struct Message m118 = { message118, 128 };
	unsigned char message119[15*128];
	for(int i = 0; i < 128*15; i++){ message119[i] = random(); }
	struct Message m119 = { message119, 120 };
	unsigned char message120[13*128];
	for(int i = 0; i < 128*13; i++){ message120[i] = random(); }
	struct Message m120 = { message120, 104 };
	unsigned char message121[11*128];
	for(int i = 0; i < 128*11; i++){ message121[i] = random(); }
	struct Message m121 = { message121, 88 };
	unsigned char message122[1*128];
	for(int i = 0; i < 128*1; i++){ message122[i] = random(); }
	struct Message m122 = { message122, 8 };
	unsigned char message123[1*128];
	for(int i = 0; i < 128*1; i++){ message123[i] = random(); }
	struct Message m123 = { message123, 8 };
	unsigned char message124[7*128];
	for(int i = 0; i < 128*7; i++){ message124[i] = random(); }
	struct Message m124 = { message124, 56 };
	unsigned char message125[1*128];
	for(int i = 0; i < 128*1; i++){ message125[i] = random(); }
	struct Message m125 = { message125, 8 };
	unsigned char message126[4*128];
	for(int i = 0; i < 128*4; i++){ message126[i] = random(); }
	struct Message m126 = { message126, 32 };
	unsigned char message127[1*128];
	for(int i = 0; i < 128*1; i++){ message127[i] = random(); }
	struct Message m127 = { message127, 8 };
	unsigned char message128[14*128];
	for(int i = 0; i < 128*14; i++){ message128[i] = random(); }
	struct Message m128 = { message128, 112 };
	unsigned char message129[1*128];
	for(int i = 0; i < 128*1; i++){ message129[i] = random(); }
	struct Message m129 = { message129, 8 };
	unsigned char message130[16*128];
	for(int i = 0; i < 128*16; i++){ message130[i] = random(); }
	struct Message m130 = { message130, 128 };
	unsigned char message131[16*128];
	for(int i = 0; i < 128*16; i++){ message131[i] = random(); }
	struct Message m131 = { message131, 128 };
	unsigned char message132[1*128];
	for(int i = 0; i < 128*1; i++){ message132[i] = random(); }
	struct Message m132 = { message132, 8 };
	unsigned char message133[13*128];
	for(int i = 0; i < 128*13; i++){ message133[i] = random(); }
	struct Message m133 = { message133, 104 };
	unsigned char message134[13*128];
	for(int i = 0; i < 128*13; i++){ message134[i] = random(); }
	struct Message m134 = { message134, 104 };
	unsigned char message135[13*128];
	for(int i = 0; i < 128*13; i++){ message135[i] = random(); }
	struct Message m135 = { message135, 104 };
	unsigned char message136[1*128];
	for(int i = 0; i < 128*1; i++){ message136[i] = random(); }
	struct Message m136 = { message136, 8 };
	unsigned char message137[1*128];
	for(int i = 0; i < 128*1; i++){ message137[i] = random(); }
	struct Message m137 = { message137, 8 };
	unsigned char message138[16*128];
	for(int i = 0; i < 128*16; i++){ message138[i] = random(); }
	struct Message m138 = { message138, 128 };
	unsigned char message139[1*128];
	for(int i = 0; i < 128*1; i++){ message139[i] = random(); }
	struct Message m139 = { message139, 8 };
	unsigned char message140[1*128];
	for(int i = 0; i < 128*1; i++){ message140[i] = random(); }
	struct Message m140 = { message140, 8 };
	unsigned char message141[11*128];
	for(int i = 0; i < 128*11; i++){ message141[i] = random(); }
	struct Message m141 = { message141, 88 };
	unsigned char message142[5*128];
	for(int i = 0; i < 128*5; i++){ message142[i] = random(); }
	struct Message m142 = { message142, 40 };
	unsigned char message143[1*128];
	for(int i = 0; i < 128*1; i++){ message143[i] = random(); }
	struct Message m143 = { message143, 8 };
	unsigned char message144[12*128];
	for(int i = 0; i < 128*12; i++){ message144[i] = random(); }
	struct Message m144 = { message144, 96 };
	unsigned char message145[1*128];
	for(int i = 0; i < 128*1; i++){ message145[i] = random(); }
	struct Message m145 = { message145, 8 };
	unsigned char message146[10*128];
	for(int i = 0; i < 128*10; i++){ message146[i] = random(); }
	struct Message m146 = { message146, 80 };
	unsigned char message147[14*128];
	for(int i = 0; i < 128*14; i++){ message147[i] = random(); }
	struct Message m147 = { message147, 112 };
	unsigned char message148[15*128];
	for(int i = 0; i < 128*15; i++){ message148[i] = random(); }
	struct Message m148 = { message148, 120 };
	unsigned char message149[1*128];
	for(int i = 0; i < 128*1; i++){ message149[i] = random(); }
	struct Message m149 = { message149, 8 };
	unsigned char message150[1*128];
	for(int i = 0; i < 128*1; i++){ message150[i] = random(); }
	struct Message m150 = { message150, 8 };
	unsigned char message151[13*128];
	for(int i = 0; i < 128*13; i++){ message151[i] = random(); }
	struct Message m151 = { message151, 104 };
	unsigned char message152[1*128];
	for(int i = 0; i < 128*1; i++){ message152[i] = random(); }
	struct Message m152 = { message152, 8 };
	unsigned char message153[16*128];
	for(int i = 0; i < 128*16; i++){ message153[i] = random(); }
	struct Message m153 = { message153, 128 };
	unsigned char message154[1*128];
	for(int i = 0; i < 128*1; i++){ message154[i] = random(); }
	struct Message m154 = { message154, 8 };
	unsigned char message155[1*128];
	for(int i = 0; i < 128*1; i++){ message155[i] = random(); }
	struct Message m155 = { message155, 8 };
	unsigned char message156[1*128];
	for(int i = 0; i < 128*1; i++){ message156[i] = random(); }
	struct Message m156 = { message156, 8 };
	unsigned char message157[16*128];
	for(int i = 0; i < 128*16; i++){ message157[i] = random(); }
	struct Message m157 = { message157, 128 };
	unsigned char message158[1*128];
	for(int i = 0; i < 128*1; i++){ message158[i] = random(); }
	struct Message m158 = { message158, 8 };
	unsigned char message159[1*128];
	for(int i = 0; i < 128*1; i++){ message159[i] = random(); }
	struct Message m159 = { message159, 8 };
	unsigned char message160[1*128];
	for(int i = 0; i < 128*1; i++){ message160[i] = random(); }
	struct Message m160 = { message160, 8 };
	unsigned char message161[2*128];
	for(int i = 0; i < 128*2; i++){ message161[i] = random(); }
	struct Message m161 = { message161, 16 };
	unsigned char message162[1*128];
	for(int i = 0; i < 128*1; i++){ message162[i] = random(); }
	struct Message m162 = { message162, 8 };
	unsigned char message163[1*128];
	for(int i = 0; i < 128*1; i++){ message163[i] = random(); }
	struct Message m163 = { message163, 8 };
	unsigned char message164[1*128];
	for(int i = 0; i < 128*1; i++){ message164[i] = random(); }
	struct Message m164 = { message164, 8 };
	unsigned char message165[1*128];
	for(int i = 0; i < 128*1; i++){ message165[i] = random(); }
	struct Message m165 = { message165, 8 };
	unsigned char message166[1*128];
	for(int i = 0; i < 128*1; i++){ message166[i] = random(); }
	struct Message m166 = { message166, 8 };
	unsigned char message167[1*128];
	for(int i = 0; i < 128*1; i++){ message167[i] = random(); }
	struct Message m167 = { message167, 8 };
	unsigned char message168[16*128];
	for(int i = 0; i < 128*16; i++){ message168[i] = random(); }
	struct Message m168 = { message168, 128 };
	unsigned char message169[3*128];
	for(int i = 0; i < 128*3; i++){ message169[i] = random(); }
	struct Message m169 = { message169, 24 };
	unsigned char message170[1*128];
	for(int i = 0; i < 128*1; i++){ message170[i] = random(); }
	struct Message m170 = { message170, 8 };
	unsigned char message171[1*128];
	for(int i = 0; i < 128*1; i++){ message171[i] = random(); }
	struct Message m171 = { message171, 8 };
	unsigned char message172[1*128];
	for(int i = 0; i < 128*1; i++){ message172[i] = random(); }
	struct Message m172 = { message172, 8 };
	unsigned char message173[1*128];
	for(int i = 0; i < 128*1; i++){ message173[i] = random(); }
	struct Message m173 = { message173, 8 };
	unsigned char message174[3*128];
	for(int i = 0; i < 128*3; i++){ message174[i] = random(); }
	struct Message m174 = { message174, 24 };
	unsigned char message175[2*128];
	for(int i = 0; i < 128*2; i++){ message175[i] = random(); }
	struct Message m175 = { message175, 16 };
	unsigned char message176[1*128];
	for(int i = 0; i < 128*1; i++){ message176[i] = random(); }
	struct Message m176 = { message176, 8 };
	unsigned char message177[1*128];
	for(int i = 0; i < 128*1; i++){ message177[i] = random(); }
	struct Message m177 = { message177, 8 };
	unsigned char message178[1*128];
	for(int i = 0; i < 128*1; i++){ message178[i] = random(); }
	struct Message m178 = { message178, 8 };
	unsigned char message179[1*128];
	for(int i = 0; i < 128*1; i++){ message179[i] = random(); }
	struct Message m179 = { message179, 8 };
	unsigned char message180[16*128];
	for(int i = 0; i < 128*16; i++){ message180[i] = random(); }
	struct Message m180 = { message180, 128 };
	unsigned char message181[16*128];
	for(int i = 0; i < 128*16; i++){ message181[i] = random(); }
	struct Message m181 = { message181, 128 };
	unsigned char message182[16*128];
	for(int i = 0; i < 128*16; i++){ message182[i] = random(); }
	struct Message m182 = { message182, 128 };
	unsigned char message183[13*128];
	for(int i = 0; i < 128*13; i++){ message183[i] = random(); }
	struct Message m183 = { message183, 104 };
	unsigned char message184[16*128];
	for(int i = 0; i < 128*16; i++){ message184[i] = random(); }
	struct Message m184 = { message184, 128 };
	unsigned char message185[16*128];
	for(int i = 0; i < 128*16; i++){ message185[i] = random(); }
	struct Message m185 = { message185, 128 };
	unsigned char message186[1*128];
	for(int i = 0; i < 128*1; i++){ message186[i] = random(); }
	struct Message m186 = { message186, 8 };
	unsigned char message187[1*128];
	for(int i = 0; i < 128*1; i++){ message187[i] = random(); }
	struct Message m187 = { message187, 8 };
	unsigned char message188[1*128];
	for(int i = 0; i < 128*1; i++){ message188[i] = random(); }
	struct Message m188 = { message188, 8 };
	unsigned char message189[1*128];
	for(int i = 0; i < 128*1; i++){ message189[i] = random(); }
	struct Message m189 = { message189, 8 };
	unsigned char message190[1*128];
	for(int i = 0; i < 128*1; i++){ message190[i] = random(); }
	struct Message m190 = { message190, 8 };
	unsigned char message191[15*128];
	for(int i = 0; i < 128*15; i++){ message191[i] = random(); }
	struct Message m191 = { message191, 120 };
	unsigned char message192[16*128];
	for(int i = 0; i < 128*16; i++){ message192[i] = random(); }
	struct Message m192 = { message192, 128 };
	unsigned char message193[13*128];
	for(int i = 0; i < 128*13; i++){ message193[i] = random(); }
	struct Message m193 = { message193, 104 };
	unsigned char message194[2*128];
	for(int i = 0; i < 128*2; i++){ message194[i] = random(); }
	struct Message m194 = { message194, 16 };
	unsigned char message195[15*128];
	for(int i = 0; i < 128*15; i++){ message195[i] = random(); }
	struct Message m195 = { message195, 120 };
	unsigned char message196[1*128];
	for(int i = 0; i < 128*1; i++){ message196[i] = random(); }
	struct Message m196 = { message196, 8 };
	unsigned char message197[14*128];
	for(int i = 0; i < 128*14; i++){ message197[i] = random(); }
	struct Message m197 = { message197, 112 };
	unsigned char message198[1*128];
	for(int i = 0; i < 128*1; i++){ message198[i] = random(); }
	struct Message m198 = { message198, 8 };
	unsigned char message199[16*128];
	for(int i = 0; i < 128*16; i++){ message199[i] = random(); }
	struct Message m199 = { message199, 128 };
	unsigned char message200[13*128];
	for(int i = 0; i < 128*13; i++){ message200[i] = random(); }
	struct Message m200 = { message200, 104 };
	unsigned char message201[1*128];
	for(int i = 0; i < 128*1; i++){ message201[i] = random(); }
	struct Message m201 = { message201, 8 };
	unsigned char message202[6*128];
	for(int i = 0; i < 128*6; i++){ message202[i] = random(); }
	struct Message m202 = { message202, 48 };
	unsigned char message203[1*128];
	for(int i = 0; i < 128*1; i++){ message203[i] = random(); }
	struct Message m203 = { message203, 8 };
	unsigned char message204[1*128];
	for(int i = 0; i < 128*1; i++){ message204[i] = random(); }
	struct Message m204 = { message204, 8 };
	unsigned char message205[15*128];
	for(int i = 0; i < 128*15; i++){ message205[i] = random(); }
	struct Message m205 = { message205, 120 };
	unsigned char message206[6*128];
	for(int i = 0; i < 128*6; i++){ message206[i] = random(); }
	struct Message m206 = { message206, 48 };
	unsigned char message207[1*128];
	for(int i = 0; i < 128*1; i++){ message207[i] = random(); }
	struct Message m207 = { message207, 8 };
	unsigned char message208[16*128];
	for(int i = 0; i < 128*16; i++){ message208[i] = random(); }
	struct Message m208 = { message208, 128 };
	unsigned char message209[16*128];
	for(int i = 0; i < 128*16; i++){ message209[i] = random(); }
	struct Message m209 = { message209, 128 };
	unsigned char message210[16*128];
	for(int i = 0; i < 128*16; i++){ message210[i] = random(); }
	struct Message m210 = { message210, 128 };
	unsigned char message211[16*128];
	for(int i = 0; i < 128*16; i++){ message211[i] = random(); }
	struct Message m211 = { message211, 128 };
	unsigned char message212[15*128];
	for(int i = 0; i < 128*15; i++){ message212[i] = random(); }
	struct Message m212 = { message212, 120 };
	unsigned char message213[16*128];
	for(int i = 0; i < 128*16; i++){ message213[i] = random(); }
	struct Message m213 = { message213, 128 };
	unsigned char message214[16*128];
	for(int i = 0; i < 128*16; i++){ message214[i] = random(); }
	struct Message m214 = { message214, 128 };
	unsigned char message215[1*128];
	for(int i = 0; i < 128*1; i++){ message215[i] = random(); }
	struct Message m215 = { message215, 8 };
	unsigned char message216[14*128];
	for(int i = 0; i < 128*14; i++){ message216[i] = random(); }
	struct Message m216 = { message216, 112 };
	unsigned char message217[16*128];
	for(int i = 0; i < 128*16; i++){ message217[i] = random(); }
	struct Message m217 = { message217, 128 };
	unsigned char message218[15*128];
	for(int i = 0; i < 128*15; i++){ message218[i] = random(); }
	struct Message m218 = { message218, 120 };
	unsigned char message219[2*128];
	for(int i = 0; i < 128*2; i++){ message219[i] = random(); }
	struct Message m219 = { message219, 16 };
	unsigned char message220[1*128];
	for(int i = 0; i < 128*1; i++){ message220[i] = random(); }
	struct Message m220 = { message220, 8 };
	unsigned char message221[13*128];
	for(int i = 0; i < 128*13; i++){ message221[i] = random(); }
	struct Message m221 = { message221, 104 };
	unsigned char message222[13*128];
	for(int i = 0; i < 128*13; i++){ message222[i] = random(); }
	struct Message m222 = { message222, 104 };
	unsigned char message223[15*128];
	for(int i = 0; i < 128*15; i++){ message223[i] = random(); }
	struct Message m223 = { message223, 120 };
	unsigned char message224[2*128];
	for(int i = 0; i < 128*2; i++){ message224[i] = random(); }
	struct Message m224 = { message224, 16 };
	unsigned char message225[13*128];
	for(int i = 0; i < 128*13; i++){ message225[i] = random(); }
	struct Message m225 = { message225, 104 };
	unsigned char message226[9*128];
	for(int i = 0; i < 128*9; i++){ message226[i] = random(); }
	struct Message m226 = { message226, 72 };
	unsigned char message227[15*128];
	for(int i = 0; i < 128*15; i++){ message227[i] = random(); }
	struct Message m227 = { message227, 120 };
	unsigned char message228[16*128];
	for(int i = 0; i < 128*16; i++){ message228[i] = random(); }
	struct Message m228 = { message228, 128 };
	unsigned char message229[16*128];
	for(int i = 0; i < 128*16; i++){ message229[i] = random(); }
	struct Message m229 = { message229, 128 };
	unsigned char message230[16*128];
	for(int i = 0; i < 128*16; i++){ message230[i] = random(); }
	struct Message m230 = { message230, 128 };
	unsigned char message231[2*128];
	for(int i = 0; i < 128*2; i++){ message231[i] = random(); }
	struct Message m231 = { message231, 16 };
	unsigned char message232[16*128];
	for(int i = 0; i < 128*16; i++){ message232[i] = random(); }
	struct Message m232 = { message232, 128 };
	unsigned char message233[1*128];
	for(int i = 0; i < 128*1; i++){ message233[i] = random(); }
	struct Message m233 = { message233, 8 };
	unsigned char message234[15*128];
	for(int i = 0; i < 128*15; i++){ message234[i] = random(); }
	struct Message m234 = { message234, 120 };
	unsigned char message235[15*128];
	for(int i = 0; i < 128*15; i++){ message235[i] = random(); }
	struct Message m235 = { message235, 120 };
	unsigned char message236[11*128];
	for(int i = 0; i < 128*11; i++){ message236[i] = random(); }
	struct Message m236 = { message236, 88 };
	unsigned char message237[16*128];
	for(int i = 0; i < 128*16; i++){ message237[i] = random(); }
	struct Message m237 = { message237, 128 };
	unsigned char message238[1*128];
	for(int i = 0; i < 128*1; i++){ message238[i] = random(); }
	struct Message m238 = { message238, 8 };
	unsigned char message239[16*128];
	for(int i = 0; i < 128*16; i++){ message239[i] = random(); }
	struct Message m239 = { message239, 128 };
	unsigned char message240[15*128];
	for(int i = 0; i < 128*15; i++){ message240[i] = random(); }
	struct Message m240 = { message240, 120 };
	unsigned char message241[15*128];
	for(int i = 0; i < 128*15; i++){ message241[i] = random(); }
	struct Message m241 = { message241, 120 };
	unsigned char message242[1*128];
	for(int i = 0; i < 128*1; i++){ message242[i] = random(); }
	struct Message m242 = { message242, 8 };
	unsigned char message243[16*128];
	for(int i = 0; i < 128*16; i++){ message243[i] = random(); }
	struct Message m243 = { message243, 128 };
	unsigned char message244[1*128];
	for(int i = 0; i < 128*1; i++){ message244[i] = random(); }
	struct Message m244 = { message244, 8 };
	unsigned char message245[1*128];
	for(int i = 0; i < 128*1; i++){ message245[i] = random(); }
	struct Message m245 = { message245, 8 };
	unsigned char message246[3*128];
	for(int i = 0; i < 128*3; i++){ message246[i] = random(); }
	struct Message m246 = { message246, 24 };
	unsigned char message247[1*128];
	for(int i = 0; i < 128*1; i++){ message247[i] = random(); }
	struct Message m247 = { message247, 8 };
	unsigned char message248[16*128];
	for(int i = 0; i < 128*16; i++){ message248[i] = random(); }
	struct Message m248 = { message248, 128 };
	unsigned char message249[13*128];
	for(int i = 0; i < 128*13; i++){ message249[i] = random(); }
	struct Message m249 = { message249, 104 };
	unsigned char message250[16*128];
	for(int i = 0; i < 128*16; i++){ message250[i] = random(); }
	struct Message m250 = { message250, 128 };
	unsigned char message251[1*128];
	for(int i = 0; i < 128*1; i++){ message251[i] = random(); }
	struct Message m251 = { message251, 8 };
	unsigned char message252[1*128];
	for(int i = 0; i < 128*1; i++){ message252[i] = random(); }
	struct Message m252 = { message252, 8 };
	unsigned char message253[1*128];
	for(int i = 0; i < 128*1; i++){ message253[i] = random(); }
	struct Message m253 = { message253, 8 };
	unsigned char message254[13*128];
	for(int i = 0; i < 128*13; i++){ message254[i] = random(); }
	struct Message m254 = { message254, 104 };
	unsigned char message255[1*128];
	for(int i = 0; i < 128*1; i++){ message255[i] = random(); }
	struct Message m255 = { message255, 8 };
	unsigned char message256[15*128];
	for(int i = 0; i < 128*15; i++){ message256[i] = random(); }
	struct Message m256 = { message256, 120 };
	unsigned char message257[16*128];
	for(int i = 0; i < 128*16; i++){ message257[i] = random(); }
	struct Message m257 = { message257, 128 };
	unsigned char message258[1*128];
	for(int i = 0; i < 128*1; i++){ message258[i] = random(); }
	struct Message m258 = { message258, 8 };
	unsigned char message259[16*128];
	for(int i = 0; i < 128*16; i++){ message259[i] = random(); }
	struct Message m259 = { message259, 128 };
	unsigned char message260[15*128];
	for(int i = 0; i < 128*15; i++){ message260[i] = random(); }
	struct Message m260 = { message260, 120 };
	unsigned char message261[1*128];
	for(int i = 0; i < 128*1; i++){ message261[i] = random(); }
	struct Message m261 = { message261, 8 };
	unsigned char message262[5*128];
	for(int i = 0; i < 128*5; i++){ message262[i] = random(); }
	struct Message m262 = { message262, 40 };
	unsigned char message263[1*128];
	for(int i = 0; i < 128*1; i++){ message263[i] = random(); }
	struct Message m263 = { message263, 8 };
	unsigned char message264[1*128];
	for(int i = 0; i < 128*1; i++){ message264[i] = random(); }
	struct Message m264 = { message264, 8 };
	unsigned char message265[1*128];
	for(int i = 0; i < 128*1; i++){ message265[i] = random(); }
	struct Message m265 = { message265, 8 };
	unsigned char message266[11*128];
	for(int i = 0; i < 128*11; i++){ message266[i] = random(); }
	struct Message m266 = { message266, 88 };
	unsigned char message267[1*128];
	for(int i = 0; i < 128*1; i++){ message267[i] = random(); }
	struct Message m267 = { message267, 8 };
	unsigned char message268[16*128];
	for(int i = 0; i < 128*16; i++){ message268[i] = random(); }
	struct Message m268 = { message268, 128 };
	unsigned char message269[1*128];
	for(int i = 0; i < 128*1; i++){ message269[i] = random(); }
	struct Message m269 = { message269, 8 };
	unsigned char message270[1*128];
	for(int i = 0; i < 128*1; i++){ message270[i] = random(); }
	struct Message m270 = { message270, 8 };
	unsigned char message271[1*128];
	for(int i = 0; i < 128*1; i++){ message271[i] = random(); }
	struct Message m271 = { message271, 8 };
	unsigned char message272[1*128];
	for(int i = 0; i < 128*1; i++){ message272[i] = random(); }
	struct Message m272 = { message272, 8 };
	unsigned char message273[1*128];
	for(int i = 0; i < 128*1; i++){ message273[i] = random(); }
	struct Message m273 = { message273, 8 };
	unsigned char message274[1*128];
	for(int i = 0; i < 128*1; i++){ message274[i] = random(); }
	struct Message m274 = { message274, 8 };
	unsigned char message275[1*128];
	for(int i = 0; i < 128*1; i++){ message275[i] = random(); }
	struct Message m275 = { message275, 8 };
	unsigned char message276[16*128];
	for(int i = 0; i < 128*16; i++){ message276[i] = random(); }
	struct Message m276 = { message276, 128 };
	unsigned char message277[1*128];
	for(int i = 0; i < 128*1; i++){ message277[i] = random(); }
	struct Message m277 = { message277, 8 };
	unsigned char message278[1*128];
	for(int i = 0; i < 128*1; i++){ message278[i] = random(); }
	struct Message m278 = { message278, 8 };
	unsigned char message279[16*128];
	for(int i = 0; i < 128*16; i++){ message279[i] = random(); }
	struct Message m279 = { message279, 128 };
	unsigned char message280[1*128];
	for(int i = 0; i < 128*1; i++){ message280[i] = random(); }
	struct Message m280 = { message280, 8 };
	unsigned char message281[13*128];
	for(int i = 0; i < 128*13; i++){ message281[i] = random(); }
	struct Message m281 = { message281, 104 };
	unsigned char message282[1*128];
	for(int i = 0; i < 128*1; i++){ message282[i] = random(); }
	struct Message m282 = { message282, 8 };
	unsigned char message283[13*128];
	for(int i = 0; i < 128*13; i++){ message283[i] = random(); }
	struct Message m283 = { message283, 104 };
	unsigned char message284[16*128];
	for(int i = 0; i < 128*16; i++){ message284[i] = random(); }
	struct Message m284 = { message284, 128 };
	unsigned char message285[13*128];
	for(int i = 0; i < 128*13; i++){ message285[i] = random(); }
	struct Message m285 = { message285, 104 };
	unsigned char message286[1*128];
	for(int i = 0; i < 128*1; i++){ message286[i] = random(); }
	struct Message m286 = { message286, 8 };
	unsigned char message287[15*128];
	for(int i = 0; i < 128*15; i++){ message287[i] = random(); }
	struct Message m287 = { message287, 120 };
	unsigned char message288[1*128];
	for(int i = 0; i < 128*1; i++){ message288[i] = random(); }
	struct Message m288 = { message288, 8 };
	unsigned char message289[5*128];
	for(int i = 0; i < 128*5; i++){ message289[i] = random(); }
	struct Message m289 = { message289, 40 };
	unsigned char message290[2*128];
	for(int i = 0; i < 128*2; i++){ message290[i] = random(); }
	struct Message m290 = { message290, 16 };
	unsigned char message291[1*128];
	for(int i = 0; i < 128*1; i++){ message291[i] = random(); }
	struct Message m291 = { message291, 8 };
	unsigned char message292[13*128];
	for(int i = 0; i < 128*13; i++){ message292[i] = random(); }
	struct Message m292 = { message292, 104 };
	unsigned char message293[16*128];
	for(int i = 0; i < 128*16; i++){ message293[i] = random(); }
	struct Message m293 = { message293, 128 };
	unsigned char message294[16*128];
	for(int i = 0; i < 128*16; i++){ message294[i] = random(); }
	struct Message m294 = { message294, 128 };
	unsigned char message295[15*128];
	for(int i = 0; i < 128*15; i++){ message295[i] = random(); }
	struct Message m295 = { message295, 120 };
	unsigned char message296[15*128];
	for(int i = 0; i < 128*15; i++){ message296[i] = random(); }
	struct Message m296 = { message296, 120 };
	unsigned char message297[14*128];
	for(int i = 0; i < 128*14; i++){ message297[i] = random(); }
	struct Message m297 = { message297, 112 };
	unsigned char message298[1*128];
	for(int i = 0; i < 128*1; i++){ message298[i] = random(); }
	struct Message m298 = { message298, 8 };
	unsigned char message299[16*128];
	for(int i = 0; i < 128*16; i++){ message299[i] = random(); }

	struct Message m299 = { message299, 128 };
	struct Message M[300] = {m0,m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12,m13,m14,
		m15,m16,m17,m18,m19,m20,m21,m22,m23,m24,m25,m26,m27,m28,m29,m30,m31,m32,
		m33,m34,m35,m36,m37,m38,m39,m40,m41,m42,m43,m44,m45,m46,m47,m48,m49,m50,
		m51,m52,m53,m54,m55,m56,m57,m58,m59,m60,m61,m62,m63,m64,m65,m66,m67,m68,
		m69,m70,m71,m72,m73,m74,m75,m76,m77,m78,m79,m80,m81,m82,m83,m84,m85,m86,
		m87,m88,m89,m90,m91,m92,m93,m94,m95,m96,m97,m98,m99,m100,m101,m102,m103,
		m104,m105,m106,m107,m108,m109,m110,m111,m112,m113,m114,m115,m116,m117,m118,
		m119,m120,m121,m122,m123,m124,m125,m126,m127,m128,m129,m130,m131,m132,m133,
		m134,m135,m136,m137,m138,m139,m140,m141,m142,m143,m144,m145,m146,m147,m148,
		m149,m150,m151,m152,m153,m154,m155,m156,m157,m158,m159,m160,m161,m162,m163,
		m164,m165,m166,m167,m168,m169,m170,m171,m172,m173,m174,m175,m176,m177,m178,
		m179,m180,m181,m182,m183,m184,m185,m186,m187,m188,m189,m190,m191,m192,m193,
		m194,m195,m196,m197,m198,m199,m200,m201,m202,m203,m204,m205,m206,m207,m208,
		m209,m210,m211,m212,m213,m214,m215,m216,m217,m218,m219,m220,m221,m222,m223,
		m224,m225,m226,m227,m228,m229,m230,m231,m232,m233,m234,m235,m236,m237,m238,
		m239,m240,m241,m242,m243,m244,m245,m246,m247,m248,m249,m250,m251,m252,m253,
		m254,m255,m256,m257,m258,m259,m260,m261,m262,m263,m264,m265,m266,m267,m268,
		m269,m270,m271,m272,m273,m274,m275,m276,m277,m278,m279,m280,m281,m282,m283,
		m284,m285,m286,m287,m288,m289,m290,m291,m292,m293,m294,m295,m296,m297,m298,m299};

	int nbytes = 279040;

	aes_ecb(M, 300, expkey);

	puts("timing");
	TIME_IT("AES-ECB", aes_ecb(M, 300, expkey), nbytes, 1);

	int x = 0;
	for (int i = 0; i<300; i++){
		x ^= M[i].M[0]^M[i].M[M[i].l*16];
	}

	printf("terminated with code %d\n", x);


	return x;
}