-- uc_1 create database 
create database payroll_service;
-- OUTPUT
--	#	Time	Action	Message	Duration / Fetch
--3	1	19:18:18	create database payroll_service	1 row(s) affected	0.031 sec
show databases;
-- OUTPUT
--3	2	19:33:08	show databases	6 row(s) returned	0.000 sec / 0.000 sec
--h2h
--information_schema
--mysql
--payroll_service
--performance_schema
--sys
use payroll_service;
-- OUTPUT
-- 3	3	19:36:10	use payroll_service	0 row(s) affected	0.000 sec

-- uc_2 Ability to create a employee payroll table in the payroll service database to manage employee payrolls
create table employee_payroll (
emp_id int auto_increment primary key,
name varchar(250),
salary decimal(10, 2),
start_date date
);

desc employee_payroll;
-- OUTPUT
--emp_id	int	NO	PRI		auto_increment
--name	varchar(250)	YES			
--salary	decimal(10,2)	YES			
--start_date	date	YES	

-- uc_3 Ability to create employee payroll data in the payroll service database as part of CURD Operation - Use payroll_service database
insert into employee_payroll (name, salary, start_date) 
values
('Ritika', 90000, '2023-12-12'),
('Joonie', 80000, '2022-12-11'),
('Bob',70000, '2020-02-01'),
('Melissa',75000,'2021-04-05');
-- OUTPUT 
-- 3	6	19:54:08	insert into employee_payroll (name, salary, start_date) 
 --values
 --('Ritika', 90000, '2023-12-12'),
 --('Joonie', 80000, '2022-12-11'),
 --('Bob',70000, '2020-02-01'),
 --('Melissa',75000,'2021-04-05')	4 row(s) affected
 --Records: 4  Duplicates: 0  Warnings: 0	0.000 sec

 -- uc_4 Ability to retrieve all the employee payroll data that is added to payroll service database
 select * from employee_payroll;
 -- OUTPUT
--1	Ritika	90000.00	2023-12-12
--2	Joonie	80000.00	2022-12-11
--3	Bob	70000.00	2020-02-01
--4	Melissa	75000.00	2021-04-05

-- uc_5 Ability to retrieve salary data for a particular employee as well as all employees who have joined in a particular data range from the payroll service database
select * from employee_payroll where name = 'Ritika';
-- OUTPUT
-- 1	Ritika	90000.00	2023-12-12
select * from employee_payroll where start_date between cast('2021-01-01' as date) and current_date();
-- OUTPUT
-- 2	Joonie	80000.00	2022-12-11
-- 4	Melissa	75000.00	2021-04-05

-- uc_6 Ability to add Gender to Employe Payroll Table and Update the Rows to reflect the correct Employee Gender
ALTER TABLE employee_payroll
ADD COLUMN gender VARCHAR(10);
desc employee_payroll;
-- OUTPUT
--emp_id	int	NO	PRI	
--name	varchar(250)	YES		
--salary	decimal(10,2)	YES		
--start_date	date	YES		
--gender	varchar(10)	YES		
update employee_payroll set gender='M' where name in ('Bob', 'Joonie') ;
update employee_payroll set gender='F' where name in ('Ritika', 'Melissa');
select * from employee_payroll;
-- OUTPUT
--1	Ritika	90000.00	2023-12-12	F
--2	Joonie	80000.00	2022-12-11	M
--3	Bob	70000.00	2020-02-01	M
--4	Melissa	75000.00	2021-04-05	F

-- uc_7 Ability to find sum, average, min, max and number of male and female employees
SELECT
    SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) AS MaleCount,
    SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS FemaleCount,
    AVG(CASE WHEN gender = 'M' THEN Salary ELSE 0 END) AS AverageMaleSalary,
    AVG(CASE WHEN gender = 'F' THEN Salary ELSE 0 END) AS AverageFemaleSalary,
    MIN(CASE WHEN gender = 'M' THEN Salary ELSE NULL END) AS MinMaleSalary,
    MIN(CASE WHEN gender = 'F' THEN Salary ELSE NULL END) AS MinFemaleSalary,
    MAX(CASE WHEN gender = 'M' THEN Salary ELSE NULL END) AS MaxMaleSalary,
    MAX(CASE WHEN gender = 'F' THEN Salary ELSE NULL END) AS MaxFemaleSalary
FROM
    employee_payroll;

--OUTPUT
--2	2	37500.000000	41250.000000	70000.00	75000.00	80000.00	90000.00