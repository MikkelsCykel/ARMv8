
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

uint8_t aes_cbc_mac_auth_flag(uint8_t M, uint8_t L){
    return (((L-1)<<5)|(((M-2)/2)<<2)|0);
}

uint8_t aes_ctr_counter_flag(uint8_t L){
    return (((L-1)<<5)|(0));
}

void create_aes_nonce_block(unsigned char *block, const unsigned char *nonce, 
    uint8_t flag, uint32_t count){
    block[0] = flag;
    block[1] = nonce[1];
    block[2] = nonce[2];
    block[3] = nonce[3];
    block[4] = nonce[4];
    block[5] = nonce[5];
    block[6] = nonce[6];
    block[7] = nonce[7];
    block[8] = nonce[8];
    block[9] = nonce[9];
    block[10] = nonce[10];
    block[11] = nonce[11];
    block[12] = (count >> 24)  & 0xFF;
    block[13] = (count >> 16)  & 0xFF;
    block[14] = (count >> 8)   & 0xFF;
    block[15] = (count >> 0)   & 0xFF;
}

void ctr_counter_generation_function(unsigned char *block, const unsigned char *nonce, 
    uint8_t flag, int length){
    for (int i = 0; i < length; i += 16){
        create_aes_nonce_block(block+i, nonce, flag, i);
    }
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

uint8x16_t aes_cbc_mac(const unsigned char* auth_block,
    const unsigned char* in, int length, const char *expkey){
    uint8x16_t lastblock = {0};
    uint8x16_t block = veorq_u8(vld1q_u8(&((int8_t *)auth_block)[0]), lastblock);
    lastblock = aes_enc(block, (uint8x16_t *)expkey); 
    for (int i = 0; i < length; i += 16){
        block = vld1q_u8(&((int8_t *)in)[i]);
        block = veorq_u8(block, lastblock);
        lastblock = aes_enc(block, (uint8x16_t *)expkey);       
    }
    return lastblock;
}

void aes_ctr(const unsigned char* in, unsigned char *out, 
    int length, const char* counter, const char *expkey){
    uint8x16_t  block;
    for (int i = 0; i < length; i += 16)
    {   
        block = vld1q_u8(&((int8_t *)counter)[i+1]);
        block = aes_enc(block, (uint8x16_t *)expkey);
        block = veorq_u8(vld1q_u8(&((int8_t *)in)[i]), block);
        vst1q_u8(&((int8_t*)out)[i], block);
    }
}

void aes_ccm(uint8_t M, uint8_t L, uint32_t lm, 
    const unsigned char *message,  unsigned char *out,
    const unsigned char *nonce, unsigned char *counter, 
    const unsigned char *expkey){

    unsigned char auth_block[16];
    uint8_t aflag = aes_cbc_mac_auth_flag(M, L);
    uint8_t cflag = aes_ctr_counter_flag(L);
    ctr_counter_generation_function(counter, nonce, cflag, lm);
    create_aes_nonce_block(auth_block, nonce, aflag, lm);
    uint8x16_t cbc_mac_tag = aes_cbc_mac(auth_block, message, lm, expkey);
    aes_ctr(message, out, lm, counter, expkey);
    cbc_mac_tag = veorq_u8(cbc_mac_tag, vld1q_u8(&((int8_t *)counter)[0]));
    vst1q_u8(&((int8_t*)out)[lm], cbc_mac_tag);
}

int main(void){

    cpu_set_t cpuset;
    CPU_ZERO(&cpuset); CPU_SET(7, &cpuset);
    if (sched_setaffinity(getpid(), sizeof cpuset, &cpuset) != 0) perror("setaffinity");
    //M => the size of the authentication field (Valid values are 4, 6, 8, 10, 12, 14, and 16 octets)
    //L => Number of octets in length field L= l(m) blocks
    //K => Secret Key
    //N => nonce of 15-L octet
    //m => message of l(m) blocks
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

    unsigned char message[128*16] = { 0 };
    unsigned char cipher[129*16] = {0};
    unsigned char counter[128*16] = {0};
    unsigned char nonce[1*16] = { 0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F };
    
    srand(time(NULL));

    for (int i = 0; i < 16*128; i++) {
          message[i] = rand();
    }


    puts("timing");
    TIME_IT("AES-CCM", aes_ccm(16, 8, 16*128, cipher, cipher, nonce, counter, expkey), 16*128, 1);

    return cipher[0] ^ cipher[(16*128)-1] ^ cipher[(16*128)-1];
}
