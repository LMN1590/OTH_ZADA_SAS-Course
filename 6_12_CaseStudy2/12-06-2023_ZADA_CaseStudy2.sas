* 	ZADA
	SQL
		Case Study 2
	12/06/2023
	LMN;
* Plotting;
data transaction;
	set "/home/u63345509/sasuser.v94/Data/transactions";
	
proc sgplot data = transaction;
	histogram amountusd;
	where amountusd< 100000;
	yaxis label='Number of transactions';
	xaxis label = 'Transaction amount';
*Expected Benford;
data benfordexpected;
	format firstdigit 8. expfreq 8.3;
	do firstdigit=1 to 9;
		expfreq = (log10(1+(1/firstdigit))*100);
		output;
	end;

proc sgplot data=benfordexpected;
	vbar firstdigit/response=expfreq datalabel;
	yaxis label='Expected distribution';
	xaxis label ='Prob';
*Acutall Benford Distribution;
data benfordactual;
	set transaction;
	firstdigit = input(substr(compress(put(amountusd,16.2),' 0.'),1,1),8.);
	count=1;

proc freq data= benfordactual;
	tables firstdigit/chisq(testp=benfordexpected(rename=(expfreq=_testp_))) nocum out=actualoutput;
	ods select onewayfreqs;
	
* Plotting Benford plot;
data benfordplot;
	format firstdigit 3. expfreq obsfreq 8.3;
	merge benfordexpected actualoutput (rename=(percent=obsfreq));
	by firstdigit;
	label obsfreq='Actual Distribution' expfreq='Expected Distribution';

proc sgplot data=benfordplot;
	vline firstdigit/response=obsfreq lineattrs=(pattern=2);
	vline firstdigit/response=expfreq lineattrs=(pattern=3);
	yaxis label='Frequency in percent';
	xaxis label='First digit';
	
*Additional Analysis with customers;
data benfordcustomer;
	set transaction;
	firstdigit = input(substr(compress(put(amountusd,16.2),' 0.'),1,1),8.);
	count=1;

proc freq data= benfordcustomer;
	tables firstdigit/chisq(testp=benfordexpected(rename=(expfreq=_testp_))) 
		nocum out=customeroutput(rename=(percent=obsfreq));
	weight count;
	by customerid;
	ods output onewaychisq=chi2;
	ods select onewaychisq;
	
* Rank Chi2 by customer;
proc transpose data=chi2 out=chi2results(drop=_name_ df_pchi);
	by customerid;
	var nvalue1;
	id name1;
proc sort data=chi2results;
	by descending _pchi_;
data chi2results;
	set chi2results;
	rank=_N_;
	rename _pchi_=chi2_value p_pchi=p_value;
	format rank 3. p_pchi percent8.3 _pchi_ 8.1;
proc sgplot data=chi2results;
	series x=rank y=p_value;
	yaxis label='Chi2 p value';
	xaxis label='Ranking';
run;

* Detailed Investigation;
proc sql;
	create table benfordcrosstab as
	select a.customerid, a.firstdigit, a.obsfreq format=8.3, b.expfreq,
		a.obsfreq-b.expfreq as delta format=8.3, c.rank, c.chi2_value, c.p_value
	from customeroutput as a, benfordexpected as b, chi2results as c
	where a.customerid=c.customerid and a.firstdigit=b.firstdigit
	order by a.customerid, a.firstdigit;
quit;

proc sgplot data=benfordcrosstab;
	vline firstdigit/response=obsfreq lineattrs=(pattern=2);
	vline firstdigit/response=expfreq lineattrs=(pattern=3);
	yaxis label='Frequency in percent';
	xaxis label='First digit';
	where customerid=10000;