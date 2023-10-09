.arch armv7-a
.syntax unified
.thumb
.thumb_func
.fpu vfpv3-d16

.text
	.global	a
	.type	a, %object
.bss
a:
	.space	4

.comm	b,4,4 
@在BSS(Block Started by Symbol)段中分配一个名为b的未初始化的全局变量,大小为4个字节,对齐方式为4字节
@BSS段是用于存放未初始化的全局变量和静态变量的一部分内存空间,其与data段的区别问gpt即可
@.comm 表示目标文件中的 common symbol,表示公共的符号

.section	.rodata
.LC0:
	.ascii	"%d\012\000"

.text
.global	main
.type	main, %function
main:
	push	{r4, r7, lr}
	sub	sp, sp, #12
	add	r7, sp, #0
	ldr	r4, .L3
.LPIC1:
	add	r4, pc
	movs	r3, #0
	str	r3, [r7]
	ldr	r3, .L3+4
.LPIC0:
	add	r3, pc
	mov	r2, r3
	movs	r3, #1
	str	r3, [r2]
	ldr	r3, .L3+8
	ldr	r3, [r4, r3]
	mov	r2, r3
	movs	r3, #2
	str	r3, [r2]
	movs	r3, #3
	str	r3, [r7]
	movs	r3, #4
	str	r3, [r7, #4]
	ldr	r3, .L3+12
.LPIC2:
	add	r3, pc
	ldr	r3, [r3]
	mov	r1, r3
	ldr	r3, .L3+16
.LPIC3:
	add	r3, pc
	mov	r0, r3
	bl	printf(PLT)
	ldr	r3, .L3+8
	ldr	r3, [r4, r3]
	ldr	r3, [r3]
	mov	r1, r3
	ldr	r3, .L3+20
.LPIC4:
	add	r3, pc
	mov	r0, r3
	bl	printf(PLT)
	ldr	r1, [r7]
	ldr	r3, .L3+24
.LPIC5:
	add	r3, pc
	mov	r0, r3
	bl	printf(PLT)
	ldr	r1, [r7, #4]
	ldr	r3, .L3+28
.LPIC6:
	add	r3, pc
	mov	r0, r3
	bl	printf(PLT)
	movs	r3, #0
	mov	r0, r3
	adds	r7, r7, #12
	mov	sp, r7
	@ sp needed
	pop	{r4, r7, pc}
.L4:
	.align	2
.L3:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC1+4)
	.word	a-(.LPIC0+4)
	.word	b(GOT)
	.word	a-(.LPIC2+4)
	.word	.LC0-(.LPIC3+4)
	.word	.LC0-(.LPIC4+4)
	.word	.LC0-(.LPIC5+4)
	.word	.LC0-(.LPIC6+4)
	.size	main, .-main
