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

void aes_ecb(const unsigned char* in, unsigned char *out, 
			int length, const char *expkey)
{
	uint8x16_t block;
	for (int i = 0; i < length; i += 16){
		block = vld1q_u8(&((int8_t *)in)[i]);
		block = aes_enc(block, (uint8x16_t *)expkey);
		vst1q_u8(&((int8_t*)out)[i], block);
	}
}

int main(void){
	cpu_set_t cpuset;
  	CPU_ZERO(&cpuset); CPU_SET(7, &cpuset);
  	if (sched_setaffinity(getpid(), sizeof cpuset, &cpuset) != 0) perror("setaffinity");


	int nblocks = 4;
	int nbytes = nblocks * 16;
	int nbits = nbytes * 8;

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
	unsigned char message[16*128] = { 0 };

	unsigned char cipher[16*128] = { 0 };

	srand(time(NULL));

	for (int i = 0; i < 16*128; i++) {
	      message[i] = rand();
	}

	aes_ecb(message, cipher, 16*128, expkey);

	puts("timing");
	TIME_IT("AES-ECB", aes_ecb(cipher, cipher, 16*128, expkey), 16*128, 1);

	return cipher[0] ^ cipher[(16*128)-1];
}