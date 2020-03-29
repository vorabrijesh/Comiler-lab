CC = g++
LC = lex
STDFLAG = --std=c++11
CFLAGS = -ll

TARGET = rdparser

all : lex.yy.c
	$(CC) $(STDFLAG) lex.yy.c $(CFLAGS) -o $(TARGET)

lex.yy.c : rdparser.l
	$(LC) rdparser.l

clean :
	rm -rf rdparser lex.yy.c