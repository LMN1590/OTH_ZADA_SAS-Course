* 	ZADA
	Data Analysis 2
		PROC RANK 2 variables
	27/04/2023
	LMN;
	
data passengerscargo;
	set "/home/u63345509/sasuser.v94/Data/passengerscargo";
run;

proc rank data=passengerscargo descending out=cargorank;
	var cargo passengers;
	ranks cargoRank passengersRank;

proc print data=cargorank;
run;