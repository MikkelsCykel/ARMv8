	.cpu cortex-a57+fp+simd+crypto+crc
	.file	"combcbc.c"
	.text
	.align	2
	.p2align 4,,15
	.global	radixSortDescending
	.type	radixSortDescending, %function
radixSortDescending:
	stp	x29, x30, [sp, -144]!
	adrp	x2, __stack_chk_guard
	add	x3, x2, :lo12:__stack_chk_guard
	add	x29, sp, 0
	sbfiz	x2, x1, 4, 32
	ldr	x4, [x3]
	str	x4, [x29, 136]
	mov	x4,0
	stp	x19, x20, [sp, 16]
	add	x2, x2, 16
	stp	x21, x22, [sp, 32]
	cmp	w1, wzr
	stp	x23, x24, [sp, 48]
	stp	x25, x26, [sp, 64]
	stp	x27, x28, [sp, 80]
	sub	sp, sp, x2
	ble	.L1
	sub	w2, w1, #5
	sub	w3, w1, #1
	lsr	w2, w2, 2
	cmp	w3, 7
	add	w2, w2, 1
	mov	x5, x0
	mov	x26, sp
	lsl	w0, w2, 2
	bls	.L14
	movi	v0.4s, 0
	add	x6, x5, 8
.L4:
	ld4	{v4.4s - v7.4s}, [x6], 64
	add	w4, w4, 1
	cmp	w4, w2
	smax	v0.4s, v0.4s, v4.4s
	bcc	.L4
	smaxv	s0, v0.4s
	cmp	w0, w1
	umov	w22, v0.s[0]
	beq	.L7
.L3:
	add	x2, x5, x0, sxtw 4
	ldr	w7, [x2, 8]
	add	w6, w0, 1
	cmp	w22, w7
	csel	w22, w22, w7, ge
	cmp	w1, w6
	ble	.L7
	ldr	w7, [x2, 24]
	add	w6, w0, 2
	cmp	w22, w7
	csel	w22, w22, w7, ge
	cmp	w1, w6
	ble	.L7
	ldr	w7, [x2, 40]
	add	w6, w0, 3
	cmp	w22, w7
	csel	w22, w22, w7, ge
	cmp	w1, w6
	ble	.L7
	ldr	w7, [x2, 56]
	add	w6, w0, 4
	cmp	w22, w7
	csel	w22, w22, w7, ge
	cmp	w1, w6
	ble	.L7
	ldr	w7, [x2, 72]
	add	w6, w0, 5
	cmp	w22, w7
	csel	w22, w22, w7, ge
	cmp	w6, w1
	bge	.L7
	ldr	w7, [x2, 88]
	add	w6, w0, 6
	cmp	w22, w7
	csel	w22, w22, w7, ge
	cmp	w1, w6
	ble	.L7
	ldr	w6, [x2, 104]
	add	w0, w0, 7
	cmp	w22, w6
	csel	w22, w22, w6, ge
	cmp	w1, w0
	ble	.L7
	ldr	w0, [x2, 120]
	cmp	w22, w0
	csel	w22, w22, w0, ge
.L7:
	cmp	w22, wzr
	ble	.L1
	uxtw	x20, w3
	mov	x19, 8
	mov	x27, 24
	mov	w25, 26215
	movk	w25, 0x6666, lsl 16
	add	x20, x20, 1
	add	x27, x27, x3, uxtw 4
	sub	x28, x5, #8
	add	x3, x19, x3, uxtw 4
	add	x27, x5, x27
	add	x19, x5, x3
	mov	w23, 1
	add	x21, x5, 8
	lsl	x20, x20, 4
	mov	w24, 9
	.p2align 2
.L12:
	mov	x2, x21
	stp	xzr, xzr, [x29, 96]
	stp	xzr, xzr, [x29, 112]
	str	xzr, [x29, 128]
	.p2align 2
.L10:
	ldr	w0, [x2], 16
	sdiv	w0, w0, w23
	cmp	x2, x27
	smull	x1, w0, w25
	asr	x1, x1, 34
	sub	w1, w1, w0, asr 31
	lsl	w3, w1, 3
	add	w1, w3, w1, lsl 1
	sub	w0, w0, w1
	add	x1, x29, 144
	sub	w0, w24, w0
	add	x0, x1, x0, sxtw 2
	ldr	w1, [x0, -48]
	add	w1, w1, 1
	str	w1, [x0, -48]
	bne	.L10
	ldp	w10, w12, [x29, 96]
	mov	x6, x19
	ldp	w9, w8, [x29, 104]
	ldp	w7, w3, [x29, 112]
	add	w10, w12, w10
	ldp	w2, w1, [x29, 120]
	add	w9, w10, w9
	ldp	w0, w11, [x29, 128]
	add	w8, w9, w8
	add	w7, w8, w7
	stp	w10, w9, [x29, 100]
	add	w3, w7, w3
	add	w2, w3, w2
	stp	w8, w7, [x29, 108]
	add	w1, w2, w1
	add	w0, w1, w0
	stp	w3, w2, [x29, 116]
	add	w2, w0, w11
	stp	w1, w0, [x29, 124]
	str	w2, [x29, 132]
	.p2align 2
.L11:
	mov	x1, x6
	sub	x6, x6, #16
	ldr	w0, [x1], -8
	cmp	x28, x6
	sdiv	w0, w0, w23
	ldp	x2, x3, [x1]
	smull	x1, w0, w25
	asr	x1, x1, 34
	sub	w1, w1, w0, asr 31
	lsl	w7, w1, 3
	add	w1, w7, w1, lsl 1
	sub	w0, w0, w1
	add	x1, x29, 144
	sub	w0, w24, w0
	add	x0, x1, x0, sxtw 2
	ldr	w1, [x0, -48]
	sub	w1, w1, #1
	add	x7, x26, x1, sxtw 4
	stp	x2, x3, [x7]
	str	w1, [x0, -48]
	bne	.L11
	mov	x0, x5
	mov	x2, x20
	mov	x1, x26
	bl	memcpy
	mov	x5, x0
	lsl	w0, w23, 3
	add	w23, w0, w23, lsl 1
	sdiv	w0, w22, w23
	cmp	w0, wzr
	bgt	.L12
.L1:
	adrp	x0, __stack_chk_guard
	add	x22, x0, :lo12:__stack_chk_guard
	ldr	x1, [x29, 136]
	ldr	x0, [x22]
	eor	x0, x1, x0
	cbnz	x0, .L23
	add	sp, x29, 0
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	ldp	x29, x30, [sp], 144
	ret
.L14:
	mov	w22, 0
	mov	w0, 0
	b	.L3
.L23:
	bl	__stack_chk_fail
	.size	radixSortDescending, .-radixSortDescending
	.align	2
	.p2align 4,,15
	.global	preComputeWindows
	.type	preComputeWindows, %function
preComputeWindows:
	cmp	w1, 1
	ble	.L31
	mov	x8, 0
	mov	w10, 0
	mov	x12, -16
	mov	x11, 8
	.p2align 2
.L29:
	add	x6, x12, x1, sxtw 4
	add	x6, x0, x6
	sub	w5, w1, #2
	ldr	w7, [x6, 8]
	add	x4, x11, x5, sxtw 4
	mov	w9, w8
	add	x4, x0, x4
	.p2align 2
.L26:
	ldr	w6, [x4]
	sub	x4, x4, #16
	cmp	w7, w6
	bne	.L34
	sub	w5, w5, #1
	cmn	w5, #1
	bne	.L26
	sbfiz	x0, x9, 1, 32
	sub	w7, w7, w10
	add	w9, w9, 1
	strh	w1, [x2, x0]
	strh	w7, [x3, x0]
.L33:
	mov	w0, w9
	ret
	.p2align 3
.L34:
	uxth	w4, w7
	strh	w1, [x2, x8, lsl 1]
	cmp	w5, 1
	add	w9, w8, 1
	sub	w1, w4, w10
	mov	w10, w7
	strh	w1, [x3, x8, lsl 1]
	add	x8, x8, 1
	mov	w1, w5
	bgt	.L29
	b	.L25
	.p2align 3
.L31:
	mov	w4, 0
	mov	w9, 0
.L25:
	cmp	w1, 1
	bne	.L33
	ldr	w5, [x0, 8]
	sbfiz	x0, x9, 1, 32
	add	w9, w9, 1
	strh	w1, [x2, x0]
	sub	w4, w5, w4
	strh	w4, [x3, x0]
	mov	w0, w9
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
	stp	x29, x30, [sp, -64]!
	add	x29, sp, 0
	stp	x19, x20, [sp, 16]
	mov	w20, w1
	mov	x19, x0
	stp	x23, x24, [sp, 48]
	mov	w23, w2
	mov	x24, x3
	stp	x21, x22, [sp, 32]
	mov	x21, x4
	bl	radixSortDescending
	sxtw	x0, w23
	cmp	w20, wzr
	ldr	q3, [x21]
	lsl	x1, x0, 4
	lsl	x0, x0, 1
	add	x1, x1, 16
	add	x0, x0, 16
	sub	sp, sp, x1
	and	x0, x0, -16
	mov	x4, sp
	sub	sp, sp, x1
	mov	x1, sp
	sub	sp, sp, x0
	mov	x14, sp
	sub	sp, sp, x0
	ble	.L36
	mov	x16, -16
	mov	x15, 8
	mov	x13, sp
.L59:
	cmp	w23, w20
	csel	w17, w23, w20, le
	cmp	w17, 1
	ble	.L54
	mov	w8, w17
	mov	x9, 0
	mov	w10, 0
	.p2align 2
.L42:
	add	x6, x16, x8, sxtw 4
	add	x6, x19, x6
	sub	w5, w8, #2
	ldr	w7, [x6, 8]
	add	x0, x15, x5, sxtw 4
	mov	w18, w9
	add	x0, x19, x0
	.p2align 2
.L39:
	ldr	w6, [x0]
	sub	x0, x0, #16
	cmp	w7, w6
	bne	.L66
	sub	w5, w5, #1
	cmn	w5, #1
	bne	.L39
	sbfiz	x0, x18, 1, 32
	sub	w7, w7, w10
	add	w18, w18, 1
	strh	w8, [x14, x0]
	strh	w7, [x13, x0]
.L44:
	sub	w5, w17, #1
	mov	x0, x1
	add	x5, x5, 1
	add	x5, x1, x5, lsl 4
	.p2align 2
.L47:
	str	q3, [x0], 16
	cmp	x5, x0
	bne	.L47
.L48:
	cmp	w18, wzr
	mov	x30, 0
	mov	w22, 0
	ble	.L46
	.p2align 2
.L60:
	ldrh	w21, [x13, x30, lsl 1]
	cbz	w21, .L51
	lsl	w0, w22, 4
	sub	w12, w21, #1
	ldr	q31, [x1]
	sxtw	x0, w0
	ldr	q30, [x1, 16]
	add	x5, x0, 16
	add	x12, x5, x12, uxtw 4
	ldr	q29, [x1, 32]
	ldr	q28, [x1, 48]
	ldr	q27, [x1, 64]
	ldr	q0, [x1, 80]
	b	.L49
	.p2align 3
.L67:
	add	x5, x5, 16
