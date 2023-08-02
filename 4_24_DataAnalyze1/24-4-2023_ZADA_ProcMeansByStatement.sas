* 	ZADA
	Data Analysis 1
		PROC MEANS with BY statement(Different Table for each Group)
	24/04/2023
	LMN;

data carstwo;
 	set "/home/u63345509/sasuser.v94/Data/automobiles";
run;

proc sort data=carstwo;
	by make;
proc means data=carstwo maxdec=0;
	var msrp invoice;
	by make;
	title 'By make';
run;

proc sort data=carstwo;
	by type;
proc means data=carstwo maxdec=0;
	var mpgcity mpghighway;
	by type;
	title "By type";
run;

proc sort data=carstwo;
	by drivetrain;
proc means data=carstwo maxdec=0;
	var enginesize cylinders horsepower;
	by drivetrain;
	title "By drivetrain";
run;