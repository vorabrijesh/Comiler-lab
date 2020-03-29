%{
    #include<bits/stdc++.h>
    using namespace std;
    int Index=0;
    vector<string> token;
    bool flag=true;
    void S();
    void A();
    void Sdash();
    void Adash();
    void B();
    void Bdash();
    void C();
    void Cdash();
    void D();
    void Ddash();
    void E();
    void Edash();
    void F();
    void G();
    void Gdash();

    void S()
    {
        if(token[Index]=="$")
            return;
        A();
         if(token[Index]=="$" || flag==false)
            return;
        Sdash();
    }
    void Sdash()
    {
        if(token[Index]=="||")
        {
           Index++; 
           A();
           if(token[Index]=="$" || flag==false)
                return;
           Sdash();
        }
        else
            return; 
    }
    void A()
    {
        B();
        if(token[Index]=="$" || flag==false)
            return;
        Adash();
    }
    void Adash()
    {
        if(token[Index]=="&&")
        {
           Index++; 
           B();
           if(token[Index]=="$" || flag==false)
               return;
           Adash();
        }
        else
            return;    
    }
    void B()
    {
        C();
        if(token[Index]=="$" || flag==false)
            return;
        Bdash();
    }
    void Bdash()
    {
        if(token[Index]=="==" || token[Index]== "!=")
        {
           Index++; 
           C();
           if(token[Index]=="$" || flag==false)
              return;
           Bdash();
        }
        else
            return; 
    }
    void C()
    {
        D();
        if(token[Index]=="$" || flag==false)
            return;
        Cdash();
    }
    void Cdash()
    {
        if(token[Index]=="<" || token[Index]==">" ||token[Index]=="<=" ||token[Index]==">=")
        {
           Index++; 
           D();
           if(token[Index]=="$" || flag==false)
              return;
           Cdash();
        }
        else
            return; 
    }
    void D()
    {
        E();
        if(token[Index]=="$" || flag==false)
            return;
        Ddash();
    }
    void Ddash()
    {
        if(token[Index]=="+" || token[Index]=="-")
        {
           Index++; 
           E();
           if(token[Index]=="$" || flag==false)
            return;
           Ddash();
        }
        else
            return; 
    }
    void E()
    {
        F();
        if(token[Index]=="$" || flag==false)
            return;
        Edash();
    }
    void Edash()
    {
        if(token[Index]=="*" || token[Index]=="/" ||token[Index]=="%" )
        {
           Index++; 
           F();
           if(token[Index]=="$" || flag==false)
            return;
           Edash();
        }
        else
            return; 
    }
    void F()
    {
        if(token[Index]=="++" || token[Index]=="--"||token[Index]=="!")
        {
            Index++;
            F();
        }
        else
            G();
    }
    void G()
    {
        if(token[Index]=="id" )
        {
            Index++;
            Gdash();
        }
        else{
            flag=false;
        }
    }
    void Gdash()
    {
        if(token[Index]=="++" || token[Index]=="--")
        {
            Index++;
            Gdash();
        }
        else
            return;

    }



%}

identifier [A-Za-z][A-Za-z0-9_]*

%%
{identifier}     {token.push_back("id");}
[0-9]+    {token.push_back("id");}
[0-9]+"."[0-9]+  {token.push_back("id");}
"++"   {token.push_back("++");}
"--"   {token.push_back("--");}
"+"    {token.push_back("+");}
"-"    {token.push_back("-");}
"*"    {token.push_back("*");}
"/"    {token.push_back("/");}
"&&"   {token.push_back("&&");}
"||"   {token.push_back("||");}
"%"    {token.push_back("%");}
"<"    {token.push_back("<");}
">"    {token.push_back(">");}
"<="   {token.push_back("<=");}
">="   {token.push_back(">=");}
"=="   {token.push_back("==");}
"="    {token.push_back("=");}
"!="   {token.push_back("!=");}
"!"    {token.push_back("!");}
";"    {token.push_back("$");} 
\".*\"          {token.push_back("id");}
"\n"            {token.push_back("$");}
"\t"            {}
" "             {}
%%  


int yywrap()
{
    return 1;
}

int main(int argc, char **argv)
{
    extern FILE *yyin;
	yyin = fopen(argv[1],"r"); 
	yylex(); 
    if(!yyin)
    {
        printf("could not open the file");
        exit(0);
    }
    yylex();
    //
    if(token[token.size()-1]!="$")
        token.push_back("$");
    // for(int i=0;i<token.size();i++)
    // {
    //     cout<<token[i]<<" ";
    // }
    while(Index<token.size())
    {
        S();
        if(token[Index]=="$" && flag==true)
        {
            cout<<"Input is valid\n";
        }
        else{
            cout<<"Input is not valid\n";
        }
        flag=true;
        while(token[Index]!="$")
        {
            Index++;
        }
        Index++;

    }


    return 0;
}