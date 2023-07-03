/* Self join */
SELECT * FROM actor as X
INNER JOIN actor as Y
ON X.first_name = Y.first_name

SELECT * FROM film

SELECT tabA.title,tabB.title,tabA.length,tabB.length, tabA.film_id,tabB.film_id FROM film as tabA
INNER JOIN film AS tabB
ON tabA.film_id != tabB.film_id /* running query till here will create a ordered cartisan product*/ 
AND tabA.length = tabB.length
/* lets understand what is happening here 
we are doing a self join, for that you will have to put alias to table and do innerjoin 
Now the ON tabA.film_id = tabB.film_id is important as this is basically doing self join 
with coloumn in tabA which are not equal to tabB.length
 try understanding it with the concept of cartisan product and subset concept */
SELECT customer_id,
CASE 
	WHEN (customer_id<=100) THEN 'PREMIUM'
	ELSE 'NORMAL'
END
FROM customer

SELECT customer_id,
CASE
	WHEN customer_id <= 100 THEN 'premium'
	WHEN customer_id BETWEEN 101 AND 200 THEN 'Normal'
	ELSE 'New customer'
END
FROM customer

