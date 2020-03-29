%{

	#include<string.h>
	#include<stdlib.h>
	#include<stdio.h>
	#include<bits/stdc++.h>
	using namespace std;

	typedef struct 
	{
		string type;
		string value;
		int offset;
		string ptr;

	}node;
	 struct Snode {
		  struct Snode *left;
		  struct Snode *right;
		  char tok[20];
		  char lexval[20];
		  int dval;
		  char reg[20];

	 };
	void postorder(struct Snode*);
	typedef map<string, node> symtable;

	stack  <symtable> s;
	vector <symtable> v;

	symtable tempo;
	node x;
	string g_type,global_val,global_id;
	int global_offset;
	symtable::iterator itr;
	int n = 0;
	int flag = 0;
	vector<string> err;
	int array_value=1;
	int yylex();
	void yyerror(string);

	std::string convertToString(char *a,int size)
	{
		std::string str = "";
		for(int i = 0; i < size; i++)
			str += a[i];
		return str;
	}
	string str1="";
	int temp=0;
%}

%union 
{
	int dval;
	char lexeme[20];
	struct Snode *snode;
}
		
%token NUM FNUM sq1 sq2 FLOAT INT CHAR SCOL COMMA ID cb1 cb2  LP RP NUMBER ADD SUB MUL DIV ASGN 

%type <lexeme> NUM;
%type <lexeme> ID;
%type <lexeme> FNUM;
%type <lexeme> FLOAT;
%type <lexeme> INT;
%type <lexeme> CHAR;
%type <dval> NUMBER
%type <snode> FACT 
%type <snode> TERM 
%type <snode> EXPR 
%type <snode> st
%type <snode> L

%%

Q    : STM
     | Q STM 
	 ;

STM : cb1 
		{
			symtable b;
			s.push(b);
			global_offset = 0;
		} 
	
	A cb2 
		{
			tempo = s.top();
			v.push_back(tempo);
			s.pop();
		};
				
A   : T B SCOL A 
	| STM A 
	| error 
	| 
	| stl A;


B   : B COMMA D | D;
D   : P ID K {
			tempo = s.top();
			s.pop();
			x.type = g_type;
			x.value=global_val;
			x.ptr=str1;
			str1="";
			if(array_value!=1)
			{

				x.type+="array";
				if(x.type=="char")
					x.value = to_string(array_value*1);
				else
					x.value = to_string(array_value*4);
				
			}
			
			global_val="";
			x.offset = global_offset;
			if(tempo.count(convertToString($2,strlen($2)))==1)
			{
				node t = tempo[convertToString($2,strlen($2))];
				if(t.type == x.type)
				{
					string e ="redeclaration of ";
					e+=convertToString($2,strlen($2));
					err.push_back(e);
				}
				else 
				{
					string e ="conflicting types for ";
					e+=convertToString($2,strlen($2));
					err.push_back(e);
				}
				
			}
			tempo[convertToString($2,strlen($2))] = x;
			s.push(tempo);	
			if(g_type=="char")
			{
				if(array_value!=1)
				{
					global_offset=+array_value*1;
					array_value=1;
				}
				else
					global_offset+=1;
			}	
			else{
				if(array_value!=1)
				{
					global_offset=+(array_value*4);
					array_value=1;
				}
				else
					global_offset+=4;
			}
		};
		
P   : MUL P {str1+="*";}| ;
K   : R 
    | ASGN NUM 
		{global_val = $2;}
    | ASGN FNUM 
		{global_val = $2;}| ;
R   : sq1 NUM sq2  R   
					{
					    array_value=array_value*atoi($2);
					}

		|  sq1 NUM sq2 
					{
						array_value=array_value*atoi($2);
					};
T   : INT {g_type = "int";} 
	| FLOAT {g_type = "float";}  
	| CHAR {g_type = "char";};

stl : st SCOL ;

st	: 	L ASGN EXPR {$$ = (struct Snode *) malloc(sizeof(struct Snode)); 
							$$->left = $1;
							$$->right = $3;
							strcpy($$->lexval,"="); 
							strcpy($$->tok,"OP");
							strcpy($$->reg,$3->reg);
			 				postorder($$);
			
		};
EXPR :	EXPR ADD TERM 
			{
					$$ = (struct Snode *) malloc(sizeof(struct Snode)); 
					$$->left = $1;							
					$$->right= $3;
					strcpy($$->lexval,"+"); 
					strcpy($$->tok,"OP");
					sprintf($$->reg, "%d", temp);
					char t[2]="t";
					strcat(t,$$->reg);
					strcpy($$->reg,t);
					temp=(temp+1)%10; 
			};
EXPR :	EXPR	SUB TERM 
{$$ = (struct Snode *) malloc(sizeof(struct Snode)); 
										$$->left = $1;
										$$->right= $3;
										strcpy($$->lexval,"-"); 
										strcpy($$->tok,"OP"); 
										sprintf($$->reg, "%d", temp);

										char t[2]="t";
										strcat(t,$$->reg);
										strcpy($$->reg,t);
										temp=(temp+1)%10;
									};
