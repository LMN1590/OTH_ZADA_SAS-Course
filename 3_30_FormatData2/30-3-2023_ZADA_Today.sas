* 	ZADA
	Format Data
		Date format and Interval Computation
	30/03/2023
	LMN;

data passport;
	input 	@1 name $9.
			@11 birthday ddmmyy8.;
	today=today();
	renewDate=today+(365.25*10);
	datalines;
James     10121945
John      20011999
Lily      06121968
Steve     25051966
	;
run;

proc print data=passport;
	format birthday today renewDate weekdate.;
	title 'Passport';
run;