* 	ZADA
	Format Data
		Parse and Concat Data
	03/04/2023
	LMN;
	
data composer;
	format first last maybe $20.;
	input @1 name $30.;
	first=scan(name,1,' ');
	last=scan(name,-1);
	maybe=scan(name,-2);
	if maybe=first then maybe='';
	if length(maybe)=1 then maybe='';
	lastname=cat(maybe,last);
	fullname=cat(first,trim(lastname));
	datalines;
Johann S. Bach
Carl P.E. Bach
Ludwig van Beethoven
G. F. Handel
Felix Max
	;
run;

proc print data=composer;
run;