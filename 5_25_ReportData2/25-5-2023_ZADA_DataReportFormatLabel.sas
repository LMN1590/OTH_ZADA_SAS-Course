* 	ZADA
	SQL
		PROC Report Format and Labels
	25/05/2023
	LMN;
	
data carstwo;
	set "/home/u63345509/sasuser.v94/Data/automobiles";

proc report data=carstwo;
	col make n (enginesize, mean) (cylinders, mean) (horsepower, mean);
		define make/group;
		define enginesize/format=4.1 "Number of liters";
		define cylinders/format=4.1 "Number of cylinders";
		define horsepower/format=5. "Number of horsepower";