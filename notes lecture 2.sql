/* LIKE and ILIKE
syntax 
SELECT column_name FROM Table 
WHERE column_name LIKE/ILIKE 'A'
wild characters '%' ,'_'
'%' any characters
'_' one characters
The main difference between like and ilike is like is case sensetive and ilike is case insensitive*/

/* '%' and like/ilike */
SELECT first_name FROM customer
WHERE first_name LIKE 'J%'
/* The above line of code menas get me all the names that start with J and have any charters after J it can have 1,2,3,n
etc I don't mind */

SELECT last_name FROM customer 
WHERE last_name LIKE '%a'
/* Get me last_name that ends with a and has any number of 
characters to its prefix */
SELECT first_name FROM customer
WHERE email LIKE '%@sakilacustomer.org'
/* Get me first name of customer who have n characters in pre-fix but end with a string @sakilacustomer.org, so you are not
only limited to leters, you can us combinatin of characters */
/* hence % means match any number of characters */

SELECT first_name FROM customer 
WHERE first_name ILIKE 'j%'
/* it is kind of same command like LIKE only difference is it takes J and j both in consideration */

SELECT first_name FROM customer 
WHERE email ILIKE '%@SAkILaCUSTomer.ORG'
/* See ILIKE is case insensitive */

/* '_' and LIKE/ILIKE */
SELECT first_name FROM customer 
WHERE first_name Like 'J_'
/* Get me the name of guy from customer table whose name start from J and has only one character after J that mean there are 
only two letters in his name */
SELECT first_name FROM customer 
WHERE first_name LIKE 'J____'
/* Name with 5 letters and first letter should be J */

SELECT first_name FROM customer 
WHERE first_name ILIKE 'j_'
SELECT first_name FROM customer 
WHERE first_name ILIKE 'j____'
/* They run the same like LIKE only differnece is they are 
case insensitive */

/* % and _ LIKE/ILIKE */
SELECT first_name FROM customer 
WHERE first_name LIKE '_ul%'
/* get me names where 2nd and 3rd letters should be ul and they should be at index 1,2(python index) follwed by any
leng of characters */

SELECT first_name from customer 
WHERE first_name ILIKE '%z%'
/* get me a name which has z at position anywhere in the name
*/


/* aggregate function */
/* syntax 
SELECT agg_function (column_name) FROM table_name
*/
SELECT * FROM payment
SELECT avg (amount) FROM payment
SELECT MAX (amount), MIN (amount) FROM payment
SELECT AVG (amount), MIN ( amount), MAX (amount) FROM payment
SELECT ROUND(AVG(amount), 2) FROM payment 
/* To get avg amount upto 2 decimal places we use round */
SELECT SUM(amount) FROM payment

/* here is how you can calculate no. of rows */
SELECT SUM(replacement_cost)/AVG(replacement_cost) FROM film
/* lets cross check */
SELECT COUNT(replacement_cost) FROM film /*gives no. of rows*/


/* GROUP BY is same as pivots in excels
syntax - SELECT column_name FROM table_name
		 GROUP BY (column_name) */
		 
SELECT * FROM payment
SELECT staff_id, sum(amount) from payment 
GROUP BY (staff_id)

/* group by syntax re
SELECT categorical_column_name , AVG(data_column_name to aplly stats function) FROM table 
GROUP BY (categorical_column_name to group by) */

SELECT staff_id, SUM(amount) FROM payment 
GROUP BY (staff_id)

SELECT DATE(payment_date) FROM payment /* we are slicing only date form payment_date */ 

SELECT DATE(payment_date), AVG(amount) FROM payment 
GROUP BY DATE(payment_date)
ORDER BY AVG(amount)
/* IT WORKS LIKE PIVOT SO IF YOU HAVE TO SORT THE NAME OF THE DATA_COLUMN IS CHANGED
DUE TO GROUP BY SO YOU WILL HAVE TO ORDER BY TO THE NEW COLUMN I.E AVG(AMOUNT) */

SELECT customer_id, ROUND(AVG(amount),2) FROM payment
GROUP BY customer_id
ORDER BY AVG(amount) DESC

SELECT customer_id, ROUND(count(amount),2) FROM payment 
GROUP BY customer_id 
 
/*We can also chose the groupby values */
SELECT customer_id, avg(amount) FROM payment 
WHERE customer_id IN (87,51,59)
GROUP BY customer_id

/*Having - this is used after you have done group by only
consider this as the filters which you apply after creating 
a pivot table llly having is after group by */

/* having clause is used on the aggregated columns only and i.e the columns with the statistic functions imparted on it */

SELECT customer_id, SUM(amount) FROM payment
WHERE customer_id IN (184,87,477)
GROUP BY customer_id

SELECT customer_id, SUM(amount) FROM payment
GROUP BY customer_id
HAVING SUM(amount) >19

