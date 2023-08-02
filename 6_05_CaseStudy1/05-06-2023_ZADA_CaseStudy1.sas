* 	ZADA
	SQL
		Case Study 1
	05/06/2023
	LMN;


data passenger;
	set "/home/u63345509/sasuser.v94/Data/travelrecovery";
run;
proc sgplot data=passenger;
	series x=date y=passengers;
	format passengers comma8.;
run;

*Smooth Data;
data passengersmooth;
	set passenger;
	passengersmooth = mean(passengers, lag(passengers), lag2(passengers), lag3(passengers), lag4(passengers), lag5(passengers), 
							lag6(passengers), lag7(passengers), lag8(passengers), lag9(passengers), lag10(passengers), lag11(passengers));
proc sgplot data=passengersmooth;
	series x=date y=passengers;
	series x=date y=passengersmooth;
	format passengersmooth comma8.;
run;

proc adaptivereg data=passengersmooth plots=all;
	model passengersmooth = date/maxbasis=11;
	output out=flights predicted=passengerprediction;
	
proc sgplot data=flights;
	series x=date y=passengers;
	series x=date y=passengersmooth;
	series x=date y=passengerprediction;
	format passengersmooth comma8.;
	refline '01AUG90'd/axis=x;
	refline '01NOV91'd/axis=x;
	refline '01APR01'd/axis=x;
	refline '01AUG02'd/axis=x;
	refline '15DEC02'd/axis=x;
run;

