%{
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
%}

%union 
{
	 int dval;
	 char lexeme[20];
}
		
%token NUM FNUM sq1 sq2 FLOAT INT CHAR SCOL COMMA ID cb1 cb2 eql pt1


%type <lexeme> NUM;
%type <lexeme> ID;
%type <lexeme> FNUM;
%type <lexeme> FLOAT;
%type <lexeme> INT;
%type <lexeme> CHAR;


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
	| ;


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
		
P   : pt1 P {str1+="*";}| ;
K   : R 
    | eql NUM 
		{global_val = $2;}
    | eql FNUM 
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

%%

int main(int argc ,char *argv[])
{
  extern FILE *yyin;
  yyin =fopen(argv[1],"r");
  yyparse();
  fclose(yyin);

if(err.size()==0)
{
  for(int i = 0; i < v.size(); i++)
  {
  	symtable y = v[i];
  	for(auto it = y.begin(); it != y.end(); it++)
  	{
  		node y = it->second;
  		std::stringstream stream;
		stream << std::hex << y.offset;
		std::string result( stream.str() );
		int zeros = result.size();
		zeros = 4-zeros;
		while(zeros--)
		{
			result="0"+result;
		}
		cout<<"0x"<<result<<"  ";
		cout<<y.ptr;
  		cout<<it->first<<"  ";
  		cout<<y.type<<"  "<<y.value<<"  "<<endl;
  	}
  	cout<<endl;
  }
}
else{
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
