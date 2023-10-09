.arch armv7-a
.syntax unified
.thumb
.thumb_func
.fpu vfpv3-d16

@===================================================================
.section	.rodata 
.LC0:
	.ascii	"%d\000"
.LC1:
	.ascii	"%d\012\000"

@===================================================================
.text
.global	main
.type	main, %function
main:
	push	{r7, lr}
	sub	sp, sp, #8 @栈扩展8
	add	r7, sp, #0 @r7=sp 地址
	ldr	r2, .L4 @r2=.L4 地址
.LPIC2:
	add	r2, pc @r2=pc+r2 地址 GOT表起始
	ldr	r3, .L4+4 @r3=.L4 + 4 地址
	ldr	r3, [r2, r3] @r3=[r2+r3] 值
	ldr	r3, [r3] @r3=[r3]
	str	r3, [r7, #4] @[r7+4]=r3
	mov	r3, r7 @r3=r7
	mov	r1, r3 @r1=r7
	ldr	r3, .L4+8 @r3=.L4+8
.LPIC0:
	add	r3, pc @r3=r3+pc
	mov	r0, r3 @r0=r3
	bl	__isoc99_scanf(PLT) @scanf函数
	ldr	r3, [r7] @r3=[r7]
	mov	r1, r3 @r1=r3
	ldr	r3, .L4+12 @r3=.L4+12
.LPIC1:
	add	r3, pc @r3=r3+pc
	mov	r0, r3 @r0=r3
	bl	printf(PLT)
	movs	r3, #0
	ldr	r1, .L4+16
.LPIC3:
	add	r1, pc
	ldr	r2, .L4+4
	ldr	r2, [r1, r2]
	ldr	r1, [r2]
	ldr	r2, [r7, #4]
	eors	r1, r2, r1
	mov	r2, #0
	beq	.L3
	bl	__stack_chk_fail(PLT)
.L3:
	mov	r0, r3
	adds	r7, r7, #8
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
.L5:
	.align	2
.L4:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC2+4)
	.word	__stack_chk_guard(GOT)
	.word	.LC0-(.LPIC0+4)
	.word	.LC1-(.LPIC1+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC3+4)
