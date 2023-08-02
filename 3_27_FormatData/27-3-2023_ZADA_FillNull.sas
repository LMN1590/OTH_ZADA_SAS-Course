* 	ZADA
	Format Data
		Fill in null values
	27/03/2023
	LMN;
	
data financialbank;
	set '/home/u63345509/sasuser.v94/Data/financialdata';
run;

proc stdize data=financialbank out=real reponly missing=0;
	var _numeric_;

proc print data=real (obs=20);
	format _character_ $20. _numeric_ dollar15.;
run;