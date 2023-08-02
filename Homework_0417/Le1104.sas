* Nghia Le 17/04/23;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;
	
data evaluate;
	set '/home/u63345509/sasuser.v94/Data/psych';
	if (n(of Ques1-Ques10) >= 7) then QuesAve=mean(of Ques1-Ques10);
	if (nmiss(of Score1-Score5) = 0) then do;
		MinScore=min(of Score1-Score5);
		MaxScore=max(of Score1-Score5);
		SecondHighest=largest(2,of Score1-Score5);
	end;
run;

proc print data=evaluate;
run;