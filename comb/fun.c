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


	unsigned char message0[1000*16] = { 0 };
	for(int i = 0; i < 1000*16; i++){ message0[i] = random(); }
	struct Message m0 = { message0, 1000 };

	unsigned char message1[160*16] = { 0 };
	for(int i = 0; i < 160*16; i++){ message1[i] = random(); }
	struct Message m1 = { message1, 160 };

	unsigned char message2[4*16] = { 0 };
	for(int i = 0; i < 4*16; i++){ message2[i] = random(); }
	struct Message m2 = { message2, 4 };

	unsigned char message3[532*16] = { 0 };
	for(int i = 0; i < 532*16; i++){ message3[i] = random(); }
	struct Message m3 = { message3, 532 };

	unsigned char message4[43*16] = { 0 };
	for(int i = 0; i < 43*16; i++){ message4[i] = random(); }
	struct Message m4 = { message4, 43 };

	unsigned char message5[145*16] = { 0 };
	for(int i = 0; i < 145*16; i++){ message5[i] = random(); }
	struct Message m5 = { message5, 145 };

	unsigned char message6[492*16] = { 0 };
	for(int i = 0; i < 492*16; i++){ message6[i] = random(); }
	struct Message m6 = { message6, 492 };

	unsigned char message7[941*16] = { 0 };
	for(int i = 0; i < 941*16; i++){ message7[i] = random(); }
	struct Message m7 = { message7, 941 };

	unsigned char message8[124*16] = { 0 };
	for(int i = 0; i < 124*16; i++){ message8[i] = random(); }
	struct Message m8 = { message8, 124 };

	unsigned char message9[64*16] = { 0 };
	for(int i = 0; i < 64*16; i++){ message9[i] = random(); }
	struct Message m9 = { message9, 64 };

	unsigned char message10[34*16] = { 0 };
	for(int i = 0; i < 34*16; i++){ message10[i] = random(); }
	struct Message m10 = { message10, 34 };

	unsigned char message11[154*16] = { 0 };
	for(int i = 0; i < 154*16; i++){ message11[i] = random(); }
	struct Message m11 = { message11, 154 };

	unsigned char message12[20000*16] = { 0 };
	for(int i = 0; i < 20000*16; i++){ message12[i] = random(); }
	struct Message m12 = { message12, 20000 };

	unsigned char message13[151*16] = { 0 };
	for(int i = 0; i < 151*16; i++){ message13[i] = random(); }
	struct Message m13 = { message13, 151 };

	unsigned char message14[598*16] = { 0 };
	for(int i = 0; i < 598*16; i++){ message14[i] = random(); }
	struct Message m14 = { message14, 598 };

	unsigned char message15[251*16] = { 0 };
	for(int i = 0; i < 251*16; i++){ message15[i] = random(); }
	struct Message m15 = { message15, 251 };

	unsigned char message16[123*16] = { 0 };
	for(int i = 0; i < 123*16; i++){ message16[i] = random(); }
	struct Message m16 = { message16, 123 };

	unsigned char message17[8000*16] = { 0 };
	for(int i = 0; i < 8000*16; i++){ message17[i] = random(); }
	struct Message m17 = { message17, 8000 };

	unsigned char message18[42*16] = { 0 };
	for(int i = 0; i < 42*16; i++){ message18[i] = random(); }
	struct Message m18 = { message18, 42 };

	unsigned char message19[12*16] = { 0 };
	for(int i = 0; i < 12*16; i++){ message19[i] = random(); }
	struct Message m19 = { message19, 12 };

	unsigned char message20[42*16] = { 0 };
	for(int i = 0; i < 42*16; i++){ message20[i] = random(); }
	struct Message m20 = { message20, 42 };

	unsigned char message21[94*16] = { 0 };
	for(int i = 0; i < 94*16; i++){ message21[i] = random(); }
	struct Message m21 = { message21, 94 };

	unsigned char message22[64*16] = { 0 };
	for(int i = 0; i < 64*16; i++){ message22[i] = random(); }
	struct Message m22 = { message22, 64 };

	unsigned char message23[91*16] = { 0 };
	for(int i = 0; i < 91*16; i++){ message23[i] = random(); }
	struct Message m23 = { message23, 91 };

	unsigned char message24[160*16] = { 0 };
	for(int i = 0; i < 160*16; i++){ message24[i] = random(); }
	struct Message m24 = { message24, 160 };

	unsigned char message25[100000*16] = { 0 };
	for(int i = 0; i < 100000*16; i++){ message25[i] = random(); }
	struct Message m25 = { message25, 100000 };

	unsigned char message26[6548*16] = { 0 };
	for(int i = 0; i < 6548*16; i++){ message26[i] = random(); }
	struct Message m26 = { message26, 6548 };

	unsigned char message27[52*16] = { 0 };
	for(int i = 0; i < 52*16; i++){ message27[i] = random(); }
	struct Message m27 = { message27, 52 };

	unsigned char message28[2367*16] = { 0 };
	for(int i = 0; i < 2367*16; i++){ message28[i] = random(); }
	struct Message m28 = { message28, 2367 };

	unsigned char message29[42*16] = { 0 };
	for(int i = 0; i < 42*16; i++){ message29[i] = random(); }
	struct Message m29 = { message29, 42 };

	unsigned char message30[41*16] = { 0 };
	for(int i = 0; i < 41*16; i++){ message30[i] = random(); }
	struct Message m30 = { message30, 41 };
	
	unsigned char message41[1000*16] = { 0 };
	for(int i = 0; i < 1000*16; i++){ message41[i] = rand(); }
	struct Message m41 = { message41, 1000 };

	unsigned char message42[1000*16] = { 0 };
	for(int i = 0; i < 1000*16; i++){ message42[i] = rand(); }
	struct Message m42 = { message42, 1000 };

	unsigned char message43[1000*16] = { 0 };
	for(int i = 0; i < 1000*16; i++){ message43[i] = rand(); }
	struct Message m43 = { message43, 1000 };

	unsigned char message44[1000*16] = { 0 };
	for(int i = 0; i < 1000*16; i++){ message44[i] = rand(); }
	struct Message m44 = { message44, 1000 };

	unsigned char message45[1000*16] = { 0 };
	for(int i = 0; i < 1000*16; i++){ message45[i] = rand(); }
	struct Message m45 = { message45, 1000 };

	unsigned char message46[1000*16] = { 0 };
	for(int i = 0; i < 1000*16; i++){ message46[i] = rand(); }
	struct Message m46 = { message46, 1000 };

	unsigned char message31[4*16] = { 
		0x6b,0xc1,0xbe,0xe2,0x2e,0x40,0x9f,0x96,0xe9,0x3d,0x7e,0x11,0x73,0x93,0x17,0x2a,
		0xae,0x2d,0x8a,0x57,0x1e,0x03,0xac,0x9c,0x9e,0xb7,0x6f,0xac,0x45,0xaf,0x8e,0x51,
		0x30,0xc8,0x1c,0x46,0xa3,0x5c,0xe4,0x11,0xe5,0xfb,0xc1,0x19,0x1a,0x0a,0x52,0xef,
		0xf6,0x9f,0x24,0x45,0xdf,0x4f,0x9b,0x17,0xad,0x2b,0x41,0x7b,0xe6,0x6c,0x37,0x10,
	};

	struct Message m31 = { message31, 4 };

	unsigned char expected_cipher[4*16] = {
		0x76,0x49,0xAB,0xAC,0x81,0x19,0xB2,0x46,0xCE,0xE9,0x8E,0x9B,0x12,0xE9,0x19,0x7D,
		0x50,0x86,0xCB,0x9B,0x50,0x72,0x19,0xEE,0x95,0xDB,0x11,0x3A,0x91,0x76,0x78,0xB2,
		0x73,0xBE,0xD6,0xB8,0xE3,0xC1,0x74,0x3B,0x71,0x16,0xE6,0x9E,0x22,0x22,0x95,0x16,
		0x3F,0xF1,0xCA,0xA1,0x68,0x1F,0xAC,0x09,0x12,0x0E,0xCA,0x30,0x75,0x86,0xE1,0xA7 
	};



	struct Message M[37] = {m0,m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,
							m11,m12,m13,m14,m5,m16,m17,m18,m19,m20,
							m21,m22,m23,m24,m25,m26,m27,m28,m29,m30, m41, m42, m43, m44, m45, m46};
							//m32,m33,m34,m35,m36,m37,m38,m39,m40,m41};

	/*struct Message M1[7] = {m31, m41, m42, m43, m44, m45, m46};

	

	printf("%d no of bytes\n",nbytes);

	combScheduler(M1, 7, 6, expkey, iv);
	
	puts("ciphertext vs expected:");

	for (int i = 0; i< 4; i++) {
		
		printf("NIST tv: %d\n", M1[6].l);
		printblock(M1[6].M+16*i);
		printblock(expected_cipher+16*i);
	}*/
	


	/*for (int i = 0; i < 1000; i++){
		printblock(M[0].M+16*i);
	}*/
	
	int nbytes = 0;
	for (int i = 0; i<37; i++){
		nbytes += (M[i].l)*16;
	}


	//TIME_IT("AES-CBC-SMALL", aes_cbc(M1, 1, expkey, iv), 16064, 1);
	TIME_IT("AES-CBC-BIG", aes_cbc(M, 37, expkey, iv), nbytes, 1);


	puts("round 1");
	TIME_IT("AES-CBC-COMP-P2", combScheduler(M, 37, 12, expkey, iv), nbytes, 1);

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
	for (int i = 0; i<37; i++){
		x ^= M[i].M[0]^M[i].M[M[i].l*16];
	}

	printf("terminated with code %d\n", x);
	
	return x;
}