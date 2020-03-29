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
{alpha}({alpha}|{digit})*    	{strcpy(yylval.lexeme, yytext); return ID; }
{digit}+.{digit}+   						{strcpy(yylval.lexeme , yytext); return FNUM;};
{digit}+ 							{yylval.dval = atoi(yytext); return NUMBER;}

"+"      							return ADD;
"-"      							return SUB;
"*"	 								return MUL;
"/"     								return DIV;
"=" 									return ASGN;
"("									return LP;
")"									return RP;
";"									return SCOL;
","     return COMMA;
"["     return sq1;
"]"     return sq2;
"{"     return cb1;
"}"     return cb2;


. 							 	{printf("lex error\n"); exit(0);}


%%

int yywrap()
{
	return 1;
} 
