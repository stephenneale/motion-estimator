	.arch armv7-a
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"main.c"
	.text
	.align	2
	.global	calculate_sad
	.arch armv7-a
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	calculate_sad, %function
calculate_sad:
	@ args = 16, pretend = 0, frame = 96
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #100
	str	r0, [fp, #-88]
	str	r1, [fp, #-92]
	str	r2, [fp, #-96]
	str	r3, [fp, #-100]
	mov	r3, #0
	strh	r3, [fp, #-6]	@ movhi
	mov	r3, #0
	str	r3, [fp, #-12]
	mov	r3, #0
	str	r3, [fp, #-16]
	b	.L2
.L6:
	mov	r3, #0
	str	r3, [fp, #-16]
	b	.L3
.L5:
	ldr	r2, [fp, #-100]
	ldr	r3, [fp, #-12]
	add	r3, r2, r3
	ldr	r2, [fp, #12]
	mul	r2, r2, r3
	ldr	r1, [fp, #-96]
	ldr	r3, [fp, #-16]
	add	r3, r1, r3
	add	r3, r2, r3
	str	r3, [fp, #-28]
	ldr	r2, [fp, #8]
	ldr	r3, [fp, #-12]
	add	r3, r2, r3
	ldr	r2, [fp, #12]
	mul	r2, r2, r3
	ldr	r1, [fp, #4]
	ldr	r3, [fp, #-16]
	add	r3, r1, r3
	add	r3, r2, r3
	str	r3, [fp, #-32]
	ldr	r3, [fp, #12]
	ldr	r2, [fp, #16]
	mul	r3, r2, r3
	ldr	r2, [fp, #-28]
	cmp	r2, r3
	bge	.L4
	ldr	r3, [fp, #12]
	ldr	r2, [fp, #16]
	mul	r3, r2, r3
	ldr	r2, [fp, #-32]
	cmp	r2, r3
	bge	.L4
	ldr	r3, [fp, #-28]
	ldr	r2, [fp, #-88]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	mov	r1, r3
	ldr	r3, [fp, #-32]
	ldr	r2, [fp, #-92]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	sub	r3, r1, r3
	cmp	r3, #0
	rsblt	r3, r3, #0
	uxth	r2, r3
	ldrh	r3, [fp, #-6]	@ movhi
	add	r3, r2, r3
	strh	r3, [fp, #-6]	@ movhi
.L4:
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L3:
	ldr	r3, [fp, #-16]
	cmp	r3, #15
	ble	.L5
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L2:
	ldr	r3, [fp, #-12]
	cmp	r3, #2
	ble	.L6
	b	.L7
.L15:
	sub	r3, fp, #80
	mov	r2, #0
	str	r2, [r3]
	str	r2, [r3, #4]
	mov	r3, #0
	str	r3, [fp, #-20]
	b	.L8
.L12:
	mov	r3, #0
	str	r3, [fp, #-16]
	b	.L9
.L11:
	ldr	r2, [fp, #-100]
	ldr	r3, [fp, #-12]
	add	r2, r2, r3
	ldr	r3, [fp, #-20]
	add	r3, r2, r3
	ldr	r2, [fp, #12]
	mul	r2, r2, r3
	ldr	r1, [fp, #-96]
	ldr	r3, [fp, #-16]
	add	r3, r1, r3
	add	r2, r2, r3
	ldr	r3, [fp, #-20]
	lsl	r3, r3, #2
	sub	r1, fp, #4
	add	r3, r1, r3
	str	r2, [r3, #-52]
	ldr	r2, [fp, #8]
	ldr	r3, [fp, #-12]
	add	r2, r2, r3
	ldr	r3, [fp, #-20]
	add	r3, r2, r3
	ldr	r2, [fp, #12]
	mul	r2, r2, r3
	ldr	r1, [fp, #4]
	ldr	r3, [fp, #-16]
	add	r3, r1, r3
	add	r2, r2, r3
	ldr	r3, [fp, #-20]
	lsl	r3, r3, #2
	sub	r1, fp, #4
	add	r3, r1, r3
	str	r2, [r3, #-68]
	ldr	r3, [fp, #-20]
	lsl	r3, r3, #2
	sub	r2, fp, #4
	add	r3, r2, r3
	ldr	r2, [r3, #-52]
	ldr	r3, [fp, #12]
	ldr	r1, [fp, #16]
	mul	r3, r1, r3
	cmp	r2, r3
	bge	.L10
	ldr	r3, [fp, #-20]
	lsl	r3, r3, #2
	sub	r2, fp, #4
	add	r3, r2, r3
	ldr	r2, [r3, #-68]
	ldr	r3, [fp, #12]
	ldr	r1, [fp, #16]
	mul	r3, r1, r3
	cmp	r2, r3
	bge	.L10
	ldr	r3, [fp, #-20]
	lsl	r3, r3, #1
	sub	r2, fp, #4
	add	r3, r2, r3
	sub	r3, r3, #76
	ldrh	r2, [r3]
	ldr	r3, [fp, #-20]
	lsl	r3, r3, #2
	sub	r1, fp, #4
	add	r3, r1, r3
	ldr	r3, [r3, #-52]
	mov	r1, r3
	ldr	r3, [fp, #-88]
	add	r3, r3, r1
	ldrb	r3, [r3]	@ zero_extendqisi2
	mov	r1, r3
	ldr	r3, [fp, #-20]
	lsl	r3, r3, #2
	sub	r0, fp, #4
	add	r3, r0, r3
	ldr	r3, [r3, #-68]
	mov	r0, r3
	ldr	r3, [fp, #-92]
	add	r3, r3, r0
	ldrb	r3, [r3]	@ zero_extendqisi2
	sub	r3, r1, r3
	cmp	r3, #0
	rsblt	r3, r3, #0
	uxth	r3, r3
	add	r3, r2, r3
	uxth	r2, r3
	ldr	r3, [fp, #-20]
	lsl	r3, r3, #1
	sub	r1, fp, #4
	add	r3, r1, r3
	sub	r3, r3, #76
	strh	r2, [r3]	@ movhi
.L10:
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L9:
	ldr	r3, [fp, #-16]
	cmp	r3, #15
	ble	.L11
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	str	r3, [fp, #-20]
.L8:
	ldr	r3, [fp, #-20]
	cmp	r3, #3
	ble	.L12
	mov	r3, #0
	str	r3, [fp, #-24]
	b	.L13
.L14:
	ldr	r3, [fp, #-24]
	lsl	r3, r3, #1
	sub	r2, fp, #4
	add	r3, r2, r3
	sub	r3, r3, #76
	ldrh	r2, [r3]
	ldrh	r3, [fp, #-6]	@ movhi
	add	r3, r2, r3
	strh	r3, [fp, #-6]	@ movhi
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L13:
	ldr	r3, [fp, #-24]
	cmp	r3, #3
	ble	.L14
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L7:
	ldr	r3, [fp, #-12]
	cmp	r3, #12
	ble	.L15
	b	.L16
.L20:
	mov	r3, #0
	str	r3, [fp, #-16]
	b	.L17
.L19:
	ldr	r2, [fp, #-100]
	ldr	r3, [fp, #-12]
	add	r3, r2, r3
	ldr	r2, [fp, #12]
	mul	r2, r2, r3
	ldr	r1, [fp, #-96]
	ldr	r3, [fp, #-16]
	add	r3, r1, r3
	add	r3, r2, r3
	str	r3, [fp, #-36]
	ldr	r2, [fp, #8]
	ldr	r3, [fp, #-12]
	add	r3, r2, r3
	ldr	r2, [fp, #12]
	mul	r2, r2, r3
	ldr	r1, [fp, #4]
	ldr	r3, [fp, #-16]
	add	r3, r1, r3
	add	r3, r2, r3
	str	r3, [fp, #-40]
	ldr	r3, [fp, #12]
	ldr	r2, [fp, #16]
	mul	r3, r2, r3
	ldr	r2, [fp, #-36]
	cmp	r2, r3
	bge	.L18
	ldr	r3, [fp, #12]
	ldr	r2, [fp, #16]
	mul	r3, r2, r3
	ldr	r2, [fp, #-40]
	cmp	r2, r3
	bge	.L18
	ldr	r3, [fp, #-36]
	ldr	r2, [fp, #-88]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	mov	r1, r3
	ldr	r3, [fp, #-40]
	ldr	r2, [fp, #-92]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	sub	r3, r1, r3
	cmp	r3, #0
	rsblt	r3, r3, #0
	uxth	r2, r3
	ldrh	r3, [fp, #-6]	@ movhi
	add	r3, r2, r3
	strh	r3, [fp, #-6]	@ movhi
.L18:
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L17:
	ldr	r3, [fp, #-16]
	cmp	r3, #15
	ble	.L19
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L16:
	ldr	r3, [fp, #-12]
	cmp	r3, #15
	ble	.L20
	ldrh	r3, [fp, #-6]
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	calculate_sad, .-calculate_sad
	.align	2
	.global	find_best_match
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	find_best_match, %function
find_best_match:
	@ args = 16, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #56
	str	r0, [fp, #-32]
	str	r1, [fp, #-36]
	str	r2, [fp, #-40]
	str	r3, [fp, #-44]
	mvn	r3, #0
	strh	r3, [fp, #-6]	@ movhi
	mvn	r3, #6
	str	r3, [fp, #-12]
	b	.L23
.L27:
	mvn	r3, #6
	str	r3, [fp, #-16]
	b	.L24
.L26:
	ldr	r2, [fp, #-40]
	ldr	r3, [fp, #-16]
	add	r3, r2, r3
	str	r3, [fp, #-20]
	ldr	r2, [fp, #-44]
	ldr	r3, [fp, #-12]
	add	r3, r2, r3
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	blt	.L25
	ldr	r3, [fp, #-24]
	cmp	r3, #0
	blt	.L25
	ldr	r3, [fp, #-20]
	add	r3, r3, #15
	ldr	r2, [fp, #4]
	cmp	r2, r3
	ble	.L25
	ldr	r3, [fp, #-24]
	add	r3, r3, #15
	ldr	r2, [fp, #8]
	cmp	r2, r3
	ble	.L25
	ldr	r3, [fp, #8]
	str	r3, [sp, #12]
	ldr	r3, [fp, #4]
	str	r3, [sp, #8]
	ldr	r3, [fp, #-24]
	str	r3, [sp, #4]
	ldr	r3, [fp, #-20]
	str	r3, [sp]
	ldr	r3, [fp, #-44]
	ldr	r2, [fp, #-40]
	ldr	r1, [fp, #-36]
	ldr	r0, [fp, #-32]
	bl	calculate_sad
	mov	r3, r0
	strh	r3, [fp, #-26]	@ movhi
	ldrh	r2, [fp, #-26]
	ldrh	r3, [fp, #-6]
	cmp	r2, r3
	bcs	.L25
	ldrh	r3, [fp, #-26]	@ movhi
	strh	r3, [fp, #-6]	@ movhi
	ldr	r3, [fp, #-20]
	uxtb	r2, r3
	ldr	r3, [fp, #-40]
	uxtb	r3, r3
	sub	r3, r2, r3
	uxtb	r3, r3
	sxtb	r2, r3
	ldr	r3, [fp, #12]
	strb	r2, [r3]
	ldr	r3, [fp, #-24]
	uxtb	r2, r3
	ldr	r3, [fp, #-44]
	uxtb	r3, r3
	sub	r3, r2, r3
	uxtb	r3, r3
	sxtb	r2, r3
	ldr	r3, [fp, #16]
	strb	r2, [r3]
.L25:
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L24:
	ldr	r3, [fp, #-16]
	cmp	r3, #7
	ble	.L26
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L23:
	ldr	r3, [fp, #-12]
	cmp	r3, #7
	ble	.L27
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	find_best_match, .-find_best_match
	.align	2
	.global	motion_estimation
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	motion_estimation, %function
motion_estimation:
	@ args = 4, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #48
	str	r0, [fp, #-24]
	str	r1, [fp, #-28]
	str	r2, [fp, #-32]
	str	r3, [fp, #-36]
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L29
.L32:
	mov	r3, #0
	str	r3, [fp, #-12]
	b	.L30
.L31:
	mov	r3, #0
	strb	r3, [fp, #-17]
	mov	r3, #0
	strb	r3, [fp, #-18]
	sub	r3, fp, #18
	str	r3, [sp, #12]
	sub	r3, fp, #17
	str	r3, [sp, #8]
	ldr	r3, [fp, #-36]
	str	r3, [sp, #4]
	ldr	r3, [fp, #-32]
	str	r3, [sp]
	ldr	r3, [fp, #-8]
	ldr	r2, [fp, #-12]
	ldr	r1, [fp, #-28]
	ldr	r0, [fp, #-24]
	bl	find_best_match
	ldr	r3, [fp, #-8]
	add	r2, r3, #15
	cmp	r3, #0
	movlt	r3, r2
	movge	r3, r3
	asr	r3, r3, #4
	mov	r1, r3
	ldr	r3, [fp, #-32]
	add	r2, r3, #15
	cmp	r3, #0
	movlt	r3, r2
	movge	r3, r3
	asr	r3, r3, #4
	mul	r2, r3, r1
	ldr	r3, [fp, #-12]
	add	r1, r3, #15
	cmp	r3, #0
	movlt	r3, r1
	movge	r3, r3
	asr	r3, r3, #4
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	lsl	r3, r3, #1
	mov	r2, r3
	ldr	r3, [fp, #4]
	add	r3, r3, r2
	ldrsb	r2, [fp, #-17]
	strb	r2, [r3]
	ldr	r3, [fp, #-16]
	lsl	r3, r3, #1
	add	r3, r3, #1
	ldr	r2, [fp, #4]
	add	r3, r2, r3
	ldrsb	r2, [fp, #-18]
	strb	r2, [r3]
	ldr	r3, [fp, #-12]
	add	r3, r3, #16
	str	r3, [fp, #-12]
.L30:
	ldr	r2, [fp, #-12]
	ldr	r3, [fp, #-32]
	cmp	r2, r3
	blt	.L31
	ldr	r3, [fp, #-8]
	add	r3, r3, #16
	str	r3, [fp, #-8]
.L29:
	ldr	r2, [fp, #-8]
	ldr	r3, [fp, #-36]
	cmp	r2, r3
	blt	.L32
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	motion_estimation, .-motion_estimation
	.section	.rodata
	.align	2
.LC0:
	.ascii	"r\000"
	.align	2
.LC1:
	.ascii	"Error opening file\000"
	.align	2
.LC2:
	.ascii	"Error allocating memory\000"
	.align	2
.LC3:
	.ascii	"%u\000"
	.text
	.align	2
	.global	read_image_from_text
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	read_image_from_text, %function
read_image_from_text:
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #40
	str	r0, [fp, #-32]
	str	r1, [fp, #-36]
	str	r2, [fp, #-40]
	movw	r1, #:lower16:.LC0
	movt	r1, #:upper16:.LC0
	ldr	r0, [fp, #-32]
	bl	fopen
	str	r0, [fp, #-16]
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bne	.L34
	movw	r0, #:lower16:.LC1
	movt	r0, #:upper16:.LC1
	bl	perror
	mov	r0, #1
	bl	exit
.L34:
	ldr	r3, [fp, #-36]
	ldr	r2, [fp, #-40]
	mul	r3, r2, r3
	mov	r0, r3
	bl	malloc
	mov	r3, r0
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	bne	.L35
	movw	r0, #:lower16:.LC2
	movt	r0, #:upper16:.LC2
	bl	perror
	mov	r0, #1
	bl	exit
.L35:
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L36
.L39:
	mov	r3, #0
	str	r3, [fp, #-12]
	b	.L37
.L38:
	sub	r3, fp, #24
	mov	r2, r3
	movw	r1, #:lower16:.LC3
	movt	r1, #:upper16:.LC3
	ldr	r0, [fp, #-16]
	bl	__isoc99_fscanf
	ldr	r1, [fp, #-24]
	ldr	r3, [fp, #-8]
	ldr	r2, [fp, #-36]
	mul	r2, r2, r3
	ldr	r3, [fp, #-12]
	add	r3, r2, r3
	mov	r2, r3
	ldr	r3, [fp, #-20]
	add	r3, r3, r2
	uxtb	r2, r1
	strb	r2, [r3]
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L37:
	ldr	r2, [fp, #-12]
	ldr	r3, [fp, #-36]
	cmp	r2, r3
	blt	.L38
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L36:
	ldr	r2, [fp, #-8]
	ldr	r3, [fp, #-40]
	cmp	r2, r3
	blt	.L39
	ldr	r0, [fp, #-16]
	bl	fclose
	ldr	r3, [fp, #-20]
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	read_image_from_text, .-read_image_from_text
	.section	.rodata
	.align	2
.LC4:
	.ascii	"../utils/current_frame.txt\000"
	.align	2
.LC5:
	.ascii	"../utils/reference_frame.txt\000"
	.align	2
.LC6:
	.ascii	"Block %d: MVx = %d, MVy = %d\012\000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #32
	mov	r3, #320
	str	r3, [fp, #-12]
	mov	r3, #240
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r1, [fp, #-12]
	movw	r0, #:lower16:.LC4
	movt	r0, #:upper16:.LC4
	bl	read_image_from_text
	str	r0, [fp, #-20]
	ldr	r2, [fp, #-16]
	ldr	r1, [fp, #-12]
	movw	r0, #:lower16:.LC5
	movt	r0, #:upper16:.LC5
	bl	read_image_from_text
	str	r0, [fp, #-24]
	ldr	r3, [fp, #-12]
	add	r2, r3, #15
	cmp	r3, #0
	movlt	r3, r2
	movge	r3, r3
	asr	r3, r3, #4
	mov	r1, r3
	ldr	r3, [fp, #-16]
	add	r2, r3, #15
	cmp	r3, #0
	movlt	r3, r2
	movge	r3, r3
	asr	r3, r3, #4
	mul	r3, r3, r1
	lsl	r3, r3, #1
	mov	r0, r3
	bl	malloc
	mov	r3, r0
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-28]
	str	r3, [sp]
	ldr	r3, [fp, #-16]
	ldr	r2, [fp, #-12]
	ldr	r1, [fp, #-24]
	ldr	r0, [fp, #-20]
	bl	motion_estimation
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L42
.L43:
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #1
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r3, r3, r2
	ldrsb	r3, [r3]
	mov	r1, r3
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #1
	add	r3, r3, #1
	ldr	r2, [fp, #-28]
	add	r3, r2, r3
	ldrsb	r3, [r3]
	mov	r2, r1
	ldr	r1, [fp, #-8]
	movw	r0, #:lower16:.LC6
	movt	r0, #:upper16:.LC6
	bl	printf
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L42:
	ldr	r3, [fp, #-12]
	add	r2, r3, #15
	cmp	r3, #0
	movlt	r3, r2
	movge	r3, r3
	asr	r3, r3, #4
	mov	r1, r3
	ldr	r3, [fp, #-16]
	add	r2, r3, #15
	cmp	r3, #0
	movlt	r3, r2
	movge	r3, r3
	asr	r3, r3, #4
	mul	r3, r3, r1
	ldr	r2, [fp, #-8]
	cmp	r2, r3
	blt	.L43
	ldr	r0, [fp, #-20]
	bl	free
	ldr	r0, [fp, #-24]
	bl	free
	ldr	r0, [fp, #-28]
	bl	free
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	main, .-main
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits
