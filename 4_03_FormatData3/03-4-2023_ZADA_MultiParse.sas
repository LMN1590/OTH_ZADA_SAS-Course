* 	ZADA
	Format Data
		Multi-line Parse
	03/04/2023
	LMN;

data uni;
	infile datalines dlm=',';
	input 	#1 name $15.
			#2 street $25.
			#3 postal & $10.  city $10.
			#4 country $10.;
	datalines;
FH Aachen
Eupenner Strasse 70
D-52066, Aachen
Germany
HAW Ausburg
An der Hoschule 1
D-86161, Ausburg
Germany
FHDW Hannover
Freundallee 15
D-30173, Hannover
Germany
OTH Regensburg
Universitatstrasse 31
D-93053, Regensburg
Germany
	;
run;

proc print data=uni;
run;