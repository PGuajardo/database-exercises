-- 1. Create a new SQL script named limit_exercises.sql.

-- 2. MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. For example, to find all the unique titles within the company, we could run the following query:

/*SELECT DISTINCT title FROM titles;
List the first 10 distinct last name sorted in descending order.*/

SELECT DISTINCT last_name FROM employees ORDER BY last_name DESC LIMIT 10;

-- 3. Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. Write a comment in your code that lists the five names of the employees returned.

SELECT * 
FROM employees 
WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31') AND (birth_date LIKE '%-12-%')
ORDER BY hire_date DESC LIMIT 5;

-- NAMES: Rosita Fujisawa, Gonzalo Aamodt, Emran Garigliano, Piyawadee Rodiger, JoAnne Merey

-- 4. Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results.

SELECT * 
FROM employees 
WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31') AND (birth_date LIKE '%-12-%')
ORDER BY hire_date DESC LIMIT 5 OFFSET 50;

-- 5. LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?

-- Stated in the previous question already, we see OFFSET as the page number or the page we are trying to create, LIMIT the content on those pages, and the page number being the use of these to create snapshots of data to be used. 