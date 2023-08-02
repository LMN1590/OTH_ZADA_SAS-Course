* 	ZADA
	SQL
		PROC Report
	25/05/2023
	LMN;
	
data carsone;
	set "/home/u63345509/sasuser.v94/Data/automobiles";
	
proc report data=carsone;
	column origin type n (mpghighway, mean) (mpgcity, mean);
		define origin/group;
		define type/group;
	title "Two groups";
	
proc report data=carsone;
	column origin type n (mpghighway, mean) (mpgcity, sum);
		define origin/group;
		define type/across;
	title "Group and Across";
	
proc report data=carsone;
	column origin n make (mpghighway, mean) (mpgcity, mean);
		define origin/group;
		define make/group;
	break after origin/summarize;
	rbreak after/summarize;
	title "Breaks";



