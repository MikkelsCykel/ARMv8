add	x0, x11, x3
	add	x3, x3, 16
	cmp	x10, x3
	ldr	q31, [x9, x0]
	ldr	q29, [x8, x0]
	ldr	q27, [x7, x0]
	ldr	q25, [x6, x0]
	ldr	q23, [x5, x0]
	ldr	q21, [x4, x0]
	
	eor	v30.16b, v31.16b, v30.16b
	eor	v28.16b, v29.16b, v28.16b
	eor	v26.16b, v27.16b, v26.16b
	eor	v24.16b, v25.16b, v24.16b
	eor	v22.16b, v23.16b, v22.16b
	eor	v0.16b, v21.16b, v0.16b

	aese	v30.16b, v19.16b
	
	aese	v28.16b, v19.16b
	
	aese	v26.16b, v19.16b
	aesmc	v30.16b, v30.16b
	
	aese	v24.16b, v19.16b
	aesmc	v28.16b, v28.16b
	aese	v22.16b, v19.16b
	aesmc	v26.16b, v26.16b
	aese	v0.16b, v19.16b
	aesmc	v24.16b, v24.16b
	aesmc	v22.16b, v22.16b
	aese	v30.16b, v18.16b
	aesmc	v0.16b, v0.16b
	aese	v28.16b, v18.16b
	aese	v26.16b, v18.16b
	aese	v24.16b, v18.16b
	aese	v22.16b, v18.16b
	aese	v0.16b, v18.16b
	aesmc	v30.16b, v30.16b
	aesmc	v28.16b, v28.16b
	aesmc	v26.16b, v26.16b
	aesmc	v24.16b, v24.16b
	aesmc	v22.16b, v22.16b
	aesmc	v0.16b, v0.16b
	aese	v30.16b, v17.16b
	aese	v28.16b, v17.16b
	aese	v26.16b, v17.16b
	aese	v24.16b, v17.16b
	aese	v22.16b, v17.16b
	aese	v0.16b, v17.16b
	aesmc	v30.16b, v30.16b
	aesmc	v28.16b, v28.16b
	aesmc	v26.16b, v26.16b
	aesmc	v24.16b, v24.16b
	aesmc	v22.16b, v22.16b
	aesmc	v0.16b, v0.16b
	aese	v30.16b, v16.16b
	aese	v28.16b, v16.16b
	aese	v26.16b, v16.16b
	aese	v24.16b, v16.16b
	aese	v22.16b, v16.16b
	aese	v0.16b, v16.16b
	aesmc	v30.16b, v30.16b
	aesmc	v28.16b, v28.16b
	aesmc	v26.16b, v26.16b
	aesmc	v24.16b, v24.16b
	aesmc	v22.16b, v22.16b
	aesmc	v0.16b, v0.16b
	aese	v30.16b, v7.16b
	aese	v28.16b, v7.16b
	aese	v26.16b, v7.16b
	aese	v24.16b, v7.16b
	aese	v22.16b, v7.16b
	aese	v0.16b, v7.16b
	aesmc	v30.16b, v30.16b
	aesmc	v28.16b, v28.16b
	aesmc	v26.16b, v26.16b
	aesmc	v24.16b, v24.16b
	aesmc	v22.16b, v22.16b
	aesmc	v0.16b, v0.16b
	aese	v30.16b, v6.16b
	aese	v28.16b, v6.16b
	aese	v26.16b, v6.16b
	aese	v24.16b, v6.16b
	aese	v22.16b, v6.16b
	aese	v0.16b, v6.16b
	aesmc	v30.16b, v30.16b
	aesmc	v28.16b, v28.16b
	aesmc	v26.16b, v26.16b
	aesmc	v24.16b, v24.16b
	aesmc	v22.16b, v22.16b
	aesmc	v0.16b, v0.16b
	aese	v30.16b, v5.16b
	aese	v28.16b, v5.16b
	aese	v26.16b, v5.16b
	aese	v24.16b, v5.16b
	aese	v22.16b, v5.16b
	aese	v0.16b, v5.16b
	aesmc	v30.16b, v30.16b
	aesmc	v28.16b, v28.16b
	aesmc	v26.16b, v26.16b
	aesmc	v24.16b, v24.16b
	aesmc	v22.16b, v22.16b
	aesmc	v0.16b, v0.16b
	aese	v30.16b, v4.16b
	aese	v28.16b, v4.16b
	aese	v26.16b, v4.16b
	aese	v24.16b, v4.16b
	aese	v22.16b, v4.16b
	aese	v0.16b, v4.16b
	aesmc	v30.16b, v30.16b
	aesmc	v28.16b, v28.16b
	aesmc	v26.16b, v26.16b
	aesmc	v24.16b, v24.16b
	aesmc	v22.16b, v22.16b
	aesmc	v0.16b, v0.16b
	aese	v30.16b, v3.16b
	aese	v28.16b, v3.16b
	aese	v26.16b, v3.16b
	aese	v24.16b, v3.16b
	aese	v22.16b, v3.16b
	aese	v0.16b, v3.16b
	aesmc	v30.16b, v30.16b
	aesmc	v28.16b, v28.16b
	aesmc	v26.16b, v26.16b
	aesmc	v24.16b, v24.16b
	aesmc	v22.16b, v22.16b
	aesmc	v0.16b, v0.16b
	aese	v30.16b, v2.16b
	aese	v28.16b, v2.16b
	aese	v26.16b, v2.16b
	aese	v24.16b, v2.16b
	aese	v22.16b, v2.16b
	eor	v30.16b, v30.16b, v1.16b
	aese	v0.16b, v2.16b
	eor	v28.16b, v28.16b, v1.16b
	eor	v26.16b, v26.16b, v1.16b
	eor	v24.16b, v24.16b, v1.16b
	eor	v22.16b, v22.16b, v1.16b
	eor	v0.16b, v0.16b, v1.16b
	bne	.L384