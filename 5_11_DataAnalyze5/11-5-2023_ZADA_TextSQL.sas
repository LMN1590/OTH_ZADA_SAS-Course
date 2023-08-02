* 	ZADA
	SQL
		Text Analysis
	11/05/2023
	LMN;
	
proc import datafile="/home/u63345509/sasuser.v94/Data/cl.csv" 
	dbms=csv out=cl replace;
	getnames=yes;

data numberw;
	set cl;
	lowertext=lowcase(text);
	formattext=compress(lowertext,"'.,;?!/\()");
	clnumberword=countw(formattext);

proc sql;
	create table clcompare as
	select formattext,
		count(formattext, 'brands') as countbrands,
		count(formattext, 'consumer') as countconsumer,
		count(formattext, 'products') as countproducts,
		count(formattext, 'cash flows') as countcashflows,
		count(formattext, 'financial condition') as countcondi
	from numberw;
quit;
proc print data=clcompare;