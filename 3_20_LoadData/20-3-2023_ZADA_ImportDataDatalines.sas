* 	ZADA
	Input Classes
		Import Data with Space Delim Dataline
	20/03/2023
	LMN;
	
data africacola;
	input 	rank
			city $ 
			country $ 
			cola 
			rent 
			groceries
			restaurant
			ppi;
	datalines;
		1 Harare Zimbabwe 48.87 10.18 39.09 38.55 17.22
		2 Harare Zimbabwe 48.87 10.18 39.09 38.55 17.22
	;
run;

proc contents data=africacola varnum;
proc print data=africacola;
run;