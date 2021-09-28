
USE employees;

/*1. Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department.
 Be absolutely sure to create this table on your own database. 
 If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.*/
 
CREATE TEMPORARY TABLE hopper_1543.employees_with_departments AS
SELECT first_name, last_name, dept_name 
FROM employees
JOIN dept_emp using(emp_no)
JOIN departments using(dept_no)
WHERE dept_emp.to_date > NOW();

USE hopper_1543;
SELECT * FROM employees_with_departments;

 -- Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns 
 ALTER TABLE employees_with_departments ADD full_name VARCHAR(31);
 
 -- Update the table so that full name column contains the correct data
 UPDATE employees_with_departments SET full_name = CONCAT(first_name , ' ' , last_name);
 
 -- Remove the first_name and last_name columns from the table.
 ALTER TABLE employees_with_departments DROP COLUMN first_name;
 ALTER TABLE employees_with_departments DROP COLUMN last_name;
 -- What is another way you could have ended up with this same table?
 
 USE employees;
 
CREATE TEMPORARY TABLE hopper_1543.employees_with_departments2 AS
SELECT CONCAT(first_name, ' ', last_name) AS full_name, dept_name 
FROM employees
JOIN dept_emp using(emp_no)
JOIN departments using(dept_no)
WHERE dept_emp.to_date > NOW();


USE hopper_1543;
SELECT * FROM employees_with_departments2;


/* 2. Create a temporary table based on the payment table from the sakila database.*/

USE sakila;

CREATE TEMPORARY TABLE hopper_1543.payment_with_cents AS
SELECT * FROM payment;

USE hopper_1543;
SELECT * FROM payment_with_cents;
-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.

ALTER TABLE payment_with_cents ADD amount_in_cents INT(10);
UPDATE payment_with_cents SET amount_in_cents = amount*100;


ALTER TABLE payment_with_cents MODIFY amount INT;
UPDATE payment_with_cents SET amount = amount*100;
UPDATE payment_with_cents SET amount = amount_in_cents;

ALTER TABLE payment_with_cents DROP COLUMN amount_in_cents;
-- 3. Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. 
USE employees;


#Creating a. temporary table
# with just departments and their respective average salaries
CREATE TEMPORARY TABLE hopper_1543.current_average_pay AS
SELECT dept_name, AVG(salary) AS Current_AVG, STDDEV(salary) AS Standard_Deviation
FROM salaries
JOIN dept_emp using(emp_no)
JOIN departments using(dept_no)
WHERE dept_emp.to_date > NOW() AND salaries.to_date > NOW()
GROUP BY dept_name;


USE hopper_1543;
SELECT * FROM current_average_pay;

# CREATED Z SCORE Table and historic averagae
ALTER TABLE current_average_pay ADD Historic_Avg DECIMAL(14,4);
ALTER TABLE current_average_pay ADD Z_SCORE FLOAT;
ALTER TABLE current_average_pay ADD Historic_STDDEV DOUBLE;

#Changing table
# Create table with historic values with another temporary table
#
#
USE employees;
CREATE TEMPORARY TABLE hopper_1543.historic_average_stddev AS
SELECT dept_name, AVG(salary) AS Hisoric_avg, STDDEV(salary) AS historic_Deviation
FROM salaries
JOIN dept_emp using(emp_no)
JOIN departments using(dept_no)
GROUP BY dept_name;

USE hopper_1543;
SELECT * FROM historic_average_stddev;

# Setting Historic Avg with other temporary table
UPDATE current_average_pay a, historic_average_stddev b SET a.Historic_Avg = b.Hisoric_avg WHERE a.dept_name = b.dept_name;
# SETTING stddev with other temporary table
UPDATE current_average_pay a, historic_average_stddev b SET a.Historic_STDDEV = b.historic_Deviation WHERE a.dept_name = b.dept_name;
# setting z score with those averages
UPDATE current_average_pay SET Z_SCORE = (Current_AVG - Historic_Avg) / Standard_Deviation;

DESCRIBE current_average_pay;
-- In terms of salary, what is the best department right now to work for? The worst?
-- Sales, the worst is human resources

