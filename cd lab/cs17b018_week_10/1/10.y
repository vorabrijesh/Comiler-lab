%{

#include<stdio.h>
#include<bits/stdc++.h>
using namespace std;


 struct Snode {
		  struct Snode *left;
		  struct Snode *right;
		  string tok;
		  string lexval;
		  string dval;
		  string type1;
		  string True;
		  string code;
		  string False;
		  string name;
	 };
void postorder(struct Snode*,string &);
string prioriry(string ,string );


string check(string );



int idx=0;

typedef struct 
{
	string type;
	string value;
	int offset;
	string ptr;

}node;

typedef map<string, node> sym;

stack  <sym> s;
vector <sym> v;

sym temp;
node x;
string st_type,st_val,st_id;
int st_offset;
sym::iterator itr;
int n = 0;
int flag = 0;
vector<string> err;
int arr_val=1;
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
string patlu;
string flag1,flag2;
int label_idx=0;
string new_label1="";
string new_label2="";

%}

//-------------------------------------------------------------------------------------------

%union 
{
	 char lexeme[20];
	 struct Snode *snode;
}
	
%token num fnum sq1 sq2 FLOAT INT CHAR doll comma ID cb1 cb2 eql pt1 ADD SUB mod DIV LP RP ELSE IF WHILE REL AND OR NOT True False
%nonassoc REDUCE
%nonassoc ELSE
%nonassoc POLU
%nonassoc ID
%left OR
%left AND
%right NOT
%nonassoc GOLU
%nonassoc RP

%type <lexeme> num;
%type <lexeme> ID;
%type <lexeme> fnum;
%type <lexeme> REL;
%type <lexeme> FLOAT;
%type <lexeme> INT;
%type <lexeme> CHAR;
%type <snode> FACT 
%type <snode> TERM 
%type <snode> EXPR 
%type <snode> st
%type <snode> L
%type <snode> IEST
%type <snode> WST
%type <snode> COND



%%


//-----------------------------------------------------------------------------------------


Q    : STM
     | Q STM 
	 ;

STM : cb1 
			{
				sym b;
				s.push(b);
				st_offset = 0;
			} 
	
	  A1 cb2 
			{
				temp = s.top();
				v.push_back(temp);
				s.pop();
			}
	 |
	  cb1 cb2
	 ;

A1  : A
    | A1 A
    ;
				
A   : T B doll 
	| st doll  { string s;postorder($1,s); } 
	| STM 
	|	{
			$<snode>$2 =  new Snode();
			$<snode>$2->next = $<snode>$->next;
		}

	 IEST
		
	|
		{
			$<snode>$2 =  new Snode();
			$<snode>$2->next = $<snode>$->next;
		}
	 WST  
	
	;





st	: 	L eql EXPR {        $$ = new Snode(); 
							$$->left = $1;
							$$->right = $3;
							$$->lexval="="; 
							$$->tok = "OP";
							$$-> name = "t" + to_string(idx);
							idx++;
					};


EXPR:	EXPR	ADD TERM    {
                            $$ = new Snode();; 
							$$->left = $1;
							$$->right= $3;
							$$->lexval = "+"; 
							$$->tok = "OP";
							$$-> name = "t" + to_string(idx);
							idx++;
					};



EXPR:	EXPR	SUB TERM {
                            $$ = new Snode(); 
							$$->left = $1;
							$$->right= $3;
							$$->lexval="-"; 
							$$->tok = "OP";
							$$-> name = "t" + to_string(idx);
							idx++;
						 };


EXPR 	: 	TERM  { $$ = $1; };



TERM :	TERM pt1 FACT {     $$ = new Snode(); 
							$$->left = $1;
							$$->right= $3;
							$$->lexval="*"; 
							$$->tok = "OP";
							$$-> name = "t" + to_string(idx);
							idx++; 
					  };	




TERM :	TERM DIV FACT {     $$ = new Snode(); 
							$$->left = $1;
							$$->right= $3;
							$$->lexval="/"; 
							$$->tok = "OP"; 
							$$-> name = "t" + to_string(idx);
							idx++;
						};
					 	


TERM :	FACT { $$ = $1; };
FACT : LP EXPR RP { $$ = $2; };




FACT 			:	num
                        { 
         					$$ = new Snode(); 
				 			$$->right = NULL; 
				 			$$->left= NULL; 
				 			$$->type1 = "int";
	 						$$->tok = "NUM";
	 						$$->dval =$1;
							$$->name = string($1);
		                } 
                |
                    fnum 
                    	{           
            		        $$ = new Snode(); 
				 			$$->right = NULL; 
				 			$$->left= NULL; 
				 			$$->type1 = "float";
	 						$$->tok= "NUM";
	 						$$->dval=$1;
	 						$$->name = string($1);
						 };



