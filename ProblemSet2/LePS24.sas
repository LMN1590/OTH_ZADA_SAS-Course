* Nghia Le - Problem Set 2;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;
	
*Question A;
data medals;
	set "/home/u63345509/sasuser.v94/Data/olympicmedals";
run;
proc sql;
	create table countCountry as 
	select country, count(*) as numberMedal
	from medals
	group by country;
quit;

proc print data=countCountry;
	title 'Number of medals per country';
run;

*Question B;
data worldmap;
	set mapsgfk.world;
	country=idname;
	
*Question C&D;
proc gmap data=countCountry map=worldmap all;
	title 'Total Olympic medals by country';
	id country;
	choro numberMedal/levels=7;
run;
