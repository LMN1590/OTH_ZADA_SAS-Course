* 	ZADA
	Data Analysis 2
		PROC RANK one var by groups
	27/04/2023
	LMN;
	
data euairports;
	set "/home/u63345509/sasuser.v94/Data/europeairports";
run;

proc rank data=euairports descending out=eurank;
	var passengers;
	ranks passRank;
proc sort data=eurank;
	by country descending passengers;
proc print data=eurank n;
	by country;
	format passengers comma12.;
run;