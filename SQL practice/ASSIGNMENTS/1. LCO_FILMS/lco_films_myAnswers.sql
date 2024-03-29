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

-- Q.10: In which year least films were released?

SELECT release_year, count(release_year) AS no_of_movies
    FROM film
    GROUP BY release_year
    ORDER BY count(release_year) ASC 
    LIMIT 1;

                -- "OR"

SELECT * FROM (
    SELECT release_year,
            COUNT(release_year) AS CNT,
            DENSE_RANK() OVER (ORDER BY COUNT(release_year) ASC) as "drnk"
            FROM film
            GROUP BY release_year
) AS test
WHERE drnk = 1;

                -- "OR"

WITH
cte AS (
    SELECT release_year, count(film_id) as no_of_movies,
        DENSE_RANK() OVER(ORDER BY COUNT(film_id) ASC) as "drnk"
    FROM film
    GROUP BY release_year
)
SELECT release_year, no_of_movies
    FROM cte
    WHERE drnk = 1;

-- Q. 11: Get the details of the film with maximum length released in 2014 

SELECT *, language.name as language 
    FROM `film` LEFT JOIN language ON language.language_id = film.language_id 
    WHERE film.release_year = "2014" AND film.length = (SELECT MAX(film.length) FROM film);

            -- "OR"

WITH
cte as(
SELECT *,
    DENSE_RANK() OVER(ORDER BY max(length) desc) as drnk
    from film 
    group by film_id
)
SELECT * 
from cte
WHERE release_year = 2014 AND drnk = 1;

-- Q.12: Get all Sci- Fi movies with NC-17 ratings and language they are screened in.

SELECT film.title, category.name, film.rating, language.name
    FROM film INNER JOIN film_category ON film_category.film_id = film.film_id
                INNER JOIN category ON category.category_id = film_category.category_id
                INNER JOIN language ON language.language_id = film.language_id
                WHERE category.name = "Sci-Fi" AND film.rating = "NC-17";

                -- "OR"

SELECT film.film_id, film.title, film.description, film.release_year, film.length, film.rating,category.name, language.name 
    FROM film LEFT JOIN language ON language.language_id=film.language_id 
    RIGHT JOIN film_category ON film_category.film_id = film.film_id 
    LEFT JOIN category ON category.category_id=film_category.category_id  
    WHERE film.rating="NC-17" AND category.name="Sci-Fi";


    -- Q.13: The actor FRED COSTNER (id:16) shifted to a new address: 
--           055,  Piazzale Michelangelo, Postal Code - 50125 , District - Rifredi at Florence, Italy.  
--           Insert the new city and update the address of the actor.

                City -> Florence
                Country -> Italy
                District -> Rifredi
                Address -> 055, Piazzale Michelangelo
                Postal Code -> 50125

-- Insert new city
INSERT INTO city(city, country_id)
        VALUES('Florence', (SELECT country_id FROM country WHERE country = 'Italy'));

-- Update the Address
UPDATE address 
    INNER JOIN actor ON actor.address_id = address.address_id 
    SET 
        address.address = "055,  Piazzale Michelangelo", 
        address.district = "Rifredi ", 
        address.city_id = (SELECT city_id FROM city WHERE city.city = "Florence") , 
        address.postal_code = "50125" 
    WHERE actor.actor_id = 16;

-- Q. 14: A new film “No Time to Die” is releasing in 2020 whose details are :  
        -- Title :- No Time to Die 
        -- Description: Recruited to rescue a kidnapped scientist, globe-trotting spy James Bond finds 
        -- himself hot on the trail of a mysterious villain, who's armed with a dangerous new technology. 
        -- Language: English 
        -- Org. Language : English 
        -- Length : 100 
        -- Rental duration : 6 
        -- Rental rate : 3.99
        -- Rating : PG-13 
        -- Replacement cost : 20.99 
        -- Special Features = Trailers,Deleted Scenes 
        
        -- Insert the above data. 

INSERT INTO film(title, description, release_year, language_id, original_language_id, rental_duration, rental_rate, length, 
replacement_cost, rating, special_features)
        VALUES("No Time to Die", 
        "Recruited to rescue a kidnapped scientist, globe-trotting spy James Bond finds 
        imself hot on the trail of a mysterious villain, who's armed with a dangerous new technology.",
        2020,
        (SELECT language_id from language WHERE name = "English"),
        (SELECT language_id from language WHERE name = "English"),
        6,3.99, 100, 20.99, "PG-13", "Trailers,Deleted Scenes ");


