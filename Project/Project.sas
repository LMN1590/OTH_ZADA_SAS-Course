* Nghia Le;

* Link:
* 	"IMDb Movie Dataset: All Movies by Genre": https://www.kaggle.com/datasets/rajugc/imdb-movies-dataset-based-on-genre
* 	"Movie Industry": https://www.kaggle.com/datasets/danielgrijalvas/movies	

* Word Count:
* 	Without Comments: 1830;

* Input Data;
%let genre1=action;
%let genre2=adventure;
%let genre3=animation;
%let genre4=biography;
%let genre5=crime;
%let genre6=family;
%let genre7=fantasy;
%let genre8=filmnoir;
%let genre9=history;
%let genre10=horror;
%let genre11=mystery;
%let genre12=romance;
%let genre13=scifi;
%let genre14=sports;
%let genre15=thriller;
%let genre16=war;

%let exception = filmnoir;

%let N=16;

%macro createGenre(genre);
	filename copy temp;
	
	%if "&genre" = "&exception" %then %do;
		%let data = film-noir;
	%end;
	%else %do;
		%let data= &genre;
	%end;

* Citation:
* Google Search Query: multiline csv import sas
* Link: https://communities.sas.com/t5/SAS-Programming/import-multiple-line-value-of-csv-file/m-p/272790;
* From: Ballardw;
	data _null_;
	  infile "/home/u63345509/sasuser.v94/Data/&data..csv" recfm=n;
	  file copy recfm=n;
	  input ch $char1.;
	  retain q 0;
	  q = mod(q+(ch='"'),2);
	  if q and ch in ('0D'x,'0A'x) then put '|';
	  else put ch $char1. ;
	run;
* End;
	data &genre;
	  infile copy dsd truncover firstobs=2;
	  length x1-x14 $250.;
	  input x1-x14 ;
	run;
%mend createGenre;

%macro createData(N);
	%do i=1 %to &N;
		%createGenre(&&genre&i);
	%end;
%mend createData;

%createData(&N);

%macro createAllGenre();
	proc sql;
	create table raw as
	select * from &genre1
	%do i=2 %to &N - 1;
		UNION select * from &&genre&i
	%end;
	UNION select * from &genre16;
quit;
%mend createAllGenre;

%createAllGenre();

proc format;
	value yearFormat
		low-<1985='Before 85'
		1985-<1990='1985 to 1990'
		1990-<1995='1990 to 1995'
		1995-<2000='1995 to 2000'
		2000-<2005='2000 to 2005'
		2005-<2010='2005 to 2010'
		2010-<2015='2010 to 2015'
		2015-<2020='2015 to 2020'
		other = 'Others';
	
proc import datafile='/home/u63345509/sasuser.v94/Data/movies.csv' dbms=csv out=movie_gross replace;
	getnames=yes;
	
data formatted;
	set raw;
	movie_id = input(x1,$15.);
	movie_name = input(x2,$100.);
	year = input(x3,??10.);
	certificate = input(x4,??$10.);
	runtime = input(compress(scan(x5,1,' '),','),10.);
	genre = input(x6,$30.);
	rating = input(x7,10.);
	description = input(x8,$250.);
	director = input(x9,$250.);
	director_id = input(x10,$100.);
	star=input(x11,$150.);
	star_id=input(x12,$300.);
	votes = input(x13, 20.);
	gross = input(x14, 20.);
	drop x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14;

data genre_temp;
	set formatted(keep=movie_id genre);
	length genre1-genre3 $20.;
	array genreInd{3} genre1-genre3;
	do i=1 to 3;
		genreInd{i}=scan(genre,i,',');
	end;
	keep movie_id genre1-genre3;
proc sort data=genre_temp out=genre nodup;
	by _all_;
	
data stars_temp;
	set formatted(keep=movie_id star star_id);
	length actor1-actor4 $40.;
	array actor{4} actor1-actor4;
	if(star="") then countAct=0;
	else countAct=countw(star,'|');
	do i=1 to 4;	
		actor{i} = trim(compress(scan(star,i,'|'),','));
	end;
	keep movie_id actor1-actor4 countAct;
proc sort data=stars_temp out=stars nodup;
	by _all_;

