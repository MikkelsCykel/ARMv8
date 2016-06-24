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
#define REPEAT 1000000
#define WARMUP REPEAT/4
uint64_t start_clk, end_clk;
double total_clk;


__inline uint64_t get_Clks(void) {
	struct timeval tv;
	gettimeofday(&tv, NULL);
	return (tv.tv_sec * 1e6 + tv.tv_usec); // usec
}

#define MEASURE(x)  start_clk=get_Clks();                \
					for (int i = 0; i < REPEAT; i++)         \
					{                                    \
								 {x;}                    \
					}                                    \
					end_clk=get_Clks();                  \
					total_clk=(double)(end_clk-start_clk)*2.1e3/REPEAT;

#define TIME_IT(name, func, nbytes, MULTIPLE)          	\
	printf("%s-%d: ", name, nbytes);                     \
	MEASURE(func);                                       \
	printf("%g cpb\n", total_clk/(nbytes)/(MULTIPLE));


struct Message{
	unsigned char* M;
	int l;
};


void radixSortDescending (uint8_t *lengths, int n)
{
	int i,biggestNo=0,signicance=1; 
	uint8_t temp[n];
    for (i=0; i<n; i++)
        if (lengths[i]>biggestNo)
            biggestNo=lengths[i];
    while (biggestNo/signicance>0)
    {
        int b[10]={0};
        for (i=0; i<n; i++)
            b[9-lengths[i]/signicance%10]++;         
        for (i=1; i<10; i++)
            b[i]+=b[i-1];
        for (i=n-1; i>=0; i--)
            temp[--b[9-lengths[i]/signicance%10]]=lengths[i]; 
        for (i=0; i<n;i++){
            lengths[i]=temp[i];                       
        }
        signicance*=10;
    }
}

int preComputeWindows(uint8_t *lengths, int r, uint16_t *rho, uint16_t *beta)
{
	int w = 0;
	int qlast = 0;
	int i = r; 
	while (i > 1) 
	{
		int q = lengths[i-1];
		int j = i-2;
		while (j >= 0 && lengths[j] == q)
		{
			j -=1; 	
		}
		rho[w] = i; 
		beta[w] = q - qlast;
		qlast = q; 
		i = j; 
		w += 1; 	
	}
	if(i == 1)
	{			
		rho[w] = 1; 			
		beta[w] = lengths[0]-qlast; 
		w += 1;
	}

	return w;
}

int getLowest(int a, int b){
	return (a < b) ? a : b;
}


