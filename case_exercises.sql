
-- 1. Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
USE employees;

SELECT emp_no, dept_no, hire_date, to_date,
		IF(dept_emp.to_date > NOW(), True, False) AS is_current_employee
FROM employees
JOIN dept_emp using(emp_no);

-- 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT first_name, last_name,
	CASE
		WHEN last_name LIKE 'A%' OR last_name LIKE 'B%' OR last_name LIKE 'C%' OR last_name LIKE 'D%' OR last_name LIKE 'E%' OR last_name LIKE 'F%' OR last_name LIKE 'G%' 
			OR last_name LIKE 'H%' THEN 'A-H'
		WHEN last_name LIKE 'I%' OR last_name LIKE 'J%' OR last_name LIKE 'K%' OR last_name LIKE 'L%' OR last_name LIKE 'M%' OR last_name LIKE 'N%' OR last_name LIKE 'O%'
			OR last_name LIKE 'P%' OR last_name LIKE 'Q%' THEN 'I-Q'
		WHEN last_name LIKE 'R%' OR last_name LIKE 'S%' OR last_name LIKE 'T%' OR last_name LIKE 'U%' OR last_name LIKE 'V%' OR last_name LIKE 'W%' OR last_name LIKE 'X%'
			OR last_name LIKE 'Y%' OR last_name LIKE 'Z%' THEN 'R-Z'
		ELSE 'OTHER'
		END AS alpha_group
FROM employees;

-- 3. How many employees (current or previous) were born in each decade?

SELECT #birth_date,
	COUNT(CASE WHEN birth_date LIKE '195%' THEN 'Born in 1950s' ELSE NULL END) AS '1950s',
	COUNT(CASE WHEN birth_date LIKE '196%' THEN 'Born in 1960s' ELSE NULL END) AS '1960s'
FROM employees;
#GROUP BY birth_date
#ORDER BY birth_date ASC;
###BONUS

-- What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?


SELECT dept_name,
       CASE 
           WHEN dept_name IN ('research', 'development') THEN 'R&D'
           WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing' 
           WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
           ELSE dept_name
           END AS dept_group,
           CASE
           	WHEN dept_group = 'R&D' THEN AVG(salary)           		WHEN dept_group = 'Customer Service' THEN AVG(salary)           		WHEN dept_group = 'Finance' THEN AVG(salary)           		WHEN dept_group = 'Human Resources' THEN AVG(salary)           		WHEN dept_group = 'Sales & Marketing' THEN AVG(salary)
           	ELSE dept_group
           	END AS Average_Salary
FROM departments
JOIN dept_emp using(dept_no)
JOIN salaries using(emp_no);