%let lim_director=5;
data director_temp;
	set formatted(keep=movie_id director director_id);
	if(director="") then countDir=0;
	else countDir=countw(director,'|');
	limit=&lim_director;
	if countDir>limit then countDir=limit+1;
	length director1-director&lim_director $40.;
	array directorArr{&lim_director} director1-director&lim_director;
	do i=1 to limit;
		directorArr{i} = trim(compress(scan(director,i,'|'),','));
	end;
	keep movie_id director1-director&lim_director countDir director;
proc sort data=director_temp out=director nodup;
	by _all_;

data details_temp;
	format year yearFormat.;
	set formatted(keep= movie_id movie_name year certificate runtime description votes gross);
	lowertext=lowcase(description);
	description=compress(lowertext,"'.,;?!/\():");
	numberwords=countw(description);
proc sql;
	create table summary_temp as
	select movie_id, movie_name, year, certificate, runtime, description, numberwords as num_description, mean(votes) as mean_vote, mean(gross)/1e6 as mean_gross
	from details_temp
	group by movie_id;
quit;
proc sort data=summary_temp out=summary nodup;
	by _all_;

proc sql;
	create table full as
	select s.*, d.*, g.*, st.*
	from summary s, director d, genre g, stars st
	where s.movie_id=d.movie_id and d.movie_id=g.movie_id and g.movie_id=st.movie_id
		and s.year<2020 and s.year>=1990;
quit;



*******************************************************************************************************;
* Merge two datasets;
data movie_gross;
	set movie_gross;
	length grossAvail $5.;
	if gross ne . then grossAvail='Yes';
	else grossAvail='No'; 
data full;
	set full;
	length grossAvail $5.;
	if mean_gross ne . then grossAvail='Yes';
	else grossAvail='No';
	if genre1 in ("Action", "Comedy","Drama","Horror") then main=1;
	else main=0;
proc sql;
	create table full_gross as
	select f.*, m.gross/1000000 as gross, m.budget/1000000 as budget, (m.gross-m.budget)/1000000 as profit
	from full f, movie_gross m
	where f.movie_name=m.name and f.year=m.year and f.runtime=m.runtime;
quit;
data full_gross;
	set full_gross;
	drop mean_gross;
	log_gross=log(gross);
	log_budget=log(budget);
	


*******************************************************************************************************;
* Bar charts of the movies industry;
proc sql;
	create table general as
	select year, sum(gross) as sum_gross, sum(budget) as sum_budget
	from full_gross
	group by year;
quit;
proc sgplot data=general;
	title "Development of the film industry over the year by gross and budget";
	xaxis label="Year";
	yaxis label="Millions of dollars";
	label sum_gross="Average Gross" sum_budget="Average Budget";
	format year 10.;
	vbar year/response=sum_gross;
	vbar year/response=sum_budget;

	
*******************************************************************************************************;
* Sort top 4 main genres;
proc freq data=full order=freq;
	table genre1/nocol nocum out=sortedGenre noprint;

proc tabulate data=sortedGenre(obs=4) order=data;
	title 'Top 4 most popular genres(based on number of movies)';
	class genre1;
	var count percent;
	table genre1, count percent;



*******************************************************************************************************;
* Plot bar charts of movies over the years;
proc format;
	value $genreFormat
		"Action"= "Action"
		"Comedy"= "Comedy"
		"Drama"= "Drama"
		"Horror"= "Horror"
		other= "Other";
proc sgplot data=full;
	title 'Development of movies over the year by number';
	xaxis label="Year";
	yaxis label="Number of movies";
	vbar year/group=genre1;
	format genre1 $genreFormat.;



*******************************************************************************************************;	
* Pie charts of six latest year groups;
proc gchart data=full;
	label genre1="Main Genre";
	title "Pie Charts of movies genres in six latest year groups";
	pie genre1/clockwise group=year legend percent=arrow across=3 down=2;
	format genre1 $genreFormat.;



*******************************************************************************************************;
* Gross of the latest six years groups;
proc sort data=full_gross out=full_sort_genre;
	by genre1 year;

*****************************;
*********NEW COMMAND*********;
*****************************;
* Purpose: Perform analysis of means to compare the gross of each genres with their overall means at a specified significance level of alpha;

