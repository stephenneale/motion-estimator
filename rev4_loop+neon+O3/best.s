	.arch armv7-a
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"main.c"
	.text
	.align	2
	.global	calculate_sad
	.arch armv7-a
	.syntax unified
	.arm
	.fpu neon
	.type	calculate_sad, %function
calculate_sad:
	@ args = 16, pretend = 0, frame = 32
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, lr}
	sub	sp, sp, #36
	ldr	r7, [sp, #64]
	ldr	r4, [sp, #72]
	ldr	ip, [sp, #68]
	ldr	r6, [sp, #76]
	add	r2, r2, #8
	add	r7, r7, #8
	mov	r5, r0
	mov	lr, #16
	mov	r0, #0
	mla	r3, r4, r3, r2
	mla	ip, ip, r4, r7
	mul	r6, r6, r4
	b	.L3
.L2:
	add	r2, sp, #16
	vst1.16	{d18-d19}, [r2:64]
	vst1.16	{d16-d17}, [sp:64]
	ldrh	r7, [sp, #16]
	ldrh	r2, [sp]
	ldrh	r8, [sp, #2]
	add	r2, r2, r7
	ldrh	r7, [sp, #18]
	add	r2, r2, r8
	ldrh	r8, [sp, #4]
	add	r2, r2, r7
	ldrh	r7, [sp, #20]
	add	r2, r2, r8
	ldrh	r8, [sp, #6]
	add	r2, r2, r7
	ldrh	r7, [sp, #22]
	add	r2, r2, r8
	ldrh	r8, [sp, #8]
	add	r2, r2, r7
	ldrh	r7, [sp, #24]
	add	r2, r2, r8
	ldrh	r8, [sp, #10]
	add	r2, r2, r7
	ldrh	r7, [sp, #26]
	add	r2, r2, r8
	ldrh	r8, [sp, #12]
	add	r2, r2, r7
	ldrh	r7, [sp, #28]
	add	r2, r2, r8
	ldrh	r8, [sp, #14]
	add	r2, r2, r7
	ldrh	r7, [sp, #30]
	add	r2, r2, r8
	add	r2, r2, r7
	add	r0, r0, r2
	subs	lr, lr, #1
	add	r3, r3, r4
	add	ip, ip, r4
	uxth	r0, r0
	beq	.L7
.L3:
	cmp	r3, ip
	movge	r2, r3
	movlt	r2, ip
	vmov.i32	q8, #0  @ v8hi
	cmp	r2, r6
	vmov	q9, q8  @ v8hi
	bge	.L2
	add	r7, r5, r3
	add	r2, ip, r1
	sub	r9, r7, #8
	sub	r8, r2, #8
	vld1.8	{d19}, [r8]
	vld1.8	{d17}, [r2]
	vld1.8	{d16}, [r9]
	vld1.8	{d18}, [r7]
	vabd.u8	d16, d16, d19
	vabd.u8	d18, d18, d17
	vmovl.u8	q8, d16
	vmovl.u8	q9, d18
	b	.L2
.L7:
	add	sp, sp, #36
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, pc}
	.size	calculate_sad, .-calculate_sad
	.align	2
	.global	find_best_match
	.syntax unified
	.arm
	.fpu neon
	.type	find_best_match, %function
find_best_match:
	@ args = 16, pretend = 0, frame = 32
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	sub	sp, sp, #52
	sub	r6, r3, #7
	ldrd	r8, [sp, #88]
	str	r3, [sp, #32]
	add	fp, r3, #8
	movw	r3, #65535
	str	r2, [sp, #16]
	sub	r2, r2, #7
	str	r2, [sp, #40]
	rsb	r2, r2, #-16777216
	add	r2, r2, #16711680
	add	r2, r2, #65280
	add	r2, r2, #249
	str	r6, [sp, #36]
	strd	r0, [sp, #24]
	str	r2, [sp, #44]
	str	r3, [sp, #20]
	b	.L9
.L13:
	add	r6, r6, #1
	cmp	r6, fp
	beq	.L8
.L9:
	mvn	r5, r6
	add	r3, r6, #15
	cmp	r9, r3
	lsr	r5, r5, #31
	ble	.L13
	movw	r10, #65529
	ldr	r3, [sp, #36]
	movt	r10, 65535
	sub	r10, r10, r3
	ldr	r3, [sp, #16]
	ldr	r4, [sp, #40]
	add	r10, r10, r6
	add	r7, r3, #8
.L11:
	cmp	r4, #0
	movlt	r3, #0
	andge	r3, r5, #1
	cmp	r3, #0
	add	r2, r4, #15
	beq	.L10
	cmp	r8, r2
	ble	.L10
	ldrd	r0, [sp, #24]
	ldr	r3, [sp, #32]
	strd	r8, [sp, #8]
	stm	sp, {r4, r6}
	ldr	r2, [sp, #16]
	bl	calculate_sad
	ldr	r3, [sp, #20]
	cmp	r0, r3
	bcs	.L10
	ldr	r3, [sp, #44]
	ldr	r2, [sp, #96]
	add	r3, r3, r4
	strb	r3, [r2]
	ldr	r3, [sp, #100]
	str	r0, [sp, #20]
	strb	r10, [r3]
.L10:
	add	r4, r4, #1
	cmp	r7, r4
	bne	.L11
	add	r6, r6, #1
	cmp	r6, fp
	bne	.L9
.L8:
	add	sp, sp, #52
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
	.size	find_best_match, .-find_best_match
	.align	2
	.global	motion_estimation
	.syntax unified
	.arm
	.fpu neon
	.type	motion_estimation, %function
motion_estimation:
	@ args = 4, pretend = 0, frame = 56
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r3, #0
	bxle	lr
	cmp	r2, #0
	add	ip, r2, #15
	movge	ip, r2
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	asr	ip, ip, #4
	sub	sp, sp, #76
	str	ip, [sp, #64]
	ble	.L19
	mov	fp, r2
	str	r3, [sp, #16]
	sub	r2, r3, #1
	sub	r3, fp, #1
	bic	r3, r3, #15
	mov	r4, #8
	mvn	r5, #6
	add	r3, r3, #16
	str	r3, [sp, #56]
	mov	r3, #7
	bic	r2, r2, #15
	strd	r0, [sp, #44]
	strd	r4, [sp, #28]
	add	r2, r2, #9
	str	r2, [sp, #68]
	str	r3, [sp, #60]
.L22:
	mov	r10, #0
	ldr	r2, [sp, #32]
	adds	r3, r2, #7
	str	r3, [sp, #36]
	addmi	r3, r2, #22
	ldr	r2, [sp, #64]
	asr	r3, r3, #4
	mul	r3, r2, r3
	str	r3, [sp, #52]
	ldr	r3, [sp, #60]
	sub	r3, r3, #7
	str	r3, [sp, #40]
.L29:
	mov	r8, #0
	add	r3, r10, #8
	ldr	r5, [sp, #32]
	mov	r6, r8
	movw	r9, #65535
	str	r3, [sp, #24]
	b	.L28
.L26:
	ldr	r3, [sp, #28]
	add	r5, r5, #1
	cmp	r5, r3
	beq	.L25
.L28:
	mvn	r2, r5
	lsr	r2, r2, #31
	str	r2, [sp, #20]
	ldr	r2, [sp, #16]
	add	r3, r5, #15
	cmp	r2, r3
	ble	.L26
	ldr	r3, [sp, #40]
	sub	r4, r10, #7
	add	r7, r3, r5
	sxtb	r7, r7
.L24:
	ldr	r2, [sp, #20]
	add	r3, r4, #15
	cmp	r4, #0
	movlt	r2, #0
	andge	r2, r2, #1
	cmp	r2, #0
	beq	.L23
	cmp	fp, r3
	ble	.L23
	ldrd	r0, [sp, #44]
	ldr	r3, [sp, #16]
	stm	sp, {r4, r5, fp}
	str	r3, [sp, #12]
	mov	r2, r10
	ldr	r3, [sp, #36]
	bl	calculate_sad
	cmp	r0, r9
	movcc	r9, r0
	movcc	r8, r7
	subcc	r6, r4, r10
	sxtbcc	r6, r6
.L23:
	ldr	r3, [sp, #24]
	add	r4, r4, #1
	cmp	r4, r3
	bne	.L24
	ldr	r3, [sp, #28]
	add	r5, r5, #1
	cmp	r5, r3
	bne	.L28
.L25:
	ldr	r3, [sp, #52]
	ldr	r2, [sp, #56]
	add	r3, r3, r10, asr #4
	add	r10, r10, #16
	cmp	r10, r2
	ldr	r2, [sp, #112]
	ldr	r1, [sp, #112]
	add	r2, r2, r3, lsl #1
	strb	r6, [r1, r3, lsl #1]
	strb	r8, [r2, #1]
	bne	.L29
	ldr	r3, [sp, #32]
	ldr	r2, [sp, #68]
	add	r3, r3, #16
	str	r3, [sp, #32]
	cmp	r3, r2
	ldr	r3, [sp, #60]
	sub	r3, r3, #16
	uxtb	r3, r3
	str	r3, [sp, #60]
	ldr	r3, [sp, #28]
	add	r3, r3, #16
	str	r3, [sp, #28]
	bne	.L22
.L19:
	add	sp, sp, #76
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
	.size	motion_estimation, .-motion_estimation
	.align	2
	.global	read_image_from_text
	.syntax unified
	.arm
	.fpu neon
	.type	read_image_from_text, %function
read_image_from_text:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r9, r1
	movw	r1, #:lower16:.LC0
	sub	sp, sp, #20
	movt	r1, #:upper16:.LC0
	mov	r10, r2
	bl	fopen
	subs	r6, r0, #0
	beq	.L48
	mul	r0, r10, r9
	bl	malloc
	subs	r3, r0, #0
	str	r3, [sp, #4]
	beq	.L41
	cmp	r10, #0
	ble	.L42
	cmp	r9, #0
	ble	.L42
	movw	r5, #:lower16:.LC3
	mov	r7, #0
	add	r4, r3, r9
	lsl	r3, r9, #1
	movt	r5, #:upper16:.LC3
	str	r3, [sp]
.L43:
	sub	r8, r4, r9
	mov	fp, r8
.L44:
	add	r2, sp, #12
	mov	r1, r5
	mov	r0, r6
	bl	__isoc99_fscanf
	ldr	r3, [sp, #12]
	strb	r3, [fp], #1
	cmp	r4, fp
	bne	.L44
	add	r7, r7, #1
	ldr	r3, [sp]
	cmp	r10, r7
	add	r4, r3, r8
	bne	.L43
.L42:
	mov	r0, r6
	bl	fclose
	ldr	r0, [sp, #4]
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L48:
	movw	r0, #:lower16:.LC1
	movt	r0, #:upper16:.LC1
	bl	perror
	mov	r0, #1
	bl	exit
.L41:
	movw	r0, #:lower16:.LC2
	movt	r0, #:upper16:.LC2
	bl	perror
	mov	r0, #1
	bl	exit
	.size	read_image_from_text, .-read_image_from_text
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu neon
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	movw	r0, #:lower16:.LC4
	push	{r4, r5, r6, r7, r8, r9, lr}
	mov	r2, #240
	sub	sp, sp, #12
	mov	r1, #320
	movt	r0, #:upper16:.LC4
	bl	read_image_from_text
	mov	r9, r0
	movw	r0, #:lower16:.LC5
	mov	r2, #240
	mov	r1, #320
	movt	r0, #:upper16:.LC5
	bl	read_image_from_text
	mov	r8, r0
	mov	r0, #600
	bl	malloc
	movw	r6, #:lower16:.LC6
	mov	r5, r0
	str	r0, [sp]
	mov	r1, r8
	mov	r0, r9
	mov	r3, #240
	mov	r2, #320
	bl	motion_estimation
	mov	r4, #0
	add	r7, r5, #1
	movt	r6, #:upper16:.LC6
.L50:
	lsl	r2, r4, #1
	ldrsb	r3, [r7, r2]
	mov	r1, r4
	ldrsb	r2, [r5, r2]
	mov	r0, r6
	add	r4, r4, #1
	bl	printf
	cmp	r4, #300
	bne	.L50
	mov	r0, r9
	bl	free
	mov	r0, r8
	bl	free
	mov	r0, r5
	bl	free
	mov	r0, #0
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, pc}
	.size	main, .-main
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"r\000"
	.space	2
.LC1:
	.ascii	"Error opening file\000"
	.space	1
.LC2:
	.ascii	"Error allocating memory\000"
.LC3:
	.ascii	"%u\000"
	.space	1
.LC4:
	.ascii	"../utils/current_frame.txt\000"
	.space	1
.LC5:
	.ascii	"../utils/reference_frame.txt\000"
	.space	3
.LC6:
	.ascii	"Block %d: MVx = %d, MVy = %d\012\000"
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits
