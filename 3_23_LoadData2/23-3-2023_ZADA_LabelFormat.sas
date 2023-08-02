proc format;
	value $Gender
		'M'='Male'
		'F'='Female'
		other='Other';
	value Age
		low-<30='Less than 30'
		30-<50='30 to 50'
		50<-high='More than 50';
	value Likert
		1-2='Disagree'
		3='Neutral'
		4-5='Agree';

proc import 
	datafile='/home/u63345509/sasuser.v94/Data/driver.txt' dbms=dlm out=driver replace;
	getnames=yes;
	label 
		ID='ID'
		Gender='Sex'
		Age="Oldness"
		Salary='Income';
proc print 
	data=driver label;
	id ID;
	format 	gender $Gender.
			Age Age.
			Ques1-Ques5 Likert.;

run;