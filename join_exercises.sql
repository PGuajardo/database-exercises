USE employees;
DESCRIBE employees;
show create table employees;

-- 1. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

SELECT d.dept_name AS Department_Name, CONCAT(e.first_name, ' ', e.last_name) AS Department_Manager
FROM employees AS e
JOIN dept_manager AS dm using(emp_no)
JOIN departments AS d using(dept_no)
WHERE dm.to_date > NOW()
ORDER BY Department_Name ASC;

-- 2. Find the name of all departments currently managed by women.
SELECT d.dept_name AS Department_Name, CONCAT(e.first_name, ' ', e.last_name) AS Manager_Name
FROM employees AS e
JOIN dept_manager AS dm using(emp_no)
JOIN departments AS d using(dept_no)
WHERE dm.to_date > NOW() AND e.gender = 'F'
ORDER BY Department_Name ASC;

-- 3. Find the current titles of employees currently working in the Customer Service department.
SELECT t.title AS Title, COUNT(*) AS Count
FROM titles AS t
# JOIN employees AS e ON t.emp_no = e.emp_no
JOIN dept_emp AS de using(emp_no)
JOIN departments AS d using(dept_no)
WHERE t.to_date > NOW() AND de.to_date > NOW() AND d.dept_name LIKE 'Customer%'
GROUP BY Title 
ORDER BY Title ASC;

-- 4. Find the current salary of all current managers.
-- SALARY/ MANAGER

SELECT d.dept_name AS DEPARTMENT_NAME ,CONCAT(e.first_name, ' ', e.last_name) AS NAME ,s.salary AS SALARY
FROM employees AS e
JOIN dept_manager AS dm using(emp_no)
JOIN departments AS d using(dept_no)
JOIN salaries AS s using(emp_no)
WHERE dm.to_date > CURDATE() AND s.to_date > CURDATE()
GROUP BY DEPARTMENT_NAME, NAME, SALARY
ORDER BY DEPARTMENT_NAME ASC;


-- 5. Find the number of current employees in each department.

-- EMPLOYEES DEPARTMENT
SELECT  d.dept_name AS dept_name, COUNT(*) AS num_employees 
FROM dept_emp AS de
JOIN departments AS d using(dept_no)
WHERE de.to_date > CURDATE()
GROUP BY dept_name
ORDER BY dept_name ASC;

-- 6. Which department has the highest average salary? Hint: Use current not historic information.

SELECT d.dept_name AS dept_name, AVG(s.salary) AS average_salary
FROM salaries AS s
JOIN dept_emp AS de using(emp_no)
JOIN departments AS d using(dept_no)
WHERE de.to_date > NOW() AND s.to_date > NOW()
GROUP BY dept_name
ORDER BY average_salary DESC
LIMIT 1;


-- 7. Who is the highest paid employee in the Marketing department?

SELECT e.first_name AS first_name, e.last_name AS last_name
FROM salaries AS s
JOIN dept_emp AS de using(emp_no)
JOIN departments AS d using(dept_no)
JOIN employees AS e using(emp_no)
WHERE s.to_date > NOW() AND de.to_date > NOW() AND d.dept_name = 'Marketing'
ORDER BY salary DESC
LIMIT 1;

-- 8. Which current department manager has the highest salary?

SELECT e.first_name AS first_name, e.last_name AS last_name, s.salary AS salary, d.dept_name AS dept_name
FROM employees AS e
JOIN dept_manager AS dm using(emp_no)
JOIN departments AS d using(dept_no)
JOIN salaries AS s using(emp_no)
WHERE s.to_date > NOW() AND dm.to_date > NOW()
ORDER BY salary DESC
LIMIT 1;

-- 9. Bonus Find the names of all current employees, their department name, and their current manager's name.

SELECT CONCAT(e.first_name, ' ', e.last_name) AS Employee_Name, d.dept_name AS Department_Name, CONCAT(e.first_name, ' ', e.last_name)  AS Manager_Name
FROM employees AS e
JOIN dept_manager AS dm ON dm.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = dm.dept_no
WHERE dm.to_date > NOW() AND;




SELECT CONCAT(e.first_name, ' ', e.last_name) AS Employee_Name, d.dept_name AS Department_Name, CONCAT(manager.first_name, ' ', manager.last_name)  AS Manager_Name
FROM employees AS manager
JOIN dept_manager AS dm ON dm.emp_no = manager.emp_no
JOIN departments AS d ON d.dept_no = dm.dept_no
JOIN dept_emp AS de ON de.dept_no = d.dept_no
JOIN employees AS e ON e.emp_no = de.emp_no
WHERE dm.to_date > NOW() AND de.to_date > NOW()
ORDER BY Manager_Name DESC;
-- 10. Bonus Who is the highest paid employee within each department.




-- BONUS BONUS
-- 1. Determine the average salary for each department. Use all salary information and round your results.
SELECT d.dept_name AS dept_name, ROUND(AVG(s.salary), 0) AS average_salary
FROM salaries AS s
JOIN dept_emp AS de using(emp_no)
JOIN departments AS d using(dept_no)
GROUP BY dept_name
ORDER BY average_salary DESC;


