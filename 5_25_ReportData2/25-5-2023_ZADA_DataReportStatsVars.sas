* 	ZADA
	SQL
		PROC Report Multiple Stats and New Vars
	25/05/2023
	LMN;

data carsthree;
	set "/home/u63345509/sasuser.v94/Data/automobiles";
	
proc report data=carsthree;
	col make n (msrp, (mean std)) (invoice, (mean std)) dealerprofit;
		define make/group;
		define msrp/format=dollar10. "Manufacturer suggested retail price";
		define invoice/format=dollar10. "Dealer Invoice Price";
		define dealerprofit/format=percent10.1 "Dealer profit margin";
	compute dealerprofit;
		dealerprofit = (_c3_/_c5_) - 1;
	endcomp;
	title "Multiple Stats and New Vars";
