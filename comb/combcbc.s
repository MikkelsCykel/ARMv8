	.cpu cortex-a57+fp+simd+crypto+crc
	.file	"combcbc.c"
	.text
	.align	2
	.p2align 4,,15
	.type	combScheduler.constprop.0, %function
combScheduler.constprop.0:
	stp	x29, x30, [sp, -272]!
	add	x29, sp, 0
	stp	x19, x20, [sp, 16]
	mov	x4, x0
	sub	x3, sp, #4096
	stp	x23, x24, [sp, 48]
	movi	v0.4s, 0
	mov	x6, sp
	stp	x25, x26, [sp, 64]
	adrp	x26, __stack_chk_guard
	add	x0, x26, :lo12:__stack_chk_guard
	stp	x27, x28, [sp, 80]
	add	x5, x4, 8
	add	x28, x4, 4096
	stp	x21, x22, [sp, 32]
	mov	x19, x1
	sub	sp, x3, #720
	ldr	x1, [x0]
	str	x1, [x29, 264]
	mov	x1,0
	mov	x7, x2
	mov	x23, sp
	add	x1, x28, 648
	mov	x0, x5
.L2:
	ld4	{v4.4s - v7.4s}, [x0], 64
	cmp	x0, x1
	smax	v0.4s, v0.4s, v4.4s
	bne	.L2
	ldr	w1, [x28, 696]
	smaxv	s0, v0.4s
	ldr	w0, [x28, 680]
	ldr	w24, [x28, 648]
	cmp	w0, w1
	csel	w0, w0, w1, ge
	ldr	w1, [x28, 664]
	cmp	w1, w24
	csel	w24, w1, w24, ge
	cmp	w0, w24
	csel	w0, w0, w24, ge
	umov	w24, v0.s[0]
	cmp	w24, w0
	csel	w24, w24, w0, ge
	cmp	w24, wzr
	ble	.L8
	mov	w22, 26215
	movk	w22, 0x6666, lsl 16
	mov	w20, 1
	sub	x27, x4, #8
	add	x25, x28, 712
	mov	w21, 9
.L7:
	mov	x2, x5
	stp	xzr, xzr, [x29, 160]
	stp	xzr, xzr, [x29, 176]
	str	xzr, [x29, 192]
	.p2align 2
.L5:
	ldr	w0, [x2], 16
	sdiv	w0, w0, w20
	cmp	x2, x25
	smull	x1, w0, w22
	asr	x1, x1, 34
	sub	w1, w1, w0, asr 31
	lsl	w3, w1, 3
	add	w1, w3, w1, lsl 1
	sub	w0, w0, w1
	add	x1, x29, 272
	sub	w0, w21, w0
	add	x0, x1, x0, sxtw 2
	ldr	w1, [x0, -112]
	add	w1, w1, 1
	str	w1, [x0, -112]
	bne	.L5
	ldp	w13, w14, [x29, 160]
	add	x8, x28, 696
	ldp	w11, w10, [x29, 168]
	ldp	w9, w3, [x29, 176]
	add	w13, w14, w13
	ldp	w2, w1, [x29, 184]
	add	w11, w13, w11
	ldp	w0, w12, [x29, 192]
	add	w10, w11, w10
	add	w9, w10, w9
	stp	w13, w11, [x29, 164]
	add	w3, w9, w3
	add	w2, w3, w2
	stp	w10, w9, [x29, 172]
	add	w1, w2, w1
	add	w0, w1, w0
	stp	w3, w2, [x29, 180]
	add	w12, w12, w0
	stp	w1, w0, [x29, 188]
	str	w12, [x29, 196]
	.p2align 2
.L6:
	mov	x1, x8
	sub	x8, x8, #16
	ldr	w0, [x1], -8
	cmp	x27, x8
	sdiv	w0, w0, w20
	ldp	x2, x3, [x1]
	smull	x1, w0, w22
	asr	x1, x1, 34
	sub	w1, w1, w0, asr 31
	lsl	w9, w1, 3
	add	w1, w9, w1, lsl 1
	sub	w0, w0, w1
	add	x1, x29, 272
	sub	w0, w21, w0
	add	x0, x1, x0, sxtw 2
	ldr	w1, [x0, -112]
	sub	w1, w1, #1
	add	x9, x23, x1, sxtw 4
	stp	x2, x3, [x9]
	str	w1, [x0, -112]
	bne	.L6
	mov	x0, x4
	mov	x2, 4800
	stp	x7, x5, [x29, 104]
	mov	x1, x23
	str	x6, [x29, 120]
	bl	memcpy
	mov	x4, x0
	lsl	w0, w20, 3
	ldp	x7, x5, [x29, 104]
	add	w20, w0, w20, lsl 1
	ldr	x6, [x29, 120]
	sdiv	w0, w24, w20
	cmp	w0, wzr
	bgt	.L7
.L8:
	ldr	q19, [x7]
	mov	w10, 300
	mov	w11, 6
	mov	sp, x6
	mov	w13, 1
	mov	x9, -16
.L4:
	cmp	w10, 6
	csel	w12, w10, w11, le
	cmp	w12, 1
	beq	.L27
	mov	w2, w12
	mov	x5, 0
	mov	w14, 0
	add	x6, x29, 128
	add	x8, x29, 144
.L13:
	add	x1, x9, x2, sxtw 4
	add	x1, x4, x1
	sub	w0, w2, #2
	ldr	w1, [x1, 8]
	add	x3, x4, x0, sxtw 4
	ldr	w7, [x3, 8]
	cmp	w7, w1
	bne	.L10
	sub	w0, w2, #3
	cmn	w0, #1
	beq	.L11
	ldr	w7, [x3, -8]
	cmp	w7, w1
	bne	.L10
	sub	w0, w2, #4
	cmn	w0, #1
	beq	.L11
	ldr	w7, [x3, -24]
	cmp	w7, w1
	bne	.L10
	sub	w0, w2, #5
	cmn	w0, #1
	beq	.L11
	ldr	w7, [x3, -40]
	cmp	w7, w1
	bne	.L12
	cmp	w2, 6
	bne	.L11
	ldr	w0, [x3, -56]
	cmp	w1, w0
	bne	.L66
.L11:
	uxth	w3, w1
	add	w17, w5, 1
	strh	w2, [x6, x5, lsl 1]
	sub	w3, w3, w14
	strh	w3, [x8, x5, lsl 1]
.L14:
	str	q19, [x29, 160]
	cmp	w12, 1
	beq	.L15
	str	q19, [x29, 176]
	cmp	w12, 2
	beq	.L15
	str	q19, [x29, 192]
	cmp	w12, 3
	beq	.L15
	str	q19, [x29, 208]
	cmp	w12, 4
	beq	.L15
	str	q19, [x29, 224]
	cmp	w12, 6
	bne	.L15
	str	q19, [x29, 240]
.L15:
	cbz	w17, .L17
	mov	x15, 0
	mov	w18, 0
	add	x8, x29, 144
	.p2align 2
.L23:
	ldrh	w16, [x8, x15, lsl 1]
	cbz	w16, .L24
	add	x6, x29, 128
	lsl	w2, w18, 4
	ldrh	w14, [x6, x15, lsl 1]
	sxtw	x2, w2
	sub	w7, w16, #1
	add	x6, x2, 16
	add	x7, x6, x7, uxtw 4
	sub	w5, w14, #1
	cmp	w14, 6
	add	x5, x5, 1
	lsl	x5, x5, 4
	beq	.L18
	.p2align 2
.L67:
	mov	x0, 0
	add	x3, x29, 160
	cbz	w14, .L20
	.p2align 2
.L19:
	ldr	x1, [x4, x0]
	ldr	q0, [x3, x0]
	ldr	q21, [x19]
	ldr	q1, [x1, x2]
	ldr	q20, [x19, 16]
	ldr	q18, [x19, 32]
	eor	v0.16b, v1.16b, v0.16b
	ldr	q17, [x19, 48]
	ldr	q16, [x19, 64]
	aese	v0.16b, v21.16b
	ldr	q7, [x19, 80]
	ldr	q6, [x19, 96]
	aesmc	v0.16b, v0.16b
	ldr	q5, [x19, 112]
	ldr	q4, [x19, 128]
	aese	v0.16b, v20.16b
	ldr	q3, [x19, 144]
	ldr	q2, [x19, 160]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v18.16b
	aesmc	v0.16b, v0.16b
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
	eor	v0.16b, v0.16b, v2.16b
	str	q0, [x1, x2]
	str	q0, [x3, x0]
	add	x0, x0, 16
	cmp	x0, x5
	bne	.L19
.L20:
	cmp	x6, x7
	mov	x2, x6
	beq	.L24
.L68:
	cmp	w14, 6
	add	x6, x6, 16
	bne	.L67
.L18:
	ldr	x0, [x4]
	cmp	x6, x7
	ldr	x22, [x4, 16]
	ldr	x21, [x4, 32]
	ldr	x3, [x4, 64]
	ldr	x20, [x4, 48]
	ldr	x1, [x4, 80]
	ldr	q25, [x0, x2]
	ldr	q23, [x22, x2]
	ldr	q22, [x21, x2]
	ldr	q7, [x3, x2]
	ldr	q31, [x29, 176]
	ldr	q30, [x29, 192]
	ldr	q29, [x29, 160]
	ldr	q27, [x29, 224]
	eor	v23.16b, v23.16b, v31.16b
	ldr	q26, [x19]
	eor	v22.16b, v22.16b, v30.16b
	ldr	q1, [x1, x2]
	eor	v25.16b, v25.16b, v29.16b
	ldr	q20, [x20, x2]
	eor	v7.16b, v7.16b, v27.16b
	ldr	q28, [x29, 208]
	aese	v25.16b, v26.16b
	aese	v23.16b, v26.16b
	ldr	q0, [x29, 240]
	aese	v22.16b, v26.16b
	ldr	q24, [x19, 16]
	aesmc	v25.16b, v25.16b
	aesmc	v23.16b, v23.16b
	eor	v20.16b, v20.16b, v28.16b
	aesmc	v22.16b, v22.16b
	ldr	q21, [x19, 32]
	eor	v0.16b, v1.16b, v0.16b
	orr	v1.16b, v7.16b, v7.16b
	ldr	q18, [x19, 48]
	aese	v20.16b, v26.16b
	ldr	q17, [x19, 64]
	aese	v23.16b, v24.16b
	aese	v1.16b, v26.16b
	ldr	q16, [x19, 80]
	aese	v0.16b, v26.16b
	aesmc	v7.16b, v20.16b
	orr	v20.16b, v22.16b, v22.16b
	ldr	q6, [x19, 96]
	aese	v25.16b, v24.16b
	aesmc	v1.16b, v1.16b
	ldr	q5, [x19, 112]
	aesmc	v0.16b, v0.16b
	aese	v20.16b, v24.16b
	ldr	q4, [x19, 128]
	aese	v7.16b, v24.16b
	aese	v1.16b, v24.16b
	ldr	q3, [x19, 144]
	aese	v0.16b, v24.16b
	aesmc	v22.16b, v23.16b
	ldr	q2, [x19, 160]
	aesmc	v24.16b, v25.16b
	aesmc	v20.16b, v20.16b
	aesmc	v7.16b, v7.16b
	aese	v22.16b, v21.16b
	aesmc	v1.16b, v1.16b
	orr	v23.16b, v24.16b, v24.16b
	aesmc	v0.16b, v0.16b
	aese	v20.16b, v21.16b
	aese	v7.16b, v21.16b
	aese	v23.16b, v21.16b
	aese	v1.16b, v21.16b
	aese	v0.16b, v21.16b
	aesmc	v21.16b, v22.16b
	aesmc	v23.16b, v23.16b
	aesmc	v20.16b, v20.16b
	aesmc	v7.16b, v7.16b
	aese	v21.16b, v18.16b
	aesmc	v1.16b, v1.16b
	orr	v22.16b, v23.16b, v23.16b
	aese	v20.16b, v18.16b
	aesmc	v0.16b, v0.16b
	aesmc	v21.16b, v21.16b
	aese	v22.16b, v18.16b
	aese	v7.16b, v18.16b
	aese	v1.16b, v18.16b
	aese	v0.16b, v18.16b
	aesmc	v18.16b, v20.16b
	orr	v20.16b, v21.16b, v21.16b
	aesmc	v22.16b, v22.16b
	aesmc	v7.16b, v7.16b
	aesmc	v1.16b, v1.16b
	aese	v20.16b, v17.16b
	aese	v18.16b, v17.16b
	aesmc	v0.16b, v0.16b
	aese	v22.16b, v17.16b
	aese	v7.16b, v17.16b
	aese	v1.16b, v17.16b
	aese	v0.16b, v17.16b
	aesmc	v20.16b, v20.16b
	aesmc	v17.16b, v18.16b
	aesmc	v21.16b, v22.16b
	aesmc	v7.16b, v7.16b
	orr	v18.16b, v20.16b, v20.16b
	aesmc	v1.16b, v1.16b
	aese	v17.16b, v16.16b
	aesmc	v0.16b, v0.16b
	aese	v21.16b, v16.16b
	aese	v18.16b, v16.16b
	aese	v7.16b, v16.16b
	aese	v1.16b, v16.16b
	aese	v0.16b, v16.16b
	aesmc	v16.16b, v17.16b
	aesmc	v18.16b, v18.16b
	aesmc	v20.16b, v21.16b
	aesmc	v7.16b, v7.16b
	aese	v16.16b, v6.16b
	orr	v17.16b, v18.16b, v18.16b
	aesmc	v1.16b, v1.16b
	aese	v20.16b, v6.16b
	aese	v7.16b, v6.16b
	aesmc	v16.16b, v16.16b
	aesmc	v0.16b, v0.16b
	aese	v17.16b, v6.16b
	aese	v1.16b, v6.16b
	aesmc	v18.16b, v20.16b
	aese	v0.16b, v6.16b
	aesmc	v6.16b, v7.16b
	orr	v7.16b, v16.16b, v16.16b
	aesmc	v17.16b, v17.16b
	aese	v18.16b, v5.16b
	aesmc	v1.16b, v1.16b
	aese	v7.16b, v5.16b
	aese	v17.16b, v5.16b
	aese	v6.16b, v5.16b
	aesmc	v0.16b, v0.16b
	aesmc	v7.16b, v7.16b
	aesmc	v18.16b, v18.16b
	aese	v1.16b, v5.16b
	aese	v0.16b, v5.16b
	aesmc	v16.16b, v17.16b
	aesmc	v5.16b, v6.16b
	orr	v17.16b, v18.16b, v18.16b
	orr	v6.16b, v7.16b, v7.16b
	aesmc	v1.16b, v1.16b
	aesmc	v0.16b, v0.16b
	aese	v16.16b, v4.16b
	aese	v17.16b, v4.16b
	aese	v6.16b, v4.16b
	aese	v5.16b, v4.16b
	aese	v1.16b, v4.16b
	aesmc	v17.16b, v17.16b
	aesmc	v6.16b, v6.16b
	aese	v0.16b, v4.16b
	aesmc	v7.16b, v16.16b
	aesmc	v4.16b, v5.16b
	orr	v16.16b, v17.16b, v17.16b
	orr	v5.16b, v6.16b, v6.16b
	aesmc	v1.16b, v1.16b
	aesmc	v0.16b, v0.16b
	aese	v7.16b, v3.16b
	aese	v16.16b, v3.16b
	aese	v5.16b, v3.16b
	aese	v1.16b, v3.16b
	aese	v0.16b, v3.16b
	eor	v6.16b, v7.16b, v2.16b
	aese	v4.16b, v3.16b
	eor	v16.16b, v16.16b, v2.16b
	eor	v5.16b, v5.16b, v2.16b
	eor	v1.16b, v1.16b, v2.16b
	eor	v0.16b, v0.16b, v2.16b
	str	q6, [x29, 176]
	eor	v3.16b, v4.16b, v2.16b
	str	q16, [x29, 160]
	str	q5, [x29, 192]
	str	q3, [x29, 208]
	str	q1, [x29, 224]
	str	q0, [x29, 240]
	str	q16, [x0, x2]
	ldr	x0, [x4, 16]
	str	q6, [x0, x2]
	ldr	x0, [x4, 32]
	str	q5, [x0, x2]
	ldr	x0, [x4, 48]
	str	q3, [x0, x2]
	ldr	x0, [x4, 64]
	str	q1, [x0, x2]
	ldr	x0, [x4, 80]
	str	q0, [x0, x2]
	mov	x2, x6
	bne	.L68
	.p2align 2
