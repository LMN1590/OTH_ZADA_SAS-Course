* Nghia Le - Problem Set 1;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;
	
* /home/u63345509/sasuser.v94/Data/;

* Question A;
proc sql;
	create table Q_A as
	select *
	from '/home/u63345509/sasuser.v94/Data/resultsone' r,
		'/home/u63345509/sasuser.v94/Data/countries' c,
		'/home/u63345509/sasuser.v94/Data/events' e
	where r.code=c.code and r.event=e.event;
run;

* Question B;
proc sql;
	create table Q_B as
	select year, sport, event, gender, medal, rank, country
	from Q_A;
run;

* Question C;
proc sql;
	create table Q_C as
	select *
	from Q_B
	order by year, event, sport, rank;
run;

* Question D;
proc sql;
	title '1924-1972 Winter Olympics';
	select * from Q_C;
run;