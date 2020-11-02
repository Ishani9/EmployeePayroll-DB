#UC 1
create database emp_payroll;
show databases;
use emp_payroll;

#UC 2
create table employee_payroll
(
id 		int unsigned not null auto_increment,
name 		varchar(100) not null,
salary 		double not null,
start		date not null,
primary key	(id)
);
describe employee_payroll;

#UC 3
insert into employee_payroll (name, salary, start) values
('Bill', 100000.00, '2018-01-03'),
('Terise', 200000.00, '2019-11-13'),
('Charlie', 500000.00, '2020-05-21');

#UC 4
select * from employee_payroll;

#UC 5
select salary from employee_payroll where name = 'Bill';
select * from employee_payroll
	 where start between cast('2018-01-01' as date) and date(now());
     
#UC 6
alter table employee_payroll		
add gender char(1)	after name;
update employee_payroll set gender = 'M' 
	where name = 'Bill' or name = 'Charlie';
update employee_payroll set gender = 'F' 
	where name = 'Terise';
update employee_payroll set salary = 300000.00 
	 where name = 'Terise';
select * from employee_payroll;

#UC 7
select gender, sum(salary) from employee_payroll 
	 where gender = 'F' group by gender;
select gender, sum(salary) from employee_payroll  
	 where gender = 'M' group by gender;
select gender, sum(salary) from employee_payroll group by gender;
select gender, avg(salary) from employee_payroll group by gender;
select gender, min(salary) from employee_payroll group by gender;
select gender, max(salary) from employee_payroll group by gender;
select gender, count(*) from employee_payroll group by gender;

# UC 8
alter table employee_payroll 
	add phone 		numeric(10) not null after name,
	add address		 varchar(200) not null default 'INDIA' after phone,
	add department 	varchar(200) not null after address;
    
#UC 9
alter table employee_payroll rename column salary to basic_pay, 
	add deductions double not null after basic_pay, 
	add taxable_pay double not null after deductions, 
	add tax double not null after taxable_pay, 
	add net_pay double not null after tax;
    
#UC 10
update employee_payroll set department = 'Sales' where name = 'Terise';
insert into employee_payroll (name,phone, department, gender, basic_pay, deductions, taxable_pay, tax, net_pay, start) values 
('Terise', 9000900088, 'Marketing', 'F', 400000, 50000, 350000, 10000, 340000, '2019-11-13');

# UC 12
create table Company(
    company_id int not null,
    company_name varchar(50) not null,
    primary key(company_id)
    );

 create table Department (
     dept_id int not null,
     dept_name varchar(50) not null,
     primary key(dept_id)
     );
     
create table Employee(
	emp_id int unsigned not null auto_increment primary key,
	company_id int not null,
   dept_id int not null,
   firstName varchar(50) not null,
   lastName varchar(50) not null,
   address varchar(50) not null,
   phoneNo long,
   gender char(1),
   foreign key(company_id) references company(company_id),
   foreign key(dept_id) references department(dept_id)
   );
   
create table payroll(
    emp_id int unsigned not null auto_increment primary key,
    basic_pay double not null,
    deductions double not null,
    taxable_income double not null,
    income_tax double not null,
    net_pay double not null,
    foreign key (emp_id) references employee(emp_id)
    );
    
create table emp_dept
(
emp_id int unsigned not null,
dept_id int not null,
foreign key (emp_id)  references employee (emp_id),
foreign key (dept_id) references department (dept_id)
);