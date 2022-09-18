-- Q.1: Which categories of movies released in 2018? Fetch with the number of movies. 

SELECT category.name, film.release_year, COUNT(category.category_id) AS number_of_films 
    FROM category 
    LEFT JOIN film_category ON film_category.category_id = category.category_id 
    LEFT JOIN film ON  film_category.film_id =  film.film_id
    WHERE film.release_year = "2018" 
    GROUP BY category.category_id;



-- Q.2:  Update the address of actor id 36 to “677 Jazz Street”. 
UPDATE `address` 
    INNER JOIN actor ON actor.address_id=address.address_id 
    SET `address`="677 Jazz Street"
WHERE actor.actor_id=36

            OR

UPDATE address
    SET address = "677 Jazz Street"
    WHERE address_id = 
        (SELECT address_id FROM actor
            WHERE actor_id = 36);




-- Q.3: Add the new actors (id : 105 , 95) in film  ARSENIC INDEPENDENCE (id:41).
INSERT INTO film_actor (actor_id, film_id)
        VALUES (105, 41),
                (95, 41)
    ON DUPLICATE KEY UPDATE
    actor_id = VALUES(actor_id),
    film_id = VALUES(film_id);

    


-- Q.4:  Get the name of films of the actors who belong to India.

SELECT DISTINCT film.title , country.country
    FROM film INNER JOIN film_actor ON film.film_id =  film_actor.film_id 
    INNER JOIN actor ON actor.actor_id = film_actor.actor_id 
    INNER JOIN address ON address.address_id = actor.address_id 
    INNER JOIN city ON city.city_id = address.city_id 
    INNER JOIN country ON country.country_id=city.country_id 
    WHERE country.country = "India"; 

-- Q.5: How many actors are from the United States?

SELECT COUNT(*) as No_of_US_actors
    FROM actor INNER JOIN address ON address.address_id = actor.address_id
                INNER JOIN city ON city.city_id = address.city_id
                INNER JOIN country ON country.country_id = city.country_id
                WHERE country.country = "United States";

-- Q.6: Get all languages in which films are released in the year between 2001 and 2010.

SELECT DISTINCT language.name
    FROM language INNER JOIN film ON language.language_id = film.language_id
    WHERE film.release_year BETWEEN 2001 AND 2010;

                            -- "OR"

    SELECT language.name,film.release_year, COUNT(language.language_id) AS number_of_films 
        FROM language LEFT JOIN film ON film.language_id = language.language_id
        WHERE film.release_year
        BETWEEN 2001 AND 2010 
        GROUP BY language.language_id;


-- Q.7: The film ALONE TRIP (id:17) was actually released in Mandarin, update the info.

UPDATE film
    SET language_id = (SELECT language.language_id from language WHERE name = "Mandarin")
WHERE film.film_id = 17;

-- Q.8: Fetch cast details of films released during 2005 and 2015 with PG rating.

SELECT actor.first_name, film.title, film.release_year, film.rating
    FROM actor INNER JOIN film_actor ON film_actor.actor_id = actor.actor_id
                INNER JOIN film ON film.film_id = film_actor.film_id
    WHERE (film.release_year BETWEEN 2005 AND 2015)
    AND (film.rating = "PG");

                -- "OR"

SELECT CONCAT(actor.first_name, " ", actor.last_name) AS actor_name, film.title,film.release_year,film.rating 
        FROM actor INNER JOIN film_actor ON film_actor.actor_id = actor.actor_id 
        INNER JOIN film ON film.film_id = film_actor.film_id 
        WHERE film.release_year BETWEEN 2005 AND 2015 
        AND film.rating = "PG";

-- Q.9: In which year most films were released? 

SELECT film.release_year, COUNT(film.release_year) AS no_of_films 
    FROM `film` 
    GROUP BY (film.release_year) 
    ORDER BY no_of_films DESC
    LIMIT 1;

            -- "OR"

SELECT release_year, count(film_id)
    from film
    group by release_year 
    ORDER BY count(film_id) DESC
    LIMIT 1;
            -- "OR"
SELECT * FROM(
        SELECT release_year, 
                COUNT(film_id) cnt, 
                DENSE_RANK() OVER (ORDER BY COUNT(film_id) DESC) drnk
            FROM film
            GROUP BY release_year 
) AS test 
WHERE drnk = 1;
            -- "OR"
WITH
cte AS (
    SELECT release_year, 
        COUNT(film_id) cnt, 
        DENSE_RANK() OVER (ORDER BY COUNT(film_id) DESC) drnk
    FROM film
    GROUP BY release_year 
)
SELECT release_year, cnt
FROM cte
WHERE drnk = 1;

