* Nghia Le 15/05/23;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;
	
data sales;
	set "/home/u63345509/sasuser.v94/Data/sales"(drop=date);
	Date=mdy(month,day,year);
	format Date date.;
run;

proc sgplot data=sales;
	title 'Series Plot of Sales by Date';
	yaxis label="SALES";
	series x=date y=sales;
run;