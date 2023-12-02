/* EXISTS OPERATOR IN POSTGRESQL */


/* consider exists are as boolean if the subquery is True you the parent query will give result
but if its not then it will give nothing see the below querry */
SELECT * FROM customer
WHERE EXISTS
(SELECT first_name FROM customer
WHERE first_name = 'DEEPU') -- the subquery is false

SELECT * FROM customer
WHERE EXISTS 
(SELECT first_name FROM customer
WHERE first_name = 'Jared') -- subquery is TRUE

/* in another use case of the exist command we can use it to match different column values from one table to
different column value form the other table if there is a match the condition will be true and the parent 
querry will be executed like in case bellow
*/
SELECT * FROM customer
SELECT * FROM rental
SELECT * FROM film

SELECT first_name, last_name FROM customer -- table used is customer in parent query 
WHERE EXISTS
(SELECT * FROM film -- table used is film in subquery
WHERE film.film_id = customer.customer_id) -- two different columns used are film_id form film and customer_id
-- from customer table 
-- note that any of the table don't have the both column that is film has only film_id but not customer_id and
-- vise verca 

select film_id from film
select customer_id from customer
SELECT first_name, last_name FROM customer
WHERE EXISTS 
(SELECT * FROM customer
WHERE customer.customer_id = film.film_id) -- this will give error so you cannot have random table 
-- note in the above querry we used 2 different tables in the FROM CLAUSE