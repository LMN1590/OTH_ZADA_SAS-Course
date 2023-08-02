* Yourfirstname yourlastname mm/dd/yy;
* INFO 201 Case study homework 2;

* Edit the data call as necessary;
data productbase;
set 'c:\users\yournetid\desktop\productbase';
data productdemand;
set 'c:\users\yournetid\desktop\productdemand';

* B.1;
* Write a 50-100 word description to describe what this section of code
is doing;
proc sql;
create table samelaunchmonth as select launchdate, productgroup,
   count(productid) as productssamelaunchmonth
   from productbase group by launchdate, productgroup
   order by 1, 2;
quit;
proc print data=samelaunchmonth (obs=10);
data demandmart;
merge productdemand productbase;
   by productid;
launchyear=year(launchdate);
launchmonth=month(launchdate);
launchyearcenter=2015-launchyear;
lifetime=intck('MONTH',launchdate,yearmonth)+1;
targetmonth=month(yearmonth);
targetjan=(targetmonth=1); targetfeb=(targetmonth=2);
targetmar=(targetmonth=3); targetapr=(targetmonth=4);
targetmay=(targetmonth=5); targetjun=(targetmonth=6);
targetjul=(targetmonth=7); targetaug=(targetmonth=8);
targetsep=(targetmonth=9); targetoct=(targetmonth=10);
targetnov=(targetmonth=11); targetdec=(targetmonth=12);
if first.productid then do;
   quantitysum=quantity;
   quantitymean=quantity;
   i=1;
end;
else do;
   quantitysum+quantity;
   i+1;
   quantitymean=round(quantitysum/i);
end;
lastcumquantity=lag(quantitysum);
histquantitylevel=lag(quantitymean);
if first.product_id then do;
   lastcumquantity=.;
   histquantitylevel=.;
end;
proc print data=demandmart (obs=10);
run;

* B.2;
* Write a 50-100 word description to describe what this section of code
is doing;
proc means data=demandmart noprint nway;
   class productgroup lifetime;
   var quantity;
output out=demanddatagroup mean= q1= median= q3= p10= p90= / autoname;
proc transpose data=demandmart out=demandmonthwide prefix=q;
   where lifetime le 12;
   by productid;
   var quantity;
   id lifetime;
data demandmonthwide;
format productid q1-q12 8.;
   set demandmonthwide;
   cq1=sum(q1);
   cq2=sum(q1,q2);
   cq3=sum(q1,q2,q3);
   cq4=sum(q1,q2,q3,q4);
   cq5=sum(q1,q2,q3,q4,q5);
   cq6=sum(q1,q2,q3,q4,q5,q6);
   cq7=sum(q1,q2,q3,q4,q5,q6,q7);
   cq8=sum(q1,q2,q3,q4,q5,q6,q7,q8);
   cq9=sum(q1,q2,q3,q4,q5,q6,q7,q8,q9);
   cq10=sum(q1,q2,q3,q4,q5,q6,q7,q8,q9,q10);
   cq11=sum(q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11);
   cq12=sum(q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12);
proc print data=demandmonthwide (obs=10);

* B.3;
* Write a 50-100 word description to describe what this section of code
is doing;
data newproduct;
do targetmonth=1 to 12;
   productid=342822; productgroup=21; priceindex=50; weight=420; size=15;
   productssamelaunchmonth=10; launchyearcenter=3; launchmonth=11;
   lifetime=targetmonth;
output;
end;
proc print data=newproduct (obs=10);
data scores;
set newproduct;
format calendarmonth yymmp7.;
calendarmonth=intnx('MONTH',mdy(launchmonth,1,2017),lifetime-1);
proc sql;
create table scorescrosstab as select * from scores as a
   left join work.demanddatagroup as b on
   a.productgroup=b.productgroup and a.lifetime=b.lifetime;
quit;
proc print data=scorescrosstab (obs=10);
proc sgplot data=scorescrosstab;
   band lower=quantity_p10 upper=quantity_p90 x=calendarmonth;
   series y=quantity_mean x=calendarmonth;
xaxis label='Month';
yaxis label='Demand';
run;

* B.4;
* Write a 50-100 word description to describe what this section of code
is doing;
data newdata;
productid=1645122; productgroup=21; priceindex=70; weight=200; size=5;
productsubgroup=2150; productssamelaunchmonth=6; launchmonth=4;
output;
data featureweight;
pgweight=1; psgweight=0.5; lmonweight=2; priceweight=1;
sizeweight=1; weightweight=1; productssamelaunchmonthweight=1;
output;
proc sql;
create table similarmaterials as select p.productid, p.productgroup,
   p.productsubgroup, p.launchdate, p.priceindex, p.weight, p.size,
   p.designer, p.theme, (p.productgroup=n.productgroup)*w.pgweight as productgroupscore,
  (p.productsubgroup=n.productsubgroup)*w.psgweight as productsubgroupscore,
  (month(p.launchdate)=n.launchmonth)*w.lmonweight as launchmonthscore,
   round(max(0,1-(abs(p.priceindex-n.priceindex) /
      max(p.priceindex,n.priceindex)))*w.priceweight,0.01) as pricescore,
   round(max(0,1-(abs(p.weight-n.weight) / 
      max(p.weight,n.weight)))*w.weightweight,0.01) as weightscore,
   round(max(0,1-(abs(p.size-n.size) / 
      max(p.size,n.size)))*w.sizeweight,0.01) as sizescore,
   sum(calculated productgroupscore, calculated productsubgroupscore,
      calculated launchmonthscore, calculated pricescore,
      calculated weightscore, calculated sizescore) as similarity
from newdata as n, featureweight as w, productbase as p
order by similarity desc;
quit;
data similarmaterials;
format rank 8.;
   set similarmaterials;
   rank=_N_;
proc print data=similarmaterials (obs=10);
proc sql;
create table plotsimilarmaterials as select s.rank, s.productid,
   s.productgroup, s.launchdate, s.similarity, d.lifetime, d.yearmonth,
   d.quantity from similarmaterials as s, demandmart as d
   where s.productid=d.productid
order by s.rank, d.yearmonth;
quit;
proc print data=plotsimilarmaterials (obs=10);
proc sgplot data=plotsimilarmaterials;
   vbox quantity / category=lifetime connect=median;
   where quantity<5000;
xaxis label='Month';
yaxis label='Demand';
run;

* B.5;
* Write a 150-200 word description of your understanding of the overall
business problem, and how the overall analysis can help the firm solve the
business problem;
