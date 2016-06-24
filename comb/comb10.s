	.cpu cortex-a57+fp+simd+crypto+crc
	.file	"comb10.c"
	.text
	.align	2
	.p2align 4,,15
	.global	radixSortDescending
	.type	radixSortDescending, %function
radixSortDescending:
	stp	x29, x30, [sp, -144]!
	add	x29, sp, 0
	stp	x21, x22, [sp, 32]
	sxtw	x1, w1
	adrp	x21, __stack_chk_guard
	add	x2, x21, :lo12:__stack_chk_guard
	ldr	x3, [x2]
	str	x3, [x29, 136]
	mov	x3,0
	stp	x19, x20, [sp, 16]
	cmp	w1, wzr
	mov	x3, x0
	add	x0, x1, 15
	stp	x23, x24, [sp, 48]
	stp	x25, x26, [sp, 64]
	and	x0, x0, -16
	stp	x27, x28, [sp, 80]
	sub	sp, sp, x0
	ble	.L1
	neg	x2, x3
	mov	x25, x1
	and	w2, w2, 15
	mov	x26, sp
	cmp	w2, w1
	csel	w2, w2, w1, ls
	mov	x4, x3
	cmp	w1, 21
	bgt	.L30
	mov	w2, w1
.L3:
	mov	w5, w2
	mov	w28, 0
	mov	w0, 0
	.p2align 2
.L5:
	ldrb	w1, [x4], 1
	add	w0, w0, 1
	cmp	w28, w1
	csel	w28, w28, w1, ge
	cmp	w2, w0
	bne	.L5
	cmp	w25, w2
	beq	.L6
.L4:
	sub	w4, w25, w2
	sub	w1, w25, #1
	uxtw	x6, w2
	sub	w0, w4, #16
	sub	w2, w1, w2
	lsr	w0, w0, 4
	cmp	w2, 14
	add	w0, w0, 1
	lsl	w1, w0, 4
	bls	.L7
	dup	v0.4s, w28
	add	x6, x3, x6
	mov	x2, 0
.L8:
	lsl	x7, x2, 4
	add	x2, x2, 1
	cmp	w0, w2
	ldr	q3, [x6, x7]
	ushll	v1.8h, v3.8b, 0
	ushll2	v3.8h, v3.16b, 0
	ushll2	v2.4s, v1.8h, 0
	ushll	v1.4s, v1.4h, 0
	ushll	v4.4s, v3.4h, 0
	ushll2	v3.4s, v3.8h, 0
	smax	v2.4s, v2.4s, v1.4s
	smax	v1.4s, v2.4s, v4.4s
	smax	v1.4s, v1.4s, v3.4s
	smax	v0.4s, v0.4s, v1.4s
	bhi	.L8
	smaxv	s0, v0.4s
	cmp	w1, w4
	add	w5, w5, w1
	umov	w28, v0.s[0]
	beq	.L6
.L7:
	ldrb	w1, [x3, w5, sxtw]
	add	w0, w5, 1
	cmp	w28, w1
	csel	w28, w28, w1, ge
	cmp	w25, w0
	ble	.L6
	ldrb	w1, [x3, w0, sxtw]
	add	w0, w5, 2
	cmp	w28, w1
	csel	w28, w28, w1, ge
	cmp	w25, w0
	ble	.L6
	ldrb	w1, [x3, w0, sxtw]
	add	w0, w5, 3
	cmp	w28, w1
	csel	w28, w28, w1, ge
	cmp	w25, w0
	ble	.L6
	ldrb	w1, [x3, w0, sxtw]
	add	w0, w5, 4
	cmp	w28, w1
	csel	w28, w28, w1, ge
	cmp	w25, w0
	ble	.L6
	ldrb	w1, [x3, w0, sxtw]
	add	w0, w5, 5
	cmp	w28, w1
	csel	w28, w28, w1, ge
	cmp	w25, w0
	ble	.L6
	ldrb	w1, [x3, w0, sxtw]
	add	w0, w5, 6
	cmp	w28, w1
	csel	w28, w28, w1, ge
	cmp	w25, w0
	ble	.L6
	ldrb	w1, [x3, w0, sxtw]
	add	w0, w5, 7
	cmp	w28, w1
	csel	w28, w28, w1, ge
	cmp	w25, w0
	ble	.L6
	ldrb	w1, [x3, w0, sxtw]
	add	w0, w5, 8
	cmp	w28, w1
	csel	w28, w28, w1, ge
	cmp	w25, w0
	ble	.L6
	ldrb	w1, [x3, w0, sxtw]
	add	w0, w5, 9
	cmp	w28, w1
	csel	w28, w28, w1, ge
	cmp	w25, w0
	ble	.L6
	ldrb	w1, [x3, w0, sxtw]
	add	w0, w5, 10
	cmp	w28, w1
	csel	w28, w28, w1, ge
	cmp	w25, w0
	ble	.L6
	ldrb	w1, [x3, w0, sxtw]
	add	w0, w5, 11
	cmp	w28, w1
	csel	w28, w28, w1, ge
	cmp	w25, w0
	ble	.L6
	ldrb	w1, [x3, w0, sxtw]
	add	w0, w5, 12
	cmp	w28, w1
	csel	w28, w28, w1, ge
	cmp	w25, w0
	ble	.L6
	ldrb	w1, [x3, w0, sxtw]
	add	w0, w5, 13
	cmp	w28, w1
	csel	w28, w28, w1, ge
	cmp	w25, w0
	ble	.L6
	ldrb	w0, [x3, w0, sxtw]
	add	w5, w5, 14
	cmp	w28, w0
	csel	w28, w28, w0, ge
	cmp	w25, w5
	ble	.L6
	ldrb	w0, [x3, w5, sxtw]
	cmp	w28, w0
	csel	w28, w28, w0, ge
