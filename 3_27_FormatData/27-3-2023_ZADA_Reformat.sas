* 	ZADA
	Format Data
		Reformat Char to Num
	27/03/2023
	LMN;

data techchar;
	input ticker $ revchar $ empchar $;
	datalines;
		AAPL 265359 132
		AMZN 232887 647.5
		FB 55838 35.587
		GOOGL 136819 98.771
		MSFT 110360 131
		TSLA 21461.268 48.817
	;
run;

proc print data=techchar;
run;

data technum;
	set techchar;
	revnum=input(revchar,9.);
	empnum=input(empchar,6.);
	revemp=revnum/empnum;
	drop revchar empchar;
run;

proc print data=technum;
	format revnum dollar9. empnum comma3. revemp dollar7.;
run;
	