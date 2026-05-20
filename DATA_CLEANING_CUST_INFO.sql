--select/display the entire table cust_info
select *
from project.cust_info;

--check cst_id for duplicates--
--expectation not met, duplicates present
select 
	cst_id,
	count(*)
from project.cust_info
group by cst_id
having count(*)>1;

--confirm reason for duplicates
--Slowly Changing Dimension (SCD)
select 
	*
from project.cust_info
where cst_id=29473;

--select cust_info with the most recent row_no using windows functions and subquerry
select 
	*	
from 
(select 
	*,
row_number() over (partition by cst_id order by cst_create_date desc) as row_no
from project.cust_info) t
where row_no = 1;

2.--check column cst_id for nulls--
--expectation not met, nulls present--

select 
	*
from project.cust_info
where cst_id is null;

--select cust_info with the most recent row_no using windows functions and subquerry WITHOUT NULL cst_id
select 
	*	
from 
(select 
	*,
row_number() over (partition by cst_id order by cst_create_date desc) as row_no
from project.cust_info
where cst_id is not null) t
where row_no = 1;

--check column cst_key for nulls using the last query (cleaned) as a temporary table--
--expectation met, no nulls--
with temp_table as (
	select 
		*	
	from 
	(select 
		*,
	row_number() over (partition by cst_id order by cst_create_date desc) as row_no
	from project.cust_info
	where cst_id is not null) t
	where row_no = 1)
select 
	cst_key,
	count(*)
from temp_table
group by cst_key
having count(*)>1;

--Recall table cust_info
select 
	*
from project.cust_info;

--check for white space in column cst_firstname
--expectation not met, presence of white space--
select 
	cst_firstname
from project.cust_info
where cst_firstname != trim(cst_firstname);

--Remove white space using trim. Also, use the clean table as subquery
select 
	cst_id,
	cst_key,
	trim(cst_firstname) as firstname,
	trim(cst_lastname) as lastname
from 
(select 
	*,
row_number() over (partition by cst_id order by cst_create_date desc) as row_no
from project.cust_info
where cst_id is not null) t
where row_no = 1;

--Recall table
select *
from project.cust_info;

--check distinct values in column cst_marital_status
select 
	distinct (cst_marital_status)
from project.cust_info;

--Rename M as Married, S as Single otherwise, n/a
select
	case 
		when cst_marital_status = 'M' then 'Married'
		when cst_marital_status = 'S' then 'Single'
		else 'n/a'
	end as Marital_Status
from project.cust_info;

--store cleaned cust_info table as view
create view project.clean_cust_info as
select 
	cst_id,
	cst_key,
	trim(cst_firstname) as firstname,
	trim(cst_lastname) as lastname,
	case 
		when cst_marital_status = 'M' then 'Married'
		when cst_marital_status = 'S' then 'Single'
		else 'n/a'
	end as Marital_Status,
	case 
		when upper (cst_gndr) = 'M' then 'Male'
		when upper (cst_gndr) = 'F' then 'Female'
		else 'n/a'
	end as Customer_gender,
	cst_create_date
from 
	(select 
	*,
row_number() over (partition by cst_id order by cst_create_date desc) as row_no
from project.cust_info
where cst_id is not null) t
where row_no = 1;

check for cst_create_date less than 2025-01-01,
none, expectation met
select 
	cst_create_date
from project.cust_info
where (cst_create_date) < '2025-01-01';

--create a new table for the cleaned data
create table final.cleaned_cust_info as 
select 
	cst_id,
	cst_key,
	trim(cst_firstname) as firstname,
	trim(cst_lastname) as lastname,
	case 
		when cst_marital_status = 'M' then 'Married'
		when cst_marital_status = 'S' then 'Single'
		else 'n/a'
	end as Marital_Status,
	case 
		when upper (cst_gndr) = 'M' then 'Male'
		when upper (cst_gndr) = 'F' then 'Female'
		else 'n/a'
	end as Customer_gender,
	cst_create_date
from 
	(select 
	*,
row_number() over (partition by cst_id order by cst_create_date desc) as row_no
from project.cust_info
where cst_id is not null) t
where row_no = 1;