--medium sql question rishab

CREATE TABLE match ( team varchar(20) )
INSERT INTO match (team) VALUES ('India'), ('Pak'), ('Aus'), ('Eng')
select * from  match

CREATE TABLE emp ( ID int, NAME varchar(10) )

INSERT INTO emp (ID, NAME)
VALUES (1,'Emp1'), (2,'Emp2'), (3,'Emp3'), (4,'Emp4'),
(5,'Emp5'), (6,'Emp6'), (7,'Emp7'), (8,'Emp8');

-- create a row, do a cartisan product and apply condition where you basically compare the sr_no of the tables

with cte as (
select team,
row_number() over() as sr_no
from match
)
select t1.team,t2.team from cte t1
join cte t2
on t1.team != t2.team -- This basically gives us a cartisean product
where t2.sr_no > t1.sr_no
-------------------- 
/* there is a percentile thing which is ntile which is used to create a group 
there is a string_agg(col_name, ', ') will join the rows with , in between 
and there is a concat also 
*/
---prequisites
select concat(id,' ',name) from emp

select string_agg(name,'* ') from emp -- concat all the rows in single rows

select *,
ntile(2) over(order by id) as groups_made
from emp

--let's begin with the problem solving 

select * from emp
select * , concat(id,' ',name) from emp

with cte as (
select * , concat(id,' ',name) as conn,
ntile(4) over(order by id) as grp
from emp
)

select string_agg(conn, ', ') as results , grp from cte
group by grp
order by grp


select * from emp
----------------------------------------------------------------------
with cte as (
select *, concat(id,' ', name) as stiched,
ntile(4) over(order by id) as groupsy
from emp
)
select groupsy,string_agg(stiched, ', ') from cte
group by groupsy
order by groupsy