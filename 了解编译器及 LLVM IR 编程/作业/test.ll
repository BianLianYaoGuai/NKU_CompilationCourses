
source_filename = "main.c"
; 指出源文件


target triple = "x86_64-pc-linux-gnu"
; 告知编译器或开发工具链，要将程序编译成在 x86_64 架构的个人计算机上运行，
;     且目标操作系统是 Linux, 
;     并且使用 GNU 工具链进行编译的配置参数


@str1 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
; @用于声明全局变量
; private表示仅当前module内可见
; unnamed_addr表示这个全局变量没有名字地址(名字是匿名的)。
;     有一些全局变量仅用于内部实现细节，而不需要被外部代码引用时，
;     可以将它们声明为 unnamed_addr。
;     这样可以避免生成全局变量名字导致的额外开销
; constant表示这是个常量,值不可改
; [3 x i8]表示数组大小是3个8位整数,也就是说这个变量占空间3个字节(即24位)。
; c"%d\00"是一个包含字符串值的数组初始化器,其中%d是一个整数的占位符,\00是字符串的结束符
; align 1表示全局变量的对齐方式为1字节。这意味着全局变量在内存中的地址应该是1字节的倍数。
;     众所周知,ASCII码中一个英文字母占一个字节的空间
; 这个变量是用于接收输入的



@str2 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
; 这个变量是用于输出结果的 \0A应该是换行

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  ; so_local指示main函数只能在当前模块或共享库中访问,
  ;     而不能在其他模块中访问
  ; #0 是一个调试元数据的附加部分，用于关联汇编代码和源代码之间的关系。
  ;     它并不影响代码的功能，只是提供了与源代码的对应关系,
  ;     以便在调试和分析时能够将汇编代码映射回源代码。
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  ; i32*是32位int型指针
  ; 这句话的意思是,将整数值0存储到指针(寄存器)%1指向的内存地址上

  %5 = call i32 (i8*, ...) @__isoc99_scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @str1, i64 0, i64 0), i32* %3)
  ; i32表示函数的返回类型是32位整数
  ; (i8*, ...)表示函数接受一个或多个参数,其中第一个参数是8位数据指针
  ; getelementptr inbounds([3 x i8], [3 x i8]* @str1, i64 0, i64 0) 目的是
  ;     从 @str1 的第一个元素(也就是第一个i8)开始，
  ;     获取一个指向字符数组的指针，也就是字符串的起始地址。
  ; 对应于c代码 —— scanf("%d",&n)

  store i32 2, i32* %2, align 4
  ; store是把左边的值存在右边的地址
  ; 对应于c代码 —— i=2
  store i32 1, i32* %4, align 4
  ; 对应于c代码 —— f=1

  br label %6
  ; br 是无条件分支,label 可以理解为一个代码标签,指代下面那个代码块

6:                                                ; preds = %10, %0
  %7 = load i32, i32* %2, align 4
  %8 = load i32, i32* %3, align 4
  %9 = icmp sle i32 %7, %8
  ; sle是指signed less than or equal,即有符号整数的小于或等于关系
  br i1 %9, label %10, label %16

10:                                               ; preds = %6
  %11 = load i32, i32* %4, align 4
  ; 取出f
  %12 = load i32, i32* %2, align 4
  ; 取出i
  %13 = mul nsw i32 %11, %12
  ; nsw表示No Signed Wrap,意思是在进行有符号整数乘法时不会发生有符号溢出
  store i32 %13, i32* %4, align 4
  ; 新的f
  %14 = load i32, i32* %2, align 4 
  ; 事实上,这似乎是多余的一步
  ; %15 = add nsw i32 %14, 1
  %15 = add nsw i32 %12, 1
  store i32 %15, i32* %2, align 4
  ; 新的i
  br label %6

16:                                               ; preds = %6
  %17 = load i32, i32* %4, align 4
  ; 取出f
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @str2, i64 0, i64 0), i32 %17)
  ret i32 0
}

declare dso_local i32 @__isoc99_scanf(i8*, ...) #1
declare dso_local i32 @printf(i8*, ...) #1
; declare关键字表明这是一个外部函数的声明,而不是函数的定义
; dso_local: 这是一个链接指示符,指示编译器在程序的本地库或动态链接库中查找该函数

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
; 这行代码是LLVM IR中的属性attributes声明,用于指定函数或全局变量的属性信息。
; 这些属性可以影响代码的优化、行为和特性。以下是一些这些属性的解释：
; - `"correctly-rounded-divide-sqrt-fp-math"="false"`: 禁用浮点数除法和平方根的正确舍入。
; - `"disable-tail-calls"="false"`: 不禁用尾递归调用。
; - `"frame-pointer"="all"`: 使用帧指针（用于调试）。
; - `"target-cpu"="x86-64"`: 目标CPU架构为x86-64。
; - `"target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87"`: 支持的目标CPU特性。
; - `"stack-protector-buffer-size"="8"`: 堆栈保护缓冲区的大小为8字节。
; - 等等...