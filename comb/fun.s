	.cpu cortex-a57+fp+simd+crypto+crc
	.file	"fun.c"
	.text
	.align	2
	.p2align 4,,15
	.type	combScheduler.constprop.0, %function
combScheduler.constprop.0:
	mov	x5, x0
	stp	x29, x30, [sp, -176]!
	add	x29, sp, 0
	add	x6, x5, 8
	movi	v0.4s, 0
	add	x10, x5, 72
	add	x9, x5, 136
	stp	x19, x20, [sp, 16]
	ld4	{v4.4s - v7.4s}, [x6]
	add	x8, x5, 200
	add	x7, x5, 264
	adrp	x20, __stack_chk_guard
	add	x0, x20, :lo12:__stack_chk_guard
	stp	x21, x22, [sp, 32]
	mov	x4, x2
	add	x2, x5, 392
	stp	x27, x28, [sp, 80]
	mov	x19, x1
	add	x1, x5, 456
	stp	x23, x24, [sp, 48]
	mov	x28, sp
	stp	x25, x26, [sp, 64]
	sub	sp, sp, #608
	ldr	x3, [x0]
	str	x3, [x29, 168]
	mov	x3,0
	add	x0, x5, 520
	ldr	w21, [x5, 584]
	add	x3, x5, 328
	smax	v0.4s, v4.4s, v0.4s
	ld4	{v4.4s - v7.4s}, [x10]
	smax	v0.4s, v0.4s, v4.4s
	ld4	{v4.4s - v7.4s}, [x9]
	smax	v0.4s, v0.4s, v4.4s
	ld4	{v4.4s - v7.4s}, [x8]
	smax	v0.4s, v0.4s, v4.4s
	ld4	{v4.4s - v7.4s}, [x7]
	smax	v0.4s, v0.4s, v4.4s
	ld4	{v4.4s - v7.4s}, [x3]
	smax	v0.4s, v0.4s, v4.4s
	ld4	{v4.4s - v7.4s}, [x2]
	smax	v0.4s, v0.4s, v4.4s
	ld4	{v4.4s - v7.4s}, [x1]
	smax	v0.4s, v0.4s, v4.4s
	ld4	{v4.4s - v7.4s}, [x0]
	smax	v0.4s, v0.4s, v4.4s
	smaxv	s0, v0.4s
	umov	w0, v0.s[0]
	cmp	w0, w21
	csel	w21, w0, w21, ge
	cmp	w21, wzr
	ble	.L7
	mov	w24, 26215
	movk	w24, 0x6666, lsl 16
	mov	x25, sp
	mov	w22, 1
	add	x27, x5, 600
	add	x7, x5, 584
	sub	x26, x5, #8
	mov	w23, 9
.L6:
	mov	x2, x6
	stp	xzr, xzr, [x29, 128]
	stp	xzr, xzr, [x29, 144]
	str	xzr, [x29, 160]
.L4:
	ldr	w0, [x2], 16
	sdiv	w0, w0, w22
	cmp	x2, x27
	smull	x1, w0, w24
	asr	x1, x1, 34
	sub	w1, w1, w0, asr 31
	lsl	w3, w1, 3
	add	w1, w3, w1, lsl 1
	sub	w0, w0, w1
	add	x1, x29, 176
	sub	w0, w23, w0
	add	x0, x1, x0, sxtw 2
	ldr	w1, [x0, -48]
	add	w1, w1, 1
	str	w1, [x0, -48]
	bne	.L4
	ldp	w13, w14, [x29, 128]
	mov	x8, x7
	ldp	w11, w10, [x29, 136]
	ldp	w9, w3, [x29, 144]
	add	w13, w14, w13
	ldp	w2, w1, [x29, 152]
	add	w11, w13, w11
	ldp	w0, w12, [x29, 160]
	add	w10, w11, w10
	add	w9, w10, w9
	stp	w13, w11, [x29, 132]
	add	w3, w9, w3
	add	w2, w3, w2
	stp	w10, w9, [x29, 140]
	add	w1, w2, w1
	add	w0, w1, w0
	stp	w3, w2, [x29, 148]
	add	w12, w12, w0
	stp	w1, w0, [x29, 156]
	str	w12, [x29, 164]
.L5:
	mov	x1, x8
	sub	x8, x8, #16
	ldr	w0, [x1], -8
	cmp	x8, x26
	sdiv	w0, w0, w22
	ldp	x2, x3, [x1]
	smull	x1, w0, w24
	asr	x1, x1, 34
	sub	w1, w1, w0, asr 31
	lsl	w9, w1, 3
	add	w1, w9, w1, lsl 1
	sub	w0, w0, w1
	add	x1, x29, 176
	sub	w0, w23, w0
	add	x0, x1, x0, sxtw 2
	ldr	w1, [x0, -48]
	sub	w1, w1, #1
	add	x9, x25, x1, sxtw 4
	stp	x2, x3, [x9]
	str	w1, [x0, -48]
	bne	.L5
	mov	x0, x5
	mov	x2, 592
	stp	x7, x4, [x29, 104]
	mov	x1, x25
	str	x6, [x29, 120]
	bl	memcpy
	mov	x5, x0
	lsl	w0, w22, 3
	ldp	x7, x4, [x29, 104]
	add	w22, w0, w22, lsl 1
	ldr	x6, [x29, 120]
	sdiv	w0, w21, w22
	cmp	w0, wzr
	bgt	.L6
.L7:
	ldr	q19, [x4]
	mov	w18, 37
	mov	w22, 6
	mov	sp, x28
	mov	w21, 1
	mov	x17, -16
.L3:
	cmp	w18, 6
	csel	w16, w18, w22, le
	sxtw	x30, w16
	mov	x23, sp
	cmp	w16, 1
	lsl	x0, x30, 1
	add	x0, x0, 16
	and	x0, x0, -16
	sub	sp, sp, x0
	mov	x15, sp
	sub	sp, sp, x0
	mov	x14, sp
	beq	.L23
	mov	w1, w16
	mov	x4, 0
	mov	w7, 0
.L11:
	add	x2, x17, x1, sxtw 4
	add	x2, x5, x2
	sub	w0, w1, #2
	ldr	w2, [x2, 8]
	add	x3, x5, x0, sxtw 4
	ldr	w6, [x3, 8]
	cmp	w2, w6
	bne	.L9
	sub	w0, w1, #3
	cmn	w0, #1
	beq	.L10
	ldr	w6, [x3, -8]
	cmp	w2, w6
	bne	.L9
	sub	w0, w1, #4
	cmn	w0, #1
	beq	.L10
	ldr	w6, [x3, -24]
	cmp	w2, w6
	bne	.L9
	sub	w0, w1, #5
	cmn	w0, #1
	beq	.L10
	ldr	w6, [x3, -40]
	cmp	w2, w6
	bne	.L9
	cmp	w1, 6
	bne	.L10
	ldr	w0, [x3, -56]
	cmp	w2, w0
	bne	.L62
