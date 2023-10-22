lexer:
	flex lexer.l
	gcc lex.yy.c -o lexer -lfl -w
	./lexer input.c
	rm lexer