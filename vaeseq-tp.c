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

#define _GNU_SOURCE             /* See feature_test_macros(7) */
#define __USE_GNU
#include <sched.h>
#include <arm_neon.h>
#define REPEAT 50000000
#define WARMUP REPEAT/4
uint64_t start_clk, end_clk;
double total_clk;


__inline uint64_t get_Clks(void) {
	struct timeval tv;
	gettimeofday(&tv, NULL);
	return (tv.tv_sec * 1e6 + tv.tv_usec); // usec
}

#define MEASURE(x)  for (int i=0; i< WARMUP; i++){x;}    \
					start_clk=get_Clks();                \
					for (int i = 0; i < REPEAT; i++)     \
					{                                    \
								 {x;}                    \
					}                                    \
					end_clk=get_Clks();                  \
					total_clk=(double)(end_clk-start_clk)*2.1e3/REPEAT;

#define TIME_IT(name, func, nbytes, MULTIPLE)            \
	printf("%s-%d: ", name, nbytes);                     \
	MEASURE(func);                                       \
	printf("%g cpb\n", total_clk/(nbytes)/(MULTIPLE));

/*void aes_enc(const unsigned char *in, unsigned char *out, int length, const unsigned char *k){
	uint8x16_t b;
	for (int i = 0; i < length; i += 16){
		 b = vld1q_u8(&((int8_t *)in)[i]);
		 b = vaeseq_u8(b, vld1q_u8(&((int8_t *)k)[i]));
		 vst1q_u8(&((int8_t*)out)[i], b);
	}
}*/

void aes_enc(uint8x16_t *in, uint8x16_t *out, int length, uint8x16_t *k){
	for (int i = 0; i < length; i++){
		 vst1q_u8(&((int8_t*)out)[i], vaeseq_u8(in[i], k[i]));
	}
}


int main(void)
{
	cpu_set_t cpuset;
  	CPU_ZERO(&cpuset); CPU_SET(7, &cpuset);
  	if (sched_setaffinity(getpid(), sizeof cpuset, &cpuset) != 0) perror("setaffinity");

/*	unsigned char message[128*16] = { 0 };
	unsigned char cipher[128*16] = { 0 };
	unsigned char keys[128*16] = { 0 };*/

	uint8x16_t blocks[128];
	uint8x16_t cipher[128];
	uint8x16_t keys[128];

	srand(time(NULL));
	for (int i = 0; i < 128; i++) {
		for (int j=0; j < 16; j++) { 
			blocks[i][j] = rand();
	      	keys[i][j] = rand();
		}
	}

	aes_enc(blocks, cipher, 128, keys);



	TIME_IT("vaeseq_u8", aes_enc(cipher, cipher, 128, keys), 2048, 1);

	return cipher[0][0] ^ cipher[0][15] ^ cipher[127][15] ^ cipher[127][0];
}
