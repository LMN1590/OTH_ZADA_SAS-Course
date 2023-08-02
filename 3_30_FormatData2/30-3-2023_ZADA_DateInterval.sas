* 	ZADA
	Format Data
		Date format and Interval Computation
	30/03/2023
	LMN;
	
data yearsold;
	input @1 date ddmmyy8.;
	targetDate=mdy(03,30,2023);
	years=intck('year',date,targetDate);
	datalines;
10121945
20011999
06121968
25051966
	;
run;

proc print data=yearsold;
	format date weekdate. targetdate ddmmyy10.;
run;