.L6:
	cmp	w28, wzr
	ble	.L1
	sub	w19, w25, #1
	mov	w24, 26215
	movk	w24, 0x6666, lsl 16
	sxtw	x20, w19
	mov	w22, 1
	mov	w23, 9
	uxtw	x19, w19
	sub	x27, x20, #1
	sub	x27, x27, x19
	add	x19, x19, 1
	add	x27, x3, x27
	.p2align 2
.L16:
	mov	x2, 0
	stp	xzr, xzr, [x29, 96]
	stp	xzr, xzr, [x29, 112]
	str	xzr, [x29, 128]
	.p2align 2
.L14:
	ldrb	w0, [x3, x2]
	add	x2, x2, 1
	cmp	w25, w2
	sdiv	w0, w0, w22
	smull	x1, w0, w24
	asr	x1, x1, 34
	sub	w1, w1, w0, asr 31
	lsl	w4, w1, 3
	add	w1, w4, w1, lsl 1
	sub	w0, w0, w1
	add	x1, x29, 144
	sub	w0, w23, w0
	add	x0, x1, x0, sxtw 2
	ldr	w1, [x0, -48]
	add	w1, w1, 1
	str	w1, [x0, -48]
	bgt	.L14
	ldp	w9, w11, [x29, 96]
	add	x2, x3, x20
	ldp	w8, w7, [x29, 104]
	ldp	w6, w5, [x29, 112]
	add	w9, w11, w9
	ldp	w4, w1, [x29, 120]
	add	w8, w9, w8
	ldp	w0, w10, [x29, 128]
	add	w7, w8, w7
	add	w6, w7, w6
	stp	w9, w8, [x29, 100]
	add	w5, w6, w5
	add	w4, w5, w4
	stp	w7, w6, [x29, 108]
	add	w1, w4, w1
	add	w0, w1, w0
	stp	w5, w4, [x29, 116]
	add	w4, w0, w10
	stp	w1, w0, [x29, 124]
	str	w4, [x29, 132]
	.p2align 2
.L15:
	ldrb	w4, [x2], -1
	sdiv	w0, w4, w22
	cmp	x2, x27
	smull	x1, w0, w24
	asr	x1, x1, 34
	sub	w1, w1, w0, asr 31
	lsl	w5, w1, 3
	add	w1, w5, w1, lsl 1
	sub	w0, w0, w1
	add	x1, x29, 144
	sub	w0, w23, w0
	add	x0, x1, x0, sxtw 2
	ldr	w1, [x0, -48]
	sub	w1, w1, #1
	strb	w4, [x26, w1, sxtw]
	str	w1, [x0, -48]
	bne	.L15
	mov	x0, x3
	mov	x2, x19
	mov	x1, x26
	bl	memcpy
	mov	x3, x0
	lsl	w0, w22, 3
	add	w22, w0, w22, lsl 1
	sdiv	w0, w28, w22
	cmp	w0, wzr
	bgt	.L16
.L1:
	add	x21, x21, :lo12:__stack_chk_guard
	ldr	x1, [x29, 136]
	ldr	x0, [x21]
	eor	x0, x1, x0
	cbnz	x0, .L31
	add	sp, x29, 0
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	ldp	x29, x30, [sp], 144
	ret
.L30:
	mov	w28, 0
	mov	w5, 0
	cbz	w2, .L4
	b	.L3
.L31:
	bl	__stack_chk_fail
	.size	radixSortDescending, .-radixSortDescending
	.align	2
	.p2align 4,,15
	.global	preComputeWindows
	.type	preComputeWindows, %function
preComputeWindows:
	cmp	w1, 1
	ble	.L39
	mov	x8, 0
	mov	w10, 0
	.p2align 2
.L37:
	add	x4, x0, x1, sxtw
	ldrb	w7, [x4, -1]
	mov	w9, w8
	sub	w4, w1, #2
	add	x5, x0, x4, sxtw
	mov	w11, w7
	.p2align 2
.L34:
	ldrb	w6, [x5]
	sub	x5, x5, #1
	cmp	w7, w6
	bne	.L42
	sub	w4, w4, #1
	cmn	w4, #1
	bne	.L34
	sbfiz	x0, x9, 1, 32
	sub	w7, w7, w10
	add	w9, w9, 1
	strh	w1, [x2, x0]
	strh	w7, [x3, x0]
.L41:
	mov	w0, w9
	ret
	.p2align 3
.L42:
	sub	w5, w7, w10
	strh	w1, [x2, x8, lsl 1]
	cmp	w4, 1
	add	w9, w8, 1
	mov	w1, w4
	strh	w5, [x3, x8, lsl 1]
	mov	w10, w7
	add	x8, x8, 1
	bgt	.L37
	b	.L33
	.p2align 3
.L39:
	mov	w11, 0
	mov	w9, 0
.L33:
	cmp	w1, 1
	bne	.L41
	sbfiz	x4, x9, 1, 32
	add	w9, w9, 1
	strh	w1, [x2, x4]
	ldrb	w0, [x0]
	sub	w11, w0, w11
	mov	w0, w9
	strh	w11, [x3, x4]
	ret
	.size	preComputeWindows, .-preComputeWindows
	.align	2
	.p2align 4,,15
	.global	getLowest
	.type	getLowest, %function
