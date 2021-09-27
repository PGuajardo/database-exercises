
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


-- DO I MORPH the table itself?
-- UPDATE payment_with_cents SET amount = amount DECIMAL(7,0);

-- 3. Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. 
USE employees;

CREATE TEMPORARY TABLE hopper_1543.current_average_pay AS 
SELECT * FROM salaries
JOIN dept_emp using(emp_no)
JOIN departments using(dept_no);


-- In terms of salary, what is the best department right now to work for? 

-- The worst?