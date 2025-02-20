-- TO CREATE A DATABASE
create database worker_sys;

-- TO VIEW ALL THE DATABASES
SELECT * FROM pg_database;

-- TO VIEW THE ALL DATABASE NAMES
SELECT datname FROM pg_database;

-- TO VIEW THE CURRENT DATABASE
select current_database();

-- TO CREATE A NEW TABLE
create table roles (
	id serial primary key,
	role_name varchar(100) unique not null
);

-- TO VIEW ALL THE TABLES IN THE DATABASE
SELECT * FROM pg_tables;
SELECT tablename FROM pg_tables;

-- CREATE TABLE FOR DEPARTMENTS
create table departments (
	id serial primary key,
	name varchar (100) unique not null
);

-- CREATE TABLE FOR WORKERS
CREATE TABLE workers (
	id serial primary key,
	name varchar(100) not null,
	email varchar (100) unique not null,
	phone varchar(15),
	department_id int references departments(id) on delete set null,
	role_id int references roles(id) on delete set null,
	salary decimal(10, 2) check (salary > 0),
	joined_on date default current_date
);

DROP TABLE attendance;
SELECT tablename FROM pg_tables;

-- CREATE A TABLE FOR ATTENDANCE OF THE WORKERS
CREATE TABLE attendance (
	id SERIAL PRIMARY KEY,
	worker_id INT REFERENCES workers(id) ON DELETE CASCADE,
	check_in TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	check_out TIMESTAMP
);

-- CREATE A SAMPLE TABLE
CREATE TABLE sample_table (
	id SERIAL PRIMARY KEY,
	uname VARCHAR (100) UNIQUE NOT NULL
);

SELECT tablename FROM pg_tables;

-- DELETE TABLE FROM THE DATABASE
DROP TABLE sample_table;

-- CRUD

-- INSERT NEW DATA TO ROLES
INSERT INTO roles(role_name) VALUES ('manager'), ('developer'), ('designer'), ('tester');
SELECT * FROM roles;

-- INERT A NEW DEPARTMENT
SELECT * FROM departments;
INSERT INTO departments (name) VALUES ('productivity'), ('f3-engine');

-- INSERT A NEW WORKERS
SELECT * FROM workers;
INSERT INTO workers (name, email, phone, department_id, role_id, salary) values ('jaisrinivasan', 'jaii123@gmail.com', '+919384284280', 2, 2, 85000.00), ('sujitha', 'suitha123@gmail.com', '+919384284280', 2, 1, 90000.00);

-- INSERT AN ATTENDANCE TO THE WORKERS
INSERT INTO attendance (worker_id) VALUES (4);
SELECT * FROM attendance;

-- TRUNCATE [DELTE DATA OF THE TABLE] TABLE
TRUNCATE TABLE attendance;

-- TIMESTAMPS

-- TIMESTAMPS WITH TIMEZONES
SELECT NOW();
SELECT CURRENT_TIMESTAMP;

-- TIMESTAMPS WITHOUT TIMEZONE
SELECT LOCALTIMESTAMP;

-- CURRENT DATE
SELECT CURRENT_DATE;

-- TIME OF DAY
SELECT TIMEOFDAY();

-- EXTRACT() FROM THE NOW()
SELECT EXTRACT(YEAR FROM NOW());

-- INSERT ATTENDANCE CHECKOUT
INSERT INTO attendance (worker_id, check_out) VALUES (1, LOCALTIMESTAMP);

-- SELECT QUERIES
SELECT * FROM workers;
SELECT name, email from workers;
SELECT id, name FROM workers WHERE salary > 82000.00;

SELECT workers.name AS employee, departments.name AS department FROM workers JOIN departments ON workers.department_id = departments.id;
SELECT workers.name, departments.name AS department FROM workers JOIN departments ON workers.department_id = departments.id WHERE departments.name = 'f3-engine';

SELECT workers.name AS emplyee_name, attendance.check_in, attendance.check_out FROM workers JOIN attendance ON attendance.worker_id = workers.id;

-- UPDATE worker
select * from departments;
UPDATE workers SET name = 'gdevakrishnan' WHERE id = 1;

-- DELETE WORKER
DELETE FROM workers WHERE id = 3;

SELECT workers.name, departments.name AS department FROM workers JOIN departments ON workers.department_id = departments.id;

-- CHECKOUT THE WORKER
SELECT * FROM attendance;
UPDATE attendance SET check_out = LOCALTIMESTAMP WHERE worker_id = 2;

SELECT workers.name, departments.name AS department, attendance.check_in, attendance.check_out FROM workers JOIN attendance ON workers.id = attendance.worker_id JOIN departments ON departments.id = workers.department_id;

TRUNCATE attendance RESTART IDENTITY;

-- ----------------------------------------

-- JOINS
-- TYPES OF JOINS ARE
	-- INNER JOIN [DEFAULT: JOIN]
	-- LEFT JOIN : Ensures all rows from 'customers' are shown, even if they have no 'orders'
	-- RIGHT JOIN : ensures all rows from 'orders' are shown, even if they have no 'customers'
	-- UNION : It joins the table without duplicates
	-- UNION ALL : It joins the table with duplicates
	-- FULL JOIN : Returns all rows in both the tables
	-- CROSS JOIN : It joins the table by all possible ways in cross paths

-- MOSTLY WE ARE USING INNER JOIN [DEFAULT: JOIN] AND LEFT JOIN


-- ----------------------------------------

-- AGGREGATIONS
	-- Basically, aggregations are the functions available in sql.

select * from workers where workers.name like 'j%';  -- j% equals to %j%
select * from workers where workers.name like '%d%';

select * from workers;

select count (*)
from workers;

select count (*)
from workers where workers.salary > 82000.00;

select sum(salary) as total_salary from workers;
select avg(salary) as average_salary from workers;
select round(avg (salary), 2) as average_salary from workers;

select max(salary) from workers;
select * from workers where salary = (select max(salary) from workers);

select min(salary) from workers;
select * from workers where salary = (select min(salary) from workers);