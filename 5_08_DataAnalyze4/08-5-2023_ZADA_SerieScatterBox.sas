* 	ZADA
	SQL
		Series, Scatter, Box plot
	08/05/2023
	LMN;

data sesthree;
	set "/home/u63345509/sasuser.v94/Data/ses";
run;

proc sort data=sesthree;
	by id;
proc sgplot data=sesthree;
	series x=id y=time1;
	title 'Series';
proc sgplot data=sesthree;
	scatter x=age y=time2;
	title 'SGPLOT basic scatterplot';
proc gplot data=sesthree;
	plot time2*age;
	title 'GPLOT basic scatterplot';

proc sgplot data=sesthree;
	vbox time3 / category=gp;
	title "SGPLOT boxplot";
proc gplot data=sesthree;
	plot time3*gp;
	title 'GPLOT boxplot';
run; 