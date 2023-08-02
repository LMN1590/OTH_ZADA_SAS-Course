* 	ZADA
	SQL
		Inner Join with Computation
	17/04/2023
	LMN;
*/home/u63345509/sasuser.v94/Data/;

proc sql;
title 'Employee who stuck more than 30 years';
select employee_name, int((today()-employee_hire_date)/365.25) as years
	from '/home/u63345509/sasuser.v94/Data/employee' e, 
		'/home/u63345509/sasuser.v94/Data/payroll' p
	where e.employee_id=p.employee_id and calculated years>=30;
quit;