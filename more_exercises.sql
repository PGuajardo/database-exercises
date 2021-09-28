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


