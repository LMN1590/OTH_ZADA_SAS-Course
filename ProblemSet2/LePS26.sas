* Nghia Le - Problem Set 2;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;
	
*Question A;
data medals;
	set "/home/u63345509/sasuser.v94/Data/olympicmedals";
run;

proc report data=medals;
	column country (medal,n);
		define country/group;
		define medal/across;
	title 'Country with Medals';
run;

*Question B;
proc report data=medals;
	column country gametype (sport,n);
		define country/group;
		define gametype/group;
		define sport/across;
	title 'Country with Medals for each game types';
run;