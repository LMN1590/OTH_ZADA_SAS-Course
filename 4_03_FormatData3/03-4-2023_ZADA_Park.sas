* 	ZADA
	Format Data
		National Park
	03/04/2023
	LMN;

data nationalpark;
	set '/home/u63345509/sasuser.v94/Data/nationalpark';
	where parkname like "%NP";
	park=substr(parkname,1,find(parkname,'NP')-2);
	location=compbl(propcase(location));
	gatecode=catx('-',parkcode,location);
run;

proc print data=nationalpark;
	var park gatecode year month count;
run;