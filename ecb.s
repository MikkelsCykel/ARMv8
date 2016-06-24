	.cpu cortex-a57+fp+simd+crypto+crc
	.file	"ecb.c"
	.text
	.align	2
	.p2align 4,,15
	.global	printblock
	.type	printblock, %function
printblock:
	stp	x29, x30, [sp, -48]!
	add	x29, sp, 0
	stp	x19, x20, [sp, 16]
	mov	x20, x0
	mov	w19, 0
	stp	x21, x22, [sp, 32]
	adrp	x21, .LC1
	add	x21, x21, :lo12:.LC1
	adrp	x22, stdout
	.p2align 2
.L2:
	ldrb	w2, [x20]
	mov	x1, x21
	mov	w0, 1
	bl	__printf_chk
	add	w19, w19, 1
	add	x20, x20, 1
	cmp	w19, 16
	mov	w0, 32
	and	w1, w19, 3
	beq	.L7
	cbnz	w1, .L2
	ldr	x1, [x22, #:lo12:stdout]
	bl	_IO_putc
	b	.L2
	.p2align 3
.L7:
	ldr	x1, [x22, #:lo12:stdout]
	mov	w0, 10
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 48
	b	_IO_putc
	.size	printblock, .-printblock
	.align	2
	.p2align 4,,15
	.global	aes_enc_rnd
	.type	aes_enc_rnd, %function
aes_enc_rnd:
	aese	v0.16b, v1.16b
	aesmc	v0.16b, v0.16b
	ret
	.size	aes_enc_rnd, .-aes_enc_rnd
	.align	2
	.p2align 4,,15
	.global	aes_enc
	.type	aes_enc, %function
aes_enc:
	ldr	q4, [x0]
	ldr	q3, [x0, 16]
	ldr	q2, [x0, 32]
	aese	v0.16b, v4.16b
	ldr	q1, [x0, 48]
	ldr	q7, [x0, 64]
	aesmc	v0.16b, v0.16b
	ldr	q6, [x0, 80]
	ldr	q5, [x0, 96]
	aese	v0.16b, v3.16b
	ldr	q4, [x0, 112]
	ldr	q3, [x0, 128]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v2.16b
	ldr	q2, [x0, 144]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x0, 160]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v7.16b
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v6.16b
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v5.16b
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v4.16b
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v3.16b
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v2.16b
	eor	v0.16b, v0.16b, v1.16b
	ret
	.size	aes_enc, .-aes_enc
	.align	2
	.p2align 4,,15
	.global	aes_ecb
	.type	aes_ecb, %function
aes_ecb:
	cmp	w2, wzr
	mov	x4, 0
	ble	.L10
	.p2align 2
.L14:
	ldr	q0, [x0, x4]
	ldr	q19, [x3]
	ldr	q18, [x3, 16]
	ldr	q17, [x3, 32]
	aese	v0.16b, v19.16b
	ldr	q16, [x3, 48]
	ldr	q7, [x3, 64]
	aesmc	v0.16b, v0.16b
	ldr	q6, [x3, 80]
	ldr	q5, [x3, 96]
	aese	v0.16b, v18.16b
	ldr	q4, [x3, 112]
	ldr	q3, [x3, 128]
	aesmc	v0.16b, v0.16b
	ldr	q2, [x3, 144]
	ldr	q1, [x3, 160]
	aese	v0.16b, v17.16b
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v16.16b
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v7.16b
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v6.16b
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v5.16b
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v4.16b
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v3.16b
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v2.16b
	eor	v0.16b, v0.16b, v1.16b
	str	q0, [x1, x4]
	add	x4, x4, 16
	cmp	w2, w4
	bgt	.L14
.L10:
	ret
	.size	aes_ecb, .-aes_ecb
	.section	.text.startup,"ax",%progbits
	.align	2
	.p2align 4,,15
	.global	main
	.type	main, %function
main:
	sub	sp, sp, #1888
	stp	x29, x30, [sp, -112]!
	add	x29, sp, 0
	add	x0, x29, 328
	stp	x19, x20, [sp, 16]
	mov	x19, 128
	stp	x23, x24, [sp, 48]
	stp	x21, x22, [sp, 32]
	stp	x25, x26, [sp, 64]
	stp	x27, x28, [sp, 80]
	str	d8, [sp, 96]
	stp	xzr, xzr, [x0]
	adrp	x23, __stack_chk_guard
	add	x0, x23, :lo12:__stack_chk_guard
	ldr	x1, [x0]
	str	x1, [x29, 1992]
	mov	x1,0
	add	x0, x29, 344
	str	x19, [x29, 328]
	stp	xzr, xzr, [x0]
	add	x0, x29, 360
	stp	xzr, xzr, [x0]
	add	x0, x29, 376
	stp	xzr, xzr, [x0]
	add	x0, x29, 392
	stp	xzr, xzr, [x0]
	add	x0, x29, 408
	stp	xzr, xzr, [x0]
	add	x0, x29, 424
	stp	xzr, xzr, [x0]
	add	x0, x29, 440
	stp	xzr, xzr, [x0]
	bl	getpid
	add	x2, x29, 328
	mov	x1, x19
	bl	sched_setaffinity
	cbnz	w0, .L42
.L17:
	adrp	x3, .LANCHOR0
	add	x3, x3, :lo12:.LANCHOR0
	add	x26, x29, 456
	mov	x2, 512
	ldr	q0, [x3]
	mov	w1, 0
	mov	x0, x26
	mov	w20, 3
	mov	w24, -98
	mov	w21, -81
	mov	w22, -106
	mov	w28, 123
	add	x19, x29, 968
	adrp	x27, .LC1
	add	x25, x27, :lo12:.LC1
	str	q0, [x29, 256]
	ldr	q0, [x3, 16]
	str	q0, [x29, 272]
	ldr	q0, [x3, 32]
	str	q0, [x29, 288]
	ldr	q0, [x3, 48]
	str	q0, [x29, 224]
	ldr	q0, [x3, 64]
	str	q0, [x29, 208]
	ldr	q0, [x3, 80]
	str	q0, [x29, 128]
	ldr	q0, [x3, 96]
	str	q0, [x29, 144]
	ldr	q0, [x3, 112]
	str	q0, [x29, 192]
	ldr	q0, [x3, 128]
	str	q0, [x29, 160]
	ldr	q0, [x3, 144]
	str	q0, [x29, 240]
	ldr	q0, [x3, 160]
	str	q0, [x29, 176]
	bl	memset
	mov	w3, 115
	mov	w0, 107
	strb	w24, [x29, 480]
	mov	w1, -114
	mov	w7, -63
	strb	w21, [x29, 485]
	strb	w3, [x29, 468]
	mov	w3, -109
	mov	w8, 17
	strb	w0, [x29, 456]
	mov	w0, -66
	mov	w2, -97
	strb	w3, [x29, 469]
	mov	w3, 42
	mov	w9, 48
	strb	w0, [x29, 458]
	mov	w0, -30
	mov	w5, -17
	strb	w3, [x29, 471]
	mov	w3, -82
	mov	w6, 36
	strb	w0, [x29, 459]
	mov	w0, 46
	strb	w3, [x29, 472]
	mov	w3, 45
	strb	w0, [x29, 460]
	mov	w0, 64
	strb	w3, [x29, 473]
	mov	w3, -118
	strb	w0, [x29, 461]
	mov	w0, -23
	strb	w3, [x29, 474]
	mov	w3, 87
	strb	w0, [x29, 464]
	mov	w0, 61
	strb	w3, [x29, 475]
	mov	w3, 30
	strb	w1, [x29, 486]
	mov	w1, -84
	strb	w3, [x29, 476]
	mov	w3, -100
	strb	w0, [x29, 465]
	mov	w0, 126
	strb	w3, [x29, 479]
	mov	w3, -73
	strb	w0, [x29, 466]
	mov	w0, 23
	strb	w3, [x29, 481]
	mov	w3, 111
	strb	w1, [x29, 478]
	strb	w1, [x29, 483]
	mov	w1, 69
	strb	w3, [x29, 482]
	mov	w3, 81
	strb	w7, [x29, 457]
	strb	w8, [x29, 467]
	strb	w2, [x29, 462]
	strb	w0, [x29, 470]
	strb	w1, [x29, 484]
	strb	w3, [x29, 487]
	mov	w3, -83
	strb	w22, [x29, 463]
	strb	w20, [x29, 477]
	strb	w9, [x29, 488]
	strb	w0, [x29, 511]
	mov	w0, -56
	strb	w5, [x29, 503]
	strb	w0, [x29, 489]
	mov	w0, 28
	strb	w6, [x29, 506]
	strb	w0, [x29, 490]
	mov	w0, 70
	strb	w3, [x29, 512]
	strb	w0, [x29, 491]
	mov	w0, -93
	stp	w5, w6, [x29, 116]
	strb	w0, [x29, 492]
	mov	w0, 92
	str	w3, [x29, 124]
	strb	w0, [x29, 493]
	mov	w0, -28
	strb	w8, [x29, 495]
	strb	w0, [x29, 494]
	mov	w0, -27
	strb	w7, [x29, 498]
	strb	w0, [x29, 496]
	mov	w0, -5
	strb	w2, [x29, 505]
	mov	x2, 512
	strb	w0, [x29, 497]
	mov	w0, 25
	strb	w1, [x29, 507]
	mov	w1, 0
	strb	w0, [x29, 499]
	mov	w0, 26
	strb	w28, [x29, 515]
	strb	w0, [x29, 500]
	mov	w0, 10
	strb	w0, [x29, 501]
	mov	w0, 82
	strb	w0, [x29, 502]
	mov	w0, -10
	strb	w0, [x29, 504]
	mov	w0, -33
	strb	w0, [x29, 508]
	mov	w0, 79
	strb	w0, [x29, 509]
	mov	w0, -101
	strb	w0, [x29, 510]
	mov	w0, 43
	strb	w0, [x29, 513]
	mov	w0, 65
	strb	w0, [x29, 514]
	mov	w0, -26
	strb	w0, [x29, 516]
	mov	w0, 108
	strb	w0, [x29, 517]
	mov	w0, 55
	strb	w0, [x29, 518]
	mov	w0, 16
	strb	w0, [x29, 519]
	mov	x0, x19
	bl	memset
	mov	x2, 512
	mov	w1, 0
	add	x0, x29, 1480
	bl	memset
	mov	w0, -123
	ldp	w5, w6, [x29, 116]
	mov	w1, -120
	strb	w24, [x29, 1489]
	mov	w2, 67
	mov	w4, 63
	strb	w0, [x29, 1499]
	adrp	x24, stdout
	strb	w0, [x29, 1505]
	mov	w0, 58
	strb	w21, [x29, 1511]
	mov	x21, x26
	strb	w0, [x29, 1480]
	mov	w0, -41
	strb	w28, [x29, 1482]
	strb	w0, [x29, 1481]
	mov	w0, -76
	strb	w5, [x29, 1494]
	mov	w5, 12
	strb	w0, [x29, 1483]
	mov	w0, 13
	strb	w22, [x29, 1508]
	strb	w0, [x29, 1484]
	mov	w0, 122
	strb	w20, [x29, 1500]
	strb	w0, [x29, 1485]
	mov	w0, 54
	strb	w6, [x29, 1492]
	strb	w0, [x29, 1486]
	mov	w0, 96
	strb	w0, [x29, 1487]
	mov	w0, -88
	strb	w0, [x29, 1488]
	mov	w0, -54
	strb	w0, [x29, 1490]
	mov	w0, -13
	strb	w0, [x29, 1491]
	mov	w0, 102
	strb	w0, [x29, 1493]
	mov	w0, -105
	strb	w0, [x29, 1495]
	mov	w0, -11
	strb	w0, [x29, 1496]
	mov	w0, -45
	strb	w0, [x29, 1497]
	mov	w0, -43
	strb	w0, [x29, 1498]
	mov	w0, -71
	strb	w0, [x29, 1501]
	mov	w0, 105
	strb	w0, [x29, 1502]
	mov	w0, -99
	strb	w0, [x29, 1503]
	mov	w0, -25
	strb	w0, [x29, 1504]
	mov	w0, -119
	strb	w0, [x29, 1506]
	mov	w0, 90
	strb	w0, [x29, 1507]
	mov	w0, -3
	strb	w0, [x29, 1509]
	mov	w0, -70
	strb	w1, [x29, 1520]
	strb	w1, [x29, 1527]
	mov	w1, 120
	ldr	w3, [x29, 124]
	strb	w1, [x29, 1530]
	mov	w1, 94
	strb	w2, [x29, 1512]
	mov	w2, -114
	strb	w1, [x29, 1531]
	mov	w1, 39
	strb	w0, [x29, 1510]
	mov	w0, 35
	strb	w1, [x29, 1532]
	mov	w1, -24
	strb	w2, [x29, 1517]
	mov	w2, -126
	strb	w1, [x29, 1533]
	mov	w1, -79
	strb	w0, [x29, 1519]
	strb	w1, [x29, 1513]
	mov	w1, -51
	strb	w0, [x29, 1537]
	mov	w0, 113
	strb	w1, [x29, 1514]
	mov	w1, 127
	strb	w2, [x29, 1536]
	mov	w2, 4
	strb	w1, [x29, 1515]
	mov	w1, 89
	strb	w3, [x29, 1534]
	mov	w3, 32
	strb	w1, [x29, 1516]
	mov	w1, -50
	strb	w0, [x29, 1539]
	mov	w0, 114
	strb	w1, [x29, 1518]
	mov	w1, 27
	strb	w2, [x29, 1540]
	mov	w2, -44
	strb	w1, [x29, 1521]
	mov	w1, -29
	strb	w3, [x29, 1538]
	mov	w3, 93
	strb	w1, [x29, 1523]
	mov	w1, -19
	strb	w28, [x29, 1528]
	add	x28, x26, 64
	strb	w1, [x29, 1524]
	mov	w1, 6
	strb	w0, [x29, 1541]
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	strb	w20, [x29, 1525]
	strb	w5, [x29, 1529]
	strb	w4, [x29, 1535]
	strb	w2, [x29, 1543]
	strb	w3, [x29, 1542]
	strb	w1, [x29, 1526]
	bl	puts
.L21:
	mov	x22, x21
	mov	w20, 0
	ldrb	w2, [x22]
	mov	x1, x25
	mov	w0, 1
	bl	__printf_chk
	add	w20, w20, 1
	cmp	w20, 16
	beq	.L43
	.p2align 2
.L20:
	and	w0, w20, 3
	cbnz	w0, .L19
	ldr	x1, [x24, #:lo12:stdout]
	mov	w0, 32
	bl	_IO_putc
.L19:
	add	x22, x22, 1
	ldrb	w2, [x22]
	mov	x1, x25
	mov	w0, 1
	add	w20, w20, 1
	bl	__printf_chk
	cmp	w20, 16
	bne	.L20
.L43:
	ldr	x1, [x24, #:lo12:stdout]
	mov	w0, 10
	add	x21, x21, 16
	bl	_IO_putc
	cmp	x21, x28
	bne	.L21
	mov	x0, 0
.L22:
	ldr	q0, [x26, x0]
	ldr	q1, [x29, 256]
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 272]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 288]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 224]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 208]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 128]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 144]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 192]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 160]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 240]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 176]
	eor	v0.16b, v0.16b, v1.16b
	str	q0, [x19, x0]
	add	x0, x0, 16
	cmp	x0, 64
	bne	.L22
	adrp	x0, .LC4
	add	x0, x0, :lo12:.LC4
	mov	x25, 0
	add	x21, x27, :lo12:.LC1
	bl	puts
