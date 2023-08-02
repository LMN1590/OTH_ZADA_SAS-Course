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
	output out=reviewloc n=n_reviewer mean=meanrate;
proc print data=reviewloc;
run;

data worldmap;
	set mapsgfk.world;
	reviewer_location=idname;
proc print data=worldmap(obs=10);

data reviewloc;
	set reviewloc;
	format meanrate 10.3;
proc gmap data=reviewloc map=worldmap all;
	id reviewer_location;
	choro meanrate/levels=4;
run;