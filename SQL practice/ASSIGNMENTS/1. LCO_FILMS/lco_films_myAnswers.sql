-- Q.1: Which categories of movies released in 2018? Fetch with the number of movies. 

SELECT category.name, film.release_year, COUNT(category.category_id) AS number_of_films 
    FROM category 
    LEFT JOIN film_category ON film_category.category_id = category.category_id 
    LEFT JOIN film ON  film_category.film_id =  film.film_id
    WHERE film.release_year = "2018" 
    GROUP BY category.category_id;