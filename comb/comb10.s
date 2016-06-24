	.cpu cortex-a57+fp+simd+crypto+crc
	.file	"comb10.c"
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
	stp	x29, x30, [sp, -80]!
	add	x29, sp, 0
	stp	x19, x20, [sp, 16]
	mov	w20, w1
	mov	x19, x0
	stp	x21, x22, [sp, 32]
	mov	x21, x4
	mov	w22, w2
	str	x23, [sp, 48]
	mov	x23, x3
	stp	d8, d9, [sp, 56]
	bl	radixSortDescending
	sxtw	x0, w22
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
	mov	x12, sp
	sub	sp, sp, x0
	ble	.L36
	mov	x14, -16
	mov	x13, 8
	mov	x11, sp
.L59:
	cmp	w22, w20
	csel	w15, w22, w20, le
	cmp	w15, 1
	ble	.L54
	mov	w8, w15
	mov	x9, 0
	mov	w10, 0
	.p2align 2
.L42:
	add	x6, x14, x8, sxtw 4
	add	x6, x19, x6
	sub	w5, w8, #2
	ldr	w7, [x6, 8]
	add	x0, x13, x5, sxtw 4
	mov	w16, w9
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
	sbfiz	x0, x16, 1, 32
	sub	w7, w7, w10
	add	w16, w16, 1
	strh	w8, [x12, x0]
	strh	w7, [x11, x0]
.L44:
	sub	w5, w15, #1
	mov	x0, x1
	add	x5, x5, 1
	add	x5, x1, x5, lsl 4
	.p2align 2
.L47:
	str	q3, [x0], 16
	cmp	x5, x0
	bne	.L47
.L48:
	cmp	w16, wzr
	mov	x17, 0
	mov	w30, 0
	ble	.L46
	.p2align 2
.L60:
	ldrh	w18, [x11, x17, lsl 1]
	cbz	w18, .L51
	lsl	w0, w30, 4
	sub	w10, w18, #1
	ldr	q29, [x1]
	sxtw	x0, w0
	ldr	q27, [x1, 16]
	add	x5, x0, 16
	add	x10, x5, x10, uxtw 4
	ldr	q26, [x1, 32]
	ldr	q0, [x1, 48]
	ldr	q31, [x1, 64]
	ldr	q30, [x1, 80]
	ldr	q6, [x1, 96]
	ldr	q18, [x1, 112]
	ldr	q1, [x1, 128]
	b	.L49
	.p2align 3
.L67:
	add	x5, x5, 16
.L49:
	ldr	x2, [x19, 16]
	cmp	x10, x5
	ldr	x8, [x19, 112]
	ldr	x6, [x19]
	ldr	q8, [x2, x0]
	ldr	x2, [x19, 32]
	ldr	x9, [x19, 96]
	ldr	x7, [x19, 128]
	eor	v27.16b, v8.16b, v27.16b
	ldr	q4, [x2, x0]
	ldr	x2, [x19, 48]
	ldr	q5, [x8, x0]
	ldr	q28, [x23]
	eor	v26.16b, v4.16b, v26.16b
	ldr	q25, [x2, x0]
	ldr	x2, [x19, 64]
	eor	v18.16b, v5.16b, v18.16b
	ldr	q7, [x9, x0]
	aese	v27.16b, v28.16b
	aese	v26.16b, v28.16b
	ldr	q2, [x7, x0]
	eor	v25.16b, v25.16b, v0.16b
	ldr	q24, [x2, x0]
	aesmc	v27.16b, v27.16b
	aesmc	v26.16b, v26.16b
	ldr	x2, [x19, 80]
	eor	v0.16b, v7.16b, v6.16b
	aese	v25.16b, v28.16b
	ldr	q9, [x6, x0]
	eor	v1.16b, v2.16b, v1.16b
	orr	v2.16b, v18.16b, v18.16b
	eor	v24.16b, v24.16b, v31.16b
	ldr	q23, [x23, 16]
	aese	v0.16b, v28.16b
	aesmc	v25.16b, v25.16b
	ldr	q22, [x2, x0]
	aese	v2.16b, v28.16b
	aese	v1.16b, v28.16b
	eor	v29.16b, v9.16b, v29.16b
	aese	v24.16b, v28.16b
	ldr	q21, [x23, 32]
	aesmc	v0.16b, v0.16b
	aesmc	v2.16b, v2.16b
	ldr	q20, [x23, 48]
	aesmc	v1.16b, v1.16b
	eor	v22.16b, v22.16b, v30.16b
	aese	v29.16b, v28.16b
	ldr	q19, [x23, 64]
	aesmc	v24.16b, v24.16b
	aese	v25.16b, v23.16b
	ldr	q17, [x23, 80]
	aese	v27.16b, v23.16b
	aese	v22.16b, v28.16b
	ldr	q16, [x23, 96]
	aesmc	v29.16b, v29.16b
	aese	v2.16b, v23.16b
	ldr	q7, [x23, 112]
	aese	v1.16b, v23.16b
	aesmc	v18.16b, v22.16b
	orr	v22.16b, v24.16b, v24.16b
	ldr	q6, [x23, 128]
	aese	v29.16b, v23.16b
	aese	v26.16b, v23.16b
	ldr	q5, [x23, 144]
	aese	v0.16b, v23.16b
	aese	v22.16b, v23.16b
	ldr	q4, [x23, 160]
	aese	v18.16b, v23.16b
	aesmc	v23.16b, v25.16b
	aesmc	v29.16b, v29.16b
	aesmc	v22.16b, v22.16b
	aesmc	v27.16b, v27.16b
	aese	v23.16b, v21.16b
	aesmc	v2.16b, v2.16b
	aese	v22.16b, v21.16b
	aesmc	v1.16b, v1.16b
	aesmc	v26.16b, v26.16b
	aesmc	v0.16b, v0.16b
	aesmc	v18.16b, v18.16b
	aesmc	v23.16b, v23.16b
	aese	v29.16b, v21.16b
	aese	v27.16b, v21.16b
	aese	v2.16b, v21.16b
	aese	v1.16b, v21.16b
	aese	v26.16b, v21.16b
	aese	v0.16b, v21.16b
	aese	v18.16b, v21.16b
	aesmc	v21.16b, v22.16b
	orr	v22.16b, v23.16b, v23.16b
	aesmc	v29.16b, v29.16b
	aesmc	v27.16b, v27.16b
	aesmc	v18.16b, v18.16b
	aese	v22.16b, v20.16b
	aese	v21.16b, v20.16b
	aesmc	v2.16b, v2.16b
	aese	v18.16b, v20.16b
	aesmc	v1.16b, v1.16b
	aesmc	v26.16b, v26.16b
	aesmc	v0.16b, v0.16b
	aesmc	v22.16b, v22.16b
	aese	v29.16b, v20.16b
	aese	v27.16b, v20.16b
	aese	v2.16b, v20.16b
	aese	v1.16b, v20.16b
	aese	v26.16b, v20.16b
	aese	v0.16b, v20.16b
	aesmc	v18.16b, v18.16b
	aesmc	v20.16b, v21.16b
	orr	v21.16b, v22.16b, v22.16b
	aesmc	v29.16b, v29.16b
	aesmc	v27.16b, v27.16b
	aese	v18.16b, v19.16b
	aese	v21.16b, v19.16b
	aesmc	v2.16b, v2.16b
	aesmc	v1.16b, v1.16b
	aesmc	v26.16b, v26.16b
	aesmc	v0.16b, v0.16b
	aese	v29.16b, v19.16b
	aese	v27.16b, v19.16b
	aese	v2.16b, v19.16b
	aese	v1.16b, v19.16b
	aese	v26.16b, v19.16b
	aese	v0.16b, v19.16b
	aese	v20.16b, v19.16b
	aesmc	v21.16b, v21.16b
	aesmc	v18.16b, v18.16b
	aesmc	v29.16b, v29.16b
	aesmc	v19.16b, v20.16b
	aesmc	v27.16b, v27.16b
	orr	v20.16b, v21.16b, v21.16b
	aese	v18.16b, v17.16b
	aesmc	v2.16b, v2.16b
	aesmc	v1.16b, v1.16b
	aesmc	v26.16b, v26.16b
	aesmc	v0.16b, v0.16b
	aese	v29.16b, v17.16b
	aese	v27.16b, v17.16b
	aese	v2.16b, v17.16b
	aese	v1.16b, v17.16b
	aese	v26.16b, v17.16b
	aese	v0.16b, v17.16b
	aese	v20.16b, v17.16b
	aese	v19.16b, v17.16b
	aesmc	v18.16b, v18.16b
	aesmc	v29.16b, v29.16b
	aesmc	v27.16b, v27.16b
	aesmc	v2.16b, v2.16b
	aese	v18.16b, v17.16b
	aesmc	v1.16b, v1.16b
	aesmc	v26.16b, v26.16b
	aesmc	v0.16b, v0.16b
	aesmc	v20.16b, v20.16b
	aesmc	v19.16b, v19.16b
	aese	v29.16b, v17.16b
	aese	v27.16b, v17.16b
	aese	v2.16b, v17.16b
	aese	v1.16b, v17.16b
	aese	v26.16b, v17.16b
	aese	v0.16b, v17.16b
	aese	v20.16b, v17.16b
	aese	v19.16b, v17.16b
	aesmc	v17.16b, v18.16b
	aesmc	v0.16b, v0.16b
	aesmc	v20.16b, v20.16b
	aesmc	v19.16b, v19.16b
	aese	v17.16b, v16.16b
	aesmc	v29.16b, v29.16b
	aesmc	v27.16b, v27.16b
	aesmc	v26.16b, v26.16b
	orr	v18.16b, v19.16b, v19.16b
	aese	v0.16b, v16.16b
	aese	v20.16b, v16.16b
	aesmc	v2.16b, v2.16b
	aesmc	v1.16b, v1.16b
	aesmc	v17.16b, v17.16b
	aese	v29.16b, v16.16b
	aese	v27.16b, v16.16b
	aese	v26.16b, v16.16b
	aese	v2.16b, v16.16b
	aese	v1.16b, v16.16b
	aese	v18.16b, v16.16b
	aese	v17.16b, v7.16b
	aesmc	v16.16b, v0.16b
	aesmc	v19.16b, v20.16b
	aesmc	v29.16b, v29.16b
	aesmc	v27.16b, v27.16b
	aesmc	v26.16b, v26.16b
	aese	v16.16b, v7.16b
	orr	v0.16b, v19.16b, v19.16b
	aesmc	v17.16b, v17.16b
	aesmc	v2.16b, v2.16b
	aesmc	v1.16b, v1.16b
	aesmc	v18.16b, v18.16b
	aese	v29.16b, v7.16b
	aese	v27.16b, v7.16b
	aese	v26.16b, v7.16b
	aese	v2.16b, v7.16b
	aese	v1.16b, v7.16b
	aese	v0.16b, v7.16b
	aese	v18.16b, v7.16b
	aesmc	v7.16b, v16.16b
	orr	v16.16b, v17.16b, v17.16b
	aesmc	v29.16b, v29.16b
	aesmc	v27.16b, v27.16b
	aesmc	v26.16b, v26.16b
	aese	v16.16b, v6.16b
	aesmc	v2.16b, v2.16b
	aesmc	v1.16b, v1.16b
	aesmc	v0.16b, v0.16b
	aesmc	v18.16b, v18.16b
	aese	v29.16b, v6.16b
	aese	v27.16b, v6.16b
	aese	v26.16b, v6.16b
	aese	v18.16b, v6.16b
	aese	v2.16b, v6.16b
	aese	v1.16b, v6.16b
	aese	v0.16b, v6.16b
	aese	v7.16b, v6.16b
	aesmc	v16.16b, v16.16b
	aesmc	v29.16b, v29.16b
	aesmc	v27.16b, v27.16b
	aesmc	v26.16b, v26.16b
	aesmc	v17.16b, v18.16b
	aesmc	v6.16b, v7.16b
	orr	v7.16b, v16.16b, v16.16b
	aesmc	v2.16b, v2.16b
	aesmc	v1.16b, v1.16b
	aesmc	v0.16b, v0.16b
	aese	v29.16b, v5.16b
	aese	v27.16b, v5.16b
	aese	v26.16b, v5.16b
	aese	v2.16b, v5.16b
	aese	v1.16b, v5.16b
	eor	v29.16b, v29.16b, v4.16b
	aese	v0.16b, v5.16b
	eor	v27.16b, v27.16b, v4.16b
	aese	v17.16b, v5.16b
	eor	v26.16b, v26.16b, v4.16b
	aese	v7.16b, v5.16b
	eor	v18.16b, v2.16b, v4.16b
	aese	v6.16b, v5.16b
	eor	v1.16b, v4.16b, v1.16b
	str	q29, [x4]
	eor	v0.16b, v0.16b, v4.16b
	str	q27, [x4, 16]
	eor	v31.16b, v17.16b, v4.16b
	str	q26, [x4, 32]
	eor	v30.16b, v7.16b, v4.16b
	eor	v6.16b, v6.16b, v4.16b
	str	q0, [x4, 48]
	str	q31, [x4, 64]
	str	q30, [x4, 80]
	str	q6, [x4, 96]
	str	q18, [x4, 112]
	str	q1, [x4, 128]
	str	q29, [x1]
	str	q27, [x1, 16]
	str	q26, [x1, 32]
	str	q0, [x1, 48]
	str	q31, [x1, 64]
	str	q30, [x1, 80]
	str	q6, [x1, 96]
	str	q18, [x1, 112]
	str	q1, [x1, 128]
	str	q29, [x6, x0]
	ldr	x6, [x19, 16]
	str	q27, [x6, x0]
	ldr	x6, [x19, 32]
	str	q26, [x6, x0]
	ldr	x6, [x19, 48]
	str	q0, [x6, x0]
	ldr	x6, [x19, 64]
	str	q31, [x6, x0]
	ldr	x6, [x19, 80]
	str	q30, [x6, x0]
	ldr	x6, [x19, 96]
	str	q6, [x6, x0]
	ldr	x6, [x19, 112]
	str	q18, [x6, x0]
	ldr	x6, [x19, 128]
	str	q1, [x6, x0]
	mov	x0, x5
	bne	.L67