.L24:
	add	x15, x15, 1
	add	w18, w18, w16
	cmp	w17, w15
	bgt	.L23
.L17:
	sub	w10, w10, w12
	add	x4, x4, x12, sxtw 4
	cmp	w10, wzr
	bgt	.L4
	add	x26, x26, :lo12:__stack_chk_guard
	ldr	x1, [x29, 264]
	ldr	x0, [x26]
	eor	x0, x1, x0
	cbnz	x0, .L69
	add	sp, x29, 0
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	ldp	x29, x30, [sp], 272
	ret
.L10:
	uxth	w3, w1
	strh	w2, [x6, x5, lsl 1]
	cmp	w0, 1
	add	w17, w5, 1
	sub	w2, w3, w14
	mov	w14, w1
	strh	w2, [x8, x5, lsl 1]
	add	x5, x5, 1
	ble	.L25
	mov	w2, w0
	b	.L13
.L66:
	mov	w0, 0
.L12:
	uxth	w3, w1
	add	w17, w5, 1
	strh	w2, [x6, x5, lsl 1]
	sub	w14, w3, w14
	strh	w14, [x8, x5, lsl 1]
.L25:
	cmp	w0, 1
	bne	.L14
	ldr	w1, [x4, 8]
	sub	x0, x29, #3824
	add	x0, x0, x17, sxtw 1
	add	w17, w17, 1
	strh	w13, [x0, 3952]
	sub	w3, w1, w3
	strh	w3, [x0, 3968]
	b	.L14
.L27:
	ldr	w1, [x4, 8]
	mov	w3, 0
	mov	w17, 0
	sub	x0, x29, #3824
	add	x0, x0, x17, sxtw 1
	add	w17, w17, 1
	strh	w13, [x0, 3952]
	sub	w3, w1, w3
	strh	w3, [x0, 3968]
	b	.L14
.L69:
	bl	__stack_chk_fail
	.size	combScheduler.constprop.0, .-combScheduler.constprop.0
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
	ble	.L70
	sub	w2, w1, #5
	sub	w3, w1, #1
	lsr	w2, w2, 2
	cmp	w3, 7
	add	w2, w2, 1
	mov	x5, x0
	mov	x26, sp
	lsl	w0, w2, 2
	bls	.L83
	movi	v0.4s, 0
	add	x6, x5, 8
.L73:
	ld4	{v4.4s - v7.4s}, [x6], 64
	add	w4, w4, 1
	cmp	w4, w2
	smax	v0.4s, v0.4s, v4.4s
	bcc	.L73
	smaxv	s0, v0.4s
	cmp	w0, w1
	umov	w22, v0.s[0]
	beq	.L76
.L72:
	add	x2, x5, x0, sxtw 4
	ldr	w7, [x2, 8]
	add	w6, w0, 1
	cmp	w22, w7
	csel	w22, w22, w7, ge
	cmp	w1, w6
	ble	.L76
	ldr	w7, [x2, 24]
	add	w6, w0, 2
	cmp	w22, w7
	csel	w22, w22, w7, ge
	cmp	w1, w6
	ble	.L76
	ldr	w7, [x2, 40]
	add	w6, w0, 3
	cmp	w22, w7
	csel	w22, w22, w7, ge
	cmp	w1, w6
	ble	.L76
	ldr	w7, [x2, 56]
	add	w6, w0, 4
	cmp	w22, w7
	csel	w22, w22, w7, ge
	cmp	w1, w6
	ble	.L76
	ldr	w7, [x2, 72]
	add	w6, w0, 5
	cmp	w22, w7
	csel	w22, w22, w7, ge
	cmp	w6, w1
	bge	.L76
	ldr	w7, [x2, 88]
	add	w6, w0, 6
	cmp	w22, w7
	csel	w22, w22, w7, ge
	cmp	w1, w6
	ble	.L76
	ldr	w6, [x2, 104]
	add	w0, w0, 7
	cmp	w22, w6
	csel	w22, w22, w6, ge
	cmp	w1, w0
	ble	.L76
	ldr	w0, [x2, 120]
	cmp	w22, w0
	csel	w22, w22, w0, ge
.L76:
	cmp	w22, wzr
	ble	.L70
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
.L81:
	mov	x2, x21
	stp	xzr, xzr, [x29, 96]
	stp	xzr, xzr, [x29, 112]
	str	xzr, [x29, 128]
	.p2align 2
.L79:
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
	bne	.L79
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
.L80:
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
	bne	.L80
	mov	x0, x5
	mov	x2, x20
	mov	x1, x26
	bl	memcpy
	mov	x5, x0
	lsl	w0, w23, 3
	add	w23, w0, w23, lsl 1
	sdiv	w0, w22, w23
	cmp	w0, wzr
	bgt	.L81
.L70:
	adrp	x0, __stack_chk_guard
	add	x22, x0, :lo12:__stack_chk_guard
	ldr	x1, [x29, 136]
	ldr	x0, [x22]
	eor	x0, x1, x0
	cbnz	x0, .L91
	add	sp, x29, 0
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	ldp	x29, x30, [sp], 144
	ret
.L83:
	mov	w22, 0
	mov	w0, 0
	b	.L72
.L91:
	bl	__stack_chk_fail
	.size	radixSortDescending, .-radixSortDescending
	.align	2
	.p2align 4,,15
	.global	preComputeWindows
	.type	preComputeWindows, %function
preComputeWindows:
	cmp	w1, 1
	ble	.L99
	mov	x8, 0
	mov	w10, 0
	mov	x12, -16
	mov	x11, 8
	.p2align 2
.L97:
	add	x6, x12, x1, sxtw 4
	add	x6, x0, x6
	sub	w5, w1, #2
	ldr	w7, [x6, 8]
	add	x4, x11, x5, sxtw 4
	mov	w9, w8
	add	x4, x0, x4
	.p2align 2
.L94:
	ldr	w6, [x4]
	sub	x4, x4, #16
	cmp	w7, w6
	bne	.L102
	sub	w5, w5, #1
	cmn	w5, #1
	bne	.L94
	sbfiz	x0, x9, 1, 32
	sub	w7, w7, w10
	add	w9, w9, 1
	strh	w1, [x2, x0]
	strh	w7, [x3, x0]
.L101:
	mov	w0, w9
	ret
	.p2align 3
.L102:
	uxth	w4, w7
	strh	w1, [x2, x8, lsl 1]
	cmp	w5, 1
	add	w9, w8, 1
	sub	w1, w4, w10
	mov	w10, w7
	strh	w1, [x3, x8, lsl 1]
	add	x8, x8, 1
	mov	w1, w5
	bgt	.L97
	b	.L93
	.p2align 3
.L99:
	mov	w4, 0
	mov	w9, 0
.L93:
	cmp	w1, 1
	bne	.L101
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
	stp	x21, x22, [sp, 32]
	mov	w22, w2
	mov	x21, x4
	str	x23, [sp, 48]
	mov	x23, x3
	bl	radixSortDescending
	sxtw	x0, w22
	cmp	w20, wzr
	ldr	q19, [x21]
	lsl	x1, x0, 4
	lsl	x0, x0, 1
	add	x1, x1, 16
	add	x0, x0, 16
	sub	sp, sp, x1
	and	x0, x0, -16
	mov	x6, sp
	sub	sp, sp, x1
	mov	x5, sp
	sub	sp, sp, x0
	mov	x11, sp
	sub	sp, sp, x0
	ble	.L104
	mov	x13, -16
	mov	x12, 8
	mov	x10, sp
.L132:
	cmp	w22, w20
	csel	w14, w22, w20, le
	cmp	w14, 1
	ble	.L126
	mov	w8, w14
	mov	x9, 0
	mov	w16, 0
.L110:
	add	x4, x13, x8, sxtw 4
	add	x4, x19, x4
	sub	w1, w8, #2
	ldr	w7, [x4, 8]
	add	x0, x12, x1, sxtw 4
	mov	w15, w9
	add	x0, x19, x0
	.p2align 2
.L107:
	ldr	w4, [x0]
	sub	x0, x0, #16
	cmp	w7, w4
	bne	.L141
	sub	w1, w1, #1
	cmn	w1, #1
	bne	.L107
	sbfiz	x0, x15, 1, 32
	sub	w7, w7, w16
	add	w15, w15, 1
	strh	w8, [x11, x0]
	strh	w7, [x10, x0]
.L112:
	sub	w1, w14, #1
	mov	x0, x5
	add	x1, x1, 1
	add	x1, x5, x1, lsl 4
	.p2align 2
.L115:
	str	q19, [x0], 16
	cmp	x1, x0
	bne	.L115
.L116:
	cmp	w15, wzr
	mov	x17, 0
	mov	w30, 0
	ble	.L114
	.p2align 2
.L133:
	ldrh	w18, [x10, x17, lsl 1]
	cbz	w18, .L123
	ldrh	w16, [x11, x17, lsl 1]
	lsl	w4, w30, 4
	sub	w9, w18, #1
	sxtw	x4, w4
	add	x8, x4, 16
	add	x9, x8, x9, uxtw 4
	sub	w7, w16, #1
	cmp	w16, 6
	add	x7, x7, 1
	lsl	x7, x7, 4
	beq	.L117
	.p2align 2
.L142:
	mov	x0, 0
	cbz	w16, .L119
	.p2align 2
.L134:
	ldr	x1, [x19, x0]
	ldr	q0, [x5, x0]
	ldr	q21, [x23]
	ldr	q1, [x1, x4]
	ldr	q20, [x23, 16]
	ldr	q18, [x23, 32]
	eor	v0.16b, v1.16b, v0.16b
	ldr	q17, [x23, 48]
	ldr	q16, [x23, 64]
	aese	v0.16b, v21.16b
	ldr	q7, [x23, 80]
	ldr	q6, [x23, 96]
	aesmc	v0.16b, v0.16b
	ldr	q5, [x23, 112]
	ldr	q4, [x23, 128]
	aese	v0.16b, v20.16b
	ldr	q3, [x23, 144]
	ldr	q2, [x23, 160]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v18.16b
	aesmc	v0.16b, v0.16b
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
	eor	v0.16b, v0.16b, v2.16b
	str	q0, [x6, x0]
	str	q0, [x1, x4]
	str	q0, [x5, x0]
	add	x0, x0, 16
	cmp	x0, x7
	bne	.L134
.L119:
	cmp	x8, x9
	mov	x4, x8
	beq	.L123
.L143:
	cmp	w16, 6
	add	x8, x8, 16
	bne	.L142
