minicc: y.tab.c lex.yy.c y.tab.h
	g++ y.tab.c lex.yy.c -std=c++11 -ll -ly -o minicc
lex.yy.c: lex.l
	lex lex.l
y.tab.c: parse.y
	yacc -v -d parse.y
clean:
	rm -f minicc y.tab.c lex.yy.c y.tab.h y.output