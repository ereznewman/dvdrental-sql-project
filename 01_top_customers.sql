-- Who are the top 10 customers by number of rentals?

SELECT customer.customer_id,customer.first_name,customer.last_name,COUNT(*) AS total_rentals FROM customer
INNER JOIN rental ON
customer.customer_id=rental.customer_id
GROUP BY customer.first_name,customer.last_name,customer.customer_id
ORDER BY total_rentals desc
LIMIT 10; 


-- Top 10 customers by total payments 

SELECT customer.customer_id,customer.first_name,customer.last_name,SUM(amount) AS total_amount FROM customer
INNER JOIN payment ON
customer.customer_id=payment.customer_id
GROUP BY customer.first_name,customer.last_name,customer.customer_id
ORDER BY total_amount desc
LIMIT 10; 

-- What’s the average payment per rental for each customer?

SELECT customer.customer_id,customer.first_name,customer.last_name,ROUND(SUM(payment.amount)::numeric / COUNT(DISTINCT rental.rental_id),2) 
AS average_pay_per_rental FROM payment
INNER JOIN rental ON payment.rental_id=rental.rental_id
INNER JOIN customer ON customer.customer_id=payment.customer_id
GROUP BY customer.first_name,customer.last_name,customer.customer_id
ORDER BY average_pay_per_rental desc;

-- Which customers have rented more than 40 films?

SELECT customer.first_name,customer.last_name,COUNT(DISTINCT film.film_id) AS films FROM customer
INNER JOIN rental ON customer.customer_id=rental.customer_id
INNER JOIN inventory ON inventory.inventory_id=rental.inventory_id
INNER JOIN film ON inventory.film_id=film.film_id
GROUP BY customer.customer_id,customer.first_name,customer.last_name
HAVING COUNT(DISTINCT film.film_id)>40
ORDER BY films desc;

-- Categorize customers as 'High', 'Medium', or 'Low' spenders 

SELECT 
customer.customer_id,
customer.first_name,
customer.last_name,
SUM(amount) AS total_payment,
CASE
    WHEN SUM(amount) > 150 THEN 'High'
    WHEN SUM(amount) BETWEEN 50 AND 150 THEN 'Medium'
    ELSE 'Low'
  END AS spender_category 
FROM customer
INNER JOIN payment ON
customer.customer_id=payment.customer_id
GROUP BY customer.first_name,customer.last_name,customer.customer_id
ORDER by total_payment DESC;


