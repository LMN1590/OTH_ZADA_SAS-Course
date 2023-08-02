* Nghia Le 15/05/23;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;
	
data voter;
	set "/home/u63345509/sasuser.v94/Data/voter";
run;
proc freq data=voter;
	table Party*(Ques1-Ques4);
run;