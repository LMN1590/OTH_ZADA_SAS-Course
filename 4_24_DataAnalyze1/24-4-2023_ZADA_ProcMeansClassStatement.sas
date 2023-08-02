* 	ZADA
	Data Analysis 1
		PROC MEANS with CLASS statement(Same Table for each Group)
	24/04/2023
	LMN;
	
data carsthree;
 	set "/home/u63345509/sasuser.v94/Data/automobiles";
run;
proc means data=carsthree maxdec=0;
	var enginesize cylinders horsepower;
	class make;
	title 'Class make';
run;

proc means data=carsthree maxdec=0;
	var mpgcity mpghighway;
	class type;
	title 'Class type';
run;

proc means data=carsthree maxdec=0;
	var msrp invoice;
	class make type;
	title 'Class make and type';
run;