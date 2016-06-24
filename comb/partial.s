ldr	x0, [x4]
	cmp	x6, x7
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
	mov	x2, x6
	bne	.L68
	.p2align 2