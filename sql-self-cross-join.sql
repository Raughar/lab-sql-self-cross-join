use sakila;

-- Getting the pair of actors that worked together:

SELECT DISTINCT CONCAT(a1.first_name, ' ', a1.last_name) AS First_Actor, CONCAT(a2.first_name, ' ', a2.last_name) AS Second_Actor
FROM actor a1
JOIN film_actor fa1 ON a1.actor_id = fa1.actor_id
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
JOIN actor a2 ON fa2.actor_id = a2.actor_id
ORDER BY First_Actor, Second_Actor;

-- Get the pair of customers that rented the same film more than 3 times:
SELECT CONCAT(c1.first_name, ' ', c1.last_name) AS First_Customer, CONCAT(c2.first_name, ' ', c2.last_name) AS Second_Customer, f.title AS Film
FROM customer c1
JOIN customer c2 ON c1.customer_id < c2.customer_id
JOIN rental r1 ON c1.customer_id = r1.customer_id
JOIN rental r2 ON c2.customer_id = r2.customer_id
JOIN inventory i1 ON r1.inventory_id = i1.inventory_id
JOIN inventory i2 ON r2.inventory_id = i2.inventory_id AND i1.film_id = i2.film_id
JOIN film f ON i1.film_id = f.film_id
GROUP BY First_Customer, Second_Customer, Film
HAVING COUNT(*) > 3
ORDER BY First_Customer, Second_Customer, Film;

-- Getting all the possible pairs of actors and films:
SELECT CONCAT(a.first_name, ' ', a.last_name) AS Actor, f.title AS Film
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
ORDER BY Actor, Film;