* 	ZADA
	Format Data
		Parse
	03/04/2023
	LMN;

data score;
	input record $10.;
	win=input(scan(record,1,'-.'),5.);
	loses=input(scan(record,2,'-'),5.);
	draw=input(scan(record,-1),5.);
	datalines;
10-2-1
2-3-1
5-9-7
	;
run;

proc print data=score;
run;