.L10:
	uxth	w3, w2
	add	w13, w4, 1
	strh	w1, [x15, x4, lsl 1]
	sub	w3, w3, w7
	strh	w3, [x14, x4, lsl 1]
.L12:
	lsl	x30, x30, 4
	cmp	w16, 1
	add	x0, x30, 16
	sub	sp, sp, x0
	mov	x6, sp
	sub	sp, sp, x0
	mov	x3, sp
	str	q19, [sp]
	beq	.L13
	str	q19, [sp, 16]
	cmp	w16, 2
	beq	.L13
	str	q19, [sp, 32]
	cmp	w16, 3
	beq	.L13
	str	q19, [sp, 48]
	cmp	w16, 4
	beq	.L13
	str	q19, [sp, 64]
	cmp	w16, 6
	bne	.L13
	str	q19, [sp, 80]
.L13:
	mov	x10, 0
	mov	w12, 0
	cbz	w13, .L15
.L42:
	ldrh	w11, [x14, x10, lsl 1]
	cbz	w11, .L17
	ldrh	w9, [x15, x10, lsl 1]
	lsl	w2, w12, 4
	sub	w8, w11, #1
	sxtw	x2, w2
	add	x7, x2, 16
	add	x8, x7, x8, uxtw 4
	sub	w4, w9, #1
	add	x4, x4, 1
	lsl	x4, x4, 4
	.p2align 2
.L20:
	mov	x0, 0
	cbz	w9, .L18
	.p2align 2
.L43:
	ldr	x1, [x5, x0]
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
	str	q0, [x6, x0]
	str	q0, [x1, x2]
	str	q0, [x3, x0]
	add	x0, x0, 16
	cmp	x0, x4
	bne	.L43
.L18:
	cmp	x7, x8
	mov	x2, x7
	beq	.L17
	add	x7, x7, 16
	b	.L20
.L17:
	add	x10, x10, 1
	add	w12, w12, w11
	cmp	w13, w10
	bgt	.L42
.L15:
	sub	w18, w18, w16
	add	x5, x5, x30
	cmp	w18, wzr
	mov	sp, x23
	bgt	.L3
	add	x20, x20, :lo12:__stack_chk_guard
	ldr	x1, [x29, 168]
	ldr	x0, [x20]
	eor	x0, x1, x0
	cbnz	x0, .L63
	add	sp, x29, 0
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	ldp	x29, x30, [sp], 176
	ret
.L62:
	mov	w0, 0
.L9:
	uxth	w3, w2
	strh	w1, [x15, x4, lsl 1]
	cmp	w0, 1
	add	w13, w4, 1
	sub	w1, w3, w7
	mov	w7, w2
	strh	w1, [x14, x4, lsl 1]
	add	x4, x4, 1
	ble	.L64
	mov	w1, w0
	b	.L11
.L23:
	mov	w3, 0
	mov	w13, 0
.L8:
	ldr	w1, [x5, 8]
	sbfiz	x0, x13, 1, 32
	add	w13, w13, 1
	strh	w21, [x15, x0]
	sub	w3, w1, w3
	strh	w3, [x14, x0]
	b	.L12
.L63:
	bl	__stack_chk_fail
.L64:
	bne	.L12
	b	.L8
	.size	combScheduler.constprop.0, .-combScheduler.constprop.0
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
	adrp	x21, .LC3
	add	x21, x21, :lo12:.LC3
	adrp	x22, stdout
	.p2align 2
