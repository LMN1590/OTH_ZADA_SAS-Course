* Nghia Le - Problem Set 1;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;
	
*Question A;
data Years20022010;
	set '/home/u63345509/sasuser.v94/Data/countrymedals20022010';
run;

data Years20142022;
	set '/home/u63345509/sasuser.v94/Data/countrymedals20142022';
run;

*Question B;
data Years20022022;
	set Years20022010 Years20142022;
	by year;
run;

*Question C;
data Years20022022;
	set Years20022022;
	totalmedals=sum(Gold,Silver,Bronze);
run;

*Question D;
data Years20022022;
	set Years20022022;
	keep country year totalmedals;
run;
proc sort data=Years20022022 overwrite;
	by country year;
proc print data=Years20022022;
	title 'Total Number of Medals of Countries 2002-2022';
run;