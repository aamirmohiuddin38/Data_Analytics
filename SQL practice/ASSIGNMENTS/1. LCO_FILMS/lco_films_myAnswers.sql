-- Q.1: Which categories of movies released in 2018? Fetch with the number of movies. 

/*
SELECT category.name, film.release_year, COUNT(category.category_id) AS number_of_films 
    FROM category 
    LEFT JOIN film_category ON film_category.category_id = category.category_id 
    LEFT JOIN film ON  film_category.film_id =  film.film_id
    WHERE film.release_year = "2018" 
    GROUP BY category.category_id;
*/

/*
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

*/

/*
-- Q.3: Add the new actors (id : 105 , 95) in film  ARSENIC INDEPENDENCE (id:41).
INSERT INTO film_actor (actor_id, film_id)
        VALUES (105, 41),
                (95, 41)
    ON DUPLICATE KEY UPDATE
    actor_id = VALUES(actor_id),
    film_id = VALUES(film_id);

    /*