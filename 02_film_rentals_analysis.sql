-- Which films have been rented the most overall? 

SELECT film.title,film.film_id,COUNT(rental_id) AS rentals FROM film
INNER JOIN inventory ON film.film_id=inventory.film_id
INNER JOIN rental ON inventory.inventory_id=rental.inventory_id
GROUP BY film.title,film.film_id
ORDER BY rentals DESC;

--What are the most popular film categories by rental count?

SELECT category.name,COUNT(rental.rental_id) AS rentals_count FROM rental
INNER JOIN inventory ON inventory.inventory_id=rental.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
INNER JOIN film_category ON film.film_id=film_category.film_id
INNER JOIN category ON film_category.category_id=category.category_id
GROUP BY category.name
ORDER BY rentals_count DESC;

--Which films are most rented within each category?

SELECT category_name, title, rentals_count FROM (
  SELECT
    category.name AS category_name,
    film.title,
    COUNT(rental.rental_id) AS rentals_count,
    ROW_NUMBER() OVER (PARTITION BY category.name ORDER BY COUNT(rental.rental_id) DESC) AS rn
  FROM rental
  JOIN inventory ON rental.inventory_id = inventory.inventory_id
  JOIN film ON inventory.film_id = film.film_id
  JOIN film_category ON film.film_id = film_category.film_id
  JOIN category ON film_category.category_id = category.category_id
  GROUP BY category.name, film.title
) sub
WHERE rn = 1
ORDER BY category_name;

--How many rentals does each language have?

SELECT language.name,COUNT(rental_id) AS rentals FROM rental
INNER JOIN inventory ON rental.inventory_id=inventory.inventory_id
INNER JOIN film ON film.film_id=inventory.film_id
INNER JOIN language ON film.language_id=language.language_id
GROUP BY language.name
ORDER BY rentals DESC;




