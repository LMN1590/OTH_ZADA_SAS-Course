data eucars;
set '/home/u63345509/sasuser.v94/Data/cars';

length country $ 14;
if make in ('Audi','BMW') then country='Germany';
else if make in ('Saab','Volvo') then country='Sweden';
else if make in ('Jaguar','Land Rover') then country='UK';

data gercars swedcars UKcars;
set eucars;
if country='Germany' then do;
	output gercars;
end;
else if country='Sweden' then do;
	output swedcars;
end;
else if country='UK' then do;
	output UKcars;
end;

title 'GER';
proc print data=gercars;
run;
title 'SWE';
proc print data=swedcars;
run;
title 'UK';
proc print data=UKcars;
run;