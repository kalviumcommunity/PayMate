create database DBMS_Project;
create table Roles(
    role_id int primary key auto_increment,
    role_name varchar(55)
);
create table Employees(
    employee_id int primary key auto_increment,
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
    salary float(7, 4),
    tax_deduction float(6, 4),
    net_pay float(7, 4),
    foreign key (employee_id) references employees(employee_id)
);
INSERT INTO roles (role_name)
VALUES ("HR"),("Employee");

select *from roles;

ALTER TABLE employees
MODIFY COLUMN phone_number varchar(10);

-- insert into employees (name, phone_number, role_id)
-- values
-- ("Nikhil Jose", 1234567891, 1),
-- ("Pankhuri Srivastava", 7676767654, 2),
-- ("Tanishka Dadhich", 9876543210, 2),
-- ("Dev Pratap", 2536694744, 2);

select *from employees;

ALTER TABLE employees DROP FOREIGN KEY FK_role_id;

drop table roles;
-- milestone-3
select * from employees;

insert into employees (name, phone_number, role_id)
values
("Nikhil Jose", "1234567891", 1),
("Pankhuri Srivastava", "7676767654", 2),
("Tanishka Dadhich", "9876543210", 2),
("Dev Pratap", "2536694744", 2);

select *from employees;

select *from attendance_record;

insert into attendance_record (employee_id) values (3);

select * from attendance_record;

select * from leave_record;

insert into leave_record (employee_id, leave_type, start_date, end_date)
values (3, "medical", now(), "2023-10-5 12:00:00");

ALTER TABLE payroll_information ALTER tax_deduction
SET DEFAULT (salary * 0.1);

ALTER TABLE payroll_information ALTER net_pay
SET DEFAULT (salary - tax_deduction);

describe payroll_information;

select * from payroll_information;

insert into payroll_information(employee_id, salary)
values(3, 50000);

select * from payroll_information;

UPDATE payroll_information
SET salary = 60000, tax_deduction = salary * 0.1, net_pay = salary - tax_deduction
WHERE employee_id = 3;

select * from employees;

UPDATE employees SET phone_number = "0000000000"
WHERE employee_id = 3;

DELETE FROM leave_record
WHERE status = "pending" and employee_id = 3;

--  milestone 4

CREATE ROLE HR;
CREATE ROLE Employee;
CREATE ROLE DB_Admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON DBMS_Project.* TO HR;
GRANT SELECT, INSERT, UPDATE, DELETE ON DBMS_Project.attendance_record TO Employee;
GRANT SELECT, INSERT, UPDATE, DELETE ON DBMS_Project.leave_record TO Employee;
GRANT SELECT ON DBMS_Project.* TO Employee;
GRANT ALL PRIVILEGES ON DBMS_Project.* TO DB_Admin;
CREATE USER 'HR_User'@'localhost' IDENTIFIED BY 'hr_password';

CREATE USER 'Employee_User'@'localhost' IDENTIFIED BY 'employee_password';
CREATE USER 'DB_Admin_User'@'localhost' IDENTIFIED BY 'db_admin_password';

GRANT HR TO 'HR_User'@'localhost';
GRANT Employee TO 'Employee_User'@'localhost';
GRANT DB_Admin TO 'DB_Admin_User'@'localhost';
SET DEFAULT ROLE HR TO 'HR_User'@'localhost';
SET DEFAULT ROLE Employee TO 'Employee_User'@'localhost';
SET DEFAULT ROLE DB_Admin TO 'DB_Admin_User'@'localhost';