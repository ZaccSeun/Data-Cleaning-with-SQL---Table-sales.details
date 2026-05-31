--create table PX_CAT_G1V2
create table project.PX_CAT_G1V2 (
	id varchar,
	cat varchar,
	subcat varchar,
	maintenance varchar
);

--create table prd_info
create table project.prd_info (
	prd_id int,
	prd_key varchar,
	prd_nm varchar,
	prd_cost int,
	prd_line varchar,
	prd_start_dt date,
	prd_end_dt date
);

--create table cust_info
create table project.cust_info (
	cst_id int,
	cst_key varchar,
	cst_firstname varchar,
	cst_lastname varchar,
	cst_marital_status varchar,
	cst_gndr varchar,
	cst_create_date date
);	

--create table CUST_AZ12
create table project.CUST_AZ12 (
	cid varchar,
	bdate date,
	gen varchar
);

--create table sales_details
create table project.sales_details (
	sls_ord_num varchar,
	sls_prd_key varchar,
	sls_cust_id int,
	sls_order_dt varchar,
	sls_ship_dt varchar,
	sls_due_dt varchar,
	sls_sales int,
	sls_quantity int,
	sls_price int
);

--create table LOC_A101
create table project.LOC_A101 (
	cid varchar,
	cntry varchar
);

--load data into table PX_CAT_G1V2
copy project.PX_CAT_G1V2
from 'C:\Users\USER\Downloads\SQL_data\PX_CAT_G1V2.csv'
with (format csv, header,delimiter',');

--load data into table prd_info
copy project.prd_info
from 'C:\Users\USER\Downloads\SQL_data\prd_info.csv'
with (format csv, header,delimiter',');

--load data into table cust_info
copy project.cust_info
from 'C:\Users\USER\Downloads\SQL_data\cust_info.csv'
with (format csv, header,delimiter',');

--load data into table CUST_AZ12
copy project.CUST_AZ12
from 'C:\Users\USER\Downloads\SQL_data\CUST_AZ12.csv'
with (format csv, header,delimiter',');

--load data into table sales_details
copy project.sales_details
from 'C:\Users\USER\Downloads\SQL_data\sales_details.csv'
with (format csv, header,delimiter',');

--load data into table LOC_A101
copy project.LOC_A101
from 'C:\Users\USER\Downloads\SQL_data\LOC_A101.csv'
with (format csv, header,delimiter',');


--select each table

select *
from project.PX_CAT_G1V2;

select *
from project.prd_info;

select *
from project.cust_info;

select *
from project.CUST_AZ12;

select *
from project.sales_details;

select *
from project.LOC_A101;