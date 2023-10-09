.PHONY: example,test,onlymain,debug,gdb,ident,scan,test2,fib
example:
	arm-linux-gnueabihf-gcc -o example.s -S -O0 example.c -fno-asynchronous-unwind-tables
	arm-linux-gnueabihf-gcc example.s -o example -static
	qemu-arm example
	rm example.s example
test:
	arm-linux-gnueabihf-gcc test.s -o test -static
	qemu-arm test
	rm test
onlymain:
	arm-linux-gnueabihf-gcc -o only_main.s -S -O0 only_main.c -fno-asynchronous-unwind-tables
print:
	arm-linux-gnueabihf-gcc -o print.s -S -O0 print.c -fno-asynchronous-unwind-tables
ident:
	arm-linux-gnueabihf-gcc -o ident.s -S -O0 ident.c -fno-asynchronous-unwind-tables
scan:
	arm-linux-gnueabihf-gcc -o scan.s -S -O0 scan.c -fno-asynchronous-unwind-tables
test2:
	arm-linux-gnueabihf-gcc -o test2.s -S -O0 test2.c -fno-asynchronous-unwind-tables
fib:
	arm-linux-gnueabihf-gcc -o fibonacci.s -S -O0 fibonacci.c -fno-asynchronous-unwind-tables
	arm-linux-gnueabihf-gcc fibonacci.s -o fibonacci -static
	qemu-arm fibonacci
	rm fibonacci.s fibonacci
