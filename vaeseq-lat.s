	.cpu cortex-a57+fp+simd+crypto+crc
	.file	"vaeseq-lat.c"
	.section	.text.startup,"ax",%progbits
	.align	2
	.p2align 4,,15
	.global	main
	.type	main, %function
main:
	stp	x29, x30, [sp, -192]!
	add	x29, sp, 0
	add	x0, x29, 56
	stp	x19, x20, [sp, 16]
	mov	x20, 128
	stp	xzr, xzr, [x0]
	adrp	x19, __stack_chk_guard
	add	x0, x19, :lo12:__stack_chk_guard
	ldr	x1, [x0]
	str	x1, [x29, 184]
	mov	x1,0
	add	x0, x29, 72
	str	x20, [x29, 56]
	stp	xzr, xzr, [x0]
	add	x0, x29, 88
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
	bl	getpid
	add	x2, x29, 56
	mov	x1, x20
	bl	sched_setaffinity
	cbnz	w0, .L13
.L2:
	ldr	q1, .LC0
	mov	w0, 45696
	movk	w0, 0xee6, lsl 16
	ldr	q0, .LC2
	.p2align 2
.L3:
	subs	w0, w0, #1
	aese	v1.16b, v0.16b
	bne	.L3
#APP
// 25 "vaeseq-lat.c" 1
	mrs x1, pmccntr_el0
// 0 "" 2
#NO_APP
	uxtw	x1, w1
	adrp	x2, start_clk
	mov	w0, 51712
	movk	w0, 0x3b9a, lsl 16
	str	x1, [x2, #:lo12:start_clk]
	.p2align 2
.L4:
	subs	w0, w0, #1
	aese	v1.16b, v0.16b
	bne	.L4
	str	q1, [x29, 32]
#APP
// 25 "vaeseq-lat.c" 1
	mrs x0, pmccntr_el0
// 0 "" 2
#NO_APP
	ldr	x4, [x2, #:lo12:start_clk]
	uxtw	x2, w0
	adrp	x5, end_clk
	adrp	x3, total_clk
	adrp	x1, .LC5
	ldr	d3, .LC3
	add	x1, x1, :lo12:.LC5
	mov	w0, 1
	str	x2, [x5, #:lo12:end_clk]
	add	x19, x19, :lo12:__stack_chk_guard
	ldr	d2, .LC4
	sub	x2, x2, x4
	ucvtf	d0, x2
	fmul	d0, d0, d3
	fdiv	d2, d0, d2
	fmov	d0, d2
	str	d2, [x3, #:lo12:total_clk]
	bl	__printf_chk
	ldr	q1, [x29, 32]
	ldr	x3, [x29, 184]
	ldr	x1, [x19]
	eor	x1, x3, x1
	umov	w2, v1.b[0]
	umov	w0, v1.b[15]
	eor	w0, w2, w0
	uxtb	w0, w0
	cbnz	x1, .L14
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 192
	ret
.L13:
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	perror
	b	.L2
.L14:
	bl	__stack_chk_fail
	.size	main, .-main
	.align	4
.LC0:
	.byte	-82
	.byte	45
	.byte	-118
	.byte	87
	.byte	30
	.byte	3
	.byte	-84
	.byte	-100
	.byte	-98
	.byte	-73
	.byte	111
	.byte	-84
	.byte	69
	.byte	-81
	.byte	-114
	.byte	81
	.align	4
.LC2:
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
	.align	3
.LC3:
	.word	0
	.word	1084254208
	.align	3
.LC4:
	.word	0
	.word	1104006501
	.comm	total_clk,8,8
	.comm	end_clk,8,8
	.comm	start_clk,8,8
	.section	.rodata.str1.8,"aMS",%progbits,1
	.align	3
.LC1:
	.string	"setaffinity"
	.zero	4
.LC5:
	.string	"%g cpb\n"
	.ident	"GCC: (Ubuntu 5.2.1-22ubuntu1) 5.2.1 20151010"
	.section	.note.GNU-stack,"",%progbits
