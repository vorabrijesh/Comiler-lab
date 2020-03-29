%{

#include<stdio.h>
#include<stdlib.h>
#include<bits/stdc++.h>
#include"y.tab.h"
	
%}


alpha [A-Za-z_]
sp [!@#$%^&*]
digit [0-9]
ws [\t" "]

%%

{ws}*	{;}
"float" return FLOAT;
"int"   return INT;
"char"  return CHAR;
";"     return SCOL;
","     return COMMA;
"["     return sq1;
"]"     return sq2;
"{"     return cb1;
"}"     return cb2;
"*"     return pt1;
"="     return eql;
{alpha}({alpha}|{digit})*    					{strcpy(yylval.lexeme, yytext); return ID; }
{digit}+ 							{strcpy(yylval.lexeme , yytext); return NUM;}
{digit}+.{digit}+   						{strcpy(yylval.lexeme , yytext); return FNUM;};
. 							 	{printf("lex error\n"); exit(0);}


%%

int yywrap()
{
	return 1;
}