.L49:
	ldr	x6, [x19]
	cmp	x12, x5
	ldr	x11, [x19, 16]
	ldr	x10, [x19, 32]
	ldr	x8, [x19, 64]
	ldr	x9, [x19, 48]
	ldr	x7, [x19, 80]
	ldr	q25, [x6, x0]
	ldr	q23, [x11, x0]
	ldr	q22, [x10, x0]
	ldr	q16, [x8, x0]
	eor	v25.16b, v25.16b, v31.16b
	ldr	q1, [x7, x0]
	eor	v23.16b, v23.16b, v30.16b
	ldr	q20, [x9, x0]
	eor	v22.16b, v22.16b, v29.16b
	ldr	q26, [x24]
	eor	v16.16b, v16.16b, v27.16b
	eor	v0.16b, v1.16b, v0.16b
	ldr	q24, [x24, 16]
	eor	v20.16b, v20.16b, v28.16b
	orr	v1.16b, v16.16b, v16.16b
	ldr	q21, [x24, 32]
	aese	v25.16b, v26.16b
	ldr	q19, [x24, 48]
	aese	v23.16b, v26.16b
	aese	v22.16b, v26.16b
	ldr	q18, [x24, 64]
	aese	v20.16b, v26.16b
	aese	v1.16b, v26.16b
	ldr	q17, [x24, 80]
	aese	v0.16b, v26.16b
	aesmc	v22.16b, v22.16b
	ldr	q7, [x24, 96]
	aesmc	v25.16b, v25.16b
	aesmc	v23.16b, v23.16b
	ldr	q6, [x24, 112]
	aesmc	v16.16b, v20.16b
	aesmc	v1.16b, v1.16b
	orr	v20.16b, v22.16b, v22.16b
	ldr	q5, [x24, 128]
	aesmc	v0.16b, v0.16b
	aese	v23.16b, v24.16b
	ldr	q4, [x24, 144]
	aese	v25.16b, v24.16b
	aese	v20.16b, v24.16b
	ldr	q2, [x24, 160]
	aese	v16.16b, v24.16b
	aese	v1.16b, v24.16b
	aese	v0.16b, v24.16b
	aesmc	v22.16b, v23.16b
	aesmc	v24.16b, v25.16b
	aesmc	v20.16b, v20.16b
	aesmc	v16.16b, v16.16b
	aese	v22.16b, v21.16b
	aesmc	v1.16b, v1.16b
	orr	v23.16b, v24.16b, v24.16b
	aesmc	v0.16b, v0.16b
	aese	v20.16b, v21.16b
	aese	v16.16b, v21.16b
	aese	v23.16b, v21.16b
	aese	v1.16b, v21.16b
	aese	v0.16b, v21.16b
	aesmc	v21.16b, v22.16b
	aesmc	v23.16b, v23.16b
	aesmc	v20.16b, v20.16b
	aesmc	v16.16b, v16.16b
	aese	v21.16b, v19.16b
	aesmc	v1.16b, v1.16b
	orr	v22.16b, v23.16b, v23.16b
	aese	v20.16b, v19.16b
	aesmc	v0.16b, v0.16b
	aesmc	v21.16b, v21.16b
	aese	v22.16b, v19.16b
	aese	v16.16b, v19.16b
	aese	v1.16b, v19.16b
	aese	v0.16b, v19.16b
	aesmc	v19.16b, v20.16b
	orr	v20.16b, v21.16b, v21.16b
	aesmc	v22.16b, v22.16b
	aesmc	v16.16b, v16.16b
	aesmc	v1.16b, v1.16b
	aese	v20.16b, v18.16b
	aese	v19.16b, v18.16b
	aesmc	v0.16b, v0.16b
	aese	v22.16b, v18.16b
	aese	v16.16b, v18.16b
	aese	v1.16b, v18.16b
	aese	v0.16b, v18.16b
	aesmc	v20.16b, v20.16b
	aesmc	v18.16b, v19.16b
	aesmc	v21.16b, v22.16b
	aesmc	v16.16b, v16.16b
	orr	v19.16b, v20.16b, v20.16b
	aesmc	v1.16b, v1.16b
	aese	v18.16b, v17.16b
	aesmc	v0.16b, v0.16b
	aese	v21.16b, v17.16b
	aese	v19.16b, v17.16b
	aese	v16.16b, v17.16b
	aese	v1.16b, v17.16b
	aese	v0.16b, v17.16b
	aesmc	v17.16b, v18.16b
	aesmc	v19.16b, v19.16b
	aesmc	v20.16b, v21.16b
	aesmc	v16.16b, v16.16b
	aese	v17.16b, v7.16b
	orr	v18.16b, v19.16b, v19.16b
	aesmc	v1.16b, v1.16b
	aese	v20.16b, v7.16b
	aese	v16.16b, v7.16b
	aesmc	v17.16b, v17.16b
	aesmc	v0.16b, v0.16b
	aese	v18.16b, v7.16b
	aese	v1.16b, v7.16b
	aesmc	v19.16b, v20.16b
	aese	v0.16b, v7.16b
	aesmc	v7.16b, v16.16b
	orr	v16.16b, v17.16b, v17.16b
	aesmc	v18.16b, v18.16b
	aese	v19.16b, v6.16b
	aesmc	v1.16b, v1.16b
	aese	v16.16b, v6.16b
	aese	v18.16b, v6.16b
	aese	v7.16b, v6.16b
	aesmc	v0.16b, v0.16b
	aesmc	v16.16b, v16.16b
	aesmc	v19.16b, v19.16b
	aese	v1.16b, v6.16b
	aese	v0.16b, v6.16b
	aesmc	v17.16b, v18.16b
	aesmc	v6.16b, v7.16b
	orr	v18.16b, v19.16b, v19.16b
	orr	v7.16b, v16.16b, v16.16b
	aesmc	v1.16b, v1.16b
	aesmc	v0.16b, v0.16b
	aese	v17.16b, v5.16b
	aese	v18.16b, v5.16b
	aese	v7.16b, v5.16b
	aese	v6.16b, v5.16b
	aese	v1.16b, v5.16b
	aese	v0.16b, v5.16b
	aesmc	v18.16b, v18.16b
	aesmc	v7.16b, v7.16b
	aesmc	v16.16b, v17.16b
	aesmc	v5.16b, v6.16b
	aesmc	v1.16b, v1.16b
	orr	v17.16b, v18.16b, v18.16b
	aesmc	v0.16b, v0.16b
	orr	v6.16b, v7.16b, v7.16b
	aese	v16.16b, v4.16b
	aese	v5.16b, v4.16b
	aese	v17.16b, v4.16b
	aese	v6.16b, v4.16b
	aese	v1.16b, v4.16b
	eor	v30.16b, v16.16b, v2.16b
	aese	v0.16b, v4.16b
	eor	v28.16b, v5.16b, v2.16b
	eor	v31.16b, v17.16b, v2.16b
	eor	v29.16b, v6.16b, v2.16b
	eor	v27.16b, v1.16b, v2.16b
	str	q30, [x4, 16]
	eor	v0.16b, v0.16b, v2.16b
	str	q28, [x4, 48]
	str	q31, [x4]
	str	q29, [x4, 32]
	str	q27, [x4, 64]
	str	q0, [x4, 80]
	str	q31, [x1]
	str	q30, [x1, 16]
	str	q29, [x1, 32]
	str	q28, [x1, 48]
	str	q27, [x1, 64]
	str	q0, [x1, 80]
	str	q31, [x6, x0]
	ldr	x6, [x19, 16]
	str	q30, [x6, x0]
	ldr	x6, [x19, 32]
	str	q29, [x6, x0]
	ldr	x6, [x19, 48]
	str	q28, [x6, x0]
	ldr	x6, [x19, 64]
	str	q27, [x6, x0]
	ldr	x6, [x19, 80]
	str	q0, [x6, x0]
	mov	x0, x5
	bne	.L67
.L51:
	add	x30, x30, 1
	add	w22, w22, w21
	cmp	w18, w30
	bgt	.L60
.L46:
	sub	w20, w20, w17
	add	x19, x19, x17, sxtw 4
	cmp	w20, wzr
	bgt	.L59
.L36:
	add	sp, x29, 0
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp], 64
	ret
	.p2align 3
.L66:
	uxth	w0, w7
	strh	w8, [x14, x9, lsl 1]
	cmp	w5, 1
	add	w18, w9, 1
	sub	w6, w0, w10
	mov	w10, w7
	strh	w6, [x13, x9, lsl 1]
	add	x9, x9, 1
	ble	.L38
	mov	w8, w5
	b	.L42
.L54:
	mov	w5, w17
	mov	w0, 0
	mov	w18, 0
.L38:
	cmp	w5, 1
	bne	.L43
	ldr	w7, [x19, 8]
	sbfiz	x6, x18, 1, 32
	add	w18, w18, 1
	strh	w5, [x14, x6]
	sub	w0, w7, w0
	strh	w0, [x13, x6]
.L43:
	cmp	w17, wzr
	ble	.L48
	b	.L44
	.size	combScheduler, .-combScheduler
	.section	.text.startup,"ax",%progbits
	.align	2
	.p2align 4,,15
	.global	main
	.type	main, %function
main:
	sub	sp, sp, #618496
	mov	x1, 29752
	movk	x1, 0x9, lsl 16
	sub	sp, sp, #992
	adrp	x0, __stack_chk_guard
	add	x0, x0, :lo12:__stack_chk_guard
	stp	x29, x30, [sp, -112]!
	add	x29, sp, 0
	add	x2, x29, 16
	stp	x19, x20, [sp, 16]
	mov	x19, 128
	stp	x21, x22, [sp, 32]
	add	x1, x1, x2
	stp	x23, x24, [sp, 48]
	stp	x25, x26, [sp, 64]
	stp	x27, x28, [sp, 80]
	str	d8, [sp, 96]
	ldr	x2, [x0]
	str	x2, [x1]
	mov	x2,0
	add	x0, x29, 256
	stp	xzr, xzr, [x29, 240]
	str	x19, [x29, 240]
	stp	xzr, xzr, [x0]
	add	x0, x29, 272
	stp	xzr, xzr, [x0]
	add	x0, x29, 288
	stp	xzr, xzr, [x0]
	add	x0, x29, 304
	stp	xzr, xzr, [x0]
	add	x0, x29, 320
	stp	xzr, xzr, [x0]
	add	x0, x29, 336
	stp	xzr, xzr, [x0]
	add	x0, x29, 352
	stp	xzr, xzr, [x0]
	bl	getpid
	add	x2, x29, 240
	mov	x1, x19
	bl	sched_setaffinity
	cbz	w0, .L69
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	perror
.L69:
	ldr	q0, .LC2
	add	x3, x29, 16
	mov	x2, 5184
	add	x2, x2, x3
	mov	w1, 1
	sub	x19, x2, #8
	mov	x2, 5184
	add	x2, x2, x3
	add	x0, x29, 136
	add	x20, x2, 2040
	str	q0, [x29, 5168]
	bl	timespec_get
	ldp	x0, x1, [x29, 136]
	eor	w0, w1, w0
	bl	srandom
