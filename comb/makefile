CFLAGS=-std=c99 -O3 -march=native -funroll-loops

comb10.s:comb10.c
	aarch64-linux-gnu-gcc-5 -O3 -mcpu=cortex-a57+crypto -static -S -o $@ $^

comb10:comb10.c
	aarch64-linux-gnu-gcc-5 -O3 -mcpu=cortex-a57+crypto -static -s -o $@ $^
	scp comb10 phone:mikkel/report/

fun:fun.c
	aarch64-linux-gnu-gcc-5 -O3 -mcpu=cortex-a57+crypto -static -s -o $@ $^
	scp fun phone:mikkel/report/

fun-asm:fun.s
	aarch64-linux-gnu-gcc-5 -O3 -mcpu=cortex-a57+crypto -static -s -o $@ $^
	scp fun-asm phone:mikkel/report/

fun.s:fun.c
	aarch64-linux-gnu-gcc-5 -O3 -mcpu=cortex-a57+crypto -static -S -o $@ $^

combcbc-asm:combcbc.s
	aarch64-linux-gnu-gcc-5 -O3 -mcpu=cortex-a57+crypto -static -s -o $@ $^
	scp combcbc-asm phone:mikkel/report/


combcbc.s:combcbc.c
	aarch64-linux-gnu-gcc-5 -O3 -mcpu=cortex-a57+crypto -static -S -o $@ $^

combcbc:combcbc.c
	aarch64-linux-gnu-gcc-5 -O3 -mcpu=cortex-a57+crypto -static -s -o $@ $^
	scp combcbc phone:mikkel/report/

.PHONY: graphic
graphic:
	gnuplot < swperf.gnuplot
	#epstopdf --autorotate=All swperf.eps

