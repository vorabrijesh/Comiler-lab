%{

#include<bits/stdc++.h>
#include "y.tab.h"

%}

quote [']
underscore _
open \[
close \]
equal \=
semicolon ;
com \,
openc \{
closec \}
openp \(
closep \)
star \*
plus \+
minus \-
div \/
mod \%

letter [a-zA-Z]  
digit [0-9]
character [a-zA-Z0-9#@!/,$%&*+^(){}<>.?:~`-]|[\t\v ]
hexadecimal 0(x|X)[0-9a-fA-F]+
octal 0[0-7]*
decimal [1-9]{digit}*
integer {hexadecimal}|{octal}|{decimal}
real {digit}+\.{digit}*|{digit}*\.{digit}+
expo ({real}|{digit})+(e|E)(\+|-)?{digit}+

identifier ({letter}|{underscore})({letter}|{digit}|{underscore})*
integer_const {integer}+
real_const {real}|{expo}
character_const {quote}({character}|{underscore}|{equal}|{close}|{open}|{semicolon}){quote}

%%

"int"			return tint;
"float"			return tfloat;
"char"			return tchar;
{semicolon}		return scol;
{openc}			return lp;
{closec}		return rp;
{open}			return alp;
{close}			return arp;
{com}			return com;
{star}			return star;
{equal}			return eq;
{openp}			return elp;
{closep}		return erp;
{plus}			return plus;
{minus}			return minus;
{div}			return divide;
{mod}			return mod;
{identifier}	{strcpy(yylval.lexeme, yytext); return id;}
{integer_const}	{strcpy(yylval.lexeme, yytext); return intconst;}
{real_const}	{strcpy(yylval.lexeme, yytext); return floatconst;}
{character_const}	{strcpy(yylval.lexeme, yytext); return charconst;}

[ \t\v\f\n] ;      /* ignore white space */

.  		{ return yytext[0]; }

%%

int yywrap()
{
	return 1;
}
