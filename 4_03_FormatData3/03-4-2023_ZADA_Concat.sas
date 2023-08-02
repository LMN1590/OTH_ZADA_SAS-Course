* 	ZADA
	Format Data
		Concat
	03/04/2023
	LMN;
	
data name;
	length name1-name3 $20.;
	firstname="Nghia ";
	lastname="Le";
	name1=firstname||lastname;
	name2=cats(firstname,lastname);
	name3=catx(':',firstname,lastname);
run;

proc print data=name;
run;
	