.L117:
	ldr	x2, [x19, 16]
	cmp	x8, x9
	ldr	x0, [x19]
	ldr	x1, [x19, 80]
	ldr	q23, [x2, x4]
	ldr	x2, [x19, 32]
	ldr	q25, [x0, x4]
	ldr	q31, [x5, 16]
	ldr	q22, [x2, x4]
	ldr	x2, [x19, 48]
	ldr	q30, [x5, 32]
	eor	v23.16b, v23.16b, v31.16b
	ldr	q29, [x5]
	ldr	q20, [x2, x4]
	ldr	x2, [x19, 64]
	eor	v22.16b, v22.16b, v30.16b
	ldr	q27, [x5, 64]
	eor	v25.16b, v25.16b, v29.16b
	ldr	q26, [x23]
	ldr	q7, [x2, x4]
	ldr	q1, [x1, x4]
	ldr	q28, [x5, 48]
	aese	v25.16b, v26.16b
	aese	v23.16b, v26.16b
	ldr	q0, [x5, 80]
	eor	v7.16b, v7.16b, v27.16b
	aese	v22.16b, v26.16b
	ldr	q24, [x23, 16]
	aesmc	v25.16b, v25.16b
	aesmc	v23.16b, v23.16b
	eor	v20.16b, v20.16b, v28.16b
	aesmc	v22.16b, v22.16b
	ldr	q21, [x23, 32]
	eor	v0.16b, v1.16b, v0.16b
	orr	v1.16b, v7.16b, v7.16b
	ldr	q18, [x23, 48]
	aese	v20.16b, v26.16b
	ldr	q17, [x23, 64]
	aese	v23.16b, v24.16b
	aese	v0.16b, v26.16b
	ldr	q16, [x23, 80]
	aese	v1.16b, v26.16b
	aesmc	v7.16b, v20.16b
	orr	v20.16b, v22.16b, v22.16b
	ldr	q6, [x23, 96]
	aese	v25.16b, v24.16b
	aesmc	v0.16b, v0.16b
	ldr	q5, [x23, 112]
	aesmc	v1.16b, v1.16b
	aese	v20.16b, v24.16b
	ldr	q4, [x23, 128]
	aese	v7.16b, v24.16b
	aese	v0.16b, v24.16b
	ldr	q3, [x23, 144]
	aese	v1.16b, v24.16b
	aesmc	v22.16b, v23.16b
	ldr	q2, [x23, 160]
	aesmc	v24.16b, v25.16b
	aesmc	v0.16b, v0.16b
	aesmc	v20.16b, v20.16b
	aese	v22.16b, v21.16b
	aesmc	v7.16b, v7.16b
	orr	v23.16b, v24.16b, v24.16b
	aesmc	v1.16b, v1.16b
	aese	v0.16b, v21.16b
	aese	v20.16b, v21.16b
	aese	v23.16b, v21.16b
	aese	v7.16b, v21.16b
	aese	v1.16b, v21.16b
	aesmc	v21.16b, v22.16b
	aesmc	v23.16b, v23.16b
	aesmc	v20.16b, v20.16b
	aesmc	v0.16b, v0.16b
	aese	v21.16b, v18.16b
	aesmc	v7.16b, v7.16b
	orr	v22.16b, v23.16b, v23.16b
	aese	v20.16b, v18.16b
	aesmc	v1.16b, v1.16b
	aesmc	v21.16b, v21.16b
	aese	v0.16b, v18.16b
	aese	v22.16b, v18.16b
	aese	v7.16b, v18.16b
	aese	v1.16b, v18.16b
	aesmc	v18.16b, v20.16b
	orr	v20.16b, v21.16b, v21.16b
	aesmc	v0.16b, v0.16b
	aesmc	v22.16b, v22.16b
	aesmc	v7.16b, v7.16b
	aese	v20.16b, v17.16b
	aese	v18.16b, v17.16b
	aesmc	v1.16b, v1.16b
	aese	v0.16b, v17.16b
	aese	v22.16b, v17.16b
	aese	v7.16b, v17.16b
	aese	v1.16b, v17.16b
	aesmc	v20.16b, v20.16b
	aesmc	v17.16b, v18.16b
	aesmc	v0.16b, v0.16b
	aesmc	v21.16b, v22.16b
	orr	v18.16b, v20.16b, v20.16b
	aesmc	v7.16b, v7.16b
	aese	v17.16b, v16.16b
	aesmc	v1.16b, v1.16b
	aese	v0.16b, v16.16b
	aese	v21.16b, v16.16b
	aese	v18.16b, v16.16b
	aese	v7.16b, v16.16b
	aese	v1.16b, v16.16b
	aesmc	v16.16b, v17.16b
	aesmc	v18.16b, v18.16b
	aesmc	v20.16b, v21.16b
	aesmc	v7.16b, v7.16b
	aese	v16.16b, v6.16b
	orr	v17.16b, v18.16b, v18.16b
	aesmc	v0.16b, v0.16b
	aese	v20.16b, v6.16b
	aese	v7.16b, v6.16b
	aesmc	v16.16b, v16.16b
	aesmc	v1.16b, v1.16b
	aese	v0.16b, v6.16b
	aese	v17.16b, v6.16b
	aesmc	v18.16b, v20.16b
	aese	v1.16b, v6.16b
	aesmc	v6.16b, v7.16b
	orr	v7.16b, v16.16b, v16.16b
	aesmc	v17.16b, v17.16b
	aese	v18.16b, v5.16b
	aesmc	v0.16b, v0.16b
	aese	v7.16b, v5.16b
	aese	v17.16b, v5.16b
	aese	v6.16b, v5.16b
	aesmc	v1.16b, v1.16b
	aesmc	v7.16b, v7.16b
	aesmc	v18.16b, v18.16b
	aese	v0.16b, v5.16b
	aese	v1.16b, v5.16b
	aesmc	v16.16b, v17.16b
	aesmc	v5.16b, v6.16b
	orr	v17.16b, v18.16b, v18.16b
	orr	v6.16b, v7.16b, v7.16b
	aesmc	v0.16b, v0.16b
	aesmc	v1.16b, v1.16b
	aese	v16.16b, v4.16b
	aese	v17.16b, v4.16b
	aese	v6.16b, v4.16b
	aese	v5.16b, v4.16b
	aese	v0.16b, v4.16b
	aesmc	v17.16b, v17.16b
	aesmc	v6.16b, v6.16b
	aese	v1.16b, v4.16b
	aesmc	v7.16b, v16.16b
	aesmc	v4.16b, v5.16b
	orr	v16.16b, v17.16b, v17.16b
	orr	v5.16b, v6.16b, v6.16b
	aesmc	v0.16b, v0.16b
	aesmc	v1.16b, v1.16b
	aese	v7.16b, v3.16b
	aese	v16.16b, v3.16b
	aese	v5.16b, v3.16b
	aese	v0.16b, v3.16b
	aese	v1.16b, v3.16b
	eor	v6.16b, v7.16b, v2.16b
	aese	v4.16b, v3.16b
	eor	v16.16b, v16.16b, v2.16b
	eor	v5.16b, v5.16b, v2.16b
	eor	v0.16b, v0.16b, v2.16b
	eor	v1.16b, v1.16b, v2.16b
	str	q6, [x6, 16]
	eor	v3.16b, v4.16b, v2.16b
	str	q16, [x6]
	str	q5, [x6, 32]
	str	q3, [x6, 48]
	str	q1, [x6, 64]
	str	q0, [x6, 80]
	str	q16, [x5]
	str	q6, [x5, 16]
	str	q5, [x5, 32]
	str	q3, [x5, 48]
	str	q1, [x5, 64]
	str	q0, [x5, 80]
	str	q16, [x0, x4]
	ldr	x0, [x19, 16]
	str	q6, [x0, x4]
	ldr	x0, [x19, 32]
	str	q5, [x0, x4]
	ldr	x0, [x19, 48]
	str	q3, [x0, x4]
	ldr	x0, [x19, 64]
	str	q1, [x0, x4]
	ldr	x0, [x19, 80]
	str	q0, [x0, x4]
	mov	x4, x8
	bne	.L143
	.p2align 2
.L123:
	add	x17, x17, 1
	add	w30, w30, w18
	cmp	w15, w17
	bgt	.L133
.L114:
	sub	w20, w20, w14
	add	x19, x19, x14, sxtw 4
	cmp	w20, wzr
	bgt	.L132
.L104:
	add	sp, x29, 0
	ldr	x23, [sp, 48]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 64
	ret
.L141:
	uxth	w0, w7
	strh	w8, [x11, x9, lsl 1]
	cmp	w1, 1
	add	w15, w9, 1
	sub	w4, w0, w16
	mov	w16, w7
	strh	w4, [x10, x9, lsl 1]
	add	x9, x9, 1
	ble	.L106
	mov	w8, w1
	b	.L110
.L126:
	mov	w1, w14
	mov	w0, 0
	mov	w15, 0
.L106:
	cmp	w1, 1
	bne	.L111
	ldr	w7, [x19, 8]
	sbfiz	x4, x15, 1, 32
	add	w15, w15, 1
	strh	w1, [x11, x4]
	sub	w0, w7, w0
	strh	w0, [x10, x4]
.L111:
	cmp	w14, wzr
	ble	.L116
	b	.L112
	.size	combScheduler, .-combScheduler
	.section	.text.startup,"ax",%progbits
	.align	2
	.p2align 4,,15
	.global	main
	.type	main, %function
main:
	sub	sp, sp, #282624
	mov	x1, 22136
	movk	x1, 0x4, lsl 16
	sub	sp, sp, #1584
	stp	x29, x30, [sp, -80]!
	add	x29, sp, 0
	stp	x19, x20, [sp, 16]
	mov	x19, 128
	adrp	x20, __stack_chk_guard
	add	x0, x20, :lo12:__stack_chk_guard
	ldr	x2, [x0]
	str	x2, [x1, x29]
	mov	x2,0
	stp	xzr, xzr, [x29, 112]
	stp	x21, x22, [sp, 32]
	stp	x23, x24, [sp, 48]
	str	d8, [sp, 64]
	stp	xzr, xzr, [x29, 128]
	stp	xzr, xzr, [x29, 144]
	stp	xzr, xzr, [x29, 160]
	stp	xzr, xzr, [x29, 176]
	stp	xzr, xzr, [x29, 192]
	stp	xzr, xzr, [x29, 208]
	stp	xzr, xzr, [x29, 224]
	str	x19, [x29, 112]
	bl	getpid
	add	x2, x29, 112
	mov	x1, x19
	bl	sched_setaffinity
	cbnz	w0, .L757
.L145:
	adrp	x1, .LANCHOR0
	mov	x2, 176
	add	x1, x1, :lo12:.LANCHOR0
	add	x0, x29, 240
	bl	memcpy
	mov	x7, 5224
	mov	w2, 1
	mov	w6, 3
	mov	w5, 5
	strb	wzr, [x7, x29]
	mov	x7, 5225
	mov	w1, 2
	mov	w3, 7
	mov	w0, 4
	strb	w2, [x7, x29]
	mov	x7, 5227
	mov	x2, 5226
	mov	w4, 6
	strb	w6, [x7, x29]
	mov	x7, 5229
	mov	x6, 5228
	strb	w1, [x2, x29]
	mov	w1, 9
	mov	w2, 8
	strb	w5, [x7, x29]
	mov	x7, 5231
	mov	x5, 5230
	strb	w0, [x6, x29]
	mov	w6, 11
	mov	w0, 10
	strb	w3, [x7, x29]
	mov	x7, 5233
	mov	x3, 5232
	strb	w4, [x5, x29]
	mov	w5, 12
	mov	w4, 13
	strb	w1, [x7, x29]
	mov	x7, 5235
	mov	x1, 5234
	strb	w2, [x3, x29]
	mov	w3, 14
	mov	w2, 15
	strb	w6, [x7, x29]
	mov	x6, 5236
	strb	w0, [x1, x29]
	mov	w1, 1
	add	x0, x29, 80
	strb	w5, [x6, x29]
	mov	x5, 5237
	strb	w4, [x5, x29]
	mov	x4, 5238
	strb	w3, [x4, x29]
	mov	x3, 5239
	strb	w2, [x3, x29]
	bl	timespec_get
	ldp	x0, x1, [x29, 80]
	mov	x2, 5240
	add	x19, x2, x29
	add	x21, x19, 128
	eor	w0, w1, w0
	bl	srandom
	.p2align 2
.L146:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L146
	mov	x0, 40184
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1920
	.p2align 2
.L147:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L147
	mov	x0, 5368
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L148:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L148
	mov	x0, 30328
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x0, x0, 2048
	add	x21, x0, x29
	.p2align 2
.L149:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L149
	mov	x0, 42104
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x0, x0, 1920
	add	x21, x0, x29
	.p2align 2
.L150:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L150
	mov	x0, 49784
	add	x19, x0, x29
	mov	x0, 51448
	add	x21, x0, x29
	.p2align 2
.L151:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L151
	mov	x0, 32376
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L152:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L152
	mov	x0, 5496
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L153:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L153
	mov	x0, 5624
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L154:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L154
	mov	x0, 51448
	add	x19, x0, x29
	add	x21, x19, 1664
	.p2align 2
.L155:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L155
	mov	x0, 34424
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x0, x0, 2048
	add	x21, x0, x29
	.p2align 2
.L156:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L156
	mov	x0, 44024
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1920
	.p2align 2
.L157:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L157
	mov	x0, 36472
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L158:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L158
	mov	x0, 5752
	add	x19, x0, x29
	mov	x0, 5880
	add	x21, x0, x29
	.p2align 2
.L159:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L159
	mov	x0, 5880
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L160:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L160
	mov	x0, 6008
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L161:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L161
	mov	x0, 6136
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L162:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L162
	mov	x0, 6264
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L163:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L163
	mov	x0, 45944
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x0, x0, 1920
	add	x21, x0, x29
	.p2align 2
.L164:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L164
	mov	x0, 38520
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x0, x0, 2048
	add	x21, x0, x29
	.p2align 2
.L165:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L165
	mov	x0, 53112
	add	x19, x0, x29
	add	x21, x19, 1664
	.p2align 2
.L166:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L166
	mov	x0, 6392
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L167:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L167
	mov	x0, 25720
	add	x19, x0, x29
	add	x21, x19, 384
	.p2align 2
.L168:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L168
	mov	x0, 40568
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L169:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L169
	mov	x0, 6520
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L170:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L170
	mov	x0, 25848
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x0, x0, 1792
	add	x21, x0, x29
	.p2align 2
.L171:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L171
	mov	x0, 47864
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1920
	.p2align 2
