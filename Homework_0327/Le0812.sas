* Nghia Le 27/03/23;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;
	
data invest;
	cur=0;
	rate=0.0425;
	do year=1 to 100 until (cur>=30000);
		cur+1000;
		gain=cur*(rate);
		cur+gain;
		output;
	end;
run;

title "Investment over the year";
proc print data=invest;
	format cur gain dollar10.2; 
run;

* From the data, it will take 20 years for the amount to reach $30.000.