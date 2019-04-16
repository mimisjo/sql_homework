USE sakila;

-- 1a. Display first and last names of all actors from the table actor
SELECT 	first_name, last_name
FROM	actor;

-- 1b. Display the first and last names of each actor in a single column in upper case letters. Name the column Actor Name.
SELECT	CONCAT(first_name, ' ', last_name) as 'Actor Name'
FROM	actor;

-- 2a. Find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe."
SELECT 	actor_id, first_name, last_name
FROM	actor
WHERE	first_name = 'Joe';

-- 2b. Find all actors whose last name contain the letters GEN.
SELECT 	actor_id, first_name, last_name
FROM	actor
WHERE	last_name LIKE '%GEN%';

-- 2c. Find all actors whose last names contain the letters LI. Order rows by last name then first name.
SELECT 		actor_id, first_name, last_name
FROM		actor
WHERE		last_name LIKE '%LI%'
ORDER BY	last_name, first_name;

-- 2d. Using IN, display the country_id and country columns of Afghanistan, Bangladesh, and China
SELECT	country_id, country
FROM	country
WHERE	country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a. Create a column in the table actor named description and use the data type BLOB 
ALTER TABLE actor
  ADD description VARBINARY(1000);

-- 3b. Delete the description column.
ALTER TABLE actor
	DROP description;

-- 4a. List the last names of actors, as well as how many actors have that last name.
SELECT		last_name, count(*) as 'count'
FROM		actor
GROUP BY	last_name;

-- 4b. COULDN'T FIGURE OUT. List last names of actors and the number of actors who have that last name, but only for names shared by at least two actors
SELECT		last_name, count(*) as 'count'
FROM		actor
GROUP BY	last_name
ORDER BY	count;

-- 4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.
UPDATE 	actor
SET 	first_name = 'HARPO'
WHERE 	first_name = 'GROUCHO' AND last_name = 'WILLIAMS'; 

-- 4d. In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO.
SET SQL_SAFE_UPDATES = 0;

UPDATE	actor
SET		first_name = 'GROUCHO'
WHERE	first_name = 'HARPO';

SET SQL_SAFE_UPDATES = 1; 

-- 5a. Recreate the schema of the address table. 
SHOW CREATE TABLE address;

-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:
SELECT 	first_name, last_name, address
FROM	staff s 
		JOIN address a ON
			s.address_id = a.address_id;

-- 6b. GETTING BLANKS. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
SELECT		first_name, last_name, sum(amount) as 'Total Amount'
FROM		staff s
			JOIN payment p ON
			s.staff_id = p.staff_id
WHERE		MONTH(payment_date) = 8 AND YEAR(payment_date) = 2015
GROUP BY	s.first_name, s.last_name;

-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
SELECT		title, count(actor_id)
FROM		film_actor fa
			INNER JOIN film f ON
            fa.film_id = f.film_id
GROUP BY	title;

-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT		title, count(title)
FROM		film f
			INNER JOIN inventory i ON
				f.film_id = i.film_id
WHERE		title = 'Hunchback Impossible'
GROUP BY	title;

-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
SELECT		first_name, last_name, sum(amount) as 'total paid'
FROM		customer c
			JOIN payment p ON
				c.customer_id = p.customer_id
GROUP BY	c.first_name, c.last_name
ORDER BY	c.last_name;

-- 7a. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
SELECT	title
FROM	film 
WHERE	language_id IN
(
		SELECT 	language_id
        FROM	language 
        WHERE	name = 'English'
)
AND 	title LIKE 'K%'
OR		title LIKE 'Q%';

-- 7b. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT	first_name, last_name
FROM	actor
WHERE	actor_id IN
(
	SELECT	actor_id
    FROM	film_actor
    WHERE	film_id IN
    (
		SELECT 	film_id
        FROM	film
        WHERE	title = 'Alone Trip'
	)
);

-- 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
SELECT	first_name, last_name, email
FROM	customer cu
		INNER JOIN address ad ON 
			cu.address_id = ad.address_id
		INNER JOIN city ci ON
			ad.city_id = ci.city_id
		INNER JOIN country co ON
			ci.country_id = co.country_id
WHERE	co.country = 'Canada';

-- 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT 	title, ca.name as 'category'
FROM 	film f 
		INNER JOIN film_category fc ON
			f.film_id = fc.film_id
		INNER JOIN category ca ON
			fc.category_id = ca.category_id
WHERE 	ca.name= 'Family';
			
-- 7e. Display the most frequently rented movies in descending order.


-- 7f. Write a query to display how much business, in dollars, each store brought in.


-- 7g. Write a query to display for each store its store ID, city, and country.


-- 7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)


-- 8a. Use the solution from the problem above to create a view of the top 5 genres by gross revenue. 


-- 8b. Display the view you created in 8a.


-- 8c. Write a query to deletew the view top_five_genres