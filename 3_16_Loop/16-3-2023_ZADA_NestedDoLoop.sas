* 	ZADA
	Intro Classes
		Nested Do loop
	16/03/2023
	LMN;
	
data investtwo;
	init=1000;
	rate=0.5;
	year=1;
	month=1;
	do while (init<2000);
		gain=init*(rate/12);
		init+gain;
		month+1;
		if(month > 12) then do;
			month=1;
		 	year+1;
		end;
		output;
	end;
run;

proc print data=investtwo;
	format gain 6.2
		   init 10.0;
run;
	
	
		 	