* 	ZADA
	Format Data
		Unbundel Date
	30/03/2023
	LMN;
	
data deconstruct;
	input @1 date ddmmyy8.;
	weekday=weekday(date);
	dayofmonth=day(date);
	month=month(date);
	year=year(date);
	datalines;
10121945
06121965
10121945
20011999
06121968
25051966
	;
run;

proc print data=deconstruct;
	format date weekdate.;
run;