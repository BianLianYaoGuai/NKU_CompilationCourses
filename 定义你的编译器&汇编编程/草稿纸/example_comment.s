.arch armv7-a


.text @代码段
	.global	a @全局标号a

.bss @未初始化的数据段
	@.align	2 @2字节对齐
	@.type	a, %object @指定符号a的类型是对象类型
	@.size	a, 4 @定义标号a的大小为4字节

	a:
		.space	4 @分配4个字节的连续内存空间,不分配会有事故!!!
		.global	b @全局标号b
		@.align	2 @2字节对齐
		@.type	b, %object @指定符号a的类型是对象类型
		@.size	b, 4 @定义标号b的大小为4字节
	b:
		.space	4

.text
	@.align	1
	.global	max @全局标号max
	@.arch armv7-a
	.syntax unified @指定汇编风格,可以放在一开头,详见https://blog.csdn.net/gzxb1995/article/details/107084219
	.type	max, %function @指定符号a的类型是函数类型

	max:
		@ args = 0, pretend = 0, frame = 8
		@ frame_needed = 1, uses_anonymous_args = 0
		@ link register save eliminated.
		push	{r7}
		sub	sp, sp, #12 @栈指针减12
		add	r7, sp, #0 @r7=sp+#0,等效于`mov r7,sp`
		str	r0, [r7, #4] @[r7+#4]=r0,r0和r1是传入函数的两个参数哦!
		str	r1, [r7] @[r7]=r1
		ldr	r2, [r7, #4] @r2=[r7+#4]
		ldr	r3, [r7] @r3=[r7]
		cmp	r2, r3 @比较r2和r3大小
		blt	.L2 @"Branch if Less Than"
		ldr	r3, [r7, #4] @r3=[r7+#4],其目的是最后无论如何r3都会是最大值
		b	.L3 @无条件分支跳转
	.L2:
		ldr	r3, [r7] @r3=[r7]
	.L3:
		mov	r0, r3 @r0=r3
		adds	r7, r7, #12 @r7=r7+#12,其目的是使栈指针+12
		mov	sp, r7	
		@ sp needed
		ldr	r7, [sp], #4 @r7=[sp],然后sp+=#4,相当于pop?
		bx	lr
		.size	max, .-max
.section	.rodata
	.align	2

	.LC0:
		.ascii	"%d %d\000"
		.align	2
	.LC1:
		.ascii	"max is: %d\012\000"

.text
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.fpu vfpv3-d16
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	add	r7, sp, #0
	ldr	r3, .L6
.LPIC0:
	add	r3, pc
	mov	r2, r3
	ldr	r3, .L6+4
.LPIC1:
	add	r3, pc
	mov	r1, r3
	ldr	r3, .L6+8
.LPIC2:
	add	r3, pc
	mov	r0, r3
	bl	__isoc99_scanf(PLT)
	ldr	r3, .L6+12
.LPIC3:
	add	r3, pc
	ldr	r3, [r3]
	ldr	r2, .L6+16
.LPIC4:
	add	r2, pc
	ldr	r2, [r2]
	mov	r1, r2
	mov	r0, r3
	bl	max(PLT)
	mov	r3, r0
	mov	r1, r3
	ldr	r3, .L6+20
.LPIC5:
	add	r3, pc
	mov	r0, r3
	bl	printf(PLT)
	movs	r3, #0
	mov	r0, r3
	pop	{r7, pc}
.L7:
	.align	2
.L6:
	.word	b-(.LPIC0+4)
	.word	a-(.LPIC1+4)
	.word	.LC0-(.LPIC2+4)
	.word	a-(.LPIC3+4)
	.word	b-(.LPIC4+4)
	.word	.LC1-(.LPIC5+4)
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
