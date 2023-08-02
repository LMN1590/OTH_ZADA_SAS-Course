* Nghia Le - Problem Set 2;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;
	
*Question A;
data medals;
	set "/home/u63345509/sasuser.v94/Data/olympicmedals";
	if gametype = 'Summer' then do;
		if year ge 1936 and year le 2020 then do;
			output;
		end;
	end;
run;

proc freq data=medals order=freq noprint;
	table country/out=numMedal;
run;

proc print data=numMedal(drop=PERCENT) label;
	label COUNT='Number of medals';
	title 'Number of medals by country';
run;

*Question B;
proc freq data=medals order=freq;
	table country*sport/nocum nopercent norow nocol;
	title 'Number of medals by sport by country';

*Question C;
proc freq data=medals order=freq;
	table gender*country*sport/nocum nopercent norow nocol;
	title 'Number of medals by sport by country by gender';
run;
