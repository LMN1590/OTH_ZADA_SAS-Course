* Nghia Le - Problem Set 2;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;
	
filename input '/home/u63345509/sasuser.v94/Data/olympicceremony.csv';

*Question A;
proc import
	datafile=input dbms=csv out=cmt replace;
	getnames=yes;
	guessingrows=max;

data comment_analysis;
	set cmt;
	lowtext=lowcase(speech);
	numberwords=countw(lowtext);

proc print data=comment_analysis;
	title 'Speech Analysis';
run;

data record;
	set comment_analysis;
	array word {1:1000} $20. _TEMPORARY_;
	do i=1 to numberwords;
		cur = scan(lowtext,i,' ');
		word(i) = cur;
		output;
	end;
run;

proc freq data=record order=freq;
	title 'Word Frequency in Descending order';
	table cur/nocum;
run;