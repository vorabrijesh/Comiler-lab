%{
#include<stdio.h>
%}

digit [0-9] 
expo [eE]

%%

\+?{digit}+    {printf("positive integer");}
"-"{digit}+     {printf("negative integer");}
\+?{digit}*"."{digit}+  {printf("positive real");}
"-"{digit}*"."{digit}+   {printf("negative real");}
\+?{digit}+{expo}\+?{digit}+  {printf("positive integer in exponential form");}
\+?{digit}+{expo}"-"{digit}+  {printf("positive integer in negative exponential form");}
"-"{digit}+{expo}"-"{digit}+  {printf("negative integer in negative exponential form");}
"-"{digit}+{expo}\+?{digit}+  {printf("negative integer in postive exponential form");}
\+?{digit}+"."{digit}+{expo}\+?{digit}+  {printf("positive real in exponential form");}
\+?{digit}+"."{digit}+{expo}"-"{digit}+  {printf("positive real in negative exponential form");}
"-"{digit}+"."{digit}+{expo}\+?{digit}+  {printf("negative real in exponential form");}
"-"{digit}+"."{digit}+{expo}"-"{digit}+  {printf("negative real in negative exponential form");}


.* {printf("neither integer nor real");}

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
