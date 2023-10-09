create database DBMS_Project;
create table Roles(
role_id int primary key auto_increment,
role_name varchar(55)
);
create table Employees(
employee_id int primary key auto_increment ,
name varchar(55),
phone_number int(10) unique,
role_id int,
FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

create table attendance_record(
record_id int primary key auto_increment,
employee_id int,
check_in datetime default now(),
check_out datetime,
date date default (current_date),
foreign key (employee_id) references employees(employee_id)
);

create table leave_record(
leave_request_id int primary key auto_increment,
employee_id int,
leave_type varchar(65),
start_date datetime,
end_date datetime,
status varchar(55) default "pending",
foreign key (employee_id) references employees(employee_id)
);

create table payroll_information(
id int primary key auto_increment,
employee_id int,
month int default (MONTH(current_date())),
year int default (year(current_date())),
salary float(7,4) ,
tax_deduction float(6,4),
net_pay float(7,4),
foreign key (employee_id) references employees(employee_id)
);

INSERT INTO roles (role_name)
VALUES ("HR"),("Employee");

select * from roles;

ALTER TABLE employees
MODIFY COLUMN phone_number varchar(10);

insert into employees (name,phone_number,role_id) values ("Nikhil Jose",1234567891,1),("Pankhuri Srivastava",7676767654,2),("Tanishka Dadhich",9876543210,2),("Dev Pratap",2536694744,2);
select * from employees;

ALTER TABLE employees
DROP FOREIGN KEY FK_role_id;

drop table roles;