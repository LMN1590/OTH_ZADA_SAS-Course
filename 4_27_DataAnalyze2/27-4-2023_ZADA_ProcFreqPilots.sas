* 	ZADA
	Data Analysis 2
		PROC FREQ one-way and two-way and new vars and computations
	27/04/2023
	LMN;

data pilots;
	infile "/home/u63345509/sasuser.v94/Data/pilots.dat";
	input 	employeeid 	$	1-6
			firstname	$	7-19
			lastname	$	20-34
			jobcode		$	35-41
			salary			42-47
			category	$	48-50;
	bonus=salary*0.1;
	if jobcode="PILOT1" then newRate=1.05;
		else if jobcode="PILOT2" then newRate=1.07;
		else if jobcode="PILOT3" then newRate=1.09;
	newSalary=salary*newRate;
	
	format salary bonus newSalary dollar15.3;
run;

proc freq data=pilots;
	table jobcode category
		jobcode*category;
run;