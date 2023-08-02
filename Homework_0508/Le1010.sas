* Nghia Le 08/05/23;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;
	
data inventory;
	set "/home/u63345509/sasuser.v94/Data/inventory";
proc sort data=inventory;
	by model;
run;

data purchase;
	set "/home/u63345509/sasuser.v94/Data/purchase";
proc sort data=purchase;
	by model;
run;

data notpurchase;
	merge	inventory
			purchase(in=in_purchase);
	by model;
	if(not in_purchase) then output;
	keep model price;
run;

proc print data=notpurchase;
	title "Models that were not purchased";
run;