.L51:
	add	x17, x17, 1
	add	w30, w30, w18
	cmp	w16, w17
	bgt	.L60
.L46:
	sub	w20, w20, w15
	add	x19, x19, x15, sxtw 4
	cmp	w20, wzr
	bgt	.L59
.L36:
	add	sp, x29, 0
	ldr	x23, [sp, 48]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	d8, d9, [sp, 56]
	ldp	x29, x30, [sp], 80
	ret
	.p2align 3
.L66:
	uxth	w0, w7
	strh	w8, [x12, x9, lsl 1]
	cmp	w5, 1
	add	w16, w9, 1
	sub	w6, w0, w10
	mov	w10, w7
	strh	w6, [x11, x9, lsl 1]
	add	x9, x9, 1
	ble	.L38
	mov	w8, w5
	b	.L42
.L54:
	mov	w5, w15
	mov	w0, 0
	mov	w16, 0
.L38:
	cmp	w5, 1
	bne	.L43
	ldr	w7, [x19, 8]
	sbfiz	x6, x16, 1, 32
	add	w16, w16, 1
	strh	w5, [x12, x6]
	sub	w0, w7, w0
	strh	w0, [x11, x6]
.L43:
	cmp	w15, wzr
	ble	.L48
	b	.L44
	.size	combScheduler, .-combScheduler
	.section	.text.startup,"ax",%progbits
	.align	2
	.p2align 4,,15
	.global	main
	.type	main, %function
main:
	sub	sp, sp, #610304
	mov	x1, 23576
	movk	x1, 0x9, lsl 16
	sub	sp, sp, #3024
	adrp	x0, __stack_chk_guard
	add	x0, x0, :lo12:__stack_chk_guard
	stp	x29, x30, [sp, -112]!
	add	x29, sp, 0
	stp	x19, x20, [sp, 16]
	add	x2, x29, 32
	add	x19, x29, 272
	stp	x21, x22, [sp, 32]
	add	x1, x1, x2
	mov	x20, 128
	stp	x23, x24, [sp, 48]
	stp	x25, x26, [sp, 64]
	stp	x27, x28, [sp, 80]
	stp	d8, d9, [sp, 96]
	ldr	x2, [x0]
	str	x2, [x1]
	mov	x2,0
	stp	xzr, xzr, [x19]
	stp	xzr, xzr, [x19, 16]
	stp	xzr, xzr, [x19, 32]
	stp	xzr, xzr, [x19, 48]
	stp	xzr, xzr, [x19, 64]
	stp	xzr, xzr, [x19, 80]
	stp	xzr, xzr, [x19, 96]
	stp	xzr, xzr, [x19, 112]
	str	x20, [x29, 272]
	bl	getpid
	mov	x2, x19
	mov	x1, x20
	bl	sched_setaffinity
	cbz	w0, .L69
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	perror
.L69:
	ldr	q0, .LC2
	add	x3, x29, 32
	mov	x2, 7200
	mov	w1, 1
	add	x2, x2, x3
	add	x0, x29, 152
	sub	x19, x2, #2056
	add	x20, x19, 2048
	str	q0, [x29, 5152]
	bl	timespec_get
	ldp	x0, x1, [x29, 152]
	eor	w0, w1, w0
	bl	srandom
.L70:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L70
	add	x1, x29, 32
	mov	x0, 7200
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 7200
	add	x0, x0, x1
	add	x20, x0, 2040
.L71:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L71
	mov	x0, 11296
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L72:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L72
	add	x1, x29, 32
	mov	x0, 11296
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 11296
	add	x0, x0, x1
	add	x20, x0, 2040
.L73:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L73
	mov	x0, 15392
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L74:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L74
	add	x1, x29, 32
	mov	x0, 15392
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 15392
	add	x0, x0, x1
	add	x20, x0, 2040
.L75:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L75
	mov	x0, 19488
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L76:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L76
	add	x1, x29, 32
	mov	x0, 19488
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 19488
	add	x0, x0, x1
	add	x20, x0, 2040
.L77:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L77
	mov	x0, 23584
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L78:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L78
	add	x1, x29, 32
	mov	x0, 23584
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 23584
	add	x0, x0, x1
	add	x20, x0, 2040
.L79:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L79
	mov	x0, 27680
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L80:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L80
	add	x1, x29, 32
	mov	x0, 27680
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 27680
	add	x0, x0, x1
	add	x20, x0, 2040
.L81:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L81
	mov	x0, 31776
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L82:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L82
	add	x1, x29, 32
	mov	x0, 31776
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 31776
	add	x0, x0, x1
	add	x20, x0, 2040
.L83:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L83
	mov	x0, 35872
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L84:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L84
	add	x1, x29, 32
	mov	x0, 35872
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 35872
	add	x0, x0, x1
	add	x20, x0, 2040
.L85:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L85
	mov	x0, 39968
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L86:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L86
	add	x1, x29, 32
	mov	x0, 39968
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 39968
	add	x0, x0, x1
	add	x20, x0, 2040
.L87:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L87
	mov	x0, 44064
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L88:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L88
	add	x1, x29, 32
	mov	x0, 44064
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 44064
	add	x0, x0, x1
	add	x20, x0, 2040
.L89:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L89
	mov	x0, 48160
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L90:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L90
	add	x1, x29, 32
	mov	x0, 48160
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 48160
	add	x0, x0, x1
	add	x20, x0, 2040
.L91:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L91
	mov	x0, 52256
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L92:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L92
	add	x1, x29, 32
	mov	x0, 52256
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 52256
	add	x0, x0, x1
	add	x20, x0, 2040
.L93:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L93
	mov	x0, 56352
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L94:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L94
	add	x1, x29, 32
	mov	x0, 56352
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 56352
	add	x0, x0, x1
	add	x20, x0, 2040
.L95:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L95
	mov	x0, 60448
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L96:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L96
	add	x1, x29, 32
	mov	x0, 60448
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 60448
	add	x0, x0, x1
	add	x20, x0, 2040
.L97:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L97
	mov	x0, 64544
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L98:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L98
	add	x1, x29, 32
	mov	x0, 64544
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 64544
	add	x0, x0, x1
	add	x20, x0, 2040
