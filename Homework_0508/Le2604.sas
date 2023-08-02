* Nghia Le 08/05/23;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;

data inventory;
	set "/home/u63345509/sasuser.v94/Data/inventory";
data purchase;
	set "/home/u63345509/sasuser.v94/Data/purchase";
run;

proc sql;
	create table test as
		select CustNumber, i.Model, Quantity, Price, Price*Quantity as Cost
		from inventory i, purchase p
		where i.model=p.model;
run;
proc print data=test;
	format Cost dollar10.2;
run; 