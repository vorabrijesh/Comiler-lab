Roll No :cs17b031
Name: Vora Brijesh

Commands
 $make clean
 $make
 $./rdparser input.txt

Grammer for recursive descent:

	S -> S || A | A
	A -> A && B | B
	B -> B == C | B != C | C
	C -> C < D | C > D | C <= D | C >= D | D
	D -> D + E | D - E | E
	E -> E * F | E / F | E % F | F
	F -> ++F | --F | !F | G
	G -> G++ | G-- | id


Grammer without left recursion and left factoring:

	S  -> AS'
	S' -> ||AS' | e
	A  -> BA'
	A' -> &&BA' | e
	B  -> CB'
	B' -> ==CB' | !=CB' | e
	C  -> DC'
	C' -> <DC' | <= DC' | >DC' | >=DC' | e 
	D  -> ED'
	D' -> +ED' | -ED' | e
	E  -> FE'
	E' -> *FE' | /FE' | %FE' | e
	F  -> ++F | --F | !F | G
	G  -> idG'
	G' -> ++G' | --G' | e






