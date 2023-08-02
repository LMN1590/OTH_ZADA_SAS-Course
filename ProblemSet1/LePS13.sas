* Nghia Le - Problem Set 1;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;
	
filename input '/home/u63345509/sasuser.v94/Data/olympichosts.csv';

*Question A;
proc import
	datafile=input dbms=csv out=host replace;
	getnames=yes;
	guessingrows=max;
run;

*Question B;
data hostB;
	set host;
	season=scan(seasonyear,1,'-');
	year=scan(seasonyear,-1,'-');
run;

*Question C;
data hostC;
	set hostB;
	city=scan(citycountry,1,',');
	country=scan(citycountry,-1,',');
run;

*Question D;
data hostD;
	set hostC;
	enddate=mdy(endmonth,endday,endyear);
	enddatetime=dhms(enddate,0,0,endtime);
	format enddate date. enddatetime datetime.;
run;

*Question E;
data hostE;
	set hostD;
	hourslength=intck('hour',startdatetime,enddatetime);
run;

*Question F;
proc sort data=hostE out=hostF;
	by year descending season;
proc print data=hostF;
	title 'Hosting Countries for the Olympic';
	var year season city country hourslength;
run;
	