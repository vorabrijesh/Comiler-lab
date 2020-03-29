%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}
alpha [A-Za-z]
digit [0-9]
%%
{alpha}({alpha}|{digit})*    	return ID;
{digit}+ 						return NUMBER;
"++"    return PLUSPLUS;
"--"    return MINUSMINUS;
"!"     return NOT;
"/"   return  DIV;
"*"   return  MUL;
"%"   return PERCENT;
"+"   return PLUS;
"-"   return MINUS;
"<"   return LT;
">"   return GT;
"<="  return  LEQ;
">="  return  GEQ;
"=="  return EQEQ;
"!="  return  NEQ;
"&"    return AND;
"|"   return OR;
"^"    return XOR;
"&&"   return ANDAND;
"||"   return OROR;
"="   return EQ;
";"     return  SCOL; 

[ \t] ; /* ignore white space */

"$"		{ return 0; }

.  		{ return yytext[0]; }
%%