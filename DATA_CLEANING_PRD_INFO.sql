---select/display the entire table prd_info
select
	*
from project.prd_info;

--check for duplicates in column prd_id
--expectation met, no duplicates
select
	prd_id,
	count(*)
from project.prd_info
group by prd_id
having count(*)>1;

--check for null cells in prd_id column
--expectation met, no null cell
select
	prd_id
from project.prd_info
where prd_id is null;

--check for duplicates cells in prd_key column
--expectation not met, duplicate cells,
select
	prd_key,
	count(*)
from project.prd_info
group by prd_key
having count(*)>1;

--confirm reason for duplicate prd_key
--some products with same prd_key have different prd_id
some prd_key has different prd_id
select
	*
from project.prd_info
where prd_key = 'CO-RF-FR-R38R-58';


--check for null cells in prd_key column
--expectation met, no null cells
select
	prd_key
from project.prd_info
where prd_key is null;

--separate prd_key into 2 (cat_id and prd_id)
select
	replace (substring (prd_key, 1, 5), '-','_') as cat_id,
	substring (prd_key, 7, length(prd_key)) as prd_key
from project.prd_info;

--check reason for duplicates in prd_key
select
	*
from project.prd_info
where prd_key = 'CO-RF-FR-R38R-58';

--check for -ve prd_cost
select
	*
from project.prd_info
where prd_cost < 0;

--replace null cells in column pro_cost as zero
select
	coalesce(prd_cost, 0) as pro_cost
from project.prd_info;

Query cleaned columns
select
	replace (substring (prd_key, 1, 5), '-','_') as cat_id,
	substring (prd_key, 7, length(prd_key)) as prd_key,
	prd_nm,
	coalesce(prd_cost, 0) as pro_cost
from project.prd_info;

--select distinct values in column prd_line
select
	distinct (prd_line)
from project.prd_info;

--replace the values in column prd_line
	case
		when trim (prd_line) = 'M' then 'Mountain'
		when trim (prd_line) = 'R' then 'Road'
		when trim (prd_line) = 'S' then 'Other Sales'
		when trim (prd_line) = 'T' then 'Touring'
		else 'n/a'
	end as prd_line
from project.prd_info;
	end

--Query cleaned table
select
	replace (substring (prd_key, 1, 5), '-','_') as cat_id,
	substring (prd_key, 7, length(prd_key)) as prd_key,
	prd_nm,
	coalesce(prd_cost, 0) as pro_cost,
	case
		when upper(trim (prd_line)) = 'M' then 'Mountain'
		when upper(trim (prd_line)) = 'R' then 'Road'
		when upper(trim (prd_line)) = 'S' then 'Other Sales'
		when upper(trim (prd_line)) = 'T' then 'Touring'
		else 'n/a'
	end as prd_line,
	prd_start_dt
from project.prd_info;

select
	*
from project.prd_info;
where prd_start_dt is null;

select
	*
from project.prd_info
where prd_start_dt > prd_end_dt;

--ensure a product ends atleats a day before the production of another
select 
	*,
	lead(prd_start_dt) over (partition by prd_key order by prd_start_dt) - 1 as prd_end_date
from project.prd_info
where prd_start_dt > prd_end_dt;

--store cleaned data as view
create view project.clean_prd_info as
select
	replace (substring (prd_key, 1, 5), '-','_') as cat_id,
	substring (prd_key, 7, length(prd_key)) as prd_key,
	prd_nm,
	coalesce(prd_cost, 0) as pro_cost,
	case
		when upper(trim (prd_line)) = 'M' then 'Mountain'
		when upper(trim (prd_line)) = 'R' then 'Road'
		when upper(trim (prd_line)) = 'S' then 'Other Sales'
		when upper(trim (prd_line)) = 'T' then 'Touring'
		else 'n/a'
	end as prd_line,
	prd_start_dt,
	lead(prd_start_dt) over (partition by prd_key order by prd_start_dt) - 1 as prd_end_date
from project.prd_info;

--create a new table for the cleaned data
create table final.cleaned_prd_info as 
select
	replace (substring (prd_key, 1, 5), '-','_') as cat_id,
	substring (prd_key, 7, length(prd_key)) as prd_key,
	prd_nm,
	coalesce(prd_cost, 0) as pro_cost,
	case
		when upper(trim (prd_line)) = 'M' then 'Mountain'
		when upper(trim (prd_line)) = 'R' then 'Road'
		when upper(trim (prd_line)) = 'S' then 'Other Sales'
		when upper(trim (prd_line)) = 'T' then 'Touring'
		else 'n/a'
	end as prd_line,
	prd_start_dt,
	lead(prd_start_dt) over (partition by prd_key order by prd_start_dt) - 1 as prd_end_date
from project.prd_info;