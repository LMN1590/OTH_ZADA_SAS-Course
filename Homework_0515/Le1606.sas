* Nghia Le 15/05/23;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;
	
proc means data="/home/u63345509/sasuser.v94/Data/college" noprint n nmiss mean min max;
	class gender schoolsize;
	var gpa classrank;
	output 	out=college
			n= 
			nmiss=
			mean=
			min=
			max= /autoname;
run;

data 	Grand(drop=gender schoolsize)
		ByGender(drop=schoolsize)
		BySize(drop=gender)
		Cell;
	set college;
	drop _type_;
	rename _freq_ = Count;
	if(_type_=0) then output Grand;
	if(_type_=2) then output ByGender;
	if(_type_=1) then output BySize;
	if(_type_=3) then output Cell;
run;

proc print data=Grand;
	title "Grand";

proc print data=ByGender;
	title "ByGender";

proc print data=BySize;
	title "BySize";

proc print data=Cell;
	title "Cell";
run;

