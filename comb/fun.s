	.cpu cortex-a57+fp+simd+crypto+crc
	.file	"fun.c"
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
	adrp	x21, .LC0
	add	x21, x21, :lo12:.LC0
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
	.global	fun
	.type	fun, %function
fun:
	mov	w1, 128
	.p2align 2
.L9:
	subs	w1, w1, #1
	eor     v30.16b, v30.16b, v31.16b
    eor     v28.16b, v28.16b, v30.16b
    eor     v26.16b, v26.16b, v29.16b
    eor     v24.16b, v24.16b, v27.16b
    eor     v22.16b, v22.16b, v28.16b
    eor     v0.16b, v1.16b, v0.16b
    aese    v30.16b, v26.16b
    aese    v28.16b, v26.16b
    aese    v26.16b, v26.16b
    aesmc   v30.16b, v30.16b
    aese    v24.16b, v26.16b
    aesmc   v28.16b, v28.16b
    aese    v22.16b, v26.16b
    aesmc   v26.16b, v26.16b
    aese    v0.16b, v26.16b
    aesmc   v24.16b, v24.16b
    aese    v30.16b, v26.16b
    aesmc   v22.16b, v22.16b
    aese    v28.16b, v26.16b
    aesmc   v0.16b, v0.16b
    aese    v26.16b, v26.16b
    aesmc   v30.16b, v30.16b
    aese    v24.16b, v26.16b
    aesmc   v28.16b, v28.16b
    aese    v22.16b, v26.16b
    aesmc   v26.16b, v26.16b
    aese    v0.16b, v26.16b
    aesmc   v24.16b, v24.16b
    aese    v30.16b, v26.16b
    aesmc   v22.16b, v22.16b
    aese    v28.16b, v26.16b
    aesmc   v0.16b, v0.16b
    aese    v26.16b, v26.16b
    aesmc   v30.16b, v30.16b
    aese    v24.16b, v26.16b
    aesmc   v28.16b, v28.16b
    aese    v22.16b, v26.16b
    aesmc   v26.16b, v26.16b
    aese    v0.16b, v26.16b
    aesmc   v24.16b, v24.16b
    aese    v30.16b, v26.16b
    aesmc   v22.16b, v22.16b
    aese    v28.16b, v26.16b
    aesmc   v0.16b, v0.16b
    aese    v26.16b, v26.16b
    aesmc   v30.16b, v30.16b
    aese    v24.16b, v26.16b
    aesmc   v28.16b, v28.16b
    aese    v22.16b, v26.16b
    aesmc   v26.16b, v26.16b
    aese    v0.16b, v26.16b
    aesmc   v24.16b, v24.16b
    aese    v30.16b, v26.16b
    aesmc   v22.16b, v22.16b
    aese    v28.16b, v26.16b
    aesmc   v0.16b, v0.16b
    aese    v26.16b, v26.16b
    aesmc   v30.16b, v30.16b
    aese    v24.16b, v26.16b
    aesmc   v28.16b, v28.16b
    aese    v22.16b, v26.16b
    aesmc   v26.16b, v26.16b
    aese    v0.16b, v26.16b
    aesmc   v24.16b, v24.16b
    aese    v30.16b, v26.16b
    aesmc   v22.16b, v22.16b
    aese    v28.16b, v26.16b
    aesmc   v0.16b, v0.16b
    aese    v26.16b, v26.16b
    aesmc   v30.16b, v30.16b
    aese    v24.16b, v26.16b
    aesmc   v28.16b, v28.16b
    aese    v22.16b, v26.16b
    aesmc   v26.16b, v26.16b
    aese    v0.16b, v26.16b
    aesmc   v24.16b, v24.16b
    aese    v30.16b, v26.16b
    aesmc   v22.16b, v22.16b
    aese    v28.16b, v26.16b
    aesmc   v0.16b, v0.16b
    aese    v26.16b, v26.16b
    aesmc   v30.16b, v30.16b
    aese    v24.16b, v26.16b
    aesmc   v28.16b, v28.16b
    aese    v22.16b, v26.16b
    aesmc   v26.16b, v26.16b
    aese    v0.16b, v26.16b
    aesmc   v24.16b, v24.16b
    aese    v30.16b, v26.16b
    aesmc   v22.16b, v22.16b
    aese    v28.16b, v26.16b
    aesmc   v0.16b, v0.16b
    aese    v26.16b, v26.16b
    aesmc   v30.16b, v30.16b
    aese    v24.16b, v26.16b
    aesmc   v28.16b, v28.16b
    aese    v22.16b, v26.16b
    aesmc   v26.16b, v26.16b
    aese    v0.16b, v26.16b
    aesmc   v24.16b, v24.16b
    aese    v30.16b, v26.16b
    aesmc   v22.16b, v22.16b
    aese    v28.16b, v26.16b
    aesmc   v0.16b, v0.16b
    aese    v26.16b, v26.16b
    aesmc   v30.16b, v30.16b
    aese    v24.16b, v26.16b
    aesmc   v28.16b, v28.16b
    aese    v22.16b, v26.16b
    aesmc   v26.16b, v26.16b
    aese    v0.16b, v26.16b
    aesmc   v24.16b, v24.16b
    aese    v30.16b, v26.16b
    aesmc   v22.16b, v22.16b
    aese    v28.16b, v26.16b
    aesmc   v0.16b, v0.16b
    aese    v26.16b, v26.16b
    eor     v6.16b, v30.16b, v26.16b
    aese    v24.16b, v26.16b
    eor     v5.16b, v28.16b, v26.16b
    aese    v22.16b, v26.16b
    eor     v1.16b, v26.16b, v26.16b  
    aese    v0.16b, v26.16b
    eor     v16.16b, v24.16b, v26.16b
    eor     v3.16b, v22.16b, v26.16b
    eor     v0.16b, v0.16b, v26.16b
	bne	.L9
	str	q0, [x0]
	ret
	.size	fun, .-fun
	.section	.text.startup,"ax",%progbits
	.align	2
	.p2align 4,,15
	.global	main
	.type	main, %function
