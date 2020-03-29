parser: y.tab.c lex.yy.c y.tab.h
	g++ -std=c++11 y.tab.c lex.yy.c  -ly  -o minicc
lex.yy.c: lab11.l
	lex lab11.l
y.tab.c: lab11.y
	yacc -v -d lab11.y
clean:
	rm -f minicc y.tab.c lex.yy.c y.tab.h y.output
