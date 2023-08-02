* 	ZADA
	Intro Classes
		Do loop
	16/03/2023
	LMN;

data investone;
	init=1000;
	rate=0.5;
	do month=1 to 12;
		gain=init*(rate/12);
		init+gain;
		output;
	end;
run;

proc print data=investone;
	format gain 6.2
		   init 10.0;
run;