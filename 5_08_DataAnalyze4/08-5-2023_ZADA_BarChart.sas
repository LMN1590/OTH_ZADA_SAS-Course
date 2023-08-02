* 	ZADA
	SQL
		Horizontal and Vertical Bar Charts
	08/05/2023
	LMN;

data sesone;
	set "/home/u63345509/sasuser.v94/Data/ses";
run;

proc gchart data=sesone;
	hbar gp;
	title "Horizontal Chart";
proc gchart data=sesone;
	vbar gender / group=gp;
	title "Vertical Chart";
proc sgpanel data=sesone;
	panelby status;
	hbar gp;
	title 'Panel of bar charts';
run;