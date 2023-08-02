* 	ZADA
	Format Data
		Histogram based on Dates
	30/03/2023
	LMN;
	
data guest;
	set '/home/u63345509/sasuser.v94/Data/hotelguestseu';
	qtr=intck('qtr','30Jun2018'd,checkin);
run;

proc sgplot data=guest;
	vbar qtr;
	title 'Guests Per Quarter';
run;
	