.L66:
	ldrb	w2, [x20]
	mov	x1, x21
	mov	w0, 1
	bl	__printf_chk
	add	w19, w19, 1
	add	x20, x20, 1
	cmp	w19, 16
	mov	w0, 32
	and	w1, w19, 3
	beq	.L70
	cbnz	w1, .L66
	ldr	x1, [x22, #:lo12:stdout]
	bl	_IO_putc
	b	.L66
	.p2align 3
.L70:
	ldr	x1, [x22, #:lo12:stdout]
	mov	w0, 10
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 48
	b	_IO_putc
	.size	printblock, .-printblock
	.align	2
	.p2align 4,,15
	.global	aes_cbc
	.type	aes_cbc, %function
aes_cbc:
	cmp	w1, wzr
	ble	.L71
	mov	x6, 24
	sub	w1, w1, #1
	add	x1, x6, x1, uxtw 4
	add	x5, x0, 8
	add	x6, x0, x1
	.p2align 2
.L74:
	ldr	w4, [x5]
	mov	x0, 0
	mov	w1, 0
	ldr	q0, [x3]
	cmp	w4, wzr
	ble	.L77
	.p2align 2
.L78:
	ldr	x4, [x5, -8]
	add	w1, w1, 1
	ldr	q20, [x2]
	ldr	q19, [x2, 16]
	ldr	q1, [x4, x0]
	ldr	q18, [x2, 32]
	ldr	q17, [x2, 48]
	eor	v0.16b, v1.16b, v0.16b
	ldr	q16, [x2, 64]
	ldr	q7, [x2, 80]
	aese	v0.16b, v20.16b
	ldr	q6, [x2, 96]
	ldr	q5, [x2, 112]
	aesmc	v0.16b, v0.16b
	ldr	q4, [x2, 128]
	ldr	q3, [x2, 144]
	aese	v0.16b, v19.16b
	ldr	q2, [x2, 160]
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
	str	q0, [x4, x0]
	add	x0, x0, 16
	ldr	w4, [x5]
	cmp	w4, w1
	bgt	.L78
.L77:
	add	x5, x5, 16
	cmp	x6, x5
	bne	.L74
	ret
.L71:
	ret
	.size	aes_cbc, .-aes_cbc
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
	ble	.L81
	sub	w2, w1, #5
	sub	w3, w1, #1
	lsr	w2, w2, 2
	cmp	w3, 7
	add	w2, w2, 1
	mov	x5, x0
	mov	x26, sp
	lsl	w0, w2, 2
	bls	.L94
	movi	v0.4s, 0
	add	x6, x5, 8
.L84:
	ld4	{v4.4s - v7.4s}, [x6], 64
	add	w4, w4, 1
	cmp	w4, w2
	smax	v0.4s, v0.4s, v4.4s
	bcc	.L84
	smaxv	s0, v0.4s
	cmp	w0, w1
	umov	w22, v0.s[0]
	beq	.L87
.L83:
	add	x2, x5, x0, sxtw 4
	ldr	w7, [x2, 8]
	add	w6, w0, 1
	cmp	w22, w7
	csel	w22, w22, w7, ge
	cmp	w1, w6
	ble	.L87
	ldr	w7, [x2, 24]
	add	w6, w0, 2
	cmp	w22, w7
	csel	w22, w22, w7, ge
	cmp	w1, w6
	ble	.L87
	ldr	w7, [x2, 40]
	add	w6, w0, 3
	cmp	w22, w7
	csel	w22, w22, w7, ge
	cmp	w1, w6
	ble	.L87
	ldr	w7, [x2, 56]
	add	w6, w0, 4
	cmp	w22, w7
	csel	w22, w22, w7, ge
	cmp	w1, w6
	ble	.L87
	ldr	w7, [x2, 72]
	add	w6, w0, 5
	cmp	w22, w7
	csel	w22, w22, w7, ge
	cmp	w6, w1
	bge	.L87
	ldr	w7, [x2, 88]
	add	w6, w0, 6
	cmp	w22, w7
	csel	w22, w22, w7, ge
	cmp	w1, w6
	ble	.L87
	ldr	w6, [x2, 104]
	add	w0, w0, 7
	cmp	w22, w6
	csel	w22, w22, w6, ge
	cmp	w1, w0
	ble	.L87
	ldr	w0, [x2, 120]
	cmp	w22, w0
	csel	w22, w22, w0, ge
.L87:
	cmp	w22, wzr
	ble	.L81
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
.L92:
	mov	x2, x21
	stp	xzr, xzr, [x29, 96]
	stp	xzr, xzr, [x29, 112]
	str	xzr, [x29, 128]
	.p2align 2
.L90:
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
	bne	.L90
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
.L91:
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
	bne	.L91
	mov	x0, x5
	mov	x2, x20
	mov	x1, x26
	bl	memcpy
	mov	x5, x0
	lsl	w0, w23, 3
	add	w23, w0, w23, lsl 1
	sdiv	w0, w22, w23
	cmp	w0, wzr
	bgt	.L92
.L81:
	adrp	x0, __stack_chk_guard
	add	x22, x0, :lo12:__stack_chk_guard
	ldr	x1, [x29, 136]
	ldr	x0, [x22]
	eor	x0, x1, x0
	cbnz	x0, .L102
	add	sp, x29, 0
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	ldp	x29, x30, [sp], 144
	ret
.L94:
	mov	w22, 0
	mov	w0, 0
	b	.L83
.L102:
	bl	__stack_chk_fail
	.size	radixSortDescending, .-radixSortDescending
	.align	2
	.p2align 4,,15
	.global	preComputeWindows
	.type	preComputeWindows, %function
preComputeWindows:
	cmp	w1, 1
	ble	.L110
	mov	x8, 0
	mov	w10, 0
	mov	x12, -16
	mov	x11, 8
	.p2align 2
.L108:
	add	x6, x12, x1, sxtw 4
	add	x6, x0, x6
	sub	w5, w1, #2
	ldr	w7, [x6, 8]
	add	x4, x11, x5, sxtw 4
	mov	w9, w8
	add	x4, x0, x4
	.p2align 2
.L105:
	ldr	w6, [x4]
	sub	x4, x4, #16
	cmp	w7, w6
	bne	.L113
	sub	w5, w5, #1
	cmn	w5, #1
	bne	.L105
	sbfiz	x0, x9, 1, 32
	sub	w7, w7, w10
	add	w9, w9, 1
	strh	w1, [x2, x0]
	strh	w7, [x3, x0]
.L112:
	mov	w0, w9
	ret
	.p2align 3
.L113:
	uxth	w4, w7
	strh	w1, [x2, x8, lsl 1]
	cmp	w5, 1
	add	w9, w8, 1
	sub	w1, w4, w10
	mov	w10, w7
	strh	w1, [x3, x8, lsl 1]
	add	x8, x8, 1
	mov	w1, w5
	bgt	.L108
	b	.L104
	.p2align 3
.L110:
	mov	w4, 0
	mov	w9, 0
.L104:
	cmp	w1, 1
	bne	.L112
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
	mov	w24, w2
	mov	x23, x3
	stp	x21, x22, [sp, 32]
	mov	x21, x4
	bl	radixSortDescending
	cmp	w20, wzr
	ldr	q19, [x21]
	ble	.L115
	mov	x13, -16
	mov	x12, 8
.L140:
	cmp	w24, w20
	csel	w14, w24, w20, le
	sxtw	x30, w14
	mov	x15, sp
	cmp	w14, 1
	lsl	x0, x30, 1
	add	x0, x0, 16
	and	x0, x0, -16
	sub	sp, sp, x0
	mov	x11, sp
	sub	sp, sp, x0
	mov	x10, sp
	ble	.L135
	mov	w6, w14
	mov	x7, 0
	mov	w8, 0
.L121:
	add	x4, x13, x6, sxtw 4
	add	x4, x19, x4
	sub	w1, w6, #2
	ldr	w5, [x4, 8]
	add	x0, x12, x1, sxtw 4
	mov	w18, w7
	add	x0, x19, x0
	.p2align 2
.L118:
	ldr	w4, [x0]
	sub	x0, x0, #16
	cmp	w5, w4
	bne	.L149
	sub	w1, w1, #1
	cmn	w1, #1
	bne	.L118
	sbfiz	x0, x18, 1, 32
	sub	w5, w5, w8
	lsl	x30, x30, 4
	add	w18, w18, 1
	strh	w5, [x10, x0]
	strh	w6, [x11, x0]
	add	x0, x30, 16
	sub	sp, sp, x0
	mov	x7, sp
	sub	sp, sp, x0
	mov	x5, sp
.L123:
	sub	w1, w14, #1
	mov	x0, x5
	add	x1, x1, 1
	add	x1, x5, x1, lsl 4
.L126:
	str	q19, [x0], 16
	cmp	x0, x1
	bne	.L126
.L127:
	cmp	w18, wzr
	mov	x17, 0
	mov	w22, 0
	ble	.L125
.L141:
	ldrh	w21, [x10, x17, lsl 1]
	cbz	w21, .L129
	ldrh	w16, [x11, x17, lsl 1]
	lsl	w4, w22, 4
	sub	w9, w21, #1
	sxtw	x4, w4
	add	x8, x4, 16
	add	x9, x8, x9, uxtw 4
	sub	w6, w16, #1
	add	x6, x6, 1
	lsl	x6, x6, 4
	.p2align 2
.L132:
	mov	x0, 0
	cbz	w16, .L130
	.p2align 2
.L142:
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
	str	q0, [x7, x0]
	str	q0, [x1, x4]
	str	q0, [x5, x0]
	add	x0, x0, 16
	cmp	x6, x0
	bne	.L142
.L130:
	cmp	x8, x9
	mov	x4, x8
	beq	.L129
	add	x8, x8, 16
	b	.L132
.L129:
	add	x17, x17, 1
	add	w22, w22, w21
	cmp	w18, w17
	bgt	.L141
.L125:
	sub	w20, w20, w14
	add	x19, x19, x30
	cmp	w20, wzr
	mov	sp, x15
	bgt	.L140
.L115:
	add	sp, x29, 0
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp], 64
	ret
.L149:
	uxth	w0, w5
	strh	w6, [x11, x7, lsl 1]
	cmp	w1, 1
	add	w18, w7, 1
	sub	w4, w0, w8
	mov	w8, w5
	strh	w4, [x10, x7, lsl 1]
	add	x7, x7, 1
	ble	.L117
	mov	w6, w1
	b	.L121
.L135:
	mov	w1, w14
	mov	w0, 0
	mov	w18, 0
.L117:
	cmp	w1, 1
	bne	.L122
	ldr	w5, [x19, 8]
	sbfiz	x4, x18, 1, 32
	add	w18, w18, 1
	strh	w1, [x11, x4]
	sub	w0, w5, w0
	strh	w0, [x10, x4]
.L122:
	lsl	x30, x30, 4
	cmp	w14, wzr
	add	x0, x30, 16
	sub	sp, sp, x0
	mov	x7, sp
	sub	sp, sp, x0
	mov	x5, sp
	ble	.L127
	b	.L123
	.size	combScheduler, .-combScheduler
	.section	.text.startup,"ax",%progbits
	.align	2
	.p2align 4,,15
	.global	main
	.type	main, %function
main:
	sub	sp, sp, #2367488
	adrp	x0, __stack_chk_guard
	add	x0, x0, :lo12:__stack_chk_guard
	sub	sp, sp, #3392
	mov	x1, 11704
	movk	x1, 0x24, lsl 16
	stp	x29, x30, [sp, -128]!
	add	x29, sp, 0
	ldr	x2, [x0]
	str	x2, [x1, x29]
	mov	x2,0
	add	x0, x29, 256
	stp	x19, x20, [sp, 16]
	stp	x21, x22, [sp, 32]
	mov	x19, 128
	stp	x23, x24, [sp, 48]
	stp	x25, x26, [sp, 64]
	stp	x27, x28, [sp, 80]
	stp	d8, d9, [sp, 96]
	stp	d10, d11, [sp, 112]
	stp	xzr, xzr, [x29, 160]
	stp	xzr, xzr, [x29, 176]
	stp	xzr, xzr, [x29, 192]
	stp	xzr, xzr, [x29, 208]
	stp	xzr, xzr, [x29, 224]
	stp	xzr, xzr, [x29, 240]
	stp	xzr, xzr, [x0]
	add	x0, x29, 272
	str	x19, [x29, 160]
	stp	xzr, xzr, [x0]
	bl	getpid
	add	x2, x29, 160
	mov	x1, x19
	bl	sched_setaffinity
	cbz	w0, .L151
	adrp	x0, .LC4
	add	x0, x0, :lo12:.LC4
	bl	perror
.L151:
	adrp	x1, .LANCHOR0
	mov	x2, 176
	add	x1, x1, :lo12:.LANCHOR0
	add	x0, x29, 968
	bl	memcpy
	mov	w2, 1
	mov	w1, 2
	strb	wzr, [x29, 888]
	mov	w0, 4
	mov	w6, 3
	mov	w5, 5
	mov	w4, 6
	strb	w2, [x29, 889]
	mov	w3, 7
	mov	w2, 8
	strb	w1, [x29, 890]
	strb	w0, [x29, 892]
	mov	w1, 9
	mov	w0, 10
	strb	w6, [x29, 891]
	mov	w6, 11
	mov	x19, 2824
	movk	x19, 0x1, lsl 16
	strb	w5, [x29, 893]
	mov	w5, 12
	add	x19, x19, x29
	strb	w4, [x29, 894]
	mov	w4, 13
	add	x20, x19, 12288
	strb	w3, [x29, 895]
	mov	w3, 14
	add	x20, x20, 3712
	strb	w2, [x29, 896]
	mov	w2, 15
	strb	w1, [x29, 897]
	mov	w1, 1
	strb	w0, [x29, 898]
	add	x0, x29, 128
	strb	w2, [x29, 903]
	strb	w6, [x29, 899]
	strb	w5, [x29, 900]
	strb	w4, [x29, 901]
	strb	w3, [x29, 902]
	bl	timespec_get
	ldp	x0, x1, [x29, 128]
	eor	w0, w1, w0
	bl	srandom
	bl	random
	mov	x0, 2824
	movk	x0, 0x1, lsl 16
	mov	x2, 16000
	mov	w1, 0
	add	x0, x0, x29
	bl	memset
.L152:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L152
	mov	x0, 24792
	mov	x2, 2560
	add	x20, x0, x29
	mov	x0, 22232
	add	x0, x0, x29
	mov	w1, 0
	mov	x19, x0
	bl	memset
.L153:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L153
	add	x0, x29, 920
	add	x19, x29, 904
	add	x20, x19, 64
	stp	xzr, xzr, [x0]
	add	x0, x29, 936
	stp	xzr, xzr, [x19]
	stp	xzr, xzr, [x0]
	add	x0, x29, 952
	stp	xzr, xzr, [x0]
.L154:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L154
	mov	x0, 35224
	mov	x2, 8512
	add	x0, x0, x29
	mov	w1, 0
	mov	x19, x0
	add	x20, x19, 8192
	add	x20, x20, 320
	bl	memset
.L155:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L155
	mov	x0, 4552
	mov	x2, 688
	add	x0, x0, x29
	mov	w1, 0
	mov	x19, x0
	add	x20, x19, 688
	bl	memset
.L156:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L156
	mov	x0, 17352
	mov	x19, 15032
	add	x20, x0, x29
	mov	x0, 15032
	mov	x2, 2320
	mov	w1, 0
	add	x0, x0, x29
	add	x19, x19, x29
	bl	memset
.L157:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L157
	mov	x0, 27352
	mov	x2, 7872
	mov	w1, 0
	add	x0, x0, x29
	bl	memset
	mov	x0, 31448
	mov	x19, 27352
	add	x20, x0, x29
	add	x19, x19, x29
	add	x20, x20, 3776
.L158:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L158
	mov	x19, 53304
	mov	x0, 53304
	add	x19, x19, x29
	mov	x2, 15056
	add	x20, x19, 12288
	mov	w1, 0
	add	x0, x0, x29
	add	x20, x20, 2768
	bl	memset
.L159:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L159
	mov	x19, 13048
	mov	x2, 1984
	add	x19, x19, x29
	mov	w1, 0
	mov	x0, x19
	add	x20, x19, 1984
	bl	memset
.L160:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L160
	mov	x19, 6072
	mov	x2, 1024
	add	x19, x19, x29
	mov	w1, 0
	mov	x0, x19
	add	x20, x19, 1024
	bl	memset
.L161:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L161
	add	x19, x29, 1336
	mov	x2, 544
	mov	w1, 0
	mov	x0, x19
	add	x20, x19, 544
	bl	memset
.L162:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L162
	mov	x0, 22232
	mov	x19, 19768
	add	x20, x0, x29
	mov	x0, 19768
	mov	x2, 2464
	mov	w1, 0
	add	x0, x0, x29
	add	x19, x19, x29
	bl	memset
.L163:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L163
	mov	x19, 57784
	movk	x19, 0x6, lsl 16
	add	x19, x19, x29
	mov	x0, 57784
	movk	x0, 0x6, lsl 16
	add	x20, x19, 319488
	mov	x2, 57856
	movk	x2, 0x4, lsl 16
	mov	w1, 0
	add	x0, x0, x29
	add	x20, x20, 512
	bl	memset
.L164:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L164
	mov	x19, 17352
	mov	x2, 2416
	add	x19, x19, x29
	mov	w1, 0
	mov	x0, x19
	add	x20, x19, 2416
	bl	memset
.L165:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L165
	mov	x19, 43736
	mov	x0, 43736
	add	x19, x19, x29
	mov	x2, 9568
	add	x20, x19, 8192
	mov	w1, 0
	add	x0, x0, x29
	add	x20, x20, 1376
	bl	memset
.L166:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L166
	mov	w19, 4016
.L167:
	bl	random
	subs	w19, w19, #1
	bne	.L167
	mov	x0, 13048
	mov	x19, 11080
	add	x20, x0, x29
	mov	x0, 11080
	mov	x2, 1968
	mov	w1, 0
	add	x0, x0, x29
	add	x19, x19, x29
	bl	memset
.L168:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L168
	mov	x19, 60856
	movk	x19, 0x4, lsl 16
	add	x19, x19, x29
	mov	x0, 60856
	movk	x0, 0x4, lsl 16
	add	x20, x19, 126976
	mov	x2, 62464
	movk	x2, 0x1, lsl 16
	mov	w1, 0
	add	x0, x0, x29
	add	x20, x20, 1024
	bl	memset
.L169:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L169
	add	x19, x29, 2536
	mov	x2, 672
	mov	w1, 0
	mov	x0, x19
	add	x20, x19, 672
	bl	memset
.L170:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L170
	add	x0, x29, 1144
	add	x19, x29, 1144
	add	x20, x19, 192
	stp	xzr, xzr, [x0]
	add	x0, x29, 1160
	stp	xzr, xzr, [x0]
	add	x0, x29, 1176
	stp	xzr, xzr, [x0]
	add	x0, x29, 1192
	stp	xzr, xzr, [x0]
	add	x0, x29, 1208
	stp	xzr, xzr, [x0]
	add	x0, x29, 1224
	stp	xzr, xzr, [x0]
	add	x0, x29, 1240
	stp	xzr, xzr, [x0]
	add	x0, x29, 1256
	stp	xzr, xzr, [x0]
	add	x0, x29, 1272
	stp	xzr, xzr, [x0]
	add	x0, x29, 1288
	stp	xzr, xzr, [x0]
	add	x0, x29, 1304
	stp	xzr, xzr, [x0]
	add	x0, x29, 1320
	stp	xzr, xzr, [x0]
.L171:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L171
	mov	x2, 672
	mov	w1, 0
	add	x0, x29, 3208
	add	x19, x29, 3208
	add	x20, x29, 3880
	bl	memset
.L172:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L172
	mov	x19, 9576
	mov	x2, 1504
	add	x19, x19, x29
	mov	w1, 0
	mov	x0, x19
	add	x20, x19, 1504
	bl	memset
.L173:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L173
	mov	x0, 7096
	mov	x2, 1024
	mov	w1, 0
	add	x0, x0, x29
	bl	memset
	mov	x19, 7096
	mov	x0, 8120
	add	x19, x19, x29
	add	x20, x0, x29
.L174:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L174
	mov	x19, 8120
	mov	x2, 1456
	add	x19, x19, x29
	mov	w1, 0
	mov	x0, x19
	add	x20, x19, 1456
	bl	memset
.L175:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L175
	mov	x19, 24792
	mov	x2, 2560
	add	x19, x19, x29
	mov	w1, 0
	mov	x0, x19
	add	x20, x19, 2560
	bl	memset
.L176:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L176
	mov	x19, 50104
	movk	x19, 0xb, lsl 16
	add	x19, x19, x29
	mov	x0, 50104
	movk	x0, 0xb, lsl 16
	add	x20, x19, 1597440
	mov	x2, 27136
	movk	x2, 0x18, lsl 16
	mov	w1, 0
	add	x0, x0, x29
	add	x20, x20, 2560
	bl	memset
.L177:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L177
	mov	x19, 21624
	movk	x19, 0x3, lsl 16
	add	x19, x19, x29
	mov	x0, 21624
	movk	x0, 0x3, lsl 16
	add	x20, x19, 102400
	mov	x2, 39232
	movk	x2, 0x1, lsl 16
	mov	w1, 0
	add	x0, x0, x29
	add	x20, x20, 2368
	bl	memset
.L178:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L178
	mov	x19, 5240
	mov	x2, 832
	add	x19, x19, x29
	mov	w1, 0
	mov	x0, x19
	add	x20, x19, 832
	bl	memset
.L179:
	bl	random
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L179
	mov	x19, 49288
	movk	x19, 0x2, lsl 16
	add	x19, x19, x29
	mov	x0, 49288
	movk	x0, 0x2, lsl 16
	add	x20, x19, 36864
	mov	x2, 37872
	mov	w1, 0
	add	x0, x0, x29
	add	x20, x20, 1008
	bl	memset
.L180:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L180
	add	x19, x29, 3880
	mov	x2, 672
	mov	w1, 0
	mov	x0, x19
	add	x20, x19, 672
	bl	memset
.L181:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L181
	add	x19, x29, 1880
	mov	x2, 656
	mov	w1, 0
	mov	x0, x19
	add	x20, x19, 656
	bl	memset
.L182:
	bl	random
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L182
	mov	x19, 18824
	movk	x19, 0x1, lsl 16
	add	x19, x19, x29
	mov	x0, 18824
	movk	x0, 0x1, lsl 16
	add	x20, x19, 12288
	mov	x2, 16000
	mov	w1, 0
	add	x0, x0, x29
	add	x20, x20, 3712
	bl	memset
.L183:
	bl	rand
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L183
	mov	x19, 34824
	movk	x19, 0x1, lsl 16
	add	x19, x19, x29
	mov	x0, 34824
	movk	x0, 0x1, lsl 16
	add	x20, x19, 12288
	mov	x2, 16000
	mov	w1, 0
	add	x0, x0, x29
	add	x20, x20, 3712
	bl	memset
.L184:
	bl	rand
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L184
	mov	x19, 50824
	movk	x19, 0x1, lsl 16
	add	x19, x19, x29
	mov	x0, 50824
	movk	x0, 0x1, lsl 16
	add	x20, x19, 12288
	mov	x2, 16000
	mov	w1, 0
	add	x0, x0, x29
	add	x20, x20, 3712
	bl	memset
.L185:
	bl	rand
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L185
	mov	x19, 1288
	movk	x19, 0x2, lsl 16
	add	x19, x19, x29
	mov	x0, 1288
	movk	x0, 0x2, lsl 16
	add	x20, x19, 12288
	mov	x2, 16000
	mov	w1, 0
	add	x0, x0, x29
	add	x20, x20, 3712
	bl	memset
.L186:
	bl	rand
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L186
	mov	x19, 17288
	movk	x19, 0x2, lsl 16
	add	x19, x19, x29
	mov	x0, 17288
	movk	x0, 0x2, lsl 16
	add	x20, x19, 12288
	mov	x2, 16000
	mov	w1, 0
	add	x0, x0, x29
	add	x20, x20, 3712
	bl	memset
.L187:
	bl	rand
	strb	w0, [x19], 1
	cmp	x20, x19
	bne	.L187
	mov	x19, 33288
	movk	x19, 0x2, lsl 16
	add	x19, x19, x29
	mov	x0, 33288
	movk	x0, 0x2, lsl 16
	add	x20, x19, 12288
	mov	x2, 16000
	mov	w1, 0
	add	x0, x0, x29
	add	x20, x20, 3712
	bl	memset
.L188:
	bl	rand
	strb	w0, [x19], 1
	cmp	x19, x20
	bne	.L188
	mov	x0, 15032
	mov	w18, 4
	add	x17, x0, x29
	mov	x0, 2824
	movk	x0, 0x1, lsl 16
	add	x2, x0, x29
	mov	x0, 22232
	str	w18, [x29, 328]
	add	x0, x0, x29
	add	x19, x29, 904
	str	x17, [x29, 368]
	str	x2, [x29, 288]
	mov	x2, 4552
	mov	x1, 35224
	str	x0, [x29, 304]
	mov	w0, 532
	add	x20, x2, x29
	mov	x2, 27352
	mov	x4, 57784
	movk	x4, 0x6, lsl 16
	str	w0, [x29, 344]
	mov	w0, 941
	add	x18, x2, x29
	add	x13, x1, x29
	add	x11, x4, x29
	str	x19, [x29, 320]
	str	w0, [x29, 408]
	mov	x0, 19768
	mov	x1, 53304
	str	x18, [x29, 384]
	add	x18, x0, x29
	mov	x0, 17352
	add	x12, x1, x29
	mov	w19, 43
	str	x11, [x29, 480]
	add	x0, x0, x29
	mov	x1, 13048
	str	x13, [x29, 336]
	add	x11, x29, 3520
	add	x1, x1, x29
	str	w19, [x29, 360]
	mov	x4, 43736
	mov	w21, 124
	str	x0, [x29, 496]
	add	x10, x4, x29
	mov	x0, x11
	str	x1, [x29, 416]
	mov	w13, 492
	mov	x19, 6072
	str	x20, [x29, 352]
	mov	x4, 60856
	movk	x4, 0x4, lsl 16
	add	x9, x4, x29
	add	x20, x19, x29
	str	w21, [x29, 424]
	mov	w1, 151
	add	x19, x29, 1336
	str	w13, [x29, 392]
	sub	x24, x0, #312
	mov	x4, 50104
	movk	x4, 0xb, lsl 16
	mov	x0, 9576
	add	x8, x4, x29
	str	w1, [x29, 504]
	mov	w21, 20000
	mov	w13, 154
	str	x20, [x29, 432]
	add	x23, x0, x29
	mov	x4, 21624
	movk	x4, 0x3, lsl 16
	mov	x0, 8120
	mov	w3, 1000
	str	x19, [x29, 448]
	mov	w14, 160
	mov	w16, 145
	str	w21, [x29, 488]
	mov	w15, 64
	add	x7, x4, x29
	str	w13, [x29, 472]
	add	x1, x0, x29
	mov	w22, 34
	str	x18, [x29, 464]
	mov	w20, 598
	mov	x0, 7096
	str	w3, [x29, 296]
	mov	x4, 49288
	movk	x4, 0x2, lsl 16
	mov	x19, 11080
	add	x6, x4, x29
	str	w14, [x29, 312]
	add	x19, x19, x29
	add	x13, x29, 2536
	str	w16, [x29, 376]
	mov	w18, 123
	sub	x25, x11, #2376
	str	x12, [x29, 400]
	mov	w11, 12
	add	x21, x0, x29
	str	w15, [x29, 440]
	mov	x0, 5240
	mov	x4, 18824
	movk	x4, 0x1, lsl 16
	add	x5, x4, x29
	str	w22, [x29, 456]
	mov	x4, 34824
	movk	x4, 0x1, lsl 16
	str	x10, [x29, 512]
	mov	x2, 24792
	mov	w12, 42
	str	x17, [x29, 528]
	add	x17, x0, x29
	mov	x0, 3880
	str	w16, [x29, 536]
	add	x4, x4, x29
	add	x2, x2, x29
	str	w20, [x29, 520]
	mov	w22, 94
	mov	w16, 52
	str	x19, [x29, 544]
	mov	w10, 41
	mov	w20, 91
	str	x9, [x29, 560]
	add	x0, x0, x29
	mov	w26, 8000
	str	x13, [x29, 576]
	mov	w19, 34464
	movk	w19, 0x1, lsl 16
	mov	w13, 2367
	str	w18, [x29, 552]
	add	x9, x29, 3520
	str	w11, [x29, 600]
	mov	w18, 6548
	add	x11, x29, 1880
	sub	x9, x9, #3224
	str	w12, [x29, 584]
	adrp	x28, .LC6
	str	w12, [x29, 616]
	str	w22, [x29, 632]
	add	x22, x29, 296
	str	w15, [x29, 648]
	str	x2, [x29, 672]
	str	w14, [x29, 680]
	str	x8, [x29, 688]
	str	x7, [x29, 704]
	str	w16, [x29, 728]
	str	x6, [x29, 736]
	str	w12, [x29, 760]
	add	x12, x29, 360
	str	w10, [x29, 776]
	str	x5, [x29, 784]
	add	x5, x29, 808
	str	w3, [x29, 792]
	str	x4, [x29, 800]
	str	x1, [x29, 656]
	str	w20, [x29, 664]
	mov	w20, 16000
	str	w19, [x29, 696]
	str	x17, [x29, 720]
	str	w13, [x29, 744]
	str	x0, [x29, 752]
	add	x0, x29, 3520
	str	w18, [x29, 712]
	sub	x10, x0, #3032
	sub	x8, x0, #2904
	str	x11, [x29, 768]
	sub	x11, x0, #3096
	sub	x7, x0, #2840
	str	w26, [x29, 568]
	sub	x6, x0, #2776
	str	x25, [x29, 592]
	str	x24, [x29, 608]
	str	x23, [x29, 624]
	str	x21, [x29, 640]
	str	w3, [x29, 808]
	ld4	{v0.4s - v3.4s}, [x9]
	sub	x9, x0, #2968
	mov	x0, 50824
	movk	x0, 0x1, lsl 16
	add	x4, x0, x29
	mov	x0, 1288
	movk	x0, 0x2, lsl 16
	add	x2, x0, x29
	mov	x0, 17288
	movk	x0, 0x2, lsl 16
	add	x1, x0, x29
	mov	x0, 33288
	movk	x0, 0x2, lsl 16
	add	x0, x0, x29
	str	w3, [x29, 824]
	str	w3, [x29, 840]
	str	w3, [x29, 856]
	shl	v5.4s, v0.4s, 4
	str	x4, [x29, 816]
	ld4	{v0.4s - v3.4s}, [x12]
	str	x2, [x29, 832]
	adrp	x2, .LC5
	add	x2, x2, :lo12:.LC5
	str	x1, [x29, 848]
	add	x1, x28, :lo12:.LC6
	str	x0, [x29, 864]
	mov	w0, 1
	str	w3, [x29, 872]
	shl	v4.4s, v0.4s, 4
	ld4	{v0.4s - v3.4s}, [x11]
	add	v5.4s, v4.4s, v5.4s
	shl	v4.4s, v0.4s, 4
	ld4	{v0.4s - v3.4s}, [x10]
	add	v5.4s, v4.4s, v5.4s
	shl	v4.4s, v0.4s, 4
	ld4	{v0.4s - v3.4s}, [x9]
	add	v5.4s, v4.4s, v5.4s
	shl	v4.4s, v0.4s, 4
	ld4	{v0.4s - v3.4s}, [x8]
	add	v5.4s, v4.4s, v5.4s
	shl	v4.4s, v0.4s, 4
	ld4	{v0.4s - v3.4s}, [x7]
	add	v5.4s, v4.4s, v5.4s
	shl	v4.4s, v0.4s, 4
	ld4	{v0.4s - v3.4s}, [x6]
	add	v5.4s, v4.4s, v5.4s
	shl	v4.4s, v0.4s, 4
	ld4	{v0.4s - v3.4s}, [x5]
	add	v4.4s, v4.4s, v5.4s
	shl	v0.4s, v0.4s, 4
	add	v0.4s, v0.4s, v4.4s
	addv	s0, v0.4s
	umov	w3, v0.s[0]
	add	w20, w3, w20
	mov	w3, w20
	bl	__printf_chk
	add	x0, x29, 288
	mov	w5, 1250
	add	x19, x0, 600
	add	x4, x29, 888
	.p2align 2
.L189:
	mov	x3, x22
	.p2align 2
.L191:
	ldr	w2, [x3]
	mov	x0, 0
	mov	w1, 0
	ldr	q0, [x4]
	cmp	w2, wzr
	ble	.L194
	.p2align 2
.L210:
	ldr	x2, [x3, -8]
	add	x6, x29, 968
	add	w1, w1, 1
	ldr	q19, [x6]
	add	x6, x29, 984
	ldr	q18, [x6]
	add	x6, x29, 1000
	ldr	q1, [x2, x0]
	ldr	q17, [x6]
	add	x6, x29, 1016
	ldr	q16, [x6]
	add	x6, x29, 1032
	eor	v0.16b, v1.16b, v0.16b
	ldr	q8, [x6]
	add	x6, x29, 1048
	ldr	q7, [x6]
	add	x6, x29, 1064
	aese	v0.16b, v19.16b
	ldr	q6, [x6]
	add	x6, x29, 1080
	ldr	q5, [x6]
	add	x6, x29, 1096
	aesmc	v0.16b, v0.16b
	ldr	q4, [x6]
	add	x6, x29, 1112
	ldr	q3, [x6]
	add	x6, x29, 1128
	aese	v0.16b, v18.16b
	ldr	q2, [x6]
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v17.16b
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v16.16b
	aesmc	v0.16b, v0.16b
	aese	v0.16b, v8.16b
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
	eor	v0.16b, v2.16b, v0.16b
	str	q0, [x2, x0]
	add	x0, x0, 16
	ldr	w2, [x3]
	cmp	w1, w2
	blt	.L210
.L194:
	add	x3, x3, 16
	cmp	x19, x3
	bne	.L191
	subs	w5, w5, #1
	bne	.L189
	mov	x1, 0
	add	x0, x29, 144
	bl	gettimeofday
	ldp	x0, x1, [x29, 144]
	adrp	x21, start_clk
	mov	w5, 5000
	add	x4, x29, 888
	ldr	d8, .LC7
	scvtf	d0, x0
	scvtf	d1, x1
	fmadd	d0, d0, d8, d1
	fcvtzu	x0, d0
	str	x0, [x21, #:lo12:start_clk]
.L196:
	mov	x3, x22
	.p2align 2
.L198:
	ldr	w2, [x3]
	mov	x0, 0
	mov	w1, 0
	ldr	q0, [x4]
	cmp	w2, wzr
	ble	.L201
	.p2align 2
.L209:
	ldr	x2, [x3, -8]
	add	x6, x29, 968
	add	w1, w1, 1
	ldr	q20, [x6]
	add	x6, x29, 984
	ldr	q19, [x6]
	add	x6, x29, 1000
	ldr	q1, [x2, x0]
	ldr	q18, [x6]
	add	x6, x29, 1016
	ldr	q17, [x6]
	add	x6, x29, 1032
	eor	v0.16b, v1.16b, v0.16b
	ldr	q16, [x6]
	add	x6, x29, 1048
	ldr	q7, [x6]
	add	x6, x29, 1064
	aese	v0.16b, v20.16b
	ldr	q6, [x6]
	add	x6, x29, 1080
	ldr	q5, [x6]
	add	x6, x29, 1096
	aesmc	v0.16b, v0.16b
	ldr	q4, [x6]
	add	x6, x29, 1112
	ldr	q3, [x6]
	add	x6, x29, 1128
	aese	v0.16b, v19.16b
	ldr	q2, [x6]
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
	eor	v0.16b, v2.16b, v0.16b
	str	q0, [x2, x0]
	add	x0, x0, 16
	ldr	w2, [x3]
	cmp	w1, w2
	blt	.L209
.L201:
	add	x3, x3, 16
	cmp	x19, x3
	bne	.L198
	subs	w5, w5, #1
	bne	.L196
	mov	x1, 0
	add	x0, x29, 144
	bl	gettimeofday
	ldp	x0, x1, [x29, 144]
	add	x3, x29, 3520
	scvtf	d9, w20
	sub	x22, x3, #2552
	sub	x19, x3, #3232
	ldr	x2, [x21, #:lo12:start_clk]
	adrp	x26, end_clk
	adrp	x25, total_clk
	mov	w24, 1250
	add	x23, x29, 888
	ldr	d11, .LC8
	scvtf	d1, x1
	scvtf	d0, x0
	adrp	x27, .LC10
	add	x1, x27, :lo12:.LC10
	ldr	d10, .LC9
	mov	w0, 1
	fmadd	d0, d0, d8, d1
	fcvtzu	x3, d0
	sub	x2, x3, x2
	str	x3, [x26, #:lo12:end_clk]
	ucvtf	d1, x2
	fmul	d1, d1, d11
	fdiv	d1, d1, d10
	fdiv	d0, d1, d9
	str	d1, [x25, #:lo12:total_clk]
	bl	__printf_chk
	adrp	x0, .LC11
	add	x0, x0, :lo12:.LC11
	bl	puts
	adrp	x2, .LC12
	add	x2, x2, :lo12:.LC12
	mov	w3, w20
	add	x1, x28, :lo12:.LC6
	mov	w0, 1
	bl	__printf_chk
.L203:
	mov	x2, x23
	mov	x1, x22
	mov	x0, x19
	bl	combScheduler.constprop.0
	subs	w24, w24, #1
	bne	.L203
	mov	x1, 0
	add	x0, x29, 144
	bl	gettimeofday
	ldr	x0, [x29, 144]
	mov	w20, 5000
	scvtf	d0, x0
	ldr	x0, [x29, 152]
	scvtf	d1, x0
	fmadd	d0, d0, d8, d1
	fcvtzu	x0, d0
	str	x0, [x21, #:lo12:start_clk]
.L204:
	mov	x2, x23
	mov	x1, x22
	mov	x0, x19
	bl	combScheduler.constprop.0
	subs	w20, w20, #1
	bne	.L204
	mov	x1, 0
	add	x0, x29, 144
	bl	gettimeofday
	ldp	x3, x4, [x29, 144]
	add	x1, x27, :lo12:.LC10
	mov	w0, 1
	mov	w20, 0
	ldr	x2, [x21, #:lo12:start_clk]
	scvtf	d1, x4
	scvtf	d0, x3
	fmadd	d8, d0, d8, d1
	fcvtzu	x3, d8
	sub	x2, x3, x2
	str	x3, [x26, #:lo12:end_clk]
	ucvtf	d1, x2
	fmul	d1, d1, d11
	fdiv	d1, d1, d10
	fdiv	d0, d1, d9
	str	d1, [x25, #:lo12:total_clk]
	bl	__printf_chk
	mov	x0, x19
	add	x4, x19, 592
.L205:
	ldr	x3, [x0]
	add	x0, x0, 16
	ldr	w2, [x0, -8]
	cmp	x0, x4
	ldrb	w1, [x3]
	lsl	w2, w2, 4
	add	x2, x3, x2, sxtw
	ldrb	w2, [x2, -1]
	eor	w1, w2, w1
	uxtb	w1, w1
	eor	w20, w20, w1
	bne	.L205
	adrp	x1, .LC13
	mov	w2, w20
	add	x1, x1, :lo12:.LC13
	mov	w0, 1
	bl	__printf_chk
	adrp	x1, __stack_chk_guard
	add	x1, x1, :lo12:__stack_chk_guard
	mov	x2, 11704
	movk	x2, 0x24, lsl 16
	ldr	x3, [x2, x29]
	ldr	x1, [x1]
	eor	x1, x3, x1
	mov	w0, w20
	cbnz	x1, .L261
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	ldp	d8, d9, [sp, 96]
	ldp	d10, d11, [sp, 112]
	ldp	x29, x30, [sp], 128
	add	sp, sp, 2367488
	add	sp, sp, 3392
	ret
.L261:
	bl	__stack_chk_fail
	.size	main, .-main
	.align	3
.LC7:
	.word	0
	.word	1093567616
	.align	3
.LC8:
	.word	0
	.word	1084254208
	.align	3
.LC9:
	.word	0
	.word	1085507584
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
.LC3:
	.string	"%02x"
	.zero	3
.LC4:
	.string	"setaffinity"
	.zero	4
.LC5:
	.string	"AES-CBC-BIG"
	.zero	4
.LC6:
	.string	"%s-%d: "
.LC10:
	.string	"%g cpb\n"
.LC11:
	.string	"round 1"
.LC12:
	.string	"AES-CBC-COMP-P2"
.LC13:
	.string	"terminated with code %d\n"
	.ident	"GCC: (Ubuntu 5.2.1-22ubuntu1) 5.2.1 20151010"
	.section	.note.GNU-stack,"",%progbits