.L70:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L70
	mov	x0, 9280
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L71:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L71
	add	x1, x29, 16
	mov	x0, 9280
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 9280
	add	x0, x0, x1
	add	x20, x0, 2040
.L72:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L72
	mov	x0, 13376
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L73:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L73
	add	x1, x29, 16
	mov	x0, 13376
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 13376
	add	x0, x0, x1
	add	x20, x0, 2040
.L74:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L74
	mov	x0, 17472
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L75:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L75
	add	x1, x29, 16
	mov	x0, 17472
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 17472
	add	x0, x0, x1
	add	x20, x0, 2040
.L76:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L76
	mov	x0, 21568
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L77:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L77
	add	x1, x29, 16
	mov	x0, 21568
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 21568
	add	x0, x0, x1
	add	x20, x0, 2040
.L78:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L78
	mov	x0, 25664
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L79:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L79
	add	x1, x29, 16
	mov	x0, 25664
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 25664
	add	x0, x0, x1
	add	x20, x0, 2040
.L80:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L80
	mov	x0, 29760
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L81:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L81
	add	x1, x29, 16
	mov	x0, 29760
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 29760
	add	x0, x0, x1
	add	x20, x0, 2040
.L82:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L82
	mov	x0, 33856
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L83:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L83
	add	x1, x29, 16
	mov	x0, 33856
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 33856
	add	x0, x0, x1
	add	x20, x0, 2040
.L84:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L84
	mov	x0, 37952
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L85:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L85
	add	x1, x29, 16
	mov	x0, 37952
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 37952
	add	x0, x0, x1
	add	x20, x0, 2040
.L86:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L86
	mov	x0, 42048
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L87:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L87
	add	x1, x29, 16
	mov	x0, 42048
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 42048
	add	x0, x0, x1
	add	x20, x0, 2040
.L88:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L88
	mov	x0, 46144
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L89:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L89
	add	x1, x29, 16
	mov	x0, 46144
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 46144
	add	x0, x0, x1
	add	x20, x0, 2040
.L90:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L90
	mov	x0, 50240
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L91:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L91
	add	x1, x29, 16
	mov	x0, 50240
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 50240
	add	x0, x0, x1
	add	x20, x0, 2040
.L92:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L92
	mov	x0, 54336
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L93:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L93
	add	x1, x29, 16
	mov	x0, 54336
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 54336
	add	x0, x0, x1
	add	x20, x0, 2040
.L94:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L94
	mov	x0, 58432
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L95:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L95
	add	x1, x29, 16
	mov	x0, 58432
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 58432
	add	x0, x0, x1
	add	x20, x0, 2040
.L96:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L96
	mov	x0, 62528
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L97:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L97
	add	x1, x29, 16
	mov	x0, 62528
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 62528
	add	x0, x0, x1
	add	x20, x0, 2040
