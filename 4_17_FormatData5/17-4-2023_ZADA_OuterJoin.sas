* 	ZADA
	SQL
		Outer Join
	17/04/2023
	LMN;
*/home/u63345509/sasuser.v94/Data/;

proc sql;
title 'Employees by location';
select e.Employee_ID, Employee_Name, Job_Title
	from '/home/u63345509/sasuser.v94/Data/employee' as e left join
		'/home/u63345509/sasuser.v94/Data/jobtitle' as j
	on e.employee_id=j.employee_id
	order by employee_id;
run;
	
