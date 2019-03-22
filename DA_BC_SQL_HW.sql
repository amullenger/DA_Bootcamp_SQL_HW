USE sakila;

-- 1a.
SELECT first_name, last_name FROM actor;
-- 1b
SELECT
CONCAT(first_name, " ", last_name) as "Actor Name"
FROM actor;

-- 2a
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';
-- 2b
SELECT * FROM actor
WHERE last_name LIKE "%GEN%";
-- 2c
SELECT * FROM actor
WHERE last_name LIKE "%LI%"
ORDER BY last_name, first_name;
-- 2d
SELECT country_id, country
FROM country
WHERE country_id IN (1,12,23);

-- 3a
ALTER TABLE actor
ADD COLUMN description BLOB;

-- 3b
ALTER TABLE actor
DROP COLUMN description;

-- 4a
SELECT last_name AS "Last Name", COUNT(last_name) AS "Number of Occurances"
FROM actor
GROUP BY last_name;

-- 4b
SELECT last_name AS "Last Name", COUNT(last_name) AS "Number of Occurances"
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) >= 2;

-- 4c
UPDATE actor
SET first_name = "Harpo"
WHERE first_name = "Groucho" AND last_name = "Williams";

-- 4d
UPDATE actor
SET first_name = "GROUCHO"
WHERE first_name = "Harpo" AND last_name = "WILLIAMS";

-- 5a
SHOW CREATE TABLE address;

-- 6a
SELECT s.first_name, s.last_name, a.address
FROM staff s
INNER JOIN  address a
ON s.address_id = a.address_id;

-- 6b
SELECT s.first_name, SUM(p.amount)
FROM staff s
INNER JOIN payment p
ON s.staff_id = p.staff_id
GROUP BY s.first_name;

-- 6c
SELECT f.title, COUNT(fa.actor_id)
FROM film f
INNER JOIN film_actor fa
ON f.film_id = fa.film_id
GROUP BY f.title;

-- 6d 
SELECT f.title, COUNT(i.film_id) AS "Inventory Count"
FROM film f 
INNER JOIN inventory i 
ON f.film_id = i.film_id
WHERE f.title = "Hunchback Impossible";

-- 6e
SELECT c.first_name, c.last_name, SUM(p.amount) AS "Amount Spent"
FROM customer c 
INNER JOIN payment p 
ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY c.last_name;

-- 7a
SELECT title
FROM film 
WHERE title LIKE "K%" OR title LIKE "Q%" AND language_id = 1;

-- 7b
SELECT first_name, last_name
FROM actor
WHERE actor_id IN 
	(SELECT actor_id
		FROM film_actor 
        WHERE film_id =
			(SELECT film_id 
				FROM film
                WHERE title = "Alone Trip"));

-- 7c
SELECT c.first_name, c.last_name, c.email
FROM customer c 
JOIN address a
ON c.address_id = a.address_id
JOIN city ci
ON a.city_id = ci.city_id
JOIN country co
ON ci.country_id = co.country_id
WHERE co.country = "Canada";

-- 7d 
SELECT f.title 
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
WHERE fc.category_id = 
	(SELECT category_id
		FROM category
        WHERE name = "Family");
        
-- 7e
SELECT f.title, count(r.rental_id)
FROM film f
JOIN inventory i 
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY count(r.rental_id) DESC;

-- 7f
SELECT st.store_id, SUM(p.amount)
FROM store st
JOIN payment p
ON st.manager_staff_id = p.staff_id
GROUP BY st.store_id;

-- 7g
SELECT st.store_id, ci.city, co.country
FROM store st
JOIN address a
ON st.address_id = a.address_id
JOIN city ci
ON a.city_id = ci.city_id
JOIN country co
ON ci.country_id = co.country_id;

-- 7h
SELECT ca.name, SUM(p.amount)
FROM category ca
JOIN film_category fc
ON ca.category_id = fc.category_id
JOIN inventory i 
ON fc.film_id = i.film_id
JOIN rental r 
ON i.inventory_id = r.inventory_id
JOIN payment p 
ON r.rental_id = p.rental_id
GROUP BY ca.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;

-- 8a
CREATE VIEW top_five_genres AS
	SELECT ca.name, SUM(p.amount)
	FROM category ca
	JOIN film_category fc
	ON ca.category_id = fc.category_id
	JOIN inventory i 
	ON fc.film_id = i.film_id
	JOIN rental r 
	ON i.inventory_id = r.inventory_id
	JOIN payment p 
	ON r.rental_id = p.rental_id
	GROUP BY ca.name
	ORDER BY SUM(p.amount) DESC
	LIMIT 5;
    
-- 8b 
SELECT * FROM top_five_genres;

-- 8c
DROP VIEW top_five_genres;




