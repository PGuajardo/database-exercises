#Employees


-- 1. How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary?
USE employees;

#Average Salary
CREATE TEMPORARY TABLE hopper_1543.Average_Salaries AS
SELECT dept_name, AVG(salary) AS Department_Salary FROM departments
JOIN dept_manager using(dept_no)
JOIN salaries using(emp_no)
GROUP BY dept_name;

USE hopper_1543;
SELECT * FROM Average_Salaries;
#Average of department managers salaries by departments,  MAIN TABLE

CREATE TEMPORARY TABLE hopper_1543.Average_Of_Managers AS
SELECT dept_name, AVG(salary) AS Average, CONCAT(e.first_name, ' ', e.last_name) AS Full_name FROM departments 
JOIN dept_manager using(dept_no)
JOIN employees e using(emp_no)
JOIN salaries using(emp_no)
WHERE salaries.to_date > NOW() AND dept_manager.to_date > NOW()
GROUP BY dept_name, Full_name;

USE hopper_1543;
SELECT * FROM Average_Of_Managers ORDER BY Average_Department_Salary DESC;

#CREATE new column with average department salaries
ALTER TABLE Average_Of_Managers ADD Average_Department_Salary DECIMAL(14,4);

#Setting that new column Average Department Salary with temporary table department salaries
UPDATE Average_Of_Managers a, Average_Salaries b SET a.Average_Department_Salary = b.Department_Salary WHERE a.dept_name = b.dept_name; 


#World Database
-- 1, What languages are spoken in Santa Monica?
USE world;

SELECT a.language AS Language, a.percentage AS Percentage
FROM countrylanguage a
JOIN city c using(CountryCode)
WHERE name = 'Santa Monica'
ORDER BY a.percentage ASC;

-- 2. How many different countries are in each region?

SELECT region, COUNT(name) AS num_countries
FROM country
GROUP BY region
ORDER BY num_countries ASC;

-- 3. What is the population for each region?
SELECT region, SUM(population) AS population
FROM country
GROUP BY region
ORDER BY population DESC;

-- 4. What is the population for each continent?

SELECT continent, SUM(population) AS population
FROM country
GROUP BY continent
ORDER BY population DESC;

-- 5. What is the average life expectancy globally?

SELECT AVG(LifeExpectancy) FROM country;

-- 6. What is the average life expectancy for each region, each continent? Sort the results from shortest to longest

SELECT continent, AVG(LifeExpectancy) AS average
FROM country
GROUP BY continent
ORDER BY average ASC;

SELECT region, AVG(LifeExpectancy) AS average
FROM country
GROUP By region
ORDER BY average ASC;

#BONUS WORLD
-- Find all the countries whose local name is different from the official name

SELECT name, localname FROM country
GROUP BY name, localname;

-- How many countries have a life expectancy less than x?

SELECT name, AVG(LifeExpectancy) as Average FROM country
GROUP BY name HAVING Average < 80
ORDER BY Average DESC;

-- What state is city x located in?

SELECT country.name, city.name 
FROM country
JOIN city ON city.countrycode = country.code
WHERE city.name = 'Santa Monica';

-- What region of the world is city x located in?

SELECT country.region, city.name
FROM country
JOIN city ON city.countrycode = country.code
WHERE city.name = 'Santa Monica';

-- What country (use the human readable name) city x located in?

SELECT country.localname, city.name
FROM country
JOIN city ON city.countrycode = country.code
WHERE city.name = 'Santa Monica';

-- What is the life expectancy in city x?
SELECT city.name, country.LifeExpectancy
FROM country
JOIN city ON city.countrycode = country.code
WHERE city.name = 'Santa Monica';


##Sakila Database
USE sakila;
-- 1. Display the first and last names in all lowercase of all the actors.

SELECT LOWER(first_name) AS First_Name, LOWER(last_name) AS Last_Name FROM actor;

-- 2. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you could use to obtain this information?

SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = 'Joe';

-- 3. Find all actors whose last name contain the letters "gen":

SELECT first_name, last_name FROM actor
WHERE last_name LIKE '%gen%';

-- 4. Find all actors whose last names contain the letters "li". This time, order the rows by last name and first name, in that order.

SELECT first_name, last_name FROM actor
WHERE last_name LIKE '%li%'
ORDER BY last_name, first_name ASC;

-- 5. Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China:

SELECT country_id, country FROM country
WHERE country IN ('Afghanistan','Bangladesh','China');

-- 6. List the last names of all the actors, as well as how many actors have that last name.

SELECT last_name, COUNT(last_name) FROM actor
GROUP BY last_name
ORDER BY COUNT(last_name);
-- 7. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
-- 8. You cannot locate the schema of the address table. Which query would you use to re-create it?
-- 9. Use JOIN to display the first and last names, as well as the address, of each staff member.
-- 10. Use JOIN to display the total amount rung up by each staff member in August of 2005.
-- 11. List each film and the number of actors who are listed for that film.
-- 12. How many copies of the film Hunchback Impossible exist in the inventory system?
-- 13.The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
-- 14. Use subqueries to display all actors who appear in the film Alone Trip.
-- 15. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.
-- 16. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.
-- 17. Write a query to display how much business, in dollars, each store brought in.
-- 18. Write a query to display for each store its store ID, city, and country.
-- 19. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
