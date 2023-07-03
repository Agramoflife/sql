 /* SELECT */
/* Basic Syntax for SELECT Statement
   SELECT column_name FROM table_name */
SELECT first_name FROM actor 

SELECT first_name, last_name FROM actor 

SELECT last_name, first_name FROM actor 

/* To select all the columns from a table
   SELECT * FROM Table_name */
SELECT * FROM actor 

/* DISTINCT */
/* Basic Syntax for DISTINCT Statement
   SELECT DISTINCT column_name FROM table_name */
SELECT * FROM film

SELECT DISTINCT release_year FROM film

SELECT DISTINCT(release_year) FROM film

SELECT DISTINCT rental_rate FROM film

/* COUNT */
/* Basic Syntax for COUNT Statement
   SELECT COUNT(column_name) FROM table_name */
/* COUNT is verry useful when combined with DISTINCT 
   SELECT COUNT(DISTNCT column_name) FROM table_name */
SELECT * FROM payment

SELECT COUNT(*) FROM payment

SELECT amount FROM payment

SELECT DISTINCT amount FROM payment

SELECT COUNT(DISTINCT amount) FROM payment

/* WHERE */
/* Basic syntax for WHERE Statement
   SELECT column 1, column 2
   FROM table
   WHERE conditions */
   
SELECT * FROM customer

SELECT * FROM customer
WHERE first_name = 'Jared'

SELECT * FROM film
WHERE rental_rate > 4 AND replacement_cost >= 19.99
AND rating = 'R'

SELECT COUNT(*) FROM film
WHERE rental_rate > 4 AND replacement_cost >= 19.99
AND rating = 'R'

SELECT * FROM film
WHERE rating = 'R' OR rating = 'PG-13'


SELECT * FROM film
WHERE rating != 'R'

/* ORDER BY */
/* Basic Syntax for ORDER BY Statement
   SELECT column 1, column 2
   FROM table
   ORDER BY column 1 ASC/DESC */

SELECT * FROM customer
ORDER BY first_name

SELECT store_id,first_name,last_name FROM customer
ORDER BY store_id

SELECT store_id,first_name,last_name FROM customer
ORDER BY store_id,first_name

SELECT store_id,first_name,last_name FROM customer
ORDER BY store_id DESC,first_name ASC

/* LIMIT */
/* Basic Syntax for LIMIT Statement
   SELECT column 1 
   FROM table
   ORDER BY column 2 
   LIMIT n */

SELECT * FROM payment
LIMIT 1

SELECT * FROM payment
WHERE amount != 0
ORDER BY payment_date DESC
LIMIT 5

/* BETWEEN */
SELECT * FROM payment
WHERE amount BETWEEN 8 and 9

SELECT * FROM payment
WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-15'

SELECT * FROM payment
WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-14'

/* IN */
/* Basic syntax of IN Statement
   SELECT column 1 
   FROM table
   WHERE column 1 IN (value 1, value 2) */
   
SELECT * FROM payment

SELECT DISTINCT amount FROM payment
ORDER BY amount

SELECT * FROM payment
WHERE amount IN(0.99,1.99,1.98)

SELECT * FROM customer
WHERE first_name IN('John','Jake','Julie')
=============================================================================
=============================================================================
/*Practice*/

/* SELECT */
/* Basic Syntax for SELECT Statement
   SELECT column_name FROM table_name */
SELECT * FROM actor
SELECT first_name FROM actor
SELECT first_name, last_name FROM actor
SELECT last_name,first_name FROM actor

/* To select all the columns from a table
   SELECT * FROM Table_name */
SELECT * FROM payment
SELECT * FROM film

/* DISTINCT */
/* Basic Syntax for DISTINCT Statement
   SELECT DISTINCT column_name FROM table_name */
SELECT DISTINCT rental_rate FROM film
SELECT DISTINCT(language_id) From film
SELECT DISTINCT (rating) FROM film

/* Basic Syntax for COUNT Statement
   SELECT COUNT(column_name) FROM table_name */
/* COUNT is verry useful when combined with DISTINCT 
   SELECT COUNT(DISTNCT column_name) FROM table_name */
