* 	ZADA
	SQL
		Case Study 1
	05/06/2023
	LMN;
	
proc import file="/home/u63345509/sasuser.v94/Data/airlineroutesgermany.xlsx" dbms=xlsx out=airroutes replace;
	getnames=yes;

proc import file="/home/u63345509/sasuser.v94/Data/airlinenames.xlsx" dbms=xlsx out=names replace;
	getnames=yes;
proc sql;
	create table routes as
	select r.*, n.airlinename
	from airroutes r, names n
	where r.airlinecode=n.airlinecode
	order by destinationairportcode, airlinecode;
quit;

proc freq data=routes order=freq;
	tables airlinename destinationcountryname/maxlevels=7;
run;

proc tabulate data=routes;
	class airlinename destinationcountryname;
	table airlinename, destinationcountryname;
	where airlinename in ('Air Berlin', 'Condor Flugdienst', 'easyJet UK', 'Germanwings', 'Lufthansa', 'TUIfly', 'Ryanair')
		and destinationcountryname in ('Germany', 'Spain', 'Italy', 'Greece', 'Turkey', 'United States', 'United Kingdom');

proc tabulate data=routes;
	class destinationcountryname destinationcity airlinename;
	table destinationcountryname, destinationcity, airlinename;
	where airlinename in ('Air Berlin', 'Condor Flugdienst', 'easyJet UK', 'Germanwings', 'Lufthansa', 'TUIfly', 'Ryanair')
		and destinationcountryname in ('Germany', 'Spain', 'Italy', 'Greece', 'Turkey', 'United States', 'United Kingdom');









