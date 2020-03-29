#include <stdio.h>
#include <stdlib.h>
#include <iostream> 
#include<bits/stdc++.h>
using namespace std;

int str_to_int(char *s)
{
	int num=0;
	int i=0;
	while(i<strlen(s))
	{
		num=((s[i])-'0')+num*10;
		i++;   
	}
	return num;
}

int main(int argc, char **argv)
{
	ifstream table;
    table.open("table.txt");
	ifstream input_str;
    input_str.open("strings.txt");
    string ch;
	char *a = argv[1];
	char *b = argv[2];
	char *c = argv[3];
	char *d = argv[4];

	// convert arguments to integer
	int total_states = str_to_int(argv[1]);
	int n_acc_states = str_to_int(argv[2]);
	int n_symbols = str_to_int(argv[3]);
	int dfa = str_to_int(argv[4]);
	
	table>>ch;
    vector<string> states;
    int i=0;
    map<string, int > stat;
    while (i<total_states)
    {
		states.push_back(ch);
		//cout<<ch<<" ";
		stat[ch] = i;
		i++;
        table>>ch;
    }
    map<string, int > acc;
    vector<string> acc_states;
    i=0;

    while (i<n_acc_states)
    {
		acc[ch] = i;
   		acc_states.push_back(ch);
   		//cout<<ch<<" ";
   		i++;
        table>>ch;
    }
    i=0;
    
    vector<string> symbols;
    map<string, int > sym;

    while (i<n_symbols)
    {
   		symbols.push_back(ch);
   		//cout<<ch<<" ";
   		sym[ch] = i;
   		i++;
   		
        table>>ch;
    }
    if(dfa==0)
    {
    	symbols.push_back("$");
    	sym["$"]=i;
    }
	if(dfa==1)
	{
	    i=0;
	    int j=0;
	    string matrix[total_states][n_symbols+1];
	    //table>>ch;
	    
	    while (i<total_states)
	    {
			matrix[i][j] = ch;
			//cout<<matrix[i][j];
			j++;
	   		
	   		if(j==n_symbols)
	   		{
	   		   i++;
	   		   j=0;  
	   		}
	        table>>ch;
	    }

	    string s;
	    while(input_str >> s)
		{   
			i = 0;
			//stringstream stoi(states[0]);
			int w = stat[states[0]];
		    while( i < s.size())
		    { 

		        string e ="";
		        e +=s[i];
				int y =sym[e];
				//cout<<y;
		        w = stat[matrix[w][y]];
		        i++;
		    }
		    int flag=0;
			for(int i=0;i<acc_states.size();i++)
			{
				if( w == stat[acc_states[i]]){
		        flag=1;
		        break;
		        //cout<< "yes\n";
		    	}
			}
			if(flag==1)
			{
				cout<<"yes\n";
			}
		    else{
		         cout<<"no\n";
		    }
	    }
	}
	if(dfa==0)
	{
		i=0;
	    int j=0,k=0;
	    string mat[total_states][n_symbols+1][total_states];
	    for(int l=0;l<total_states;l++)
	    	for(int m=0;m<n_symbols+1;m++)
	    		for(int n=0;n<total_states;n++)
	    			mat[l][m][n]="";

	    while (i<total_states)
	    {
	    	//cout<<ch<<endl;
	    	stringstream ss(ch);
   			string token;
			while (getline(ss,token, ','))
			{
			    //cout<< token <<endl;
			    mat[i][j][k]=token; 
			    //cout<<token<<" ";
			    k++;
			}
			//cout<<endl;
			k=0;
			j++;
	   		
	   		if(j==n_symbols+1)
	   		{
	   		   i++;
	   		   j=0;  
	   		}
	   		
	        table>>ch;
	    }
	    string s;
	    //cout<<endl;
	    while(input_str>> s)
	    {
	    	i=0;
	    	int w = stat[states[0]];
	    	
	    	set<int> t1;
	    	t1.insert(w);
			set <int > :: iterator itr; 
		    set<int> r;
		    for (itr = t1.begin(); itr != t1.end(); itr++) 
		    { 
		        r.insert(*itr); 
		    	//cout<<*itr<<" ";
			    for(int k=0;k<total_states;k++)
			    { 
					if(mat[*itr][n_symbols][k]!="^" && mat[*itr][n_symbols][k]!="")
					{
						int x=stoi(mat[*itr][n_symbols][k]);
						r.insert(x);
						//cout<<x<<" ";
					}
				}
			}
			//cout<<endl;
	    	while(i<s.size())
	    	{
	    		string e ="";
		        e +=s[i];
				int y =sym[e];
	    		//set<int> tmp=move(r,y);
	    		set<int> tmp;
				set <int > :: iterator itr; 
				for (itr = r.begin(); itr != r.end(); itr++) 
			    { 
			    	for(int k=0;k<total_states;k++)
			    	{
				        if(mat[*itr][y][k]!="^" && mat[*itr][y][k]!="")
				        {
				        	int x;

				        	stringstream ss(mat[*itr][y][k]);
				        	ss>>x;
				        	//int x=stoi(mat[*itr][n_symbols][k]);
				        	tmp.insert(x);
				        	//cout<<mat[*itr][y][k];
				        }
			    	}
			    }
			    //cout<<endl;
	    		set <int > :: iterator itr1; 
			    set<int> q;
			    for (itr1 = tmp.begin(); itr1 != tmp.end(); itr1++) 
			    { 
			        q.insert(*itr1); 
			    	//cout<<*itr1<<" ";
				    for(int k=0;k<total_states;k++)
				    { 
						if(mat[*itr1][n_symbols][k]!="^" && mat[*itr1][n_symbols][k]!="")
						{
							int x;
				        	stringstream ss1(mat[*itr1][n_symbols][k]);
				        	ss1>>x;
							//int x=stoi(mat[*itr1][n_symbols][k]);
							q.insert(x);
							//cout<<x<<" ";
						}
					}
				}
	    		//r = e_closure(tmp);
	    		i++;
	    		r=q;
	    	}
	    	int flag=0;
	    	i=0;
	    	set <int > :: iterator it; 
			for (it = r.begin(); it != r.end(); it++) 
		    {
		    	//cout<<*it<<endl;
		    	for(int i=0;i<acc_states.size();i++)
		    	{
					if( *it == stat[acc_states[i]])
					{
			        	flag=1;
			        	break;	
		    		}
		    	}
		    	if(flag==1)
		    		break;
		    	
			}
			if(flag==1)
			{
				cout<<"yes\n";
			}
		    else{
		         cout<<"no\n";
		    }
	    }
	}
	return 0;
}