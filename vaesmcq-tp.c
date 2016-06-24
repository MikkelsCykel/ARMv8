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

__inline uint64_t get_Clks(void) {
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return (tv.tv_sec * 1e6 + tv.tv_usec); // usec
}

int main(void)
{
    cpu_set_t cpuset;
    CPU_ZERO(&cpuset); CPU_SET(7, &cpuset);
    if (sched_setaffinity(getpid(), sizeof cpuset, &cpuset) != 0) perror("setaffinity");
    int64_t start_clk, end_clk;
    double total_clk;
    int q;
    uint32x4_t a = { 0xA579D,  0x538FE03, 0x1718192, 0xF00DA};
    uint32x4_t b = { 0x4234D,  0xBD0A505, 0x0212223, 0x132DA};
    uint32x4_t c = { 0x9DF33,  0x12EE567, 0x24AD262, 0xF0DDD};
    uint32x4_t d = { 0xAA66A,  0x8910111, 0x2829303, 0x120DA};
    uint32x4_t e = { 0xA1432,  0x131FD22, 0x13ED334, 0xDD0F2};
    uint32x4_t f = { 0xDD321,  0x1BBCC21, 0x1AAAAA4, 0xEEE72};
    uint32x4_t g = { 0xA9022,  0x1314151, 0xFF1FE11, 0xFF292};
    uint32x4_t h = { 0xBBCDBB,  0x1BA4451, 0x1323334, 0xF0322};
    uint32x4_t i = { 0xA4332,  0x131B911, 0xC41F2F1, 0xFB992};
    uint32x4_t j = { 0xBBBBB,  0x1EE2A51, 0x1FFF334, 0xF0DC2};
    uint32x4_t k = { 0xACBB2,  0x13AAB77, 0xFD222F1, 0xF0332};
    uint32x4_t l = { 0xBDBA3,  0x1DC3252, 0x13EEED1, 0xFDD22};
    uint32x4_t shablock1 = { 0xDFDD444,  0x5944E03, 0xB865405, 0xD22D1A};
    uint32x4_t shablock2 = { 0x25FB391,  0x126A7, 0x36F2AAE9, 0x8938};
    uint32_t hblock = 0x4D2FA200;
    
    start_clk = get_Clks();
    for(q=0; q<1000000; q++){
       a = vsha256su1q_u32(a, shablock2, shablock1);
       b = vsha256su1q_u32(b, shablock2, shablock1);
       c = vsha256su1q_u32(c, shablock2, shablock1);
       d = vsha256su1q_u32(d, shablock2, shablock1);
       e = vsha256su1q_u32(e, shablock2, shablock1);
       f = vsha256su1q_u32(f, shablock2, shablock1);
       g = vsha256su1q_u32(g, shablock2, shablock1);
       h = vsha256su1q_u32(h, shablock2, shablock1);
       i = vsha256su1q_u32(i, shablock2, shablock1);
       j = vsha256su1q_u32(j, shablock2, shablock1);
       k = vsha256su1q_u32(k, shablock2, shablock1);
       l = vsha256su1q_u32(l, shablock2, shablock1);
    }
    end_clk = get_Clks();
    total_clk=(double)(end_clk-start_clk)*2.1e3;
    printf("%g\n", total_clk);

    return a[0]^a[3]^b[0]^b[3]^c[0]^c[3]^d[0]^d[3]^e[0]^e[3]^f[0]^f[3]^g[0]^g[3]^h[0]^h[3]^i[0]^i[3]^j[0]^j[3]^k[0]^k[3]^l[0]^l[3]^shablock2[0]^shablock2[3];
}
