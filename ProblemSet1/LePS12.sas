* Nghia Le - Problem Set 1;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;

filename input '/home/u63345509/sasuser.v94/Data/wintermedalstotal.xlsx';

*Question A;
proc import
	datafile=input dbms=xlsx out=winter_medal replace;
	getnames=yes;
run;

*Question B;
data winter_medalB;
	set winter_medal;
	populationmedals=(medals/population)*100000;
run;

*Question C;
data winter_medalC;
	set winter_medalB;
	gdpmedals=PerCapitaGDP*population/medals;
run;

*Question D;
data winter_medalD;
	set winter_medalC;
	keep country populationmedals gdpmedals;
	format populationmedals 10.4 gdpmedals comma16.;
run;

proc print data=winter_medalD;
	title 'Statistics about Medal-winning Countries';
run;