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
#define REPEAT 1000000000
#define WARMUP REPEAT/4
uint64_t start_clk, end_clk;
double total_clk;



__inline__ uint64_t get_Clks(void) {
	uint32_t __r;
	__asm__ __volatile__("mrs %0, pmccntr_el0" : "=r" (__r));
	return __r;
}

/*__inline uint64_t get_Clks(void) {
	struct timeval tv;
	gettimeofday(&tv, NULL);
	return (tv.tv_sec * 1e6 + tv.tv_usec); // usec
}*/

#define MEASURE(x)  for (int i=0; i< WARMUP; i++){x;}    \
					start_clk=get_Clks();                \
					for (int i = 0; i < REPEAT; i++)     \
					{                                    \
								 {x;}                    \
					}                                    \
					end_clk=get_Clks();                  \
					total_clk=(double)(end_clk-start_clk)*2.1e3/REPEAT;

#define TIME_IT(name, func)                              \
	MEASURE(func);                                       \
	printf("%g cpb\n", total_clk);


int main(void)
{
	cpu_set_t cpuset;
  	CPU_ZERO(&cpuset); CPU_SET(7, &cpuset);
  	if (sched_setaffinity(getpid(), sizeof cpuset, &cpuset) != 0) perror("setaffinity");
	uint8x16_t block = { 0xae,0x2d,0x8a,0x57,0x1e,0x03,0xac,0x9c,0x9e,0xb7,0x6f,0xac,0x45,0xaf,0x8e,0x51};
	uint8x16_t key = {0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c};

	
	TIME_IT("vaeseq_u8", block = vaeseq_u8(block, key));

	return block[0] ^ block[15];
}