.L98:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L98
	mov	x0, 1088
	movk	x0, 0x1, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L99:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L99
	add	x1, x29, 16
	mov	x0, 1088
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 1088
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L100:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L100
	mov	x0, 5184
	movk	x0, 0x1, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L101:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L101
	add	x1, x29, 16
	mov	x0, 5184
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 5184
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L102:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L102
	mov	x0, 9280
	movk	x0, 0x1, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L103:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L103
	add	x1, x29, 16
	mov	x0, 9280
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 9280
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L104:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L104
	mov	x0, 13376
	movk	x0, 0x1, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L105:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L105
	add	x1, x29, 16
	mov	x0, 13376
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 13376
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L106:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L106
	mov	x0, 17472
	movk	x0, 0x1, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L107:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L107
	add	x1, x29, 16
	mov	x0, 17472
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 17472
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L108:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L108
	mov	x0, 21568
	movk	x0, 0x1, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L109:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L109
	add	x1, x29, 16
	mov	x0, 21568
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 21568
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L110:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L110
	mov	x0, 25664
	movk	x0, 0x1, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L111:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L111
	add	x1, x29, 16
	mov	x0, 25664
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 25664
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L112:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L112
	mov	x0, 29760
	movk	x0, 0x1, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L113:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L113
	add	x1, x29, 16
	mov	x0, 29760
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 29760
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L114:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L114
	mov	x0, 33856
	movk	x0, 0x1, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L115:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L115
	add	x1, x29, 16
	mov	x0, 33856
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 33856
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L116:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L116
	mov	x0, 37952
	movk	x0, 0x1, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L117:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L117
	add	x1, x29, 16
	mov	x0, 37952
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 37952
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L118:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L118
	mov	x0, 42048
	movk	x0, 0x1, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L119:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L119
	add	x1, x29, 16
	mov	x0, 42048
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 42048
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L120:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L120
	mov	x0, 46144
	movk	x0, 0x1, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L121:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L121
	add	x1, x29, 16
	mov	x0, 46144
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 46144
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L122:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L122
	mov	x0, 50240
	movk	x0, 0x1, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L123:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L123
	add	x1, x29, 16
	mov	x0, 50240
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 50240
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L124:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L124
	mov	x0, 54336
	movk	x0, 0x1, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L125:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L125
	add	x1, x29, 16
	mov	x0, 54336
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 54336
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L126:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L126
	mov	x0, 58432
	movk	x0, 0x1, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L127:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L127
	add	x1, x29, 16
	mov	x0, 58432
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 58432
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L128:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L128
	mov	x0, 62528
	movk	x0, 0x1, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L129:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L129
	add	x1, x29, 16
	mov	x0, 62528
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 62528
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L130:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L130
	mov	x0, 1088
	movk	x0, 0x2, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L131:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L131
	add	x1, x29, 16
	mov	x0, 1088
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 1088
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L132:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L132
	mov	x0, 5184
	movk	x0, 0x2, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L133:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L133
	add	x1, x29, 16
	mov	x0, 5184
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 5184
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L134:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L134
	mov	x0, 9280
	movk	x0, 0x2, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L135:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L135
	add	x1, x29, 16
	mov	x0, 9280
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 9280
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L136:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L136
	mov	x0, 13376
	movk	x0, 0x2, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L137:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L137
	add	x1, x29, 16
	mov	x0, 13376
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 13376
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L138:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L138
	mov	x0, 17472
	movk	x0, 0x2, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L139:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L139
	add	x1, x29, 16
	mov	x0, 17472
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 17472
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L140:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L140
	mov	x0, 21568
	movk	x0, 0x2, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L141:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L141
	add	x1, x29, 16
	mov	x0, 21568
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 21568
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L142:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L142
	mov	x0, 25664
	movk	x0, 0x2, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L143:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L143
	add	x1, x29, 16
	mov	x0, 25664
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 25664
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L144:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L144
	mov	x0, 29760
	movk	x0, 0x2, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L145:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L145
	mov	x0, 29760
	movk	x0, 0x2, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L146:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L146
	mov	x0, 33856
	movk	x0, 0x2, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L147:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L147
	add	x1, x29, 16
	mov	x0, 33856
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 33856
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L148:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L148
	mov	x0, 37952
	movk	x0, 0x2, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L149:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L149
	add	x1, x29, 16
	mov	x0, 37952
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 37952
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L150:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L150
	mov	x0, 42048
	movk	x0, 0x2, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L151:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L151
	add	x1, x29, 16
	mov	x0, 42048
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 42048
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L152:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L152
	mov	x0, 46144
	movk	x0, 0x2, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L153:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L153
	add	x1, x29, 16
	mov	x0, 46144
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 46144
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L154:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L154
	mov	x0, 50240
	movk	x0, 0x2, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L155:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L155
	add	x1, x29, 16
	mov	x0, 50240
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 50240
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L156:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L156
	mov	x0, 54336
	movk	x0, 0x2, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L157:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L157
	add	x1, x29, 16
	mov	x0, 54336
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 54336
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L158:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L158
	mov	x0, 58432
	movk	x0, 0x2, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L159:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L159
	add	x1, x29, 16
	mov	x0, 58432
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 58432
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L160:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L160
	mov	x0, 62528
	movk	x0, 0x2, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L161:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L161
	add	x1, x29, 16
	mov	x0, 62528
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 62528
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L162:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L162
	mov	x0, 1088
	movk	x0, 0x3, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L163:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L163
	add	x1, x29, 16
	mov	x0, 1088
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 1088
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L164:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L164
	mov	x0, 5184
	movk	x0, 0x3, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L165:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L165
	add	x1, x29, 16
	mov	x0, 5184
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 5184
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L166:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L166
	mov	x0, 9280
	movk	x0, 0x3, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L167:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L167
	add	x1, x29, 16
	mov	x0, 9280
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 9280
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L168:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L168
	mov	x0, 13376
	movk	x0, 0x3, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L169:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L169
	add	x1, x29, 16
	mov	x0, 13376
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 13376
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L170:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L170
	mov	x0, 17472
	movk	x0, 0x3, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L171:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L171
	add	x1, x29, 16
	mov	x0, 17472
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 17472
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L172:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L172
	mov	x0, 21568
	movk	x0, 0x3, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L173:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L173
	add	x1, x29, 16
	mov	x0, 21568
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 21568
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L174:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L174
	mov	x0, 25664
	movk	x0, 0x3, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L175:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L175
	add	x1, x29, 16
	mov	x0, 25664
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 25664
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L176:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L176
	mov	x0, 29760
	movk	x0, 0x3, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L177:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L177
	add	x1, x29, 16
	mov	x0, 29760
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 29760
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L178:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L178
	mov	x0, 33856
	movk	x0, 0x3, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L179:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L179
	add	x1, x29, 16
	mov	x0, 33856
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 33856
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L180:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L180
	mov	x0, 37952
	movk	x0, 0x3, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L181:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L181
	add	x1, x29, 16
	mov	x0, 37952
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 37952
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L182:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L182
	mov	x0, 42048
	movk	x0, 0x3, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L183:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L183
	add	x1, x29, 16
	mov	x0, 42048
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 42048
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L184:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L184
	mov	x0, 46144
	movk	x0, 0x3, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L185:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L185
	add	x1, x29, 16
	mov	x0, 46144
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 46144
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L186:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L186
	mov	x0, 50240
	movk	x0, 0x3, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L187:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L187
	add	x1, x29, 16
	mov	x0, 50240
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 50240
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L188:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L188
	mov	x0, 54336
	movk	x0, 0x3, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L189:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L189
	add	x1, x29, 16
	mov	x0, 54336
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 54336
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L190:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L190
	mov	x0, 58432
	movk	x0, 0x3, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L191:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L191
	add	x1, x29, 16
	mov	x0, 58432
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 58432
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L192:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L192
	mov	x0, 62528
	movk	x0, 0x3, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L193:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L193
	add	x1, x29, 16
	mov	x0, 62528
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 62528
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L194:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L194
	mov	x0, 1088
	movk	x0, 0x4, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L195:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L195
	add	x1, x29, 16
	mov	x0, 1088
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 1088
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L196:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L196
	mov	x0, 5184
	movk	x0, 0x4, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L197:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L197
	add	x1, x29, 16
	mov	x0, 5184
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 5184
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L198:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L198
	mov	x0, 9280
	movk	x0, 0x4, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L199:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L199
	add	x1, x29, 16
	mov	x0, 9280
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 9280
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L200:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L200
	mov	x0, 13376
	movk	x0, 0x4, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L201:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L201
	add	x1, x29, 16
	mov	x0, 13376
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 13376
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L202:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L202
	mov	x0, 17472
	movk	x0, 0x4, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L203:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L203
	add	x1, x29, 16
	mov	x0, 17472
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 17472
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L204:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L204
	mov	x0, 21568
	movk	x0, 0x4, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L205:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L205
	add	x1, x29, 16
	mov	x0, 21568
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 21568
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L206:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L206
	mov	x0, 25664
	movk	x0, 0x4, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L207:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L207
	add	x1, x29, 16
	mov	x0, 25664
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 25664
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L208:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L208
	mov	x0, 29760
	movk	x0, 0x4, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L209:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L209
	add	x1, x29, 16
	mov	x0, 29760
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 29760
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L210:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L210
	mov	x0, 33856
	movk	x0, 0x4, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L211:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L211
	add	x1, x29, 16
	mov	x0, 33856
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 33856
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L212:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L212
	mov	x0, 37952
	movk	x0, 0x4, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L213:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L213
	add	x1, x29, 16
	mov	x0, 37952
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 37952
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L214:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L214
	mov	x0, 42048
	movk	x0, 0x4, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L215:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L215
	add	x1, x29, 16
	mov	x0, 42048
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 42048
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L216:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L216
	mov	x0, 46144
	movk	x0, 0x4, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L217:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L217
	add	x1, x29, 16
	mov	x0, 46144
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 46144
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L218:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L218
	mov	x0, 50240
	movk	x0, 0x4, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L219:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L219
	add	x1, x29, 16
	mov	x0, 50240
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 50240
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L220:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L220
	mov	x0, 54336
	movk	x0, 0x4, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L221:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L221
	add	x1, x29, 16
	mov	x0, 54336
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 54336
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L222:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L222
	mov	x0, 58432
	movk	x0, 0x4, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L223:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L223
	add	x1, x29, 16
	mov	x0, 58432
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 58432
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L224:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L224
	mov	x0, 62528
	movk	x0, 0x4, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L225:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L225
	add	x1, x29, 16
	mov	x0, 62528
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 62528
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L226:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L226
	mov	x0, 1088
	movk	x0, 0x5, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L227:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L227
	add	x1, x29, 16
	mov	x0, 1088
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 1088
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L228:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L228
	mov	x0, 5184
	movk	x0, 0x5, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L229:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L229
	add	x1, x29, 16
	mov	x0, 5184
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 5184
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L230:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L230
	mov	x0, 9280
	movk	x0, 0x5, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L231:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L231
	add	x1, x29, 16
	mov	x0, 9280
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 9280
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L232:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L232
	mov	x0, 13376
	movk	x0, 0x5, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L233:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L233
	add	x1, x29, 16
	mov	x0, 13376
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 13376
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L234:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L234
	mov	x0, 17472
	movk	x0, 0x5, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L235:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L235
	add	x1, x29, 16
	mov	x0, 17472
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 17472
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L236:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L236
	mov	x0, 21568
	movk	x0, 0x5, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L237:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L237
	add	x1, x29, 16
	mov	x0, 21568
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 21568
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L238:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L238
	mov	x0, 25664
	movk	x0, 0x5, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L239:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L239
	add	x1, x29, 16
	mov	x0, 25664
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 25664
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L240:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L240
	mov	x0, 29760
	movk	x0, 0x5, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L241:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L241
	add	x1, x29, 16
	mov	x0, 29760
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 29760
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L242:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L242
	mov	x0, 33856
	movk	x0, 0x5, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L243:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L243
	add	x1, x29, 16
	mov	x0, 33856
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 33856
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L244:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L244
	mov	x0, 37952
	movk	x0, 0x5, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L245:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L245
	add	x1, x29, 16
	mov	x0, 37952
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 37952
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L246:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L246
	mov	x0, 42048
	movk	x0, 0x5, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L247:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L247
	add	x1, x29, 16
	mov	x0, 42048
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 42048
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L248:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L248
	mov	x0, 46144
	movk	x0, 0x5, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L249:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L249
	add	x1, x29, 16
	mov	x0, 46144
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 46144
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L250:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L250
	mov	x0, 50240
	movk	x0, 0x5, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L251:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L251
	add	x1, x29, 16
	mov	x0, 50240
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 50240
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L252:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L252
	mov	x0, 54336
	movk	x0, 0x5, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L253:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L253
	add	x1, x29, 16
	mov	x0, 54336
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 54336
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L254:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L254
	mov	x0, 58432
	movk	x0, 0x5, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L255:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L255
	add	x1, x29, 16
	mov	x0, 58432
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 58432
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L256:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L256
	mov	x0, 62528
	movk	x0, 0x5, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L257:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L257
	add	x1, x29, 16
	mov	x0, 62528
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 62528
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L258:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L258
	mov	x0, 1088
	movk	x0, 0x6, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L259:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L259
	add	x1, x29, 16
	mov	x0, 1088
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 1088
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L260:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L260
	mov	x0, 5184
	movk	x0, 0x6, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L261:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L261
	add	x1, x29, 16
	mov	x0, 5184
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 5184
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L262:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L262
	mov	x0, 9280
	movk	x0, 0x6, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L263:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L263
	add	x1, x29, 16
	mov	x0, 9280
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 9280
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L264:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L264
	mov	x0, 13376
	movk	x0, 0x6, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L265:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L265
	add	x1, x29, 16
	mov	x0, 13376
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 13376
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L266:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L266
	mov	x0, 17472
	movk	x0, 0x6, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L267:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L267
	add	x1, x29, 16
	mov	x0, 17472
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 17472
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L268:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L268
	mov	x0, 21568
	movk	x0, 0x6, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L269:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L269
	add	x1, x29, 16
	mov	x0, 21568
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 21568
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L270:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L270
	mov	x0, 25664
	movk	x0, 0x6, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L271:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L271
	add	x1, x29, 16
	mov	x0, 25664
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 25664
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L272:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L272
	mov	x0, 29760
	movk	x0, 0x6, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L273:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L273
	add	x1, x29, 16
	mov	x0, 29760
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 29760
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L274:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L274
	mov	x0, 33856
	movk	x0, 0x6, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L275:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L275
	add	x1, x29, 16
	mov	x0, 33856
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 33856
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L276:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L276
	mov	x0, 37952
	movk	x0, 0x6, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L277:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L277
	add	x1, x29, 16
	mov	x0, 37952
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 37952
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L278:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L278
	mov	x0, 42048
	movk	x0, 0x6, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L279:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L279
	add	x1, x29, 16
	mov	x0, 42048
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 42048
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L280:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L280
	mov	x0, 46144
	movk	x0, 0x6, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L281:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L281
	add	x1, x29, 16
	mov	x0, 46144
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 46144
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L282:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L282
	mov	x0, 50240
	movk	x0, 0x6, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L283:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L283
	add	x1, x29, 16
	mov	x0, 50240
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 50240
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L284:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L284
	mov	x0, 54336
	movk	x0, 0x6, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L285:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L285
	add	x1, x29, 16
	mov	x0, 54336
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 54336
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L286:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L286
	mov	x0, 58432
	movk	x0, 0x6, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L287:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L287
	add	x1, x29, 16
	mov	x0, 58432
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 58432
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L288:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L288
	mov	x0, 62528
	movk	x0, 0x6, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L289:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L289
	add	x1, x29, 16
	mov	x0, 62528
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 62528
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L290:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L290
	mov	x0, 1088
	movk	x0, 0x7, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L291:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L291
	add	x1, x29, 16
	mov	x0, 1088
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 1088
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L292:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L292
	mov	x0, 5184
	movk	x0, 0x7, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L293:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L293
	add	x1, x29, 16
	mov	x0, 5184
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 5184
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L294:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L294
	mov	x0, 9280
	movk	x0, 0x7, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L295:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L295
	add	x1, x29, 16
	mov	x0, 9280
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 9280
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L296:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L296
	mov	x0, 13376
	movk	x0, 0x7, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L297:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L297
	add	x1, x29, 16
	mov	x0, 13376
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 13376
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L298:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L298
	mov	x0, 17472
	movk	x0, 0x7, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L299:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L299
	add	x1, x29, 16
	mov	x0, 17472
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 17472
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L300:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L300
	mov	x0, 21568
	movk	x0, 0x7, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L301:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L301
	add	x1, x29, 16
	mov	x0, 21568
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 21568
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L302:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L302
	mov	x0, 25664
	movk	x0, 0x7, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L303:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L303
	add	x1, x29, 16
	mov	x0, 25664
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 25664
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L304:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L304
	mov	x0, 29760
	movk	x0, 0x7, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L305:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L305
	add	x1, x29, 16
	mov	x0, 29760
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 29760
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L306:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L306
	mov	x0, 33856
	movk	x0, 0x7, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L307:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L307
	add	x1, x29, 16
	mov	x0, 33856
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 33856
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L308:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L308
	mov	x0, 37952
	movk	x0, 0x7, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L309:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L309
	add	x1, x29, 16
	mov	x0, 37952
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 37952
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L310:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L310
	mov	x0, 42048
	movk	x0, 0x7, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L311:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L311
	add	x1, x29, 16
	mov	x0, 42048
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 42048
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L312:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L312
	mov	x0, 46144
	movk	x0, 0x7, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L313:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L313
	add	x1, x29, 16
	mov	x0, 46144
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 46144
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L314:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L314
	mov	x0, 50240
	movk	x0, 0x7, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L315:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L315
	add	x1, x29, 16
	mov	x0, 50240
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 50240
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L316:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L316
	mov	x0, 54336
	movk	x0, 0x7, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L317:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L317
	add	x1, x29, 16
	mov	x0, 54336
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 54336
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L318:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L318
	mov	x0, 58432
	movk	x0, 0x7, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L319:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L319
	add	x1, x29, 16
	mov	x0, 58432
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 58432
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L320:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L320
	mov	x0, 62528
	movk	x0, 0x7, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L321:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L321
	add	x1, x29, 16
	mov	x0, 62528
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 62528
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L322:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L322
	mov	x0, 1088
	movk	x0, 0x8, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L323:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L323
	add	x1, x29, 16
	mov	x0, 1088
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 1088
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L324:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L324
	mov	x0, 5184
	movk	x0, 0x8, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L325:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L325
	add	x1, x29, 16
	mov	x0, 5184
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 5184
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L326:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L326
	mov	x0, 9280
	movk	x0, 0x8, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L327:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L327
	add	x1, x29, 16
	mov	x0, 9280
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 9280
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L328:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L328
	mov	x0, 13376
	movk	x0, 0x8, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L329:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L329
	add	x1, x29, 16
	mov	x0, 13376
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 13376
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L330:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L330
	mov	x0, 17472
	movk	x0, 0x8, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L331:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L331
	add	x1, x29, 16
	mov	x0, 17472
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 17472
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L332:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L332
	mov	x0, 21568
	movk	x0, 0x8, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L333:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L333
	add	x1, x29, 16
	mov	x0, 21568
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 21568
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L334:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L334
	mov	x0, 25664
	movk	x0, 0x8, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L335:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L335
	add	x1, x29, 16
	mov	x0, 25664
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 25664
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L336:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L336
	mov	x0, 29760
	movk	x0, 0x8, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L337:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L337
	add	x1, x29, 16
	mov	x0, 29760
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 29760
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L338:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L338
	mov	x0, 33856
	movk	x0, 0x8, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L339:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L339
	mov	x0, 33856
	movk	x0, 0x8, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L340:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L340
	mov	x0, 37952
	movk	x0, 0x8, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L341:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L341
	mov	x0, 37952
	movk	x0, 0x8, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L342:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L342
	mov	x0, 42048
	movk	x0, 0x8, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L343:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L343
	mov	x0, 42048
	movk	x0, 0x8, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L344:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L344
	mov	x0, 46144
	movk	x0, 0x8, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L345:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L345
	mov	x0, 46144
	movk	x0, 0x8, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L346:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L346
	mov	x0, 50240
	movk	x0, 0x8, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L347:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L347
	mov	x0, 50240
	movk	x0, 0x8, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L348:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L348
	mov	x0, 54336
	movk	x0, 0x8, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L349:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L349
	mov	x0, 54336
	movk	x0, 0x8, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L350:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L350
	mov	x0, 58432
	movk	x0, 0x8, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L351:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L351
	mov	x0, 58432
	movk	x0, 0x8, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L352:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L352
	mov	x0, 62528
	movk	x0, 0x8, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L353:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L353
	mov	x0, 62528
	movk	x0, 0x8, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L354:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L354
	mov	x0, 1088
	movk	x0, 0x9, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L355:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L355
	mov	x0, 1088
	movk	x0, 0x9, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L356:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L356
	mov	x0, 5184
	movk	x0, 0x9, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L357:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L357
	mov	x0, 5184
	movk	x0, 0x9, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L358:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L358
	mov	x0, 9280
	movk	x0, 0x9, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L359:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L359
	mov	x0, 9280
	movk	x0, 0x9, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L360:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L360
	mov	x0, 13376
	movk	x0, 0x9, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L361:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L361
	mov	x0, 13376
	movk	x0, 0x9, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L362:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L362
	mov	x0, 17472
	movk	x0, 0x9, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L363:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L363
	mov	x0, 17472
	movk	x0, 0x9, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L364:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L364
	mov	x0, 21568
	movk	x0, 0x9, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L365:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L365
	mov	x0, 21568
	movk	x0, 0x9, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L366:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L366
	mov	x0, 25664
	movk	x0, 0x9, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L367:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L367
	mov	x0, 25664
	movk	x0, 0x9, lsl 16
	add	x1, x29, 16
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L368:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L368
	mov	x0, 27704
	movk	x0, 0x9, lsl 16
	add	x1, x29, 16
	add	x19, x1, x0
	mov	x20, x19
	add	x21, x19, 2048
