CC = gcc
LC = lex
CFLAGS = -ll

TARGET = scanner

all : lex.yy.c
	$(CC) lex.yy.c $(CFLAGS) -o $(TARGET)

lex.yy.c : q4.l
	$(LC) q4.l

clean :
	rm -rf scanner lex.yy.c
