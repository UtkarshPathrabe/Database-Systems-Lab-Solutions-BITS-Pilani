drop table students;

Create Table Students(idno char(12), name varchar2(30), dob date, cgpa number(4,2), age number(2));

select * from Students;

Insert Into Students Values('2012A7PS034P', 'Utkarsh A. Pathrabe', '18 Nov 1994', 9.09, 19);

Insert Into Students Values('2012A1PS501P', 'Prince Singhal', '22 Oct 1994', 8.10, 19);

Insert Into Students Values('2012A3PS040P', 'Arvind Mohan', '26 May 1995', 7.5, 18);

INSERT INTO students VALUES('1997B2A5563P', 'K Ramesh', '21-Jun- 75', 7.86, 27);

INSERT INTO students(name,idno,age) VALUES('R Suresh','1998A7PS003P',25);

drop table staff;

Create Table STAFF (sid number(10) NOT NULL, name varchar2(30), dept varchar2(20));

select * from Staff;

Insert Into Staff values('1234567890', 'Sudeept Mohan', 'Computer Science');

Insert into staff(name,dept, sid) values('Krishna Sharma', 'Practice School D.', '2345678901');

drop table course;

Create table course(compcode number(4) Unique, courseno varchar2(9) not Null Unique, Course_Name varchar2(30), Units number(2) Not Null);

drop table course;

Create table course(compcode number(4), courseno varchar2(9) not null, course_name varchar2(20), units number(2) not null, unique(compcode, courseno));

Select * from course;

drop table employee;

create table employee(empid number(4) primary key, name varchar2(30) not null);

Select * from Employee;

drop table registered;

create table registered(courseno varchar2(9), idno char(12), grade varchar2(10), primary key(courseno, idno));

Select * from registered;

drop table registered;

create table registered(courseno varchar2(9), idno char(12), grade varchar2(10), Constraint pk_registered primary key(courseno, idno));

Select * from registered;

drop table students;

Create table students(idno char(12), name varchar2(30), dob date, cgpa number(4,2), age number(2), constraint pk_students primary key(idno));

drop table course;

create table course(compcode number(4), courseno varchar2(9) not null, course_name varchar2(30), units number(2) not null, constraint un_course unique(compcode, courseno), constraint pk_course primary key(courseno));

drop table registered;

create table registered(courseno varchar2(9) references course, idno char(12) references students, grade varchar2(10), primary key(courseno, idno));

Select * from students;

Select * from course;

Select * from registered;

Select * from User_tables;

create table registered(courseno varchar2(9), idno char(11), grade varchar2(10), constraint pk_registered primary key(courseno, idno), constraint fk_cno foreign key(courseno) references course ON DELETE CASCADE, constraint fk_idno foreign key (idno) references students ON DELETE CASCADE);

create table students(idno char(12) primary key, name varchar2(30) not null, cgpa number(4,2) check(cgpa >= 2 and cgpa <= 10), roomno number(3) check(roomno > 99), hostel_code varchar2(2) check(hostel_code in ('VK', 'RP', 'MB')), age number(2), dob date);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

drop table category_details;

create table category_details(category_id number(2), category_name varchar2(30));

drop table sub_category_details;

create table sub_category_details(sub_category_id number(2), category_id number(2), sub_category_name varchar2(30));

drop table product_details;

create table product_details(product_id number(6), category_id number(2), sub_category_id number(2), product_name varchar2(30));

Select * from category_details;

Select * from sub_category_details;

Select * from product_details;

drop table employee;

create table employee(employee_id number(9) primary key, first_name varchar2(10), last_name varchar2(20), dept_code char(5), salary number(9,2));

drop table departments;

create table departments(code char(5) primary key, name varchar2(30), manager_id number(9), sub_dept_of char(5));

drop table projects;

create table projects(project_id char(8) primary key, dept_code char(5), description varchar2(200), start_date date, stop_date date, revenue number(12,2));

drop table workson;

create table workson(employee_id number(9), project_id char(8), assignedtime number(3,2));

alter table employee add constraint fk_employee_departments foreign key(dept_code) references departments(code) on delete cascade;

alter table departments add constraint fk_departments_employee foreign key(manager_id) references employee(employee_id) on delete cascade;

alter table departments add constraint fk_departments_subdepartments foreign key(sub_dept_of) references departments(code) on delete cascade;

alter table projects add constraint fk_projects_departments foreign key(dept_code) references departments(code) on delete cascade;

alter table workson add constraint fk_workson_employee foreign key(employee_id) references employee(employee_id) on delete cascade;

alter table workson add constraint fk_workson_projects foreign key(project_id) references projects(project_id) on delete cascade;

Select * From employee;

Select * From departments;

Select * From projects;

Select * From workson;