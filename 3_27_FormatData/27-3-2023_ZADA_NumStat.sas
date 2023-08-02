* 	ZADA
	Format Data
		Create numeric statistics
	27/03/2023
	LMN;
	
data techcash;
	input applcash amzncash fbcash googlcash msftcash tslacash;
	avgcash=mean(applcash,amzncash,fbcash,googlcash,msftcash,tslacash);
	mincash=min(applcash,amzncash,fbcash,googlcash,msftcash,tslacash);
	maxcash=max(applcash,amzncash,fbcash,googlcash,msftcash,tslacash);
	rangecash=maxcash-mincash;
	datalines;
		66301 41668 41124 109140 133768 3878.169
	;
run;

proc print data=techcash;
	format avgcash mincash maxcash rangecash dollar10.2;
run;