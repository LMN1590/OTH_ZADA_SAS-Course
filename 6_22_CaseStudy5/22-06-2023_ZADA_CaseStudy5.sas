* 	ZADA
	SQL
		Case Study 5
	22/06/2023
	LMN;

proc import datafile='/home/u63345509/sasuser.v94/Data/BTC.xlsx' dbms=xlsx out=btc replace;
	getnames=yes;
proc import datafile='/home/u63345509/sasuser.v94/Data/NASDAQ.xlsx' dbms=xlsx out=nasdaq replace;
	getnames=yes;
proc import datafile='/home/u63345509/sasuser.v94/Data/SPX.xlsx' dbms=xlsx out=spx replace;
	getnames=yes;

*A. Merge into one dataset and add variables;
data bns;
	set btc nasdaq spx;
	by ticker;
data bns;
	set bns;
	prevclose=lag(close);
	pctchange = (close-open)/open;
	year=year(date);
	week=week(date);
	biweekly=round(week/2);
	if(prevclose-close)>0 then upclose=(prevclose-close);
	else if(prevclose-close) <0 then downclose = (prevclose-close);
proc print data=bns(obs=10);
	title 'Combined dataset';
	format pctchange percent8.2;
run;

*B. Plot daily volume and price;
proc sgplot data=bns;
	series x=date y=volume/group=ticker;
	title 'Daily Volume';
proc sgplot data=bns;
	series x=date y=close/group=ticker;
	title 'Daily Close';
run;

*C. Create summary statistics;
proc sql;
	create table bnsstats as 
	select ticker, 
		mean(open) as averageopen format=dollar20.4,
		median(open) as medianopen format=dollar20.4,
		mean(close) as averageclose format=dollar20.4,
		median(close) as medianclose format=dollar20.4,
		mean(volume) as averagevolume format=comma20.,
		median(volume) as medianvolume format=comma20.,
		std(close) as stdclose format=dollar20.4,
		std(pctchange) as stdpctchange format=percent8.2
	from bns
	group by ticker;
quit;
proc print data=bnsstats;
	title 'Summary statistics';

*D. Average daily return for each year;
proc sql;
	create table dailyreturn as
	select ticker, year, mean(pctchange) as pctchange format=percent8.2
	from bns
	group by ticker, year
	order by year desc, pctchange desc;
quit;
data dailyreturn;
	set dailyreturn;
	if pctchange=. then delete;
proc sgpanel data=dailyreturn;
	panelby ticker / noheader columns=3;
	scatter x=year y=pctchange/group=ticker;
	title 'Average daily return for each year';
run;

*E. Relative strength index;
proc sql;
	create table rsi as
	select ticker, mean(upclose) as meanupclose, mean(downclose) as meandownclose, biweekly
	from bns
	group by ticker, biweekly
	order by ticker, biweekly;
quit;
data rsi;
	set rsi;
	meandownclose=abs(meandownclose);
	rsi = 100-(100/(1+(meanupclose/meandownclose)));
	if rsi=. then delete;
	biweekly+1;
proc sgplot data=rsi;
	series x=biweekly y=rsi/group=ticker;
	refline 30 40 60 70/axis=y lineattrs=(pattern=2 thickness=2px);
	title '14-day average RSI comparison';
proc format;
	value rsivalue
		low-30='Oversold'
		30-40 = 'Increased Selling'
		40-60 = 'Normal Momentum'
		60-70 = 'Increased Buying'
		70-high = 'Overbought';
proc sgplot data=rsi;
	vbar rsi/group=ticker groupdisplay=cluster;
	format rsi rsivalue.;
	yaxis grid;
	title 'Categories for 14-day average RSI';
run;

*F. Price forecast (autoregressive intergrated moving average);
proc sort data=bns;
	by date;
	where ticker='BTC';
proc arima data=btc;
	identify var=close(1);
	estimate p=1;
	forecast id=date interval=day lead=540;
	title 'Bitcoin price forecast';
run;



