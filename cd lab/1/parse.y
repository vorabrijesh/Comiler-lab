%{

#include<bits/stdc++.h>
using namespace std;

//structure to store contents of identifier
typedef struct
{
	string type;
	string value;
	string type1;
	bool same;
}content;

//node of syntax tree for arithmetic expression
struct Node
{
	string type;
	string opval;
	string name;
	struct Node *left;
	struct Node *right;
};

//map to store identifiers of a block
typedef map< string, content > block;

//stacks to maintain scope of blocks
stack<block> s;

block temp;
content x;
string st_type, st_id, temp_str;
block::iterator blit;
int tactemp = 0;

//flag = 1 indicates correct input // tacflag=1 indicates printing of three address code
int flag=1;
int tacflag = 1;

int yylex();
void yyerror(string);

//convert char array to string
std::string convertToString(char* a, int size) 
{ 
    int i; 
    std::string s = ""; 
    for (i = 0; i < size; i++) { 
        s = s + a[i]; 
    } 
    return s; 
}

//type of expression // widening conversion
std::string maxtype(string s1, string s2)
{
	std::string ans;
	if(s1==s2)
		return s1;
	else if(s1=="char")
		return s2;
	else if(s1=="int" && s2=="float")
		return s2;
	else if(s1=="int" && s2=="char")
		return s1;
	return s1;

}

//postOrder traversal to generate Three Address Code
void postOrder(struct Node *t);

%}

%union {
	 char lexeme[20];
	 int dval;
	 struct Node *node;
}

%token lp rp tint tfloat tchar scol com id intconst floatconst charconst alp arp star eq plus minus divide mod elp erp
%type <lexeme> intconst;
%type <lexeme> floatconst;
%type <lexeme> charconst;
%type <lexeme> id;
%type <dval> M;
%type <node> AST;
%type <node> AE;
%type <node> T;
%type <node> F;
%type <node> F1;
%type <node> F2;

%%

BLOCK	:	lp {
					//push new block and related address and index into respective stacks
					block b;
					if(!s.empty())
					{
						temp = s.top();
						for(blit=temp.begin(); blit!=temp.end(); blit++)
						{
							blit->second.same = false;
							b[blit->first] = blit->second;
						}
					}
					s.push(b);
				}
			A rp { 
					//pop block and related address and index from respective stacks
					temp = s.top();
					s.pop();
				}
		| 	lp rp;
A		:	B | A B;
B		:	ST | BLOCK | AST scol;
ST		:	TYPE L scol;
TYPE	:	tint {st_type = "int";}
		|	tfloat {st_type = "float";}
		|	tchar {st_type = "char";};
L		:	E com L | E;
E		:	N | AR | P;
N		:	id 		{
						temp = s.top();
						st_id = convertToString($1, strlen($1));
						if(temp.count(st_id) && temp[st_id].same==true && temp[st_id].type == st_type)
						{
							cout << "error : redeclaration of "  << st_id << endl;
							flag = 0;
							tacflag = 0;
						}
						else if(temp.count(st_id) && temp[st_id].same==true)
						{
							cout << "error : conflicting types for " << st_id << endl;
							flag = 0;
							tacflag = 0;
						}
						else
						{
							s.pop();
							x.type = st_type;
							x.type1 = st_type;
							x.value = "";
							x.same = true;
							temp[st_id] = x;
							s.push(temp);
						}
					}
		| 	id eq AE {
						temp = s.top();
						st_id = convertToString($1, strlen($1));
						if(temp.count(st_id) && temp[st_id].same==true && temp[st_id].type == st_type)
						{
							cout << "error : redeclaration of "  << st_id << endl;
							flag = 0;
							tacflag = 0;
						}
						else if(temp.count(st_id) && temp[st_id].same==true)
						{
							cout << "error : conflicting types for " << st_id << endl;
							flag = 0;
							tacflag = 0;
						}
						else
						{
							s.pop();
							x.type = st_type;
							x.type1 = st_type;
							x.same = true;
							x.value = "";
							temp[st_id] = x;
							s.push(temp);

							if(tacflag)
							{
								postOrder($3);
								if($3->type != temp[st_id].type)
								{
									cout << st_id << " = " << "(" << temp[st_id].type << ")" << $3->name << endl;
								}
								else cout << st_id << " = " <<  $3->name << endl;
							}
						}
					}
		;
