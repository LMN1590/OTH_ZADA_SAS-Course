* 	ZADA
	SQL
		Case Study 4
	19/06/2023
	LMN;
data employees;
	set '/home/u63345509/sasuser.v94/Data/employees';
	%let firstdate='01JAN2004'd;
	%let graphdate='01JAN2009'd;
	%let lastdate='31DEC2016'd;

*A. Employee duration;
proc means data=employees mean;
	var duration;
proc lifetest data=employees;
	time duration*status(1);
	ods select survivalplot;
proc sort data=employees out=employeessort;
	by empno;
proc transpose data=employeessort(keep=empno department start end) out=employeestp(rename=(col1=date));
	by empno;
data employeestp;
	set employeestp;
	by empno;
	if first.empno then start=date;
	if date=. then date=&lastdate;
	_ID_=ceil(_n_/2);
proc sgplot data=employeestp;
	series x=date y=_ID_/group=empno lineattrs=(pattern=solid color=black);
run;

* B. Employee hires and departures;
data _null_;
	monthcount=intck('month',&firstdate,&lastdate);
	call symput('MonthCount',monthcount);
data allmonths;
	do i=1 to &monthcount;
		month=intnx('month',&firstdate,i-1);
		drop i;
		output;
	end;
proc sql;
	create table empcount as
		select month, count(distinct empno) as empcount
		from allmonths as a left join employees as b
		on intnx('month',b.end,0) > a.month and b.start<=a.month
		group by month;
	create table departure as
		select intnx('month',end,0,'BEGIN') as end, count (distinct empno) as departures
		from employees 
		where end ne .
		group by end;
	create table arrival as
		select start,count(distinct empno) as arrivals
		from employees
		where end ne .
		group by end;
	create table allcounts as
		select a.month, a.empcount, 
			case when b.arrivals=. then 0 else b.arrivals end as arrivals,
			case when c.departures=. then 0 else c.departures end as departures
		from (empcount as a left join arrival as b on a.month=b.start)
			left join departure as c on a.month=c.end;
quit;
data allcounts;
	set allcounts;
	retain numbertemp;
	numbertemp2=sum(numbertemp,arrivals,-lag(departures));
	numbertemp=numbertemp2;
	employees=numbertemp2-arrivals-departures;
	drop numbertemp numbertemp2 empcount;
run;

proc transpose data=allcounts out=allcountstp(rename=(_name_=type col1=number));
	by month;
proc sgplot data=allcountstp;
	vbar month/group=type response=number;
	xaxis fitpolicy=thin;
	where month>&graphdate;
	format month yymmp7.;
run;
			
*C Employee duration by department and knowledge;
proc means data=employees mean;
	class department;
	var duration;
proc lifetest data=employees;
	time duration*status(1);
	strata department;
	ods select survivalplot;
proc means data=employees mean;
	class techknowhow;
	var duration;
proc lifetest data=employees;
	time duration*status(1);
	strata techknowhow;
	ods select survivalplot;

*D Total knowledge increases even with departure;
proc sql;
	create table knowledgetotal as	
		select month, empno, round(sum(intck('month',b.start,a.month)),1) as knowledgemonths
		from allmonths as a left join employees(where=(techknowhow='YES')) as b
		on intnx('month',sum(b.end,(b.end=.)*&lastdate),0) > a.month and b.start<=a.month
		group by month, empno;
quit;
proc sgplot data=knowledgetotal;
	vbar month/group=empno response=knowledgemonths;
	xaxis fitpolicy=thin;
	where month>&graphdate;
	format month yymmp7.;
run









