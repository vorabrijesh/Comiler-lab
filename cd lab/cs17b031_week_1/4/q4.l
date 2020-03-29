%{
#include<stdio.h>
%}

a   [a-zA-Z0-9]
sp  [._]
b   {sp}?{a}+
%%

{a}+{b}*?"@"{a}+{b}*  {printf("valid email");}

.*   {printf("invalid email");}

%%

int main(int argc, char **argv)
{
	
	if(argc>0)
		yyin = fopen(argv[1],"r");
	else
		yyin = stdin;
	
	yylex();
	return 0;

}