FACT 	:	ID	{ 

							string res=check($1);
	                        $$ = new Snode(); 

							if (res.size()>0)
							$$->type1 = res;

							else
							{
								cout<<"'"<<$1<<"'"<<" is not declare in this scope"<<endl;
								exit(0);
							}
							
	 						$$->tok= "ID";
	 						$$->lexval= $1;
				 			$$->right = NULL; 
				 			$$->left = NULL; 
				 			$$->name = string($1);
						} ;

L	:	ID	{      
					    string res = check($1);
			       		$$ = new Snode(); 

						if (res.size()>0)
							$$->type1 = res;
						else
						{
							cout<<"'"<<$1<<"'"<<" is not declare in this scope"<<endl;
							exit(0);
						}
						
 						$$->tok= "ID";
 						$$->lexval= $1;
			 			$$->right = NULL; 
			 			$$->left = NULL; 
			} ;







//--------------------------------------------------------------------------------------------------------





B   : B comma D | D;
D   : P ID K {
			temp = s.top();
			s.pop();
			x.type = st_type;
			x.value=st_val;
			x.ptr=str1;
			str1="";
			if(arr_val!=1)
			{

				x.type+="array";
				if(x.type=="char")
					x.value = to_string(arr_val*1);
				else
					x.value = to_string(arr_val*4);
				
			}
			
			st_val="";
			x.offset = st_offset;
			if(temp.count(convertToString($2,strlen($2)))==1)
			{
				node t = temp[convertToString($2,strlen($2))];
				if(t.type == x.type)
				{
					string e ="redclaration of ";
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
			temp[convertToString($2,strlen($2))] = x;
			s.push(temp);	
			if(st_type=="char")
			{
				if(arr_val!=1)
				{
					st_offset=+arr_val*1;
					arr_val=1;
				}
				else
					st_offset+=1;
			}	
			else{
				if(arr_val!=1)
				{
					st_offset=+(arr_val*4);
					arr_val=1;
				}
				else
					st_offset+=4;
			}
		};
		
P   : pt1 P {str1+="*";}| ;
K   : R 
    | eql num {st_val = $2;}

	| eql fnum {st_val = $2;}| ;
R   : sq1 num sq2  R   
					{
					       arr_val=arr_val*atoi($2);
					}

		|  sq1 num sq2 
					{
						arr_val=arr_val*atoi($2);
					};
T   : INT {st_type = "int";} 
	| FLOAT {st_type = "float";}  
	| CHAR {st_type = "char";};

IEST : IF LP 
		{
			new_label1 = "L" +to_string(label_idx);
			label_idx++;
			new_label2 = "L" +to_string(label_idx);
			label_idx++;
			$<snode>$4->True = new_label1;
			$<snode>$4->False = new_label2;

		}
		COND RP
		{
			$<snode>$7->next = $<snode>$->next;

		} 
		A ELSE
		{
			$<snode>$10->next = $<snode>$->next;
		} 
		A
		{
			patlu = $<snode>$4->code + $<snode>$4->True +":"+ $<snode>$7->code +"goto"+ $<snode>$->next + "\n" + $<snode>$4->False + $<snode>$10->code;   
			$$->code = 
		} 
	 | IF LP
	 	{
	 		patlu = "L"+to_string(label_idx++);
	 		$<snode>$4->True = patlu;
	 		$<snode>$4->False = $<snode>$->next;

	 	} 
	 	COND RP
		 	{
		 		$<snode>$7->next = $<snode>$->next; 
		 	} 
	 	A
		 	{
		 		patlu = $<snode>$4->code + $<snode>$4->True+ ": " + $<snode>$7->code;
		 	}
		%prec REDUCE;

WST  :	WHILE LP
			{
				new_label1 = "L" +to_string(label_idx);
				label_idx++;
				new_label2 = "L" +to_string(label_idx);
				label_idx++;
				$<snode>$4 = new Snode();
				$<snode>$4->True = new_label2;
				$<snode>$4->False = $<snode>$->next;

			} 
		COND RP 
			{
				$<snode>$7 = new Snode();
				$<snode>$7->next = new_label1;
			}
		A
			{
				patlu = new_label1 + " : " + $<snode>$4->code + $<snode>$4->true + ":" + $<snode>$7->code + "goto " + new_label1+"\n";   
				$<snode>$->code =  patlu;
			};
COND :    { 
		 	
		 	patlu  = "L"+to_string(label_idx);
			label_idx++;

			$<snode>$2->True = $<snode>$->True;
			$<snode>$2->False = patlu;

		   }
	   COND OR 
	   		{
	  			$<snode>$5->True = $<snode>$->True;
	  			$<snode>$5->False =  $<snode>$->False;
	  		}
	   COND 
			{
	  			patlu = $<snode>$2->code + $<snode>$2->False + ":"+$<snode>$5->code;
	  			$<snode>$->code = patlu;
	  		}

	 | { 
	 	
	 	patlu  = "L"+to_string(label_idx);
		label_idx++;
		$<snode>$2->True = patlu;
		$<snode>$2->False = $$->False;
	   }
	  COND AND 
	  		{
	  			$<snode>$5->True = $<snode>$->True;
	  			$<snode>$5->False =  $<snode>$->False;
	  		}
	  COND
	  		{
	  			patlu = $<snode>$2->code + $<snode>$2->True +":"+ $<snode>$5->code;
	  			$<snode>$->code = patlu;
	  		}
	 | NOT 
	 		{
	 			
	 			$<snode>$3->True = $<snode>$->False;
	 			$<snode>$3->False = $<snode>$->True;
	 		}
	 	COND 
 			{
 					$<snode>$->code = $3->code;
 			}
	 | EXPR REL EXPR	 
	 				{
	 					
	 					string rel = convertToString($2, strlen($2));
	 					string str1="" ,str2="";
	 					postorder($1,str1); 
	 					postorder($3,str2);
	 					patlu = str1 + str2; 
	 					patlu += " if " + $1->name + " " + rel " " + $3->name+ " goto "+ $$->True + "\n" + "goto " + $$->False;
	 					$$->code = patlu;
	 				}
	 | EXPR %prec  GOLU  {
	 						
	 						string str = "";
	 						postorder($1,str);
	 						patlu = str;
	 						patlu += " if " + $1->name + " " + " > 0" + " goto "+ $$->True + "\n" + "goto " + $$->False;

	 					  }
	 | LP COND RP {
	 				$$ = new Snode();
	 				$$= $2;}
	 | True {	
	 			
	 			patlu  = "goto" + $$->true; $$->code = patlu;
	 		}
	 | False {
	 			
	 			patlu  = "goto" + $$->false; $$->code = patlu;
	 		};

%%

int main(int argc ,char *argv[])
{
  extern FILE *yyin;
  yyin =fopen(argv[1],"r");
  yyparse();
  fclose(yyin);


if(err.size()>0)
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
string prioriry(string s1,string s2)
{
	string res = "";
	if(s1 == "float" && s2 != "float")
		res = "float";
	else if(s1 != "float" && s2 == "float")
		res = "float";
	else if((s1 == "float" && s2 == "float") || (s1 == "int" && s2 == "int"))
		return "yes";

	return res;
}


//------------------------------------------------------------------------------------------

void postorder(struct Snode *ptr, string &str) {
	if (ptr != NULL)
	{
        postorder(ptr->left,str);
		  postorder(ptr->right,str);
		  if (ptr->tok != "ID" && ptr->tok!="NUM" && ptr->lexval!="=")
		  {
		  		string s="";
		  		if(ptr->left->tok == "NUM" && ptr->right->tok == "NUM")
		  		{
		  			string temp = prioriry(ptr->left->type1,ptr->right->type1);

		  			if(temp == "")
		  			{
		  				cout<<"type error"<<endl;
		  				exit(0);
		  			}


		  			else if(temp != "yes")
		  			{
		  				if(ptr->left->type1 != temp)
		  				{
		  					ptr->type1 = temp;
		  					ptr->left->type1 = temp;
		  				    s = s + "t" + to_string(idx) + "=" + "(" + temp +")" + ptr->left->dval + ptr->lexval +  ptr->right->dval + "\n";

		  				}
		  				else
		  				{
                            ptr->type1 = temp;
		  					ptr->right->type1 = temp;
		  					s = s + "t" + to_string(idx) + "=" + ptr->left->dval + ptr->lexval + "(" + temp +")" + ptr->right->dval +"\n";

		  				}
		  			}
		  			else if(temp == "yes")
		  			{
		  				ptr->type1 = ptr->left->type1;
		  				s = s + "t" + to_string(idx) + "=" + ptr->left->dval + ptr->lexval + ptr->right->dval +"\n";
		  			}
		  			str =s;
		  			cout<<s<<endl;
		  		}
		  		
		  		if(ptr->left->tok != "NUM" && ptr->right->tok == "NUM")
		  		{
                    string s="";
		  			string temp = prioriry(ptr->left->type1,ptr->right->type1);
		  			
		  			if(temp == "")
		  			{
		  				cout<<"type error"<<endl;
		  				exit(0);
		  			}
		  			else if(temp != "yes")
		  			{
		  				if(ptr->left->type1 != temp)
		  				{
		  					ptr->type1 = temp;
		  					ptr->left->type1 = temp;
		  					s = s + "t" + to_string(idx) + "=" + "(" + temp +")" + ptr->left->lexval + ptr->lexval +  ptr->right->dval +"\n";
		  				}
		  				else
		  				{
		  					ptr->type1 = temp;
		  					ptr->right->type1 = temp;
		  					s = s + "t" + to_string(idx) + "=" + ptr->left->lexval + ptr->lexval + "(" + temp +")" +ptr->right->dval +"\n" ;
		  				}
		  			}
		  			else if(temp == "yes")
		  			{
		  				ptr->type1 = ptr->left->type1;
		  					s = s + "t" + to_string(idx) + "=" + ptr->left->lexval + ptr->lexval +ptr->right->dval +"\n";
		  			}
		  			str =s;
		  			cout<<s<<endl;
		  		}
		  		if(ptr->left->tok == "NUM" && ptr->right->tok != "NUM")
		  		{
		  			string s="";
		  			string temp = prioriry(ptr->left->type1,ptr->right->type1);
		  			
		  			if(temp == "")
		  			{
		  				cout<<"type error"<<endl;
		  				exit(0);
		  			}
		  			else if(temp != "yes")
		  			{
		  				if(ptr->left->type1 != temp)
		  				{
		  					ptr->left->type1 = temp;
		  					ptr->type1 = temp;
		  					s=s+"t"+to_string(idx)+"="+  "(" + temp +")"+ ptr->left->dval + ptr->lexval+ ptr->right->lexval +"\n";
		  				}
		  				else
		  				{
		  					ptr->right->type1 = temp;
		  					ptr->type1 = temp;
		  					s=s+"t"+to_string(idx)+"="+ ptr->left->dval + ptr->lexval+ "(" + temp +")"+ptr->right->lexval +"\n";
		  				}
		  			}
		  			else if(temp == "yes")
		  			{
		  				    ptr->type1 = ptr->left->type1;
		  					s=s+"t"+to_string(idx)+"="+ ptr->left->dval + ptr->lexval+ptr->right->lexval +"\n";
		  			}
		  			str = s;
		  			cout<<s<<endl;
		  		}


		  		if(ptr->left->tok != "NUM" && ptr->right->tok != "NUM")
		  		{
		  			string s="";
		  			string temp = prioriry(ptr->left->type1,ptr->right->type1);
		  			
		  			if(temp == "")
		  			{
		  				cout<<"type error"<<endl;
		  				exit(0);
		  			}
		  			else if(temp != "yes")
		  			{
		  				if(ptr->left->type1 != temp)
		  				{
		  					ptr->left->type1 = temp;
		  					ptr->type1 =temp;
		  					s=s+"t"+to_string(idx)+"="+ "(" + temp +")" +ptr->left->lexval + ptr->lexval+ ptr->right->lexval+"\n";
		  				}
		  				else
		  				{
		  					ptr->right->type1 = temp;
		  					ptr->type1 = temp;
		  					s=s+"t"+to_string(idx)+"="+ptr->left->lexval + ptr->lexval+ "(" + temp +")" + ptr->right->lexval +"\n";
		  				}
		  			}
                    else if(temp=="yes")
                    {
                    	   ptr->type1 = ptr->left->type1;
		  					s=s+"t"+to_string(idx)+"="+ptr->left->lexval + ptr->lexval+ ptr->right->lexval +"\n";
                    }
                    str = s;
		  			cout<<s<<endl;
		  		}


		  		
		  		ptr->lexval="t"+to_string(idx);
		  		ptr->tok="ID";
		  		idx++;
		  }
		  else if (ptr->tok != "ID" && ptr->tok!="NUM" && ptr->lexval == "=")
		  {
		  	string s="";
		  	if(ptr->left->type1 != ptr->right->type1)
		  	{

		  		s = s + ptr->left->lexval+"="+ "(" + ptr->left->type1 + ")"  + ptr->right->lexval +"\n";
		  	}
		  	else  s = s + ptr->left->lexval+"="+ ptr->right->lexval +"\n";

		  		str =s;
		  		cout<<s<<endl;
		  }
		  
	}
}


string check(string spr)
{
	stack<sym> temp;
    string res="";
	while(s.size()>0)
	{
       map<string ,node> m = s.top();
       s.pop();
       auto it=m.find(spr);
       temp.push(m);

       if(it!=m.end())
       {
       	   node p=it->second;
       	   res=p.type;
       	   break;
       }

	}


     while(temp.size()>0)
       {
       	  s.push(temp.top());
       	  temp.pop();
       }

       return res;
}