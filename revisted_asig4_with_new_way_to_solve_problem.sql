-- question 5 lead lag-- 
select * from a5

create temporary table a as 
select id, num, 
lag(num) over() as prev_value, -- over is used to give partitation if we don't pass any thing is will not create a pratitaion 
lead(num) over() as next_value -- consider over as a square which moulds the data into square if you pass null it won't mould 
from a5

select id,num from a
where num = prev_value and num = next_value and prev_value is not null and next_value is not null

/* you are using the LAG and LEAD window functions to get the previous (prev) and next (next) values for each row in the a5 table, respectively. These functions introduce null values for the first row when using LAG and for the last row when using LEAD. However, when you filter the results using the WHERE clause, the condition a.num = a.prev and a.num = a.next effectively excludes the rows where either a.prev or a.next is null.

Here's the breakdown:

For the first row, LAG(num) returns null as there is no previous row, and for the last row, LEAD(num) returns null as there is no next row.
The WHERE clause specifies a.num = a.prev and a.num = a.next, meaning both a.prev and a.next must have non-null values and be equal to a.num.
Since null = null is not true in SQL, the rows with null values in a.prev or a.next are effectively excluded by the WHERE clause. As a result, the query works as expected, checking for consecutive numbers without encountering issues related to null values in this specific context.

It's essential to be aware that the behavior might be different if you have specific requirements for how you want to handle null values in your comparison logic. If you want to include rows with null values in the comparison, you might need to modify the conditions accordingly.
*/

/* another query for the same problem */
select distinct a.num as  ConsecutiveNum
from (
select num, 
lag(num) over() as prev,
lead(num) over() as next
from a5) as a
where a.num = a.prev and a.num = a.next -- and a.prev is not null and a.next is not null
-------------------------------------------------------------------------------------------------------

--question 4 cross join--
create table a4 (
x int,
y int
)

insert into a4(x,y)
values
(-1,-1),
(0,0),
(-1,-2)

--cross join syntax--
select * from table_name as tab1
cross join table_name as tab2

select a.x,a.y,b.x,b.y,sqrt(pow((a.x-b.x),2)+pow((a.y-b.y),2)) as distance from a4 as a
cross join a4 as b
where a.x != b.x and a.y != b.y-- condition that points don't join with itself 
order by distance --sqrt(pow((a.x-b.x),2)+pow((a.y-b.y),2))
limit 1

/* it's a simple querry we did a cross join and made a condition that we don't join two same point with 
itself then we calculate the distance between point i.e math operation on columns and then do a order by 
and limit it to 1 */

-----------------------------------------------------------------------------------------------
--question 3 moving average 
create table customer(
customer_id integer,
name varchar(100),
visited_on timestamp,
amount integer
)

insert into customer(customer_id, name, visited_on, amount)
values
(1,'John','2019-01-01',100),
(2,'Daniel','2019-01-02',110),
(3,'Jade','2019-01-03',120),
(4,'Khaled','2019-01-04',130),
(5,'Winston','2019-01-05',110),
(6,'Elvis','2019-01-06',140),
(7,'Anna','2019-01-07',150),
(8,'Maria','2019-01-08',80),
(9,'Jaze','2019-01-09',110),
(1,'John','2019-01-10',130),
(3,'Jade','2019-01-10',150)

select * from customer

-- grouping by on date and creating a temporary 
create temporary table temp1 as  
select date(visited_on), sum(amount) as total_amount from customer 
group by visited_on
order by visited_on

select * from temp1

-- let's write a simple sql moving average query 
select date, total_amount,
sum(total_amount) over(rows between 6 preceding and current row)
from temp1

--now we have to do an offset as we have to calculate the moving avergae of 6 number 
select date,total_amount,
sum(total_amount) over(rows between 6 preceding and current row)
from temp1
offset 6 rows

-- now writing the query as per the question requirement
select date, total_amount, sum(total_amount) over(rows between 6 preceding and current row),
avg(total_amount) over (rows between 6 preceding and current row)-- avg(total_amount) is the agg function and rest is the syntax for moving average
from temp1
offset 6 rows
------------------------------------------------------------------------------------------
-- Qestion 2
create table emp(
id integer,
name varchar(100),
salary integer,
department integer
)

insert into emp(id, name, salary, department)
values
(1,'Joe',85000,1),
(2, 'Henry',80000,2),
(3,'Sam',60000,2),
(4,'Max',90000,1),
(5,'Janet',69000,1),
(6,'Randy',85000,1),
(7,'Will',70000,1)

select * from emp

create table depart(
	id integer,
	name varchar(100)
)

select * from depart

insert into depart(id, name)
values
(1,'IT'),
(2,'Sales')

select * from depart
select * from emp

create temporary table temp2 as 
select depart.name as Department,emp.name as employee,emp.salary from emp
inner join depart
on emp.department = depart.id
order by emp.id

select * from temp2


--this is a window function on the temporary table
select department,employee,salary, 
avg(salary) over (partition by department order by salary) as department 
from temp2

--dense rank--
select * from 
(select department,employee,salary,
dense_rank() over(PARTITION BY department order by salary desc) AS R 
from temp2) as a
where a.r < 3
----learn about cte ----