.L369:
	bl	random
	strb	w0, [x20], 1
	cmp	x21, x20
	bne	.L369
	add	x1, x29, 16
	mov	x0, 5184
	add	x0, x0, x1
	mov	w4, 128
	sub	x0, x0, #8
	add	x2, x29, 16
	str	w4, [x29, 376]
	add	x3, x29, 16
	add	x5, x29, 16
	str	x0, [x29, 368]
	mov	x0, 9280
	add	x6, x29, 16
	add	x0, x0, x1
	str	w4, [x29, 392]
	mov	w23, 26215
	movk	w23, 0x6666, lsl 16
	sub	x0, x0, #2056
	str	w4, [x29, 408]
	add	x25, x29, 360
	str	w4, [x29, 424]
	str	x0, [x29, 384]
	mov	x0, 9280
	add	x0, x0, x1
	str	w4, [x29, 440]
	sub	x0, x0, #8
	str	w4, [x29, 456]
	str	w4, [x29, 472]
	str	x0, [x29, 400]
	mov	x0, 13376
	add	x0, x0, x1
	str	w4, [x29, 488]
	sub	x0, x0, #2056
	str	w4, [x29, 504]
	str	w4, [x29, 520]
	str	x0, [x29, 416]
	mov	x0, 13376
	add	x0, x0, x1
	str	w4, [x29, 536]
	sub	x0, x0, #8
	str	w4, [x29, 552]
	str	w4, [x29, 568]
	str	x0, [x29, 432]
	mov	x0, 17472
	add	x0, x0, x1
	str	w4, [x29, 584]
	sub	x0, x0, #2056
	str	w4, [x29, 600]
	str	w4, [x29, 616]
	str	x0, [x29, 448]
	mov	x0, 17472
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 464]
	mov	x0, 21568
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 480]
	mov	x0, 21568
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 496]
	mov	x0, 25664
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 512]
	mov	x0, 25664
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 528]
	mov	x0, 29760
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 544]
	mov	x0, 29760
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 560]
	mov	x0, 33856
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 576]
	mov	x0, 33856
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 592]
	mov	x0, 37952
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 608]
	mov	x0, 37952
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 624]
	mov	x0, 42048
	add	x0, x0, x1
	str	w4, [x29, 632]
	sub	x0, x0, #2056
	str	w4, [x29, 648]
	str	w4, [x29, 664]
	str	x0, [x29, 640]
	mov	x0, 42048
	add	x0, x0, x1
	str	w4, [x29, 680]
	sub	x0, x0, #8
	str	w4, [x29, 696]
	str	w4, [x29, 712]
	str	x0, [x29, 656]
	mov	x0, 46144
	add	x0, x0, x1
	str	w4, [x29, 728]
	sub	x0, x0, #2056
	str	w4, [x29, 744]
	str	w4, [x29, 760]
	str	x0, [x29, 672]
	mov	x0, 46144
	add	x0, x0, x1
	str	w4, [x29, 776]
	sub	x0, x0, #8
	str	w4, [x29, 792]
	str	w4, [x29, 808]
	str	x0, [x29, 688]
	mov	x0, 50240
	add	x0, x0, x1
	str	w4, [x29, 824]
	sub	x0, x0, #2056
	str	w4, [x29, 840]
	str	w4, [x29, 856]
	str	x0, [x29, 704]
	mov	x0, 50240
	add	x0, x0, x1
	str	w4, [x29, 872]
	sub	x0, x0, #8
	str	x0, [x29, 720]
	mov	x0, 54336
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 736]
	mov	x0, 54336
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 752]
	mov	x0, 58432
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 768]
	mov	x0, 58432
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 784]
	mov	x0, 62528
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 800]
	mov	x0, 62528
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 816]
	mov	x0, 1088
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 832]
	mov	x0, 1088
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 848]
	mov	x0, 5184
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 864]
	mov	x0, 5184
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 880]
	mov	x0, 9280
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 888]
	sub	x0, x0, #2056
	str	w4, [x29, 904]
	str	w4, [x29, 920]
	str	x0, [x29, 896]
	mov	x0, 9280
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 936]
	sub	x0, x0, #8
	str	w4, [x29, 952]
	str	w4, [x29, 968]
	str	x0, [x29, 912]
	mov	x0, 13376
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 984]
	sub	x0, x0, #2056
	str	w4, [x29, 1000]
	str	w4, [x29, 1016]
	str	x0, [x29, 928]
	mov	x0, 13376
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1032]
	sub	x0, x0, #8
	str	w4, [x29, 1048]
	str	w4, [x29, 1064]
	str	x0, [x29, 944]
	mov	x0, 17472
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1080]
	sub	x0, x0, #2056
	str	w4, [x29, 1096]
	str	w4, [x29, 1112]
	str	x0, [x29, 960]
	mov	x0, 17472
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1128]
	sub	x0, x0, #8
	str	w4, [x29, 1144]
	str	x0, [x29, 976]
	mov	x0, 21568
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 992]
	mov	x0, 21568
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1008]
	mov	x0, 25664
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1024]
	mov	x0, 25664
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1040]
	mov	x0, 29760
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1056]
	mov	x0, 29760
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1072]
	mov	x0, 33856
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1088]
	mov	x0, 33856
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1104]
	mov	x0, 37952
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1120]
	mov	x0, 37952
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1136]
	mov	x0, 42048
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1152]
	mov	x0, 42048
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1160]
	sub	x0, x0, #8
	str	w4, [x29, 1176]
	str	w4, [x29, 1192]
	str	x0, [x29, 1168]
	mov	x0, 46144
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1208]
	sub	x0, x0, #2056
	str	w4, [x29, 1224]
	str	w4, [x29, 1240]
	str	x0, [x29, 1184]
	mov	x0, 46144
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1256]
	sub	x0, x0, #8
	str	w4, [x29, 1272]
	str	w4, [x29, 1288]
	str	x0, [x29, 1200]
	mov	x0, 50240
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1304]
	sub	x0, x0, #2056
	str	w4, [x29, 1320]
	str	w4, [x29, 1336]
	str	x0, [x29, 1216]
	mov	x0, 50240
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1352]
	sub	x0, x0, #8
	str	w4, [x29, 1368]
	str	w4, [x29, 1384]
	str	x0, [x29, 1232]
	mov	x0, 54336
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1400]
	sub	x0, x0, #2056
	str	x0, [x29, 1248]
	mov	x0, 54336
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1264]
	mov	x0, 58432
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1280]
	mov	x0, 58432
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1296]
	mov	x0, 62528
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1312]
	mov	x0, 62528
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1328]
	mov	x0, 1088
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1344]
	mov	x0, 1088
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1360]
	mov	x0, 5184
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1376]
	mov	x0, 5184
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1392]
	mov	x0, 9280
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1408]
	mov	x0, 9280
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1416]
	sub	x0, x0, #8
	str	w4, [x29, 1432]
	str	w4, [x29, 1448]
	str	x0, [x29, 1424]
	mov	x0, 13376
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1464]
	sub	x0, x0, #2056
	str	w4, [x29, 1480]
	str	w4, [x29, 1496]
	str	x0, [x29, 1440]
	mov	x0, 13376
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1512]
	sub	x0, x0, #8
	str	w4, [x29, 1528]
	str	w4, [x29, 1544]
	str	x0, [x29, 1456]
	mov	x0, 17472
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1560]
	sub	x0, x0, #2056
	str	w4, [x29, 1576]
	str	w4, [x29, 1592]
	str	x0, [x29, 1472]
	mov	x0, 17472
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1608]
	sub	x0, x0, #8
	str	w4, [x29, 1624]
	str	w4, [x29, 1640]
	str	x0, [x29, 1488]
	mov	x0, 21568
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1656]
	sub	x0, x0, #2056
	str	w4, [x29, 1672]
	str	x0, [x29, 1504]
	mov	x0, 21568
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1520]
	mov	x0, 25664
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1536]
	mov	x0, 25664
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1552]
	mov	x0, 29760
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1568]
	mov	x0, 29760
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1584]
	mov	x0, 33856
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1600]
	mov	x0, 33856
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1616]
	mov	x0, 37952
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1632]
	mov	x0, 37952
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1648]
	mov	x0, 42048
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1664]
	mov	x0, 42048
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1680]
	mov	x0, 46144
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1688]
	sub	x0, x0, #2056
	str	w4, [x29, 1704]
	str	w4, [x29, 1720]
	str	x0, [x29, 1696]
	mov	x0, 46144
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1736]
	sub	x0, x0, #8
	str	w4, [x29, 1752]
	str	w4, [x29, 1768]
	str	x0, [x29, 1712]
	mov	x0, 50240
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1784]
	sub	x0, x0, #2056
	str	w4, [x29, 1800]
	str	w4, [x29, 1816]
	str	x0, [x29, 1728]
	mov	x0, 50240
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1832]
	sub	x0, x0, #8
	str	w4, [x29, 1848]
	str	w4, [x29, 1864]
	str	x0, [x29, 1744]
	mov	x0, 54336
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1880]
	sub	x0, x0, #2056
	str	w4, [x29, 1896]
	str	w4, [x29, 1912]
	str	x0, [x29, 1760]
	mov	x0, 54336
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1928]
	sub	x0, x0, #8
	str	x0, [x29, 1776]
	mov	x0, 58432
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1792]
	mov	x0, 58432
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1808]
	mov	x0, 62528
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1824]
	mov	x0, 62528
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1840]
	mov	x0, 1088
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1856]
	mov	x0, 1088
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1872]
	mov	x0, 5184
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1888]
	mov	x0, 5184
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1904]
	mov	x0, 9280
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1920]
	mov	x0, 9280
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1936]
	mov	x0, 13376
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1944]
	sub	x0, x0, #2056
	str	w4, [x29, 1960]
	str	w4, [x29, 1976]
	str	x0, [x29, 1952]
	mov	x0, 13376
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1992]
	sub	x0, x0, #8
	str	w4, [x29, 2008]
	str	w4, [x29, 2024]
	str	x0, [x29, 1968]
	mov	x0, 17472
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2040]
	sub	x0, x0, #2056
	str	w4, [x29, 2056]
	str	w4, [x29, 2072]
	str	x0, [x29, 1984]
	mov	x0, 17472
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2088]
	sub	x0, x0, #8
	str	w4, [x29, 2104]
	str	w4, [x29, 2120]
	str	x0, [x29, 2000]
	mov	x0, 21568
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2136]
	sub	x0, x0, #2056
	str	w4, [x29, 2152]
	str	w4, [x29, 2168]
	str	x0, [x29, 2016]
	mov	x0, 21568
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2184]
	sub	x0, x0, #8
	str	w4, [x29, 2200]
	str	x0, [x29, 2032]
	mov	x0, 25664
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2048]
	mov	x0, 25664
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2064]
	mov	x0, 29760
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2080]
	mov	x0, 29760
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2096]
	mov	x0, 33856
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2112]
	mov	x0, 33856
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2128]
	mov	x0, 37952
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2144]
	mov	x0, 37952
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2160]
	mov	x0, 42048
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2176]
	mov	x0, 42048
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2192]
	mov	x0, 46144
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2208]
	mov	x0, 46144
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2216]
	sub	x0, x0, #8
	str	w4, [x29, 2232]
	str	w4, [x29, 2248]
	str	x0, [x29, 2224]
	mov	x0, 50240
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2264]
	sub	x0, x0, #2056
	str	w4, [x29, 2280]
	str	w4, [x29, 2296]
	str	x0, [x29, 2240]
	mov	x0, 50240
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2312]
	sub	x0, x0, #8
	str	w4, [x29, 2328]
	str	w4, [x29, 2344]
	str	x0, [x29, 2256]
	mov	x0, 54336
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2360]
	sub	x0, x0, #2056
	str	w4, [x29, 2376]
	str	w4, [x29, 2392]
	str	x0, [x29, 2272]
	mov	x0, 54336
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2408]
	sub	x0, x0, #8
	str	w4, [x29, 2424]
	str	w4, [x29, 2440]
	str	x0, [x29, 2288]
	mov	x0, 58432
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2456]
	sub	x0, x0, #2056
	str	x0, [x29, 2304]
	mov	x0, 58432
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2320]
	mov	x0, 62528
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2336]
	mov	x0, 62528
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2352]
	mov	x0, 1088
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2368]
	mov	x0, 1088
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2384]
	mov	x0, 5184
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2400]
	mov	x0, 5184
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2416]
	mov	x0, 9280
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2432]
	mov	x0, 9280
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2448]
	mov	x0, 13376
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2464]
	mov	x0, 13376
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2472]
	sub	x0, x0, #8
	str	w4, [x29, 2488]
	str	w4, [x29, 2504]
	str	x0, [x29, 2480]
	mov	x0, 17472
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2520]
	sub	x0, x0, #2056
	str	w4, [x29, 2536]
	str	w4, [x29, 2552]
	str	x0, [x29, 2496]
	mov	x0, 17472
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2568]
	sub	x0, x0, #8
	str	w4, [x29, 2584]
	str	w4, [x29, 2600]
	str	x0, [x29, 2512]
	mov	x0, 21568
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2616]
	sub	x0, x0, #2056
	str	w4, [x29, 2632]
	str	w4, [x29, 2648]
	str	x0, [x29, 2528]
	mov	x0, 21568
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2664]
	sub	x0, x0, #8
	str	w4, [x29, 2680]
	str	w4, [x29, 2696]
	str	x0, [x29, 2544]
	mov	x0, 25664
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2712]
	sub	x0, x0, #2056
	str	w4, [x29, 2728]
	str	x0, [x29, 2560]
	mov	x0, 25664
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2576]
	mov	x0, 29760
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2592]
	mov	x0, 29760
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2608]
	mov	x0, 33856
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2624]
	mov	x0, 33856
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2640]
	mov	x0, 37952
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2656]
	mov	x0, 37952
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2672]
	mov	x0, 42048
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2688]
	mov	x0, 42048
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2704]
	mov	x0, 46144
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2720]
	mov	x0, 46144
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2736]
	mov	x0, 50240
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2744]
	sub	x0, x0, #2056
	str	w4, [x29, 2760]
	str	w4, [x29, 2776]
	str	x0, [x29, 2752]
	mov	x0, 50240
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2792]
	sub	x0, x0, #8
	str	w4, [x29, 2808]
	str	w4, [x29, 2824]
	str	x0, [x29, 2768]
	mov	x0, 54336
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2840]
	sub	x0, x0, #2056
	str	w4, [x29, 2856]
	str	w4, [x29, 2872]
	str	x0, [x29, 2784]
	mov	x0, 54336
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2888]
	sub	x0, x0, #8
	str	w4, [x29, 2904]
	str	w4, [x29, 2920]
	str	x0, [x29, 2800]
	mov	x0, 58432
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2936]
	sub	x0, x0, #2056
	str	w4, [x29, 2952]
	str	w4, [x29, 2968]
	str	x0, [x29, 2816]
	mov	x0, 58432
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2984]
	sub	x0, x0, #8
	str	x0, [x29, 2832]
	mov	x0, 62528
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2848]
	mov	x0, 62528
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2864]
	mov	x0, 1088
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2880]
	mov	x0, 1088
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2896]
	mov	x0, 5184
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2912]
	mov	x0, 5184
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2928]
	mov	x0, 9280
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2944]
	mov	x0, 9280
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2960]
	mov	x0, 13376
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2976]
	mov	x0, 13376
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2992]
	mov	x0, 17472
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3000]
	sub	x0, x0, #2056
	str	w4, [x29, 3016]
	str	w4, [x29, 3032]
	str	x0, [x29, 3008]
	mov	x0, 17472
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3048]
	sub	x0, x0, #8
	str	w4, [x29, 3064]
	str	w4, [x29, 3080]
	str	x0, [x29, 3024]
	mov	x0, 21568
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3096]
	sub	x0, x0, #2056
	str	w4, [x29, 3112]
	str	w4, [x29, 3128]
	str	x0, [x29, 3040]
	mov	x0, 21568
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3144]
	sub	x0, x0, #8
	str	w4, [x29, 3160]
	str	w4, [x29, 3176]
	str	x0, [x29, 3056]
	mov	x0, 25664
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3192]
	sub	x0, x0, #2056
	str	w4, [x29, 3208]
	str	w4, [x29, 3224]
	str	x0, [x29, 3072]
	mov	x0, 25664
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3240]
	sub	x0, x0, #8
	str	w4, [x29, 3256]
	str	x0, [x29, 3088]
	mov	x0, 29760
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 3104]
	mov	x0, 29760
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 3120]
	mov	x0, 33856
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 3136]
	mov	x0, 33856
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 3152]
	mov	x0, 37952
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 3168]
	mov	x0, 37952
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 3184]
	mov	x0, 42048
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 3200]
	mov	x0, 42048
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 3216]
	mov	x0, 46144
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 3232]
	mov	x0, 46144
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 3248]
	mov	x0, 50240
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 3264]
	mov	x0, 50240
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3272]
	sub	x0, x0, #8
	str	w4, [x29, 3288]
	str	w4, [x29, 3304]
	str	x0, [x29, 3280]
	mov	x0, 54336
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3320]
	sub	x0, x0, #2056
	str	w4, [x29, 3336]
	str	w4, [x29, 3352]
	str	x0, [x29, 3296]
	mov	x0, 54336
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3368]
	sub	x0, x0, #8
	str	w4, [x29, 3384]
	str	w4, [x29, 3400]
	str	x0, [x29, 3312]
	mov	x0, 58432
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3416]
	sub	x0, x0, #2056
	str	w4, [x29, 3432]
	str	w4, [x29, 3448]
	str	x0, [x29, 3328]
	mov	x0, 58432
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3464]
	sub	x0, x0, #8
	str	w4, [x29, 3480]
	str	w4, [x29, 3496]
	str	x0, [x29, 3344]
	mov	x0, 62528
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3512]
	sub	x0, x0, #2056
	str	x0, [x29, 3360]
	mov	x0, 62528
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 3376]
	mov	x0, 1088
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 3392]
	mov	x0, 1088
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 3408]
	mov	x0, 5184
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 3424]
	mov	x0, 5184
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 3440]
	mov	x0, 9280
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 3456]
	mov	x0, 9280
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 3472]
	mov	x0, 13376
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 3488]
	mov	x0, 13376
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 3504]
	mov	x0, 17472
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 3520]
	mov	x0, 42048
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3528]
	sub	x0, x0, #8
	str	w4, [x29, 3544]
	str	w4, [x29, 3560]
	str	x0, [x29, 3728]
	mov	x0, 42048
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3576]
	sub	x0, x0, #2056
	str	w4, [x29, 3592]
	str	w4, [x29, 3608]
	str	x0, [x29, 3712]
	mov	x0, 37952
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3624]
	sub	x0, x0, #8
	str	w4, [x29, 3640]
	str	w4, [x29, 3656]
	str	x0, [x29, 3696]
	mov	x0, 37952
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3672]
	sub	x0, x0, #2056
	str	w4, [x29, 3688]
	str	w4, [x29, 3704]
	str	x0, [x29, 3680]
	mov	x0, 33856
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3720]
	sub	x0, x0, #8
	str	w4, [x29, 3736]
	str	w4, [x29, 3752]
	str	x0, [x29, 3664]
	mov	x0, 33856
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3768]
	sub	x0, x0, #2056
	str	w4, [x29, 3784]
	str	x0, [x29, 3648]
	mov	x0, 29760
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 3632]
	mov	x0, 29760
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 3616]
	mov	x0, 25664
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 3600]
	mov	x0, 25664
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 3584]
	mov	x0, 21568
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 3568]
	mov	x0, 21568
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 3552]
	mov	x0, 17472
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 3536]
	mov	x0, 46144
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 3744]
	mov	x0, 46144
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 3760]
	mov	x0, 50240
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 3776]
	mov	x0, 50240
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 3792]
	mov	x0, 54336
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3800]
	sub	x0, x0, #2056
	str	w4, [x29, 3816]
	str	w4, [x29, 3832]
	str	x0, [x29, 3808]
	mov	x0, 54336
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3848]
	sub	x0, x0, #8
	str	w4, [x29, 3864]
	str	w4, [x29, 3880]
	str	x0, [x29, 3824]
	mov	x0, 58432
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3896]
	sub	x0, x0, #2056
	str	w4, [x29, 3912]
	str	w4, [x29, 3928]
	str	x0, [x29, 3840]
	mov	x0, 58432
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3944]
	sub	x0, x0, #8
	str	w4, [x29, 3960]
	str	w4, [x29, 3976]
	str	x0, [x29, 3856]
	mov	x0, 62528
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3992]
	sub	x0, x0, #2056
	str	w4, [x29, 4008]
	str	w4, [x29, 4024]
	str	x0, [x29, 3872]
	mov	x0, 62528
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 4040]
	sub	x0, x0, #8
	str	x0, [x29, 3888]
	mov	x0, 1088
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 3904]
	mov	x0, 1088
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 3920]
	mov	x0, 5184
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 3936]
	mov	x0, 5184
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 3952]
	mov	x0, 9280
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 3968]
	mov	x0, 9280
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 3984]
	mov	x0, 13376
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 4000]
	mov	x0, 13376
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 4016]
	mov	x0, 17472
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 4032]
	mov	x0, 17472
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 4048]
	mov	x0, 21568
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 4056]
	sub	x0, x0, #2056
	str	w4, [x29, 4072]
	str	w4, [x29, 4088]
	str	x0, [x29, 4064]
	mov	x0, 21568
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 4104]
	sub	x0, x0, #8
	str	w4, [x29, 4120]
	str	w4, [x29, 4136]
	str	x0, [x29, 4080]
	mov	x0, 25664
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 4152]
	sub	x0, x0, #2056
	str	w4, [x29, 4168]
	str	w4, [x29, 4184]
	str	x0, [x29, 4096]
	mov	x0, 25664
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 4200]
	sub	x0, x0, #8
	str	w4, [x29, 4216]
	str	w4, [x29, 4232]
	str	x0, [x29, 4112]
	mov	x0, 29760
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 4248]
	sub	x0, x0, #2056
	str	w4, [x29, 4264]
	str	w4, [x29, 4280]
	str	x0, [x29, 4128]
	mov	x0, 29760
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 4296]
	sub	x0, x0, #8
	str	w4, [x29, 4312]
	str	x0, [x29, 4144]
	mov	x0, 33856
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 4160]
	mov	x0, 33856
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 4176]
	mov	x0, 37952
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 4192]
	mov	x0, 37952
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 4208]
	mov	x0, 42048
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 4224]
	mov	x0, 42048
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 4240]
	mov	x0, 46144
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 4256]
	mov	x0, 46144
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 4272]
	mov	x0, 50240
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 4288]
	mov	x0, 50240
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 4304]
	mov	x0, 54336
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 4320]
	mov	x0, 54336
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 4328]
	sub	x0, x0, #8
	str	w4, [x29, 4344]
	str	w4, [x29, 4360]
	str	x0, [x29, 4336]
	mov	x0, 58432
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 4376]
	sub	x0, x0, #2056
	str	w4, [x29, 4392]
	str	w4, [x29, 4408]
	str	x0, [x29, 4352]
	mov	x0, 58432
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 4424]
	sub	x0, x0, #8
	str	w4, [x29, 4440]
	str	w4, [x29, 4456]
	str	x0, [x29, 4368]
	mov	x0, 62528
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 4472]
	sub	x0, x0, #2056
	str	w4, [x29, 4488]
	str	w4, [x29, 4504]
	str	x0, [x29, 4384]
	mov	x0, 62528
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 4520]
	sub	x0, x0, #8
	str	w4, [x29, 4536]
	str	w4, [x29, 4552]
	str	x0, [x29, 4400]
	mov	x0, 1088
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 4568]
	sub	x0, x0, #2056
	str	x0, [x29, 4416]
	mov	x0, 1088
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 4432]
	mov	x0, 5184
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 4448]
	mov	x0, 5184
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 4464]
	mov	x0, 9280
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 4480]
	mov	x0, 9280
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 4496]
	mov	x0, 13376
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 4512]
	mov	x0, 13376
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 4528]
	mov	x0, 17472
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 4544]
	mov	x0, 17472
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 4560]
	mov	x0, 21568
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 4576]
	mov	x0, 21568
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 4584]
	sub	x0, x0, #8
	str	w4, [x29, 4600]
	str	w4, [x29, 4616]
	str	x0, [x29, 4592]
	mov	x0, 25664
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 4632]
	sub	x0, x0, #2056
	str	w4, [x29, 4648]
	str	w4, [x29, 4664]
	str	x0, [x29, 4608]
	mov	x0, 25664
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 4680]
	sub	x0, x0, #8
	str	w4, [x29, 4696]
	str	w4, [x29, 4712]
	str	x0, [x29, 4624]
	mov	x0, 29760
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 4728]
	sub	x0, x0, #2056
	str	w4, [x29, 4744]
	str	w4, [x29, 4760]
	str	x0, [x29, 4640]
	mov	x0, 29760
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 4776]
	sub	x0, x0, #8
	str	w4, [x29, 4792]
	str	w4, [x29, 4808]
	str	x0, [x29, 4656]
	mov	x0, 33856
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 4824]
	sub	x0, x0, #2056
	str	w4, [x29, 4840]
	str	x0, [x29, 4672]
	mov	x0, 33856
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 4688]
	mov	x0, 37952
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 4704]
	mov	x0, 37952
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 4720]
	mov	x0, 42048
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 4736]
	mov	x0, 42048
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 4752]
	mov	x0, 46144
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 4768]
	mov	x0, 46144
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 4784]
	mov	x0, 50240
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 4800]
	mov	x0, 50240
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 4816]
	mov	x0, 54336
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 4832]
	mov	x0, 54336
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 4848]
	mov	x0, 58432
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 4856]
	sub	x0, x0, #2056
	str	w4, [x29, 4872]
	str	w4, [x29, 4888]
	str	x0, [x29, 4864]
	mov	x0, 58432
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 4904]
	sub	x0, x0, #8
	str	w4, [x29, 4920]
	str	w4, [x29, 4936]
	str	x0, [x29, 4880]
	mov	x0, 62528
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 4952]
	sub	x0, x0, #2056
	str	w4, [x29, 4968]
	str	w4, [x29, 4984]
	str	x0, [x29, 4896]
	mov	x0, 62528
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 5000]
	sub	x0, x0, #8
	str	w4, [x29, 5016]
	str	w4, [x29, 5032]
	str	x0, [x29, 4912]
	mov	x0, 1088
	movk	x0, 0x9, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 5048]
	sub	x0, x0, #2056
	str	w4, [x29, 5064]
	str	w4, [x29, 5080]
	str	x0, [x29, 4928]
	mov	x0, 1088
	movk	x0, 0x9, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 5096]
	sub	x0, x0, #8
	str	x0, [x29, 4944]
	mov	x0, 5184
	movk	x0, 0x9, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 4960]
	mov	x0, 5184
	movk	x0, 0x9, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 4976]
	mov	x0, 9280
	movk	x0, 0x9, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 4992]
	mov	x0, 9280
	movk	x0, 0x9, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 5008]
	mov	x0, 13376
	movk	x0, 0x9, lsl 16
	add	x0, x0, x1
	sub	x1, x0, #2056
	mov	x0, 13376
	movk	x0, 0x9, lsl 16
	add	x0, x0, x2
	str	x1, [x29, 5024]
	mov	x1, 17472
	movk	x1, 0x9, lsl 16
	sub	x0, x0, #8
	add	x1, x1, x2
	sub	x2, x1, #2056
	mov	x1, 17472
	movk	x1, 0x9, lsl 16
	str	x0, [x29, 5040]
	mov	x0, 21568
	movk	x0, 0x9, lsl 16
	add	x0, x0, x3
	str	x2, [x29, 5056]
	add	x1, x1, x3
	sub	x2, x0, #2056
	mov	x0, 21568
	movk	x0, 0x9, lsl 16
	add	x0, x0, x3
	mov	x3, 25664
	movk	x3, 0x9, lsl 16
	sub	x1, x1, #8
	sub	x0, x0, #8
	str	x2, [x29, 5088]
	add	x3, x3, x5
	mov	x5, 25664
	movk	x5, 0x9, lsl 16
	add	x5, x5, x6
	sub	x3, x3, #2056
	str	x1, [x29, 5072]
	sub	x5, x5, #8
	str	x0, [x29, 5104]
	adrp	x1, .LC4
	add	x1, x1, :lo12:.LC4
	str	w4, [x29, 5112]
	adrp	x2, .LC3
	add	x2, x2, :lo12:.LC3
	str	x3, [x29, 5120]
	mov	w0, 1
	mov	w3, 24576
	movk	w3, 0x9, lsl 16
	str	x5, [x29, 5136]
	str	x19, [x29, 5152]
	add	x19, x29, 376
	str	w4, [x29, 5128]
	str	w4, [x29, 5144]
	str	w4, [x29, 5160]
	bl	__printf_chk
	mov	w2, 10000
	mov	x1, 0
	add	x0, x29, 152
	str	w2, [x29, 124]
	bl	gettimeofday
	ldp	x0, x1, [x29, 152]
	ldr	d8, .LC5
	scvtf	d0, x0
	scvtf	d1, x1
	add	x0, x29, 1104
	sub	x24, x0, #936
	adrp	x1, start_clk
	fmadd	d0, d0, d8, d1
	fcvtzu	x0, d0
	str	x0, [x1, #:lo12:start_clk]
.L388:
	sub	x0, sp, #4096
	movi	v0.4s, 0
	mov	x21, sp
	sub	sp, x0, #720
	add	x0, x29, 1104
	add	x1, x0, 4008
	mov	x28, sp
	mov	x0, x19
.L370:
	ld4	{v4.4s - v7.4s}, [x0], 64
	cmp	x0, x1
	smax	v0.4s, v0.4s, v4.4s
	bne	.L370
	smaxv	s0, v0.4s
	ldr	w0, [x29, 5144]
	ldr	w3, [x29, 5160]
	ldr	w2, [x29, 5112]
	umov	w22, v0.s[0]
	ldr	w1, [x29, 5128]
	cmp	w0, w3
	csel	w0, w0, w3, ge
	cmp	w1, w2
	csel	w1, w1, w2, ge
	cmp	w0, w1
	csel	w0, w0, w1, ge
	cmp	w22, w0
	csel	w22, w22, w0, ge
	cmp	w22, wzr
	ble	.L371
	add	x0, x29, 1104
	mov	w26, 1
	add	x20, x0, 4072
	mov	w27, 9
.L374:
	add	x0, x29, 200
	mov	x2, x19
	str	xzr, [x29, 232]
	stp	xzr, xzr, [x0]
	add	x0, x29, 216
	stp	xzr, xzr, [x0]
	.p2align 2
.L372:
	ldr	w0, [x2], 16
	sdiv	w0, w0, w26
	cmp	x2, x20
	smull	x1, w0, w23
	asr	x1, x1, 34
	sub	w1, w1, w0, asr 31
	lsl	w3, w1, 3
	add	w1, w3, w1, lsl 1
	add	x3, x29, 16
	sub	w0, w0, w1
	mov	x1, 29760
	movk	x1, 0x9, lsl 16
	add	x1, x1, x3
	sub	w0, w27, w0
	add	x0, x1, x0, sxtw 2
	sub	x0, x0, #622592
	ldr	w1, [x0, 3192]
	add	w1, w1, 1
	str	w1, [x0, 3192]
	bne	.L372
	ldp	w8, w10, [x29, 200]
	add	x4, x29, 1104
	add	x4, x4, 4056
	ldp	w7, w6, [x29, 208]
	ldp	w5, w3, [x29, 216]
	add	w8, w10, w8
	ldp	w2, w1, [x29, 224]
	add	w7, w8, w7
	ldp	w0, w9, [x29, 232]
	add	w6, w7, w6
	add	w5, w6, w5
	stp	w8, w7, [x29, 204]
	add	w3, w5, w3
	add	w2, w3, w2
	stp	w6, w5, [x29, 212]
	add	w1, w2, w1
	add	w0, w1, w0
	stp	w3, w2, [x29, 220]
	add	w2, w9, w0
	stp	w1, w0, [x29, 228]
	str	w2, [x29, 236]
	.p2align 2
.L373:
	mov	x1, x4
	sub	x4, x4, #16
	ldr	w0, [x1], -8
	cmp	x25, x4
	sdiv	w0, w0, w26
	ldp	x2, x3, [x1]
	smull	x1, w0, w23
	asr	x1, x1, 34
	sub	w1, w1, w0, asr 31
	lsl	w5, w1, 3
	add	w1, w5, w1, lsl 1
	add	x5, x29, 16
	sub	w0, w0, w1
	mov	x1, 29760
	movk	x1, 0x9, lsl 16
	add	x1, x1, x5
	sub	w0, w27, w0
	add	x0, x1, x0, sxtw 2
	sub	x0, x0, #622592
	ldr	w1, [x0, 3192]
	sub	w1, w1, #1
	add	x5, x28, x1, sxtw 4
	stp	x2, x3, [x5]
	str	w1, [x0, 3192]
	bne	.L373
	mov	x2, 4800
	mov	x1, x28
	add	x0, x29, 368
	bl	memcpy
	lsl	w0, w26, 3
	add	w26, w0, w26, lsl 1
	sdiv	w0, w22, w26
	cmp	w0, wzr
	bgt	.L374
.L371:
	ldr	q19, .LC6
	mov	sp, x21
	add	x0, x29, 1104
	sub	sp, sp, #112
	add	x12, x29, 368
	ldr	q20, [x29, 5168]
	mov	x2, sp
	sub	sp, sp, #112
	mov	w26, 300
	mov	w27, 6
	ldr	q18, .LC7
	mov	w28, 1
	mov	x18, -16
	mov	x1, sp
	sub	x17, x0, #920
	ldr	q17, .LC8
	ldr	q16, .LC9
	ldr	q7, .LC10
	ldr	q6, .LC11
	ldr	q5, .LC12
	ldr	q4, .LC13
	ldr	q3, .LC14
	ldr	q2, .LC15
	ldr	q1, .LC16
.L387:
	cmp	w26, 6
	csel	w20, w26, w27, le
	cmp	w20, 1
	beq	.L392
	mov	w4, w20
	mov	x6, 0
	mov	w8, 0
	.p2align 2
.L379:
	add	x3, x18, x4, sxtw 4
	add	x3, x12, x3
	sub	w0, w4, #2
	ldr	w3, [x3, 8]
	add	x5, x12, x0, sxtw 4
	ldr	w7, [x5, 8]
	cmp	w3, w7
	bne	.L376
	sub	w0, w4, #3
	cmn	w0, #1
	beq	.L377
	ldr	w7, [x5, -8]
	cmp	w7, w3
	bne	.L376
	sub	w0, w4, #4
	cmn	w0, #1
	beq	.L377
	ldr	w7, [x5, -24]
	cmp	w7, w3
	bne	.L376
	sub	w0, w4, #5
	cmn	w0, #1
	beq	.L377
	ldr	w7, [x5, -40]
	cmp	w7, w3
	bne	.L378
	cmp	w4, 6
	bne	.L377
	ldr	w0, [x5, -56]
	cmp	w3, w0
	bne	.L738
.L377:
	uxth	w5, w3
	add	w16, w6, 1
	strh	w4, [x24, x6, lsl 1]
	sub	w5, w5, w8
	strh	w5, [x17, x6, lsl 1]
.L380:
	str	q20, [x1]
	cmp	w20, 1
	beq	.L381
	str	q20, [x1, 16]
	cmp	w20, 2
	beq	.L381
	str	q20, [x1, 32]
	cmp	w20, 3
	beq	.L381
	str	q20, [x1, 48]
	cmp	w20, 4
	beq	.L381
	str	q20, [x1, 64]
	cmp	w20, 6
	bne	.L381
	str	q20, [x1, 80]
.L381:
	mov	x13, 0
	mov	w15, 0
	cbz	w16, .L383
	.p2align 2
.L412:
	ldrh	w14, [x17, x13, lsl 1]
	cbz	w14, .L386
	ldr	q30, [x1]
	lsl	w11, w15, 4
	sub	w10, w14, #1
	add	x10, x10, 1
	sxtw	x11, w11
	mov	x3, 0
	ldr	q28, [x1, 16]
	lsl	x10, x10, 4
	ldr	q26, [x1, 32]
	ldr	q24, [x1, 48]
	ldr	q22, [x1, 64]
	ldr	q0, [x1, 80]
	ldr	x9, [x12]
	ldr	x8, [x12, 16]
	ldr	x7, [x12, 32]
	ldr	x6, [x12, 48]
	ldr	x5, [x12, 64]
	ldr	x4, [x12, 80]
	.p2align 2
.L386:
	add	x13, x13, 1
	add	w15, w15, w14
	cmp	w16, w13
	bgt	.L412
.L383:
	sub	w26, w26, w20
	add	x12, x12, x20, sxtw 4
	cmp	w26, wzr
	bgt	.L387
	ldr	w0, [x29, 124]
	subs	w0, w0, #1
	str	w0, [x29, 124]
	mov	sp, x21
	bne	.L388
	mov	x1, 0
	add	x0, x29, 152
	bl	gettimeofday
	ldp	x3, x4, [x29, 152]
	adrp	x0, start_clk
	adrp	x6, end_clk
	adrp	x5, total_clk
	adrp	x1, .LC20
	ldr	x2, [x0, #:lo12:start_clk]
	add	x1, x1, :lo12:.LC20
	mov	w0, 1
	mov	w19, 0
	ldr	d1, .LC17
	scvtf	d2, x3
	scvtf	d3, x4
	ldr	d4, .LC18
	ldr	d0, .LC19
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
	add	x0, x29, 1104
	add	x4, x29, 368
	add	x0, x0, 4064
.L389:
	ldr	x3, [x4]
	add	x4, x4, 16
	ldr	w2, [x4, -8]
	cmp	x0, x4
	ldrb	w1, [x3]
	lsl	w2, w2, 4
	add	x2, x3, x2, sxtw
	ldrb	w2, [x2, -1]
	eor	w1, w2, w1
	uxtb	w1, w1
	eor	w19, w19, w1
	bne	.L389
	adrp	x1, .LC21
	mov	w2, w19
	add	x1, x1, :lo12:.LC21
	mov	w0, 1
	bl	__printf_chk
	add	x3, x29, 16
	mov	x2, 29752
	movk	x2, 0x9, lsl 16
	adrp	x1, __stack_chk_guard
	add	x1, x1, :lo12:__stack_chk_guard
	add	x2, x2, x3
	mov	w0, w19
	ldr	x3, [x2]
	ldr	x1, [x1]
	eor	x1, x3, x1
	cbnz	x1, .L739
	add	sp, x29, 0
	ldr	d8, [sp, 96]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	ldp	x29, x30, [sp], 112
	add	sp, sp, 618496
	add	sp, sp, 992
	ret
	.p2align 3
.L376:
	uxth	w5, w3
	strh	w4, [x24, x6, lsl 1]
	cmp	w0, 1
	add	w16, w6, 1
	sub	w4, w5, w8
	mov	w8, w3
	strh	w4, [x17, x6, lsl 1]
	add	x6, x6, 1
	ble	.L390
	mov	w4, w0
	b	.L379
.L738:
	mov	w0, 0
.L378:
	uxth	w5, w3
	add	w16, w6, 1
	strh	w4, [x24, x6, lsl 1]
	sub	w8, w5, w8
	strh	w8, [x17, x6, lsl 1]
.L390:
	cmp	w0, 1
	bne	.L380
	ldr	w3, [x12, 8]
	sub	x0, x29, #2992
	add	x0, x0, x16, sxtw 1
	add	w16, w16, 1
	strh	w28, [x0, 3160]
	sub	w5, w3, w5
	strh	w5, [x0, 3176]
	b	.L380
.L392:
	ldr	w3, [x12, 8]
	mov	w5, 0
	mov	w16, 0
	sub	x0, x29, #2992
	add	x0, x0, x16, sxtw 1
	add	w16, w16, 1
	strh	w28, [x0, 3160]
	sub	w5, w3, w5
	strh	w5, [x0, 3176]
	b	.L380
.L739:
	bl	__stack_chk_fail
	.size	main, .-main
	.align	4
.LC2:
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
.LC5:
	.word	0
	.word	1093567616
	.align	4
.LC6:
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
.LC7:
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
.LC8:
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
.LC9:
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
.LC10:
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
.LC11:
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
.LC12:
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
.LC13:
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
.LC14:
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
.LC15:
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
.LC16:
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
.LC17:
	.word	0
	.word	1084254208
	.align	3
.LC18:
	.word	0
	.word	1086556160
	.align	3
.LC19:
	.word	0
	.word	1092796416
	.comm	total_clk,8,8
	.comm	end_clk,8,8
	.comm	start_clk,8,8
	.section	.rodata.str1.8,"aMS",%progbits,1
	.align	3
.LC1:
	.string	"setaffinity"
	.zero	4
.LC3:
	.string	"AES-CBC-COMP-P6"
.LC4:
	.string	"%s-%d: "
.LC20:
	.string	"%g cpb\n"
.LC21:
	.string	"\n\nterminated with code %d\n"
	.ident	"GCC: (Ubuntu 5.2.1-22ubuntu1) 5.2.1 20151010"
	.section	.note.GNU-stack,"",%progbits
