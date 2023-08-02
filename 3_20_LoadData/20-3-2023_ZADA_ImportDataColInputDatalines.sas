* 	ZADA
	Input Classes
		Import Data with Space Column Input Dataline
	20/03/2023
	LMN;

data africacola2;
	input 	rank 		1
			city 		$2-10
			country 	$11-20 
			cola 		21-25
			rent 		26-30
			groceries	31-35
			restaurant	36-40
			ppi;
	datalines;
1Harare   Zimbabwe  48.8710.1839.0938.5517.22
2Harare   Zimbabwe  48.8710.1839.0938.5517.22
3123456789Zimbabwe  48.8710.1839.0938.5517.22
	;
run;

proc contents data=africacola2 varnum;
proc print data=africacola2;
run;