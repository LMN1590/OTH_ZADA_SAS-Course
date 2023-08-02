* 	ZADA
	SQL
		Join Multiple Tables 2
	17/04/2023
	LMN;
*/home/u63345509/sasuser.v94/Data/;

proc sql;
title 'Trainees and their managers';
select  m.employee_name as Manager, count(*) as Number_of_trainees
	from '/home/u63345509/sasuser.v94/Data/employee' e,
		'/home/u63345509/sasuser.v94/Data/jobtitle' j,
		'/home/u63345509/sasuser.v94/Data/employee' m
	where e.employee_id=j.employee_id
		and j.manager_id=m.employee_id
		and j.job_title contains 'Trainee'
	group by Manager;
quit;