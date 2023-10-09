.PHONY: example,test
example:
	yacc expr.y
	gcc y.tab.c -o compute_expr
	#rm y.tab.c
	./compute_expr
test:
	yacc test.y
	gcc y.tab.c -o test
	#rm y.tab.c
	./test
