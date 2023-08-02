* 	ZADA
	Format Data
		Date and Time
	30/03/2023
	LMN;

data processtime;
	input 	datein 		: 	ddmmyy8.
			timein 		: 	time7.
			datetimeout	:	datetime19.;
	datetimein=dhms(datein,0,0,timein);
	days=(datetimeout-datetimein)/(24*60*60);
	datalines;
30032023 10:00am 03may2023:17:00:00
	;
run;

proc print data=processtime;
	format datein ddmmyy10. timein time10. datetimeout datetimein datetime19. days 3.;
run;