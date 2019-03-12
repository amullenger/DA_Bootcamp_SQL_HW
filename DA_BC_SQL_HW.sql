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