void combScheduler(const unsigned char *M, unsigned char *out, uint8_t *lengths, int k, int P, uint8x16_t *expkey, const char* iv)
{
	radixSortDescending(lengths, k);
	int r, w, i, j, windows,z;
	uint8x16_t iv1 = vld1q_u8((int8_t *)iv);
	uint8x16_t block[P];
	uint8x16_t lblock[P];
	uint16_t rho[P];
	uint16_t beta[P];
	//int blockss = 0;
	while(k>0)
	{
		r = getLowest(P, k);
		windows = preComputeWindows(lengths, r, rho, beta);
		

		for (int i = 0; i < r; i++){lblock[i] = iv1;}
		int completedBlocks = 0;
		
		for(w = 0; w < windows; w++)
		{	
			for (i = 0; i < beta[w]; i++)
			{
				block[0] = vld1q_u8(&((uint8_t*)M)[16*(i+completedBlocks)]);
				block[1] = vld1q_u8(&((uint8_t*)M)[16*(i+completedBlocks)+2048]);
				block[2] = vld1q_u8(&((uint8_t*)M)[16*(i+completedBlocks)+4096]);
				block[3] = vld1q_u8(&((uint8_t*)M)[16*(i+completedBlocks)+6144]);
				block[4] = vld1q_u8(&((uint8_t*)M)[16*(i+completedBlocks)+8192]);
				block[5] = vld1q_u8(&((uint8_t*)M)[16*(i+completedBlocks)+10240]);
				block[6] = vld1q_u8(&((uint8_t*)M)[16*(i+completedBlocks)+12288]);
				block[7] = vld1q_u8(&((uint8_t*)M)[16*(i+completedBlocks)+14336]);
				block[8] = vld1q_u8(&((uint8_t*)M)[16*(i+completedBlocks)+16384]);

				block[0] = veorq_u8(block[0], lblock[0]);
				block[1] = veorq_u8(block[1], lblock[1]);
				block[2] = veorq_u8(block[2], lblock[2]);
				block[3] = veorq_u8(block[3], lblock[3]);
				block[4] = veorq_u8(block[4], lblock[4]);
				block[5] = veorq_u8(block[5], lblock[5]);
				block[6] = veorq_u8(block[6], lblock[6]);
				block[7] = veorq_u8(block[7], lblock[7]);
				block[8] = veorq_u8(block[8], lblock[8]);

				block[0] = vaeseq_u8(block[0], expkey[0]);
				block[1] = vaeseq_u8(block[1], expkey[0]);
				block[2] = vaeseq_u8(block[2], expkey[0]);
				block[3] = vaeseq_u8(block[3], expkey[0]);
				block[4] = vaeseq_u8(block[4], expkey[0]);
				block[5] = vaeseq_u8(block[5], expkey[0]);
				block[6] = vaeseq_u8(block[6], expkey[0]);
				block[7] = vaeseq_u8(block[7], expkey[0]);
				block[8] = vaeseq_u8(block[8], expkey[0]);

				block[0] = vaesmcq_u8(block[0]);
				block[1] = vaesmcq_u8(block[1]);
				block[2] = vaesmcq_u8(block[2]);
				block[3] = vaesmcq_u8(block[3]);
				block[4] = vaesmcq_u8(block[4]);
				block[5] = vaesmcq_u8(block[5]);
				block[6] = vaesmcq_u8(block[6]);
				block[7] = vaesmcq_u8(block[7]);
				block[8] = vaesmcq_u8(block[8]);

				block[0] = vaeseq_u8(block[0], expkey[1]);
				block[1] = vaeseq_u8(block[1], expkey[1]);
				block[2] = vaeseq_u8(block[2], expkey[1]);
				block[3] = vaeseq_u8(block[3], expkey[1]);
				block[4] = vaeseq_u8(block[4], expkey[1]);
				block[5] = vaeseq_u8(block[5], expkey[1]);
				block[6] = vaeseq_u8(block[6], expkey[1]);
				block[7] = vaeseq_u8(block[7], expkey[1]);
				block[8] = vaeseq_u8(block[8], expkey[1]);

				block[0] = vaesmcq_u8(block[0]);
				block[1] = vaesmcq_u8(block[1]);
				block[2] = vaesmcq_u8(block[2]);
				block[3] = vaesmcq_u8(block[3]);
				block[4] = vaesmcq_u8(block[4]);
				block[5] = vaesmcq_u8(block[5]);
				block[6] = vaesmcq_u8(block[6]);
				block[7] = vaesmcq_u8(block[7]);
				block[8] = vaesmcq_u8(block[8]);

				block[0] = vaeseq_u8(block[0], expkey[2]);
				block[1] = vaeseq_u8(block[1], expkey[2]);
				block[2] = vaeseq_u8(block[2], expkey[2]);
				block[3] = vaeseq_u8(block[3], expkey[2]);
				block[4] = vaeseq_u8(block[4], expkey[2]);
				block[5] = vaeseq_u8(block[5], expkey[2]);
				block[6] = vaeseq_u8(block[6], expkey[2]);
				block[7] = vaeseq_u8(block[7], expkey[2]);
				block[8] = vaeseq_u8(block[8], expkey[2]);

				block[0] = vaesmcq_u8(block[0]);
				block[1] = vaesmcq_u8(block[1]);
				block[2] = vaesmcq_u8(block[2]);
				block[3] = vaesmcq_u8(block[3]);
				block[4] = vaesmcq_u8(block[4]);
				block[5] = vaesmcq_u8(block[5]);
				block[6] = vaesmcq_u8(block[6]);
				block[7] = vaesmcq_u8(block[7]);
				block[8] = vaesmcq_u8(block[8]);

				block[0] = vaeseq_u8(block[0], expkey[3]);
				block[1] = vaeseq_u8(block[1], expkey[3]);
				block[2] = vaeseq_u8(block[2], expkey[3]);
				block[3] = vaeseq_u8(block[3], expkey[3]);
				block[4] = vaeseq_u8(block[4], expkey[3]);
				block[5] = vaeseq_u8(block[5], expkey[3]);
				block[6] = vaeseq_u8(block[6], expkey[3]);
				block[7] = vaeseq_u8(block[7], expkey[3]);
				block[8] = vaeseq_u8(block[8], expkey[3]);

				block[0] = vaesmcq_u8(block[0]);
				block[1] = vaesmcq_u8(block[1]);
				block[2] = vaesmcq_u8(block[2]);
				block[3] = vaesmcq_u8(block[3]);
				block[4] = vaesmcq_u8(block[4]);
				block[5] = vaesmcq_u8(block[5]);
				block[6] = vaesmcq_u8(block[6]);
				block[7] = vaesmcq_u8(block[7]);
				block[8] = vaesmcq_u8(block[8]);

				block[0] = vaeseq_u8(block[0], expkey[4]);
				block[1] = vaeseq_u8(block[1], expkey[4]);
				block[2] = vaeseq_u8(block[2], expkey[4]);
				block[3] = vaeseq_u8(block[3], expkey[4]);
				block[4] = vaeseq_u8(block[4], expkey[4]);
				block[5] = vaeseq_u8(block[5], expkey[4]);
				block[6] = vaeseq_u8(block[6], expkey[4]);
				block[7] = vaeseq_u8(block[7], expkey[4]);
				block[8] = vaeseq_u8(block[8], expkey[4]);

				block[0] = vaesmcq_u8(block[0]);
				block[1] = vaesmcq_u8(block[1]);
				block[2] = vaesmcq_u8(block[2]);
				block[3] = vaesmcq_u8(block[3]);
				block[4] = vaesmcq_u8(block[4]);
				block[5] = vaesmcq_u8(block[5]);
				block[6] = vaesmcq_u8(block[6]);
				block[7] = vaesmcq_u8(block[7]);
				block[8] = vaesmcq_u8(block[8]);

				block[0] = vaeseq_u8(block[0], expkey[5]);
				block[1] = vaeseq_u8(block[1], expkey[5]);
				block[2] = vaeseq_u8(block[2], expkey[5]);
				block[3] = vaeseq_u8(block[3], expkey[5]);
				block[4] = vaeseq_u8(block[4], expkey[5]);
				block[5] = vaeseq_u8(block[5], expkey[5]);
				block[6] = vaeseq_u8(block[6], expkey[5]);
				block[7] = vaeseq_u8(block[7], expkey[5]);
				block[8] = vaeseq_u8(block[8], expkey[5]);

				block[0] = vaesmcq_u8(block[0]);
				block[1] = vaesmcq_u8(block[1]);
				block[2] = vaesmcq_u8(block[2]);
				block[3] = vaesmcq_u8(block[3]);
				block[4] = vaesmcq_u8(block[4]);
				block[5] = vaesmcq_u8(block[5]);
				block[6] = vaesmcq_u8(block[6]);
				block[7] = vaesmcq_u8(block[7]);
				block[8] = vaesmcq_u8(block[8]);

				block[0] = vaeseq_u8(block[0], expkey[5]);
				block[1] = vaeseq_u8(block[1], expkey[5]);
				block[2] = vaeseq_u8(block[2], expkey[5]);
				block[3] = vaeseq_u8(block[3], expkey[5]);
				block[4] = vaeseq_u8(block[4], expkey[5]);
				block[5] = vaeseq_u8(block[5], expkey[5]);
				block[6] = vaeseq_u8(block[6], expkey[5]);
				block[7] = vaeseq_u8(block[7], expkey[5]);
				block[8] = vaeseq_u8(block[8], expkey[5]);

				block[0] = vaesmcq_u8(block[0]);
				block[1] = vaesmcq_u8(block[1]);
				block[2] = vaesmcq_u8(block[2]);
				block[3] = vaesmcq_u8(block[3]);
				block[4] = vaesmcq_u8(block[4]);
				block[5] = vaesmcq_u8(block[5]);
				block[6] = vaesmcq_u8(block[6]);
				block[7] = vaesmcq_u8(block[7]);
				block[8] = vaesmcq_u8(block[8]);

				block[0] = vaeseq_u8(block[0], expkey[6]);
				block[1] = vaeseq_u8(block[1], expkey[6]);
				block[2] = vaeseq_u8(block[2], expkey[6]);
				block[3] = vaeseq_u8(block[3], expkey[6]);
				block[4] = vaeseq_u8(block[4], expkey[6]);
				block[5] = vaeseq_u8(block[5], expkey[6]);
				block[6] = vaeseq_u8(block[6], expkey[6]);
				block[7] = vaeseq_u8(block[7], expkey[6]);
				block[8] = vaeseq_u8(block[8], expkey[6]);

				block[0] = vaesmcq_u8(block[0]);
				block[1] = vaesmcq_u8(block[1]);
				block[2] = vaesmcq_u8(block[2]);
				block[3] = vaesmcq_u8(block[3]);
				block[4] = vaesmcq_u8(block[4]);
				block[5] = vaesmcq_u8(block[5]);
				block[6] = vaesmcq_u8(block[6]);
				block[7] = vaesmcq_u8(block[7]);
				block[8] = vaesmcq_u8(block[8]);

				block[0] = vaeseq_u8(block[0], expkey[7]);
				block[1] = vaeseq_u8(block[1], expkey[7]);
				block[2] = vaeseq_u8(block[2], expkey[7]);
				block[3] = vaeseq_u8(block[3], expkey[7]);
				block[4] = vaeseq_u8(block[4], expkey[7]);
				block[5] = vaeseq_u8(block[5], expkey[7]);
				block[6] = vaeseq_u8(block[6], expkey[7]);
				block[7] = vaeseq_u8(block[7], expkey[7]);
				block[8] = vaeseq_u8(block[8], expkey[7]);

				block[0] = vaesmcq_u8(block[0]);
				block[1] = vaesmcq_u8(block[1]);
				block[2] = vaesmcq_u8(block[2]);
				block[3] = vaesmcq_u8(block[3]);
				block[4] = vaesmcq_u8(block[4]);
				block[5] = vaesmcq_u8(block[5]);
				block[6] = vaesmcq_u8(block[6]);
				block[7] = vaesmcq_u8(block[7]);
				block[8] = vaesmcq_u8(block[8]);

				block[0] = vaeseq_u8(block[0], expkey[8]);
				block[1] = vaeseq_u8(block[1], expkey[8]);
				block[2] = vaeseq_u8(block[2], expkey[8]);
				block[3] = vaeseq_u8(block[3], expkey[8]);
				block[4] = vaeseq_u8(block[4], expkey[8]);
				block[5] = vaeseq_u8(block[5], expkey[8]);
				block[6] = vaeseq_u8(block[6], expkey[8]);
				block[7] = vaeseq_u8(block[7], expkey[8]);
				block[8] = vaeseq_u8(block[8], expkey[8]);

				block[0] = vaesmcq_u8(block[0]);
				block[1] = vaesmcq_u8(block[1]);
				block[2] = vaesmcq_u8(block[2]);
				block[3] = vaesmcq_u8(block[3]);
				block[4] = vaesmcq_u8(block[4]);
				block[5] = vaesmcq_u8(block[5]);
				block[6] = vaesmcq_u8(block[6]);
				block[7] = vaesmcq_u8(block[7]);
				block[8] = vaesmcq_u8(block[8]);

				block[0] = vaeseq_u8(block[0], expkey[9]);
				block[1] = vaeseq_u8(block[1], expkey[9]);
				block[2] = vaeseq_u8(block[2], expkey[9]);
				block[3] = vaeseq_u8(block[3], expkey[9]);
				block[4] = vaeseq_u8(block[4], expkey[9]);
				block[5] = vaeseq_u8(block[5], expkey[9]);
				block[6] = vaeseq_u8(block[6], expkey[9]);
				block[7] = vaeseq_u8(block[7], expkey[9]);
				block[8] = vaeseq_u8(block[8], expkey[9]);

				block[0] = veorq_u8(block[0], expkey[10]); 
				block[1] = veorq_u8(block[1], expkey[10]); 
				block[2] = veorq_u8(block[2], expkey[10]); 
				block[3] = veorq_u8(block[3], expkey[10]); 
				block[4] = veorq_u8(block[4], expkey[10]); 
				block[5] = veorq_u8(block[5], expkey[10]); 
				block[6] = veorq_u8(block[6], expkey[10]); 
				block[7] = veorq_u8(block[7], expkey[10]); 
				block[8] = veorq_u8(block[8], expkey[10]); 

				lblock[0] = block[0];
				lblock[1] = block[1];
				lblock[2] = block[2];
				lblock[3] = block[3];
				lblock[4] = block[4];
				lblock[5] = block[5];
				lblock[6] = block[6];
				lblock[7] = block[7];
				lblock[8] = block[8];
				
				vst1q_u8(&((uint8_t*)out)[16*(i+completedBlocks)], block[0]);
				vst1q_u8(&((uint8_t*)out)[16*(i+completedBlocks)+2048], block[1]);
				vst1q_u8(&((uint8_t*)out)[16*(i+completedBlocks)+4096], block[2]);
				vst1q_u8(&((uint8_t*)out)[16*(i+completedBlocks)+6144], block[3]);
				vst1q_u8(&((uint8_t*)out)[16*(i+completedBlocks)+8192], block[4]);
				vst1q_u8(&((uint8_t*)out)[16*(i+completedBlocks)+10240], block[5]);
				vst1q_u8(&((uint8_t*)out)[16*(i+completedBlocks)+12288], block[6]);
				vst1q_u8(&((uint8_t*)out)[16*(i+completedBlocks)+14336], block[7]);
				vst1q_u8(&((uint8_t*)out)[16*(i+completedBlocks)+16384], block[8]);
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

	uint8x16_t expkey[11] = {
		{0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c},
		{0xa0,0xfa,0xfe,0x17,0x88,0x54,0x2c,0xb1,0x23,0xa3,0x39,0x39,0x2a,0x6c,0x76,0x05},
		{0xf2,0xc2,0x95,0xf2,0x7a,0x96,0xb9,0x43,0x59,0x35,0x80,0x7a,0x73,0x59,0xf6,0x7f},
		{0x3d,0x80,0x47,0x7d,0x47,0x16,0xfe,0x3e,0x1e,0x23,0x7e,0x44,0x6d,0x7a,0x88,0x3b},
		{0xef,0x44,0xa5,0x41,0xa8,0x52,0x5b,0x7f,0xb6,0x71,0x25,0x3b,0xdb,0x0b,0xad,0x00},
		{0xd4,0xd1,0xc6,0xf8,0x7c,0x83,0x9d,0x87,0xca,0xf2,0xb8,0xbc,0x11,0xf9,0x15,0xbc},
		{0x6d,0x88,0xa3,0x7a,0x11,0x0b,0x3e,0xfd,0xdb,0xf9,0x86,0x41,0xca,0x00,0x93,0xfd},
		{0x4e,0x54,0xf7,0x0e,0x5f,0x5f,0xc9,0xf3,0x84,0xa6,0x4f,0xb2,0x4e,0xa6,0xdc,0x4f},
		{0xea,0xd2,0x73,0x21,0xb5,0x8d,0xba,0xd2,0x31,0x2b,0xf5,0x60,0x7f,0x8d,0x29,0x2f},
		{0xac,0x77,0x66,0xf3,0x19,0xfa,0xdc,0x21,0x28,0xd1,0x29,0x41,0x57,0x5c,0x00,0x6e},
		{0xd0,0x14,0xf9,0xa8,0xc9,0xee,0x25,0x89,0xe1,0x3f,0x0c,0xc8,0xb6,0x63,0x0c,0xa6}
	};

	unsigned char iv[16] = {
		0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F 
	};

  	struct timespec ts;
  	if (timespec_get(&ts, TIME_UTC) == 0) {

  	}
  	srandom(ts.tv_nsec ^ ts.tv_sec);  

  	unsigned char message[608256];
  	unsigned char cipher[608256];
  	uint8_t lengths[297] = {128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,
  		128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,
  		128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,
  		128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,
  		128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,
  		128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,
  		128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,
  		128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,
  		128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,
  		128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,
  		128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,
  		128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,
  		128,128,128,128,128,128,128,128,128,128,128,128,128,128};

	TIME_IT("AES-CBC-COMP-P6", combScheduler(message, cipher, lengths, 297, 9, expkey, iv), 608256, 1);

	int x = 123;
	//for (int i = 0; i<297; i++){
	x ^= message[0]^message[608255];
	//}
	printf("\n\nterminated with code %d\n", x);
	
	return x;
}
