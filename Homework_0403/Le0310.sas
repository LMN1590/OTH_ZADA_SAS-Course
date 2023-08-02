* Nghia Le 03/04/23;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;
	
filename input '/home/u63345509/sasuser.v94/Data/stockprices.txt';

data stock;
	infile input;
	input	@1	Stock 		$4.
			@5	PurDate		mmddyy10.
			@15	PurPrice	dollar6.
			@21	Number		4.
			@25	SellDate	mmddyy10.
			@35 SellPrice	dollar6.;
	TotalPur=Number*PurPrice;
	TotalSell=Number*SellPrice;
	Profit=TotalSell-TotalPur;
run;

proc print data=stock;
	format 	PurDate SellDate ddmmyy10. 
			Profit PurPrice SellPrice dollar6.
			TotalPur TotalSell dollar6.;
run;