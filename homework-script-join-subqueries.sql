-- 1) List all customers who live in Texas (use JOINs):

SELECT CONCAT(first_name,' ',last_name) AS full_name
FROM customer
JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';
-- Output: Jennifer Davis, Kim Cruz, Richard Mccrary, Bryan Hardison, and Ian Still

-- 2) Get all payments above $6.99 with the Customer's Full Name:

SELECT CONCAT(first_name,' ',last_name) AS full_name, amount
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99


-- 3) Show all customer names who have made payments over $175 (use subqueries):

SELECT CONCAT(first_name,' ',last_name) AS full_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING sum(amount) > 175
);
-- Output: Rhonda Kennedy, Clara Shaw, Eleanor Hunt, Marion Snyder, Tommy Collazo, and Karl Seal

SELECT CONCAT(first_name,' ',last_name) AS full_name
FROM customer
JOIN payment
ON payment.customer_id = customer.customer_id
GROUP BY full_name
HAVING SUM(amount) > 175;

-- 4) List all customers that live in Nepal (use the city table):
	
SELECT CONCAT(first_name,' ',last_name) AS full_name
FROM customer
WHERE address_id IN (
	SELECT address_id
	FROM address
	WHERE city_id IN (
		SELECT city_id
		FROM city
		WHERE country_id IN (
			SELECT country_id
			FROM country
			WHERE country = 'Nepal'
)));
-- Output: Kevin Schuler

SELECT country_id
FROM country
WHERE country = 'Nepal'
-- 66
SELECT city_id
FROM city
WHERE country_id = 66
-- 81
SELECT count(address_id)
FROM address
WHERE city_id = 81
-- 1

-- 5) Which staff member had the most transactions?

SELECT concat(first_name,' ',last_name)
FROM staff
WHERE staff_id = (
	SELECT staff_id
	FROM payment
	GROUP BY staff_id
	ORDER BY count(payment_id) DESC
	LIMIT 1
);
-- Output: Jon Stephens

-- 6) How many movies of each rating are there?

SELECT rating, count(DISTINCT film_id)
FROM film
GROUP BY rating;
-- Output:
-- G = 178
-- PG = 194
-- PG-13 = 223
-- R = 195
-- NC-17 = 210

-- 7) Show all customers who have made a single payment above $6.99 (Use Subqueries):

SELECT CONCAT(first_name,' ',last_name) AS full_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING count(amount>6.99) = 1 
);
-- Output: None

-- 8) How many free rentals did our stores give away?

SELECT rental_id
FROM payment
WHERE amount = 0;
-- Output: 24