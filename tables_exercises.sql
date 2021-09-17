-- Use the employees DB
USE employees;

-- List the tables in the DB
show tables;

-- Exploring the Employees table
describe employees;

-- Exploring the other tables and their datatypes
describe departments;
describe salaries;
describe titles;
describe dept_manager;
describe dept_emp_latest_date;
describe dept_emp;
describe current_dept_emp;

-- Relation ship between employee and dept is in dept_emp which uses both id numbers
-- Showing the sql that created the dept_manager
show create table dept_manager;