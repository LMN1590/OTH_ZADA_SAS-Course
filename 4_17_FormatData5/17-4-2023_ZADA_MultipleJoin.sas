* 	ZADA
	SQL
		Join Multiple Tables
	17/04/2023
	LMN;
*/home/u63345509/sasuser.v94/Data/;

proc sql;
title 'Australian Customers who purchased imported goods';
select customer_name, count(*) as Total
	from '/home/u63345509/sasuser.v94/Data/customer' c,
		'/home/u63345509/sasuser.v94/Data/order' o,
		'/home/u63345509/sasuser.v94/Data/product' p
	where c.customer_id=o.customer_id
		and o.product_id=p.product_id
		and c.country='AU' and p.supplier_country ne 'AU'
	group by customer_name
	order by total, customer_name;
quit;