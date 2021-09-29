
-- 1. Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
USE employees;

SELECT emp_no, dept_no, hire_date, to_date,
		IF(dept_emp.to_date > NOW(), True, False) AS is_current_employee
FROM employees
JOIN dept_emp using(emp_no);

-- 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT first_name, last_name,
	CASE
		WHEN last_name BETWEEN 'A%' AND 'H%' THEN 'A-H'
		WHEN last_name BETWEEN 'I%' AND 'Q%' THEN 'I-Q'
		ELSE 'R-Z'
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


SELECT 
       CASE 
           WHEN dept_name IN ('research', 'development') THEN 'R&D'
           WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing' 
           WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
           	  WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
           ELSE dept_name
           END AS dept_group,
           AVG(salary) AS Average_Salary
FROM departments
JOIN dept_emp using(dept_no)
JOIN salaries using(emp_no)
WHERE salaries.to_date > NOW() AND dept_emp.to_date > NOW()
GROUP BY dept_group
ORDER BY dept_group;