-- Q. 15: Assign the category Action, Classics, Drama  to the movie “No Time to Die” .

INSERT INTO film_category(category_id, film_id) 
        VALUES  ((SELECT category_id FROM category WHERE category.name = "Action"), (SELECT film_id FROM film WHERE film.title = "No Time to Die" )), 
                ((SELECT category_id FROM category WHERE category.name = "Classics") , (SELECT film_id FROM film WHERE film.title = "No Time to Die" )) ,
                ((SELECT category_id FROM category WHERE category.name = "Drama") , (SELECT film_id FROM film WHERE film.title = "No Time to Die" ));


-- Q. 16: Assign the cast: PENELOPE GUINESS, NICK WAHLBERG, JOE SWANK to the movie “No Time to Die” .

INSERT INTO film_actor(actor_id, film_id) 
        VALUES ((SELECT actor_id FROM actor WHERE actor.first_name = "PENELOPE" AND actor.last_name = "GUINESS") , (SELECT film_id FROM film WHERE film.title = "No Time to Die" )), 
            ((SELECT actor_id FROM actor WHERE actor.first_name = "NICK" AND actor.last_name = "WAHLBERG") , (SELECT film_id FROM film WHERE film.title = "No Time to Die" )) ,
            ((SELECT actor_id FROM actor WHERE actor.first_name = "JOE" AND actor.last_name = "SWANK") , (SELECT film_id FROM film WHERE film.title = "No Time to Die" ));

-- Q. 17: Assign a new category Thriller  to the movie ANGELS LIFE.

INSERT INTO category(name) VALUES ("Thriller");

INSERT INTO film_category(film_id, category_id)
        VALUES ((SELECT film_id FROM film WHERE title = "ANGELS LIFE"), (SELECT category_id FROM category WHERE name ="Thriller"));

-- Q.18: Which actor acted in most movies?

WITH
cte as(
    SELECT actor_id,
        COUNT(actor_id) as No_of_movies,
        DENSE_RANK() OVER(ORDER BY COUNT(actor_id) DESC) drnk
        FROM film_actor
        GROUP BY actor_id
)
SELECT actor_id, No_of_movies
FROM cte
WHERE drnk = 1;

-- Q.19: The actor JOHNNY LOLLOBRIGIDA was removed from the movie GRAIL FRANKENSTEIN. How would you update that record?

DELETE FROM film_actor
    WHERE actor_id = (SELECT actor_id FROM actor WHERE first_name ="JOHNNY" AND last_name = "LOLLOBRIGIDA") 
    AND film_id = (SELECT film_id FROM film WHERE title = "GRAIL FRANKENSTEIN");

-- Q.20: The HARPER DYING movie is an animated movie with Drama and Comedy. Assign these categories to the movie.

INSERT INTO film_category(category_id, film_id) 
    VALUES ((SELECT category_id FROM category WHERE category.name="Drama"), (SELECT film_id FROM film WHERE film.title ="HARPER DYING")),
    ((SELECT category_id FROM category WHERE category.name="Comedy"),(SELECT film_id FROM film WHERE film.title ="HARPER DYING"))
    ON DUPLICATE KEY UPDATE film_id = VALUES(film_id) , category_id = VALUES(category_id);

-- Q. 21: The entire cast of the movie WEST LION has changed. The new actors are DAN TORN, 
        -- MAE HOFFMAN, SCARLETT DAMON. How would you update the record in the safest way.

DELETE FROM film_actor  
    WHERE film_id = (SELECT film_id FROM film WHERE film.title = "WEST LION"); -- Deleting previous cast first

INSERT INTO film_actor(actor_id, film_id) VALUES 
        ((SELECT actor_id FROM actor WHERE actor.first_name = "DAN" AND actor.last_name="TORN"), (SELECT film_id FROM film WHERE film.title="WEST LION")),
        ((SELECT actor_id FROM actor WHERE actor.first_name = "MAE" AND actor.last_name="HOFFMAN"), (SELECT film_id FROM film WHERE film.title="WEST LION")),
        ((SELECT actor_id FROM actor WHERE actor.first_name = "SCARLETT" AND actor.last_name="DAMON"), (SELECT film_id FROM film WHERE film.title="WEST LION"));

                -- "OR"


-- Q.22: The entire category of the movie WEST LION was wrongly inserted. The correct categories 
        -- are Classics, Family, Children. How would you update the record ensuring no wrong data is left?

DELETE FROM film_category WHERE film_id = (SELECT film_id FROM film WHERE film.title = "WEST LION");

