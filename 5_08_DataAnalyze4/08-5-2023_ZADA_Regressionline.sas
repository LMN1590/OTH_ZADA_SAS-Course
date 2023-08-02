* 	ZADA
	SQL
		Series, Scatter, Box plot
	08/05/2023
	LMN;

data sesfour;
	set "/home/u63345509/sasuser.v94/Data/ses";
run;

proc sgplot data=sesfour;
	reg y=time4 x=sex / clm cli;
	title "SGPLOT Regression Line";
proc gplot data=sesfour;
	plot time4*status;
	symbol1 i=stdljt;
	title 'GPLOT Regression Line';
	
axis1 order=(1 to 5 by 1) label=('Social Econ Status');
axis2 order=(24 to 28 by 2) label=(a=90 'Time after 24 months');
proc gplot data=sesfour;
	plot time4*status / haxis=axis1 vaxis=axis2;
	symbol1 i=stdljt;
	title 'GPLOT Regression Line customized';
run;