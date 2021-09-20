USE employees;

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.

SELECT COUNT(first_name) AS 'Records of Names', first_name 
FROM employees WHERE first_name IN ('Irena','Vidya','Maya')
GROUP BY first_name; /* Here we see Irena, Vidya, and Maya split into 3 groups and how many times their called */

-- Cleaner
SELECT COUNT(first_name) AS 'Records of Names' 
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya');

-- 709 records are returned here

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of  records returned. Does it match number of rows from Q2?

SELECT COUNT(first_name) AS 'Record of Names', first_name 
FROM employees 
WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya'
GROUP BY first_name;
-- ONly 709 is returned

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned.
SELECT COUNT(first_name) AS 'Record of names', 
	first_name, gender 
FROM employees 
WHERE (first_name = 'Irena' AND gender = 'M') OR (first_name = 'Vidya' AND gender = 'M') OR (first_name = 'Maya' AND gender = 'M')
GROUP BY first_name, gender;
-- 619 

-- Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E.
SELECT COUNT(last_name), last_name 
FROM employees 
WHERE last_name 
LIKE 'E%'
GROUP BY last_name;
-- 7330


-- Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. How many employees have a last name that ends with E, but does not start with E?

SELECT * 
FROM employees 
WHERE last_name LIKE 'E%' OR last_name LIKE '%E';
-- 30723

SELECT last_name 
FROM employees 
WHERE last_name LIKE '%E' AND NOT last_name LIKE 'E%';

-- 23393 with names that end with e but dont start with e

-- Find all current or previous employees employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. How many employees' last names end with E, regardless of whether they start with E?

SELECT * 
FROM employees 
WHERE last_name LIKE 'E%' AND last_name LIKE '%E';
-- 899

SELECT *
FROM employees
WHERE last_name LIKE '%E';
-- 24292

-- Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.

SELECT * 
FROM employees 
WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31'); /*   AND (last_name LIKE 'E%') AND (last_name LIKE '%E');*/
-- 135214

-- Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.

SELECT * 
FROM employees 
WHERE birth_date LIKE '%-12-25';
-- 842

-- Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.

SELECT * 
FROM employees 
WHERE (hire_date LIKE '199%') AND (hire_date LIKE '%-12-25%');
-- 346

-- Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.

SELECT * 
FROM employees 
WHERE last_name LIKE '%q%';
-- 1873

-- Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?

SELECT * 
FROM employees 
WHERE last_name LIKE '%q%' AND NOT last_name LIKE '%qu%';

-- 547