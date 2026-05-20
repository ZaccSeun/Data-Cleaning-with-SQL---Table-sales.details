--select/display the entire table sales_details
select
	*
from project.sales_details;

--check for duplicates in column sls_ord_num
--expectation not met, duplicates present
select
	sls_ord_num,
	count(*)
from project.sales_details
group by sls_ord_num
having count(*) >1;

--confirm reason for duplicates in column sls_ord_num
--some products with different sls_prd_key have the same sls_ord_num
select
	*
from project.sales_details
where sls_ord_num = 'SO58610';

--check for null in column sls_ord_num
--expectation met, null absent
select
	*
from project.sales_details
where sls_ord_num is null;

select
	sls_ord_num,
	sls_prd_key
from project.sales_details;
where sls_ord_num is null;

--confirm the presence of sls_prd_key in the subquery below
--expectation met, sls_prd_key present
select
	*
from 
	project.sales_details
where sls_prd_key not in (
	select
	substring (prd_key, 7, length(prd_key)) as prd_key
	from project.prd_info);

--confirm the presence of cust_id in the subquery below
--expectation met, cust_id present
select
	*
from 
	project.sales_details
where sls_cust_id not in (
	select 
		cst_id
	from project.cust_info);

select
	*
from project.sales_details
where cast (sls_order_dt as int) = 0;

--Query table where length of sls_order_dt does not equal 8
select
	*
from project.sales_details
where length (sls_order_dt) != 8;

select 
	case
		when cast (sls_order_dt as int)= 0 or length (sls_order_dt) != 8 then null
		else cast (sls_order_dt as date)
	end as sls_order_dt
from project.sales_details;

--Recall table
select
	*
from project.sales_details;

--Query cleaned table
select
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	case
		when cast (sls_order_dt as int)= 0 or length (sls_order_dt) != 8 then null
		else cast (sls_order_dt as date)
	end as sls_order_dt,
	case
		when cast (sls_ship_dt as int)= 0 or length (sls_ship_dt) != 8 then null
		else cast (sls_ship_dt as date)
	end as sls_ship_dt,
	case
		when cast (sls_due_dt as int)= 0 or length (sls_due_dt) != 8 then null
		else cast (sls_due_dt as date)
	end as sls_due_dt
from project.sales_details;

--check for null and negative sls_sales
--expectation not met, presence of null and negative sls_sales
select
	*
from project.sales_details
where cast (sls_sales as int) is null or cast (sls_sales as int)<0;

select
	*
from project.sales_details
where cast (sls_quantity as int) * cast (sls_price as int)!= cast (sls_sales as int);

select
	case
		when sls_quantity <= 0 or sls_sales is null or sls_quantity * sls_price != sls_sales 
		then ABS (sls_price) * sls_quantity
		else sls_sales
	end as sls_sales
from project.sales_details;

--Querry cleaned table
select
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	case
		when cast (sls_order_dt as int)= 0 or length (sls_order_dt) != 8 then null
		else cast (sls_order_dt as date)
	end as sls_order_dt,
	case
		when cast (sls_ship_dt as int)= 0 or length (sls_ship_dt) != 8 then null
		else cast (sls_ship_dt as date)
	end as sls_ship_dt,
	case
		when cast (sls_due_dt as int)= 0 or length (sls_due_dt) != 8 then null
		else cast (sls_due_dt as date)
	end as sls_due_dt,
	case
		when sls_quantity <= 0 or sls_sales is null or sls_quantity * sls_price != sls_sales 
		then ABS (sls_price) * sls_quantity
		else sls_sales
	end as sls_sales,
	sls_quantity,
	case
			when sls_price is null or sls_price<=0
			then sls_sales/coalesce(sls_quantity, 0)
		else sls_price
	end as sls_price
from project.sales_details;

--create a new table for the cleaned data
create table final.cleaned_sales_details as 
select
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	case
		when cast (sls_order_dt as int)= 0 or length (sls_order_dt) != 8 then null
		else cast (sls_order_dt as date)
	end as sls_order_dt,
	case
		when cast (sls_ship_dt as int)= 0 or length (sls_ship_dt) != 8 then null
		else cast (sls_ship_dt as date)
	end as sls_ship_dt,
	case
		when cast (sls_due_dt as int)= 0 or length (sls_due_dt) != 8 then null
		else cast (sls_due_dt as date)
	end as sls_due_dt,
	case
		when sls_quantity <= 0 or sls_sales is null or sls_quantity * sls_price != sls_sales 
		then ABS (sls_price) * sls_quantity
		else sls_sales
	end as sls_sales,
	sls_quantity,
	case
			when sls_price is null or sls_price<=0
			then sls_sales/coalesce(sls_quantity, 0)
		else sls_price
	end as sls_price
from project.sales_details;