AR		:	id M{
					temp = s.top();
					st_id = convertToString($1, strlen($1));
					if(temp.count(st_id) && temp[st_id].same==true && temp[st_id].type == st_type)
					{
						cout << "error : redeclaration of "  << st_id << endl;
						flag = 0;
						tacflag = 0;
					}
					else if(temp.count(st_id) && temp[st_id].same==true)
					{
						cout << "error : conflicting types for " << st_id << endl;
						flag = 0;
						tacflag = 0;
					}
					else
					{
						s.pop();
						x.type = st_type;
						x.type1 = st_type + "array";
						x.same = true;
						if(st_type == "char")
						{
							x.value = std::to_string($2);
						}
						else 
						{
							x.value = std::to_string($2*4);
						}
						temp[st_id] = x;
						s.push(temp);
					}
				}
		;
M		:	alp intconst arp M {
									$$ = stoi($2) * $4;
								}
		|	alp intconst arp {
								$$ = stoi($2);
							}
		;
G		:	star G | star;
P		:	G id {	
					temp = s.top();
					st_id = convertToString($2, strlen($2));
					if(temp.count(st_id) && temp[st_id].same==true && temp[st_id].type == st_type)
					{
						cout << "error : redeclaration of "  << st_id << endl;
						flag = 0;
						tacflag = 0;
					}
					else if(temp.count(st_id) && temp[st_id].same==true)
					{
						cout << "error : conflicting types for " << st_id << endl;
						flag = 0;
						tacflag = 0;
					}
					else
					{
						s.pop();
						x.type = st_type;
						x.type1 = st_type + "pointer";
						x.value = "";
						x.same = true;
						temp[st_id] = x;
						s.push(temp);
					}
				}
		;
AST		:	id eq AE
					{
						if(flag==0)
							flag = 1;
						else
						{
							if(!s.empty())
							{
								temp = s.top();
								st_id = convertToString($1, strlen($1));
								if(!temp.count(st_id))
								{
									cout << "error : var "  << st_id << " is not declared in the scope" << endl;
									flag = 0;
									tacflag = 0;
								}
								else
								{
									if(tacflag)
									{
										postOrder($3);
										if($3->type != temp[st_id].type)
										{
											cout << st_id << " = " << "(" << temp[st_id].type << ")" << $3->name << endl;
										}
										else cout << st_id << " = " <<  $3->name << endl;
									}
								}
							}
						}
					}
		;
AE		:	AE plus T 
						{
							if(flag)
							{
								$$ = new Node;
								
								$$->opval = "+";
								temp_str = "t" + std::to_string(tactemp);
								$$->name = temp_str;	//compiler generate
								temp_str = maxtype($1->type, $3->type);
								$$->type = temp_str;
								tactemp += 1;
								$$->left = $1;
								$$->right = $3;
							}
						}
		|	AE minus T 
						{
							if(flag)
							{
								$$ = new Node;
								
								$$->opval = "-";
								temp_str = "t" + std::to_string(tactemp);
								$$->name = temp_str;	//compiler generate
								temp_str = maxtype($1->type, $3->type);
								$$->type = temp_str;
								tactemp += 1;
								$$->left = $1;
								$$->right = $3;
							}
						}
		|	T
				{
					if(flag)
					{
						$$ = $1;
					}
				}
		;
