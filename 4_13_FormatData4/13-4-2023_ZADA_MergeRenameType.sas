* 	ZADA
	Concat and Merge Data
		Merge with MERGE with different names and types
	13/04/2023
	LMN;

data salesid;
	set '/home/u63345509/sasuser.v94/Data/salesid';
run;
proc sort data=salesid;
	by salesid;
proc contents data=salesid;
run;

data idsales;
	set '/home/u63345509/sasuser.v94/Data/idsales'(rename=(IDSales=ID));
	SalesID=input(ID,6.);
	drop ID;
run;
proc sort data=idsales;
	by salesid;
proc contents data=idsales;
run;

data merged;
	merge salesid idsales;
	by SalesID;
run;

proc print data=merged(obs=20);
run;

	
