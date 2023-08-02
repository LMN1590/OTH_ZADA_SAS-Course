* Nghia Le 27/03/23;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;
	
data square;
	num=1;
	do num=1 to 100 until(num**2>=100);
		square=num**2;
		output;
	end;
run;

proc print data=square;
	title 'Intergers and Squares';
run;