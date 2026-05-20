--select/display the entire table LOC_A101
select
	*
from project.LOC_A101;

--check for null in column cid
--expectation met, no null cells
select
	*
from project.LOC_A101;
where cid is null;

--check for duplicates in column cid cid
--expectation met, no duplicates
select
	cid,
	count (*)
from project.LOC_A101
group by cid
having count (*) > 1;


--check for null in column cntry 
--No null cells in cntry
select
	*
from project.LOC_A101
where cntry is null;

--check for white space in column cntry
--expectation met, no white space
select 
	cntry
from project.LOC_A101
where cntry != trim(cntry);

--remove the hyphen in column cid to match cut_key in cust_info table
select
	cid,
	replace (cid, '-','') as cleaned_cid
from project.LOC_A101;

--Query cleaned data
select
	replace (cid, '-','') as cleaned_cid,
	cntry
from project.LOC_A101;

--create a new table for the cleaned data
create table final.cleaned_LOC_A101 as
select
	replace (cid, '-','') as cleaned_cid,
	cntry
from project.LOC_A101;