EXPR 			: 	TERM  { $$ = $1; strcpy($$->reg, $1->reg);};

TERM 			:	TERM MUL FACT {$$ = (struct Snode *) malloc(sizeof(struct Snode)); 
										$$->left = $1;
										$$->right= $3;
										strcpy($$->lexval,"*"); 
										strcpy($$->tok,"OP");
										sprintf($$->reg, "%d", temp);
										char t[2]="t";
										strcat(t,$$->reg);
										strcpy($$->reg,t);
										temp=(temp+1)%10; 
						}
					 ;	

TERM 			:	TERM DIV FACT {$$ = (struct Snode *) malloc(sizeof(struct Snode)); 
										$$->left = $1;
										$$->right= $3;
										strcpy($$->lexval,"/"); 
										strcpy($$->tok,"OP"); 
										sprintf($$->reg, "%d", temp);
										char t[2]="t";
										strcat(t,$$->reg);
										strcpy($$->reg,t);
										temp=(temp+1)%10;
						}
					 ;	


TERM 			:	FACT 
{ $$ = $1; strcpy($$->reg , $1->reg); };

FACT : LP EXPR RP	{ $$ = $2; strcpy($$->reg , $2->reg);};

FACT 			:	NUMBER { $$ = (struct Snode *) malloc(sizeof(struct Snode)); 
						 			$$->right = NULL; 
						 			$$->left= NULL; 
			 						strcpy($$->tok, "NUM");
			 						$$->dval=$1;
									sprintf($$->reg, "%d", $1);
								} 

			| FNUM {$$ = (struct Snode *) malloc(sizeof(struct Snode)); 
						 			$$->right = NULL; 
						 			$$->left= NULL; 
			 						strcpy($$->tok, "NUM");
			 						
									strcpy($$->reg, $1);
								};

FACT 			:	ID	{ $$ = (struct Snode *) malloc(sizeof(struct Snode)); 
			 						strcpy($$->tok, "ID");
			 						strcpy($$->lexval, $1);
						 			$$->right = NULL; 
						 			$$->left = NULL; 
									strcpy($$->reg ,$1);
									} ;

L	:	ID	{ $$ = (struct Snode *) malloc(sizeof(struct Snode)); 
			 						strcpy($$->tok, "ID");
			 						strcpy($$->lexval, $1);
						 			$$->right = NULL; 
						 			$$->left = NULL; 
									strcpy($$->reg ,$1);
								} ;

%%

int main(int argc ,char *argv[])
{
	extern FILE *yyin;
	yyin =fopen(argv[1],"r");
	yyparse();
	fclose(yyin);

	if(err.size()!=0)
	{
		for(int i=0;i<err.size();i++)
		{
			yyerror(err[i]);
		}
		exit(0);
	}
	return 0;
}

void yyerror(string s)
{
  std::cout<<"Error "<<s<<endl;
}
void postorder(struct Snode *ptr) {
	if (ptr == NULL)
		return;
	
    postorder(ptr->left);
	postorder(ptr->right);
	symtable b;
	b = s.top();
	if (ptr->left!=NULL && ptr->right!=NULL && strcmp(ptr->lexval,"="))
	{
		printf("\n%s = %s %s %s",ptr->reg ,ptr->left->reg, ptr->lexval, ptr->right->reg);
		if( (ptr->tok!="NUM" && !b.count(ptr->reg) && ptr->reg[0]!='t') )
		{
			printf("\nError: var %s is not declared in the scope",ptr->reg);			
		} 
		if(strcmp(ptr->left->tok,"NUM") && !b.count(ptr->left->reg) && ptr->left->reg[0]!='t')
		{
			printf("\nError: var %s is not declared in the scope",ptr->left->reg);
		}
		if(strcmp(ptr->right->tok,"NUM") &&!b.count(ptr->right->reg) && ptr->right->reg[0]!='t')
		{
			printf("\nError: var %s is not declared in the scope",ptr->right->reg);					
		}
		
			
	}
	else if (ptr->left!=NULL && ptr->right!=NULL && !strcmp(ptr->lexval,"="))
	{
		printf("\n%s  %s %s",ptr->left->reg,ptr->lexval, ptr->right->reg);
		if(strcmp(ptr->left->tok,"NUM") && !b.count(ptr->left->reg) && ptr->left->reg[0]!='t')
		{
			printf("\nError: var %s is not declared in the scope",ptr->left->reg);
		}
		if(strcmp(ptr->right->tok,"NUM") &&!b.count(ptr->right->reg) && ptr->right->reg[0]!='t')
		{
			printf("\nError: var %s is not declared in the scope",ptr->right->reg);					
		}
		
	}	
	
}

