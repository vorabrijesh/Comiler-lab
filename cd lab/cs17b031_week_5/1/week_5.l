%{
	#include<stdio.h>
	#include<bits/stdc++.h>
	std::vector<std::string> v;
	void installToken(char* str);
	std::vector<std::string> getSym();
%}

/*Rule Section*/
delim   [ \n\t]
ws      {delim}+
letter  [A-Za-z]
digit   [0-9]
id      {letter}({letter}|{digit})*
conditional "if"|"else"|"else if"|"switch"|"case"
keyword "break"|"continue"|"goto"|"printf"|"scanf"|"sprintf"|"sscanf"|"fopen"|"fwrite"|"fread"|"fclose"|"write"|"read"|"open"|"close"|"return"|"int"|"float"|"char"|"unsigned"|"signed"|"short"|"long"|"double"
iterators "for"|"while"|"do"
preprocessor "#"|"#line"|"#undef"|"#error"|"#elif"|"#else"|"#endif"|"#if"|"#define"|"#include"|"#pragma"|"#ifndef"|"#ifdef"
escape "\a"|"\\n"|"\\b"|"\t"|"\\t"|"\b"|"\\a"
separator  ","|"."|";"|":"|"("|")"|"["|"]"|"{"|"}"
arithmatic "+"|"-"|"*"|"/"|"%"
assignment  "="|"+="|"-="|"*="|"/="|"%="
unary "++"|"--"
logical "&&"|"!"|"||"
relop  ">"|"<"|">="|"<="|"=="|"!="
bitwise  "~"|"&"|"|"|"<<"|">>"|"^"
format  "%d"|"%s"|"%c"|"%f"|"%e"
comments  \/\/(.*)|\/\*(.*\n)*.*\*\/ 

%%  
{ws}
{comments}  {}
{digit}+(("e"|"E")?("+"|"-")?{digit}+)?   {printf("\n%s is real number",yytext); }
{digit}+"."{digit}+(("E"|"e")?("+"|"-")?{digit}+)?   {printf("\n%s is floating point number",yytext); }
{conditional} 	{printf("\n%s is conditional",yytext); installToken(yytext);}
{keyword} 		{printf("\n%s is keywords",yytext); installToken(yytext);}
{preprocessor} 	{printf("\n%s is preprocessor",yytext); installToken(yytext);}
{iterators} 	{printf("\n%s is iterators",yytext); installToken(yytext);}
{arithmatic}    {printf("\n%s is arithmatic operator",yytext); }
{relop}     	{printf("\n%s is relational operator",yytext); }
{bitwise}  		{printf("\n%s is bitwise operator",yytext); }
{assignment}    {printf("\n%s is assignment operator",yytext); }
{separator}   	{printf("\n%s is separator",yytext); }
{escape}  		{printf("\n%s is Escape sequences",yytext);}
{unary}   		{printf("\n%s is unary",yytext); }
{id} 			{printf("\n%s is identifier",yytext); installToken(yytext);}
{logical} 		{printf("\n%s is logical",yytext); }
{format} 		{printf("\n%s is a format specifier",yytext);}  

%%  
/* installToken will push the token into vector*/
void installToken(char* str)
{
	std::string s = str;
	int flag=0;
	for(int i=0;i<v.size();i++)
	{
		if(v[i]==str)
		{
			flag=1;
			break;
		}
	}

	if(flag==0)
	{
		v.push_back(str);
	}
}
/* getSym() is get symbol table from above scope and it is passed into main function*/
std::vector<std::string> getSym()
{
	return v;
}
int yywrap()  
{  
	return 1;  
}
int main(int argc, char *argv[])  
{  
	extern FILE *yyin;
	yyin = fopen(argv[1],"r"); 
	yylex(); 

	std::vector<std::string> s;
	s=getSym();
	printf("\n");

	/*Print the symbol table*/
	for(int i=0;i<s.size();i++)
	{
		std::cout<<"\nid";
		std::cout<<i;
		std::cout<<"->"<<s[i];
	}
	printf("\n");
	fclose(yyin);

	return 0;  
} 