* Nghia Le 08/05/23;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;

	
data names;
	set "/home/u63345509/sasuser.v94/Data/names_and_more";
	LastName=input(scan(name,-1),$15.);
	name=compress(name,' ');
run;

proc sort data=names out=res;
	by lastname;
proc print data=res;
run;