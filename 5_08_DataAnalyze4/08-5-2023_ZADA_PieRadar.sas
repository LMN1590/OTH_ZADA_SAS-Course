* 	ZADA
	SQL
		Pie Chart and Radar Chart
	08/05/2023
	LMN;

data sestwo;
	set "/home/u63345509/sasuser.v94/Data/ses";
run;

proc gchart data=sestwo;
	pie age	/ clockwise percent=outside;
	pie status / clockwise percent=outside group=gender across=2;
	pie gp / clockwise detail=gender detail_percent=best legend;
	title 'Pie Chart';
	
proc gradar data=sestwo;
	chart age;
	chart status / overlayvar=gender;
	title 'Radar Chart';
run;