.L172:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L172
	mov	x0, 54776
	add	x19, x0, x29
	mov	x0, 56440
	add	x21, x0, x29
	.p2align 2
.L173:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L173
	mov	x0, 49784
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x0, x0, 1920
	add	x21, x0, x29
	.p2align 2
.L174:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L174
	mov	x0, 6648
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L175:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L175
	mov	x0, 6776
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L176:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L176
	mov	x0, 6904
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L177:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L177
	mov	x0, 7032
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L178:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L178
	mov	x0, 56440
	add	x19, x0, x29
	add	x21, x19, 1664
	.p2align 2
.L179:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L179
	mov	x0, 7160
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L180:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L180
	mov	x0, 42616
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x0, x0, 2048
	add	x21, x0, x29
	.p2align 2
.L181:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L181
	mov	x0, 44664
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L182:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L182
	mov	x0, 39544
	add	x19, x0, x29
	add	x21, x19, 1408
	.p2align 2
.L183:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L183
	mov	x0, 46712
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x0, x0, 2048
	add	x21, x0, x29
	.p2align 2
.L184:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L184
	mov	x0, 27640
	add	x19, x0, x29
	add	x21, x19, 512
	.p2align 2
.L185:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L185
	mov	x0, 7288
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L186:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L186
	mov	x0, 27640
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1792
	.p2align 2
.L187:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L187
	mov	x0, 58104
	add	x19, x0, x29
	mov	x0, 59768
	add	x21, x0, x29
	.p2align 2
.L188:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L188
	mov	x0, 7416
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L189:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L189
	mov	x0, 7544
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L190:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L190
	mov	x0, 48760
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L191:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L191
	mov	x0, 7672
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L192:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L192
	mov	x0, 50808
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x0, x0, 2048
	add	x21, x0, x29
	.p2align 2
.L193:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L193
	mov	x0, 52856
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L194:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L194
	mov	x0, 59768
	add	x19, x0, x29
	add	x21, x19, 1664
	.p2align 2
.L195:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L195
	mov	x0, 7800
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L196:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L196
	mov	x0, 54904
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x0, x0, 2048
	add	x21, x0, x29
	.p2align 2
.L197:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L197
	mov	x0, 7928
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L198:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L198
	mov	x0, 30200
	add	x19, x0, x29
	mov	x0, 30840
	add	x21, x0, x29
	.p2align 2
.L199:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L199
	mov	x0, 8056
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L200:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L200
	mov	x0, 61432
	add	x19, x0, x29
	add	x21, x19, 1664
	.p2align 2
.L201:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L201
	mov	x0, 51704
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1920
	.p2align 2
.L202:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L202
	mov	x0, 63096
	add	x19, x0, x29
	mov	x0, 64760
	add	x21, x0, x29
	.p2align 2
.L203:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L203
	mov	x0, 8184
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L204:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L204
	mov	x0, 29432
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x0, x0, 1792
	add	x21, x0, x29
	.p2align 2
.L205:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L205
	mov	x0, 8312
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L206:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L206
	mov	x0, 56952
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L207:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L207
	mov	x0, 8440
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L208:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L208
	mov	x0, 31224
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1792
	.p2align 2
.L209:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L209
	mov	x0, 8568
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L210:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L210
	mov	x0, 8696
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L211:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L211
	mov	x0, 64760
	add	x19, x0, x29
	add	x21, x19, 1664
	.p2align 2
.L212:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L212
	mov	x0, 8824
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L213:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L213
	mov	x0, 59000
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x0, x0, 2048
	add	x21, x0, x29
	.p2align 2
.L214:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L214
	mov	x0, 61048
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L215:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L215
	mov	x0, 63096
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x0, x0, 2048
	add	x21, x0, x29
	.p2align 2
.L216:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L216
	mov	x0, 53624
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x0, x0, 1920
	add	x21, x0, x29
	.p2align 2
.L217:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L217
	mov	x0, 8952
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L218:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L218
	mov	x0, 9080
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L219:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L219
	mov	x0, 9208
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L220:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L220
	mov	x0, 9336
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L221:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L221
	mov	x0, 55544
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1920
	.p2align 2
.L222:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L222
	mov	x0, 57464
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x0, x0, 1920
	add	x21, x0, x29
	.p2align 2
.L223:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L223
	mov	x0, 9464
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L224:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L224
	mov	x0, 23160
	add	x19, x0, x29
	add	x21, x19, 256
	.p2align 2
.L225:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L225
	mov	x0, 888
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x0, x0, 1664
	add	x21, x0, x29
	.p2align 2
.L226:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L226
	mov	x0, 9592
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L227:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L227
	mov	x0, 65144
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L228:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L228
	mov	x0, 9720
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L229:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L229
	mov	x0, 9848
	add	x19, x0, x29
	mov	x0, 9976
	add	x21, x0, x29
	.p2align 2
.L230:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L230
	mov	x0, 9976
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L231:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L231
	mov	x0, 37112
	add	x19, x0, x29
	add	x21, x19, 1152
	.p2align 2
.L232:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L232
	mov	x0, 59384
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1920
	.p2align 2
.L233:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L233
	mov	x0, 61304
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x0, x0, 1920
	add	x21, x0, x29
	.p2align 2
.L234:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L234
	mov	x0, 63224
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1920
	.p2align 2
.L235:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L235
	mov	x0, 1656
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x0, x0, 2048
	add	x21, x0, x29
	.p2align 2
.L236:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L236
	mov	x0, 65144
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1920
	.p2align 2
.L237:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L237
	mov	x0, 28152
	add	x19, x0, x29
	add	x21, x19, 512
	.p2align 2
.L238:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L238
	mov	x0, 45176
	add	x19, x0, x29
	add	x21, x19, 1536
	.p2align 2
.L239:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L239
	mov	x0, 10104
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L240:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L240
	mov	x0, 10232
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L241:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L241
	mov	x0, 3704
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L242:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L242
	mov	x0, 10360
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L243:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L243
	mov	x0, 5752
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x0, x0, 2048
	add	x21, x0, x29
	.p2align 2
.L244:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L244
	mov	x0, 40952
	add	x19, x0, x29
	add	x21, x19, 1408
	.p2align 2
.L245:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L245
	mov	x0, 7800
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L246:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L246
	mov	x0, 2552
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1664
	.p2align 2
.L247:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L247
	mov	x0, 10488
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L248:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L248
	mov	x0, 23416
	add	x19, x0, x29
	add	x21, x19, 256
	.p2align 2
.L249:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L249
	mov	x0, 10616
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L250:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L250
	mov	x0, 10744
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L251:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L251
	mov	x0, 28664
	add	x19, x0, x29
	add	x21, x19, 512
	.p2align 2
.L252:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L252
	mov	x0, 4216
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x0, x0, 1664
	add	x21, x0, x29
	.p2align 2
.L253:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L253
	mov	x0, 10872
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L254:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L254
	mov	x0, 33016
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x0, x0, 1792
	add	x21, x0, x29
	.p2align 2
.L255:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L255
	mov	x0, 11000
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L256:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L256
	mov	x0, 11128
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L257:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L257
	mov	x0, 36088
	add	x19, x0, x29
	add	x21, x19, 1024
	.p2align 2
.L258:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L258
	mov	x0, 11256
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L259:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L259
	mov	x0, 5880
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1664
	.p2align 2
.L260:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L260
	mov	x0, 11384
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L261:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L261
	mov	x0, 11512
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L262:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L262
	mov	x0, 11640
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L263:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L263
	mov	x0, 7544
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1664
	.p2align 2
.L264:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L264
	mov	x0, 11768
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L265:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L265
	mov	x0, 11896
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L266:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L266
	mov	x0, 9848
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x0, x0, 2048
	add	x21, x0, x29
	.p2align 2
.L267:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L267
	mov	x0, 12024
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L268:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L268
	mov	x0, 1528
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x0, x0, 1920
	add	x21, x0, x29
	.p2align 2
.L269:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L269
	mov	x0, 12152
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L270:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L270
	mov	x0, 12280
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L271:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L271
	mov	x0, 11896
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L272:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L272
	mov	x0, 12408
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L273:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L273
	mov	x0, 12536
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L274:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L274
	mov	x0, 12664
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L275:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L275
	mov	x0, 13944
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x0, x0, 2048
	add	x21, x0, x29
	.p2align 2
.L276:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L276
	mov	x0, 12792
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L277:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L277
	mov	x0, 15992
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L278:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L278
	mov	x0, 30840
	add	x19, x0, x29
	add	x21, x19, 640
	.p2align 2
.L279:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L279
	mov	x0, 12920
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L280:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L280
	mov	x0, 13048
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L281:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L281
	mov	x0, 18040
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x0, x0, 2048
	add	x21, x0, x29
	.p2align 2
.L282:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L282
	mov	x0, 13176
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L283:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L283
	mov	x0, 13304
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L284:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L284
	mov	x0, 3448
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1920
	.p2align 2
.L285:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L285
	mov	x0, 34808
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1792
	.p2align 2
.L286:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L286
	mov	x0, 13432
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L287:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L287
	mov	x0, 42360
	add	x19, x0, x29
	mov	x0, 43768
	add	x21, x0, x29
	.p2align 2
.L288:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L288
	mov	x0, 20088
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L289:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L289
	mov	x0, 13560
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L290:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L290
	mov	x0, 22136
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x0, x0, 2048
	add	x21, x0, x29
	.p2align 2
.L291:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L291
	mov	x0, 13688
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L292:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L292
	mov	x0, 24184
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L293:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L293
	mov	x0, 9208
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x0, x0, 1664
	add	x21, x0, x29
	.p2align 2
.L294:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L294
	mov	x0, 13816
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L295:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L295
	mov	x0, 26232
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L296:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L296
	mov	x0, 13944
	add	x19, x0, x29
	mov	x0, 14072
	add	x21, x0, x29
	.p2align 2
.L297:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L297
	mov	x0, 23672
	add	x19, x0, x29
	add	x21, x19, 256
	.p2align 2
.L298:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L298
	mov	x0, 28280
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L299:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L299
	mov	x0, 14072
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L300:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L300
	mov	x0, 30328
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L301:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L301
	mov	x0, 14200
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L302:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L302
	mov	x0, 14328
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L303:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L303
	mov	x0, 26104
	add	x19, x0, x29
	mov	x0, 26488
	add	x21, x0, x29
	.p2align 2
.L304:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L304
	mov	x0, 14456
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L305:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L305
	mov	x0, 32376
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L306:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L306
	mov	x0, 14584
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L307:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L307
	mov	x0, 14712
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L308:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L308
	mov	x0, 34424
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L309:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L309
	mov	x0, 36472
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L310:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L310
	mov	x0, 5368
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x0, x0, 1920
	add	x21, x0, x29
	.p2align 2
.L311:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L311
	mov	x0, 14840
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L312:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L312
	mov	x0, 14968
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L313:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L313
	mov	x0, 15096
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L314:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L314
	mov	x0, 15224
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L315:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L315
	mov	x0, 15352
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L316:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L316
	mov	x0, 15480
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L317:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L317
	mov	x0, 15608
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L318:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L318
	mov	x0, 10872
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1664
	.p2align 2
.L319:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L319
	mov	x0, 38520
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L320:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L320
	mov	x0, 15736
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L321:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L321
	mov	x0, 40568
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L322:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L322
	mov	x0, 42616
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L323:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L323
	mov	x0, 15864
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L324:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L324
	mov	x0, 15992
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L325:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L325
	mov	x0, 12536
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x0, x0, 1664
	add	x21, x0, x29
	.p2align 2
.L326:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L326
	mov	x0, 16120
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L327:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L327
	mov	x0, 16248
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L328:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L328
	mov	x0, 16376
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L329:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L329
	mov	x0, 32120
	add	x19, x0, x29
	add	x21, x19, 768
	.p2align 2
.L330:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L330
	mov	x0, 14200
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1664
	.p2align 2
.L331:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L331
	mov	x0, 36600
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1792
	.p2align 2
.L332:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L332
	mov	x0, 15864
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1664
	.p2align 2
.L333:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L333
	mov	x0, 16504
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L334:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L334
	mov	x0, 17528
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x0, x0, 1664
	add	x21, x0, x29
	.p2align 2
.L335:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L335
	mov	x0, 16632
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L336:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L336
	mov	x0, 16760
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L337:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L337
	mov	x0, 7288
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1920
	.p2align 2
.L338:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L338
	mov	x0, 16888
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L339:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L339
	mov	x0, 17016
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L340:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L340
	mov	x0, 17144
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L341:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L341
	mov	x0, 17272
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L342:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L342
	mov	x0, 17400
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L343:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L343
	mov	x0, 44664
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L344:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L344
	mov	x0, 46712
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L345:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L345
	mov	x0, 9208
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x0, x0, 1920
	add	x21, x0, x29
	.p2align 2
.L346:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L346
	mov	x0, 17528
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L347:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L347
	mov	x0, 17656
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L348:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L348
	mov	x0, 32888
	add	x19, x0, x29
	add	x21, x19, 768
	.p2align 2
.L349:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L349
	mov	x0, 17784
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L350:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L350
	mov	x0, 48760
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L351:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L351
	mov	x0, 33656
	add	x19, x0, x29
	add	x21, x19, 768
	.p2align 2
.L352:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L352
	mov	x0, 17912
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L353:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L353
	mov	x0, 23928
	add	x19, x0, x29
	add	x21, x19, 256
	.p2align 2
.L354:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L354
	mov	x0, 26488
	add	x19, x0, x29
	add	x21, x19, 384
	.p2align 2
.L355:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L355
	mov	x0, 50808
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L356:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L356
	mov	x0, 52856
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L357:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L357
	mov	x0, 11128
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1920
	.p2align 2
.L358:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L358
	mov	x0, 54904
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L359:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L359
	mov	x0, 18040
	add	x19, x0, x29
	mov	x0, 18168
	add	x21, x0, x29
	.p2align 2
