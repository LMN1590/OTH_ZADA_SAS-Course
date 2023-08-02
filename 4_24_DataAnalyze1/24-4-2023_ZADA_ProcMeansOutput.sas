* 	ZADA
	Data Analysis 1
		PROC MEANS output
	24/04/2023
	LMN;

data carsfive;
 	set "/home/u63345509/sasuser.v94/Data/automobiles";
run;

proc means data=carsfive maxdec=0;
	class make type;
	var cylinders horsepower mpgcity mpghighway;
	output out=carmeans
		mean(cylinders horsepower mpgcity mpghighway)=
			meancylinders meanhorsepower meanmpgcity meanmpghighway
		stddev(cylinders horsepower mpgcity mpghighway)=
			stdcylinders stdhorsepower stdmpgcity stdmpghighway;
run;

proc print data=carmeans;
	format _numeric_ 6.2;
run;