SELECT * FROM film
SELECT COUNT(*) FROM film
SELECT rating FROM film
SELECT DISTINCT(rating) FROM film
SELECT COUNT(DISTINCT(rating)) FROM film

/* WHERE */
/* Basic syntax for WHERE Statement
   SELECT column 1, column 2
   FROM table
   WHERE conditions */
SELECT * FROM actor
WHERE first_name = 'Nick'

SELECT title, rental_rate, rating, replacement_cost FROM film
WHERE rental_rate > 4 AND rating = 'R' or rating = 'PG' AND replacement_cost > 19
/* here the replacement column filter is not working */

SELECT title, rental_rate, rating, replacement_cost FROM film 
WHERE rental_rate > 4 AND (rating = 'R' or rating = 'PG') AND replacement_cost > 19
/* Now it works so if you are using 'or' make sure you put it into parenthesis */

Select count(*) FROM film
WHERE rental_rate > 4 AND (rating = 'R' or rating = 'PG') AND replacement_cost > 19

SELECT title,rating FROM film
WHERE rating = 'R' or rating = 'PG'
SELECT title,rating FROM film 
WHERE (rating != 'R' or rating != 'PG') /* this does not make sense*/
SELECT 	title, rating FROM film 
WHERE rating != 'R' AND rating != 'PG' /* this make sense and it works like a charm
*/

/* ORDER BY */
/* Basic Syntax for ORDER BY Statement
   SELECT column 1, column 2
   FROM table
   ORDER BY column 1 ASC/DESC */

SELECT * FROM customer 
ORDER BY last_name asc
SELECT store_id, first_name,last_name FROM customer 
ORDER BY store_id DESC, first_name ASC /* if you are doing to order by make sure 
one of them is categorical column */
SELECT store_id,first_name, last_name FROM customer
ORDER BY store_id,first_name /* by default it takes ascending */
SELECT store_id,first_name,last_name FROM customer
ORDER BY store_id ASC, first_name DESC

/* LIMIT */
/* Basic Syntax for LIMIT Statement
   SELECT column 1 
   FROM table
   ORDER BY column 2 
   LIMIT n */

SELECT * FROM payment 
LIMIT 5
SELECT first_name FROM actor 
ORDER BY first_name DESC
LIMIT 5
SELECT * FROM payment 
WHERE amount > 5
ORDER BY amount ASC
LIMIT 10

/* BETWEEN */
SELECT * FROM payment
WHERE amount BETWEEN 8 and 9
SELECT title, rental_rate FROM film 
WHERE rental_rate BETWEEN 0 and 4
/* below query is very imortant in terms of understanding the inclusive property*/
SELECT distinct(date(payment_date)) FROM payment 
WHERE DATE(payment_date) BETWEEN '2007-02-15' and '2007-02-21'
/* both the upper bound and lower bound date are included here */
/* TRY removeing the date , it you remove the DATE then end point is exclusive */

SELECT distinct(date(payment_date)) FROM payment 
WHERE date(payment_date) BETWEEN '2007-02-15' AND '2007-02-21'
/* when using date in the where clause upper bound and lower bound are inclusive */

SELECT distinct(date(payment_date)) FROM payment
WHERE payment_date BETWEEN '2007-02-15' AND '2007-02-21'
/* when not using date after where the upperbound is exclusive and lower bound is 
inclusive*/

SELECT * FROM payment
WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-15'
/* not used date hence upper bound will be excluded*/

SELECT * FROM payment
WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-14'
/* Not used date hence 14 will not be included */

SELECT * FROM payment 
WHERE DATE(payment_date) BETWEEN '2007-02-01' AND '2007-02-14'
/* included date hence 14 will be included */

/* IN */
/* Basic syntax of IN Statement
   SELECT column 1 
   FROM table
   WHERE column 1 IN (value 1, value 2) */
   
/* I belive the this will have usecase mostly in strings*/
SELECT amount FROM payment 
group by amount /* basically a piviot */
order by amount

SELECT * FROM payment 
WHERE amount in (0,0.99,1.98,2.99,3.98)
ORDER BY amount DESC

SELECT * FROM customer
WHERE first_name in ('Jared','Mary','Patricia')



