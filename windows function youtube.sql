--for reference watch the below youtube video 
--https://www.youtube.com/watch?v=S1do1EeA7ng 

/*Understanding windows function */

--creating table first
CREATE TABLE test_data(
new_id INTEGER,
new_cat VARCHAR(10)
)

SELECT * FROM test_data

--entering values into table 
INSERT INTO test_data(new_id,new_cat)
values
(100,'Agni'),
(200,'Agni'),
(500,'Dharti'),
(700,'Dharti'),
(200,'Vayu'),
(300,'vayu'),
(500,'vayu')
Returning *

Select * from test_data

/*Window function syntax
select col_names, function(on column) over (partition by col_name)
from table_name */

-- lets start with the aggregate funciton 

select new_id,new_cat,
sum(new_id) over(PARTITION BY  new_cat) as total
FROM test_data

select new_id,new_cat,
avg(new_id) over(PARTITION BY new_cat) as average
FROM test_data
--had entered Vayu insted of vayu
-- updating the values

UPDATE test_data
set new_cat = 'vayu'
where new_id = 200

-- oopsi it chaged the agni as well
-- lets delete it 
delete from test_data
where new_id = 200

select * from test_data

-- lets reenter the values in the table 
INSERT INTO test_data(new_id,new_cat)
VALUES
(200,'Agni'),
(200,'vayu')

select * from test_data

-- Now lets continute with our learing of windows function
select new_id,new_cat,
sum(new_id) OVER(PARTITION BY new_cat) as total
FROM test_data

select new_id,new_cat,
round(avg(new_id) over(partition by new_cat),2) as average
from test_data

select new_id,new_cat,
count(new_cat) over(partition by new_cat) as frequency_cat
from test_data

select new_id,new_cat,
count(new_id) over(partition by new_cat) as frequency_id
from test_data

select new_id,new_cat,
max(new_id) over(partition by new_cat)
from test_data

select new_id,new_cat,
min(new_id) over(partition by new_cat) 
from test_data

-- all together 
select new_id,new_cat,
sum(new_id) over(partition by new_cat) as Total_sum,
round(avg(new_id) over(partition by new_cat),2) as average_value,
count(new_id) over(partition by new_cat) as frequency,
max(new_id) over(partition by new_cat) as max_value,
min(new_id) over (partition by new_cat) as min_value
from test_data

-- lets move on 
/* remeber when you did total sum and it returned single row but what if you want to the total to 
be displayed with every row then you can use the following */

select new_id,new_cat,
sum(new_id) over(PARTITION BY new_cat ORDER BY new_id rows between UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
from test_data

select new_id,new_cat,
sum(new_id) over(order by new_cat rows between unbounded preceding and unbounded following)
from test_data

select new_id,new_cat,
sum(new_id) over(partition by new_cat)
from test_data

select new_id, new_cat,
sum(new_id) over(rows between unbounded preceding and unbounded following)
from test_data

select new_id,new_cat,
sum(new_id) over(rows between unbounded preceding and unbounded following)
from test_data 

select new_id, new_cat,
count(new_cat) over(rows between unbounded preceding and unbounded following)
from test_data

select new_id,new_cat,
round(avg(new_id) over(rows between unbounded preceding and unbounded following),2) as average
from test_data

select new_id,new_cat,
max(new_id) over(rows between unbounded preceding and unbounded following) as max_value
FROM test_data

Select new_id,new_cat,
min(new_id) over(rows between unbounded preceding and unbounded following)
from test_data

-- all together 
select new_id,new_cat,
sum(new_id) over(rows between unbounded preceding and unbounded following) as total,
round(avg(new_id) over(rows between unbounded preceding and unbounded following),2) as average,
count(new_id) over(rows between unbounded preceding and unbounded following) as frequency,
max(new_id) over(rows between unbounded preceding and unbounded following) as max_value,
min(new_id) over(rows between unbounded preceding and unbounded following) as min_value
from test_data

-- lets do row funcitons
/* lets understand the row_number first it basically gives serial no to set columns */

select new_id, new_cat,
row_number() over(order by new_id)
from test_data

select new_id, new_cat,
row_number() over(order by new_cat) as "serial_number"
from test_data

select new_id, new_cat,
rank() over(order by new_id) as "rank"
from test_data
/* as per what logic does rank is assigned and skipped in */
-- the no. of  skips is = freqency of value - 1
-- in above example 200 is 2 times so skips will be 2-1 = 1 so the next number is 4 and not three
-- had it been case like 200 200 200 than the frequency is 3 and skip would be 3 - 1 = 2

select new_id, new_cat,
dense_rank() over(order by new_cat) as "dense_rank"
from test_data

-- consider percent_rank as percentile and take anology of cat exam.
select new_id, new_cat,
percent_rank() over(order by new_id)
from test_data 

-- all the query at once
SELECT new_id,new_cat,
ROW_NUMBER() OVER(ORDER BY new_id) as "row_number",
RANK() OVER (ORDER BY new_id) as "rank",
DENSE_RANK() OVER(ORDER BY new_id) as "dense_rank",
PERCENT_RANK() OVER(ORDER BY new_id) as "percent_rank"
FROM test_data

/* LETS DO THE ANALYTICAL FUNCITONS NOW */
-- first value will give the first value of the selected column
-- last value is a bit tricky
SELECT new_id,new_cat,
FIRST_VALUE(new_id) OVER( ORDER BY new_id)
FROM test_data

SELECT new_id,new_cat,
FIRST_VALUE(new_id) OVER(PARTITION BY new_cat ORDER BY new_id)
FROM test_data

--this is tricky to get last value use rows between unbounded preceding and unbounded following 
select new_id,new_cat,
last_value(new_id) over(partition by new_id order by new_id) as "last value"
from test_data

select new_id,new_cat,
last_value(new_id) over(order by new_id rows between unbounded preceding and unbounded following)
from test_data

select new_id,new_cat,
lead(new_id) over(order by new_id) as "lead"
from test_data

SELECT new_id,new_cat,
lead(new_id) over(partition by new_cat order by new_id)
from test_data

-- note the lead and the lag aka hops can also be set 
select new_id, new_cat,
lead(new_id,2) over( order by new_id) as lead_hops 
from test_data