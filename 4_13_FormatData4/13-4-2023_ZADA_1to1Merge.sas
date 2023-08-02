* 	ZADA
	Concat and Merge Data
		1-to-1 merge with computation
	13/04/2023
	LMN;

data unitprice;
	infile '/home/u63345509/sasuser.v94/Data/unitprice.dat';
	input 	ID			$	1-2
			Name		$	4-26
			Price			28-32
	;
proc sort data=unitprice;
	by ID;
run;

data unitcost;
	infile '/home/u63345509/sasuser.v94/Data/unitcost.dat';
	input	ID			$	1-2
			Cost			4-8
	;
proc sort data=unitcost;
	by ID;
run;

data together;
	merge unitprice unitcost;
	by ID;
	Profit=Price-Cost;
	Margin=Profit/Price;
run;

proc print data=together;
	format Profit Price Cost dollar6.2 Margin percent10.;
run;