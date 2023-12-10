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

-- uc_8 Ability to extend employee_payroll data to store employee information like employee phone, address and department - Ensure employee department
alter table employee_payroll add column phone varchar(20), add column address varchar(50), add column department varchar(20);
update employee_payroll set phone = "91 7373737373", address = "werwe", department = "Management" where emp_id = 1;
update employee_payroll set phone = "91 2121212121", address = "vbnvc", department = "Sales" where emp_id = 2;
update employee_payroll set phone = "91 7171717171", address = "fhffh", department = "Marketing" where emp_id = 3;
update employee_payroll set phone = "91 8383838383", address = "sdfgs", department = "Management" where emp_id = 4;
select * from employee_payroll;
-- OUTPUT
--1	Ritika	90000.00	2023-12-12	F	91 7373737373	werwe	Management
--2	Joonie	80000.00	2022-12-11	M	91 2121212121	vbnvc	Sales
--3	Bob	70000.00	2020-02-01	M	91 7171717171	fhffh	Marketing
--4	Melissa	75000.00	2021-04-05	F	91 8383838383	sdfgs	Management

-- uc_9 Ability to extend employee_payroll table to have Basic Pay,Deductions, Taxable Pay,Income Tax, Net Pay
alter table employee_payroll add column deductions int, add column taxable_pay int, add column income_tax int, add column net_pay int;
update employee_payroll set deductions = 100, taxable_pay = 100, income_tax = 100, net_pay = 10000 where emp_id = 1;
update employee_payroll set deductions = 200, taxable_pay = 200, income_tax = 200, net_pay = 20000 where emp_id = 2;
update employee_payroll set deductions = 300, taxable_pay = 300, income_tax = 300, net_pay = 30000 where emp_id = 3;
update employee_payroll set deductions = 400, taxable_pay = 400, income_tax = 400, net_pay = 40000 where emp_id = 4;
select * from employee_payroll;
--OUTPUT
--1	Ritika	90000.00	2023-12-12	F	91 7373737373	werwe	Management	100	100	100	10000
--2	Joonie	80000.00	2022-12-11	M	91 2121212121	vbnvc	Sales	200	200	200	20000
--3	Bob	70000.00	2020-02-01	M	91 7171717171	fhffh	Marketing	300	300	300	30000
--4	Melissa	75000.00	2021-04-05	F	91 8383838383	sdfgs	Management	400	400	400	40000

-- uc_10 Ability to make Terissa as part of Sales and Marketing Department
insert into employee_payroll(name, salary, start_date, gender, phone, address, department, deductions, taxable_pay, income_tax, net_pay) values
 ("Terissa", 60000, "2022-10-07", "F", "91 4646464646", "qwert", "Sales", 500, 500, 500, 50000),
 ("Terissa", 60000, "2022-10-07", "F", "91 4646464646", "qwert", "Marketing",500, 500, 500, 50000);
select * from employee_payroll;
--OUTPUT
--1	Ritika	90000.00	2023-12-12	F	91 7373737373	werwe	Management	100	100	100	10000
--2	Joonie	80000.00	2022-12-11	M	91 2121212121	vbnvc	Sales	200	200	200	20000
--3	Bob 	70000.00	2020-02-01	M	91 7171717171	fhffh	Marketing	300	300	300	30000
--4	Melissa	75000.00	2021-04-05	F	91 8383838383	sdfgs	Management	400	400	400	40000
--5	Terissa	60000.00	2022-10-07	F	91 4646464646	qwert	Sales	500	500	500	50000
--6	Terissa	60000.00	2022-10-07	F	91 4646464646	qwert	Marketing	500	500	500	50000	

--UC_11 Draw the ER Diagram for Payroll Service DB
alter table employee_payroll drop column department; 
delete from employee_payroll where name = "Terissa";
insert into employee_payroll(name, salary, start_date, gender, phone, address, deductions, taxable_pay, income_tax, net_pay) values 
	("Terissa", 60000, "2022-10-07", "F", "91 4646464646", "qwert", 500, 500, 500, 50000);