* Citation:
* Google Search Query: proc anom sas
* Link: https://support.sas.com/documentation/onlinedoc/qc/142/anom.pdf;	
proc anom data=full_sort_genre;
	boxchart log_gross*genre1/alpha=0.05 nochart outbox=anom_data;
* End;

*****************************;
************ END ************;
*****************************;
proc transpose data=anom_data out=anom_data;
	id _type_;
	var _value_;
	by genre1;
proc sql;
	create table merge_data as
	select f.*, a.*
	from anom_data a, full_sort_genre f
	where f.genre1=a.genre1 and f.genre1 in ("Action", "Comedy","Drama","Horror");
quit;
proc sgplot data=merge_data;
	title "Analysis of Means for log of gross for movies";
	label log_gross="Log of Gross(in millions)" udlx="Upper Decision Limit" ldlx="Lower Decision Limit";
	xaxis label="Main Genre";
	yaxis label="Log of Gross(in millions)";
	vbox log_gross/category=genre1;
	
* Citation;
* Google Search Query: proc sgplot vbox reference line each column
* Link: https://communities.sas.com/t5/Graphics-Programming/proc-sgplot-vbox-reference-lines/td-p/414921;
* From: WCW;
	scatter x=genre1 y=udlx/jitter jitterwidth=0.2 markerattrs=(symbol=circlefilled size=3 color=blue);
	scatter x=genre1 y=ldlx/jitter jitterwidth=0.2 markerattrs=(symbol=circlefilled size=3 color=red);
* End;

proc means data=full_sort_genre mean q1 q3 median std nway noprint;
	var profit;
	by genre1;
	output out=general_stat mean=Mean q1=q1 q3=q3 median=Median std=STD max=Max min=Min/autoname;
	where main not eq 0;
proc print data=general_stat label;
	title "Statistics for profit(in millions) of top genres of movies";
	var genre1 min q1 mean median q3 max std;
	format min q1 mean median q3 max std dollar10.4;
	label genre1="Main Genre" q1="Quartile 1" q3="Quartile 3" median="Median" std="Standard Deviation" max="Max" min="Min" mean="Mean";



*******************************************************************************************************;
* Means of Genres per year;
proc means data=full_sort_genre mean nway noprint;
	format genre1 $genreFormat. year 10.;
	class year;
	var gross;
	by genre1;
	where main not eq 0;
	output out=full_stats_gross mean=mean_gross;
data full_stats_gross;
	set full_stats_gross;
	if genre1 in ("Action", "Horror") then group=1;
	else group=2;
proc adaptivereg data=full_stats_gross plots=none;
	title "Regression for gross(in millions) over the year";
	by genre1;
	model mean_gross=year/maxbasis=11;
	output out=stats_gross predicted=predictions;
proc sgpanel data=stats_gross;
	title "Mean Gross of genres over the year";
	panelby group;
	rowaxis label="Mean Gross(in millions dollar)";
	format year 10.;
	vline year/group=genre1 response=mean_gross lineattrs=(thickness=2.5);
	vline year/group=genre1 response=predictions lineattrs=(thickness=2.5 pattern=2);
	colaxis fitpolicy=thin;

proc means data=full_sort_genre mean nway noprint;
	format genre1 $genreFormat. year 10.;
	class year;
	var profit;
	by genre1;
	where main not eq 0;
	output out=full_stats_profit mean=mean_profit;
data full_stats_profit;
	set full_stats_profit;
	if genre1 in ("Action", "Horror") then group=1;
	else group=2;
proc adaptivereg data=full_stats_profit plots=none;
	title "Regression for profit(in millions) over the year";
	by genre1;
	model mean_profit=year/maxbasis=11;
	output out=action_profit predicted=predictions;
proc sgpanel data=action_profit;
	title "Mean Profit of genres over the year";
	panelby group;
	rowaxis label="Mean Profit(in millions dollar)";
	format year 10.;
	vline year/group=genre1 response=mean_profit lineattrs=(thickness=2.5);
	vline year/group=genre1 response=predictions lineattrs=(thickness=2.5 pattern=2);
	colaxis fitpolicy=thin;

	

