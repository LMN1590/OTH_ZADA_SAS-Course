* 	ZADA
	SQL
		Reporting on Data
	22/05/2023
	LMN;

data goods;
	set "/home/u63345509/sasuser.v94/Data/outdoorgoodsinclass";
run;

proc tabulate data=goods;
	class productline producttype quarter;
	table productline, producttype,quarter;
	title "Each product type by product line";
proc tabulate data=goods;
	class retailercountry retailertype quarter;
	table retailercountry, retailertype, quarter;
	title "Each reailer country by retailer type";
**************************************************;	
proc tabulate data=goods;
	class productline producttype quarter;
	var revenue;
	table productline, producttype,quarter*revenue;
	title "Add revenue";
proc tabulate data=goods;
	class productline producttype quarter;
	var revenue;
	table productline, producttype,quarter*revenue*format=dollar14.;
	title "Format revenue2";

**************************************************;
proc tabulate data=goods;
	class retailercountry retailertype quarter;
	var revenue cost;
	table (retailercountry)*(retailertype all), (quarter all)*(revenue cost)*format=dollar14.;
	title "Nest country";
	
proc tabulate data=goods;
	class ordermethod quarter;
	var revenue;
	table ordermethod all, (quarter all)*(revenue*format=dollar14. reppctn);
	title "Order method percentage";
run;
