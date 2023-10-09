.arch armv7-a
.text
	.align	1
	.global	main

.arch armv7-a
.syntax unified
.thumb
.thumb_func
.fpu vfpv3-d16

	.type	main, %function
main:
	push	{r7}
	add	r7, sp, #0 @是在代码中的一个无操作(No-op)指令，用于占位或者调整指令的对齐
	movs	r3, #0
	mov	r0, r3
	mov	sp, r7
	@ sp needed
	ldr	r7, [sp], #4
	bx	lr
