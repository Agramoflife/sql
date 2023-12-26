/* Since we will be working on Purchase_timestamp lets create a new date column which will have datetimestamp data type */
ALTER TABLE transactions
ADD date TIMESTAMP;

UPDATE transactions
SET date = TO_TIMESTAMP(transaction_timestamp, 'MM/DD/YY HH24:MI');
select date from transactions

--let's rename the date to Purchase_date to algin with the dataset feilds terminology
ALTER TABLE transactions
RENAME COLUMN date TO Purchase_date;

----------------------------------------------------------------------------------------------------------
/*queston 6 customer retention month on month */

select * from transactions 

--finding the users who visitd the very first time 

create temporary table first_visit as
select user_id, min(date_part('month',Purchase_date)) as first_month from transactions
group by user_id 
order by user_id

---finding all the visits of the users

create temporary table all_visits as
select user_id,date_part('month',Purchase_date) as visits_all_months from transactions
group by user_id,visits_all_months
order by user_id,visits_all_months
select * from all_visits

---- find all the months visited by a particular user retative to it's first visit

create temporary table final_table as
select first_visit.user_id,first_month,visits_all_months, (visits_all_months - first_month) as relative_month from all_visits 
join first_visit
on all_visits.user_id = first_visit.user_id 

---- finding the retetion of the usere

select * from final_table

create temporary table results_table as(
select first_month,
sum(case when relative_month = 0 then 1 else 0 end ) as month0,
sum(case when relative_month = 1 then 1 else 0 end ) as month1,
sum(case when relative_month = 2 then 1 else 0 end ) as month2
from final_table
group by first_month
order by first_month
)

select * from results_table 


-----calcuate the retention percentage 

select first_month,
to_char((month0::float / month0::float) * 100 ,'999.99') as month0_retention,
to_char((month1::float / month0::float) * 100 ,'999.99') as month1_retention,
to_char((month2::float / month0::float) * 100 ,'999.99') as month2_retention
from results_table

----------------------------------------------------------------------------------------
/* further analysis on the problem this time we will week on week */

-- let's further analysis if we are able to retain users week wise 

-- Create a temporary table to store the first visit month for each user

CREATE TEMPORARY TABLE first_visit_weekwise AS
SELECT
    user_id,
    MIN(DATE_PART('week', Purchase_date)) AS first_week
FROM
    transactions
GROUP BY
    user_id
ORDER BY
    user_id;

-- Find all the visits of the users
CREATE TEMPORARY TABLE all_visits_weekwise AS
SELECT
    user_id,
    DATE_PART('week', Purchase_date) AS visits_all_weeks
FROM
    transactions
GROUP BY
    user_id, visits_all_weeks
ORDER BY
    user_id, visits_all_weeks;

-- Find all the weeks visited by a particular user relative to its first visit
CREATE TEMPORARY TABLE final_table_weekwise AS
SELECT
    first_visit_weekwise.user_id,
    first_week,
    visits_all_weeks,
    (visits_all_weeks - first_week) AS relative_week
FROM
    first_visit_weekwise
JOIN 
     all_visits_weekwise ON all_visits_weekwise.user_id = first_visit_weekwise.user_id;

------ let's see if we have any relative visit ( a relative visit is if I visit in 2nd month then it will be my refference week i.e week0) 

select * from final_table_weekwise
order by relative_week desc

-- since there is no repeat customer i.e we don't have a retention of custumer even if we consider weekwise 
--hence we stop here


