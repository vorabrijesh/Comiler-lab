%{
#include<stdio.h>
%}


D 25[0-5]|2[0-4][0-9]|[0-1][0-9][0-9]|[0-9][0-9]|[0-9]

%%
{D}\.{D}\.{D}\.{D} {printf("valid");}

.* {printf("invalid");}

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
