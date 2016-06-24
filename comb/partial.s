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
	ldr	q26, [x19]
	ldr	q1, [x1, x2]
	ldr	q20, [x20, x2]
	ldr	q28, [x29, 208]
	ldr	q0, [x29, 240]
	ldr	q24, [x19, 16]
	eor     v23.16b, v23.16b, v31.16b
    eor     v22.16b, v22.16b, v30.16b
    eor     v25.16b, v25.16b, v29.16b
    eor     v7.16b, v7.16b, v27.16b
    eor     v20.16b, v20.16b, v28.16b
    eor     v0.16b, v1.16b, v0.16b
    aese    v23.16b, v26.16b
    aese    v22.16b, v26.16b
    aese    v25.16b, v26.16b
    aesmc   v23.16b, v23.16b
    aese    v7.16b, v26.16b
    aesmc   v22.16b, v22.16b
    aese    v20.16b, v26.16b
    aesmc   v25.16b, v25.16b
    aese    v0.16b, v26.16b
    aesmc   v7.16b, v7.16b
    aese    v23.16b, v26.16b
    aesmc   v20.16b, v20.16b
    aese    v22.16b, v26.16b
    aesmc   v0.16b, v0.16b
    aese    v25.16b, v26.16b
    aesmc   v23.16b, v23.16b
    aese    v7.16b, v26.16b
    aesmc   v22.16b, v22.16b
    aese    v20.16b, v26.16b
    aesmc   v25.16b, v25.16b
    aese    v0.16b, v26.16b
    aesmc   v7.16b, v7.16b
    aese    v23.16b, v26.16b
    aesmc   v20.16b, v20.16b
    aese    v22.16b, v26.16b
    aesmc   v0.16b, v0.16b
    aese    v25.16b, v26.16b
    aesmc   v23.16b, v23.16b
    aese    v7.16b, v26.16b
    aesmc   v22.16b, v22.16b
    aese    v20.16b, v26.16b
    aesmc   v25.16b, v25.16b
    aese    v0.16b, v26.16b
    aesmc   v7.16b, v7.16b
    aese    v23.16b, v26.16b
    aesmc   v20.16b, v20.16b
    aese    v22.16b, v26.16b
    aesmc   v0.16b, v0.16b
    aese    v25.16b, v26.16b
    aesmc   v23.16b, v23.16b
    aese    v7.16b, v26.16b
    aesmc   v22.16b, v22.16b
    aese    v20.16b, v26.16b
    aesmc   v25.16b, v25.16b
    aese    v0.16b, v26.16b
    aesmc   v7.16b, v7.16b
    aese    v23.16b, v26.16b
    aesmc   v20.16b, v20.16b
    aese    v22.16b, v26.16b
    aesmc   v0.16b, v0.16b
    aese    v25.16b, v26.16b
    aesmc   v23.16b, v23.16b
    aese    v7.16b, v26.16b
    aesmc   v22.16b, v22.16b
    aese    v20.16b, v26.16b
    aesmc   v25.16b, v25.16b
    aese    v0.16b, v26.16b
    aesmc   v7.16b, v7.16b
    aese    v23.16b, v26.16b
    aesmc   v20.16b, v20.16b
    aese    v22.16b, v26.16b
    aesmc   v0.16b, v0.16b
    aese    v25.16b, v26.16b
    aesmc   v23.16b, v23.16b
    aese    v7.16b, v26.16b
    aesmc   v22.16b, v22.16b
    aese    v20.16b, v26.16b
    aesmc   v25.16b, v25.16b
    aese    v0.16b, v26.16b
    aesmc   v7.16b, v7.16b
    aese    v23.16b, v26.16b
    aesmc   v20.16b, v20.16b
    aese    v22.16b, v26.16b
    aesmc   v0.16b, v0.16b
    aese    v25.16b, v26.16b
    aesmc   v23.16b, v23.16b
    aese    v7.16b, v26.16b
    aesmc   v22.16b, v22.16b
    aese    v20.16b, v26.16b
    aesmc   v25.16b, v25.16b
    aese    v0.16b, v26.16b
    aesmc   v7.16b, v7.16b
    aese    v23.16b, v26.16b
    aesmc   v20.16b, v20.16b
    aese    v22.16b, v26.16b
    aesmc   v0.16b, v0.16b
    aese    v25.16b, v26.16b
    aesmc   v23.16b, v23.16b
    aese    v7.16b, v26.16b
    aesmc   v22.16b, v22.16b
    aese    v20.16b, v26.16b
    aesmc   v25.16b, v25.16b
    aese    v0.16b, v26.16b
    aesmc   v7.16b, v7.16b
    aese    v23.16b, v26.16b
    aesmc   v20.16b, v20.16b
    aese    v22.16b, v26.16b
    aesmc   v0.16b, v0.16b
    aese    v25.16b, v26.16b
    aesmc   v23.16b, v23.16b
    aese    v7.16b, v26.16b
    aesmc   v22.16b, v22.16b
    aese    v20.16b, v26.16b
    aesmc   v25.16b, v25.16b
    aese    v0.16b, v26.16b
    aesmc   v7.16b, v7.16b
    aese    v23.16b, v26.16b
    aesmc   v20.16b, v20.16b
    aese    v22.16b, v26.16b
    aesmc   v0.16b, v0.16b
    aese    v25.16b, v26.16b
    eor     v6.16b, v23.16b, v26.16b
    aese    v7.16b, v26.16b
    eor     v5.16b, v22.16b, v26.16b
    aese    v20.16b, v26.16b
    eor     v1.16b, v25.16b, v26.16b  
    aese    v0.16b, v26.16b
    eor     v16.16b, v7.16b, v26.16b
    eor     v3.16b, v20.16b, v26.16b
    eor     v0.16b, v0.16b, v26.16b
	str	q6, [x29, 176]
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