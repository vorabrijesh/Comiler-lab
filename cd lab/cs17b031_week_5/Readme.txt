Commands:
	$ make
	$ make clean
	$ ./scanner test.c

The name of the executable file is scanner.

In the rule section all the rules including
ws,delim,letter,digit,arithmatic,assignment,conditional,keywords,iterartors,preprocessor,escape,separator,unary,relop,bitwise,format,comments are included with their corresponding regular expression.

After that each string is tokenized and its particular class is matched with the rule and printed. If it is identifier then it is pushed in symbol table. I have maintained symbol table as vector of strings (vector<strings>). Here the index of the vector is name of the token and its value will be identified as lexeme.

So I wrote a function installToken() which will push the token into symbol table.

Atlast I printed the elements of the symbol table.