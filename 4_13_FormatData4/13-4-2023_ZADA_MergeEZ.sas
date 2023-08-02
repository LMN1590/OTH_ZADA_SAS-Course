* 	ZADA
	Concat and Merge Data
		Merge with MERGE
	13/04/2023
	LMN;
	
data backpacks;
	infile '/home/u63345509/sasuser.v94/Data/backpacks.dat';
	input 	ID			$	1-2
			Name		$	4-33
			UnitPrice		35-40
			UnitCost		42-47
	;
run;
proc print data=backpacks;
	format UnitPrice UnitCost dollar8.;
run;
	
	
data packsales;
	infile '/home/u63345509/sasuser.v94/Data/packsales.dat';
	input 	ID			$	1-2
			Sales			4-8
	;
run;

proc print data=packsales;
	format Sales comma8.;
run;

data details;
	merge backpacks packsales;
	by ID;
	TotalProfit=Sales*(UnitPrice-UnitCost);
	output;
run;
proc print data=details;
	format UnitPrice UnitCost TotalProfit dollar12. Sales comma8.;
run;