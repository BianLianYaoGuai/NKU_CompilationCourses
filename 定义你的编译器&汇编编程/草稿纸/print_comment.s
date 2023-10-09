.arch armv7-a
.syntax unified
.thumb
.thumb_func
.fpu vfpv3-d16



.text
.align	1
.global	main
.type	main, %function

main:
	push	{r7, lr}
	add	r7, sp, #0
	ldr	r3, .L3


.text
.LPIC0:
	add	r3, pc
	mov	r0, r3
	bl	printf(PLT)
	movs	r3, #0
	mov	r0, r3
	pop	{r7, pc} @ 返回(注意到,这个pop顺便将pc指向lr所指,即返回上级)

.section	.rodata
.align	2
.LC0:
	.ascii	"\350\215\211\346\263\245\351\251\254\000"

.text
.L3:
	.word	.LC0-(.LPIC0+4) @+4的原因是pc指向的其实是下一条指令的位置