.L99:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L99
	mov	x0, 3104
	movk	x0, 0x1, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L100:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L100
	add	x1, x29, 32
	mov	x0, 3104
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 3104
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L101:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L101
	mov	x0, 7200
	movk	x0, 0x1, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L102:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L102
	add	x1, x29, 32
	mov	x0, 7200
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 7200
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L103:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L103
	mov	x0, 11296
	movk	x0, 0x1, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L104:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L104
	add	x1, x29, 32
	mov	x0, 11296
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 11296
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L105:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L105
	mov	x0, 15392
	movk	x0, 0x1, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L106:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L106
	add	x1, x29, 32
	mov	x0, 15392
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 15392
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L107:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L107
	mov	x0, 19488
	movk	x0, 0x1, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L108:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L108
	add	x1, x29, 32
	mov	x0, 19488
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 19488
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L109:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L109
	mov	x0, 23584
	movk	x0, 0x1, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L110:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L110
	add	x1, x29, 32
	mov	x0, 23584
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 23584
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L111:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L111
	mov	x0, 27680
	movk	x0, 0x1, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L112:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L112
	add	x1, x29, 32
	mov	x0, 27680
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 27680
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L113:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L113
	mov	x0, 31776
	movk	x0, 0x1, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L114:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L114
	add	x1, x29, 32
	mov	x0, 31776
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 31776
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L115:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L115
	mov	x0, 35872
	movk	x0, 0x1, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L116:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L116
	add	x1, x29, 32
	mov	x0, 35872
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 35872
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L117:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L117
	mov	x0, 39968
	movk	x0, 0x1, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L118:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L118
	add	x1, x29, 32
	mov	x0, 39968
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 39968
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L119:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L119
	mov	x0, 44064
	movk	x0, 0x1, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L120:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L120
	add	x1, x29, 32
	mov	x0, 44064
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 44064
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L121:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L121
	mov	x0, 48160
	movk	x0, 0x1, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L122:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L122
	add	x1, x29, 32
	mov	x0, 48160
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 48160
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L123:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L123
	mov	x0, 52256
	movk	x0, 0x1, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L124:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L124
	add	x1, x29, 32
	mov	x0, 52256
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 52256
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L125:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L125
	mov	x0, 56352
	movk	x0, 0x1, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L126:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L126
	add	x1, x29, 32
	mov	x0, 56352
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 56352
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L127:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L127
	mov	x0, 60448
	movk	x0, 0x1, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L128:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L128
	add	x1, x29, 32
	mov	x0, 60448
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 60448
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L129:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L129
	mov	x0, 64544
	movk	x0, 0x1, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L130:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L130
	add	x1, x29, 32
	mov	x0, 64544
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 64544
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L131:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L131
	mov	x0, 3104
	movk	x0, 0x2, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L132:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L132
	add	x1, x29, 32
	mov	x0, 3104
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 3104
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L133:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L133
	mov	x0, 7200
	movk	x0, 0x2, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L134:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L134
	add	x1, x29, 32
	mov	x0, 7200
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 7200
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L135:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L135
	mov	x0, 11296
	movk	x0, 0x2, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L136:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L136
	add	x1, x29, 32
	mov	x0, 11296
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 11296
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L137:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L137
	mov	x0, 15392
	movk	x0, 0x2, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L138:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L138
	add	x1, x29, 32
	mov	x0, 15392
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 15392
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L139:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L139
	mov	x0, 19488
	movk	x0, 0x2, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L140:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L140
	add	x1, x29, 32
	mov	x0, 19488
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 19488
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L141:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L141
	mov	x0, 23584
	movk	x0, 0x2, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L142:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L142
	mov	x0, 23584
	movk	x0, 0x2, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L143:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L143
	mov	x0, 27680
	movk	x0, 0x2, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L144:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L144
	add	x1, x29, 32
	mov	x0, 27680
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 27680
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L145:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L145
	mov	x0, 31776
	movk	x0, 0x2, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L146:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L146
	add	x1, x29, 32
	mov	x0, 31776
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 31776
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L147:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L147
	mov	x0, 35872
	movk	x0, 0x2, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L148:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L148
	add	x1, x29, 32
	mov	x0, 35872
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 35872
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L149:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L149
	mov	x0, 39968
	movk	x0, 0x2, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L150:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L150
	add	x1, x29, 32
	mov	x0, 39968
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 39968
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L151:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L151
	mov	x0, 44064
	movk	x0, 0x2, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L152:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L152
	add	x1, x29, 32
	mov	x0, 44064
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 44064
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L153:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L153
	mov	x0, 48160
	movk	x0, 0x2, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L154:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L154
	add	x1, x29, 32
	mov	x0, 48160
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 48160
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L155:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L155
	mov	x0, 52256
	movk	x0, 0x2, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L156:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L156
	add	x1, x29, 32
	mov	x0, 52256
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 52256
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L157:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L157
	mov	x0, 56352
	movk	x0, 0x2, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L158:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L158
	add	x1, x29, 32
	mov	x0, 56352
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 56352
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L159:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L159
	mov	x0, 60448
	movk	x0, 0x2, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L160:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L160
	add	x1, x29, 32
	mov	x0, 60448
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 60448
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L161:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L161
	mov	x0, 64544
	movk	x0, 0x2, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L162:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L162
	add	x1, x29, 32
	mov	x0, 64544
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 64544
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L163:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L163
	mov	x0, 3104
	movk	x0, 0x3, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L164:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L164
	add	x1, x29, 32
	mov	x0, 3104
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 3104
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L165:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L165
	mov	x0, 7200
	movk	x0, 0x3, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L166:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L166
	add	x1, x29, 32
	mov	x0, 7200
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 7200
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L167:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L167
	mov	x0, 11296
	movk	x0, 0x3, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L168:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L168
	add	x1, x29, 32
	mov	x0, 11296
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 11296
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L169:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L169
	mov	x0, 15392
	movk	x0, 0x3, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L170:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L170
	add	x1, x29, 32
	mov	x0, 15392
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 15392
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L171:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L171
	mov	x0, 19488
	movk	x0, 0x3, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L172:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L172
	add	x1, x29, 32
	mov	x0, 19488
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 19488
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L173:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L173
	mov	x0, 23584
	movk	x0, 0x3, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L174:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L174
	add	x1, x29, 32
	mov	x0, 23584
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 23584
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L175:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L175
	mov	x0, 27680
	movk	x0, 0x3, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L176:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L176
	add	x1, x29, 32
	mov	x0, 27680
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 27680
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L177:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L177
	mov	x0, 31776
	movk	x0, 0x3, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L178:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L178
	add	x1, x29, 32
	mov	x0, 31776
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 31776
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L179:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L179
	mov	x0, 35872
	movk	x0, 0x3, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L180:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L180
	add	x1, x29, 32
	mov	x0, 35872
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 35872
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L181:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L181
	mov	x0, 39968
	movk	x0, 0x3, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L182:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L182
	add	x1, x29, 32
	mov	x0, 39968
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 39968
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L183:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L183
	mov	x0, 44064
	movk	x0, 0x3, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L184:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L184
	add	x1, x29, 32
	mov	x0, 44064
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 44064
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L185:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L185
	mov	x0, 48160
	movk	x0, 0x3, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L186:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L186
	add	x1, x29, 32
	mov	x0, 48160
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 48160
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L187:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L187
	mov	x0, 52256
	movk	x0, 0x3, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L188:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L188
	add	x1, x29, 32
	mov	x0, 52256
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 52256
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L189:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L189
	mov	x0, 56352
	movk	x0, 0x3, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L190:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L190
	add	x1, x29, 32
	mov	x0, 56352
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 56352
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L191:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L191
	mov	x0, 60448
	movk	x0, 0x3, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L192:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L192
	add	x1, x29, 32
	mov	x0, 60448
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 60448
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L193:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L193
	mov	x0, 64544
	movk	x0, 0x3, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L194:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L194
	add	x1, x29, 32
	mov	x0, 64544
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 64544
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L195:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L195
	mov	x0, 3104
	movk	x0, 0x4, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L196:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L196
	add	x1, x29, 32
	mov	x0, 3104
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 3104
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L197:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L197
	mov	x0, 7200
	movk	x0, 0x4, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L198:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L198
	add	x1, x29, 32
	mov	x0, 7200
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 7200
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L199:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L199
	mov	x0, 11296
	movk	x0, 0x4, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L200:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L200
	add	x1, x29, 32
	mov	x0, 11296
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 11296
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L201:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L201
	mov	x0, 15392
	movk	x0, 0x4, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L202:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L202
	add	x1, x29, 32
	mov	x0, 15392
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 15392
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L203:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L203
	mov	x0, 19488
	movk	x0, 0x4, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L204:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L204
	add	x1, x29, 32
	mov	x0, 19488
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 19488
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L205:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L205
	mov	x0, 23584
	movk	x0, 0x4, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L206:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L206
	add	x1, x29, 32
	mov	x0, 23584
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 23584
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L207:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L207
	mov	x0, 27680
	movk	x0, 0x4, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L208:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L208
	add	x1, x29, 32
	mov	x0, 27680
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 27680
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L209:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L209
	mov	x0, 31776
	movk	x0, 0x4, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L210:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L210
	add	x1, x29, 32
	mov	x0, 31776
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 31776
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L211:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L211
	mov	x0, 35872
	movk	x0, 0x4, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L212:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L212
	add	x1, x29, 32
	mov	x0, 35872
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 35872
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L213:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L213
	mov	x0, 39968
	movk	x0, 0x4, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L214:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L214
	add	x1, x29, 32
	mov	x0, 39968
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 39968
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L215:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L215
	mov	x0, 44064
	movk	x0, 0x4, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L216:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L216
	add	x1, x29, 32
	mov	x0, 44064
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 44064
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L217:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L217
	mov	x0, 48160
	movk	x0, 0x4, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L218:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L218
	add	x1, x29, 32
	mov	x0, 48160
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 48160
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L219:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L219
	mov	x0, 52256
	movk	x0, 0x4, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L220:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L220
	add	x1, x29, 32
	mov	x0, 52256
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 52256
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L221:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L221
	mov	x0, 56352
	movk	x0, 0x4, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L222:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L222
	add	x1, x29, 32
	mov	x0, 56352
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 56352
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L223:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L223
	mov	x0, 60448
	movk	x0, 0x4, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L224:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L224
	add	x1, x29, 32
	mov	x0, 60448
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 60448
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L225:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L225
	mov	x0, 64544
	movk	x0, 0x4, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L226:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L226
	add	x1, x29, 32
	mov	x0, 64544
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 64544
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L227:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L227
	mov	x0, 3104
	movk	x0, 0x5, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L228:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L228
	add	x1, x29, 32
	mov	x0, 3104
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 3104
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L229:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L229
	mov	x0, 7200
	movk	x0, 0x5, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L230:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L230
	add	x1, x29, 32
	mov	x0, 7200
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 7200
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L231:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L231
	mov	x0, 11296
	movk	x0, 0x5, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L232:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L232
	add	x1, x29, 32
	mov	x0, 11296
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 11296
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L233:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L233
	mov	x0, 15392
	movk	x0, 0x5, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L234:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L234
	add	x1, x29, 32
	mov	x0, 15392
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 15392
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L235:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L235
	mov	x0, 19488
	movk	x0, 0x5, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L236:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L236
	add	x1, x29, 32
	mov	x0, 19488
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 19488
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L237:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L237
	mov	x0, 23584
	movk	x0, 0x5, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L238:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L238
	add	x1, x29, 32
	mov	x0, 23584
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 23584
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L239:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L239
	mov	x0, 27680
	movk	x0, 0x5, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L240:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L240
	add	x1, x29, 32
	mov	x0, 27680
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 27680
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L241:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L241
	mov	x0, 31776
	movk	x0, 0x5, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L242:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L242
	add	x1, x29, 32
	mov	x0, 31776
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 31776
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L243:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L243
	mov	x0, 35872
	movk	x0, 0x5, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L244:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L244
	add	x1, x29, 32
	mov	x0, 35872
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 35872
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L245:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L245
	mov	x0, 39968
	movk	x0, 0x5, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L246:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L246
	add	x1, x29, 32
	mov	x0, 39968
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 39968
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L247:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L247
	mov	x0, 44064
	movk	x0, 0x5, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L248:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L248
	add	x1, x29, 32
	mov	x0, 44064
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 44064
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L249:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L249
	mov	x0, 48160
	movk	x0, 0x5, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L250:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L250
	add	x1, x29, 32
	mov	x0, 48160
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 48160
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L251:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L251
	mov	x0, 52256
	movk	x0, 0x5, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L252:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L252
	add	x1, x29, 32
	mov	x0, 52256
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 52256
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L253:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L253
	mov	x0, 56352
	movk	x0, 0x5, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L254:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L254
	add	x1, x29, 32
	mov	x0, 56352
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 56352
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L255:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L255
	mov	x0, 60448
	movk	x0, 0x5, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L256:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L256
	add	x1, x29, 32
	mov	x0, 60448
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 60448
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L257:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L257
	mov	x0, 64544
	movk	x0, 0x5, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L258:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L258
	add	x1, x29, 32
	mov	x0, 64544
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 64544
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L259:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L259
	mov	x0, 3104
	movk	x0, 0x6, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L260:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L260
	add	x1, x29, 32
	mov	x0, 3104
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 3104
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L261:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L261
	mov	x0, 7200
	movk	x0, 0x6, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L262:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L262
	add	x1, x29, 32
	mov	x0, 7200
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 7200
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L263:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L263
	mov	x0, 11296
	movk	x0, 0x6, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L264:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L264
	add	x1, x29, 32
	mov	x0, 11296
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 11296
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L265:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L265
	mov	x0, 15392
	movk	x0, 0x6, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L266:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L266
	add	x1, x29, 32
	mov	x0, 15392
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 15392
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L267:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L267
	mov	x0, 19488
	movk	x0, 0x6, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L268:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L268
	add	x1, x29, 32
	mov	x0, 19488
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 19488
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L269:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L269
	mov	x0, 23584
	movk	x0, 0x6, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L270:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L270
	add	x1, x29, 32
	mov	x0, 23584
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 23584
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L271:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L271
	mov	x0, 27680
	movk	x0, 0x6, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L272:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L272
	add	x1, x29, 32
	mov	x0, 27680
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 27680
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L273:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L273
	mov	x0, 31776
	movk	x0, 0x6, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L274:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L274
	add	x1, x29, 32
	mov	x0, 31776
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 31776
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L275:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L275
	mov	x0, 35872
	movk	x0, 0x6, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L276:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L276
	add	x1, x29, 32
	mov	x0, 35872
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 35872
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L277:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L277
	mov	x0, 39968
	movk	x0, 0x6, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L278:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L278
	add	x1, x29, 32
	mov	x0, 39968
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 39968
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L279:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L279
	mov	x0, 44064
	movk	x0, 0x6, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L280:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L280
	add	x1, x29, 32
	mov	x0, 44064
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 44064
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L281:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L281
	mov	x0, 48160
	movk	x0, 0x6, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L282:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L282
	add	x1, x29, 32
	mov	x0, 48160
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 48160
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L283:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L283
	mov	x0, 52256
	movk	x0, 0x6, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L284:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L284
	add	x1, x29, 32
	mov	x0, 52256
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 52256
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L285:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L285
	mov	x0, 56352
	movk	x0, 0x6, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L286:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L286
	add	x1, x29, 32
	mov	x0, 56352
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 56352
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L287:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L287
	mov	x0, 60448
	movk	x0, 0x6, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L288:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L288
	add	x1, x29, 32
	mov	x0, 60448
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 60448
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L289:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L289
	mov	x0, 64544
	movk	x0, 0x6, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L290:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L290
	add	x1, x29, 32
	mov	x0, 64544
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 64544
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L291:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L291
	mov	x0, 3104
	movk	x0, 0x7, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L292:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L292
	add	x1, x29, 32
	mov	x0, 3104
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 3104
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L293:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L293
	mov	x0, 7200
	movk	x0, 0x7, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L294:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L294
	add	x1, x29, 32
	mov	x0, 7200
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 7200
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L295:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L295
	mov	x0, 11296
	movk	x0, 0x7, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L296:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L296
	add	x1, x29, 32
	mov	x0, 11296
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 11296
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L297:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L297
	mov	x0, 15392
	movk	x0, 0x7, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L298:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L298
	add	x1, x29, 32
	mov	x0, 15392
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 15392
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L299:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L299
	mov	x0, 19488
	movk	x0, 0x7, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L300:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L300
	add	x1, x29, 32
	mov	x0, 19488
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 19488
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L301:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L301
	mov	x0, 23584
	movk	x0, 0x7, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L302:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L302
	add	x1, x29, 32
	mov	x0, 23584
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 23584
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L303:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L303
	mov	x0, 27680
	movk	x0, 0x7, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L304:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L304
	add	x1, x29, 32
	mov	x0, 27680
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 27680
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L305:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L305
	mov	x0, 31776
	movk	x0, 0x7, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L306:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L306
	add	x1, x29, 32
	mov	x0, 31776
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 31776
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L307:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L307
	mov	x0, 35872
	movk	x0, 0x7, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L308:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L308
	add	x1, x29, 32
	mov	x0, 35872
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 35872
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L309:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L309
	mov	x0, 39968
	movk	x0, 0x7, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L310:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L310
	add	x1, x29, 32
	mov	x0, 39968
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 39968
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L311:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L311
	mov	x0, 44064
	movk	x0, 0x7, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L312:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L312
	add	x1, x29, 32
	mov	x0, 44064
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 44064
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L313:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L313
	mov	x0, 48160
	movk	x0, 0x7, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L314:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L314
	add	x1, x29, 32
	mov	x0, 48160
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 48160
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L315:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L315
	mov	x0, 52256
	movk	x0, 0x7, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L316:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L316
	add	x1, x29, 32
	mov	x0, 52256
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 52256
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L317:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L317
	mov	x0, 56352
	movk	x0, 0x7, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L318:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L318
	add	x1, x29, 32
	mov	x0, 56352
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 56352
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L319:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L319
	mov	x0, 60448
	movk	x0, 0x7, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L320:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L320
	add	x1, x29, 32
	mov	x0, 60448
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 60448
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L321:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L321
	mov	x0, 64544
	movk	x0, 0x7, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L322:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L322
	add	x1, x29, 32
	mov	x0, 64544
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 64544
	movk	x0, 0x7, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L323:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L323
	mov	x0, 3104
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L324:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L324
	add	x1, x29, 32
	mov	x0, 3104
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 3104
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L325:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L325
	mov	x0, 7200
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L326:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L326
	add	x1, x29, 32
	mov	x0, 7200
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 7200
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L327:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L327
	mov	x0, 11296
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L328:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L328
	add	x1, x29, 32
	mov	x0, 11296
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 11296
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L329:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L329
	mov	x0, 15392
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L330:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L330
	add	x1, x29, 32
	mov	x0, 15392
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 15392
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L331:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L331
	mov	x0, 19488
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L332:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L332
	add	x1, x29, 32
	mov	x0, 19488
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 19488
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L333:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L333
	mov	x0, 23584
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L334:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L334
	add	x1, x29, 32
	mov	x0, 23584
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	sub	x19, x0, #8
	mov	x0, 23584
	movk	x0, 0x8, lsl 16
	add	x0, x0, x1
	add	x20, x0, 2040
