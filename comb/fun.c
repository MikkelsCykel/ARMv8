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


#define REPEAT 5000
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

#define TIME_IT_OUT(name, func, nbytes, MULTIPLE)          	\
	MEASURE(func);                                       \
	printf("%g,", total_clk/(nbytes)/(MULTIPLE));

#define TIME_IT(name, func, nbytes, MULTIPLE)          	\
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


void aes_cbc(struct Message *M, int k, const char *expkey, const char* iv)
{

	uint8x16_t block, lblock;
	
	for (int i = 0; i < k; i++){

		lblock = vld1q_u8((int8_t *)iv);

		for (int j = 0; j < M[i].l; j++){

			block = vld1q_u8(&((uint8_t*)M[i].M)[16*j]);
			block = veorq_u8(block, lblock);

			for (int r=0; r < 9; r++) {
				
				block = vaeseq_u8(block, ((uint8x16_t *)expkey)[r]);
				block = vaesmcq_u8(block);
				
			}

			block = vaeseq_u8(block, ((uint8x16_t *)expkey)[9]);
			block = veorq_u8(block, ((uint8x16_t *)expkey)[10]);
			vst1q_u8(&((uint8_t*)M[i].M)[16*j], block);
			lblock = block;
		}
	}
}

void radixSortDescending (struct Message *M, int n)
{
	int i,biggestNo=0,signicance=1; 
	struct Message temp[n];
    for (i=0; i<n; i++)
        if (M[i].l>biggestNo)
            biggestNo=M[i].l;
    while (biggestNo/signicance>0)
    {
        int b[10]={0};
        for (i=0; i<n; i++)
            b[9-M[i].l/signicance%10]++;         
        for (i=1; i<10; i++)
            b[i]+=b[i-1];
        for (i=n-1; i>=0; i--)
            temp[--b[9-M[i].l/signicance%10]]=M[i]; 
        for (i=0; i<n;i++){
            M[i]=temp[i];                       
        }
        signicance*=10;
    }
}

int preComputeWindows(struct Message *M, int r, uint16_t *rho, uint16_t *beta)
{
	
	int w = 0;
	int qlast = 0;


	int i = r; // r = 6
	while (i > 1) // 6,1
	{
		int q = M[i-1].l; // q = M[5].l
		int j = i-2; // j = 4
		while (j >= 0 && M[j].l == q)
		{
			j -=1; 	//3,2,1,0
		}
		rho[w] = i; // 6
		beta[w] = q - qlast; // 1000-0
		/*printf("q: %d\n", q);
		printf("qlast: %d\n", qlast);
		printf("q - qlast: %d\n", q - qlast);
		printf("beta[w]: %d\n",beta[w]);
		printf("j: %d\n",j);*/
		qlast = q; 	// 1000
		i = j; 	// i=1
		w += 1; 	// w=1
	}
	if(i == 1)
	{	
		//printf("LAST!");
		rho[w] = 1; 			// message = 1
		beta[w] = M[0].l-qlast; // block = 
		w += 1;
	}

	return w;
}

int getLowest(int a, int b){
	return (a < b) ? a : b;
}


