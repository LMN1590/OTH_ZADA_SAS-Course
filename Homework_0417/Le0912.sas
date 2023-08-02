* Nghia Le 17/04/23;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;
	
data visit;
	set '/home/u63345509/sasuser.v94/Data/medical';
	ReturnDate=intnx('week',VisitDate,5,'SAME');
	format ReturnDate mmddyy10.;
run;

proc print data=visit;
	var Patno VisitDate ReturnDate;
run;