all : lex.yy.c
	g++ lex.yy.c  -o scanner

lex.yy.c : week_5.l
	lex week_5.l

clean :
	rm -rf scanner lex.yy.c
