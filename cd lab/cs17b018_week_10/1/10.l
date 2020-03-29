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
dot [.]
pkmkb [+]

%%

{ws}*	{;}
"+"      							{return ADD;}
"-"      							return SUB;
"/"     								return DIV;
"("									return LP;
")"									return RP;
"float" return FLOAT;
"int"   return INT;
"char"  return CHAR;
"while" return WHILE;
"if"    return IF;
"else"  return ELSE;
";"     return doll;
","     return comma;
"["     return sq1;
"]"     return sq2;
"{"     return cb1;
"}"     return cb2;
"*"     return pt1;
"=="      { strcpy(yylval.lexeme, yytext); return REL;}
"!="      { strcpy(yylval.lexeme, yytext); return REL;}

"<"     { strcpy(yylval.lexeme, yytext); return REL;}
"<="      { strcpy(yylval.lexeme, yytext); return REL;}
">"      { strcpy(yylval.lexeme, yytext); return REL;}
">="      { strcpy(yylval.lexeme, yytext); return REL;}
"="     return eql;
"&&"	return AND;
"||" 	return OR;
"!"		return NOT;
"true"   return True;
"false"  return False;
{alpha}({alpha}|{digit})*    			{ strcpy(yylval.lexeme, yytext);return ID; }
{digit}+ 								{strcpy(yylval.lexeme, yytext);return num;}
({digit}){pkmkb}{dot}({digit}){pkmkb}   {strcpy(yylval.lexeme, yytext); return fnum;}
. {printf("lex error\n"); exit(0);}


%%

int yywrap()
{
	return 1;
}