parser: y.tab.c lex.yy.c y.tab.h
	g++ y.tab.c lex.yy.c   -o minicc
lex.yy.c: lab8.l
	lex lab8.l
y.tab.c: lab8.y
	yacc -v -d lab8.y
clean:
	rm -f minicc y.tab.c lex.yy.c y.tab.h y.output
