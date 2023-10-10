.PHONY: example,test,hw3,hw2,hw1
example:
	yacc expr.y
	gcc y.tab.c -o compute_expr
	rm y.tab.c
	./compute_expr
test:
	yacc test.y
	gcc y.tab.c -o test
	rm y.tab.c
	./test
hw1:
	yacc hw1.y
	gcc y.tab.c -o hw1
	rm y.tab.c
	./hw1
hw2:
	yacc hw2.y
	gcc y.tab.c -o hw2
	rm y.tab.c
	./hw2
hw3:
	yacc -d hw3.y
	lex hw3.l
	gcc -o hw3 lex.yy.c y.tab.c -w
	rm lex.yy.c y.tab.c y.tab.h
	./hw3
