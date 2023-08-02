* 	ZADA
	Format Data
		Create numeric variable and add total
	27/03/2023
	LMN;
	
data marketcap;
	input ticker $ sharesout shareprice;
	marketcap=sharesout*shareprice;
	label 	ticker='Ticker Symbol'
			sharesout='Shares Outstanding'
			shareprice='Share Price'
			marketcap='Market Capitalization'
			;
	datalines;
	AAPL 4754.986 225.74
	AMZN 491 1501.97
	FB 2854 131.09
	GOOGL 695.556 1040.259459
	MSFT 7677 98.61
	TSLA 172.603 332.8
	;
run;

proc print data=marketcap label;
	format 	sharesout comma5. 
			shareprice dollar6.
			marketcap dollar10.;
	sum marketcap;
run;