* Nghia Le 15/05/23;
* On my own;

* 	My full name is Nghia Le Minh, but "Minh" is a middle name. 
	Naming convention in my country is different from Western countries. 
	Therefore, I will only insert my first name and last name in the first line.;
	
proc format; 
	value $Yesno 
		'Y','1' = 'Yes' 
		'N','0' = 'No' 
		' ' = 'Not Given'; 
	value $Size 
		'S' = 'Small' 
		'M' = 'Medium' 
		'L' = 'Large' 
		' ' = 'Missing'; 
	value $Gender 
		'F' = 'Female' 
		'M' = 'Male' 
		' ' = 'Not Given'; 
run;
data college;
	set "/home/u63345509/sasuser.v94/Data/college";
	format Scholarship $Yesno. Schoolsize $size.;
run;

proc format;
	value $SchoolSize
		'L'='Large'
		'M'='Medium'
		'S'='Small';
	value $YesNo
		'Y'='Yes'
		'N'='No';

proc tabulate data=college;
	class schoolsize gender scholarship;
	table 	(schoolsize ALL),
			(Gender) (Scholarship ALL);
	keylabel 	ALL='Total'
				n=' ';
run;