	.cpu cortex-a57+fp+simd+crypto+crc
	.file	"fun.c"
	.text
	.align	2
	.p2align 4,,15
	.global	fun
	.type	fun, %function
fun:
	ret
	.size	fun, .-fun
	.section	.text.startup,"ax",%progbits
	.align	2
	.p2align 4,,15
	.global	main
	.type	main, %function
main:
	stp	x29, x30, [sp, -208]!
	add	x29, sp, 0
	add	x0, x29, 72
	stp	x19, x20, [sp, 16]
	mov	x20, 128
	str	d8, [sp, 32]
	stp	xzr, xzr, [x0]
	adrp	x19, __stack_chk_guard
	add	x0, x19, :lo12:__stack_chk_guard
	ldr	x1, [x0]
	str	x1, [x29, 200]
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
	cbz	w0, .L3
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	perror
.L3:
	adrp	x2, .LC1
	adrp	x1, .LC2
	add	x2, x2, :lo12:.LC1
	add	x1, x1, :lo12:.LC2
	mov	w3, 24576
	movk	w3, 0x9, lsl 16
	mov	w0, 1
	adrp	x20, start_clk
	bl	__printf_chk
	mov	x1, 0
	add	x0, x29, 56
	bl	gettimeofday
	ldp	x2, x3, [x29, 56]
	mov	x1, 0
	add	x0, x29, 56
	add	x19, x19, :lo12:__stack_chk_guard
	ldr	d8, .LC3
	scvtf	d1, x3
	scvtf	d0, x2
	fmadd	d0, d0, d8, d1
	fcvtzu	x2, d0
	str	x2, [x20, #:lo12:start_clk]
	bl	gettimeofday
	ldp	x3, x4, [x29, 56]
	adrp	x6, end_clk
	adrp	x5, total_clk
	adrp	x1, .LC7
	mov	w0, 1
	ldr	x2, [x20, #:lo12:start_clk]
	add	x1, x1, :lo12:.LC7
	ldr	d1, .LC4
	scvtf	d3, x3
	scvtf	d2, x4
	ldr	d4, .LC5
	ldr	d0, .LC6
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
	ldr	x0, [x29, 200]
	ldr	x1, [x19]
	eor	x1, x0, x1
	mov	w0, 1
	cbnz	x1, .L10
	ldp	x19, x20, [sp, 16]
	ldr	d8, [sp, 32]
	ldp	x29, x30, [sp], 208
	ret
.L10:
	bl	__stack_chk_fail
	.size	main, .-main
	.align	3
.LC3:
	.word	0
	.word	1093567616
	.align	3
.LC4:
	.word	0
	.word	1084254208
	.align	3
.LC5:
	.word	0
	.word	1086556160
	.align	3
.LC6:
	.word	0
	.word	1092796416
	.comm	total_clk,8,8
	.comm	end_clk,8,8
	.comm	start_clk,8,8
	.section	.rodata.str1.8,"aMS",%progbits,1
	.align	3
.LC0:
	.string	"setaffinity"
	.zero	4
.LC1:
	.string	"performance:"
	.zero	3
.LC2:
	.string	"%s-%d: "
.LC7:
	.string	"%g cpb\n"
	.ident	"GCC: (Ubuntu 5.2.1-22ubuntu1) 5.2.1 20151010"
	.section	.note.GNU-stack,"",%progbits