.L29:
	add	x22, x19, x25
	mov	w20, 0
	ldrb	w2, [x22]
	mov	x1, x21
	mov	w0, 1
	bl	__printf_chk
	add	w20, w20, 1
	cmp	w20, 16
	beq	.L44
	.p2align 2
.L25:
	and	w0, w20, 3
	cbnz	w0, .L24
	ldr	x1, [x24, #:lo12:stdout]
	mov	w0, 32
	bl	_IO_putc
.L24:
	add	x22, x22, 1
	ldrb	w2, [x22]
	mov	x1, x21
	mov	w0, 1
	add	w20, w20, 1
	bl	__printf_chk
	cmp	w20, 16
	bne	.L25
.L44:
	ldr	x1, [x24, #:lo12:stdout]
	add	x2, x29, 1480
	mov	w0, 10
	add	x22, x2, x25
	mov	w20, 0
	bl	_IO_putc
	ldrb	w2, [x22]
	mov	x1, x21
	mov	w0, 1
	bl	__printf_chk
	add	w20, w20, 1
	cmp	w20, 16
	beq	.L45
	.p2align 2
.L28:
	and	w0, w20, 3
	cbnz	w0, .L27
	ldr	x1, [x24, #:lo12:stdout]
	mov	w0, 32
	bl	_IO_putc
.L27:
	add	x22, x22, 1
	ldrb	w2, [x22]
	mov	x1, x21
	mov	w0, 1
	add	w20, w20, 1
	bl	__printf_chk
	cmp	w20, 16
	bne	.L28
.L45:
	ldr	x1, [x24, #:lo12:stdout]
	mov	w0, 10
	add	x25, x25, 16
	bl	_IO_putc
	cmp	x25, 64
	bne	.L29
	adrp	x0, .LC5
	add	x0, x0, :lo12:.LC5
	bl	puts
	adrp	x2, .LC6
	adrp	x1, .LC7
	mov	w3, w20
	add	x2, x2, :lo12:.LC6
	add	x1, x1, :lo12:.LC7
	mov	w0, 1
	bl	__printf_chk
	ldr	q0, [x19]
	mov	w0, 48160
	movk	w0, 0xbe, lsl 16
	.p2align 2
.L30:
	subs	w0, w0, #1
	ldr	q1, [x29, 256]
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 272]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 288]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 224]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 208]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 128]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 144]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 192]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 160]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 240]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 176]
	eor	v0.16b, v1.16b, v0.16b
	str	q0, [x19]
	bne	.L30
	mov	x1, 0
	add	x0, x29, 312
	bl	gettimeofday
	ldp	x1, x2, [x29, 312]
	adrp	x20, start_clk
	mov	w0, 61568
	movk	w0, 0x2fa, lsl 16
	ldr	d8, .LC8
	scvtf	d0, x1
	scvtf	d1, x2
	fmadd	d0, d0, d8, d1
	fcvtzu	x1, d0
	str	x1, [x20, #:lo12:start_clk]
	ldr	q0, [x19]
	.p2align 2
.L31:
	subs	w0, w0, #1
	ldr	q1, [x29, 256]
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 272]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 288]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 224]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 208]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 128]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 144]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 192]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 160]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 240]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v1.16b
	ldr	q1, [x29, 176]
	eor	v0.16b, v1.16b, v0.16b
	str	q0, [x19]
	bne	.L31
	mov	x1, 0
	add	x0, x29, 312
	bl	gettimeofday
	ldp	x3, x4, [x29, 312]
	adrp	x6, end_clk
	adrp	x5, total_clk
	adrp	x1, .LC12
	mov	w0, 1
	ldr	x2, [x20, #:lo12:start_clk]
	add	x1, x1, :lo12:.LC12
	add	x23, x23, :lo12:__stack_chk_guard
	ldr	d1, .LC9
	scvtf	d3, x3
	scvtf	d2, x4
	ldr	d4, .LC10
	ldr	d0, .LC11
	fmadd	d2, d3, d8, d2
	fcvtzu	x3, d2
	sub	x2, x3, x2
	str	x3, [x6, #:lo12:end_clk]
	ucvtf	d2, x2
	fmul	d1, d2, d1
	fdiv	d1, d1, d4
	fmul	d0, d1, d0
	str	d1, [x5, #:lo12:total_clk]
	bl	__printf_chk
	ldrb	w2, [x29, 968]
	ldr	x3, [x29, 1992]
	ldr	x1, [x23]
	eor	x1, x3, x1
	ldrb	w0, [x29, 1479]
	eor	w0, w2, w0
	uxtb	w0, w0
	cbnz	x1, .L46
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	ldr	d8, [sp, 96]
	ldp	x29, x30, [sp], 112
	add	sp, sp, 1888
	ret
.L42:
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	perror
	b	.L17
.L46:
	bl	__stack_chk_fail
	.size	main, .-main
	.align	3
.LC8:
	.word	0
	.word	1093567616
	.align	3
.LC9:
	.word	0
	.word	1084254208
	.align	3
.LC10:
	.word	0
	.word	1099421572
	.align	3
.LC11:
	.word	0
	.word	1068498944
	.comm	total_clk,8,8
	.comm	end_clk,8,8
	.comm	start_clk,8,8
	.section	.rodata
	.align	3
.LANCHOR0 = . + 0
.LC0:
	.byte	43
	.byte	126
	.byte	21
	.byte	22
	.byte	40
	.byte	-82
	.byte	-46
	.byte	-90
	.byte	-85
	.byte	-9
	.byte	21
	.byte	-120
	.byte	9
	.byte	-49
	.byte	79
	.byte	60
	.byte	-96
	.byte	-6
	.byte	-2
	.byte	23
	.byte	-120
	.byte	84
	.byte	44
	.byte	-79
	.byte	35
	.byte	-93
	.byte	57
	.byte	57
	.byte	42
	.byte	108
	.byte	118
	.byte	5
	.byte	-14
	.byte	-62
	.byte	-107
	.byte	-14
	.byte	122
	.byte	-106
	.byte	-71
	.byte	67
	.byte	89
	.byte	53
	.byte	-128
	.byte	122
	.byte	115
	.byte	89
	.byte	-10
	.byte	127
	.byte	61
	.byte	-128
	.byte	71
	.byte	125
	.byte	71
	.byte	22
	.byte	-2
	.byte	62
	.byte	30
	.byte	35
	.byte	126
	.byte	68
	.byte	109
	.byte	122
	.byte	-120
	.byte	59
	.byte	-17
	.byte	68
	.byte	-91
	.byte	65
	.byte	-88
	.byte	82
	.byte	91
	.byte	127
	.byte	-74
	.byte	113
	.byte	37
	.byte	59
	.byte	-37
	.byte	11
	.byte	-83
	.byte	0
	.byte	-44
	.byte	-47
	.byte	-58
	.byte	-8
	.byte	124
	.byte	-125
	.byte	-99
	.byte	-121
	.byte	-54
	.byte	-14
	.byte	-72
	.byte	-68
	.byte	17
	.byte	-7
	.byte	21
	.byte	-68
	.byte	109
	.byte	-120
	.byte	-93
	.byte	122
	.byte	17
	.byte	11
	.byte	62
	.byte	-3
	.byte	-37
	.byte	-7
	.byte	-122
	.byte	65
	.byte	-54
	.byte	0
	.byte	-109
	.byte	-3
	.byte	78
	.byte	84
	.byte	-9
	.byte	14
	.byte	95
	.byte	95
	.byte	-55
	.byte	-13
	.byte	-124
	.byte	-90
	.byte	79
	.byte	-78
	.byte	78
	.byte	-90
	.byte	-36
	.byte	79
	.byte	-22
	.byte	-46
	.byte	115
	.byte	33
	.byte	-75
	.byte	-115
	.byte	-70
	.byte	-46
	.byte	49
	.byte	43
	.byte	-11
	.byte	96
	.byte	127
	.byte	-115
	.byte	41
	.byte	47
	.byte	-84
	.byte	119
	.byte	102
	.byte	-13
	.byte	25
	.byte	-6
	.byte	-36
	.byte	33
	.byte	40
	.byte	-47
	.byte	41
	.byte	65
	.byte	87
	.byte	92
	.byte	0
	.byte	110
	.byte	-48
	.byte	20
	.byte	-7
	.byte	-88
	.byte	-55
	.byte	-18
	.byte	37
	.byte	-119
	.byte	-31
	.byte	63
	.byte	12
	.byte	-56
	.byte	-74
	.byte	99
	.byte	12
	.byte	-90
	.section	.rodata.str1.8,"aMS",%progbits,1
	.align	3
.LC1:
	.string	"%02x"
	.zero	3
.LC2:
	.string	"setaffinity"
	.zero	4
.LC3:
	.string	"message:"
	.zero	7
.LC4:
	.string	"ciphertext vs expected:"
.LC5:
	.string	"timing"
	.zero	1
.LC6:
	.string	"AES-ECB"
.LC7:
	.string	"%s-%d: "
.LC12:
	.string	"%g cpb\n"
	.ident	"GCC: (Ubuntu 5.2.1-22ubuntu1) 5.2.1 20151010"
	.section	.note.GNU-stack,"",%progbits
