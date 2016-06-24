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
#define REPEAT 10000
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

void printblock(uint8x16_t x)
{
    for (int i = 0; i < 16; i++) {
        if(i%4 == 0 && i != 0){
            putchar(' ');
        }
        printf("%02x", x[i]);
    }
    putchar('\n');
}


void fun(uint8x16_t out, uint8x16_t k, unsigned char *out){
  	for (int i = 0; i < 128; i++){
  		out = vaeseq_u8(out, k);
  	}
  	vst1q_u8(&((int8_t*)out), out);
}


int main(void){
	cpu_set_t cpuset;
  	CPU_ZERO(&cpuset); CPU_SET(7, &cpuset);
  	if (sched_setaffinity(getpid(), sizeof cpuset, &cpuset) != 0) perror("setaffinity");

  	uint8x16_t b = {0};
  	uint8x16_t k = {1};
  	unsigned char out[16];
  	TIME_IT("performance:", fun(b, k, out), 614400, 1);
	

  	printblock(out);

	return out[0]^out[15];	

}