* Nghia Le - Problem Set 1;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;

filename input '/home/u63345509/sasuser.v94/Data/eventmedals2020.txt';

*Question A;
data medalsA;
	infile input;
	input 	year		1-4
			season	$	6-11
			sport	$	13-28
			event	$	30-63
			gender	$	65
			points		67
			country	$	69-86;
run;

*Question B;
data medalsB;
	set medalsA;
	length medal $ 6;
	if(points=3) then medal='Gold';
	else if(points=2) then medal='Silver';
	else medal='Bronze';
run;

*Question C;
proc format;
	value $Gender
		'M'='Male'
		'F'='Female'
		'X'='Mixed'
		other='Error';
run;
		
data medalsC;
	set medalsB;
	format gender $Gender.;
run;

*Question D;
data medalsD;
	set medalsC;
	keep sport event gender medal country;
	label
		sport='Olympic Sport'
		event='Olympic Event'
		gender='Gender'
		medal='Medal'
		country='Country'
	;
run;	
proc print data=medalsD label;
	title '2020 Tokyo Olympic Medals';
	var sport event gender medal country;
run;


