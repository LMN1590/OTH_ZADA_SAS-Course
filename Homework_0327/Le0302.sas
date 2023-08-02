* Nghia Le 27/03/23;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;

*a;
filename input '/home/u63345509/sasuser.v94/Data/political.csv';

data Vote;
	infile input dsd;
	input State $ Party $ Age;
run;

*b;
proc print data=Vote;
	title 'Data';
run;