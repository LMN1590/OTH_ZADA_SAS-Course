* 	ZADA
	Data Analysis 1
		PROC MEANS print all
	24/04/2023
	LMN;

data carsfour;
 	set "/home/u63345509/sasuser.v94/Data/automobiles";
run;

proc means data=carsfour maxdec=0 printalltypes;
	var msrp invoice;
	class make type;
	title "Print all types";
run;