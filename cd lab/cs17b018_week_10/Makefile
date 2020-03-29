parser: y.tab.c lex.yy.c y.tab.h
	g++ -std=c++11 y.tab.c lex.yy.c  -ll -ly  -o minicc
lex.yy.c: 10.l
	lex 10.l
y.tab.c: lab10.y
	yacc -v -d lab10.y
clean:
	rm -f minicc y.tab.c lex.yy.c y.tab.h y.output
