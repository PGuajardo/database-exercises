
USE employees;
-- 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.

SELECT emp_no, hire_date, first_name
FROM employees
WHERE hire_date = (
SELECT hire_date
FROM employees
WHERE emp_no = 101010
);


-- 2. Find all the titles ever held by all current employees with the first name Aamod.

SELECT t.title, e.first_name
FROM (
	SELECT *
	FROM employees
	WHERE first_name = 'Aamod'
) AS e
JOIN titles AS t ON t.emp_no = e.emp_no
WHERE t.to_date > NOW()
GROUP BY t.title, e.first_name;

-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

SELECT COUNT(*)
FROM employees
WHERE emp_no IN (
SELECT emp_no
FROM dept_emp
WHERE to_date < now()
);

-- 85108


-- 4. Find all the current department managers that are female. List their names in a comment in your code.

SELECT first_name, last_name, gender
FROM employees
WHERE emp_no IN (
SELECT emp_no
FROM dept_manager
WHERE dept_manager.to_date > now()
) AND gender = 'F';
-- Isamu Legleitner, Karsten Sigstam, Leon DasSarma, Hilary Kambil

-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.

Select first_name, last_name, AVG(salary)
FROM salaries
JOIN employees using(emp_no)
WHERE salary > (SELECT AVG(salary)
				FROM salaries) 
AND to_date > NOW()
GROUP BY first_name, last_name;


-- 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?


SELECT count(*) FROM salaries WHERE salary > (SELECT (MAX(salary) - stddev(salary)) FROM salaries WHERE to_date > NOW()) AND to_date > NOW();
-- 83 current salaries are within 1 standard deviation of the current highest salary


SELECT 
	(
	(SELECT count(*) FROM salaries WHERE salary > (SELECT (MAX(salary) - stddev(salary)) FROM salaries WHERE to_date > NOW()) AND to_date > NOW()) /
	(SELECT count(*) FROM salaries WHERE  to_date > NOW()) 
	)*100 AS Highest;

--  .0346 percent




-- BONUS

-- Find all the department names that currently have female managers.

SELECT dept_name, gender, first_name, last_name
FROM (SELECT * FROM employees WHERE gender = 'F') AS e
JOIN dept_manager using(emp_no)
JOIN departments using(dept_no)
GROUP BY dept_name, gender, first_name, last_name;

-- Find the first and last name of the employee with the highest salary.

SELECT first_name, last_name
FROM employees e
WHERE emp_no IN (SELECT emp_no FROM salaries WHERE salary IN
					(SELECT MAX(salary)
					FROM salaries)
	);



-- Find the department name that the employee with the highest salary works in.

SELECT dept_name
FROM departments
WHERE dept_no IN (SELECT dept_no
				FROM dept_emp
				WHERE emp_no IN (
							SELECT emp_no FROM salaries WHERE salary IN
																			(SELECT MAX(salary)
																			FROM salaries)
								)
			);

