* Nghia Le 15/05/23;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;
	
data blood;
	set "/home/u63345509/sasuser.v94/Data/bloodpressure";
run;

title 'Subjects in Gender and Age Order';
proc report data=blood;
	column Gender Age SBP DBP;
	define Gender / group;
	define Age / group;
	define SBP / display "Systolic Blood Pressure";
	define DBP / display "Diastolic Blood Pressure";
run;