*******************************************************************************************************;	
* Actor and director Analysis;
* Top 5 actors and directors;
proc sql;
	create table actor_sort_gross as
	select actor1 as main_actor, sum(gross) as sum_money, "Gross" as flag
	from full_gross
	where genre1 = 'Action'
	group by actor1
	order by sum_money desc;
	
	create table dir_sort_gross as
	select director1 as main_director, sum(gross) as sum_money, "Gross" as flag
	from full_gross
	where genre1 = 'Action'
	group by director1
	order by sum_money desc;
	
	create table actor_sort_profit as
	select actor1 as main_actor, sum(profit) as sum_money, "Profit" as flag
	from full_gross
	where genre1 = 'Action'
	group by actor1
	order by sum_money desc;
	
	create table dir_sort_profit as
	select director1 as main_director, sum(profit) as sum_money, "Profit" as flag
	from full_gross
	where genre1 = 'Action'
	group by director1
	order by sum_money desc;
quit;
data actor_sort;
	length flag $10.;
	format sum_money dollar15.4;
	set actor_sort_gross(obs=5) actor_sort_profit(obs=5);
data dir_sort;
	length flag $10.;
	format sum_money dollar15.4;
	set dir_sort_gross(obs=5) dir_sort_profit(obs=5);
proc print data=actor_sort label;
	title "Top actors by gross and profit";
	label sum_money="Income(millions of dollars)" main_actor="Main Actor" flag="Category";
proc print data=dir_sort label;
	title "Top directors by gross and profit";
	label sum_money="Income(millions of dollars)" main_director="Main Director" flag="Category";
* Top 5 actors and 5 directors who have worked together;
proc sql;
	title "Movies by top actors and directors in Action Genre";
	select actor1 as Main_Actor, director1 as Main_Director, movie_name as Name, Year as Year, Runtime as Runtime,
		Gross as Gross format=dollar15.4, Profit as Profit format=dollar15.4
	from full_gross
	where actor1 in ('Robert Downey Jr.','Tom Cruise', 'Dwayne Johnson', 'Vin Diesel', 'Will Smith','Chris Pratt') and director1 in ('James Cameron','Anthony Russo','Michael Bay','Christopher Nolan','Roland Emmerich','Steven Spielberg')
	order by profit desc;
quit;
data full_gross;
	set full_gross;
	if actor1 in ('Robert Downey Jr.','Tom Cruise', 'Dwayne Johnson', 'Vin Diesel', 'Will Smith','Chris Pratt') then famousActor=1;
	else famousActor=0;
	if  director1 in ('James Cameron','Anthony Russo','Michael Bay','Christopher Nolan','Roland Emmerich','Steven Spielberg') then famousDir=1;
	else famousDir=0;
proc corr data=full_gross;
	var gross famousDir famousActor;


*******************************************************************************************************;
* Action and its subgenres;
proc sql;
	create table genre_sort as
	select genre1 as main_genre, genre2 as sub_genre, avg(gross) as avg_gross, avg(profit) as avg_profit
	from full_gross
	where main_genre = 'Action'
	group by main_genre, sub_genre
	order by avg_gross desc;
proc gradar data=genre_sort;
	title "Averae gross(in million dollars) by sub-genres";
	chart sub_genre/freq=avg_gross wstar=2 lstar=2;
proc gradar data=full;
	title "Number of Movies by sub-genres";
	chart genre2/wstar=2 lstar=2;
	where genre1='Action';



*******************************************************************************************************;	
* Keyword;
%let lim_gross=2000;
data word_temp;
	set full_gross;
	where genre1='Action' and gross ne .;
	do i=1 to num_description;
		word=trim(scan(description,i,' '));
		if word ne '' then do;
			if gross > &lim_gross then gross=&lim_gross;
			output;
		end;
	end;
	keep word gross;
proc sql;
	create table word_weight as
	select word, avg(gross) as avg_gross, count(word) as word_num
	from word_temp
	group by word
	having count(word) > 5
	order by avg_gross desc;
quit;
proc print data=word_weight(obs=10) label;
	label avg_gross='Average Gross(in million of dollars)' word="Word" word_num="Appearances";
	format avg_gross dollar10.4;
	title "Weighted Words List in Action Genre";





	
	