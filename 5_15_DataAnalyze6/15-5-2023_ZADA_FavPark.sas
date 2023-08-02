* 	ZADA
	SQL
		Basic Map Data
	15/05/2023
	LMN;

data disney;
	set "/home/u63345509/sasuser.v94/Data/disneylandreviews";
proc means data=disney mean maxdec=3 noprint;
	var rating;
	class reviewer_location;
	output out=disney2 n=nreviewer mean=meanrate;

data cali;
	set disney;
	if branch='Disneyland_California';
proc means data=cali mean maxdec=3 noprint;
	var rating;
	class reviewer_location;
	output out=calmean n=nreviewer mean=meanrate;

data hongkong;
	set disney;
	if branch='Disneyland_HongKong';
proc means data=hongkong mean maxdec=3 noprint;
	var rating;
	class reviewer_location;
	output out=hkmean n=nreviewer mean=meanrate;;

data paris;
	set disney;
	if branch='Disneyland_Paris';
proc means data=paris mean maxdec=3 noprint;
	var rating;
	class reviewer_location;
	output out=pamean n=nreviewer mean=meanrate;

proc sql;
	create table fav as
	select a.reviewer_location, 
		c.meanrate as calrate,
		hk.meanrate as hkrate,
		p.meanrate as parrate
	from calmean c, hkmean hk, pamean p, disney2 a
	where 	a.reviewer_location=c.reviewer_location and 
			a.reviewer_location=hk.reviewer_location and
			a.reviewer_location=p.reviewer_location;
			

	create table fav2 as
	select a.reviewer_location, 
		c.meanrate as calrate,
		hk.meanrate as hkrate,
		p.meanrate as parrate
	from disney2 a 	full join calmean c on a.reviewer_location=c.reviewer_location
					full join hkmean hk on a.reviewer_location=hk.reviewer_location
					full join pamean p on a.reviewer_location=p.reviewer_location;
quit;

data favpark;
	set fav2;
	if calrate>=hkrate and calrate>=parrate then favpark='California';
	else if hkrate>=calrate and hkrate>=parrate then favpark='Hong Kong';
	else if parrate>=hkrate and parrate>=calrate then favpark='Paris';
proc print data=favpark(obs=20);
run;

data worldmap;
	set mapsgfk.world;
	reviewer_location=idname;
	
proc gmap data=favpark map=worldmap all;
	id reviewer_location;
	choro favpark/levels=3;
run;












