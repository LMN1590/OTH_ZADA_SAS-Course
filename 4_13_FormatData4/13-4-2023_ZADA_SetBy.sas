* 	ZADA
	Concat and Merge Data
		Merge with SET and BY
	13/04/2023
	LMN;

data mensgolf;
	infile '/home/u63345509/sasuser.v94/Data/mensgolf.dat';
	input 	ID				$ 1-2
			Name			$ 4-32
			SellPrice		34-39
			ManPrice		40-46
	;
run;

data womensgolf;
	infile '/home/u63345509/sasuser.v94/Data/womensgolf.dat';
	input 	ID				$ 1-2
			Name			$ 4-32
			SellPrice		34-39
			ManPrice		40-46
	;
run;

data weave;
	set mensgolf womensgolf;
	by ID;
run;
proc print data=weave;
run;

data stack;
	set mensgolf womensgolf;
	by Name;
run;
proc print data=stack;
run;