void combScheduler(struct Message *M, int k, int P, const char *expkey, const char* iv)
{
	radixSortDescending(M, k);

	int r, w, i, j, windows,z;
	uint8x16_t iv1 = vld1q_u8((int8_t *)iv);

	while(k>0)
	{
		r = getLowest(P, k);

		/*printf("P is : %d\n", P);
		printf("k is : %d\n", k);
		printf("r is : %d\n", r);*/
		uint16_t rho[r];
		uint16_t beta[r];
		windows = preComputeWindows(M, r, rho, beta);

		/*for(int i = 0; i < windows; i++){
			printf("w:%d: blocks %d, messages: %d\n", i+1, beta[i],rho[i]);
		}*/

		uint8x16_t block[r];
		uint8x16_t lblock[r];

		for (int i = 0; i < r; i++){lblock[i] = iv1;}

		
		int completedBlocks = 0;
		
		for(w = 0; w < windows; w++)
		{	
			
			//puts("windowing");
			for (i = 0; i < beta[w]; i++)
			{

			
				for (j = 0; j < rho[w]; j++)
				{


					block[j] = vld1q_u8(&((uint8_t*)M[j].M)[16*(i+completedBlocks)]);
					block[j] = veorq_u8(block[j], lblock[j]);

					block[j] = vaeseq_u8(block[j], ((uint8x16_t *)expkey)[0]); 
					block[j] = vaesmcq_u8(block[j]);

					block[j] = vaeseq_u8(block[j], ((uint8x16_t *)expkey)[1]); 
					block[j] = vaesmcq_u8(block[j]);

					block[j] = vaeseq_u8(block[j], ((uint8x16_t *)expkey)[2]); 
					block[j] = vaesmcq_u8(block[j]);

					block[j] = vaeseq_u8(block[j], ((uint8x16_t *)expkey)[3]); 
					block[j] = vaesmcq_u8(block[j]);

					block[j] = vaeseq_u8(block[j], ((uint8x16_t *)expkey)[4]); 
					block[j] = vaesmcq_u8(block[j]);

					block[j] = vaeseq_u8(block[j], ((uint8x16_t *)expkey)[5]); 
					block[j] = vaesmcq_u8(block[j]);

					block[j] = vaeseq_u8(block[j], ((uint8x16_t *)expkey)[6]); 
					block[j] = vaesmcq_u8(block[j]);

					block[j] = vaeseq_u8(block[j], ((uint8x16_t *)expkey)[7]); 
					block[j] = vaesmcq_u8(block[j]);

					block[j] = vaeseq_u8(block[j], ((uint8x16_t *)expkey)[8]); 
					block[j] = vaesmcq_u8(block[j]);

					// first 9 rounds of aes128
					/*for (int r=0; r < 9; r++) {
						block[j] = vaeseq_u8(block[j], ((uint8x16_t *)expkey)[r]); 
						block[j] = vaesmcq_u8(block[j]);
					})*/

					block[j] = vaeseq_u8(block[j], ((uint8x16_t *)expkey)[9]);
					block[j] = veorq_u8(block[j], ((uint8x16_t *)expkey)[10]);

					vst1q_u8(&((uint8_t*)M[j].M)[16*(i+completedBlocks)], block[j]);
					lblock[j] = block[j];
				}
			}
			completedBlocks += beta[w];
		}
		M = M + r;		
		k -= r;
	}
}
	
