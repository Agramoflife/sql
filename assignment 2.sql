/* Question 1 : Return the customer IDs of customers who have spent at least $110
with the staff member who has an ID of 2. */
SELECT * FROM customer
SELECT * FROM payment

SELECT customer.customer_id,amount,staff_id FROM customer
FULL OUTER JOIN payment
ON customer.customer_id = payment.customer_id
HAVING staff_id like = 2

SELECT customer_id,staff_id,sum(amount) FROM payment 
WHERE staff_id = 1
GROUP BY customer_id, staff_id
HAVING sum(amount) >= 110 

SELECT customer_id,staff_id,sum(amount) FROM payment 
GROUP BY customer_id,staff_id
HAVING sum(amount) >= 110 and staff_id = 1

/*Question 2 : How many films begin with the letter J? */

SELECT COUNT(title) as Count_of_movie_starting_with_J FROM film
WHERE title LIKE 'J%'

/* Question 3 : What customer has the highest customer ID number whose name starts
with an 'E' and has an address ID lower than 500? */
select * from customer 
WHERE first_name like 'E%' and address_id < 500
ORDER BY customer_id DESC
limit 1