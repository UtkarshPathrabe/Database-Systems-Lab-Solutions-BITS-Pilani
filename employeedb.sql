drop table workson;
drop table projects;
alter table departments drop constraint fk_departments_subdepartments;
alter table departments drop constraint fk_departments_employee;
alter table employees drop constraint fk_employee_departments;
drop table departments;
drop table employees;

Select * from user_tables;

CREATE TABLE employees (
employeeid Number(9) NOT NULL,
firstname VARCHAR2(10),
lastname VARCHAR2(20),
deptcode CHAR(5),
salary Number(9, 2),
  PRIMARY KEY(employeeid)
);

Select * from employees;

CREATE TABLE departments (
  code CHAR(5) NOT NULL,
  name VARCHAR2(30),
  manager_id number(9),
  subdeptof CHAR(5),
  constraint pk_department PRIMARY KEY(code),
  constraint fk_departments_employee FOREIGN KEY(manager_id) REFERENCES employees(employeeid) ON DELETE CASCADE,
  constraint fk_departments_subdepartments FOREIGN KEY(subdeptof) REFERENCES departments(code) ON DELETE CASCADE
);

ALTER TABLE employees ADD constraint fk_employee_departments foreign key (deptcode) REFERENCES departments(code) ON DELETE CASCADE;

Select * from departments;

CREATE TABLE projects (
  projectid CHAR(8) NOT NULL,
  deptcode CHAR(5),
  description VARCHAR2(200),
  startdate DATE DEFAULT sysdate,
  enddate DATE,
  revenue Number(12, 2),
  PRIMARY KEY(projectid),
  FOREIGN KEY(deptcode) REFERENCES departments(code) ON DELETE CASCADE
);

Select * from projects;

CREATE TABLE workson (
  employeeid Number(9) NOT NULL,
  projectid CHAR(8) NOT NULL,
  assignedtime DECIMAL(3,2),
  PRIMARY KEY(employeeid, projectid),
  FOREIGN KEY(employeeid) REFERENCES employees(employeeid) ON DELETE CASCADE,
  FOREIGN KEY(projectid) REFERENCES projects(projectid) ON DELETE CASCADE
);

Select * from workson;

INSERT INTO departments VALUES ('ADMIN', 'Administration', NULL, NULL);
INSERT INTO departments VALUES ('ACCNT', 'Accounting', NULL, 'ADMIN');
INSERT INTO departments VALUES ('CNSLT', 'Consulting', NULL, 'ADMIN');
INSERT INTO departments VALUES ('HDWRE', 'Hardware', NULL, 'CNSLT');
INSERT INTO departments VALUES ('ACTNG', 'Acting', NULL, NULL);

Select * from departments;

INSERT INTO employees VALUES (1, 'Al', 'Betheleader', 'ADMIN', 70000);
INSERT INTO employees VALUES (2, 'PI', 'Rsquared', 'ACCNT', 40000);
INSERT INTO employees VALUES (3, 'Harry', 'Hardware', 'HDWRE', 50000);
INSERT INTO employees VALUES (4, 'Sussie', 'Software', 'CNSLT', 60000);
INSERT INTO employees VALUES (5, 'Abe', 'Advice', 'ACTNG', 30000);
INSERT INTO employees VALUES (6, 'Hardly', 'Aware', NULL, 65000);
INSERT INTO employees VALUES (7, 'Sigma', 'Quad', 'ACCNT', 35000);

Select * from employees;

UPDATE departments SET manager_id = '1' WHERE code = 'ADMIN';
UPDATE departments SET manager_id = '2' WHERE code = 'ACCNT';
UPDATE departments SET manager_id = '3' WHERE code = 'HDWRE';
UPDATE departments SET manager_id = '4' WHERE code = 'CNSLT';
UPDATE departments SET manager_id = '5' WHERE code = 'ACTNG';

Select * from departments;

INSERT INTO projects VALUES ('EMPHAPPY', 'ADMIN', 'Employee Moral', '14-MAR-2002', NULL, 0);
INSERT INTO projects VALUES ('ROBOSPSE', 'CNSLT', 'Robotic Spouse', '14-MAR-2002', NULL, 200000);
INSERT INTO projects VALUES ('ADT4MFIA', 'ACCNT', 'Mofia Audit', '03-JUL-2003', '30-NOV-2003', 100000);
INSERT INTO PROJECTS VALUES ('DNLDCLNT', 'CNSLT', 'Download Client', '03-FEB-2005', NULL, 15000);
Insert into projects values ('EMPHAPPZ', 'ACTNG', 'Employee Spouse', NULL, Null, 23000);

Select * from projects;

INSERT INTO workson VALUES (2, 'ADT4MFIA', 0.50);
INSERT INTO workson VALUES (3, 'ROBOSPSE', 0.75);
INSERT INTO workson VALUES (4, 'ROBOSPSE', 0.75);
INSERT INTO workson VALUES (5, 'ROBOSPSE', 0.50);
INSERT INTO workson VALUES (5, 'ADT4MFIA', 0.40);
INSERT INTO workson VALUES (3, 'DNLDCLNT', 0.25);

Select * from workson;