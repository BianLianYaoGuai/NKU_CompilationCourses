.arch armv7-a
.syntax unified
.thumb
.thumb_func
.fpu vfpv3-d16

@======================个人习惯==============================
@一、变量=常数
@	涉及寄存器{r0,r1},通用语句如下:
@```
@	ldr	r0, .bridge+4*偏移量
@.符号:
@	add	r0, pc
@	mov r1, 立即数
@	str r1,	[r0]
@.bridge
@	...
@	.word	变量-(.符号+4)
@```
@二、scanf("带%d的字符串",单变量)
@	涉及寄存器{r0,r1},通用语句如下:
@```
@	ldr	r0, .bridge+4*偏移量0
@.符号0:
@	add	r0, pc
@	ldr	r1, .bridge+4*偏移量1
@.符号1:
@	add	r1, pc
@	bl	__isoc99_scanf(PLT)
@.bridge
@	...
@	.word	字符串-(.符号0+4)
@	.word	变量-(.符号1+4)
@```
@三、printf("带%d的字符串",单变量)
@	涉及寄存器{r0,r1},通用语句如下:
@```
@	ldr	r0, .bridge+4*偏移量0
@.符号0:
@	add	r0, pc
@	ldr	r1, .bridge+4*偏移量1
@.符号1:
@	add	r1, pc
@	ldr r1,	[r1]
@	bl	printf(PLT)
@.bridge
@	...
@	.word	字符串-(.符号0+4)
@	.word	变量-(.符号1+4)
@```
@四、while(单一条件判断){}
@	通用语句如下:
@```
@	判断(cmp)...
@	blt	.while数字_start
@.while数字_start:
@	内部循环体...
@.while数字_end:
@	判断(cmp)...
@	blt	.while数字_start
@```
@五、变量0=变量1
@	涉及寄存器{r0,r1},通用语句如下:
@```
@	ldr	r0, .bridge+4*偏移量
@.符号0:
@	add	r0, pc
@	ldr	r1, .bridge+4*偏移量
@.符号1:
@	add	r1, pc
@	ldr r1,	[r1]
@	str r1,	[r0]
@.bridge
@	...
@	.word	变量0-(.符号0+4)
@	.word	变量1-(.符号1+4)
@```

@=======================bss段================================
.bss
.comm a,4,4
.comm b,4,4
.comm i,4,4
.comm t,4,4
.comm n,4,4

@=======================rodata段=============================
.section	.rodata
.LC0:
	.ascii	"%d\000"
.LC1:
	.ascii	"%d\012\000"


@======================text段================================
.text
	.global	main
	.type	main, %function
main:
	push	{r7,lr}

@------------------------a = 0-------------------------------
	ldr	r0, .bridge
.LPIC0:
	add	r0, pc
	mov r1, #0
	str r1,	[r0]

@------------------------b = 1-------------------------------

	ldr	r0, .bridge+4
.LPIC1:
	add	r0, pc
	mov r1, #1
	str r1,	[r0]

@------------------------i = 1-------------------------------

	ldr	r0, .bridge+8
.LPIC2:
	add	r0, pc
	mov r1, #1
	str r1,	[r0]

@------------------------scanf("%d",&n)----------------------

	ldr	r0, .bridge+12
.LPIC3:
	add	r0, pc
	ldr	r1, .bridge+16
.LPIC4:
	add	r1, pc
	bl	__isoc99_scanf(PLT)

@------------------------printf("%d\n",a)----------------------

	ldr	r0, .bridge+20
.LPIC5:
	add	r0, pc
	ldr	r1, .bridge+24
.LPIC6:
	add	r1, pc
	ldr r1,	[r1]
	bl	printf(PLT)

@------------------------printf("%d\n",b)----------------------

	ldr	r0, .bridge+28
.LPIC7:
	add	r0, pc
	ldr	r1, .bridge+32
.LPIC8:
	add	r1, pc
	ldr r1,	[r1]
	bl	printf(PLT)

@------------------------while(){}----------------------

	@------------------------判断-----------------------
		@------------------------取i--------------------
		ldr	r0, .bridge+36
	.LPIC9:
		add	r0, pc
		ldr	r0,	[r0]
		@------------------------取n--------------------
		ldr	r1, .bridge+40
	.LPIC10:
		add	r1, pc
		ldr	r1,	[r1]
		@------------------------cmp跳转----------------
	cmp r0,	r1
	blt	.while0_start

	@------------------------循环体----------------------
.while0_start:
		@------------------------t=b--------------------
		ldr	r0, .bridge+44
	.LPIC11:
		add	r0, pc
		ldr	r1, .bridge+48
	.LPIC12:
		add	r1, pc
		ldr r1,	[r1]
		str r1,	[r0]


		@------------------------b=a+b--------------------
		ldr	r0, .bridge+52
	.LPIC13:
		add	r0, pc
		mov	r1,	r0
		ldr r1,	[r1]
		ldr	r2, .bridge+56
	.LPIC14:
		add	r2, pc
		ldr	r2,	[r2]
		add	r1,	r2
		str r1,	[r0]

		@------------------------printf("%d\n",b)----------------------
		ldr	r0, .bridge+60
	.LPIC15:
		add	r0, pc
		ldr	r1, .bridge+64
	.LPIC16:
		add	r1, pc
		ldr r1,	[r1]
		bl	printf(PLT)

		@------------------------a=t--------------------
		ldr	r0, .bridge+68
	.LPIC17:
		add	r0, pc
		ldr	r1, .bridge+72
	.LPIC18:
		add	r1, pc
		ldr r1,	[r1]
		str r1,	[r0]

		@------------------------i++--------------------
		ldr	r0, .bridge+76
	.LPIC19:
		add	r0, pc
		mov r1,	r0
		ldr r1,	[r1]
		add r1,	#1
		str r1,	[r0]


.while0_end:
@------------------------判断-----------------------
	@------------------------取i--------------------
	ldr	r0, .bridge+80
.LPIC20:
	add	r0, pc
	ldr	r0,	[r0]
	@------------------------取n--------------------
	ldr	r1, .bridge+84
.LPIC21:
	add	r1, pc
	ldr	r1,	[r1]
	@------------------------cmp跳转----------------
cmp r0,	r1
blt	.while0_start


@------------------------return 0----------------------------
ending:
	mov	r0, #0
	pop     {r7,pc}

@------------------------bridge------------------------------
.bridge:
	.word	a-(.LPIC0+4)
	.word	b-(.LPIC1+4)
	.word	i-(.LPIC2+4)
	.word	.LC0-(.LPIC3+4)
	.word	n-(.LPIC4+4)
	.word	.LC1-(.LPIC5+4)
	.word	a-(.LPIC6+4)
	.word	.LC1-(.LPIC7+4)
	.word	b-(.LPIC8+4)
	.word	i-(.LPIC9+4)
	.word	n-(.LPIC10+4)
	.word	t-(.LPIC11+4)
	.word	b-(.LPIC12+4)
	.word	b-(.LPIC13+4)
	.word	a-(.LPIC14+4)
	.word	.LC1-(.LPIC15+4)
	.word	b-(.LPIC16+4)
	.word	a-(.LPIC17+4)
	.word	t-(.LPIC18+4)
	.word	i-(.LPIC19+4)
	.word	i-(.LPIC20+4)
	.word	n-(.LPIC21+4)
