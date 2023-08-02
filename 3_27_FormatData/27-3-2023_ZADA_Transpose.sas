* 	ZADA
	Format Data
		Transpose
	27/03/2023
	LMN;
	
data og;
	input variable $ Apple $ Amazon $ Facebook $;
	datalines;
		ticker aapl amzn fb
		naics 334220 454110 519130
		netinc 59531 10073 22112
	;
run;

proc print data=og;
	title 'OG Data';
run;

proc transpose data=og out=trans;
	var Apple Amazon Facebook;

proc contents data=trans;
	title 'Transposed Data';
run;

data final;
	set trans;
	naics=input(COL2,comma10.2);
	netinc=input(COL3,comma10.2);
	drop COL2 COL3;
run;
proc print data=final;
run;