.L360:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L360
	mov	x0, 29176
	add	x19, x0, x29
	add	x21, x19, 512
	.p2align 2
.L361:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L361
	mov	x0, 56952
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L362:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L362
	mov	x0, 24184
	add	x19, x0, x29
	add	x21, x19, 256
	.p2align 2
.L363:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L363
	mov	x0, 19192
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1664
	.p2align 2
.L364:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L364
	mov	x0, 18168
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L365:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L365
	mov	x0, 59000
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L366:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L366
	mov	x0, 18296
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L367:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L367
	mov	x0, 18424
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L368:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L368
	mov	x0, 13048
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x0, x0, 1920
	add	x21, x0, x29
	.p2align 2
.L369:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L369
	mov	x0, 24440
	add	x19, x0, x29
	add	x21, x19, 256
	.p2align 2
.L370:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L370
	mov	x0, 14968
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1920
	.p2align 2
.L371:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L371
	mov	x0, 31480
	add	x19, x0, x29
	add	x21, x19, 640
	.p2align 2
.L372:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L372
	mov	x0, 18552
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L373:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L373
	mov	x0, 18680
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L374:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L374
	mov	x0, 16888
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x0, x0, 1920
	add	x21, x0, x29
	.p2align 2
.L375:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L375
	mov	x0, 61048
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L376:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L376
	mov	x0, 18808
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L377:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L377
	mov	x0, 18936
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L378:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L378
	mov	x0, 19064
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L379:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L379
	mov	x0, 18808
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1920
	.p2align 2
.L380:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L380
	mov	x0, 19192
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L381:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L381
	mov	x0, 63096
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L382:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L382
	mov	x0, 20728
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x0, x0, 1920
	add	x21, x0, x29
	.p2align 2
.L383:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L383
	mov	x0, 65144
	movk	x0, 0x3, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L384:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L384
	mov	x0, 19320
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L385:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L385
	mov	x0, 38264
	add	x19, x0, x29
	mov	x0, 39544
	add	x21, x0, x29
	.p2align 2
.L386:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L386
	mov	x0, 26872
	add	x19, x0, x29
	add	x21, x19, 384
	.p2align 2
.L387:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L387
	mov	x0, 19448
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L388:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L388
	mov	x0, 1656
	movk	x0, 0x4, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L389:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L389
	mov	x0, 35192
	add	x19, x0, x29
	add	x21, x19, 896
	.p2align 2
.L390:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L390
	mov	x0, 46712
	add	x19, x0, x29
	mov	x0, 48248
	add	x21, x0, x29
	.p2align 2
.L391:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L391
	mov	x0, 19576
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L392:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L392
	mov	x0, 3704
	movk	x0, 0x4, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L393:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L393
	mov	x0, 5752
	movk	x0, 0x4, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L394:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L394
	mov	x0, 19704
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L395:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L395
	mov	x0, 43768
	add	x19, x0, x29
	add	x21, x19, 1408
	.p2align 2
.L396:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L396
	mov	x0, 22648
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1920
	.p2align 2
.L397:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L397
	mov	x0, 7800
	movk	x0, 0x4, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L398:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L398
	mov	x0, 19832
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L399:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L399
	mov	x0, 19960
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L400:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L400
	mov	x0, 38392
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x0, x0, 1792
	add	x21, x0, x29
	.p2align 2
.L401:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L401
	mov	x0, 48248
	add	x19, x0, x29
	add	x21, x19, 1536
	.p2align 2
.L402:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L402
	mov	x0, 29688
	add	x19, x0, x29
	add	x21, x19, 512
	.p2align 2
.L403:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L403
	mov	x0, 20088
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L404:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L404
	mov	x0, 20216
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L405:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L405
	mov	x0, 20344
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L406:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L406
	mov	x0, 24696
	add	x19, x0, x29
	add	x21, x19, 256
	.p2align 2
.L407:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L407
	mov	x0, 24952
	add	x19, x0, x29
	add	x21, x19, 256
	.p2align 2
.L408:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L408
	mov	x0, 20472
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L409:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L409
	mov	x0, 9848
	movk	x0, 0x4, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L410:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L410
	mov	x0, 27256
	add	x19, x0, x29
	add	x21, x19, 384
	.p2align 2
.L411:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L411
	mov	x0, 11896
	movk	x0, 0x4, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L412:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L412
	mov	x0, 20600
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L413:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L413
	mov	x0, 24568
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x0, x0, 1920
	add	x21, x0, x29
	.p2align 2
.L414:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L414
	mov	x0, 20728
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L415:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L415
	mov	x0, 20856
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L416:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L416
	mov	x0, 13944
	movk	x0, 0x4, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L417:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L417
	mov	x0, 20984
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L418:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L418
	mov	x0, 21112
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L419:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L419
	mov	x0, 21240
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L420:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L420
	mov	x0, 26488
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1920
	.p2align 2
.L421:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L421
	mov	x0, 21368
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L422:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L422
	mov	x0, 21496
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L423:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L423
	mov	x0, 21624
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L424:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L424
	mov	x0, 15992
	movk	x0, 0x4, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L425:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L425
	mov	x0, 20856
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x0, x0, 1664
	add	x21, x0, x29
	.p2align 2
.L426:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L426
	mov	x0, 21752
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L427:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L427
	mov	x0, 21880
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L428:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L428
	mov	x0, 22008
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L429:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L429
	mov	x0, 22136
	add	x19, x0, x29
	mov	x0, 22264
	add	x21, x0, x29
	.p2align 2
.L430:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L430
	mov	x0, 28408
	movk	x0, 0x2, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1920
	.p2align 2
.L431:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L431
	mov	x0, 25208
	add	x19, x0, x29
	add	x21, x19, 256
	.p2align 2
.L432:
	bl	random
	strb	w0, [x19], 1
	cmp	x21, x19
	bne	.L432
	mov	x0, 22264
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L433:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L433
	mov	x0, 22392
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L434:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L434
	mov	x0, 22520
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1664
	.p2align 2
.L435:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L435
	mov	x0, 25464
	add	x19, x0, x29
	add	x21, x19, 256
	.p2align 2
.L436:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L436
	mov	x0, 18040
	movk	x0, 0x4, lsl 16
	add	x19, x0, x29
	add	x21, x19, 2048
	.p2align 2
.L437:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L437
	mov	x0, 22520
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L438:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L438
	mov	x0, 24184
	movk	x0, 0x1, lsl 16
	add	x19, x0, x29
	add	x21, x19, 1664
	.p2align 2
.L439:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L439
	mov	x0, 22648
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L440:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L440
	mov	x0, 34424
	add	x19, x0, x29
	mov	x0, 35192
	add	x21, x0, x29
	.p2align 2
.L441:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L441
	mov	x0, 20088
	movk	x0, 0x4, lsl 16
	add	x22, x29, x0
	mov	x19, x22
	add	x21, x22, 2048
	.p2align 2
.L442:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L442
	mov	x0, 22776
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L443:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L443
	mov	x0, 22904
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L444:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L444
	mov	x0, 23032
	add	x19, x0, x29
	add	x21, x19, 128
	.p2align 2