INSERT INTO film_category(category_id, film_id) 
    VALUES ((SELECT category_id FROM category WHERE category.name = "Classics"), (SELECT film_id FROM film WHERE film.title="WEST LION")), 
    ((SELECT category_id FROM category WHERE category.name = "Family"), (SELECT film_id FROM film WHERE film.title="WEST LION")), 
    ((SELECT category_id FROM category WHERE category.name = "Children"), (SELECT film_id FROM film WHERE film.title="WEST LION"));


-- Q.23: How many actors acted in films released in 2017? 

SELECT film.release_year,
        COUNT(film_actor.actor_id) as cnt
        FROM film_actor
        INNER JOIN film ON film.film_id = film_actor.film_id
        WHERE film.release_year = 2017
        GROUP BY film.release_year;

                -- "OR"

        SELECT COUNT(*) FROM film_actor INNER JOIN film ON film.film_id=film_actor.film_id WHERE film.release_year = 2017;

-- Q. 24: How many Sci-Fi films released between the year 2007 to 2017

SELECT COUNT(film.film_id) as CNT
        FROM film INNER JOIN film_category ON film_category.film_id = film.film_id
                INNER JOIN category ON category.category_id = film_category.category_id
                WHERE film.release_year BETWEEN 2007 AND 2017
                AND category.name = "Sci-Fi";

-- Q. 25: Fetch the actors of the movie WESTWARD SEABISCUIT with the city they live in.

SELECT CONCAT(actor.first_name, " " ,actor.last_name) AS Actor, film.title, city.city
        FROM film INNER JOIN film_actor ON film.film_id = film_actor.film_id
                    INNER JOIN actor ON actor.actor_id = film_actor.actor_id
                    INNER JOIN address ON address.address_id = actor.address_id
                    INNER JOIN city ON city.city_id = address.address_id
                    WHERE film.title = "WESTWARD SEABISCUIT";

-- Q. 26: What is the total length of all movies played in 2008

SELECT SUM(length) as totol_length from film WHERE release_year = 2008;

-- Q. 27: Which film has the shortest length? In which language and year was it released

SELECT film.title, film.release_year, film.length, language.name as lang
    FROM film INNER JOIN language ON language.language_id = film.language_id
        WHERE film.length = (SELECT MIN(length) FROM film);

-- Q. 28: How many movies were released each year
SELECT release_year, COUNT(film_id) AS No_of_movies
    FROM film
    GROUP BY release_year;

-- Q. 29: How many languages of movies were released each year 

-- just for 2019 (trying to make it dynamic)
WITH 
movies_released AS(
select release_year, count(film_id) AS No_of_movies
    FROM film
    GROUP BY film.release_year
),
ENG AS(
select count(film.language_id) AS English
        FROM film
        WHERE language_id = (SELECT language_id from language WHERE name = "English")
        AND
        release_year = "2019"
),
ITL AS(
select count(film.language_id) AS Italian
        FROM film
        WHERE language_id = (SELECT language_id from language WHERE name = "Italian")
        AND
        release_year = "2019"
),
JPN AS(
select count(film.language_id) AS Japanese
        FROM film
        WHERE language_id = (SELECT language_id from language WHERE name = "Japanese")
        AND
        release_year = "2019"
),
MND AS(
select count(film.language_id) AS Mandarin
        FROM film
        WHERE language_id = (SELECT language_id from language WHERE name = "Mandarin")
        AND
        release_year = "2019"
),
FRN AS(
select count(film.language_id) AS French
        FROM film
        WHERE language_id = (SELECT language_id from language WHERE name = "French")
        AND
        release_year = "2019"
),
GER AS(
select count(film.language_id) AS German
        FROM film
        WHERE language_id = (SELECT language_id from language WHERE name = "German")
        AND
        release_year = "2019"
)
SELECT * 
FROM movies_released, ENG, ITL, JPN, MND, FRN, GER
WHERE release_year = 2019;

-- Q. 30: Which actor did least movies
WITH 
cte AS(
        SELECT film_actor.actor_id AS ID, CONCAT(actor.first_name," ",actor.last_name) as Actor,
            COUNT(film_actor.actor_id) as CNT,
            DENSE_RANK() OVER(ORDER BY COUNT(film_actor.actor_id) ASC) AS drnk
            FROM film_actor INNER JOIN actor ON actor.actor_id = film_actor.actor_id
            GROUP BY film_actor.actor_id
)
SELECT ID, Actor, CNT FROM cte
WHERE drnk = 1;