.L335:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L335
	mov	x0, 27680
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L336:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L336
	mov	x0, 27680
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L337:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L337
	mov	x0, 31776
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L338:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L338
	mov	x0, 31776
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L339:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L339
	mov	x0, 35872
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L340:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L340
	mov	x0, 35872
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L341:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L341
	mov	x0, 39968
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L342:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L342
	mov	x0, 39968
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L343:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L343
	mov	x0, 44064
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L344:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L344
	mov	x0, 44064
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L345:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L345
	mov	x0, 48160
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L346:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L346
	mov	x0, 48160
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L347:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L347
	mov	x0, 52256
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L348:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L348
	mov	x0, 52256
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L349:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L349
	mov	x0, 56352
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L350:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L350
	mov	x0, 56352
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L351:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L351
	mov	x0, 60448
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L352:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L352
	mov	x0, 60448
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L353:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L353
	mov	x0, 64544
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L354:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L354
	mov	x0, 64544
	movk	x0, 0x8, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L355:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L355
	mov	x0, 3104
	movk	x0, 0x9, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L356:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L356
	mov	x0, 3104
	movk	x0, 0x9, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L357:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L357
	mov	x0, 7200
	movk	x0, 0x9, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L358:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L358
	mov	x0, 7200
	movk	x0, 0x9, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L359:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L359
	mov	x0, 11296
	movk	x0, 0x9, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L360:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L360
	mov	x0, 11296
	movk	x0, 0x9, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L361:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L361
	mov	x0, 15392
	movk	x0, 0x9, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L362:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L362
	mov	x0, 15392
	movk	x0, 0x9, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L363:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L363
	mov	x0, 19488
	movk	x0, 0x9, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #2056
	add	x20, x19, 2048
.L364:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L364
	mov	x0, 19488
	movk	x0, 0x9, lsl 16
	add	x1, x29, 32
	add	x0, x0, x1
	sub	x19, x0, #8
	add	x20, x19, 2048
.L365:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L365
	mov	x0, 21528
	movk	x0, 0x9, lsl 16
	add	x1, x29, 32
	add	x19, x1, x0
	mov	x20, x19
	add	x21, x19, 2048
.L366:
	bl	random
	strb	w0, [x20], 1
	cmp	x21, x20
	bne	.L366
	mov	w20, 2048
.L367:
	bl	random
	subs	w20, w20, #1
	bne	.L367
	mov	w20, 2048
.L368:
	bl	random
	subs	w20, w20, #1
	bne	.L368
	mov	w20, 2048
