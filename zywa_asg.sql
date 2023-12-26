/*going through the data*/
select * from Transactions
--------------------------------------------------------------------------------------------------------------------
/* question 1.How much amount we have processed each month commutative and every month.*/
/*Answer we will do a group by on months with sum on billing_amount and make that a cte and then we will querry that table
use a window function, i.e over () with order by to get the cummulative sum */

WITH myCTE AS (
    SELECT
        EXTRACT(MONTH FROM TO_TIMESTAMP(transaction_timestamp, 'MM/DD/YY HH24:MI')) AS months,
        SUM(billing_amount) AS monthly_sales
    FROM
        transactions
    GROUP BY
        months
    ORDER BY
        months
)

SELECT
    months,
    monthly_sales,
    SUM(monthly_sales) OVER (ORDER BY months) AS monthly_cumulative_sales
FROM
    myCTE;

----------------------------------------------------------------------------------------------------------------------------------
/* question 2 : Design a SQL query to identify the top 5 most popular products or services based on transaction counts.
   Answer: Since we will have a set of merchant values we will apply group by and use agg funciton as count on transcatiosn
   then we will do a order by on the counted transaction and limit it by 5
*/

SELECT
    merchant_type AS popular_product_or_service,
    COUNT(billing_amount) AS total_purchases
FROM
    transactions
--WHERE
    -- Uncomment and modify the WHERE clause if needed
    -- (merchant_type ILIKE '%Products' OR merchant_type ILIKE '%Services')
GROUP BY
    popular_product_or_service
ORDER BY
    total_purchases DESC
LIMIT
    5;

---------------------------------------------------------------------------------------------------------------------
/* Question 3.Formulate a SQL query to visualize the daily revenue trend over time 
   Answer: Since we can have multiple transaction on single day we will group by on the date and 
   use agg function sum on the billing amount
*/


SELECT
    DATE(TO_TIMESTAMP(transaction_timestamp, 'MM/DD/YY')) AS purchase_date,
    SUM(billing_amount) AS daily_sales
FROM
    transactions
GROUP BY
    DATE(TO_TIMESTAMP(transaction_timestamp, 'MM/DD/YY'))
ORDER BY
    purchase_date;
----------------------------------------------------------------------------------------------------------------------
/* Question 4: Formulate a SQL query to find the average transaction amount for each product category 
   Answer: We will have set of product we will group by and then use avg agg function on billing amunt 
   and round it to 2 places
*/

SELECT
    merchant_type,
    ROUND(AVG(billing_amount), 2) AS average_transaction
FROM
    transactions
--WHERE
    -- Uncomment and modify the WHERE clause if needed
    -- (merchant_type ILIKE '%Products')
GROUP BY
    merchant_type;


-------------------------------------------------------------------------------------------------------------------------------
/* question 5: Create a SQL query to analyze the transaction funnel, including completed, pending, and cancelled transactions.
   Answer : a simple group by and sum 
*/

SELECT
    transaction_type,
    SUM(billing_amount) AS total_billing_amount
FROM
    transactions
GROUP BY
    transaction_type;

----------------------------------------------------------------------------------------------------------------------------------
/* question 6: Design a SQL query to calculate the Monthly Retention Rate, grouping users into monthly cohorts.
Answer: 
1.we will first find users who have visited the very first time 
2.Then we will find useres who have visited in the entire time period that includes a user visiting first time and again and again
3.THen we will subtract the first time and all time visit to find the relative visit i.e if I visit in second month
then second month will be my reference month and that will be my 0 month if I visit again in 3 month it will be
month1 with my reference month 
4.Then we will sum the every users visits in month0,month1,month2 and finally calculate the retention rate */



/* Since we will be working on Purchase_timestamp lets create a new date column which will have datetimestamp data type */

ALTER TABLE transactions
ADD date TIMESTAMP;

UPDATE transactions
SET date = TO_TIMESTAMP(transaction_timestamp, 'MM/DD/YY HH24:MI');
select date from transactions

--let's rename the date to Purchase_date to algin with the dataset feilds terminology

ALTER TABLE transactions
RENAME COLUMN date TO Purchase_date;

-----------
/*let's start */

select * from transactions 

--finding the users who visitd the very first time 

create temporary table first_visit as
select user_id, min(date_part('month',Purchase_date)) as first_month from transactions
group by user_id 
order by user_id

select * from first_visit

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

select * from final_table

---- finding the retetion of the usere


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
/* further analysis on the problem this time we will do week on week */

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



