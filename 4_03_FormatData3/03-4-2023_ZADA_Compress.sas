* 	ZADA
	Format Data
		Weather
	03/04/2023
	LMN;

data weather;
	set '/home/u63345509/sasuser.v94/Data/weatherstation';
	station=compress(station,' -. ');
	location=propcase(compbl(location),', ');
	city=scan(location,1);
	prefecture=scan(location,2);
	country=scan(location,-1);
	drop location;
run;

proc print data=weather;
	format precip comma5.;
run;