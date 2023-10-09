.PHONY: example,fib
example:
	arm-linux-gnueabihf-gcc -o example.s -S -O0 example.c -fno-asynchronous-unwind-tables
	arm-linux-gnueabihf-gcc example.s -o example -static
	qemu-arm example
	rm example.s example
fib:
	arm-linux-gnueabihf-gcc fib.s -o fib -static
	qemu-arm fib
	rm fib