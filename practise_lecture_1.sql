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

/*self parctised*/
select * from payment 
select amount from payment 
select count(*) from payment
select count(amount) from payment 
select distinct(amount) from payment
select count (distinct(amount)) from payment
select count (distinct amount) from payment
select * from customer 
select first_name from customer 
where first_name ='Linda'
Select * from customer 
where first_name='Linda'
select distinct(activebool) from customer
select count (distinct activebool) from customer
select count(activebool) from customer
select * from customer
select count(*) from customer 
select * from film
select * from film 
SELECT * FROM film
WHERE rental_rate > 4 AND replacement_cost >= 19.99
AND rating = 'R'
select * from film 
where rental_rate > 2 and replacement_cost > 13 
and rating = 'R' 

-----------------------------------------------------------------------------
PRACTICE -1
_____________________________________________________________________________

/* Practice 1 date - 3/2/2023 */

/* Select querry */
SELECT first_name FROM actor
SELECT first_name,last_name FROM actor
SELECT last_name,first_name FROM actor
SELECT last_update FROM actor
SELECT COUNT(last_update) From actor

/* Distinct query */
SELECT * FROM film
SELECT COUNT (*) FROM film
SELECT DISTINCT (release_year) FROM film
SELECT DISTINCT release_year FROM film
SELECT DISTINCT rental_duration FROM film
SELECT DISTINCT (rating) FROM film

/* Count query */
SELECT * FROM payment
SELECT COUNT (*) FROM payment 
SELECT COUNT(amount) FROM payment 
SELECT COUNT (DISTINCT amount) FROM payment
SELECT DISTINCT amount FROM payment
SELECT amount FROM payment

/*where query */
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
/* Practice continued */

/* Select querry , syntax is select column_name from table */
SELECT * FROM customer
SELECT first_name FROM customer 
SELECT first_name, last_name FROM customer
SELECT last_name, First_name FROM customer

/* select * querry */
SELECT * FROM film
SELECT * FROM store

/* distinct 1uerry */
SELECT * FROM actor
SELECT * FROM film
SELECT DISTINCT release_year FROM film
SELECT DISTINCT (rating) FROM film
SELECT DISTINCT rating FROM film
SELECT DISTINCT rental_rate FROM film

/* count */
SELECT  COUNT * FROM actor /* without () it does not work */
SELECT COUNT (*) FROM actor /* this one works */
SELECT * FROM actor
SELECT COUNT (DISTINCT last_name) FROM actor
SELECT COUNT(last_name) FROM actor
SELECT last_name FROM actor

/* WHERE */
SELECT * FROM actor
SELECT first_name, last_name FROM actor /* selecting first & last name */
where first_name = 'Johnny'
SELECT * FROM customer /* will get all his columns */
WHERE first_name = 'Jared'
SELECT * FROM customer
WHERE first_name = "Jared" /* double quote does not work */
SELECT * FROM film
SELECT title FROM film
WHERE rental_rate = 4.99
SELECT COUNT(title) FROM film
where rental_rate >= 4.99
SELECT title, rental_rate FROM film
WHERE rental_rate < 4.99
SELECT COUNT(title) from film
WHERE rental_rate < 4.99
SELECT * FROM film
WHERE rating = 'R' OR rating = 'PG'
SELECT title FROM film
WHERE rating = 'R' or rating = 'PG'
SELECT COUNT(title) FROM film
WHERE rating = 'R' or rating = 'PG'
SELECT * FROM film
Where rental_duration >= 4 AND length > 90 AND rating = 'R'
SELECT COUNT(*) FROM film
where rental_duration >= 4 AND length > 90 AND rating = 'R'
SELECT * FROM film 
WHERE rating != 'R' AND rating != 'PG' /* The OR will still give PG field 
but AND is not giving PG field values */
SELECT COUNT(*) FROM film
WHERE rating != 'R' AND rating != 'PG'
SELECT COUNT(*) FROM film 
WHERE rating != 'R' OR rating != 'PG' /* absurd querry */
SELECT * FROM actor
ORDER BY first_name
SELECT * FROM actor 
ORDER BY first_name ASC
SELECT * FROM actor 
ORDER BY first_name DESC
SELECT store_id, first_name, last_name FROM customer 
ORDER BY store_id ASC
SELECT store_id, first_name, last_name FROM customer 
ORDER BY store_id ASC, first_name DESC 
SELECT * FROM customer 
ORDER BY store_id , first_name /* by default will take ascending for both */
SELECT * FROM payment
LIMIT 5
SELECT * FROM payment 
WHERE amount >= 4 AND staff_id = 1
ORDER BY amount ASC
LIMIT 5
SELECT * FROM payment 
WHERE amount != 0
ORDER BY amount ASC, staff_id DESC
LIMIT 4

SELECT amount FROM payment 
BETWEEN 1 AND 6 /* BETWEEN works with combination with  where only */
SELECT amount FROM payment 
WHERE amount BETWEEN 1 AND 6 /* works like a charm here */
/* mainly works with int and float */
SELECT * FROM customer 
WHERE address_id BETWEEN 5 AND 10 /* both limits are inclusive */
ORDER BY store_id ASC
SELECT amount from payment
WHERE payment_date BETWEEN 2007-02-15 AND 2007-02-17 /* error because date
has to be inside '' */
SELECT * FROM payment
WHERE payment_date BETWEEN '2007-02-15' AND '2007-02-17'
ORDER BY payment_date ASC
SELECT * FROM payment 
where payment_date = '2007-02-17' /* The reson it did not work is because it
is date which is a part of datetime stamp, to use where we need entire feild
value */
SELECT first_name FROM customer
WHERE first_name = 'J' /* this is what has happened above */
/* in date the first date in inclusive and the last date is exclusive but in
the amount 'where amount between x and y' both x and y are inclusive 
The between is basically for int/float feild types what if you want to find 
string that short comming is filled bu in command */
SELECT * FROM customer
where first_name in ('Jared','Linda','Sandra')
SELECT * FROM film
WHERE rating IN('R','PG-13','PG')
/* we can also do it for int/float, suppose you want to find in certain 
amount is present or not */
SELECT * FROM film
Where replacement_cost IN (11.99,15.99,28.99) /* will have all the filed 
values which are in the tuple */
SELECT * FROM film 
WHERE rental_duration IN (3,4,5)
ORDER BY rental_duration


