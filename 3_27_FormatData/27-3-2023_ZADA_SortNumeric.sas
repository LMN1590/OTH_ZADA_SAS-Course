* 	ZADA
	Format Data
		Sort numeric
	27/03/2023
	LMN;

data techassets;
	input ticker $ assets;
	datalines;
	AAPL 365725
	AMZN 162648
	FB 97334
	GOOGL 232792
	MSFT 258848
	TSLA 29739.614
	;
run;

proc print data=techassets;
	format assets dollar8.;
proc sort data=techassets out=sortasc;
	by assets;
	format assets dollar8.;
proc print data=sortasc;
proc sort data=techassets out=sortdesc;
	by descending assets;
	format assets dollar8.;
proc print data=sortdesc;
run;