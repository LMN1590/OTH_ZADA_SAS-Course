* Nghia Le - Problem Set 2;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;
	
filename input '/home/u63345509/sasuser.v94/Data/wintermedals.csv';

*Question A;
proc import
	datafile=input dbms=csv out=winter_medal replace;
	getnames=yes;
	guessingrows=max;
proc print data=winter_medal;
run;

*Question B;
proc corr data=winter_medal;
	var medals percapitagdp population temperature;
	title  'Variable Temperature, coefficient -0.44581, p 0.0106';

*Question C;
proc reg data=winter_medal;
	model medals = percapitagdp population temperature;
	title  'Variable Temperature, coefficient -4.64684, p 0.0142';
run;