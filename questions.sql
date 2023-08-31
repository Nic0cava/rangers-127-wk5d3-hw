-- Question 1
SELECT COUNT(customer_id) AS number_of_customers, address.district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas'
GROUP BY address.district;
-- Question 2
-- this gets the names and payment amount
SELECT customer.first_name, customer.last_name, amount
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99
ORDER BY amount DESC;

-- this gets the number of payments
SELECT COUNT(amount) AS number_of_payments
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;

-- this shows the number or payments each customer made(over $6.99), Clara Shaw made the most number of payments
SELECT customer.first_name, customer.last_name, COUNT(amount) AS number_of_payments
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99
GROUP BY customer.first_name, customer.last_name, amount
ORDER BY COUNT(amount) DESC;
-- Question 3
SELECT store_id, first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);
-- Question 4
SELECT COUNT(customer_id) AS number_of_customers, country.country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal'
GROUP BY country.country;
-- Question 5
SELECT staff.first_name, staff.last_name, COUNT(amount)
FROM staff
INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.first_name, staff.last_name
ORDER BY COUNT(amount) DESC;
-- Question 6
SELECT COUNT(DISTINCT title), rating
FROM film
GROUP BY rating;
-- Question 7
SELECT COUNT(DISTINCT customer_id) AS number_of_customers
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id, amount
	HAVING amount > 6.99 AND COUNT(amount) = 1
);
-- Question 8
SELECT COUNT(amount) AS free_rentals
FROM payment
WHERE amount = 0;

-- this shows us which store gave out the most free rentals
-- store 1 gave out 13 free rentals, store 2 gave out 11 free rentals
SELECT store.store_id, COUNT(amount) AS free_rentals
FROM store
INNER JOIN inventory
ON store.store_id = inventory.store_id
INNER JOIN rental
ON inventory.inventory_id = rental.inventory_id
INNER JOIN payment
ON rental.rental_id = payment.rental_id
WHERE amount = 0
GROUP BY store.store_id;