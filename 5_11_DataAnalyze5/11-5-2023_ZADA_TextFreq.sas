* 	ZADA
	SQL
		Text Analysis
	11/05/2023
	LMN;
	
proc import datafile="/home/u63345509/sasuser.v94/Data/pg.csv" 
	dbms=csv out=pg replace;
	getnames=yes;
	
data numberw;
	set pg;
	lowertext=lowcase(text);
	formattext=compress(lowertext,"'.,;?!/\()");
	numberwords=countw(formattext);

data wordgrams;
	set numberw;
	array word {1:5000} $50. _temporary_;
	do i=1 to numberwords;
		retain word_i;
		word(i)=scan(formattext,i,' ');
		word_i=word(i);
		if(i>1) then word_2i=catx(' ',word(i-1),word_i);
		if(i>2) then word_3i=catx(' ',word(i-2),word(i-1),word_i);
		output;
	end;
proc freq data=wordgrams order=freq;
	table word_i word_2i word_3i / nocum;
run;