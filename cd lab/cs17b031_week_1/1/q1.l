%{
#include<stdio.h>
%}


%%

[0-1]+  {printf("binary");}
[0-7]+  {printf("octal");}
[0-9]+  {printf("decimal");}
[0-9a-fA-F]+ {printf("hexa");}

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
