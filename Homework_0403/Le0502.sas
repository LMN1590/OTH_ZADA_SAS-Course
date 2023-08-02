* Nghia Le 03/04/23;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;
	
filename input '/home/u63345509/sasuser.v94/Data/voter.txt';	

proc format;
	value Age
		. = 'N/A'
		low-30='0-30'
		31-50='31-50'
		51-70='51-70'
		71-high='71+';
	value $Party
		'D' 	= 'Democrat'
		'R' 	= 'Republican'
		' ' 	= 'N/A'
		other	= 'Misscoded';
	value $LRT
		1='Strongly Disagree'
		2='Disagree'
		3='No Opinion'
		4='Agree'
		5='Strongly Agree';
	value $LRTnew
		1-2='Generally Disagree'
		3='No Opinion'
		4-5='Generally Agree';

data Voter;
	infile input;
	input 	Age
			Party: $1.
			(Ques1-Ques4) ($1. +1);
	label 	Ques1='The president is doing a good job'
			Ques2='Congress is doing a good job'
			Ques3='Taxes are too high'
			Ques4='Government should cut spending';
run;

proc print data=Voter label;
	format 	Age Age.
			Party $Party.
			Ques1-Ques4 $LRTnew.;
run;

proc freq data=Voter;
	tables Ques1-Ques4;
	format Ques1-Ques4 $LRTnew.;
run;