CFLAGS=-std=c99 -O3 -march=native -funroll-loops

combcbc-asm:comb/combcbc.s
	aarch64-linux-gnu-gcc-5 -O3 -mcpu=cortex-a57+crypto -static -s -o $@ $^
	scp combcbc-asm phone:mikkel/report/


combcbc.s:comb/combcbc.c
	aarch64-linux-gnu-gcc-5 -O3 -mcpu=cortex-a57+crypto -static -S -o $@ $^

combcbc:comb/combcbc.c
	aarch64-linux-gnu-gcc-5 -O3 -mcpu=cortex-a57+crypto -static -s -o $@ $^
	scp combcbc phone:mikkel/report/

clock:clock.c
	aarch64-linux-gnu-gcc-5 -O3 -mcpu=cortex-a57+crypto -static -s -o $@ $^
	scp clock phone:mikkel/report/

flag:flag.c
	aarch64-linux-gnu-gcc-5 -O3 -mcpu=cortex-a57+crypto -static -s -o $@ $^
	scp flag phone:mikkel/report/

ecbo1:ecb.c
	aarch64-linux-gnu-gcc-5 -O1 -mcpu=cortex-a57+crypto -static -s -o $@ $^
	scp ecbo1 phone:mikkel/report/

ecb.s:ecb.c
	aarch64-linux-gnu-gcc-5 -O3 -mcpu=cortex-a57+crypto -static -S -o $@ $^

ecb:ecb.c
	aarch64-linux-gnu-gcc-5 -O3 -mcpu=cortex-a57+crypto -static -s -o $@ $^
	scp ecb phone:mikkel/report/

vaeseq-lat:vaeseq-lat.c
	aarch64-linux-gnu-gcc-5 -O3 -mcpu=cortex-a57+crypto -static -s -o $@ $^
	scp vaeseq-lat phone:mikkel/report/

vaeseq-lat.s:vaeseq-lat.c
	aarch64-linux-gnu-gcc-5 -O3 -mcpu=cortex-a57+crypto -static -S -o $@ $^

vaeseq-tp:vaeseq-tp.c
	aarch64-linux-gnu-gcc-5 -O3 -mcpu=cortex-a57+crypto -static -s -o $@ $^
	scp vaeseq-tp phone:mikkel/report/

vaesmcq-tp-asm:vaesmcq-tp.s
	aarch64-linux-gnu-gcc-5 -O3 -mcpu=cortex-a57+crypto -static -s -o $@ $^
	scp vaesmcq-tp-asm phone:mikkel/report/

vaesmcq-tp:vaesmcq-tp.c
	aarch64-linux-gnu-gcc-5 -O3 -mcpu=cortex-a57+crypto -static -s -o $@ $^
	scp vaesmcq-tp phone:mikkel/report/

vaesmcq-tp.s:vaesmcq-tp.c
	aarch64-linux-gnu-gcc-5 -O3 -mcpu=cortex-a57+crypto -static -S -o $@ $^


.PHONY: graphic
graphic:
	gnuplot < swperf.gnuplot
	#epstopdf --autorotate=All swperf.eps
