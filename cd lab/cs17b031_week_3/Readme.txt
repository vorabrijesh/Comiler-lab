Commands:
	$ make
	$ make clean
	$ ./slex 5 2 2 0


The executable file slex takes 4 arguments from command line: total states, no. of accepting states, no. of symbols, dfa(1)/nfa(0). 

I have mapped the given states to 0,1,2... so on and mapped accepting states accordingly. 

Then I took the given symbols(a,b,c or any other symbols) and mapped to 0,1,2.. so on. 

psuedo code for nfa which I used:
	S = e_closure(s0);
	c = nextchar();
	while(c!=eof)
	{
		S= e_closure(move(S,c));
		c =nextchar();
	}
	if(S intersection F != phi)
		return "yes";
	else 
		return "no";


