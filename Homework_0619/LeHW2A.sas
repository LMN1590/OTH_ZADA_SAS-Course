* Nghia Le 19/06/23;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;
	
data bank;
	set "/home/u63345509/sasuser.v94/Data/bank";
	
*C1 Plotting data by transaction amount;
proc sgplot data=bank;
	title 'Visual representation of amount (-800<amount<500)';
	histogram amount;
	where amount<500 and amount>=-800;
	yaxis label='Number of transactions';
	xaxis label='Amount';

*C2 Computing and plotting expected Benford distribution;
data expectedBenford;
	do first=1 to 9;
		expectedFreq = log10(1+1/(first))*100;
		output;
	end;
run;
proc sgplot data=expectedBenford;
	title 'Expected Benford Distribution';
	vbar first/response=expectedFreq datalabel;
	yaxis label = 'Percent Distribution';
	xaxis label = 'Digit';
run;

*C3 Compute actual distribution by first digit;
data bank;
	set bank;
	first = input(substr(compress(amount_abs, ' 0.'),1,1),8.);
proc freq data=bank;
	title 'Chi Square Analysis of Frequency from 2011-2015';
	table first/chisq(testp=expectedBenford(rename=(expectedFreq=_testp_))) out=actualBenford(rename=(percent=realFreq));
proc sgplot data=actualBenford;
	title 'Actual Distribution by First Digit';
	vbar first/response=realFreq datalabel;
	yaxis label = 'Percent Distribution';
	xaxis label = 'Digit';

*C4 Join and plot actual vs expected Benford distribution;
data diff;
	merge actualBenford expectedBenford;
	by first;
	drop count;
	label expectedFreq='Expected Frequency' realFreq='Real Frequency';
proc sgplot data=diff;
	vline first/response=expectedFreq lineattrs=(pattern=2);
	vline first/response=realFreq lineattrs=(pattern=1);
	yaxis label = 'Percent Distribution';
	xaxis label = 'Digit';

*C5 Additional Analysis by year;
proc freq data=bank;
	title 'Analysis by Year';
	table first/chisq(testp=expectedBenford(rename=(expectedFreq=_testp_)));
	by year;
	ods select onewaychisq onewayfreqs;
	ods output onewayfreqs=dataByYearTemp onewaychisq=chi2;
proc sgpanel data=dataByYearTemp;
	title 'Plots of Benford Distribution comparision by year';
	panelby year;
	vline first/response=percent lineattrs=(pattern=1);
	vline first/response=testpercent lineattrs=(pattern=2);

*C6 Rank Chi2 by Year;
proc transpose data=chi2 out=chi2res(drop=_name_ df_pchi);
	by year;
	var nvalue1;
	id name1;
proc sort data=chi2res;
	by descending _pchi_;
data chi2res;
	set chi2res;
	rank=_N_;
	rename _pchi_=chi2_value p_pchi=p_value;
	format rank 3. p_pchi percent8.5 _pchi_ 8.1;
proc print data=chi2res;
	title 'Chi Square value by year';
proc sgplot data=chi2res;
	title 'Ranking of Chi Square value';
	vline rank/response=p_value lineattrs=(pattern=1);

*C7 Detailed investigation for one year. 
The year that I chose for this section will be the one with the lowest p_value, which is 2012.;
data bank2012;
	set bank;
	where year=2012;
proc means data=bank2012;
	title 'Analysis of the transaction amounts in 2012';
	var amount;
proc sgplot data=dataByYearTemp;
	title 'Benford Distribution comparision in year 2012';
	vline first/response=percent lineattrs=(pattern=1);
	vline first/response=testpercent lineattrs=(pattern=2);
	where year=2012;

*C8 Identify problematic transactions
Comment:
	- From the analysis performed below, it can be seen that during the year 2012, 
		the month of February, March, and July have 
		either abnormally high or low mean of transaction amounts.
	- The month of August have very low number of transactions.
	- The month of April have both the highest and lowest transaction amount of the year 2012,
		which occurs in the date of 10/04 and 11/04 respectively.
;	
proc means data=bank2012 noprint min max mean sum;
	title 'Analysis of transaction amounts by month in 2012';
	by month;
	var amount;
	output out=stat2012 n= min= max= mean= sum= /autoname;
proc sgplot data=stat2012;
	title 'Number of transactions amount in 2012 by month';
	vline month/response=amount_n lineattrs=(pattern=1);
proc sgplot data=stat2012;
	title 'Sum of transactions amount in 2012 by month';
	vline month/response=amount_sum lineattrs=(pattern=1);
proc sgplot data=stat2012;
	title 'Mean transactions amount in 2012 by month';
	vline month/response=amount_mean lineattrs=(pattern=1);
proc sgplot data=stat2012;
	title 'Max transactions amount in 2012 by month';
	vline month/response=amount_max lineattrs=(pattern=1);
proc sgplot data=stat2012;
	title 'Min transactions amount in 2012 by month';
	vline month/response=amount_min lineattrs=(pattern=1);

data bank042012;
	set bank2012;
	where month=4;
proc sgplot data=bank042012;
	title 'Visual representation of transactions amount by date in April 2012';
	vline valuta/response=amount;
	yaxis label='Number of transactions';
	xaxis label='Amount';










