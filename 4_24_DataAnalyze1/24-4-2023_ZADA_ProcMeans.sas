* 	ZADA
	Data Analysis 1
		PROC MEANS formats
	24/04/2023
	LMN;

data carsone;
 	set "/home/u63345509/sasuser.v94/Data/automobiles";
run;

proc means data=carsone;
	var msrp invoice;
	title 'Default stats and default output';
	
proc means data=carsone maxdec=0;
	var enginesize cylinders horsepower;
	title 'Default stats and formatted output';
	
proc means data=carsone maxdec=0 n min mean median max;
	var weightlbs wheelbasein lengthin;
	title "Specific stats and formatted output";
	
proc means data=carsone maxdec=0 p10 q1 p50 q3 p90;
	var mpgcity mpghighway;
	title "More specific stats and formatted output";

run;