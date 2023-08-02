* 	ZADA
	Data Analysis 1
		PROC SUMMARY
	24/04/2023
	LMN;

data carssix;
 	set "/home/u63345509/sasuser.v94/Data/automobiles";
run;

proc summary data=carssix;
	class make type;
	var cylinders horsepower mpgcity mpghighway;
	output out=carssummary
		mean=meancylinders mean=meanhorsepower mean=meanmpgcity mean=meanmpghighway
		stddev=stdcylinders stddev=stdhorsepower stddev=stdcity stddev=stdmpghighway /
		levels ways;

proc print data=carssummary;
	title 'Cars summary';
	format _numeric_ 6.2;
run;