getLowest:
	cmp	w1, w0
	csel	w0, w1, w0, le
	ret
	.size	getLowest, .-getLowest
	.align	2
	.p2align 4,,15
	.global	combScheduler
	.type	combScheduler, %function
combScheduler:
	stp	x29, x30, [sp, -80]!
	add	x29, sp, 0
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	mov	x20, x1
	mov	x0, x2
	mov	w1, w3
	stp	x21, x22, [sp, 32]
	stp	x23, x24, [sp, 48]
	mov	x21, x6
	mov	w22, w3
	str	x25, [sp, 64]
	mov	w23, w4
	mov	x24, x5
	str	d8, [sp, 72]
	mov	x25, x2
	bl	radixSortDescending
	sxtw	x0, w23
	cmp	w22, wzr
	ldr	q2, [x21]
	lsl	x1, x0, 4
	lsl	x0, x0, 1
	add	x1, x1, 16
	add	x0, x0, 16
	sub	sp, sp, x1
	and	x0, x0, -16
	mov	x7, sp
	sub	sp, sp, x1
	mov	x6, sp
	sub	sp, sp, x0
	mov	x14, sp
	sub	sp, sp, x0
	ble	.L44
	mov	x13, sp
.L66:
	cmp	w23, w22
	csel	w15, w23, w22, le
	cmp	w15, 1
	ble	.L62
	mov	w11, w15
	mov	x12, 0
	mov	w16, 0
	.p2align 2
.L50:
	add	x0, x25, x11, sxtw
	ldrb	w9, [x0, -1]
	mov	w10, w12
	sub	w0, w11, #2
	add	x1, x25, x0, sxtw
	mov	w17, w9
	.p2align 2
.L47:
	ldrb	w8, [x1]
	sub	x1, x1, #1
	cmp	w9, w8
	bne	.L74
	sub	w0, w0, #1
	cmn	w0, #1
	bne	.L47
	sbfiz	x0, x10, 1, 32
	sub	w9, w9, w16
	add	w10, w10, 1
	strh	w11, [x14, x0]
	strh	w9, [x13, x0]
.L52:
	sub	w1, w15, #1
	mov	x0, x6
	add	x1, x1, 1
	add	x1, x6, x1, lsl 4
	.p2align 2
.L55:
	str	q2, [x0], 16
	cmp	x1, x0
	bne	.L55
.L56:
	cmp	w10, wzr
	mov	x9, 0
	mov	w12, 0
	ble	.L54
	.p2align 2
.L67:
	ldrh	w11, [x13, x9, lsl 1]
	cbz	w11, .L59
	ldr	q20, [x6]
	lsl	w1, w12, 4
	sub	w8, w11, #1
	sxtw	x1, w1
	ldr	q0, [x6, 16]
	add	x16, x1, 16
	add	x0, x19, x1
	add	x8, x16, x8, uxtw 4
	ldr	q8, [x6, 32]
	add	x1, x20, x1
	add	x8, x19, x8
	ldr	q31, [x6, 48]
	ldr	q30, [x6, 64]
	ldr	q29, [x6, 80]
	ldr	q22, [x6, 96]
	ldr	q17, [x6, 112]
	ldr	q1, [x6, 128]
	.p2align 2
.L59:
	add	x9, x9, 1
	add	w12, w12, w11
	cmp	w10, w9
	bgt	.L67
.L54:
	sub	w22, w22, w15
	add	x19, x19, x15, sxtw
	cmp	w22, wzr
	bgt	.L66
.L44:
	add	sp, x29, 0
	ldr	x25, [sp, 64]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldr	d8, [sp, 72]
	ldp	x29, x30, [sp], 80
	ret
	.p2align 3
.L74:
	sub	w1, w9, w16
	strh	w11, [x14, x12, lsl 1]
	cmp	w0, 1
	add	w10, w12, 1
	mov	w16, w9
	strh	w1, [x13, x12, lsl 1]
	add	x12, x12, 1
	ble	.L46
	mov	w11, w0
	b	.L50
.L62:
	mov	w0, w15
	mov	w17, 0
	mov	w10, 0
.L46:
	cmp	w0, 1
	bne	.L51
	ldrb	w8, [x25]
	sbfiz	x1, x10, 1, 32
	add	w10, w10, 1
	strh	w0, [x14, x1]
	sub	w17, w8, w17
	strh	w17, [x13, x1]
.L51:
	cmp	w15, wzr
	ble	.L56
	b	.L52
	.size	combScheduler, .-combScheduler
	.section	.text.startup,"ax",%progbits
	.align	2
	.p2align 4,,15
	.global	main
	.type	main, %function
