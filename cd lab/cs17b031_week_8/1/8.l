%{
#include<stdio.h>
#include<bits/stdc++.h>
using namespace std;
#include "y.tab.h"
%}

alpha  [a-zA-Z]
digit [0-9]

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

%%