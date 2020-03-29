
Name : Vora Brijesh
Roll No : cs17b031

Grammer :


Q               : STM| Q STM
STM             : cb1 A cb2
A               : T B SCOL A | STM A | error | stl A | 
B               : B COMMA D | D
D               : P ID K
P               : MUL P | 
K               : R | ASGN NUM | ASGN FNUM | 
R               : sq1 NUM sq2  R |  sq1 NUM sq2
T               : INT | FLOAT  | CHAR 
stl             : st SCOL 
st	            : L ASGN EXPR 
EXPR            : EXPR	ADD TERM 
EXPR            : EXPR	SUB TERM 
EXPR 			: TERM 
TERM 			: TERM MUL FACT 
TERM 			: TERM DIV FACT 
TERM 			: FACT 
FACT            : LP EXPR RP	
FACT 			: NUMBER |FNUM 
FACT 			: ID	
L	            : ID	
