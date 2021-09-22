-- 1. Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.
describe employees;
-- 2. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name ASC;
-- IRENA Reutenauer : first result
-- Vidya Awdeh : Last result

-- 3. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

SELECT first_name, last_name FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name ASC, last_name ASC; /* first_name DESC, last_name DESC; */

-- Irena Acton
-- Vidya Zweizig

-- 4. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

SELECT last_name, first_name FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY last_name ASC, first_name ASC; /*last_name DESSC, first_name DESC; */
-- Irena Acton
-- Maya Zyda

-- 5. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.

SELECT * FROM employees WHERE last_name LIKE '%E' ORDER BY emp_no ASC;

-- 24292 total
-- last employee Navin Argence 499994
-- first  employee Ramzi Erde 10021

-- 6. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest emmployee.

SELECT * FROM employees WHERE (last_name LIKE 'E%') AND (last_name LIKE '%E') ORDER BY hire_date ASC; 
-- 899
-- Oldest Sergi Erde
-- Newest Teiji Eldridge

-- 7. Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest emmployee who was hired first.

SELECT * FROM employees WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31' ORDER BY birth_date DESC, hire_date DESC;
-- 135214
-- Badri Schapire : Youngest Hired last
SELECT * FROM employees WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31' ORDER BY birth_date ASC, hire_date ASC;
-- Eishiro Kuzuoka : Oldest HIred last 

--
--
-- function_sql exercises
--
--
use employees;

-- 1. Write a query to to find all employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name.
SELECT concat(first_name, last_name) AS full_name 
FROM employees 
WHERE last_name LIKE 'E%%E';
-- 899

-- 2. Convert the names produced in your last query to all uppercase.
SELECT UPPER(concat(first_name, last_name)) AS full_name 
FROM employees 
WHERE last_name LIKE 'E%%E';

-- 3. Find all employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),
use employees;
SELECT DATEDIFF(CURDATE(), hire_date) FROM employees
WHERE (hire_date LIKE '199%') AND (birth_date LIKE '%-25');

-- 4. Find the smallest and largest current salary from the salaries table.

SELECT MIN(salary) AS SmallestSalary, MAX(salary) AS LargestSalary 
FROM salaries;

-- 5. Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like: hhhhhh

SELECT LOWER(CONCAT(SUBSTR(first_name,1,1), SUBSTR(last_name,1,4), '_', SUBSTR(birth_date, 6, 2), SUBSTR(birth_date, 3, 2))) AS UserName,
first_name, last_name, birth_date
FROM employees
LIMIT 10;  

--
--

-- 1. In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.
use titles;
SELECT DISTINCT title
FROM titles;
-- 7 

-- 2. Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.

SELECT /*first_name,*/ last_name FROM employees
GROUP BY last_name #first_name
HAVING last_name LIKE 'E%%E';
-- 5

-- 3. Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.

SELECT first_name, last_name FROM employees
GROUP BY last_name, first_name
HAVING last_name LIKE 'E%%E';

-- 4. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.

SELECT last_name FROM employees
GROUP BY last_name
HAVING last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';
-- Chleq, Lindqvist, Qiwen

-- 5. Add a COUNT() to your results (the query above) to find the number of employees with the same last name.

SELECT last_name, COUNT(last_name) AS COUNT_OF_LAST 
FROM employees
GROUP BY last_name;
-- 1637

-- 6. Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.

SELECT first_name, COUNT(*), gender FROM employees
GROUP BY first_name, gender
# ORDER BY COUNT(*) ASC
HAVING first_name IN ('Irena', 'Vidya', 'Maya');

-- 7. Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?

SELECT LOWER(CONCAT(SUBSTR(first_name,1,1), SUBSTR(last_name,1,4), '_', SUBSTR(birth_date, 6, 2), SUBSTR(birth_date, 3, 2))) AS username, COUNT(*) 
FROM employees
GROUP BY username;
# 285872

# HAVING COUNT(*) > 1;
# 13251


-- More practice with aggregate functions:

-- Find the historic average salary for all employees. 

SELECT avg(salary) FROM salaries;
-- Now determine the current average salary.

SELECT avg(salary) FROM salaries
WHERE to_date LIKE '9999%';

/*Now find the historic average salary for each employee. Reminder that when you hear "for each" in the problem statement, you'll probably be grouping by that exact column.*/

SELECT AVG(salary) FROM salaries
GROUP BY salary
ORDER BY salary ASC;

-- Find the current average salary for each employee.

SELECT avg(salary) FROM salaries
WHERE to_date LIKE '9999%'
GROUP BY salary;

-- Find the maximum salary for each current employee.

SELECT MAX(salary) FROM salaries
WHERE to_date LIKE '9999%'
GROUP BY salary
ORDER BY salary DESC;

-- Now find the max salary for each current employee where that max salary is greater than $150,000.

SELECT MAX(salary) FROM salaries
WHERE to_date LIKE '9999%'
GROUP BY salary HAVING MAX(salary) > 150000
ORDER BY salary DESC;
-- Find the current average salary for each employee where that average salary is between $80k and $90k.

SELECT AVG(salary) FROM salaries
GROUP BY salary HAVING AVG(salary) BETWEEN 80000 AND 90000
ORDER BY salary DESC;