.L445:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x21
	bne	.L445
	mov	x0, 5240
	mov	x6, 5752
	add	x0, x0, x29
	add	x6, x6, x29
	mov	w4, 8
	mov	w1, 128
	str	x0, [x29, 424]
	mov	x0, 40184
	movk	x0, 0x1, lsl 16
	add	x0, x0, x29
	str	x6, [x29, 632]
	mov	x6, 5224
	add	x23, x6, x29
	mov	x6, 5880
	str	w1, [x29, 480]
	str	x0, [x29, 440]
	mov	x0, 42104
	movk	x0, 0x1, lsl 16
	add	x0, x0, x29
	add	x6, x6, x29
	str	w1, [x29, 528]
	mov	w2, 120
	mov	w3, 104
	str	w1, [x29, 592]
	str	x0, [x29, 488]
	mov	x0, 5368
	mov	w8, 112
	add	x0, x0, x29
	str	x6, [x29, 648]
	mov	x6, 6008
	add	x6, x6, x29
	str	w2, [x29, 448]
	mov	w11, 24
	str	x0, [x29, 456]
	mov	x0, 30328
	movk	x0, 0x2, lsl 16
	add	x0, x0, x29
	str	x6, [x29, 664]
	mov	x6, 6136
	add	x6, x6, x29
	str	w2, [x29, 496]
	mov	w12, 32
	str	x0, [x29, 472]
	mov	x0, 49784
	mov	w13, 88
	add	x0, x0, x29
	str	w3, [x29, 512]
	mov	x7, 8568
	str	w3, [x29, 576]
	add	x7, x7, x29
	mov	w9, 40
	str	x0, [x29, 504]
	mov	x0, 32376
	movk	x0, 0x2, lsl 16
	add	x0, x0, x29
	str	w2, [x29, 608]
	mov	w14, 96
	str	w1, [x29, 624]
	mov	x15, 2552
	movk	x15, 0x1, lsl 16
	str	x0, [x29, 520]
	mov	x0, 34424
	movk	x0, 0x2, lsl 16
	add	x0, x0, x29
	str	w4, [x29, 432]
	add	x15, x15, x29
	str	w4, [x29, 464]
	str	x0, [x29, 584]
	mov	x0, 5496
	add	x0, x0, x29
	str	w4, [x29, 544]
	str	w4, [x29, 560]
	str	x0, [x29, 536]
	mov	x0, 5624
	add	x0, x0, x29
	str	w4, [x29, 640]
	str	w4, [x29, 656]
	str	x0, [x29, 552]
	mov	x0, 51448
	add	x0, x0, x29
	str	w4, [x29, 672]
	str	x0, [x29, 568]
	mov	x0, 44024
	movk	x0, 0x1, lsl 16
	add	x0, x0, x29
	str	x0, [x29, 600]
	mov	x0, 45944
	movk	x0, 0x1, lsl 16
	add	x5, x0, x29
	mov	x0, 36472
	movk	x0, 0x2, lsl 16
	add	x0, x0, x29
	str	x0, [x29, 616]
	mov	x0, 38520
	movk	x0, 0x2, lsl 16
	str	x6, [x29, 680]
	add	x0, x0, x29
	mov	x6, 59768
	str	x5, [x29, 712]
	mov	x5, 6520
	add	x6, x6, x29
	add	x5, x5, x29
	str	x0, [x29, 728]
	mov	x0, 6264
	add	x0, x0, x29
	str	w2, [x29, 720]
	str	x5, [x29, 808]
	mov	x5, 25848
	movk	x5, 0x1, lsl 16
	add	x5, x5, x29
	str	x0, [x29, 696]
	mov	x0, 53112
	add	x0, x0, x29
	str	w1, [x29, 736]
	str	x5, [x29, 824]
	mov	x5, 47864
	movk	x5, 0x1, lsl 16
	add	x5, x5, x29
	str	x0, [x29, 744]
	mov	x0, 54776
	add	x0, x0, x29
	str	w3, [x29, 752]
	str	x5, [x29, 840]
	mov	x5, 49784
	movk	x5, 0x1, lsl 16
	add	x5, x5, x29
	str	x0, [x29, 856]
	mov	x0, 6392
	add	x0, x0, x29
	str	w1, [x29, 800]
	str	x5, [x29, 872]
	mov	x5, 6648
	add	x5, x5, x29
	str	x0, [x29, 760]
	mov	x0, 25720
	add	x0, x0, x29
	str	w8, [x29, 832]
	str	x5, [x29, 888]
	mov	x5, 6776
	add	x5, x5, x29
	str	x0, [x29, 776]
	mov	x0, 40568
	movk	x0, 0x2, lsl 16
	str	x5, [x29, 904]
	mov	x5, 6904
	add	x0, x0, x29
	add	x5, x5, x29
	str	w2, [x29, 848]
	str	x0, [x29, 792]
	mov	x0, 42616
	movk	x0, 0x2, lsl 16
	str	x5, [x29, 920]
	mov	x5, 7032
	add	x0, x0, x29
	add	x5, x5, x29
	str	w3, [x29, 864]
	str	w2, [x29, 880]
	str	x5, [x29, 936]
	mov	x5, 7416
	str	w4, [x29, 688]
	add	x5, x5, x29
	str	w4, [x29, 704]
	str	w4, [x29, 768]
	str	w11, [x29, 784]
	str	w4, [x29, 816]
	str	w4, [x29, 896]
	str	w4, [x29, 912]
	str	w4, [x29, 928]
	str	w4, [x29, 944]
	str	x0, [x29, 984]
	mov	x0, 56440
	add	x0, x0, x29
	str	x5, [x29, 1112]
	mov	x5, 7544
	add	x5, x5, x29
	str	w3, [x29, 960]
	str	x0, [x29, 952]
	mov	x0, 58104
	add	x0, x0, x29
	str	x5, [x29, 1128]
	mov	x5, 48760
	movk	x5, 0x2, lsl 16
	str	x0, [x29, 1096]
	mov	x0, 7160
	add	x5, x5, x29
	add	x0, x0, x29
	str	w1, [x29, 992]
	str	x5, [x29, 1144]
	mov	x5, 50808
	movk	x5, 0x2, lsl 16
	str	x0, [x29, 968]
	mov	x0, 44664
	movk	x0, 0x2, lsl 16
	add	x0, x0, x29
	add	x5, x5, x29
	str	w1, [x29, 1008]
	str	w1, [x29, 1040]
	str	x0, [x29, 1000]
	mov	x0, 46712
	movk	x0, 0x2, lsl 16
	add	x0, x0, x29
	str	x5, [x29, 1176]
	mov	x5, 7672
	add	x5, x5, x29
	str	w8, [x29, 1088]
	str	x0, [x29, 1032]
	mov	x0, 39544
	add	x0, x0, x29
	str	x5, [x29, 1160]
	mov	x5, 52856
	movk	x5, 0x2, lsl 16
	str	x0, [x29, 1016]
	mov	x0, 27640
	add	x5, x5, x29
	add	x0, x0, x29
	str	w3, [x29, 1104]
	str	w1, [x29, 1152]
	str	x0, [x29, 1048]
	mov	x0, 7288
	add	x0, x0, x29
	str	w1, [x29, 1184]
	str	w1, [x29, 1200]
	str	x0, [x29, 1064]
	mov	x0, 27640
	movk	x0, 0x1, lsl 16
	add	x0, x0, x29
	str	x5, [x29, 1192]
	mov	x5, 54904
	movk	x5, 0x2, lsl 16
	str	x0, [x29, 1080]
	mov	x0, 29432
	movk	x0, 0x1, lsl 16
	add	x0, x0, x29
	str	w4, [x29, 976]
	add	x5, x5, x29
	str	w13, [x29, 1024]
	str	w12, [x29, 1056]
	str	w4, [x29, 1072]
	str	w4, [x29, 1120]
	str	w4, [x29, 1136]
	str	w4, [x29, 1168]
	str	x6, [x29, 1208]
	str	x0, [x29, 1368]
	mov	x0, 7800
	add	x0, x0, x29
	str	x5, [x29, 1240]
	mov	x5, 8184
	add	x5, x5, x29
	str	x7, [x29, 1448]
	mov	x7, 8696
	str	x0, [x29, 1224]
	mov	x0, 7928
	add	x7, x7, x29
	add	x0, x0, x29
	str	x5, [x29, 1352]
	mov	x5, 8312
	add	x5, x5, x29
	str	w3, [x29, 1216]
	str	x0, [x29, 1256]
	mov	x0, 30200
	add	x0, x0, x29
	str	x5, [x29, 1384]
	mov	x5, 56952
	movk	x5, 0x2, lsl 16
	str	x0, [x29, 1272]
	mov	x0, 8056
	add	x5, x5, x29
	add	x0, x0, x29
	str	w1, [x29, 1248]
	str	x5, [x29, 1400]
	mov	x5, 59000
	movk	x5, 0x2, lsl 16
	str	x0, [x29, 1288]
	mov	x0, 61432
	add	x6, x5, x29
	add	x0, x0, x29
	mov	x5, 8440
	str	w9, [x29, 1280]
	add	x5, x5, x29
	str	w3, [x29, 1312]
	str	x0, [x29, 1304]
	mov	x0, 63096
	add	x0, x0, x29
	str	x5, [x29, 1416]
	mov	x5, 31224
	movk	x5, 0x1, lsl 16
	str	x0, [x29, 1336]
	mov	x0, 51704
	movk	x0, 0x1, lsl 16
	add	x0, x0, x29
	add	x5, x5, x29
	str	w2, [x29, 1328]
	str	w3, [x29, 1344]
	str	x0, [x29, 1320]
	mov	x0, 53624
	movk	x0, 0x1, lsl 16
	add	x0, x0, x29
	str	w8, [x29, 1376]
	str	w1, [x29, 1408]
	str	w8, [x29, 1440]
	str	x7, [x29, 1464]
	mov	x7, 28152
	str	x5, [x29, 1432]
	add	x7, x7, x29
	mov	x5, 33016
	movk	x5, 0x1, lsl 16
	str	w4, [x29, 1232]
	add	x5, x5, x29
	str	w4, [x29, 1264]
	str	w4, [x29, 1296]
	str	w4, [x29, 1360]
	str	w4, [x29, 1392]
	str	w4, [x29, 1424]
	str	w4, [x29, 1456]
	str	w4, [x29, 1472]
	str	x0, [x29, 1560]
	mov	x0, 64760
	add	x0, x0, x29
	str	x6, [x29, 1512]
	mov	w6, 16
	str	w3, [x29, 1488]
	str	x0, [x29, 1480]
	mov	x0, 888
	movk	x0, 0x1, lsl 16
	add	x0, x0, x29
	str	w1, [x29, 1520]
	str	w1, [x29, 1536]
	str	x0, [x29, 1704]
	mov	x0, 8824
	add	x0, x0, x29
	str	w1, [x29, 1552]
	str	w2, [x29, 1568]
	str	x0, [x29, 1496]
	mov	x0, 61048
	movk	x0, 0x2, lsl 16
	add	x0, x0, x29
	str	w2, [x29, 1648]
	str	w2, [x29, 1664]
	str	x0, [x29, 1528]
	mov	x0, 63096
	movk	x0, 0x2, lsl 16
	add	x0, x0, x29
	str	w3, [x29, 1712]
	str	w6, [x29, 1696]
	str	x0, [x29, 1544]
	mov	x0, 8952
	add	x0, x0, x29
	str	w4, [x29, 1504]
	str	w4, [x29, 1584]
	str	x0, [x29, 1576]
	mov	x0, 9080
	add	x0, x0, x29
	str	w4, [x29, 1600]
	str	w4, [x29, 1616]
	str	x0, [x29, 1592]
	mov	x0, 9208
	add	x0, x0, x29
	str	w4, [x29, 1632]
	str	w4, [x29, 1680]
	str	x0, [x29, 1608]
	mov	x0, 9336
	add	x0, x0, x29
	str	w4, [x29, 1728]
	str	x0, [x29, 1624]
	mov	x0, 55544
	movk	x0, 0x1, lsl 16
	add	x0, x0, x29
	str	x0, [x29, 1640]
	mov	x0, 57464
	movk	x0, 0x1, lsl 16
	add	x0, x0, x29
	str	x0, [x29, 1656]
	mov	x0, 9464
	add	x0, x0, x29
	str	x0, [x29, 1672]
	mov	x0, 48248
	add	x10, x0, x29
	mov	x0, 23160
	add	x0, x0, x29
	str	x0, [x29, 1688]
	mov	x0, 9592
	add	x0, x0, x29
	str	x0, [x29, 1720]
	mov	x0, 65144
	movk	x0, 0x2, lsl 16
	add	x0, x0, x29
	str	x0, [x29, 1736]
	mov	x0, 1656
	movk	x0, 0x3, lsl 16
	add	x0, x0, x29
	str	x7, [x29, 1896]
	mov	x7, 45176
	add	x7, x7, x29
	str	w1, [x29, 1744]
	str	x0, [x29, 1864]
	mov	x0, 9720
	add	x0, x0, x29
	str	x7, [x29, 1912]
	mov	x7, 10104
	add	x7, x7, x29
	str	w2, [x29, 1824]
	str	x0, [x29, 1752]
	mov	x0, 9848
	add	x0, x0, x29
	str	x7, [x29, 1928]
	mov	x7, 10232
	add	x7, x7, x29
	str	w2, [x29, 1840]
	str	x0, [x29, 1768]
	mov	x0, 9976
	add	x0, x0, x29
	str	x7, [x29, 1944]
	mov	x7, 3704
	movk	x7, 0x3, lsl 16
	str	x0, [x29, 1784]
	mov	x0, 37112
	add	x7, x7, x29
	add	x0, x0, x29
	str	w2, [x29, 1856]
	str	x7, [x29, 1960]
	mov	x7, 5752
	movk	x7, 0x3, lsl 16
	str	x0, [x29, 1800]
	mov	w0, 72
	add	x7, x7, x29
	str	w1, [x29, 1872]
	str	w0, [x29, 1808]
	mov	x0, 59384
	movk	x0, 0x1, lsl 16
	add	x0, x0, x29
	str	x7, [x29, 1992]
	mov	x7, 10360
	add	x7, x7, x29
	str	w2, [x29, 1888]
	str	x0, [x29, 1816]
	mov	x0, 61304
	movk	x0, 0x1, lsl 16
	add	x0, x0, x29
	str	w1, [x29, 1968]
	str	x7, [x29, 1976]
	mov	x7, 7800
	movk	x7, 0x3, lsl 16
	str	x0, [x29, 1832]
	mov	x0, 63224
	movk	x0, 0x1, lsl 16
	add	x0, x0, x29
	str	w4, [x29, 1760]
	add	x7, x7, x29
	str	w4, [x29, 1776]
	str	x0, [x29, 1848]
	mov	x0, 65144
	movk	x0, 0x1, lsl 16
	add	x0, x0, x29
	str	w4, [x29, 1792]
	str	w12, [x29, 1904]
	str	x0, [x29, 1880]
	mov	x0, 1528
	movk	x0, 0x2, lsl 16
	str	w14, [x29, 1920]
	add	x0, x0, x29
	str	w4, [x29, 1936]
	str	w4, [x29, 1952]
	str	w4, [x29, 1984]
	str	w1, [x29, 2000]
	str	x15, [x29, 2040]
	mov	x15, 4216
	movk	x15, 0x1, lsl 16
	add	x15, x15, x29
	str	x5, [x29, 2168]
	mov	x5, 40952
	str	x7, [x29, 2024]
	add	x5, x5, x29
	mov	x7, 9848
	movk	x7, 0x3, lsl 16
	str	x15, [x29, 2136]
	mov	x15, 10488
	add	x7, x7, x29
	add	x15, x15, x29
	str	w1, [x29, 2032]
	str	w3, [x29, 2048]
	str	x15, [x29, 2056]
	mov	x15, 23416
	add	x15, x15, x29
	str	w6, [x29, 2080]
	str	w3, [x29, 2144]
	str	x15, [x29, 2072]
	mov	x15, 10616
	add	x15, x15, x29
	str	w8, [x29, 2176]
	str	w3, [x29, 2256]
	str	x15, [x29, 2088]
	mov	x15, 10744
	add	x15, x15, x29
	str	x5, [x29, 2008]
	mov	x5, 42360
	str	w13, [x29, 2016]
	add	x5, x5, x29
	str	x15, [x29, 2104]
	mov	x15, 28664
	add	x15, x15, x29
	str	w4, [x29, 2064]
	str	w4, [x29, 2096]
	str	x15, [x29, 2120]
	mov	x15, 10872
	add	x15, x15, x29
	str	w4, [x29, 2112]
	str	w12, [x29, 2128]
	str	x15, [x29, 2152]
	mov	x15, 11000
	add	x15, x15, x29
	str	w4, [x29, 2160]
	str	w4, [x29, 2192]
	str	x15, [x29, 2184]
	mov	x15, 11128
	add	x15, x15, x29
	str	w4, [x29, 2208]
	str	w4, [x29, 2240]
	str	x15, [x29, 2200]
	mov	x15, 36088
	add	x15, x15, x29
	str	x15, [x29, 2216]
	mov	w15, 64
	str	w15, [x29, 2224]
	mov	x15, 11256
	add	x15, x15, x29
	str	x15, [x29, 2232]
	mov	x15, 5880
	movk	x15, 0x1, lsl 16
	add	x15, x15, x29
	str	x15, [x29, 2248]
	mov	x15, 11384
	add	x15, x15, x29
	str	x15, [x29, 2264]
	mov	w15, 48
	str	x7, [x29, 2360]
	mov	x7, 11768
	add	x7, x7, x29
	str	x0, [x29, 2392]
	mov	x0, 11512
	add	x0, x0, x29
	str	w3, [x29, 2320]
	str	x7, [x29, 2328]
	mov	x7, 11896
	add	x7, x7, x29
	str	x0, [x29, 2280]
	mov	x0, 11640
	add	x0, x0, x29
	str	w1, [x29, 2368]
	str	x7, [x29, 2344]
	mov	x7, 12024
	add	x7, x7, x29
	str	x0, [x29, 2296]
	mov	x0, 7544
	movk	x0, 0x1, lsl 16
	str	x7, [x29, 2376]
	mov	x7, 12152
	add	x0, x0, x29
	add	x7, x7, x29
	str	w2, [x29, 2400]
	str	w1, [x29, 2448]
	str	x7, [x29, 2408]
	mov	x7, 12280
	add	x7, x7, x29
	str	w1, [x29, 2512]
	str	x0, [x29, 2312]
	mov	x0, 9208
	movk	x0, 0x1, lsl 16
	str	x7, [x29, 2424]
	mov	x7, 11896
	movk	x7, 0x3, lsl 16
	add	x7, x7, x29
	str	w4, [x29, 2272]
	add	x0, x0, x29
	str	w4, [x29, 2288]
	str	x7, [x29, 2440]
	mov	x7, 13944
	movk	x7, 0x3, lsl 16
	add	x7, x7, x29
	str	w4, [x29, 2304]
	str	w4, [x29, 2336]
	str	x7, [x29, 2504]
	mov	x7, 12408
	add	x7, x7, x29
	str	w4, [x29, 2352]
	str	w4, [x29, 2384]
	str	x7, [x29, 2456]
	mov	x7, 12536
	add	x7, x7, x29
	str	w4, [x29, 2416]
	str	w4, [x29, 2432]
	str	x7, [x29, 2472]
	mov	x7, 12664
	add	x7, x7, x29
	str	w4, [x29, 2464]
	str	w4, [x29, 2480]
	str	x7, [x29, 2488]
	mov	x7, 12792
	add	x7, x7, x29
	str	w4, [x29, 2496]
	str	x7, [x29, 2520]
	mov	x7, 34808
	movk	x7, 0x1, lsl 16
	str	w4, [x29, 2528]
	add	x7, x7, x29
	str	x5, [x29, 2696]
	mov	x5, 15992
	movk	x5, 0x3, lsl 16
	add	x5, x5, x29
	str	x7, [x29, 2664]
	mov	x7, 13432
	add	x7, x7, x29
	str	w1, [x29, 2544]
	str	x5, [x29, 2536]
	mov	x5, 18040
	movk	x5, 0x3, lsl 16
	add	x5, x5, x29
	str	x7, [x29, 2680]
	mov	x7, 20088
	movk	x7, 0x3, lsl 16
	str	x5, [x29, 2600]
	mov	x5, 30840
	add	x7, x7, x29
	add	x5, x5, x29
	str	w9, [x29, 2560]
	str	x7, [x29, 2712]
	mov	x7, 22136
	movk	x7, 0x3, lsl 16
	str	x5, [x29, 2552]
	mov	x5, 12920
	add	x7, x7, x29
	add	x5, x5, x29
	str	w1, [x29, 2608]
	str	x7, [x29, 2744]
	mov	x7, 13560
	str	x5, [x29, 2568]
	mov	x5, 13048
	add	x7, x7, x29
	add	x5, x5, x29
	str	w2, [x29, 2656]
	str	x7, [x29, 2728]
	mov	x7, 13688
	str	x5, [x29, 2584]
	mov	x5, 13176
	add	x7, x7, x29
	add	x5, x5, x29
	str	w8, [x29, 2672]
	str	x7, [x29, 2760]
	mov	x7, 24184
	movk	x7, 0x3, lsl 16
	str	x5, [x29, 2616]
	mov	x5, 13304
	add	x7, x7, x29
	add	x5, x5, x29
	str	w1, [x29, 2720]
	str	w1, [x29, 2752]
	str	x5, [x29, 2632]
	mov	x5, 3448
	movk	x5, 0x2, lsl 16
	add	x5, x5, x29
	str	w1, [x29, 2784]
	str	x7, [x29, 2776]
	str	x5, [x29, 2648]
	mov	x5, 5368
	movk	x5, 0x2, lsl 16
	str	w4, [x29, 2576]
	add	x5, x5, x29
	str	w4, [x29, 2592]
	str	w4, [x29, 2624]
	str	w4, [x29, 2640]
	str	w4, [x29, 2688]
	str	w13, [x29, 2704]
	str	w4, [x29, 2736]
	str	w4, [x29, 2768]
	str	x0, [x29, 2792]
	mov	x0, 26232
	movk	x0, 0x3, lsl 16
	add	x0, x0, x29
	str	w3, [x29, 2800]
	str	w1, [x29, 2832]
	str	x0, [x29, 2824]
	mov	x0, 13816
	add	x0, x0, x29
	str	w6, [x29, 2864]
	str	w1, [x29, 2880]
	str	x0, [x29, 2808]
	mov	x0, 13944
	add	x0, x0, x29
	str	w1, [x29, 2912]
	str	w1, [x29, 2992]
	str	x0, [x29, 2840]
	mov	x0, 23672
	add	x0, x0, x29
	str	w1, [x29, 3040]
	str	w4, [x29, 2816]
	str	x0, [x29, 2856]
	mov	x0, 28280
	movk	x0, 0x3, lsl 16
	add	x0, x0, x29
	str	w4, [x29, 2848]
	str	w4, [x29, 2896]
	str	x0, [x29, 2872]
	mov	x0, 30328
	movk	x0, 0x3, lsl 16
	add	x0, x0, x29
	str	w4, [x29, 2928]
	str	w4, [x29, 2944]
	str	x0, [x29, 2904]
	mov	x0, 14072
	add	x0, x0, x29
	str	w11, [x29, 2960]
	str	w4, [x29, 2976]
	str	x0, [x29, 2888]
	mov	x0, 14200
	add	x0, x0, x29
	str	w4, [x29, 3008]
	str	w4, [x29, 3024]
	str	x0, [x29, 2920]
	mov	x0, 14328
	add	x0, x0, x29
	str	x0, [x29, 2936]
	mov	x0, 26104
	add	x0, x0, x29
	str	x0, [x29, 2952]
	mov	x0, 14456
	add	x0, x0, x29
	str	x0, [x29, 2968]
	mov	x0, 32376
	movk	x0, 0x3, lsl 16
	add	x0, x0, x29
	str	x0, [x29, 2984]
	mov	x0, 34424
	movk	x0, 0x3, lsl 16
	add	x0, x0, x29
	str	x0, [x29, 3032]
	mov	x0, 14584
	add	x0, x0, x29
	str	x0, [x29, 3000]
	mov	x0, 14712
	add	x0, x0, x29
	str	x0, [x29, 3016]
	mov	x0, 36472
	movk	x0, 0x3, lsl 16
	add	x0, x0, x29
	str	x0, [x29, 3048]
	mov	x0, 38520
	movk	x0, 0x3, lsl 16
	add	x0, x0, x29
	str	w1, [x29, 3056]
	str	x5, [x29, 3064]
	str	x0, [x29, 3208]
	mov	x0, 14840
	add	x0, x0, x29
	str	w2, [x29, 3072]
	str	w3, [x29, 3200]
	str	x0, [x29, 3080]
	mov	x0, 14968
	add	x0, x0, x29
	str	w1, [x29, 3216]
	str	w1, [x29, 3248]
	str	x0, [x29, 3096]
	mov	x0, 15096
	add	x0, x0, x29
	str	w1, [x29, 3264]
	str	w3, [x29, 3312]
	str	x0, [x29, 3112]
	mov	x0, 15224
	add	x0, x0, x29
	str	w4, [x29, 3088]
	str	w4, [x29, 3104]
	str	x0, [x29, 3128]
	mov	x0, 15352
	add	x0, x0, x29
	str	w4, [x29, 3120]
	str	w4, [x29, 3136]
	str	x0, [x29, 3144]
	mov	x0, 15480
	add	x0, x0, x29
	str	w4, [x29, 3152]
	str	w4, [x29, 3168]
	str	x0, [x29, 3160]
	mov	x0, 15608
	add	x0, x0, x29
	str	w4, [x29, 3184]
	str	w4, [x29, 3232]
	str	x0, [x29, 3176]
	mov	x0, 10872
	movk	x0, 0x1, lsl 16
	add	x0, x0, x29
	str	w4, [x29, 3280]
	str	w4, [x29, 3296]
	str	x0, [x29, 3192]
	mov	x0, 12536
	movk	x0, 0x1, lsl 16
	add	x0, x0, x29
	str	x0, [x29, 3304]
	mov	x0, 15736
	add	x0, x0, x29
	str	x0, [x29, 3224]
	mov	x0, 40568
	movk	x0, 0x3, lsl 16
	add	x0, x0, x29
	str	x0, [x29, 3240]
	mov	x0, 42616
	movk	x0, 0x3, lsl 16
	add	x0, x0, x29
	str	x0, [x29, 3256]
	mov	x0, 15864
	add	x0, x0, x29
	str	x0, [x29, 3272]
	mov	x0, 15992
	add	x0, x0, x29
	str	x0, [x29, 3288]
	mov	x0, 16120
	add	x0, x0, x29
	str	x0, [x29, 3320]
	mov	x0, 16248
	add	x0, x0, x29
	str	w3, [x29, 3392]
	str	w8, [x29, 3408]
	str	x0, [x29, 3336]
	mov	x0, 16376
	add	x0, x0, x29
	str	w3, [x29, 3424]
	str	w3, [x29, 3456]
	str	x0, [x29, 3352]
	mov	x0, 32120
	add	x0, x0, x29
	str	w2, [x29, 3504]
	str	w4, [x29, 3328]
	str	x0, [x29, 3368]
	mov	x0, 14200
	movk	x0, 0x1, lsl 16
	add	x0, x0, x29
	str	w4, [x29, 3344]
	str	w4, [x29, 3360]
	str	x0, [x29, 3384]
	mov	x0, 36600
	movk	x0, 0x1, lsl 16
	add	x0, x0, x29
	str	w15, [x29, 3376]
	str	w4, [x29, 3440]
	str	x0, [x29, 3400]
	mov	x0, 38392
	movk	x0, 0x1, lsl 16
	add	x7, x0, x29
	mov	x0, 15864
	movk	x0, 0x1, lsl 16
	add	x0, x0, x29
	str	w4, [x29, 3472]
	str	w4, [x29, 3488]
	str	x0, [x29, 3416]
	mov	x0, 17528
	movk	x0, 0x1, lsl 16
	add	x0, x0, x29
	str	w4, [x29, 3520]
	str	w4, [x29, 3536]
	str	x0, [x29, 3448]
	mov	x0, 16504
	add	x0, x0, x29
	str	w4, [x29, 3552]
	str	w4, [x29, 3568]
	str	x0, [x29, 3432]
	mov	x0, 16632
	add	x0, x0, x29
	str	x0, [x29, 3464]
	mov	x0, 16760
	add	x0, x0, x29
	str	x0, [x29, 3480]
	mov	x0, 7288
	movk	x0, 0x2, lsl 16
	add	x0, x0, x29
	str	x0, [x29, 3496]
	mov	x0, 16888
	add	x0, x0, x29
	str	x0, [x29, 3512]
	mov	x0, 17016
	add	x0, x0, x29
	str	x0, [x29, 3528]
	mov	x0, 33656
	add	x17, x0, x29
	mov	x0, 17912
	add	x16, x0, x29
	mov	x0, 32888
	add	x21, x0, x29
	mov	x0, 17784
	add	x19, x0, x29
	mov	x0, 48760
	movk	x0, 0x3, lsl 16
	add	x18, x0, x29
	add	x0, x0, 2048
	add	x5, x0, x29
	mov	x0, 17144
	add	x0, x0, x29
	str	x0, [x29, 3544]
	mov	x0, 17272
	add	x0, x0, x29
	str	x0, [x29, 3560]
	mov	x0, 17400
	add	x0, x0, x29
	str	x0, [x29, 3576]
	mov	x0, 9208
	movk	x0, 0x2, lsl 16
	add	x0, x0, x29
	str	w4, [x29, 3584]
	str	x5, [x29, 3784]
	mov	x5, 23928
	add	x5, x5, x29
	str	x0, [x29, 3624]
	mov	x0, 44664
	movk	x0, 0x3, lsl 16
	add	x0, x0, x29
	str	x5, [x29, 3752]
	mov	x5, 26488
	add	x5, x5, x29
	str	w1, [x29, 3600]
	str	x0, [x29, 3592]
	mov	x0, 46712
	movk	x0, 0x3, lsl 16
	add	x0, x0, x29
	str	x5, [x29, 3768]
	mov	x5, 52856
	movk	x5, 0x3, lsl 16
	add	x5, x5, x29
	str	x0, [x29, 3608]
	mov	x0, 17528
	add	x0, x0, x29
	str	w1, [x29, 3616]
	str	x5, [x29, 3800]
	mov	x5, 54904
	movk	x5, 0x3, lsl 16
	add	x5, x5, x29
	str	x0, [x29, 3640]
	mov	x0, 17656
	add	x0, x0, x29
	str	w2, [x29, 3632]
	str	x5, [x29, 3832]
	mov	x5, 11128
	movk	x5, 0x2, lsl 16
	add	x5, x5, x29
	str	x0, [x29, 3656]
	mov	x0, 18040
	add	x0, x0, x29
	str	x21, [x29, 3672]
	mov	w21, 25000
	str	x19, [x29, 3688]
	add	x19, x29, 424
	str	w1, [x29, 3712]
	str	x16, [x29, 3736]
	mov	x16, 19576
	str	w6, [x29, 3760]
	add	x16, x16, x29
	str	w1, [x29, 3792]
	str	w1, [x29, 3808]
	str	w2, [x29, 3824]
	str	w1, [x29, 3840]
	str	x5, [x29, 3816]
	str	w4, [x29, 3648]
	str	w4, [x29, 3664]
	str	w15, [x29, 3680]
	str	w4, [x29, 3696]
	str	x18, [x29, 3704]
	str	x17, [x29, 3720]
	str	w15, [x29, 3728]
	str	w4, [x29, 3744]
	str	w11, [x29, 3776]
	str	x0, [x29, 3848]
	mov	x0, 13048
	movk	x0, 0x2, lsl 16
	add	x0, x0, x29
	str	w9, [x29, 4048]
	str	w1, [x29, 3888]
	str	x0, [x29, 3992]
	mov	x0, 29176
	add	x0, x0, x29
	str	w6, [x29, 3904]
	str	w3, [x29, 3920]
	str	x0, [x29, 3864]
	mov	x0, 56952
	movk	x0, 0x3, lsl 16
	add	x0, x0, x29
	str	w1, [x29, 3952]
	str	w2, [x29, 4000]
	str	x0, [x29, 3880]
	mov	x0, 59000
	movk	x0, 0x3, lsl 16
	add	x0, x0, x29
	str	w6, [x29, 4016]
	str	w2, [x29, 4032]
	str	x0, [x29, 3944]
	mov	x0, 24184
	add	x0, x0, x29
	str	w2, [x29, 4096]
	str	w4, [x29, 3856]
	str	x0, [x29, 3896]
	mov	x0, 19192
	movk	x0, 0x1, lsl 16
	add	x0, x0, x29
	str	w12, [x29, 3872]
	str	w4, [x29, 3936]
	str	x0, [x29, 3912]
	mov	x0, 20856
	movk	x0, 0x1, lsl 16
	add	x9, x0, x29
	mov	x0, 18168
	str	w4, [x29, 3968]
	add	x0, x0, x29
	str	w4, [x29, 3984]
	str	w4, [x29, 4064]
	str	x0, [x29, 3928]
	mov	x0, 18296
	add	x0, x0, x29
	str	w4, [x29, 4080]
	str	x0, [x29, 3960]
	mov	x0, 18424
	add	x0, x0, x29
	str	x0, [x29, 3976]
	mov	x0, 24440
	add	x0, x0, x29
	str	x0, [x29, 4008]
	mov	x0, 14968
	movk	x0, 0x2, lsl 16
	add	x0, x0, x29
	str	x0, [x29, 4024]
	mov	x0, 16888
	movk	x0, 0x2, lsl 16
	add	x0, x0, x29
	str	x0, [x29, 4088]
	mov	x0, 31480
	add	x0, x0, x29
	str	x0, [x29, 4040]
	mov	x0, 34424
	add	x5, x0, x29
	mov	x0, 18552
	add	x0, x0, x29
	str	x0, [x29, 4056]
	mov	x0, 18680
	add	x0, x0, x29
	str	x0, [x29, 4072]
	mov	x0, 61048
	movk	x0, 0x3, lsl 16
	add	x0, x0, x29
	str	x0, [x29, 4104]
	mov	x0, 63096
	movk	x0, 0x3, lsl 16
	add	x0, x0, x29
	str	w1, [x29, 4112]
	str	x16, [x29, 4360]
	mov	x16, 3704
	movk	x16, 0x4, lsl 16
	str	x0, [x29, 4200]
	mov	x0, 18808
	add	x16, x16, x29
	add	x0, x0, x29
	str	w2, [x29, 4176]
	str	w1, [x29, 4208]
	str	x0, [x29, 4120]
	mov	x0, 18936
	add	x0, x0, x29
	str	w2, [x29, 4224]
	str	w1, [x29, 4240]
	str	x0, [x29, 4136]
	mov	x0, 19064
	add	x0, x0, x29
	str	w1, [x29, 4320]
	str	w4, [x29, 4128]
	str	x0, [x29, 4152]
	mov	x0, 18808
	movk	x0, 0x2, lsl 16
	add	x0, x0, x29
	str	w4, [x29, 4144]
	str	w4, [x29, 4160]
	str	x0, [x29, 4168]
	mov	x0, 20728
	movk	x0, 0x2, lsl 16
	add	x0, x0, x29
	str	w4, [x29, 4192]
	str	w4, [x29, 4256]
	str	x0, [x29, 4216]
	mov	x0, 19192
	add	x0, x0, x29
	str	w11, [x29, 4288]
	str	w4, [x29, 4304]
	str	x0, [x29, 4184]
	mov	x0, 65144
	movk	x0, 0x3, lsl 16
	add	x0, x0, x29
	str	w14, [x29, 4352]
	str	w4, [x29, 4368]
	str	x0, [x29, 4232]
	mov	x0, 1656
	movk	x0, 0x4, lsl 16
	add	x0, x0, x29
	str	x0, [x29, 4312]
	mov	x0, 19320
	add	x0, x0, x29
	str	x0, [x29, 4248]
	mov	x0, 38264
	add	x0, x0, x29
	str	x0, [x29, 4264]
	mov	x0, 35192
	add	x0, x0, x29
	str	x0, [x29, 4328]
	mov	w0, 80
	str	w0, [x29, 4272]
	mov	x0, 26872
	add	x0, x0, x29
	str	x0, [x29, 4280]
	mov	x0, 19448
	add	x0, x0, x29
	str	x0, [x29, 4296]
	mov	w0, 56
	str	w0, [x29, 4336]
	mov	x0, 46712
	add	x0, x0, x29
	str	x0, [x29, 4344]
	mov	x0, 43768
	add	x0, x0, x29
	str	x16, [x29, 4376]
	str	x10, [x29, 4520]
	mov	x10, 20088
	str	x0, [x29, 4424]
	mov	x0, 5752
	movk	x0, 0x4, lsl 16
	add	x0, x0, x29
	add	x10, x10, x29
	str	x7, [x29, 4504]
	str	w8, [x29, 4512]
	str	x0, [x29, 4392]
	mov	x0, 19704
	add	x0, x0, x29
	str	x10, [x29, 4552]
	mov	x10, 20216
	add	x10, x10, x29
	str	w1, [x29, 4384]
	str	x0, [x29, 4408]
	mov	x0, 22648
	movk	x0, 0x2, lsl 16
	add	x0, x0, x29
	str	x10, [x29, 4568]
	mov	x10, 20344
	add	x10, x10, x29
	str	w1, [x29, 4400]
	str	x0, [x29, 4440]
	mov	x0, 24568
	movk	x0, 0x2, lsl 16
	add	x7, x0, x29
	mov	x0, 7800
	movk	x0, 0x4, lsl 16
	add	x0, x0, x29
	str	x10, [x29, 4584]
	mov	x10, 24696
	add	x10, x10, x29
	str	w2, [x29, 4448]
	str	x0, [x29, 4456]
	mov	x0, 9848
	movk	x0, 0x4, lsl 16
	add	x8, x0, x29
	mov	x0, 19832
	str	x10, [x29, 4600]
	add	x0, x0, x29
	mov	x10, 24952
	str	w1, [x29, 4464]
	add	x10, x10, x29
	str	w6, [x29, 4608]
	str	x0, [x29, 4472]
	mov	x0, 19960
	add	x0, x0, x29
	str	x10, [x29, 4616]
	mov	x10, 20472
	add	x10, x10, x29
	str	w6, [x29, 4624]
	str	x0, [x29, 4488]
	mov	x0, 29688
	add	x0, x0, x29
	str	w4, [x29, 4416]
	str	w13, [x29, 4432]
	str	x0, [x29, 4536]
	mov	x0, 27256
	add	x0, x0, x29
	str	w4, [x29, 4480]
	str	w4, [x29, 4496]
	str	w14, [x29, 4528]
	str	w12, [x29, 4544]
	str	w4, [x29, 4560]
	str	w4, [x29, 4576]
	str	w4, [x29, 4592]
	str	x10, [x29, 4632]
	str	w4, [x29, 4640]
	str	x0, [x29, 4664]
	mov	x0, 11896
	movk	x0, 0x4, lsl 16
	add	x0, x0, x29
	str	x7, [x29, 4712]
	mov	x7, 21368
	add	x7, x7, x29
	str	w1, [x29, 4656]
	str	x0, [x29, 4680]
	mov	x0, 13944
	movk	x0, 0x4, lsl 16
	add	x0, x0, x29
	str	x7, [x29, 4840]
	mov	x7, 21496
	add	x7, x7, x29
	str	w1, [x29, 4688]
	str	x0, [x29, 4760]
	mov	x0, 20600
	add	x0, x0, x29
	str	x7, [x29, 4856]
	mov	x7, 21624
	add	x7, x7, x29
	str	w2, [x29, 4720]
	str	x0, [x29, 4696]
	mov	x0, 20728
	add	x0, x0, x29
	str	x7, [x29, 4872]
	mov	x7, 15992
	movk	x7, 0x4, lsl 16
	str	x0, [x29, 4728]
	mov	x0, 20856
	add	x7, x7, x29
	add	x0, x0, x29
	str	w1, [x29, 4768]
	str	w2, [x29, 4832]
	str	x0, [x29, 4744]
	mov	x0, 20984
	add	x0, x0, x29
	str	w1, [x29, 4896]
	str	x8, [x29, 4648]
	str	x0, [x29, 4776]
	mov	x0, 21112
	add	x0, x0, x29
	str	w11, [x29, 4672]
	str	w4, [x29, 4704]
	str	x0, [x29, 4792]
	mov	x0, 21240
	add	x0, x0, x29
	str	w4, [x29, 4736]
	str	w4, [x29, 4752]
	str	x0, [x29, 4808]
	mov	x0, 26488
	movk	x0, 0x2, lsl 16
	add	x0, x0, x29
	str	w4, [x29, 4784]
	str	w4, [x29, 4800]
	str	x0, [x29, 4824]
	mov	x0, 28408
	movk	x0, 0x2, lsl 16
	add	x0, x0, x29
	str	w4, [x29, 4816]
	str	w4, [x29, 4848]
	str	w4, [x29, 4864]
	str	w4, [x29, 4880]
	str	x7, [x29, 4888]
	str	x9, [x29, 4904]
	str	x0, [x29, 4984]
	mov	x0, 18040
	movk	x0, 0x4, lsl 16
	add	x0, x0, x29
	str	w2, [x29, 4992]
	mov	x2, 22776
	str	w6, [x29, 5008]
	str	x0, [x29, 5080]
	mov	x0, 22648
	add	x0, x0, x29
	str	w6, [x29, 5072]
	add	x6, x2, x29
	str	w3, [x29, 4912]
	str	x0, [x29, 5128]
	mov	x0, 21752
	add	x0, x0, x29
	str	w3, [x29, 5056]
	str	w3, [x29, 5120]
	str	x0, [x29, 4920]
	mov	x0, 21880
	add	x0, x0, x29
	str	x5, [x29, 5144]
	str	w1, [x29, 5088]
	str	x0, [x29, 4936]
	mov	x0, 22008
	add	x2, x0, x29
	mov	x0, 22136
	str	x22, [x29, 5160]
	add	x0, x0, x29
	str	w4, [x29, 4928]
	add	x22, x29, 240
	str	x2, [x29, 4952]
	mov	x2, 25208
	add	x2, x2, x29
	str	x0, [x29, 4968]
	mov	x0, 22264
	str	w4, [x29, 4944]
	str	x2, [x29, 5000]
	add	x2, x0, x29
	mov	x0, 22392
	add	x0, x0, x29
	str	w4, [x29, 4960]
	str	x2, [x29, 5016]
	mov	x2, 24184
	movk	x2, 0x1, lsl 16
	str	x0, [x29, 5032]
	mov	x0, 22520
	movk	x0, 0x1, lsl 16
	add	x3, x0, x29
	mov	x0, 25464
	str	w4, [x29, 4976]
	add	x0, x0, x29
	add	x2, x2, x29
	str	w4, [x29, 5024]
	str	x3, [x29, 5048]
	str	x0, [x29, 5064]
	mov	x0, 22520
	add	x3, x0, x29
	mov	x0, 22904
	str	x2, [x29, 5112]
	add	x5, x0, x29
	mov	x0, 23032
	str	w4, [x29, 5040]
	add	x0, x0, x29
	str	x3, [x29, 5096]
	adrp	x2, .LC2
	add	x2, x2, :lo12:.LC2
	str	w4, [x29, 5104]
	mov	w3, 16896
	movk	w3, 0x4, lsl 16
	str	w4, [x29, 5136]
	str	w15, [x29, 5152]
	str	w1, [x29, 5168]
	adrp	x1, .LC3
	str	x0, [x29, 5208]
	add	x1, x1, :lo12:.LC3
	mov	w0, 1
	str	x6, [x29, 5176]
	str	w4, [x29, 5184]
	str	x5, [x29, 5192]
	str	w4, [x29, 5200]
	str	w4, [x29, 5216]
	bl	__printf_chk
	.p2align 2
