
--select/display the entire table CUST_AZ12
select
	*
from project.CUST_AZ12;

--check for null in column cid
--expectation met, no null cells
select
	*
from project.CUST_AZ12
where cid is null;

--check for duplicates in column cid
--expectations met, no duplicates
select
	cid,
	count (*)
from project.CUST_AZ12
group by cid
having count (*) > 1;

--check for null in column bdate
--No null cells
select
	*
from project.CUST_AZ12
where bdate is null;

--check for duplicates in column bdate
--presence of duplicates
select
	bdate,
	count (*)
from project.CUST_AZ12
group by bdate
having count (*) > 1;

--check reason for duplicates in column bdate
--No duplicates, the same date for different products
select
	*
from project.CUST_AZ12
where bdate = '1946-12-11';


--check for null in column gen
--No null cells
select
	*
from project.CUST_AZ12
where gen is null;


--select distict values in column gen 
select
	distinct (gen)
from project.CUST_AZ12;


--check for white space in column gen
--expectation not met, presence of white space--
select 
	gen
from project.CUST_AZ12
where gen != trim(gen);

--remove whitespace
select
	case 
		when upper (trim(gen)) = 'M' then 'Male'
		when upper (trim(gen)) = 'F' then 'Female'
		when trim (gen) = 'Male' then 'Male'
		when trim(gen) = 'Female' then 'Female'
		else 'n/a'
	end as Gender
from project.CUST_AZ12;

--create a new table for the cleaned data
create table final.cleaned_CUST_AZ12 as 
select 
	cid,
	bdate,
	case 
		when upper (trim(gen)) = 'M' then 'Male'
		when upper (trim(gen)) = 'F' then 'Female'
		when trim (gen) = 'Male' then 'Male'
		when trim(gen) = 'Female' then 'Female'
		else 'n/a'
	end as Gender
from project.CUST_AZ12;