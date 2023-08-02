* 	ZADA
	SQL
		Case Study 3
	15/06/2023
	LMN;

data manfc;
	set '/home/u63345509/sasuser.v94/Data/manfc';
	
data statfc;
	set '/home/u63345509/sasuser.v94/Data/statfc';

data products;
	set '/home/u63345509/sasuser.v94/Data/products';
	
*A: Merge stats data and forecast data;
proc sort data=manfc out=manfcsort;
	by id targetmonth createmonth;
proc sort data=statfc out=statfcsort;
	by id targetmonth createmonth;
	
data fc;
	merge statfc(in=instat) manfcsort(in=inman rename=(actual=actualman));
		by id targetmonth createmonth;
	if instat and inman then do;
		if actual = actualman then output fc;
		drop actualman;
	end;
proc print data=fc(obs=10);
run;	

*B: Create master dataset;
proc sql;
	create table fcmart as
	select a.*, b.productgroup, b.priceindex, b.launchdate
	from fc as a right join products as b
	on a.id=b.id where a.actual>0 and a.actual not in (.)
	order by id, targetmonth, createmonth;
quit;

data fcmart;
	set fcmart;
	fcid = N;
	if priceindex in (0,999) then priceindex=.;
	launchmonth = month(launchdate);
	launchyear = year(launchdate);
	createcalmonth = month(createmonth);
	createyear = year(createmonth);
	targetcalmonth = month(targetmonth);
	targetyear = year(targetmonth);
	
	leadtime = intck('Month',createmonth,targetmonth);
	productage = intck('Month',launchdate,targetmonth);
	
	if productage>120 then productage=120;
	
	apeman = abs((manfc-actual)/actual)*100;
	apemanlimit = min(apeman,300);
	
	apestat = abs((statfc-actual)/actual)*100;
	apestatlimit = min(apestat,300);

proc print data=fcmart(obs=10);
	format apeman apemanlimit apestat apestatlimit 8.1;
run;

*C Main reason that our current forecasts are not accurate;
proc means data=fcmart n min q1 median mean p70 q3 max maxdec=1;
	var apestatlimit;
proc sgplot data=fcmart;
	histogram apestatlimit;
	refline 46.8 / axis=x label='Median';
	refline 80.7 / axis=x label ='Mean';
run;

proc surveyselect data=fcmart out=fcmartsample method=srs sampsize=10000 seed=19416;
proc quantselect data=fcmartsample;
	class productgroup model launchmonth launchyear createcalmonth createyear targetcalmonth targetyear;
	model apestatlimit = productgroup model priceindex productage launchmonth launchyear createcalmonth
		createyear targetcalmonth targetyear leadtime / quantile=0.7 selection=stepwise;

*D. Another area to improve out forecasts;
proc surveyselect data=fcmart out=fcmartsample method=srs sampsize=10000 seed=19416;
proc quantselect data=fcmartsample;
	class productgroup model launchmonth launchyear createcalmonth createyear targetcalmonth targetyear;
	model apestatlimit = productgroup model priceindex productage launchmonth launchyear createcalmonth
		createyear targetcalmonth targetyear leadtime / quantile=0.5 selection=stepwise;

proc sgpanel data=fcmart;
	panelby model;
	vbox apestatlimit / category = targetyear nooutliers;
run;