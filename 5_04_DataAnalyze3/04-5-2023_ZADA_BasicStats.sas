* 	ZADA
	SQL
		Basic Statistics
	04/05/2023
	LMN;
*/home/u63345509/sasuser.v94/Data/;
*var 	claim noclaim
		male female
		young middleage old
		highlyurban urban rural highlyrural
		paneltruck pickup sedan sportscar suv van
		private commercial;

proc import datafile="/home/u63345509/sasuser.v94/Data/claimsonerow.xlsx"
	dbms=xlsx out=claims replace;
	getnames=yes;
	
proc means data=claims maxdec=2 mean stddev;
	var claim noclaim
		male female
		young middleage old
		highlyurban urban rural highlyrural
		paneltruck pickup sedan sportscar suv van
		private commercial;
proc univariate data=claims;
	var claim;
		probplot claim;
proc corr data=claims;
	var claim noclaim
		male female
		young middleage old
		highlyurban urban rural highlyrural
		paneltruck pickup sedan sportscar suv van
		private commercial;
		
proc anova data=claims;
	class highlyurban;
	model claim=highlyurban;
	means highlyurban;
proc freq data=claims;
	tables claim*young / chisq;
proc ttest data=claims;
	class claim;
	var sportscar;


proc probit data=claims;
	model claim = 
		male
		young middleage
		highlyurban urban rural
		paneltruck pickup sedan sportscar suv
		private;
		
proc varclus data=claims outtree=varclus_tree1 centroid;
	var claim noclaim
		male female
		young middleage old
		highlyurban urban rural highlyrural
		paneltruck pickup sedan sportscar suv van
		private commercial
	;
run;




