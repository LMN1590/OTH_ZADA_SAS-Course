* 	ZADA
	Data Analysis 2
		PROC FREQ one-way default and sorted 
	27/04/2023
	LMN;

proc import datafile="/home/u63345509/sasuser.v94/Data/airlineroutes.xlsx" dbms=xlsx
	out=routesone replace;
	getnames=yes;

proc freq data=routesone;
	table airlinename;
	title "PROC FREQ default result";
proc freq data=routesone order=freq;
	table airlinename;
	title "PROC FREQ sorted result";
run;