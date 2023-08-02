* 	ZADA
	Data Analysis 2
		PROC FREQ one-way and two-way
	27/04/2023
	LMN;
	
proc import datafile="/home/u63345509/sasuser.v94/Data/airlineroutes.xlsx" dbms=xlsx
	out=routestwo replace;
	getnames=yes;
	
proc freq data=routestwo nlevels;
	tables origincontinentname destinationcontinentname
		origincontinentname*destinationcontinentname;
	title "One-way and Two-ways";
run;