main:
	stp	x29, x30, [sp, -224]!
	add	x29, sp, 0
	add	x0, x29, 72
	stp	x19, x20, [sp, 16]
	mov	x20, 128
	str	d8, [sp, 32]
	stp	xzr, xzr, [x0]
	adrp	x19, __stack_chk_guard
	add	x0, x19, :lo12:__stack_chk_guard
	ldr	x1, [x0]
	str	x1, [x29, 216]
	mov	x1,0
	add	x0, x29, 88
	str	x20, [x29, 72]
	stp	xzr, xzr, [x0]
	add	x0, x29, 104
	stp	xzr, xzr, [x0]
	add	x0, x29, 120
	stp	xzr, xzr, [x0]
	add	x0, x29, 136
	stp	xzr, xzr, [x0]
	add	x0, x29, 152
	stp	xzr, xzr, [x0]
	add	x0, x29, 168
	stp	xzr, xzr, [x0]
	add	x0, x29, 184
	stp	xzr, xzr, [x0]
	bl	getpid
	add	x2, x29, 72
	mov	x1, x20
	bl	sched_setaffinity
	cbnz	w0, .L22
.L12:
	adrp	x2, .LC2
	adrp	x1, .LC3
	add	x2, x2, :lo12:.LC2
	add	x1, x1, :lo12:.LC3
	mov	w3, 24576
	movk	w3, 0x9, lsl 16
	mov	w0, 1
	adrp	x20, start_clk
	bl	__printf_chk
	mov	x1, 0
	add	x0, x29, 56
	bl	gettimeofday
	ldp	x0, x2, [x29, 56]
	mov	w1, 10000
	ldr	d8, .LC4
	ldr	q1, .LC5
	scvtf	d0, x0
	scvtf	d3, x2
	fmadd	d0, d0, d8, d3
	fcvtzu	x0, d0
	str	x0, [x20, #:lo12:start_clk]
	.p2align 2
.L13:
	movi	v0.4s, 0
	mov	w0, 128
	.p2align 2
.L14:
	subs	w0, w0, #1
	aese	v0.16b, v1.16b
	bne	.L14
	str	q0, [x29, 200]
	subs	w1, w1, #1
	bne	.L13
	mov	x1, 0
	add	x0, x29, 56
	bl	gettimeofday
	ldp	x3, x4, [x29, 56]
	adrp	x6, end_clk
	adrp	x5, total_clk
	adrp	x1, .LC9
	mov	w0, 1
	ldr	x2, [x20, #:lo12:start_clk]
	add	x1, x1, :lo12:.LC9
	add	x19, x19, :lo12:__stack_chk_guard
	ldr	d1, .LC6
	scvtf	d3, x3
	scvtf	d2, x4
	ldr	d4, .LC7
	ldr	d0, .LC8
	fmadd	d2, d3, d8, d2
	fcvtzu	x3, d2
	sub	x2, x3, x2
	str	x3, [x6, #:lo12:end_clk]
	ucvtf	d2, x2
	fmul	d1, d2, d1
	fdiv	d1, d1, d4
	fdiv	d0, d1, d0
	str	d1, [x5, #:lo12:total_clk]
	bl	__printf_chk
	add	x0, x29, 200
	bl	printblock
	ldrb	w2, [x29, 200]
	ldr	x3, [x29, 216]
	ldr	x1, [x19]
	eor	x1, x3, x1
	ldrb	w0, [x29, 215]
	eor	w0, w2, w0
	uxtb	w0, w0
	cbnz	x1, .L23
	ldp	x19, x20, [sp, 16]
	ldr	d8, [sp, 32]
	ldp	x29, x30, [sp], 224
	ret
.L22:
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	perror
	b	.L12
.L23:
	bl	__stack_chk_fail
	.size	main, .-main
	.align	3
.LC4:
	.word	0
	.word	1093567616
	.align	4
.LC5:
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.align	3
.LC6:
	.word	0
	.word	1084254208
	.align	3
.LC7:
	.word	0
	.word	1086556160
	.align	3
.LC8:
	.word	0
	.word	1092796416
	.comm	total_clk,8,8
	.comm	end_clk,8,8
	.comm	start_clk,8,8
	.section	.rodata.str1.8,"aMS",%progbits,1
	.align	3
.LC0:
	.string	"%02x"
	.zero	3
.LC1:
	.string	"setaffinity"
	.zero	4
.LC2:
	.string	"performance:"
	.zero	3
.LC3:
	.string	"%s-%d: "
.LC9:
	.string	"%g cpb\n"
	.ident	"GCC: (Ubuntu 5.2.1-22ubuntu1) 5.2.1 20151010"
	.section	.note.GNU-stack,"",%progbits