int main(void){
	cpu_set_t cpuset;
  	CPU_ZERO(&cpuset); CPU_SET(7, &cpuset);
  	if (sched_setaffinity(getpid(), sizeof cpuset, &cpuset) != 0) perror("setaffinity");

	// NIST test key
	unsigned char key[16] = { 
		0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c
	};
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

	unsigned char iv[16] = {
		0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F 
	};

	int r;
  	int num;

  	struct timespec ts;
  	if (timespec_get(&ts, TIME_UTC) == 0) {

  	}
  	srandom(ts.tv_nsec ^ ts.tv_sec);  
  	r = random();  


	unsigned char message0[1920];
	for(int i = 0; i < 1920; i++){ message0[i] = random(); }
	struct Message m0 = { message0, 120 };
	unsigned char message1[896];
	for(int i = 0; i < 896; i++){ message1[i] = random(); }
	struct Message m1 = { message1, 56 };
	unsigned char message2[1664];
	for(int i = 0; i < 1664; i++){ message2[i] = random(); }
	struct Message m2 = { message2, 104 };
	unsigned char message3[1920];
	for(int i = 0; i < 1920; i++){ message3[i] = random(); }
	struct Message m3 = { message3, 120 };
	unsigned char message4[128];
	for(int i = 0; i < 128; i++){ message4[i] = random(); }
	struct Message m4 = { message4, 8 };
	unsigned char message5[128];
	for(int i = 0; i < 128; i++){ message5[i] = random(); }
	struct Message m5 = { message5, 8 };
	unsigned char message6[128];
	for(int i = 0; i < 128; i++){ message6[i] = random(); }
	struct Message m6 = { message6, 8 };
	unsigned char message7[1152];
	for(int i = 0; i < 1152; i++){ message7[i] = random(); }
	struct Message m7 = { message7, 72 };
	unsigned char message8[128];
	for(int i = 0; i < 128; i++){ message8[i] = random(); }
	struct Message m8 = { message8, 8 };
	unsigned char message9[1792];
	for(int i = 0; i < 1792; i++){ message9[i] = random(); }
	struct Message m9 = { message9, 112 };
	unsigned char message10[128];
	for(int i = 0; i < 128; i++){ message10[i] = random(); }
	struct Message m10 = { message10, 8 };
	unsigned char message11[1664];
	for(int i = 0; i < 1664; i++){ message11[i] = random(); }
	struct Message m11 = { message11, 104 };
	unsigned char message12[1664];
	for(int i = 0; i < 1664; i++){ message12[i] = random(); }
	struct Message m12 = { message12, 104 };
	unsigned char message13[1792];
	for(int i = 0; i < 1792; i++){ message13[i] = random(); }
	struct Message m13 = { message13, 112 };
	unsigned char message14[1280];
	for(int i = 0; i < 1280; i++){ message14[i] = random(); }
	struct Message m14 = { message14, 80 };
	unsigned char message15[2048];
	for(int i = 0; i < 2048; i++){ message15[i] = random(); }
	struct Message m15 = { message15, 128 };
	unsigned char message16[1408];
	for(int i = 0; i < 1408; i++){ message16[i] = random(); }
	struct Message m16 = { message16, 88 };
	unsigned char message17[1536];
	for(int i = 0; i < 1536; i++){ message17[i] = random(); }
	struct Message m17 = { message17, 96 };
	unsigned char message18[256];
	for(int i = 0; i < 256; i++){ message18[i] = random(); }
	struct Message m18 = { message18, 16 };
	unsigned char message19[512];
	for(int i = 0; i < 512; i++){ message19[i] = random(); }
	struct Message m19 = { message19, 32 };
	unsigned char message20[384];
	for(int i = 0; i < 384; i++){ message20[i] = random(); }
	struct Message m20 = { message20, 24 };
	unsigned char message21[2048];
	for(int i = 0; i < 2048; i++){ message21[i] = random(); }
	struct Message m21 = { message21, 128 };
	unsigned char message22[1920];
	for(int i = 0; i < 1920; i++){ message22[i] = random(); }
	struct Message m22 = { message22, 120 };
	unsigned char message23[768];
	for(int i = 0; i < 768; i++){ message23[i] = random(); }
	struct Message m23 = { message23, 48 };
	unsigned char message24[128];
	for(int i = 0; i < 128; i++){ message24[i] = random(); }
	struct Message m24 = { message24, 8 };
	unsigned char message25[2048];
	for(int i = 0; i < 2048; i++){ message25[i] = random(); }
	struct Message m25 = { message25, 128 };
	unsigned char message26[128];
	for(int i = 0; i < 128; i++){ message26[i] = random(); }
	struct Message m26 = { message26, 8 };
	unsigned char message27[128];
	for(int i = 0; i < 128; i++){ message27[i] = random(); }
	struct Message m27 = { message27, 8 };
	unsigned char message28[768];
	for(int i = 0; i < 768; i++){ message28[i] = random(); }
	struct Message m28 = { message28, 48 };
	unsigned char message29[128];
	for(int i = 0; i < 128; i++){ message29[i] = random(); }
	struct Message m29 = { message29, 8 };
	unsigned char message30[1920];
	for(int i = 0; i < 1920; i++){ message30[i] = random(); }
	struct Message m30 = { message30, 120 };
	unsigned char message31[2048];
	for(int i = 0; i < 2048; i++){ message31[i] = random(); }
	struct Message m31 = { message31, 128 };
	unsigned char message32[1664];
	for(int i = 0; i < 1664; i++){ message32[i] = random(); }
	struct Message m32 = { message32, 104 };
	unsigned char message33[2048];
	for(int i = 0; i < 2048; i++){ message33[i] = random(); }
	struct Message m33 = { message33, 128 };
	unsigned char message34[128];
	for(int i = 0; i < 128; i++){ message34[i] = random(); }
	struct Message m34 = { message34, 8 };
	unsigned char message35[1536];
	for(int i = 0; i < 1536; i++){ message35[i] = random(); }
	struct Message m35 = { message35, 96 };
	unsigned char message36[128];
	for(int i = 0; i < 128; i++){ message36[i] = random(); }
	struct Message m36 = { message36, 8 };
	unsigned char message37[2048];
	for(int i = 0; i < 2048; i++){ message37[i] = random(); }
	struct Message m37 = { message37, 128 };
	unsigned char message38[1024];
	for(int i = 0; i < 1024; i++){ message38[i] = random(); }
	struct Message m38 = { message38, 64 };
	unsigned char message39[1920];
	for(int i = 0; i < 1920; i++){ message39[i] = random(); }
	struct Message m39 = { message39, 120 };
	unsigned char message40[1792];
	for(int i = 0; i < 1792; i++){ message40[i] = random(); }
	struct Message m40 = { message40, 112 };
	unsigned char message41[128];
	for(int i = 0; i < 128; i++){ message41[i] = random(); }
	struct Message m41 = { message41, 8 };
	unsigned char message42[1920];
	for(int i = 0; i < 1920; i++){ message42[i] = random(); }
	struct Message m42 = { message42, 120 };
	unsigned char message43[2048];
	for(int i = 0; i < 2048; i++){ message43[i] = random(); }
	struct Message m43 = { message43, 128 };
	unsigned char message44[768];
	for(int i = 0; i < 768; i++){ message44[i] = random(); }
	struct Message m44 = { message44, 48 };
	unsigned char message45[2048];
	for(int i = 0; i < 2048; i++){ message45[i] = random(); }
	struct Message m45 = { message45, 128 };
	unsigned char message46[1920];
	for(int i = 0; i < 1920; i++){ message46[i] = random(); }
	struct Message m46 = { message46, 120 };
	unsigned char message47[1664];
	for(int i = 0; i < 1664; i++){ message47[i] = random(); }
	struct Message m47 = { message47, 104 };
	unsigned char message48[1664];
	for(int i = 0; i < 1664; i++){ message48[i] = random(); }
	struct Message m48 = { message48, 104 };
	unsigned char message49[1664];
	for(int i = 0; i < 1664; i++){ message49[i] = random(); }
	struct Message m49 = { message49, 104 };
	unsigned char message50[1408];
	for(int i = 0; i < 1408; i++){ message50[i] = random(); }
	struct Message m50 = { message50, 88 };
	unsigned char message51[128];
	for(int i = 0; i < 128; i++){ message51[i] = random(); }
	struct Message m51 = { message51, 8 };
	unsigned char message52[1792];
	for(int i = 0; i < 1792; i++){ message52[i] = random(); }
	struct Message m52 = { message52, 112 };
	unsigned char message53[1664];
	for(int i = 0; i < 1664; i++){ message53[i] = random(); }
	struct Message m53 = { message53, 104 };
	unsigned char message54[512];
	for(int i = 0; i < 512; i++){ message54[i] = random(); }
	struct Message m54 = { message54, 32 };
	unsigned char message55[1920];
	for(int i = 0; i < 1920; i++){ message55[i] = random(); }
	struct Message m55 = { message55, 120 };
	unsigned char message56[640];
	for(int i = 0; i < 640; i++){ message56[i] = random(); }
	struct Message m56 = { message56, 40 };
	unsigned char message57[128];
	for(int i = 0; i < 128; i++){ message57[i] = random(); }
	struct Message m57 = { message57, 8 };
	unsigned char message58[2048];
	for(int i = 0; i < 2048; i++){ message58[i] = random(); }
	struct Message m58 = { message58, 128 };
	struct Message M[59] = {m0,m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12,m13,m14,m15,m16,m17,m18,
		m19,m20,m21,m22,m23,m24,m25,m26,m27,m28,m29,m30,m31,m32,m33,m34,m35,m36,m37,m38,m39,m40,
		m41,m42,m43,m44,m45,m46,m47,m48,m49,m50,m51,m52,m53,m54,m55,m56,m57,m58};

	int nbytes = 0;
	for (int i = 0; i<59; i++){
		nbytes += (M[i].l)*16;
	}


	//TIME_IT("AES-CBC-SMALL", aes_cbc(M1, 1, expkey, iv), 16064, 1);
	TIME_IT("AES-CBC-BIG", aes_cbc(M, 59, expkey, iv), nbytes, 1);

	int a = total_clk;

	puts("round 1");
	TIME_IT("AES-CBC-COMP-P6", combScheduler(M, 59, 6, expkey, iv), nbytes, 1);

	/*TIME_IT_OUT("AES-CBC-COMP-P1", combScheduler(M, 31, 1, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P2", combScheduler(M, 31, 2, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P3", combScheduler(M, 31, 3, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P4", combScheduler(M, 31, 4, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P5", combScheduler(M, 31, 5, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P6", combScheduler(M, 31, 6, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P7", combScheduler(M, 31, 7, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P8", combScheduler(M, 31, 8, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P9", combScheduler(M, 31, 9, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P10", combScheduler(M, 31, 10, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P11", combScheduler(M, 31, 11, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P12", combScheduler(M, 31, 12, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P13", combScheduler(M, 31, 13, expkey, iv), nbytes, 1);



	puts("round 2");
	TIME_IT_OUT("AES-CBC-COMP-P1", combScheduler(M, 31, 1, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P2", combScheduler(M, 31, 2, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P3", combScheduler(M, 31, 3, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P4", combScheduler(M, 31, 4, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P5", combScheduler(M, 31, 5, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P6", combScheduler(M, 31, 6, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P7", combScheduler(M, 31, 7, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P8", combScheduler(M, 31, 8, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P9", combScheduler(M, 31, 9, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P10", combScheduler(M, 31, 10, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P11", combScheduler(M, 31, 11, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P12", combScheduler(M, 31, 12, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P13", combScheduler(M, 31, 13, expkey, iv), nbytes, 1);

	puts("round 3");
	TIME_IT_OUT("AES-CBC-COMP-P1", combScheduler(M, 31, 1, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P2", combScheduler(M, 31, 2, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P3", combScheduler(M, 31, 3, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P4", combScheduler(M, 31, 4, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P5", combScheduler(M, 31, 5, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P6", combScheduler(M, 31, 6, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P7", combScheduler(M, 31, 7, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P8", combScheduler(M, 31, 8, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P9", combScheduler(M, 31, 9, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P10", combScheduler(M, 31, 10, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P11", combScheduler(M, 31, 11, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P12", combScheduler(M, 31, 12, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P13", combScheduler(M, 31, 13, expkey, iv), nbytes, 1);
	puts("round 4");
	TIME_IT_OUT("AES-CBC-COMP-P1", combScheduler(M, 31, 1, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P2", combScheduler(M, 31, 2, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P3", combScheduler(M, 31, 3, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P4", combScheduler(M, 31, 4, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P5", combScheduler(M, 31, 5, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P6", combScheduler(M, 31, 6, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P7", combScheduler(M, 31, 7, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P8", combScheduler(M, 31, 8, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P9", combScheduler(M, 31, 9, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P10", combScheduler(M, 31, 10, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P11", combScheduler(M, 31, 11, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P12", combScheduler(M, 31, 12, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P13", combScheduler(M, 31, 13, expkey, iv), nbytes, 1);
	puts("round 5");
	TIME_IT_OUT("AES-CBC-COMP-P1", combScheduler(M, 31, 1, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P2", combScheduler(M, 31, 2, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P3", combScheduler(M, 31, 3, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P4", combScheduler(M, 31, 4, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P5", combScheduler(M, 31, 5, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P6", combScheduler(M, 31, 6, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P7", combScheduler(M, 31, 7, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P8", combScheduler(M, 31, 8, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P9", combScheduler(M, 31, 9, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P10", combScheduler(M, 31, 10, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P11", combScheduler(M, 31, 11, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P12", combScheduler(M, 31, 12, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P13", combScheduler(M, 31, 13, expkey, iv), nbytes, 1);
	puts("round 6");
	TIME_IT_OUT("AES-CBC-COMP-P1", combScheduler(M, 31, 1, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P2", combScheduler(M, 31, 2, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P3", combScheduler(M, 31, 3, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P4", combScheduler(M, 31, 4, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P5", combScheduler(M, 31, 5, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P6", combScheduler(M, 31, 6, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P7", combScheduler(M, 31, 7, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P8", combScheduler(M, 31, 8, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P9", combScheduler(M, 31, 9, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P10", combScheduler(M, 31, 10, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P11", combScheduler(M, 31, 11, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P12", combScheduler(M, 31, 12, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P13", combScheduler(M, 31, 13, expkey, iv), nbytes, 1);
	puts("round 7");
	TIME_IT_OUT("AES-CBC-COMP-P1", combScheduler(M, 31, 1, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P2", combScheduler(M, 31, 2, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P3", combScheduler(M, 31, 3, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P4", combScheduler(M, 31, 4, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P5", combScheduler(M, 31, 5, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P6", combScheduler(M, 31, 6, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P7", combScheduler(M, 31, 7, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P8", combScheduler(M, 31, 8, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P9", combScheduler(M, 31, 9, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P10", combScheduler(M, 31, 10, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P11", combScheduler(M, 31, 11, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P12", combScheduler(M, 31, 12, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P13", combScheduler(M, 31, 13, expkey, iv), nbytes, 1);
	puts("round 8");
	TIME_IT_OUT("AES-CBC-COMP-P1", combScheduler(M, 31, 1, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P2", combScheduler(M, 31, 2, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P3", combScheduler(M, 31, 3, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P4", combScheduler(M, 31, 4, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P5", combScheduler(M, 31, 5, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P6", combScheduler(M, 31, 6, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P7", combScheduler(M, 31, 7, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P8", combScheduler(M, 31, 8, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P9", combScheduler(M, 31, 9, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P10", combScheduler(M, 31, 10, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P11", combScheduler(M, 31, 11, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P12", combScheduler(M, 31, 12, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P13", combScheduler(M, 31, 13, expkey, iv), nbytes, 1);
	puts("round 9");
	TIME_IT_OUT("AES-CBC-COMP-P1", combScheduler(M, 31, 1, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P2", combScheduler(M, 31, 2, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P3", combScheduler(M, 31, 3, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P4", combScheduler(M, 31, 4, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P5", combScheduler(M, 31, 5, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P6", combScheduler(M, 31, 6, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P7", combScheduler(M, 31, 7, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P8", combScheduler(M, 31, 8, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P9", combScheduler(M, 31, 9, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P10", combScheduler(M, 31, 10, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P11", combScheduler(M, 31, 11, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P12", combScheduler(M, 31, 12, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P13", combScheduler(M, 31, 13, expkey, iv), nbytes, 1);
	puts("round 10");
	TIME_IT_OUT("AES-CBC-COMP-P1", combScheduler(M, 31, 1, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P2", combScheduler(M, 31, 2, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P3", combScheduler(M, 31, 3, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P4", combScheduler(M, 31, 4, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P5", combScheduler(M, 31, 5, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P6", combScheduler(M, 31, 6, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P7", combScheduler(M, 31, 7, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P8", combScheduler(M, 31, 8, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P9", combScheduler(M, 31, 9, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P10", combScheduler(M, 31, 10, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P11", combScheduler(M, 31, 11, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P12", combScheduler(M, 31, 12, expkey, iv), nbytes, 1);
	TIME_IT_OUT("AES-CBC-COMP-P13", combScheduler(M, 31, 13, expkey, iv), nbytes, 1);


*/

	//printblock(M[1].M);

	int x = 0;
	for (int i = 0; i<59; i++){
		x ^= M[i].M[0]^M[i].M[(M[i].l*16)-1];
	}

	printf("terminated with code %d\n", x);
	
	return x;
}