.L446:
	mov	x2, x23
	mov	x1, x22
	mov	x0, x19
	bl	combScheduler.constprop.0
	subs	w21, w21, #1
	bne	.L446
	mov	x1, 0
	add	x0, x29, 96
	bl	gettimeofday
	ldp	x0, x1, [x29, 96]
	adrp	x24, start_clk
	mov	w21, 34464
	movk	w21, 0x1, lsl 16
	ldr	d8, .LC4
	scvtf	d0, x0
	scvtf	d1, x1
	fmadd	d0, d0, d8, d1
	fcvtzu	x0, d0
	str	x0, [x24, #:lo12:start_clk]
	.p2align 2
.L447:
	mov	x2, x23
	mov	x1, x22
	mov	x0, x19
	bl	combScheduler.constprop.0
	subs	w21, w21, #1
	bne	.L447
	mov	x1, 0
	add	x0, x29, 96
	bl	gettimeofday
	ldp	x0, x3, [x29, 96]
	adrp	x4, total_clk
	adrp	x5, end_clk
	adrp	x1, .LC8
	add	x1, x1, :lo12:.LC8
	ldr	x2, [x24, #:lo12:start_clk]
	mov	w21, 0
	ldr	d1, .LC5
	scvtf	d3, x3
	scvtf	d2, x0
	mov	w0, 1
	ldr	d4, .LC6
	ldr	d0, .LC7
	fmadd	d2, d2, d8, d3
	fcvtzu	x3, d2
	sub	x2, x3, x2
	str	x3, [x5, #:lo12:end_clk]
	ucvtf	d2, x2
	fmul	d1, d2, d1
	fdiv	d1, d1, d4
	fdiv	d0, d1, d0
	str	d1, [x4, #:lo12:total_clk]
	bl	__printf_chk
	add	x1, x29, 1664
	mov	x0, x19
	add	x4, x1, 3560
	.p2align 2
.L448:
	ldr	x3, [x0]
	add	x0, x0, 16
	ldr	w2, [x0, -8]
	cmp	x4, x0
	ldrb	w1, [x3]
	lsl	w2, w2, 4
	add	x2, x3, x2, sxtw
	ldrb	w2, [x2, -1]
	eor	w1, w2, w1
	uxtb	w1, w1
	eor	w21, w21, w1
	bne	.L448
	adrp	x1, .LC9
	mov	w2, w21
	add	x1, x1, :lo12:.LC9
	mov	w0, 1
	bl	__printf_chk
	add	x20, x20, :lo12:__stack_chk_guard
	mov	x1, 22136
	movk	x1, 0x4, lsl 16
	ldr	x2, [x1, x29]
	ldr	x1, [x20]
	eor	x1, x2, x1
	mov	w0, w21
	cbnz	x1, .L758
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldr	d8, [sp, 64]
	ldp	x29, x30, [sp], 80
	add	sp, sp, 282624
	add	sp, sp, 1584
	ret
.L757:
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	perror
	b	.L145
.L758:
	bl	__stack_chk_fail
	.size	main, .-main
	.align	3
.LC4:
	.word	0
	.word	1093567616
	.align	3
.LC5:
	.word	0
	.word	1084254208
	.align	3
.LC6:
	.word	0
	.word	1090021888
	.align	3
.LC7:
	.word	0
	.word	1091635200
	.comm	total_clk,8,8
	.comm	end_clk,8,8
	.comm	start_clk,8,8
	.section	.rodata
	.align	4
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
	.string	"setaffinity"
	.zero	4
.LC2:
	.string	"AES-CBC-COMP-P6"
.LC3:
	.string	"%s-%d: "
.LC8:
	.string	"%g cpb\n"
.LC9:
	.string	"\n\nterminated with code %d\n"
	.ident	"GCC: (Ubuntu 5.2.1-22ubuntu1) 5.2.1 20151010"
	.section	.note.GNU-stack,"",%progbits
