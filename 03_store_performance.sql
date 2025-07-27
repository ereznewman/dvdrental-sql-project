--Which store has the highest total revenue?

SELECT store.store_id,SUM(amount) AS total_revenue FROM store
INNER JOIN staff ON staff.store_id=store.store_id
INNER JOIN payment ON payment.staff_id=staff.staff_id
GROUP BY store.store_id
ORDER by total_revenue DESC;

--How many rentals were made at each store?

SELECT store.store_id, COUNT(rental.rental_id) AS total_rentals
FROM store
JOIN inventory ON inventory.store_id = store.store_id
JOIN rental ON rental.inventory_id = inventory.inventory_id
GROUP BY store.store_id
ORDER BY total_rentals DESC;

--Which staff member generated the most revenue?

SELECT staff.staff_id,staff.first_name,staff.last_name, SUM(payment.amount) AS total_revenue FROM staff
INNER JOIN payment ON payment.staff_id=staff.staff_id
GROUP BY staff.staff_id,staff.first_name,staff.last_name
ORDER by total_revenue DESC;

--What is the average rental duration per store?

SELECT store.store_id,AVG(return_date-rental_date) AS average_rental_duration FROM store
INNER JOIN inventory ON inventory.store_id=store.store_id
INNER JOIN rental ON rental.inventory_id=inventory.inventory_id
GROUP BY store.store_id;

