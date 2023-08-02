* Nghia Le - Problem Set 1;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;

*Question A;
data init;
	set '/home/u63345509/sasuser.v94/Data/summermedalstotal';
run;

proc transpose data=init out=temp name=country;
	var _character_;
	id country;
run;

data sum_medal;
	set temp;
	if _n_=1 then delete;
run;

*Question B;
data sum_medalB;
	set sum_medal;
	Gold_Num=input(Gold, 8.);
	Silver_Num=input(Silver, 8.);
	Bronze_Num=input(Bronze, 8.);
	totalpoints=3*Gold_Num + 2*Silver_Num + Bronze_Num;
	drop Gold Silver Bronze;
run;

*Question C;
data sum_medalC;
	set sum_medalB;
	keep country totalpoints;
run;

proc sort data=sum_medalC overwrite;
	by descending totalpoints;
proc print data=sum_medalC;
	title 'Points of Countries';
	format totalpoints comma8.;
run;