select * from employee_payroll;
--1	Ritika	90000.00	2023-12-12	F	91 7373737373	werwe	100	100	100	10000
--2	Joonie	80000.00	2022-12-11	M	91 2121212121	vbnvc	200	200	200	20000
--3	Bob 	70000.00	2020-02-01	M	91 7171717171	fhffh	300	300	300	30000
--4	Melissa	75000.00	2021-04-05	F	91 8383838383	sdfgs	400	400	400	40000
--7	Terissa	60000.00	2022-10-07	F	91 4646464646	qwert	500	500	500	50000
create table departments(
	dep_id int not null auto_increment primary key,
    department varchar(20)
);
desc departments;
--dep_id	int	NO	PRI		auto_increment
--department	varchar(20)	YES			
insert into departments(department) values ("Management"), ("Sales"), ("Marketing");
select * from departments;
--1	Management
--2	Sales
--3	Marketing
create table employee_departments(
	emp_id int not null,
    dep_id int not null,
    foreign key(emp_id) references employee_payroll(emp_id),
    foreign key(dep_id) references departments(dep_id)
);
desc employee_departments;
--emp_id	int	NO	MUL		
--dep_id	int	NO	MUL		
insert into employee_departments(emp_id, dep_id) values
	(1,1), (2,2), (3,3), (4,1), (7,2), (7,3);
select * from employee_departments;
--1	1
--2	2
--3	3
--4	1
--7	2
--7	3

--Ensure all retrieve queries done especially in UC 4, UC 5 and UC 7 are working with new table structure
select 
	ep.emp_id,
    ep.name,
    ep.salary,
    ep.start_date,
    ep.gender,
    ep.phone,
    ep.address,
    ep.deductions,
    ep.taxable_pay,
    ep.income_tax,
    ep.net_pay,
    dep.department
from employee_payroll ep inner join employee_departments ed on ep.emp_id = ed.emp_id 
	inner join departments dep on ed.dep_id = dep.dep_id;
--OUTPUT
--1	Ritika	90000.00	2023-12-12	F	91 7373737373	werwe	100	100	100	10000	Management
--4	Melissa	75000.00	2021-04-05	F	91 8383838383	sdfgs	400	400	400	40000	Management
--2	Joonie	80000.00	2022-12-11	M	91 2121212121	vbnvc	200	200	200	20000	Sales
--7	Terissa	60000.00	2022-10-07	F	91 4646464646	qwert	500	500	500	50000	Sales
--3	Bob 	70000.00	2020-02-01	M	91 7171717171	fhffh	300	300	300	30000	Marketing
--7	Terissa	60000.00	2022-10-07	F	91 4646464646	qwert	500	500	500	50000	Marketing
select 
	ep.emp_id,
    ep.name,
    ep.salary,
    ep.start_date,
    ep.gender,
    ep.phone,
    ep.address,
    ep.deductions,
    ep.taxable_pay,
    ep.income_tax,
    ep.net_pay,
    dep.department
from employee_payroll ep inner join employee_departments ed on ep.emp_id = ed.emp_id 
	inner join departments dep on ed.dep_id = dep.dep_id where name="Ritika";
--OUTPUT
--1	Ritika	90000.00	2023-12-12	F	91 7373737373	werwe	100	100	100	10000	Management
select 
	ep.emp_id,
    ep.name,
    ep.salary,
    ep.start_date,
    ep.gender,
    ep.phone,
    ep.address,
    ep.deductions,
    ep.taxable_pay,
    ep.income_tax,
    ep.net_pay,
    dep.department
from employee_payroll ep inner join employee_departments ed on ep.emp_id = ed.emp_id 
	inner join departments dep on ed.dep_id = dep.dep_id 
    where start_date between cast('2021-01-01' as date) and current_date();
--OUTPUT
--2	Joonie	80000.00	2022-12-11	M	91 2121212121	vbnvc	200	200	200	20000	Sales
--4	Melissa	75000.00	2021-04-05	F	91 8383838383	sdfgs	400	400	400	40000	Management
--7	Terissa	60000.00	2022-10-07	F	91 4646464646	qwert	500	500	500	50000	Sales
--7	Terissa	60000.00	2022-10-07	F	91 4646464646	qwert	500	500	500	50000	Marketing
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
--2	3	30000.000000	45000.000000	70000.00	60000.00	80000.00	90000.00