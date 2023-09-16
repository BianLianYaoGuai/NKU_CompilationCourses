source_filename = "fibonacci.c"

target triple = "x86_64-pc-linux-gnu"

@str1 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
; 输入

@str2 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
; 输出

define dso_local i32 @main() {

  %1 = alloca i32, align 4
  ; 用于存a
  %2 = alloca i32, align 4
  ; 用于存b
  %3 = alloca i32, align 4
  ; 用于存i
  %4 = alloca i32, align 4
  ; 用于存n
  %5 = alloca i32, align 4
  ; 用于存t

  store i32 0, i32* %1, align 4
  ; a = 0
  store i32 1, i32* %2, align 4
  ; b = 1
  store i32 1, i32* %3, align 4
  ; i = 1

  %6 = call i32 (i8*, ...) @__isoc99_scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @str1, i64 0, i64 0), i32* %4)
  ; scanf("%d",&n)
  
  %7 = load i32, i32* %1, align 4
  %8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @str2, i64 0, i64 0), i32 %7)


  %9 = load i32, i32* %2, align 4
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @str2, i64 0, i64 0), i32 %9)

  br label %11

11:                                              
  %12 = load i32, i32* %3, align 4
  ; 取出i
  %13 = load i32, i32* %4, align 4
  ; 取出n
  %14 = icmp slt i32 %12, %13
  ; i<n
  br i1 %14, label %15, label %23

15:
  %16 = load i32, i32* %2, align 4
  ; 取出b
  store i32 %16, i32* %5, align 4
  ; t=b

  %17 = load i32, i32* %1, align 4
  ; 取出a
  %18 = add nsw i32 %16, %17
  ; a+b
  store i32 %18, i32* %2, align 4
  ; b=a+b

  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @str2, i64 0, i64 0), i32 %18)

  %20 = load i32, i32* %5, align 4
  ; 取出t
  store i32 %20, i32* %1, align 4
  ; a=t

  %21 = load i32, i32* %3, align 4
  ; 取出i
  %22 = add nsw i32 %21, 1
  ; i+1
  store i32 %22, i32* %3, align 4
  ; i=i+1

  br label %11

23: 
  ret i32 0
}

declare dso_local i32 @__isoc99_scanf(i8*, ...) 
declare dso_local i32 @printf(i8*, ...) 
