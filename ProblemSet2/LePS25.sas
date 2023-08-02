* Nghia Le - Problem Set 2;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;
	
*Question A;
data medals;
	set "/home/u63345509/sasuser.v94/Data/olympicmedals";
	temp=catx(' ',year,gametype);
	if year ge 1994 and year le 2022 then
		output;
run;
proc tabulate data=medals;
	title 'Country by Sport';
	class country sport;
	table country, sport;
run;

*Question B;
proc tabulate data=medals;
	title 'Sum of Scores of Country by Year';
	class country year gametype;
	var swedishscore;
	table (country all), (year*gametype all)*(swedishscore*(sum)*format=comma6. reppctn);
run;
	