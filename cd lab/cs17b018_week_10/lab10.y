%{

#include<stdio.h>
#include<bits/stdc++.h>
using namespace std;





int yylex();
void yyerror(string);
%}

%token num fnum sq1 sq2 FLOAT INT CHAR doll comma ID cb1 cb2 eql pt1 ADD SUB mod DIV LP RP ELSE IF WHILE REL AND OR NOT
%nonassoc REDUCE
%nonassoc ELSE
%nonassoc POLU
%nonassoc ID
%left OR
%left AND
%right NOT
%nonassoc GOLU
%nonassoc RP
%%



Q    : STM 
     | Q STM 
	 ;


STM : cb1 A1 cb2 
	| cb1 cb2;

A1 : A
   | A1 A
   ;
		

A   : T B doll 
	| st doll   
	| STM 
	| IEST
	| WST
	;
B    :  B comma D | D;
D    :  P ID K ;
		
P    : pt1 P | pt1;
K    : R 
     | eql num
	 | eql fnum | ;


R    : sq1 num sq2  R  |  sq1 num sq2 ;
T    : INT 
	 | FLOAT 
	 | CHAR;



st	 : 	L eql EXPR ;
EXPR :	EXPR	ADD TERM   ;
EXPR :	EXPR	SUB TERM ;
EXPR : 	TERM  ;
TERM :	TERM pt1 FACT ;	
TERM :	TERM DIV FACT;
TERM :	FACT ;
FACT :  LP EXPR RP ;
FACT :	num
     |
        fnum 
     ;


FACT :	ID;

L	 :	ID;	
IEST : IF LP COND RP A ELSE A 
	 | IF LP COND RP A %prec REDUCE;

WST  : WHILE LP COND RP A;
COND : COND OR COND
	 | COND AND COND
	 | NOT COND
	 | EXPR REL EXPR
	 | EXPR %prec GOLU
	 | LP COND RP;

%%



int main(int argc ,char *argv[])
{
  extern FILE *yyin;
  yyin =fopen(argv[1],"r");
  yyparse();
  fclose(yyin);


  return 0;
}
void yyerror(string s)
{
  std::cout<<"Error "<<s<<endl;
  
}

					 	
























