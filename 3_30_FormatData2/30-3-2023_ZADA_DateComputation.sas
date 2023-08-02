* 	ZADA
	Format Data
		Date Computation
	30/03/2023
	LMN;

data invoice;
	set '/home/u63345509/sasuser.v94/Data/hotelcharges';
	days=checkout-checkin;
	roomcharge=days*roomrate;
	roomtax=roomcharge*0.096;
	resortfee=days*20;
	invoice=roomcharge+roomtax+resortfee+meals;
run;

proc print data=invoice;
	format meals roomcharge roomtax resortfee invoice dollar9.2;
run;