main:
	sub	sp, sp, #1216512
	mov	x1, 37608
	movk	x1, 0x12, lsl 16
	sub	sp, sp, #608
	adrp	x0, __stack_chk_guard
	add	x0, x0, :lo12:__stack_chk_guard
	stp	x29, x30, [sp, -160]!
	add	x29, sp, 0
	stp	x19, x20, [sp, 16]
	add	x2, x29, 16
	add	x20, x29, 304
	stp	x21, x22, [sp, 32]
	add	x1, x1, x2
	mov	x21, 128
	stp	x23, x24, [sp, 48]
	stp	x25, x26, [sp, 64]
	stp	x27, x28, [sp, 80]
	stp	d8, d9, [sp, 96]
	stp	d10, d11, [sp, 112]
	stp	d12, d13, [sp, 128]
	str	d14, [sp, 144]
	ldr	x2, [x0]
	str	x2, [x1]
	mov	x2,0
	stp	xzr, xzr, [x20]
	stp	xzr, xzr, [x20, 16]
	stp	xzr, xzr, [x20, 32]
	stp	xzr, xzr, [x20, 48]
	stp	xzr, xzr, [x20, 64]
	stp	xzr, xzr, [x20, 80]
	stp	xzr, xzr, [x20, 96]
	stp	xzr, xzr, [x20, 112]
	str	x21, [x29, 304]
	bl	getpid
	mov	x2, x20
	mov	x1, x21
	bl	sched_setaffinity
	cbz	w0, .L76
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	perror
.L76:
	ldr	q0, .LC3
	mov	w2, 10000
	add	x22, x29, 448
	mov	w1, 1
	add	x0, x29, 184
	str	w2, [x29, 172]
	add	x2, x22, 288
	mov	w24, 26215
	movk	w24, 0x6666, lsl 16
	str	x2, [x29, 160]
	mov	x26, x22
	str	q0, [x29, 432]
	bl	timespec_get
	ldp	x0, x1, [x29, 184]
	eor	w0, w1, w0
	bl	srandom
	adrp	x1, .LANCHOR0
	mov	x2, 297
	add	x1, x1, :lo12:.LANCHOR0
	mov	x0, x22
	bl	memcpy
	adrp	x2, .LC4
	adrp	x1, .LC5
	add	x2, x2, :lo12:.LC4
	add	x1, x1, :lo12:.LC5
	mov	w3, 18432
	movk	w3, 0x9, lsl 16
	mov	w0, 1
	bl	__printf_chk
	mov	x1, 0
	add	x0, x29, 200
	bl	gettimeofday
	ldp	x0, x1, [x29, 200]
	ldr	d8, .LC6
	scvtf	d0, x0
	scvtf	d1, x1
	mov	x0, 21232
	movk	x0, 0x9, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	adrp	x1, start_clk
	sub	x27, x0, #2056
	fmadd	d0, d0, d8, d1
	fcvtzu	x0, d0
	str	x0, [x1, #:lo12:start_clk]
.L96:
	ldr	x1, [x29, 160]
	movi	v0.4s, 0
	mov	x22, sp
	sub	sp, sp, #304
	mov	x0, x26
	mov	x21, sp
.L77:
	ldr	q3, [x0], 16
	ushll	v1.8h, v3.8b, 0
	cmp	x0, x1
	ushll2	v3.8h, v3.16b, 0
	ushll2	v2.4s, v1.8h, 0
	ushll	v1.4s, v1.4h, 0
	ushll	v4.4s, v3.4h, 0
	ushll2	v3.4s, v3.8h, 0
	smax	v2.4s, v2.4s, v1.4s
	smax	v1.4s, v2.4s, v4.4s
	smax	v1.4s, v1.4s, v3.4s
	smax	v0.4s, v0.4s, v1.4s
	bne	.L77
	ldrb	w0, [x29, 739]
	smaxv	s0, v0.4s
	mov	w28, 1
	ldrb	w9, [x29, 738]
	ldrb	w6, [x29, 737]
	umov	w1, v0.s[0]
	ldrb	w8, [x29, 736]
	cmp	w0, w9
	csel	w0, w0, w9, ge
	ldrb	w5, [x29, 741]
	ldrb	w7, [x29, 740]
	cmp	w6, w8
	csel	w6, w6, w8, ge
	ldrb	w3, [x29, 743]
	cmp	w0, w6
	csel	w0, w0, w6, ge
	ldrb	w25, [x29, 742]
	cmp	w5, w7
	csel	w5, w5, w7, ge
	ldrb	w2, [x29, 744]
	cmp	w0, w5
	csel	w0, w0, w5, ge
	cmp	w3, w25
	csel	w25, w3, w25, ge
	cmp	w0, w25
	csel	w0, w0, w25, ge
	cmp	w2, w1
	csel	w1, w2, w1, ge
	cmp	w1, w0
	csel	w25, w1, w0, ge
	cbz	w25, .L83
	add	x20, x26, 297
	mov	w19, 9
	add	x23, x29, 447
.L132:
	add	x0, x29, 264
	mov	x2, x26
	str	xzr, [x29, 296]
	stp	xzr, xzr, [x0]
	add	x0, x29, 280
	stp	xzr, xzr, [x0]
	.p2align 2
.L80:
	ldrb	w0, [x2], 1
	add	x3, x29, 16
	sdiv	w0, w0, w28
	cmp	x2, x20
	smull	x1, w0, w24
	asr	x1, x1, 34
	sub	w1, w1, w0, asr 31
	lsl	w7, w1, 3
	add	w1, w7, w1, lsl 1
	sub	w0, w0, w1
	mov	x1, 37616
	movk	x1, 0x12, lsl 16
	add	x1, x1, x3
	sub	w0, w19, w0
	add	x0, x1, x0, sxtw 2
	sub	x0, x0, #1220608
	ldr	w1, [x0, 3592]
	add	w1, w1, 1
	str	w1, [x0, 3592]
	bne	.L80
	add	x0, x29, 256
	add	x3, x29, 256
	ldr	w12, [x29, 300]
	add	x4, x29, 256
	add	x5, x29, 256
	ldp	w13, w14, [x0, 8]
	add	x2, x26, 296
	ldp	w11, w10, [x0, 16]
	ldp	w9, w8, [x3, 24]
	add	w13, w14, w13
	ldp	w7, w1, [x3, 32]
	add	w11, w13, w11
	ldr	w0, [x29, 296]
	add	w10, w11, w10
	add	w9, w10, w9
	stp	w13, w11, [x4, 12]
	add	w8, w9, w8
	add	w7, w8, w7
	stp	w10, w9, [x4, 20]
	add	w1, w7, w1
	add	w0, w1, w0
	stp	w8, w7, [x5, 28]
	add	w12, w12, w0
	stp	w1, w0, [x5, 36]
	str	w12, [x29, 300]
	.p2align 2
.L81:
	ldrb	w7, [x2], -1
	add	x3, x29, 16
	sdiv	w0, w7, w28
	cmp	x23, x2
	smull	x1, w0, w24
	asr	x1, x1, 34
	sub	w1, w1, w0, asr 31
	lsl	w8, w1, 3
	add	w1, w8, w1, lsl 1
	sub	w0, w0, w1
	mov	x1, 37616
	movk	x1, 0x12, lsl 16
	add	x1, x1, x3
	sub	w0, w19, w0
	add	x0, x1, x0, sxtw 2
	sub	x0, x0, #1220608
	ldr	w1, [x0, 3592]
	sub	w1, w1, #1
	strb	w7, [x21, w1, sxtw]
	str	w1, [x0, 3592]
	bne	.L81
	mov	x2, 297
	mov	x1, x21
	mov	x0, x26
	bl	memcpy
	lsl	w0, w28, 3
	add	w28, w0, w28, lsl 1
	sdiv	w0, w25, w28
	cmp	w0, wzr
	bgt	.L132
.L83:
	ldr	q19, .LC7
	mov	sp, x22
	add	x0, x29, 768
	sub	sp, sp, #160
	add	x7, x29, 760
	ldr	q20, [x29, 432]
	mov	x3, sp
	sub	sp, sp, #160
	mov	w9, 297
	mov	w10, 9
	ldr	q18, .LC8
	mov	x2, sp
	mov	w11, 1
	sub	x8, x0, #552
	sub	x5, x0, #528
	ldr	q17, .LC9
	ldr	q16, .LC10
	ldr	q7, .LC11
	ldr	q1, .LC12
	ldr	q6, .LC13
	ldr	q5, .LC14
	ldr	q4, .LC15
	ldr	q3, .LC16
	ldr	q2, .LC17
.L79:
	cmp	w9, 9
	csel	w6, w9, w10, le
	cmp	w6, 1
	beq	.L99
	mov	w4, w6
	mov	x14, 0
	mov	w15, 0
	.p2align 2
.L88:
	sub	x0, x29, #3328
	add	x12, x0, x4, sxtw
	ldrb	w1, [x12, 3775]
	sub	w0, w4, #2
	sub	x12, x29, #3328
	add	x12, x12, x0, sxtw
	ldrb	w12, [x12, 3776]
	mov	w16, w1
	cmp	w1, w12
	bne	.L85
	sub	w0, w4, #3
	cmn	w0, #1
	beq	.L86
	sub	x12, x29, #3328
	add	x12, x12, x0, sxtw
	ldrb	w12, [x12, 3776]
	cmp	w1, w12
	bne	.L85
	sub	w0, w4, #4
	cmn	w0, #1
	beq	.L86
	sub	x12, x29, #3328
	add	x12, x12, x0, sxtw
	ldrb	w12, [x12, 3776]
	cmp	w1, w12
	bne	.L85
	sub	w0, w4, #5
	cmn	w0, #1
	beq	.L86
	sub	x12, x29, #3328
	add	x12, x12, x0, sxtw
	ldrb	w12, [x12, 3776]
	cmp	w1, w12
	bne	.L85
	sub	w0, w4, #6
	cmn	w0, #1
	beq	.L86
	sub	x12, x29, #3328
	add	x12, x12, x0, sxtw
	ldrb	w12, [x12, 3776]
	cmp	w1, w12
	bne	.L85
	sub	w0, w4, #7
	cmn	w0, #1
	beq	.L86
	sub	x12, x29, #3328
	add	x12, x12, x0, sxtw
	ldrb	w12, [x12, 3776]
	cmp	w1, w12
	bne	.L85
	sub	w0, w4, #8
	cmn	w0, #1
	beq	.L86
	sub	x12, x29, #3328
	add	x12, x12, x0, sxtw
	ldrb	w12, [x12, 3776]
	cmp	w1, w12
	bne	.L87
	cmp	w4, 9
	bne	.L86
	ldrb	w0, [x29, 448]
	cmp	w1, w0
	bne	.L159
.L86:
	sub	w1, w1, w15
	add	w13, w14, 1
	strh	w4, [x8, x14, lsl 1]
	strh	w1, [x5, x14, lsl 1]
.L89:
	str	q20, [x2]
	cmp	w6, 1
	beq	.L90
	str	q20, [x2, 16]
	cmp	w6, 2
	beq	.L90
	str	q20, [x2, 32]
	cmp	w6, 3
	beq	.L90
	str	q20, [x2, 48]
	cmp	w6, 4
	beq	.L90
	str	q20, [x2, 64]
	cmp	w6, 5
	beq	.L90
	str	q20, [x2, 80]
	cmp	w6, 6
	beq	.L90
	str	q20, [x2, 96]
	cmp	w6, 7
	beq	.L90
	str	q20, [x2, 112]
	cmp	w6, 9
	bne	.L90
	str	q20, [x2, 128]
.L90:
	mov	x12, 0
	mov	w15, 0
	cbz	w13, .L92
	.p2align 2
.L131:
	ldrh	w14, [x5, x12, lsl 1]
	cbz	w14, .L95
	ldr	q29, [x2]
	lsl	w0, w15, 4
	sub	w4, w14, #1
	sxtw	x0, w0
	ldr	q28, [x2, 16]
	add	x16, x0, 16
	add	x1, x7, x0
	add	x4, x16, x4, uxtw 4
	ldr	q12, [x2, 32]
	add	x0, x27, x0
	add	x4, x27, x4
	ldr	q11, [x2, 48]
	ldr	q10, [x2, 64]
	ldr	q9, [x2, 80]
	ldr	q31, [x2, 96]
	ldr	q30, [x2, 112]
	ldr	q0, [x2, 128]
	.p2align 2
.L93:
	add	x0, x0, 16
	add	x1, x1, 16
	ldr	q13, [x1, 2032]
	cmp	x0, x4
	ldr	q26, [x1, 6128]
	ldr	q24, [x1, 10224]
	ldr	q22, [x1, 14320]
	eor	v28.16b, v13.16b, v28.16b
	ldr	q21, [x1, 16368]
	eor	v26.16b, v26.16b, v11.16b
	ldr	q14, [x1, -16]
	eor	v24.16b, v24.16b, v9.16b
	aese	v28.16b, v19.16b
	ldr	q27, [x1, 4080]
	eor	v22.16b, v22.16b, v30.16b
	aese	v26.16b, v19.16b
	ldr	q25, [x1, 8176]
	eor	v0.16b, v21.16b, v0.16b
	aese	v24.16b, v19.16b
	aesmc	v28.16b, v28.16b
	ldr	q23, [x1, 12272]
	eor	v29.16b, v14.16b, v29.16b
	aesmc	v26.16b, v26.16b
	eor	v27.16b, v27.16b, v12.16b
	aesmc	v24.16b, v24.16b
	aese	v0.16b, v19.16b
	eor	v25.16b, v25.16b, v10.16b
	aese	v29.16b, v19.16b
	aese	v21.16b, v19.16b
	eor	v23.16b, v23.16b, v31.16b
	aese	v27.16b, v19.16b
	aesmc	v0.16b, v0.16b
	aese	v25.16b, v19.16b
	aesmc	v29.16b, v29.16b
	aese	v23.16b, v19.16b
	aesmc	v27.16b, v27.16b
	aesmc	v25.16b, v25.16b
	aesmc	v21.16b, v21.16b
	aesmc	v22.16b, v23.16b
	aese	v28.16b, v18.16b
	aese	v26.16b, v18.16b
	aese	v25.16b, v18.16b
	aese	v29.16b, v18.16b
	aese	v27.16b, v18.16b
	aesmc	v26.16b, v26.16b
	aese	v23.16b, v18.16b
	aese	v22.16b, v18.16b
	aese	v21.16b, v18.16b
	aese	v0.16b, v18.16b
	aesmc	v28.16b, v28.16b
	aesmc	v24.16b, v25.16b
	aesmc	v29.16b, v29.16b
	aesmc	v27.16b, v27.16b
	aesmc	v23.16b, v23.16b
	aesmc	v22.16b, v22.16b
	aesmc	v21.16b, v21.16b
	aesmc	v0.16b, v0.16b
	aese	v28.16b, v17.16b
	aese	v27.16b, v17.16b
	aese	v29.16b, v17.16b
	aese	v25.16b, v17.16b
	aesmc	v28.16b, v28.16b
	aese	v24.16b, v17.16b
	aese	v23.16b, v17.16b
	aese	v22.16b, v17.16b
	aese	v21.16b, v17.16b
	aese	v0.16b, v17.16b
	aesmc	v26.16b, v27.16b
	aesmc	v29.16b, v29.16b
	aesmc	v25.16b, v25.16b
	aesmc	v24.16b, v24.16b
	aesmc	v23.16b, v23.16b
	aesmc	v22.16b, v22.16b
	aesmc	v21.16b, v21.16b
	aesmc	v0.16b, v0.16b
	aese	v29.16b, v16.16b
	aese	v27.16b, v16.16b
	aese	v26.16b, v16.16b
	aese	v25.16b, v16.16b
	aese	v24.16b, v16.16b
	aese	v23.16b, v16.16b
	aese	v22.16b, v16.16b
	aese	v21.16b, v16.16b
	aese	v0.16b, v16.16b
	aesmc	v29.16b, v29.16b
	aesmc	v27.16b, v27.16b
	aesmc	v26.16b, v26.16b
	aesmc	v25.16b, v25.16b
	aesmc	v24.16b, v24.16b
	aesmc	v23.16b, v23.16b
	aesmc	v22.16b, v22.16b
	aesmc	v21.16b, v21.16b
	aesmc	v0.16b, v0.16b
	aese	v29.16b, v7.16b
	aese	v27.16b, v7.16b
	aese	v26.16b, v7.16b
	aese	v25.16b, v7.16b
	aese	v24.16b, v7.16b
	aese	v23.16b, v7.16b
	aese	v22.16b, v7.16b
	aese	v21.16b, v7.16b
	aese	v0.16b, v7.16b
	aesmc	v29.16b, v29.16b
	aesmc	v27.16b, v27.16b
	aesmc	v26.16b, v26.16b
	aesmc	v25.16b, v25.16b
	aesmc	v24.16b, v24.16b
	aesmc	v23.16b, v23.16b
	aesmc	v22.16b, v22.16b
	aesmc	v21.16b, v21.16b
	aesmc	v0.16b, v0.16b
	aese	v29.16b, v1.16b
	aese	v27.16b, v1.16b
	aese	v26.16b, v1.16b
	aese	v25.16b, v1.16b
	aese	v24.16b, v1.16b
	aese	v23.16b, v1.16b
	aese	v22.16b, v1.16b
	aese	v21.16b, v1.16b
	aese	v0.16b, v1.16b
	aesmc	v29.16b, v29.16b
	aesmc	v27.16b, v27.16b
	aesmc	v26.16b, v26.16b
	aesmc	v25.16b, v25.16b
	aesmc	v24.16b, v24.16b
	aesmc	v23.16b, v23.16b
	aesmc	v22.16b, v22.16b
	aesmc	v21.16b, v21.16b
	aesmc	v0.16b, v0.16b
	aese	v29.16b, v1.16b
	aese	v27.16b, v1.16b
	aese	v26.16b, v1.16b
	aese	v25.16b, v1.16b
	aese	v24.16b, v1.16b
	aese	v23.16b, v1.16b
	aese	v22.16b, v1.16b
	aese	v21.16b, v1.16b
	aese	v0.16b, v1.16b
	aesmc	v29.16b, v29.16b
	aesmc	v27.16b, v27.16b
	aesmc	v26.16b, v26.16b
	aesmc	v25.16b, v25.16b
	aesmc	v24.16b, v24.16b
	aesmc	v23.16b, v23.16b
	aesmc	v22.16b, v22.16b
	aesmc	v21.16b, v21.16b
	aesmc	v0.16b, v0.16b
	aese	v29.16b, v6.16b
	aese	v27.16b, v6.16b
	aese	v26.16b, v6.16b
	aese	v25.16b, v6.16b
	aese	v24.16b, v6.16b
	aese	v23.16b, v6.16b
	aese	v22.16b, v6.16b
	aese	v21.16b, v6.16b
	aese	v0.16b, v6.16b
	aesmc	v29.16b, v29.16b
	aesmc	v27.16b, v27.16b
	aesmc	v26.16b, v26.16b
	aesmc	v25.16b, v25.16b
	aesmc	v24.16b, v24.16b
	aesmc	v23.16b, v23.16b
	aesmc	v22.16b, v22.16b
	aesmc	v21.16b, v21.16b
	aesmc	v0.16b, v0.16b
	aese	v29.16b, v5.16b
	aese	v27.16b, v5.16b
	aese	v26.16b, v5.16b
	aese	v25.16b, v5.16b
	aese	v24.16b, v5.16b
	aese	v23.16b, v5.16b
	aese	v22.16b, v5.16b
	aese	v21.16b, v5.16b
	aese	v0.16b, v5.16b
	aesmc	v29.16b, v29.16b
	aesmc	v27.16b, v27.16b
	aesmc	v26.16b, v26.16b
	aesmc	v25.16b, v25.16b
	aesmc	v24.16b, v24.16b
	aesmc	v23.16b, v23.16b
	aesmc	v22.16b, v22.16b
	aesmc	v21.16b, v21.16b
	aesmc	v0.16b, v0.16b
	aese	v29.16b, v4.16b
	aese	v27.16b, v4.16b
	aese	v26.16b, v4.16b
	aese	v25.16b, v4.16b
	aese	v24.16b, v4.16b
	aese	v23.16b, v4.16b
	aese	v22.16b, v4.16b
	aese	v21.16b, v4.16b
	aese	v0.16b, v4.16b
	aesmc	v29.16b, v29.16b
	aesmc	v27.16b, v27.16b
	aesmc	v26.16b, v26.16b
	aesmc	v25.16b, v25.16b
	aesmc	v24.16b, v24.16b
	aesmc	v23.16b, v23.16b
	aesmc	v22.16b, v22.16b
	aesmc	v21.16b, v21.16b
	aesmc	v0.16b, v0.16b
	aese	v29.16b, v3.16b
	aese	v27.16b, v3.16b
	aese	v26.16b, v3.16b
	aese	v25.16b, v3.16b
	aese	v24.16b, v3.16b
	eor	v29.16b, v29.16b, v2.16b
	aese	v23.16b, v3.16b
	eor	v28.16b, v27.16b, v2.16b
	aese	v22.16b, v3.16b
	eor	v12.16b, v26.16b, v2.16b
	aese	v21.16b, v3.16b
	eor	v11.16b, v25.16b, v2.16b
	aese	v0.16b, v3.16b
	eor	v10.16b, v24.16b, v2.16b
	str	q29, [x3]
	eor	v9.16b, v23.16b, v2.16b
	eor	v31.16b, v22.16b, v2.16b
	eor	v30.16b, v21.16b, v2.16b
	eor	v0.16b, v0.16b, v2.16b
	str	q29, [x0, -16]
	str	q28, [x0, 2032]
	str	q12, [x0, 4080]
	str	q11, [x0, 6128]
	str	q10, [x0, 8176]
	str	q9, [x0, 10224]
	str	q31, [x0, 12272]
	str	q30, [x0, 14320]
	str	q0, [x0, 16368]
	bne	.L93
.L95:
	add	x12, x12, 1
	add	w15, w15, w14
	cmp	w13, w12
	bgt	.L131
.L92:
	sub	w9, w9, w6
	add	x7, x7, x6, sxtw
	cmp	w9, wzr
	bgt	.L79
	ldr	w0, [x29, 172]
	subs	w0, w0, #1
	str	w0, [x29, 172]
	mov	sp, x22
	bne	.L96
	mov	x1, 0
	add	x0, x29, 200
	bl	gettimeofday
	ldp	x3, x4, [x29, 200]
	adrp	x0, start_clk
	adrp	x6, end_clk
	adrp	x5, total_clk
	adrp	x1, .LC21
	ldr	x2, [x0, #:lo12:start_clk]
	add	x1, x1, :lo12:.LC21
	mov	w0, 1
	ldr	d1, .LC18
	scvtf	d2, x3
	scvtf	d3, x4
	ldr	d4, .LC19
	ldr	d0, .LC20
	fmadd	d8, d2, d8, d3
	fcvtzu	x3, d8
	sub	x2, x3, x2
	str	x3, [x6, #:lo12:end_clk]
	ucvtf	d2, x2
	fmul	d1, d2, d1
	fdiv	d1, d1, d4
	fdiv	d0, d1, d0
	str	d1, [x5, #:lo12:total_clk]
	bl	__printf_chk
	add	x1, x29, 16
	mov	x0, 19175
	movk	x0, 0x9, lsl 16
	add	x0, x0, x1
	ldrb	w20, [x29, 760]
	mov	w2, 123
	adrp	x1, .LC22
	ldrb	w3, [x0]
	add	x1, x1, :lo12:.LC22
	mov	w0, 1
	eor	w20, w20, w3
	eor	w20, w20, w2
	uxtb	w20, w20
	mov	w2, w20
	bl	__printf_chk
	adrp	x1, __stack_chk_guard
	add	x19, x1, :lo12:__stack_chk_guard
	add	x2, x29, 16
	mov	x1, 37608
	movk	x1, 0x12, lsl 16
	add	x1, x1, x2
	mov	w0, w20
	ldr	x2, [x1]
	ldr	x1, [x19]
	eor	x1, x2, x1
	cbnz	x1, .L160
	add	sp, x29, 0
	ldr	d14, [sp, 144]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	ldp	d8, d9, [sp, 96]
	ldp	d10, d11, [sp, 112]
	ldp	d12, d13, [sp, 128]
	ldp	x29, x30, [sp], 160
	add	sp, sp, 1216512
	add	sp, sp, 608
	ret
	.p2align 3
.L85:
	sub	w12, w1, w15
	strh	w4, [x8, x14, lsl 1]
	cmp	w0, 1
	add	w13, w14, 1
	mov	w15, w1
	strh	w12, [x5, x14, lsl 1]
	add	x14, x14, 1
	ble	.L97
	mov	w4, w0
	b	.L88
.L159:
	mov	w0, 0
.L87:
	sub	w1, w1, w15
	add	w13, w14, 1
	strh	w4, [x8, x14, lsl 1]
	strh	w1, [x5, x14, lsl 1]
.L97:
	cmp	w0, 1
	bne	.L89
	ldrb	w1, [x29, 448]
	sub	x0, x29, #3328
	add	x0, x0, x13, sxtw 1
	add	w13, w13, 1
	strh	w11, [x0, 3544]
	sub	w16, w1, w16
	strh	w16, [x0, 3568]
	b	.L89
.L99:
	ldrb	w1, [x29, 448]
	mov	w16, 0
	mov	w13, 0
	sub	x0, x29, #3328
	add	x0, x0, x13, sxtw 1
	add	w13, w13, 1
	strh	w11, [x0, 3544]
	sub	w16, w1, w16
	strh	w16, [x0, 3568]
	b	.L89
.L160:
	bl	__stack_chk_fail
	.size	main, .-main
	.align	4
.LC3:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	12
	.byte	13
	.byte	14
	.byte	15
	.align	3
.LC6:
	.word	0
	.word	1093567616
	.align	4
.LC7:
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
	.align	4
.LC8:
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
	.align	4
.LC9:
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
	.align	4
.LC10:
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
	.align	4
.LC11:
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
	.align	4
.LC12:
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
	.align	4
.LC13:
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
	.align	4
.LC14:
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
	.align	4
.LC15:
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
	.align	4
.LC16:
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
	.align	4
.LC17:
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
	.align	3
.LC18:
	.word	0
	.word	1084254208
	.align	3
.LC19:
	.word	0
	.word	1086556160
	.align	3
.LC20:
	.word	0
	.word	1092784128
	.comm	total_clk,8,8
	.comm	end_clk,8,8
	.comm	start_clk,8,8
	.section	.rodata
	.align	3
.LANCHOR0 = . + 0
.LC1:
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.section	.rodata.str1.8,"aMS",%progbits,1
	.align	3
.LC2:
	.string	"setaffinity"
	.zero	4
.LC4:
	.string	"AES-CBC-COMP-P6"
.LC5:
	.string	"%s-%d: "
.LC21:
	.string	"%g cpb\n"
.LC22:
	.string	"\n\nterminated with code %d\n"
	.ident	"GCC: (Ubuntu 5.2.1-22ubuntu1) 5.2.1 20151010"
	.section	.note.GNU-stack,"",%progbits
