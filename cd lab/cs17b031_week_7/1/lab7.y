
%{
#include<stdio.h>
int yylex();
int yyerror(char *);
%}

%token NUMBER ID PLUSPLUS MINUSMINUS PLUS MINUS MUL DIV XOR AND OR ANDAND OROR PERCENT LT GT LEQ GEQ EQEQ EQ NEQ NOT SCOL

%%
P  : Q SCOL | P Q SCOL;
Q  : S  {printf("Accepted\n");};
S  : S OROR A | A  ;
A  : A ANDAND B | B ;
B  : B XOR C | C;
C  : C AND D | C OR D | D;  
D  : D EQEQ E | D NEQ E | E ;
E  : E LT F | E LEQ F | E GT F | E GEQ F | F ;
F  : F PLUS G | F MINUS G | G ;
G  : G MUL H | G DIV H | G PERCENT H | H ;
H  : PLUSPLUS H | MINUSMINUS H | NOT H | I ;
I  : I PLUSPLUS | I MINUSMINUS | ID | NUMBER ;

%%

int main(int argc, char **argv){
	extern FILE *yyin;
	yyin = fopen(argv[1],"r"); 
  	yyparse();
}

int yyerror(char *s){
  printf("\n\nError: %s\n", s);
}




