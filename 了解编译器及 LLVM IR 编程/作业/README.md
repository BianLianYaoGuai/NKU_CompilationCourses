# 阶乘

源程序`test.c`

使用以下指令即可编译运行阶乘程序, 同时会生成程序的IR中间形式`test.ll`  
```ssh
make test
```

我将对`test.ll`的部分理解以注释的方式记录到`test_comment.ll`中

# 斐波那契

|文件名||
|-|-|
|fibonacci.c|源程序|
|fibonacci.ll|手写的LLVM IR 程序|

使用以下指令即可将手写的LLVM IR 程序`fibonacci.ll`编译成可执行程序并运行程序  
```ssh
make fi
```

使用以下指令即可将源程序`fibonacci.c`编译成可执行程序并运行程序，以供参考  
```ssh
make gc
```