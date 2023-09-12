# 关于工具的疑问解答

## 1. apt 和 apt-get 的区别

apt 是在 apt-get 之后引入的，旨在提供更强大和易用的软件包管理工具。简单来说就是：apt 是 apt-get、apt-cache 和 apt-config 中最常用命令选项的集合。apt并不能完全向下兼容 apt-get 命令。但是作为普通用户，更推荐使用apt。

## 2.  gcc-arm-linux-gnueabi 和 gcc-arm-linux-gnueabihf 的区别

gcc-arm-linux-gnueabi 和 gcc-arm-linux-gnueabihf 都是用于交叉编译（cross-compilation）的GCC编译器，用于将源代码编译成在ARM架构上运行的可执行文件。它们之间的主要区别在于如何处理浮点运算和硬件浮点单元。

`gcc-arm-linux-gnueabi`：
   - EABI (Embedded Application Binary Interface) 是一种嵌入式应用二进制接口，它定义了二进制接口规范，用于ARM架构上的嵌入式系统。
   - `gnueabi` 表示它使用GNU工具链，并且不假设目标设备具有硬件浮点单元（FPU）。
   - 当使用这个编译器时，生成的可执行文件会使用软件浮点运算，即它会包含一组软件库函数来模拟浮点运算，因为它不依赖于硬件浮点单元。这使得生成的可执行文件更通用，可以在不同的ARM设备上运行，但性能可能较低。

`gcc-arm-linux-gnueabihf`：
   - `gnueabihf` 中的 `hf` 表示使用硬件浮点单元（Hard Float），这意味着它假定目标ARM设备具有硬件浮点单元（FPU）。
   - 当使用这个编译器时，生成的可执行文件会直接使用硬件浮点单元执行浮点运算，而不是通过软件库函数来模拟。


# 熟悉arm工具链

## 1. main.c

我编写了一个最简单的c文件`main.c`，内容如下：

```c
#include <stdio.h>
int main() {
    printf("Hello, World!\n");
    return 0;
}
```

## 2. arm.s

使用如下命令编译

```bash
arm-linux-gnueabihf-gcc -o arm.s -S -O0 main.c -fno-asynchronous-unwind-tables
```

其中，一些参数的含义如下
|参数|含义|
|---|---|
| -S | (编译)告诉编译器只生成汇编代码而不生成可执行的二进制文件 |
| -O0  | (优化)指定编译器不进行优化  |
| -fno-asynchronous-unwind-tables | (编译)用于禁用生成用于异步取消（例如在多线程程序中）的取消信息的表格。这个选项可能会减小生成的汇编代码的大小，但会失去一些调试和错误处理的信息。 |

注：我不能理解-fno-asynchronous-unwind-tables所述的“异步取消表格”！！！

得到汇编代码`arm.S`,内容如下：

```asm
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
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Hello, World!\000"
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
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	add	r7, sp, #0
	ldr	r3, .L3
.LPIC0:
	add	r3, pc
	mov	r0, r3
	bl	puts(PLT)
	movs	r3, #0
	mov	r0, r3
	pop	{r7, pc}
.L4:
	.align	2
.L3:
	.word	.LC0-(.LPIC0+4)
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
```
[arm体系结构版本(CSDN)](https://blog.csdn.net/sinat_28494049/article/details/46006477#:~:text=%E4%B8%BA%E4%BA%86%E7%B2%BE%E7%A1%AE%E8%A1%A8%E8%BE%BE%E6%AF%8F%E4%B8%AA,%E5%90%84%E7%89%88%E6%9C%AC%E7%89%B9%E7%82%B9%E5%A6%82%E4%B8%8B%E3%80%82)  
[arm编程入门(知乎)](https://zhuanlan.zhihu.com/p/388683540)  
[arm常见伪指令(CSDN)](https://blog.csdn.net/liuxianfei0810/article/details/108036937)

## 3. arm

使用如下命令进一步将汇编代码编译成可执行文件

```bash
arm-linux-gnueabihf-gcc arm.s -o arm -static
```

其中，参数-static的作用是：指示编译器生成一个静态可执行文件。静态可执行文件包含程序所需的所有库的副本，使得程序可以在不依赖于系统上已安装的共享库的情况下运行。