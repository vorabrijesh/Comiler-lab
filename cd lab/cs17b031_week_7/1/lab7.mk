parser: y.tab.c lex.yy.c y.tab.h
	gcc y.tab.c lex.yy.c  -ly  -o myparser
lex.yy.c: lab7.l
	lex lab7.l
y.tab.c: lab7.y
	yacc -v -d lab7.y
clean:
	rm -f myparser y.tab.c lex.yy.c y.tab.h y.output
