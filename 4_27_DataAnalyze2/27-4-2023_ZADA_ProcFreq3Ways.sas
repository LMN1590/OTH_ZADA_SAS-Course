* 	ZADA
	Data Analysis 2
		PROC FREQ three-way
	27/04/2023
	LMN;
	
proc import datafile="/home/u63345509/sasuser.v94/Data/airlineroutes.xlsx" dbms=xlsx
	out=routesthree replace;
	getnames=yes;
	
proc freq data=routesthree;
	tables airlinename*origincontinentname*destinationcontinentname;
	label airlinename="AirlineName" origincontinentname="Origin" destinationcontinentname="Dest";
	title "FREQ 3-ways";
run;
