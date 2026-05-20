--select/display the entire table PX_CAT_G1V2

select
	*
from project.PX_CAT_G1V2;

--check for null in column id
--No null cells
select
	*
from project.PX_CAT_G1V2
where id is null;

--check for white space in column id
--expectation met, no white space
select 
	id
from project.PX_CAT_G1V2
where id != trim(id);

--check for duplicates in column id
--No duplicates
select
	id,
	count (*)
from project.PX_CAT_G1V2
group by id
having count (*) > 1;


--check for null in column cat
--No null cells
select
	cat
from project.PX_CAT_G1V2
where cat is null;


--Check for distinct
select
	distinct (cat)
from project.PX_CAT_G1V2;

--check for white space in column cat
--expectation met, no white space
select 
	cat
from project.PX_CAT_G1V2
where cat != trim(cat);

--check for null in column subcat
--No null cells
select
	*
from project.PX_CAT_G1V2
where subcat is null;

--check for white space in column subcat
--expectation met, no white space
select 
	subcat
from project.PX_CAT_G1V2
where subcat != trim(subcat);

--check for distnct in column subcat
select
	distinct (subcat)
from project.PX_CAT_G1V2;


--check for null in column maintenance
--No null cells
select
	*
from project.PX_CAT_G1V2
where maintenance is null;

--check for white space in column maintenance
--expectation met, no white space
select 
	maintenance
from project.PX_CAT_G1V2
where maintenance != trim(maintenance);

--Check for distinct in column maintenance
select
	distinct (maintenance)
from project.PX_CAT_G1V2;

--table is clean

select 
	id,
	cat,
	subcat,
	maintenance
from PX_CAT_G1V2;

--create a new table for the cleaned data
create table final.cleaned_PX_CAT_G1V2 as
select 
	id,
	cat,
	subcat,
	maintenance
from PX_CAT_G1V2;
