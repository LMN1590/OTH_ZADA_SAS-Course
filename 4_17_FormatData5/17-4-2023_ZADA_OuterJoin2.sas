* 	ZADA
	SQL
		Outer Join 2
	17/04/2023
	LMN;
*/home/u63345509/sasuser.v94/Data/;

proc sql;
	title 'Products that are ordered';
	select p.product_id, product_name, quantity
	from '/home/u63345509/sasuser.v94/Data/order' o left join
		'/home/u63345509/sasuser.v94/Data/product' p
	on o.product_id=p.product_id
	order by quantity;
quit;