SELECT store_id, COUNT(customer_id) FROM customer
GROUP BY store_id
HAVING COUNT(customer_id) < 300

/* As is used as an alias for columns in sql, here is a 
funny thing about AS though is it executed at last in sql
just like you can name the pivol column at last, the satement 
is passed at the very begining of sql querry i.e in the select 
line, it can be used after having 
syntax is select avg(column_name) as new_col_name from table*/

SELECT AVG(amount) AS average_amount FROM payment

SELECT customer_id, avg(amount) as average_amount  FROM payment 
GROUP BY customer_id
order by avg(amount) DESC

SELECT * FROM payment

SELECT customer_id, avg(amount) as average_amount  FROM payment
WHERE customer_id > 350 /* ERROR BECAUSE YOU WERE DOING SORTING BEFORE PIVOT*/
ORDER BY customer_id /* SORTING IS DONE AFTER PIVOT BY USIGN HAVING CLAUSE */

SELECT customer_id, round(avg(amount),2) as average_amount FROM payment 
GROUP BY customer_id
HAVING customer_id > 350
ORDER BY avg(amount) DESC /* Note the column name in the order by */

/* Inner join 
syntax 
SELECT * FROM talbe_a
INNER JOIN table_b
on TableA.col_match = table_b.col_match
*/

SELECT * FROM payment 
INNER JOIN customer
ON payment.customer_id = customer.customer_id /* A very important thing to note here is that
when you do an inner join in sql the common column is included twice unlike pandas join */
SELECT * FROM payment 
SELECT * FROM customer

/* lets pick columns and not every thing */
SELECT payment_id,payment.customer_id,first_name FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id
/* So i was having confusion that if we are taking columns from both the tables than what sud
we write in the from clause I asked this to chat gpt and it says does not matter from what 
tables you take column, weather from tabe_1 or table_2 or both table_1 and table_2 you always 
write table 1
syntax 
SELECT column1_table1, column2_table1, column1_table2, column2_table2
FROM table1
JOIN table2
ON table1.column_name = table2.column_name;

Yes, that's correct. In the FROM clause, you will always specify the first table (let's call it
table_1), and then you can use an INNER JOIN clause to join it with another table (table_2).
In the SELECT clause, you can specify the columns you want to pick from both tables. The 
syntax would look like this: */

/* FULL OUTTER JOIN */
/* Syntax is same as the inner join 
SELECT * FORM table_a
FULL OUTER JOIN table_b
ON table_a.col_match = table_b.col_match
*/
SELECT * FROM payment 
FULL OUTER JOIN customer
ON payment.customer_id = customer.customer_id

/* being scrupulous here */
SELECT payment_id,payment.customer_id,first_name FROM customer /*From table has to be different */
FULL OUTER JOIN payment /* table here has to be different */
ON payment.customer_id = customer.customer_id

/* Full outer join with where 
lets just say we want colmns in both the tables which are exclusive to respective tables */

SELECT * FROM customer 
FULL OUTER JOIN payment 
ON payment.customer_id = customer.customer_id
WHERE payment.customer_id IS null /* make sense here */ 

/* Try to understand the below querry they are very crucial 
for developing the understanding of how to think logically*/
SELECT * FROM customer 
FUll OUTER JOIN payment 
ON payment.customer_id = customer.customer_id
WHERE payment.customer_id IS NULL OR first_name IS NULL

SELECT * FROM customer /* add count prefix to * to get count of table */
FULL OUTER JOIN payment 
ON payment.customer_id = customer.customer_id
WHERE payment.customer_id IS NULL OR payment_id IS NULL
/* we have payment_id in payment table and customer_id in 
customer table */

SELECT COUNT(*) FROM payment 
SELECT COUNT(*) FROM customer

SELECT DISTINCT COUNT(customer_id) FROM payment /* QUREYED WRONG */
SELECT DISTINCT COUNT(customer_id) FROM customer

/* so if you have join where i.e distinct of outer join is zero 
this is what it means i.e there is no uniuqe feild values in here 
which means number of feild values in both the table is same */
SELECT COUNT (DISTINCT customer_id) FROM payment
SELECT COUNT (DISTINCT customer_id) FROM payment

/* LEFT JOIN 
Synatx 
SELECT * FROM table_a
LEFT JOIN table_b
ON table_a.match_col = table_b.match_col
*/

SELECT * FROM film
LEFT JOIN inventory
ON film.film_id = inventory.film_id

/* bieng scruplous again here */
SELECT film, title, inventory_id,store_id FROM film
LEFT JOIN inventory
ON inventory.film_id = film.film_id

/* left join with where 
left outer join */

SELECT film.film_id,title,inventory_id,store_id FROM film
LEFT JOIN inventory
ON inventory.film_id = film.film_id
WHERE inventory.film_id is NULL