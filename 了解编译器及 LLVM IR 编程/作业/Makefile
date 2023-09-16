.PHONY: test,fi,gc

test:
	llvm-as test.ll -o test.bc
	clang -o test_x86 test.bc
	rm test.bc
	./test_x86

fi:
	llvm-as fibonacci.ll -o fibonacci.bc
	clang -o fibonacci_x86 fibonacci.bc
	rm fibonacci.bc
	./fibonacci_x86

gc:
	gcc fibonacci.c -o fibonacci
	./fibonacci