T 		:	T star F 
					{
						if(flag)
						{
							$$ = new Node;
							
							$$->opval = "*";
							temp_str = "t" + std::to_string(tactemp);
							$$->name = temp_str;	//compiler generate
							temp_str = maxtype($1->type, $3->type);
							$$->type = temp_str;
							tactemp += 1;
							$$->left = $1;
							$$->right = $3;
						}
					}
		| 	T divide F 
					{
						if(flag)
						{
							$$ = new Node;
							
							$$->opval = "/";
							temp_str = "t" + std::to_string(tactemp);
							$$->name = temp_str;	//compiler generate
							temp_str = maxtype($1->type, $3->type);
							$$->type = temp_str;
							tactemp += 1;
							$$->left = $1;
							$$->right = $3;
						}
					}
		|	T mod F 
					{
						if(flag)
						{
							$$ = new Node;
							$$->opval = "%";
							temp_str = "t" + std::to_string(tactemp);
							$$->name = temp_str;	//compiler generate
							temp_str = maxtype($1->type, $3->type);
							$$->type = temp_str;
							tactemp += 1;
							$$->left = $1;
							$$->right = $3;
						}
					}
		|	F
				{
					if(flag)
					{
						$$ = $1;
					}
				}
		;
F		:	F1
				{
					if(flag)
					{
						$$ = $1;
					}
				}
		|	F2
				{
					if(flag)
					{
						$$ = $1;
					}
				}
		;
F1		:	id 
				{
					if(flag)
					{
						if(!s.empty())
						{
							temp = s.top();
							st_id = convertToString($1, strlen($1));
							if(!temp.count(st_id))
							{
								cout << "error : var "  << st_id << " is not declared in the scope" << endl;
								flag = 0;
								tacflag = 0;
							}
							else
							{
								$$ = new Node;
								$$->type = temp[st_id].type;
								$$->name = st_id;
								$$->opval = "id";
								$$->left = NULL;
								$$->right = NULL;
							}
						}
					}
				}
		| 	intconst
				{
					if(flag)
					{
						$$ = new Node;
						$$->type = "int";
						temp_str = convertToString($1, strlen($1));
						$$->name = temp_str;
						$$->opval = "const";
						$$->left = NULL;
						$$->right = NULL;
					}
				}
		| 	floatconst
				{
					if(flag)
					{
						$$ = new Node;
						$$->type = "float";
						temp_str = convertToString($1, strlen($1));
						$$->name = temp_str;
						$$->opval = "const";
						$$->left = NULL;
						$$->right = NULL;
					}
				}
		|	charconst
				{
					if(flag)
					{
						$$ = new Node;
						$$->type = "char";
						temp_str = convertToString($1, strlen($1));
						$$->name = temp_str;
						$$->opval = "const";
						$$->left = NULL;
						$$->right = NULL;
					}
				}
		| 	elp AE erp
						{
							if(flag)
								$$ = $2;
						}
		;
F2		:	minus F1
					{
						if(flag)
						{
							$$ = new Node;
							$$->type = $2->type;
							if($2->opval == "const")
							{
								temp_str = "-" + $2->name;
								$$->name = temp_str;
								$$->opval = $2->opval;
								$$->left = NULL;
							}
							else
							{
								temp_str = "t" + std::to_string(tactemp);
								$$->name = temp_str;	//compiler generate
								tactemp += 1;
								$$->opval = "minus";
								$$->left = $2;
							}
							$$->right = NULL;
						}
					}
		;

%%

extern FILE *yyin;

int main(int argc, char *argv[]){
	yyin = fopen(argv[1],"r");  
	yyparse();
	fclose(yyin);
	return 0;
}

void yyerror(string s){
	flag = 0;
 	cout << "Error: " << s << endl;
}

void postOrder(struct Node *t)
{
	if(t!=NULL)
	{
		postOrder(t->left);
		postOrder(t->right);
		if(t->left!=NULL && t->right!=NULL)
		{
			temp_str;
			if(t->type != t->left->type)
			{
				temp_str = t->name + " = " + "(" + t->type + ")" + t->left->name + " " + t->opval + " " + t->right->name;
			}
			else if(t->type != t->right->type)
			{
				temp_str = t->name + " = " + t->left->name + " " + t->opval + " (" + t->type + ")" + t->right->name;
			}
			else temp_str = t->name + " = " + t->left->name + " " + t->opval + " " + t->right->name;
			cout << temp_str << endl;
		}
		else if(t->left!=NULL && t->right==NULL)
		{
			temp_str = t->name + " = " + t->opval + " " + t->left->name;
			cout << temp_str << endl;
		}
	}
}