.L369:
	bl	random
	subs	w20, w20, #1
	bne	.L369
	add	x1, x29, 32
	mov	x0, 7200
	add	x0, x0, x1
	mov	w4, 128
	sub	x0, x0, #2056
	add	x2, x29, 32
	str	w4, [x29, 408]
	add	x3, x29, 32
	add	x5, x29, 32
	str	x0, [x29, 400]
	mov	x0, 7200
	add	x6, x29, 32
	add	x0, x0, x1
	str	w4, [x29, 424]
	add	x12, x29, 32
	sub	x0, x0, #8
	str	w4, [x29, 440]
	mov	w20, 26215
	movk	w20, 0x6666, lsl 16
	str	x0, [x29, 416]
	mov	x0, 7200
	add	x22, x29, 392
	add	x0, x0, x1
	str	w4, [x29, 456]
	sub	x0, x0, #2080
	str	w4, [x29, 472]
	str	w4, [x29, 488]
	str	x0, [x29, 120]
	mov	x0, 11296
	add	x0, x0, x1
	str	w4, [x29, 504]
	sub	x0, x0, #2056
	str	w4, [x29, 520]
	str	w4, [x29, 536]
	str	x0, [x29, 432]
	mov	x0, 11296
	add	x0, x0, x1
	str	w4, [x29, 552]
	sub	x0, x0, #8
	str	w4, [x29, 568]
	str	w4, [x29, 584]
	str	x0, [x29, 448]
	mov	x0, 15392
	add	x0, x0, x1
	str	w4, [x29, 600]
	sub	x0, x0, #2056
	str	w4, [x29, 616]
	str	w4, [x29, 632]
	str	x0, [x29, 464]
	mov	x0, 15392
	add	x0, x0, x1
	str	w4, [x29, 648]
	sub	x0, x0, #8
	str	x0, [x29, 480]
	mov	x0, 19488
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 496]
	mov	x0, 19488
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 512]
	mov	x0, 23584
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 528]
	mov	x0, 23584
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 544]
	mov	x0, 27680
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 560]
	mov	x0, 27680
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 576]
	mov	x0, 31776
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 592]
	mov	x0, 31776
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 608]
	mov	x0, 35872
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 624]
	mov	x0, 35872
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 640]
	mov	x0, 39968
	add	x0, x0, x1
	str	w4, [x29, 664]
	sub	x0, x0, #2056
	str	w4, [x29, 680]
	str	w4, [x29, 696]
	str	x0, [x29, 656]
	mov	x0, 39968
	add	x0, x0, x1
	str	w4, [x29, 712]
	sub	x0, x0, #8
	str	w4, [x29, 728]
	str	w4, [x29, 744]
	str	x0, [x29, 672]
	mov	x0, 44064
	add	x0, x0, x1
	str	w4, [x29, 760]
	sub	x0, x0, #2056
	str	w4, [x29, 776]
	str	w4, [x29, 792]
	str	x0, [x29, 688]
	mov	x0, 44064
	add	x0, x0, x1
	str	w4, [x29, 808]
	sub	x0, x0, #8
	str	w4, [x29, 824]
	str	w4, [x29, 840]
	str	x0, [x29, 704]
	mov	x0, 48160
	add	x0, x0, x1
	str	w4, [x29, 856]
	sub	x0, x0, #2056
	str	w4, [x29, 872]
	str	w4, [x29, 888]
	str	x0, [x29, 720]
	mov	x0, 48160
	add	x0, x0, x1
	str	w4, [x29, 904]
	sub	x0, x0, #8
	str	x0, [x29, 736]
	mov	x0, 52256
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 752]
	mov	x0, 52256
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 768]
	mov	x0, 56352
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 784]
	mov	x0, 56352
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 800]
	mov	x0, 60448
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 816]
	mov	x0, 60448
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 832]
	mov	x0, 64544
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 848]
	mov	x0, 64544
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 864]
	mov	x0, 3104
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 880]
	mov	x0, 3104
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 896]
	mov	x0, 7200
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 912]
	mov	x0, 7200
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 920]
	sub	x0, x0, #8
	str	w4, [x29, 936]
	str	w4, [x29, 952]
	str	x0, [x29, 928]
	mov	x0, 11296
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 968]
	sub	x0, x0, #2056
	str	w4, [x29, 984]
	str	w4, [x29, 1000]
	str	x0, [x29, 944]
	mov	x0, 11296
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1016]
	sub	x0, x0, #8
	str	w4, [x29, 1032]
	str	w4, [x29, 1048]
	str	x0, [x29, 960]
	mov	x0, 15392
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1064]
	sub	x0, x0, #2056
	str	w4, [x29, 1080]
	str	w4, [x29, 1096]
	str	x0, [x29, 976]
	mov	x0, 15392
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1112]
	sub	x0, x0, #8
	str	w4, [x29, 1128]
	str	w4, [x29, 1144]
	str	x0, [x29, 992]
	mov	x0, 19488
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1160]
	sub	x0, x0, #2056
	str	w4, [x29, 1176]
	str	x0, [x29, 1008]
	mov	x0, 19488
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1024]
	mov	x0, 23584
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1040]
	mov	x0, 23584
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1056]
	mov	x0, 27680
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1072]
	mov	x0, 27680
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1088]
	mov	x0, 31776
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1104]
	mov	x0, 31776
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1120]
	mov	x0, 35872
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1136]
	mov	x0, 35872
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1152]
	mov	x0, 39968
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1168]
	mov	x0, 39968
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1192]
	sub	x0, x0, #8
	str	w4, [x29, 1208]
	str	w4, [x29, 1224]
	str	x0, [x29, 1184]
	mov	x0, 44064
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1240]
	sub	x0, x0, #2056
	str	w4, [x29, 1256]
	str	w4, [x29, 1272]
	str	x0, [x29, 1200]
	mov	x0, 44064
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1288]
	sub	x0, x0, #8
	str	w4, [x29, 1304]
	str	w4, [x29, 1320]
	str	x0, [x29, 1216]
	mov	x0, 48160
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1336]
	sub	x0, x0, #2056
	str	w4, [x29, 1352]
	str	w4, [x29, 1368]
	str	x0, [x29, 1232]
	mov	x0, 48160
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1384]
	sub	x0, x0, #8
	str	w4, [x29, 1400]
	str	w4, [x29, 1416]
	str	x0, [x29, 1248]
	mov	x0, 52256
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1432]
	sub	x0, x0, #2056
	str	x0, [x29, 1264]
	mov	x0, 52256
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1280]
	mov	x0, 56352
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1296]
	mov	x0, 56352
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1312]
	mov	x0, 60448
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1328]
	mov	x0, 60448
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1344]
	mov	x0, 64544
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1360]
	mov	x0, 64544
	movk	x0, 0x1, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1376]
	mov	x0, 3104
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1392]
	mov	x0, 3104
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1408]
	mov	x0, 7200
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1424]
	mov	x0, 7200
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1440]
	mov	x0, 11296
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1448]
	sub	x0, x0, #2056
	str	w4, [x29, 1464]
	str	w4, [x29, 1480]
	str	x0, [x29, 1456]
	mov	x0, 11296
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1496]
	sub	x0, x0, #8
	str	w4, [x29, 1512]
	str	w4, [x29, 1528]
	str	x0, [x29, 1472]
	mov	x0, 15392
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1544]
	sub	x0, x0, #2056
	str	w4, [x29, 1560]
	str	w4, [x29, 1576]
	str	x0, [x29, 1488]
	mov	x0, 15392
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1592]
	sub	x0, x0, #8
	str	w4, [x29, 1608]
	str	w4, [x29, 1624]
	str	x0, [x29, 1504]
	mov	x0, 19488
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1640]
	sub	x0, x0, #2056
	str	w4, [x29, 1656]
	str	w4, [x29, 1672]
	str	x0, [x29, 1520]
	mov	x0, 19488
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1688]
	sub	x0, x0, #8
	str	w4, [x29, 1704]
	str	x0, [x29, 1536]
	mov	x0, 23584
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1552]
	mov	x0, 23584
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1568]
	mov	x0, 27680
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1584]
	mov	x0, 27680
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1600]
	mov	x0, 31776
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1616]
	mov	x0, 31776
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1632]
	mov	x0, 35872
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1648]
	mov	x0, 35872
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1664]
	mov	x0, 39968
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1680]
	mov	x0, 39968
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1696]
	mov	x0, 44064
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1720]
	sub	x0, x0, #2056
	str	w4, [x29, 1736]
	str	w4, [x29, 1752]
	str	x0, [x29, 1712]
	mov	x0, 44064
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1768]
	sub	x0, x0, #8
	str	w4, [x29, 1784]
	str	w4, [x29, 1800]
	str	x0, [x29, 1728]
	mov	x0, 48160
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1816]
	sub	x0, x0, #2056
	str	w4, [x29, 1832]
	str	w4, [x29, 1848]
	str	x0, [x29, 1744]
	mov	x0, 48160
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1864]
	sub	x0, x0, #8
	str	w4, [x29, 1880]
	str	w4, [x29, 1896]
	str	x0, [x29, 1760]
	mov	x0, 52256
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1912]
	sub	x0, x0, #2056
	str	w4, [x29, 1928]
	str	w4, [x29, 1944]
	str	x0, [x29, 1776]
	mov	x0, 52256
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1960]
	sub	x0, x0, #8
	str	x0, [x29, 1792]
	mov	x0, 56352
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1808]
	mov	x0, 56352
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1824]
	mov	x0, 60448
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1840]
	mov	x0, 60448
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1856]
	mov	x0, 64544
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1872]
	mov	x0, 64544
	movk	x0, 0x2, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1888]
	mov	x0, 3104
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1904]
	mov	x0, 3104
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1920]
	mov	x0, 7200
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1936]
	mov	x0, 7200
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 1952]
	mov	x0, 11296
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 1968]
	mov	x0, 11296
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 1976]
	sub	x0, x0, #8
	str	w4, [x29, 1992]
	str	w4, [x29, 2008]
	str	x0, [x29, 1984]
	mov	x0, 15392
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2024]
	sub	x0, x0, #2056
	str	w4, [x29, 2040]
	str	w4, [x29, 2056]
	str	x0, [x29, 2000]
	mov	x0, 15392
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2072]
	sub	x0, x0, #8
	str	w4, [x29, 2088]
	str	w4, [x29, 2104]
	str	x0, [x29, 2016]
	mov	x0, 19488
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2120]
	sub	x0, x0, #2056
	str	w4, [x29, 2136]
	str	w4, [x29, 2152]
	str	x0, [x29, 2032]
	mov	x0, 19488
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2168]
	sub	x0, x0, #8
	str	w4, [x29, 2184]
	str	w4, [x29, 2200]
	str	x0, [x29, 2048]
	mov	x0, 23584
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2216]
	sub	x0, x0, #2056
	str	w4, [x29, 2232]
	str	x0, [x29, 2064]
	mov	x0, 23584
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2080]
	mov	x0, 27680
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2096]
	mov	x0, 27680
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2112]
	mov	x0, 31776
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2128]
	mov	x0, 31776
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2144]
	mov	x0, 35872
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2160]
	mov	x0, 35872
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2176]
	mov	x0, 39968
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2192]
	mov	x0, 39968
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2208]
	mov	x0, 44064
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2224]
	mov	x0, 44064
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2248]
	sub	x0, x0, #8
	str	w4, [x29, 2264]
	str	w4, [x29, 2280]
	str	x0, [x29, 2240]
	mov	x0, 48160
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2296]
	sub	x0, x0, #2056
	str	w4, [x29, 2312]
	str	w4, [x29, 2328]
	str	x0, [x29, 2256]
	mov	x0, 48160
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2344]
	sub	x0, x0, #8
	str	w4, [x29, 2360]
	str	w4, [x29, 2376]
	str	x0, [x29, 2272]
	mov	x0, 52256
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2392]
	sub	x0, x0, #2056
	str	w4, [x29, 2408]
	str	w4, [x29, 2424]
	str	x0, [x29, 2288]
	mov	x0, 52256
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2440]
	sub	x0, x0, #8
	str	w4, [x29, 2456]
	str	w4, [x29, 2472]
	str	x0, [x29, 2304]
	mov	x0, 56352
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2488]
	sub	x0, x0, #2056
	str	x0, [x29, 2320]
	mov	x0, 56352
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2336]
	mov	x0, 60448
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2352]
	mov	x0, 60448
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2368]
	mov	x0, 64544
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2384]
	mov	x0, 64544
	movk	x0, 0x3, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2400]
	mov	x0, 3104
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2416]
	mov	x0, 3104
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2432]
	mov	x0, 7200
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2448]
	mov	x0, 7200
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2464]
	mov	x0, 11296
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2480]
	mov	x0, 11296
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2496]
	mov	x0, 15392
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2504]
	sub	x0, x0, #2056
	str	w4, [x29, 2520]
	str	w4, [x29, 2536]
	str	x0, [x29, 2512]
	mov	x0, 15392
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2552]
	sub	x0, x0, #8
	str	w4, [x29, 2568]
	str	w4, [x29, 2584]
	str	x0, [x29, 2528]
	mov	x0, 19488
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2600]
	sub	x0, x0, #2056
	str	w4, [x29, 2616]
	str	w4, [x29, 2632]
	str	x0, [x29, 2544]
	mov	x0, 19488
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2648]
	sub	x0, x0, #8
	str	w4, [x29, 2664]
	str	w4, [x29, 2680]
	str	x0, [x29, 2560]
	mov	x0, 23584
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2696]
	sub	x0, x0, #2056
	str	w4, [x29, 2712]
	str	w4, [x29, 2728]
	str	x0, [x29, 2576]
	mov	x0, 23584
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2744]
	sub	x0, x0, #8
	str	w4, [x29, 2760]
	str	x0, [x29, 2592]
	mov	x0, 27680
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2608]
	mov	x0, 27680
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2624]
	mov	x0, 31776
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2640]
	mov	x0, 31776
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2656]
	mov	x0, 35872
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2672]
	mov	x0, 35872
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2688]
	mov	x0, 39968
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2704]
	mov	x0, 39968
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2720]
	mov	x0, 44064
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2736]
	mov	x0, 44064
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2752]
	mov	x0, 48160
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2776]
	sub	x0, x0, #2056
	str	w4, [x29, 2792]
	str	w4, [x29, 2808]
	str	x0, [x29, 2768]
	mov	x0, 48160
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2824]
	sub	x0, x0, #8
	str	w4, [x29, 2840]
	str	w4, [x29, 2856]
	str	x0, [x29, 2784]
	mov	x0, 52256
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2872]
	sub	x0, x0, #2056
	str	w4, [x29, 2888]
	str	w4, [x29, 2904]
	str	x0, [x29, 2800]
	mov	x0, 52256
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2920]
	sub	x0, x0, #8
	str	w4, [x29, 2936]
	str	w4, [x29, 2952]
	str	x0, [x29, 2816]
	mov	x0, 56352
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 2968]
	sub	x0, x0, #2056
	str	w4, [x29, 2984]
	str	w4, [x29, 3000]
	str	x0, [x29, 2832]
	mov	x0, 56352
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3016]
	sub	x0, x0, #8
	str	x0, [x29, 2848]
	mov	x0, 60448
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2864]
	mov	x0, 60448
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2880]
	mov	x0, 64544
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2896]
	mov	x0, 64544
	movk	x0, 0x4, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2912]
	mov	x0, 3104
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2928]
	mov	x0, 3104
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2944]
	mov	x0, 7200
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2960]
	mov	x0, 7200
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 2976]
	mov	x0, 11296
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 2992]
	mov	x0, 11296
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 3008]
	mov	x0, 15392
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 3024]
	mov	x0, 15392
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3032]
	sub	x0, x0, #8
	str	w4, [x29, 3048]
	str	w4, [x29, 3064]
	str	x0, [x29, 3040]
	mov	x0, 19488
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3080]
	sub	x0, x0, #2056
	str	w4, [x29, 3096]
	str	w4, [x29, 3112]
	str	x0, [x29, 3056]
	mov	x0, 19488
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3128]
	sub	x0, x0, #8
	str	w4, [x29, 3144]
	str	w4, [x29, 3160]
	str	x0, [x29, 3072]
	mov	x0, 23584
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3176]
	sub	x0, x0, #2056
	str	w4, [x29, 3192]
	str	w4, [x29, 3208]
	str	x0, [x29, 3088]
	mov	x0, 23584
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3224]
	sub	x0, x0, #8
	str	w4, [x29, 3240]
	str	w4, [x29, 3256]
	str	x0, [x29, 3104]
	mov	x0, 27680
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3272]
	sub	x0, x0, #2056
	str	w4, [x29, 3288]
	str	x0, [x29, 3120]
	mov	x0, 27680
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 3136]
	mov	x0, 31776
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 3152]
	mov	x0, 31776
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 3168]
	mov	x0, 35872
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 3184]
	mov	x0, 35872
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 3200]
	mov	x0, 39968
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 3216]
	mov	x0, 39968
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 3232]
	mov	x0, 44064
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 3248]
	mov	x0, 44064
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #8
	str	x0, [x29, 3264]
	mov	x0, 48160
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	sub	x0, x0, #2056
	str	x0, [x29, 3280]
	mov	x0, 48160
	movk	x0, 0x5, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3304]
	sub	x0, x0, #8
	str	w4, [x29, 3320]
	str	w4, [x29, 3336]
	str	x0, [x29, 3296]
	mov	x0, 35872
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	str	w4, [x29, 3352]
	sub	x7, x0, #2056
	mov	x0, 35872
	movk	x0, 0x6, lsl 16
	add	x0, x0, x1
	mov	x1, 52256
	movk	x1, 0x5, lsl 16
	add	x1, x1, x2
	sub	x0, x0, #8
	str	w4, [x29, 3368]
	sub	x1, x1, #2056
	str	w4, [x29, 3384]
	str	w4, [x29, 3400]
	str	x1, [x29, 3312]
	mov	x1, 52256
	movk	x1, 0x5, lsl 16
	add	x1, x1, x2
	str	w4, [x29, 3416]
	sub	x1, x1, #8
	str	w4, [x29, 3432]
	str	w4, [x29, 3448]
	str	x1, [x29, 3328]
	mov	x1, 31776
	movk	x1, 0x6, lsl 16
	add	x1, x1, x2
	str	w4, [x29, 3464]
	sub	x8, x1, #2056
	mov	x1, 31776
	movk	x1, 0x6, lsl 16
	add	x1, x1, x2
	mov	x2, 23584
	movk	x2, 0x6, lsl 16
	add	x2, x2, x3
	str	w4, [x29, 3480]
	sub	x1, x1, #8
	sub	x10, x2, #8
	mov	x2, 27680
	movk	x2, 0x6, lsl 16
	add	x2, x2, x3
	str	w4, [x29, 3496]
	sub	x9, x2, #2056
	mov	x2, 27680
	movk	x2, 0x6, lsl 16
	add	x2, x2, x3
	mov	x3, 56352
	movk	x3, 0x5, lsl 16
	add	x3, x3, x5
	str	w4, [x29, 3512]
	sub	x2, x2, #8
	sub	x3, x3, #2056
	str	w4, [x29, 3528]
	str	w4, [x29, 3544]
	str	x3, [x29, 3344]
	mov	x3, 56352
	movk	x3, 0x5, lsl 16
	add	x3, x3, x5
	sub	x3, x3, #8
	str	x3, [x29, 3360]
	mov	x3, 23584
	movk	x3, 0x6, lsl 16
	add	x3, x3, x5
	mov	x5, 60448
	movk	x5, 0x5, lsl 16
	add	x5, x5, x6
	sub	x3, x3, #2056
	sub	x5, x5, #2056
	str	x5, [x29, 3376]
	mov	x5, 19488
	movk	x5, 0x6, lsl 16
	add	x5, x5, x6
	sub	x11, x5, #2056
	mov	x5, 19488
	movk	x5, 0x6, lsl 16
	add	x5, x5, x6
	mov	x6, 11296
	movk	x6, 0x6, lsl 16
	add	x6, x6, x12
	sub	x5, x5, #8
	sub	x6, x6, #8
	str	x6, [x29, 3520]
	mov	x6, 15392
	movk	x6, 0x6, lsl 16
	add	x6, x6, x12
	sub	x6, x6, #2056
	str	x6, [x29, 3536]
	mov	x6, 60448
	movk	x6, 0x5, lsl 16
	add	x6, x6, x12
	sub	x6, x6, #8
	str	x6, [x29, 3392]
	mov	x6, 15392
	movk	x6, 0x6, lsl 16
	add	x6, x6, x12
	sub	x6, x6, #8
	str	x6, [x29, 3552]
	mov	x6, 64544
	movk	x6, 0x5, lsl 16
	add	x6, x6, x12
	sub	x6, x6, #2056
	str	x6, [x29, 3408]
	mov	x6, 64544
	movk	x6, 0x5, lsl 16
	add	x6, x6, x12
	sub	x6, x6, #8
	str	x6, [x29, 3424]
	mov	x6, 3104
	movk	x6, 0x6, lsl 16
	add	x6, x6, x12
	sub	x6, x6, #2056
	str	x6, [x29, 3440]
	mov	x6, 3104
	movk	x6, 0x6, lsl 16
	add	x6, x6, x12
	sub	x6, x6, #8
	str	x6, [x29, 3456]
	mov	x6, 7200
	movk	x6, 0x6, lsl 16
	add	x6, x6, x12
	sub	x6, x6, #2056
	str	x6, [x29, 3472]
	mov	x6, 7200
	movk	x6, 0x6, lsl 16
	add	x6, x6, x12
	sub	x6, x6, #8
	str	x6, [x29, 3488]
	mov	x6, 11296
	movk	x6, 0x6, lsl 16
	add	x6, x6, x12
	sub	x6, x6, #2056
	str	x6, [x29, 3504]
	str	x0, [x29, 3712]
	mov	x0, 39968
	movk	x0, 0x6, lsl 16
	add	x0, x0, x12
	str	x11, [x29, 3568]
	sub	x0, x0, #2056
	str	x10, [x29, 3616]
	str	x9, [x29, 3632]
	str	x0, [x29, 3728]
	mov	x0, 39968
	movk	x0, 0x6, lsl 16
	add	x0, x0, x12
	str	x8, [x29, 3664]
	sub	x0, x0, #8
	str	x7, [x29, 3696]
	str	w4, [x29, 3560]
	str	x0, [x29, 3744]
	mov	x0, 44064
	movk	x0, 0x6, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 3576]
	sub	x0, x0, #2056
	str	x5, [x29, 3584]
	str	w4, [x29, 3592]
	str	x0, [x29, 3760]
	mov	x0, 44064
	movk	x0, 0x6, lsl 16
	add	x0, x0, x12
	str	x3, [x29, 3600]
	mov	x3, 15392
	movk	x3, 0x9, lsl 16
	sub	x0, x0, #8
	str	w4, [x29, 3608]
	add	x3, x3, x12
	str	w4, [x29, 3624]
	sub	x6, x3, #2056
	mov	x3, 15392
	movk	x3, 0x9, lsl 16
	str	x0, [x29, 3776]
	mov	x0, 48160
	movk	x0, 0x6, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 3640]
	add	x3, x3, x12
	sub	x0, x0, #2056
	str	x2, [x29, 3648]
	sub	x3, x3, #8
	str	w4, [x29, 3656]
	str	x0, [x29, 3792]
	mov	x0, 48160
	movk	x0, 0x6, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 3672]
	sub	x0, x0, #8
	str	x1, [x29, 3680]
	mov	x1, 3104
	movk	x1, 0x9, lsl 16
	str	w4, [x29, 3688]
	add	x1, x1, x12
	str	w4, [x29, 3704]
	sub	x1, x1, #8
	str	w4, [x29, 3720]
	str	w4, [x29, 3736]
	str	w4, [x29, 3752]
	str	w4, [x29, 3768]
	str	w4, [x29, 3784]
	str	w4, [x29, 3800]
	str	w4, [x29, 3816]
	str	x0, [x29, 3808]
	mov	x0, 52256
	movk	x0, 0x6, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 3832]
	sub	x0, x0, #2056
	str	w4, [x29, 3848]
	str	w4, [x29, 3864]
	str	x0, [x29, 3824]
	mov	x0, 52256
	movk	x0, 0x6, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 3880]
	sub	x0, x0, #8
	str	w4, [x29, 3896]
	str	w4, [x29, 3912]
	str	x0, [x29, 3840]
	mov	x0, 56352
	movk	x0, 0x6, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 3928]
	sub	x0, x0, #2056
	str	w4, [x29, 3944]
	str	w4, [x29, 3960]
	str	x0, [x29, 3856]
	mov	x0, 56352
	movk	x0, 0x6, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 3976]
	sub	x0, x0, #8
	str	w4, [x29, 3992]
	str	w4, [x29, 4008]
	str	x0, [x29, 3872]
	mov	x0, 60448
	movk	x0, 0x6, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 4024]
	sub	x0, x0, #2056
	str	w4, [x29, 4040]
	str	w4, [x29, 4056]
	str	x0, [x29, 3888]
	mov	x0, 60448
	movk	x0, 0x6, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 4072]
	sub	x0, x0, #8
	str	x0, [x29, 3904]
	mov	x0, 64544
	movk	x0, 0x6, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #2056
	str	x0, [x29, 3920]
	mov	x0, 64544
	movk	x0, 0x6, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #8
	str	x0, [x29, 3936]
	mov	x0, 3104
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #2056
	str	x0, [x29, 3952]
	mov	x0, 3104
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #8
	str	x0, [x29, 3968]
	mov	x0, 7200
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #2056
	str	x0, [x29, 3984]
	mov	x0, 7200
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #8
	str	x0, [x29, 4000]
	mov	x0, 11296
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #2056
	str	x0, [x29, 4016]
	mov	x0, 11296
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #8
	str	x0, [x29, 4032]
	mov	x0, 15392
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #2056
	str	x0, [x29, 4048]
	mov	x0, 15392
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #8
	str	x0, [x29, 4064]
	mov	x0, 19488
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #2056
	str	x0, [x29, 4080]
	mov	x0, 19488
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 4088]
	sub	x0, x0, #8
	str	w4, [x29, 4104]
	str	w4, [x29, 4120]
	str	x0, [x29, 4096]
	mov	x0, 23584
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 4136]
	sub	x0, x0, #2056
	str	w4, [x29, 4152]
	str	w4, [x29, 4168]
	str	x0, [x29, 4112]
	mov	x0, 23584
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 4184]
	sub	x0, x0, #8
	str	w4, [x29, 4200]
	str	w4, [x29, 4216]
	str	x0, [x29, 4128]
	mov	x0, 27680
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 4232]
	sub	x0, x0, #2056
	str	w4, [x29, 4248]
	str	w4, [x29, 4264]
	str	x0, [x29, 4144]
	mov	x0, 27680
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 4280]
	sub	x0, x0, #8
	str	w4, [x29, 4296]
	str	w4, [x29, 4312]
	str	x0, [x29, 4160]
	mov	x0, 31776
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 4328]
	sub	x0, x0, #2056
	str	w4, [x29, 4344]
	str	x0, [x29, 4176]
	mov	x0, 31776
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #8
	str	x0, [x29, 4192]
	mov	x0, 35872
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #2056
	str	x0, [x29, 4208]
	mov	x0, 35872
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #8
	str	x0, [x29, 4224]
	mov	x0, 39968
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #2056
	str	x0, [x29, 4240]
	mov	x0, 39968
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #8
	str	x0, [x29, 4256]
	mov	x0, 44064
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #2056
	str	x0, [x29, 4272]
	mov	x0, 44064
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #8
	str	x0, [x29, 4288]
	mov	x0, 48160
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #2056
	str	x0, [x29, 4304]
	mov	x0, 48160
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #8
	str	x0, [x29, 4320]
	mov	x0, 52256
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #2056
	str	x0, [x29, 4336]
	mov	x0, 52256
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 4360]
	sub	x0, x0, #8
	str	w4, [x29, 4376]
	str	w4, [x29, 4392]
	str	x0, [x29, 4352]
	mov	x0, 56352
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 4408]
	sub	x0, x0, #2056
	str	w4, [x29, 4424]
	str	w4, [x29, 4440]
	str	x0, [x29, 4368]
	mov	x0, 56352
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 4456]
	sub	x0, x0, #8
	str	w4, [x29, 4472]
	str	w4, [x29, 4488]
	str	x0, [x29, 4384]
	mov	x0, 60448
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 4504]
	sub	x0, x0, #2056
	str	w4, [x29, 4520]
	str	w4, [x29, 4536]
	str	x0, [x29, 4400]
	mov	x0, 60448
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 4552]
	sub	x0, x0, #8
	str	w4, [x29, 4568]
	str	w4, [x29, 4584]
	str	x0, [x29, 4416]
	mov	x0, 64544
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 4600]
	sub	x0, x0, #2056
	str	x0, [x29, 4432]
	mov	x0, 64544
	movk	x0, 0x7, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #8
	str	x0, [x29, 4448]
	mov	x0, 3104
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #2056
	str	x0, [x29, 4464]
	mov	x0, 3104
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #8
	str	x0, [x29, 4480]
	mov	x0, 7200
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #2056
	str	x0, [x29, 4496]
	mov	x0, 7200
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #8
	str	x0, [x29, 4512]
	mov	x0, 11296
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #2056
	str	x0, [x29, 4528]
	mov	x0, 11296
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #8
	str	x0, [x29, 4544]
	mov	x0, 15392
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #2056
	str	x0, [x29, 4560]
	mov	x0, 15392
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #8
	str	x0, [x29, 4576]
	mov	x0, 19488
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #2056
	str	x0, [x29, 4592]
	mov	x0, 19488
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #8
	str	x0, [x29, 4608]
	mov	x0, 23584
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 4616]
	sub	x0, x0, #2056
	str	w4, [x29, 4632]
	str	w4, [x29, 4648]
	str	x0, [x29, 4624]
	mov	x0, 23584
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 4664]
	sub	x0, x0, #8
	str	w4, [x29, 4680]
	str	w4, [x29, 4696]
	str	x0, [x29, 4640]
	mov	x0, 27680
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 4712]
	sub	x0, x0, #2056
	str	w4, [x29, 4728]
	str	w4, [x29, 4744]
	str	x0, [x29, 4656]
	mov	x0, 27680
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 4760]
	sub	x0, x0, #8
	str	w4, [x29, 4776]
	str	w4, [x29, 4792]
	str	x0, [x29, 4672]
	mov	x0, 31776
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 4808]
	sub	x0, x0, #2056
	str	w4, [x29, 4824]
	str	w4, [x29, 4840]
	str	x0, [x29, 4688]
	mov	x0, 31776
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 4856]
	sub	x0, x0, #8
	str	w4, [x29, 4872]
	str	x0, [x29, 4704]
	mov	x0, 35872
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #2056
	str	x0, [x29, 4720]
	mov	x0, 35872
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #8
	str	x0, [x29, 4736]
	mov	x0, 39968
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #2056
	str	x0, [x29, 4752]
	mov	x0, 39968
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #8
	str	x0, [x29, 4768]
	mov	x0, 44064
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #2056
	str	x0, [x29, 4784]
	mov	x0, 44064
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #8
	str	x0, [x29, 4800]
	mov	x0, 48160
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #2056
	str	x0, [x29, 4816]
	mov	x0, 48160
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #8
	str	x0, [x29, 4832]
	mov	x0, 52256
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #2056
	str	x0, [x29, 4848]
	mov	x0, 52256
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	sub	x0, x0, #8
	str	x0, [x29, 4864]
	mov	x0, 56352
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	str	x1, [x29, 4992]
	mov	x1, 11296
	movk	x1, 0x9, lsl 16
	sub	x0, x0, #2056
	add	x1, x1, x12
	str	x6, [x29, 5072]
	str	w4, [x29, 4888]
	str	x0, [x29, 4880]
	mov	x0, 56352
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 4904]
	sub	x0, x0, #8
	str	w4, [x29, 4920]
	str	w4, [x29, 4936]
	str	x0, [x29, 4896]
	mov	x0, 60448
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 4952]
	sub	x0, x0, #2056
	str	w4, [x29, 4968]
	str	w4, [x29, 4984]
	str	x0, [x29, 4912]
	mov	x0, 60448
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 5000]
	sub	x0, x0, #8
	str	w4, [x29, 5016]
	str	w4, [x29, 5032]
	str	x0, [x29, 4928]
	mov	x0, 64544
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 5048]
	sub	x0, x0, #2056
	str	w4, [x29, 5064]
	str	w4, [x29, 5080]
	str	x0, [x29, 4944]
	mov	x0, 64544
	movk	x0, 0x8, lsl 16
	add	x0, x0, x12
	str	w4, [x29, 5096]
	sub	x0, x0, #8
	str	w4, [x29, 5112]
	str	w4, [x29, 5128]
	str	x0, [x29, 4960]
	mov	x0, 3104
	movk	x0, 0x9, lsl 16
	add	x0, x0, x12
	str	x19, [x29, 5136]
	add	x19, x29, 408
	sub	x0, x0, #2056
	str	x3, [x29, 5088]
	mov	w3, 18432
	movk	w3, 0x9, lsl 16
	str	x0, [x29, 4976]
	mov	x0, 7200
	movk	x0, 0x9, lsl 16
	add	x0, x0, x12
	sub	x2, x0, #2056
	mov	x0, 7200
	movk	x0, 0x9, lsl 16
	add	x0, x0, x12
	str	x2, [x29, 5008]
	sub	x2, x1, #2056
	sub	x0, x0, #8
	mov	x1, 11296
	movk	x1, 0x9, lsl 16
	str	x0, [x29, 5024]
	mov	x0, 19488
	movk	x0, 0x9, lsl 16
	add	x0, x0, x12
	add	x1, x1, x12
	str	x2, [x29, 5040]
	sub	x5, x0, #2056
	mov	x0, 19488
	movk	x0, 0x9, lsl 16
	sub	x1, x1, #8
	add	x0, x0, x12
	str	x5, [x29, 5104]
	sub	x0, x0, #8
	adrp	x2, .LC3
	str	x1, [x29, 5056]
	adrp	x1, .LC4
	add	x2, x2, :lo12:.LC3
	str	x0, [x29, 5120]
	add	x1, x1, :lo12:.LC4
	mov	w0, 1
	str	w4, [x29, 5144]
	bl	__printf_chk
	mov	w0, 10000
	mov	x1, 0
	str	w0, [x29, 132]
	add	x0, x29, 168
	bl	gettimeofday
	ldp	x0, x1, [x29, 168]
	ldr	d8, .LC5
	scvtf	d0, x0
	scvtf	d1, x1
	adrp	x1, start_clk
	fmadd	d0, d0, d8, d1
	fcvtzu	x0, d0
	str	x0, [x1, #:lo12:start_clk]
.L388:
	sub	x0, sp, #4096
	movi	v0.4s, 0
	mov	x1, sp
	sub	sp, x0, #672
	add	x0, x29, 3136
	add	x23, x0, 2008
	mov	x26, sp
	str	x1, [x29, 136]
	mov	x0, x19
.L370:
	ld4	{v4.4s - v7.4s}, [x0], 64
	cmp	x0, x23
	smax	v0.4s, v0.4s, v4.4s
	bne	.L370
	smaxv	s0, v0.4s
	ldr	w21, [x29, 5144]
	umov	w0, v0.s[0]
	cmp	w0, w21
	csel	w21, w0, w21, ge
	cmp	w21, wzr
	ble	.L371
	add	x0, x29, 3136
	mov	w24, 1
	add	x27, x0, 2024
	mov	w25, 9
.L374:
	add	x0, x29, 232
	mov	x2, x19
	str	xzr, [x29, 264]
	stp	xzr, xzr, [x0]
	add	x0, x29, 248
	stp	xzr, xzr, [x0]
	.p2align 2
.L372:
	ldr	w0, [x2], 16
	sdiv	w0, w0, w24
	cmp	x2, x27
	smull	x3, w0, w20
	asr	x1, x3, 34
	sub	w1, w1, w0, asr 31
	lsl	w3, w1, 3
	add	w1, w3, w1, lsl 1
	add	x3, x29, 32
	sub	w0, w0, w1
	mov	x1, 23584
	movk	x1, 0x9, lsl 16
	add	x1, x1, x3
	sub	w0, w25, w0
	add	x0, x1, x0, sxtw 2
	sub	x0, x0, #614400
	ldr	w1, [x0, 1192]
	add	w1, w1, 1
	str	w1, [x0, 1192]
	bne	.L372
	ldp	w8, w10, [x29, 232]
	add	x11, x29, 256
	mov	x4, x23
	ldp	w7, w6, [x29, 240]
	ldp	w5, w3, [x29, 248]
	add	w8, w10, w8
	ldp	w2, w1, [x11]
	add	w7, w8, w7
	ldp	w0, w9, [x11, 8]
	add	w6, w7, w6
	add	w5, w6, w5
	stp	w8, w7, [x29, 236]
	add	w3, w5, w3
	add	w2, w3, w2
	stp	w6, w5, [x29, 244]
	add	w1, w2, w1
	add	w0, w1, w0
	stp	w3, w2, [x29, 252]
	add	w2, w9, w0
	str	w1, [x29, 260]
	str	w0, [x29, 264]
	str	w2, [x29, 268]
	.p2align 2
.L373:
	mov	x1, x4
	sub	x4, x4, #16
	ldr	w0, [x1], -8
	cmp	x22, x4
	sdiv	w0, w0, w24
	ldp	x2, x3, [x1]
	smull	x5, w0, w20
	asr	x1, x5, 34
	sub	w1, w1, w0, asr 31
	lsl	w5, w1, 3
	add	w1, w5, w1, lsl 1
	add	x5, x29, 32
	sub	w0, w0, w1
	mov	x1, 23584
	movk	x1, 0x9, lsl 16
	add	x1, x1, x5
	sub	w0, w25, w0
	add	x0, x1, x0, sxtw 2
	sub	x0, x0, #614400
	ldr	w1, [x0, 1192]
	sub	w1, w1, #1
	add	x5, x26, x1, sxtw 4
	stp	x2, x3, [x5]
	str	w1, [x0, 1192]
	bne	.L373
	mov	x2, 4752
	mov	x1, x26
	add	x0, x29, 400
	bl	memcpy
	lsl	w0, w24, 3
	add	w24, w0, w24, lsl 1
	sdiv	w0, w21, w24
	cmp	w0, wzr
	bgt	.L374
.L371:
	ldr	x0, [x29, 120]
	add	x15, x29, 400
	mov	w27, 297
	mov	w28, 9
	mov	w30, 1
	ldr	q19, .LC6
	mov	x26, -16
	ldr	q18, .LC7
	ldr	q20, [x0]
	ldr	x0, [x29, 136]
	ldr	q17, .LC8
	ldr	q16, .LC9
	mov	sp, x0
	add	x0, x29, 3136
	ldr	q7, .LC10
	sub	sp, sp, #160
	sub	x25, x0, #2952
	mov	x2, sp
	sub	sp, sp, #160
	ldr	q1, .LC11
	mov	x1, sp
	sub	x23, x0, #2928
	ldr	q6, .LC12
	ldr	q5, .LC13
	ldr	q4, .LC14
	ldr	q3, .LC15
	ldr	q2, .LC16
.L387:
	cmp	w27, 9
	csel	w24, w27, w28, le
	cmp	w24, 1
	beq	.L392
	mov	w4, w24
	mov	x6, 0
	mov	w8, 0
	.p2align 2
.L379:
	add	x3, x26, x4, sxtw 4
	add	x3, x15, x3
	sub	w0, w4, #2
	ldr	w3, [x3, 8]
	add	x5, x15, x0, sxtw 4
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
	bne	.L376
	sub	w0, w4, #6
	cmn	w0, #1
	beq	.L377
	ldr	w7, [x5, -56]
	cmp	w7, w3
	bne	.L376
	sub	w0, w4, #7
	cmn	w0, #1
	beq	.L377
	ldr	w7, [x5, -72]
	cmp	w7, w3
	bne	.L376
	sub	w0, w4, #8
	cmn	w0, #1
	beq	.L377
	ldr	w7, [x5, -88]
	cmp	w7, w3
	bne	.L378
	cmp	w4, 9
	bne	.L377
	ldr	w0, [x5, -104]
	cmp	w3, w0
	bne	.L759
.L377:
	uxth	w5, w3
	add	w21, w6, 1
	strh	w4, [x25, x6, lsl 1]
	sub	w5, w5, w8
	strh	w5, [x23, x6, lsl 1]
.L380:
	str	q20, [x1]
	cmp	w24, 1
	beq	.L381
	str	q20, [x1, 16]
	cmp	w24, 2
	beq	.L381
	str	q20, [x1, 32]
	cmp	w24, 3
	beq	.L381
	str	q20, [x1, 48]
	cmp	w24, 4
	beq	.L381
	str	q20, [x1, 64]
	cmp	w24, 5
	beq	.L381
	str	q20, [x1, 80]
	cmp	w24, 6
	beq	.L381
	str	q20, [x1, 96]
	cmp	w24, 7
	beq	.L381
	str	q20, [x1, 112]
	cmp	w24, 9
	bne	.L381
	str	q20, [x1, 128]
.L381:
	mov	x16, 0
	mov	w18, 0
	cbz	w21, .L383
	.p2align 2
.L424:
	ldrh	w17, [x23, x16, lsl 1]
	cbz	w17, .L386
	ldr	q31, [x1]
	lsl	w14, w18, 4
	sub	w13, w17, #1
	add	x13, x13, 1
	sxtw	x14, w14
	mov	x3, 0
	ldr	q30, [x1, 16]
	lsl	x13, x13, 4
	ldr	q29, [x1, 32]
	ldr	q28, [x1, 48]
	ldr	q27, [x1, 64]
	ldr	q26, [x1, 80]
	ldr	q24, [x1, 96]
	ldr	q22, [x1, 112]
	ldr	q0, [x1, 128]
	ldr	x12, [x15]
	ldr	x11, [x15, 16]
	ldr	x10, [x15, 32]
	ldr	x9, [x15, 48]
	ldr	x8, [x15, 64]
	ldr	x7, [x15, 80]
	ldr	x6, [x15, 96]
	ldr	x5, [x15, 112]
	ldr	x4, [x15, 128]
	.p2align 2
.L384:
	add	x0, x14, x3
	add	x3, x3, 16
	cmp	x13, x3
	ldr	q9, [x12, x0]
	ldr	q25, [x6, x0]
	ldr	q23, [x5, x0]
	eor	v31.16b, v9.16b, v31.16b
	ldr	q9, [x11, x0]
	ldr	q21, [x4, x0]
	eor	v24.16b, v25.16b, v24.16b
	eor	v22.16b, v23.16b, v22.16b
	aese	v31.16b, v19.16b
	eor	v30.16b, v9.16b, v30.16b
	ldr	q9, [x10, x0]
	aese	v24.16b, v19.16b
	eor	v0.16b, v21.16b, v0.16b
	aese	v22.16b, v19.16b
	aesmc	v31.16b, v31.16b
	aese	v30.16b, v19.16b
	aesmc	v24.16b, v24.16b
	eor	v29.16b, v9.16b, v29.16b
	ldr	q9, [x9, x0]
	aese	v0.16b, v19.16b
	aesmc	v22.16b, v22.16b
	aesmc	v30.16b, v30.16b
	aese	v31.16b, v18.16b
	aese	v29.16b, v19.16b
	aesmc	v0.16b, v0.16b
	eor	v28.16b, v9.16b, v28.16b
	ldr	q9, [x8, x0]
	aese	v30.16b, v18.16b
	aese	v24.16b, v18.16b
	aesmc	v29.16b, v29.16b
	aese	v22.16b, v18.16b
	aese	v28.16b, v19.16b
	aese	v0.16b, v18.16b
	eor	v27.16b, v9.16b, v27.16b
	ldr	q9, [x7, x0]
	aese	v29.16b, v18.16b
	aesmc	v31.16b, v31.16b
	aesmc	v28.16b, v28.16b
	aesmc	v30.16b, v30.16b
	aese	v27.16b, v19.16b
	aesmc	v29.16b, v29.16b
	eor	v26.16b, v9.16b, v26.16b
	aese	v28.16b, v18.16b
	aesmc	v24.16b, v24.16b
	aesmc	v27.16b, v27.16b
	aesmc	v22.16b, v22.16b
	aese	v26.16b, v19.16b
	aesmc	v28.16b, v28.16b
	aese	v27.16b, v18.16b
	aesmc	v0.16b, v0.16b
	aesmc	v26.16b, v26.16b
	aese	v31.16b, v17.16b
	aesmc	v27.16b, v27.16b
	aese	v30.16b, v17.16b
	aese	v26.16b, v18.16b
	aese	v29.16b, v17.16b
	aese	v28.16b, v17.16b
	aese	v27.16b, v17.16b
	aesmc	v26.16b, v26.16b
	aese	v24.16b, v17.16b
	aese	v22.16b, v17.16b
	aese	v0.16b, v17.16b
	aese	v26.16b, v17.16b
	aesmc	v31.16b, v31.16b
	aesmc	v30.16b, v30.16b
	aesmc	v29.16b, v29.16b
	aesmc	v28.16b, v28.16b
	aesmc	v27.16b, v27.16b
	aesmc	v26.16b, v26.16b
	aesmc	v24.16b, v24.16b
	aesmc	v22.16b, v22.16b
	aesmc	v0.16b, v0.16b
	aese	v31.16b, v16.16b
	aese	v30.16b, v16.16b
	aese	v29.16b, v16.16b
	aese	v28.16b, v16.16b
	aese	v27.16b, v16.16b
	aese	v26.16b, v16.16b
	aese	v24.16b, v16.16b
	aese	v22.16b, v16.16b
	aese	v0.16b, v16.16b
	aesmc	v31.16b, v31.16b
	aesmc	v30.16b, v30.16b
	aesmc	v29.16b, v29.16b
	aesmc	v28.16b, v28.16b
	aesmc	v27.16b, v27.16b
	aesmc	v26.16b, v26.16b
	aesmc	v24.16b, v24.16b
	aesmc	v22.16b, v22.16b
	aesmc	v0.16b, v0.16b
	aese	v31.16b, v7.16b
	aese	v30.16b, v7.16b
	aese	v29.16b, v7.16b
	aese	v28.16b, v7.16b
	aese	v27.16b, v7.16b
	aese	v26.16b, v7.16b
	aese	v24.16b, v7.16b
	aese	v22.16b, v7.16b
	aese	v0.16b, v7.16b
	aesmc	v31.16b, v31.16b
	aesmc	v30.16b, v30.16b
	aesmc	v29.16b, v29.16b
	aesmc	v28.16b, v28.16b
	aesmc	v27.16b, v27.16b
	aesmc	v26.16b, v26.16b
	aesmc	v24.16b, v24.16b
	aesmc	v22.16b, v22.16b
	aesmc	v0.16b, v0.16b
	aese	v31.16b, v1.16b
	aese	v30.16b, v1.16b
	aese	v29.16b, v1.16b
	aese	v28.16b, v1.16b
	aese	v27.16b, v1.16b
	aese	v26.16b, v1.16b
	aese	v24.16b, v1.16b
	aese	v22.16b, v1.16b
	aese	v0.16b, v1.16b
	aesmc	v31.16b, v31.16b
	aesmc	v30.16b, v30.16b
	aesmc	v29.16b, v29.16b
	aesmc	v28.16b, v28.16b
	aesmc	v27.16b, v27.16b
	aesmc	v26.16b, v26.16b
	aesmc	v24.16b, v24.16b
	aesmc	v22.16b, v22.16b
	aesmc	v0.16b, v0.16b
	aese	v31.16b, v1.16b
	aese	v30.16b, v1.16b
	aese	v29.16b, v1.16b
	aese	v28.16b, v1.16b
	aese	v27.16b, v1.16b
	aese	v26.16b, v1.16b
	aese	v24.16b, v1.16b
	aese	v22.16b, v1.16b
	aese	v0.16b, v1.16b
	aesmc	v31.16b, v31.16b
	aesmc	v30.16b, v30.16b
	aesmc	v29.16b, v29.16b
	aesmc	v28.16b, v28.16b
	aesmc	v27.16b, v27.16b
	aesmc	v26.16b, v26.16b
	aesmc	v24.16b, v24.16b
	aesmc	v22.16b, v22.16b
	aesmc	v0.16b, v0.16b
	aese	v31.16b, v6.16b
	aese	v30.16b, v6.16b
	aese	v29.16b, v6.16b
	aese	v28.16b, v6.16b
	aese	v27.16b, v6.16b
	aese	v26.16b, v6.16b
	aese	v24.16b, v6.16b
	aese	v22.16b, v6.16b
	aese	v0.16b, v6.16b
	aesmc	v31.16b, v31.16b
	aesmc	v30.16b, v30.16b
	aesmc	v29.16b, v29.16b
	aesmc	v28.16b, v28.16b
	aesmc	v27.16b, v27.16b
	aesmc	v26.16b, v26.16b
	aesmc	v24.16b, v24.16b
	aesmc	v22.16b, v22.16b
	aesmc	v0.16b, v0.16b
	aese	v31.16b, v5.16b
	aese	v30.16b, v5.16b
	aese	v29.16b, v5.16b
	aese	v28.16b, v5.16b
	aese	v27.16b, v5.16b
	aese	v26.16b, v5.16b
	aese	v24.16b, v5.16b
	aese	v22.16b, v5.16b
	aese	v0.16b, v5.16b
	aesmc	v31.16b, v31.16b
	aesmc	v30.16b, v30.16b
	aesmc	v29.16b, v29.16b
	aesmc	v28.16b, v28.16b
	aesmc	v27.16b, v27.16b
	aesmc	v26.16b, v26.16b
	aesmc	v24.16b, v24.16b
	aesmc	v22.16b, v22.16b
	aesmc	v0.16b, v0.16b
	aese	v31.16b, v4.16b
	aese	v30.16b, v4.16b
	aese	v29.16b, v4.16b
	aese	v28.16b, v4.16b
	aese	v27.16b, v4.16b
	aese	v26.16b, v4.16b
	aese	v24.16b, v4.16b
	aese	v22.16b, v4.16b
	aese	v0.16b, v4.16b
	aesmc	v31.16b, v31.16b
	aesmc	v30.16b, v30.16b
	aesmc	v29.16b, v29.16b
	aesmc	v28.16b, v28.16b
	aesmc	v27.16b, v27.16b
	aesmc	v26.16b, v26.16b
	aesmc	v24.16b, v24.16b
	aesmc	v22.16b, v22.16b
	aesmc	v0.16b, v0.16b
	aese	v31.16b, v3.16b
	aese	v30.16b, v3.16b
	aese	v29.16b, v3.16b
	aese	v28.16b, v3.16b
	aese	v27.16b, v3.16b
	eor	v31.16b, v31.16b, v2.16b
	aese	v26.16b, v3.16b
	eor	v30.16b, v30.16b, v2.16b
	aese	v24.16b, v3.16b
	eor	v29.16b, v29.16b, v2.16b
	aese	v22.16b, v3.16b
	eor	v28.16b, v28.16b, v2.16b
	aese	v0.16b, v3.16b
	eor	v27.16b, v27.16b, v2.16b
	str	q31, [x2]
	eor	v26.16b, v26.16b, v2.16b
	str	q30, [x2, 16]
	eor	v24.16b, v24.16b, v2.16b
	str	q29, [x2, 32]
	eor	v22.16b, v22.16b, v2.16b
	str	q28, [x2, 48]
	eor	v0.16b, v0.16b, v2.16b
	str	q27, [x2, 64]
	str	q26, [x2, 80]
	str	q24, [x2, 96]
	str	q22, [x2, 112]
	str	q0, [x2, 128]
	str	q31, [x1]
	str	q30, [x1, 16]
	str	q29, [x1, 32]
	str	q28, [x1, 48]
	str	q27, [x1, 64]
	str	q26, [x1, 80]
	str	q24, [x1, 96]
	str	q22, [x1, 112]
	str	q0, [x1, 128]
	str	q31, [x12, x0]
	str	q30, [x11, x0]
	str	q29, [x10, x0]
	str	q28, [x9, x0]
	str	q27, [x8, x0]
	str	q26, [x7, x0]
	str	q24, [x6, x0]
	str	q22, [x5, x0]
	str	q0, [x4, x0]
	bne	.L384
.L386:
	add	x16, x16, 1
	add	w18, w18, w17
	cmp	w21, w16
	bgt	.L424
.L383:
	sub	w27, w27, w24
	add	x15, x15, x24, sxtw 4
	cmp	w27, wzr
	bgt	.L387
	ldr	w0, [x29, 132]
	subs	w0, w0, #1
	str	w0, [x29, 132]
	ldr	x0, [x29, 136]
	mov	sp, x0
	bne	.L388
	mov	x1, 0
	add	x0, x29, 168
	bl	gettimeofday
	ldp	x3, x4, [x29, 168]
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
	add	x0, x29, 3136
	add	x4, x29, 400
	add	x0, x0, 2016
.L389:
	ldr	x3, [x4]
	add	x4, x4, 16
	ldr	w2, [x4, -8]
	cmp	x4, x0
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
	add	x3, x29, 32
	mov	x2, 23576
	movk	x2, 0x9, lsl 16
	adrp	x1, __stack_chk_guard
	add	x1, x1, :lo12:__stack_chk_guard
	add	x2, x2, x3
	mov	w0, w19
	ldr	x3, [x2]
	ldr	x1, [x1]
	eor	x1, x3, x1
	cbnz	x1, .L760
	add	sp, x29, 0
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	ldp	d8, d9, [sp, 96]
	ldp	x29, x30, [sp], 112
	add	sp, sp, 610304
	add	sp, sp, 3024
	ret
	.p2align 3
.L376:
	uxth	w5, w3
	strh	w4, [x25, x6, lsl 1]
	cmp	w0, 1
	add	w21, w6, 1
	sub	w4, w5, w8
	mov	w8, w3
	strh	w4, [x23, x6, lsl 1]
	add	x6, x6, 1
	ble	.L390
	mov	w4, w0
	b	.L379
.L759:
	mov	w0, 0
.L378:
	uxth	w5, w3
	add	w21, w6, 1
	strh	w4, [x25, x6, lsl 1]
	sub	w8, w5, w8
	strh	w8, [x23, x6, lsl 1]
.L390:
	cmp	w0, 1
	bne	.L380
	ldr	w3, [x15, 8]
	sub	x0, x29, #960
	add	x0, x0, x21, sxtw 1
	add	w21, w21, 1
	strh	w30, [x0, 1144]
	sub	w5, w3, w5
	strh	w5, [x0, 1168]
	b	.L380
.L392:
	ldr	w3, [x15, 8]
	mov	w5, 0
	mov	w21, 0
	sub	x0, x29, #960
	add	x0, x0, x21, sxtw 1
	add	w21, w21, 1
	strh	w30, [x0, 1144]
	sub	w5, w3, w5
	strh	w5, [x0, 1168]
	b	.L380
.L760:
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
	.word	1092784128
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
