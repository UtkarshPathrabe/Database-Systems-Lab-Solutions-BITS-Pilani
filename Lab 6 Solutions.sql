DROP VIEW VRS;

CREATE VIEW vrs AS
SELECT ingredientid, name, inventory, inventory * unitprice AS value
FROM ingredients i, vendors v
WHERE i.vendorid = v.vendorid AND companyname = 'Veggies_R_Us';

SELECT * from vrs;

SELECT name
FROM vrs
WHERE inventory > 100;

SELECT name
FROM ingredients i, vendors v
WHERE i.vendorid = v.vendorid AND companyname = 'Veggies_R_Us'
AND inventory > 100;

UPDATE ingredients
SET inventory = inventory * 2
WHERE ingredientid = 'TOMTO';

SELECT * from vrs;

DROP VIEW MENUITEMS;

CREATE VIEW menuitems (menuitemid, name, price) AS
(SELECT m.mealid, m.name, CAST(SUM(price * (1-discount)) AS NUMERIC(5,2))
FROM meals m LEFT OUTER JOIN partof p ON m.mealid = p.mealid LEFT OUTER JOIN items i ON p.itemid = i.itemid
GROUP BY m.mealid, m.name)
UNION
(SELECT itemid, name, price
FROM items);

Select * from menuitems;

SELECT name
FROM menuitems
WHERE price =
  (SELECT MAX(price)
  FROM menuitems);

SELECT COUNT(*) AS "PRICELESS ITEMS"
FROM menuitems
WHERE price IS NULL;

UPDATE vrs SET inventory = inventory * 2;

SELECT * FROM vrs;

INSERT INTO vrs(ingredientid, name, inventory) VALUES('NEWIN','New ingredient',100);

SELECT * FROM vrs;

CREATE OR REPLACE VIEW vrs AS
SELECT ingredientid, name, inventory, inventory * unitprice AS value
FROM ingredients i, vendors v
WHERE i.vendorid = v.vendorid AND companyname = 'Spring Water Supply';

drop VIEW vrs;

****************************************************************************************************************************************************************
DROP VIEW EWP;

CREATE VIEW ewp AS
SELECT e.EMPLOYEEID, e.FIRSTNAME || ' ' || e.LASTNAME AS "NAME", e.DEPTCODE, e.SALARY, w.ASSIGNEDTIME
FROM EMPLOYEES e LEFT OUTER JOIN WORKSON w ON e.EMPLOYEEID = w.EMPLOYEEID LEFT OUTER JOIN PROJECTS p ON w.PROJECTID = p.PROJECTID
WHERE p.DESCRIPTION = 'Robotic Spouse';

SELECT * FROM ewp;

SELECT "NAME"
FROM ewp
WHERE ASSIGNEDTIME = 
  (SELECT MAX(ASSIGNEDTIME)
  FROM ewp);

DROP VIEW ed;

CREATE VIEW ed AS
SELECT e.EMPLOYEEID, e.FIRSTNAME || ' ' || e.LASTNAME AS "EMPLOYEE NAME", e.DEPTCODE, e.SALARY, d.NAME AS "DEPARTMENT NAME"
FROM EMPLOYEES e LEFT OUTER JOIN DEPARTMENTS d ON e.DEPTCODE = d.CODE
ORDER BY e.EMPLOYEEID;

SELECT * FROM ed;

SELECT "EMPLOYEE NAME"
FROM ed
WHERE "DEPARTMENT NAME" = 'Consulting';

DROP VIEW pwe;

CREATE VIEW pwe AS
SELECT p.projectid, p.deptcode, p.description, p.startdate, p.enddate, p.revenue, w.assignedtime
FROM PROJECTS p LEFT OUTER JOIN WORKSON w ON p.PROJECTID = w.PROJECTID LEFT OUTER JOIN EMPLOYEES e ON w.EMPLOYEEID = e.EMPLOYEEID
WHERE e.FIRSTNAME = 'Abe' AND e.LASTNAME = 'Advice';

SELECT * FROM pwe;

SELECT SUM(ASSIGNEDTIME) AS "TOTAL TIME"
FROM pwe;

DROP VIEW EL;

CREATE VIEW e1 AS
SELECT EMPLOYEEID, FIRSTNAME, LASTNAME, SALARY
FROM EMPLOYEES;

SELECT * FROM e1;

UPDATE e1 SET SALARY = SALARY * 1.1;

***************************************************************************************************************************************************************
SELECT * FROM vrs;
SET TRANSACTION NAME 't1';
UPDATE vrs SET inventory = inventory + 10;
SELECT * FROM vrs;
COMMIT;
SELECT * FROM vrs;

SET TRANSACTION NAME 't2';
UPDATE vrs SET inventory = inventory -20;
SELECT * FROM vrs;
ROLLBACK;
SELECT * FROM vrs;

UPDATE vrs SET inventory = inventory + 25;
SELECT * FROM vrs;
SAVEPOINT spoint1;
UPDATE vrs SET inventory = inventory - 15;
SELECT * FROM vrs;
SAVEPOINT spoint2;
UPDATE vrs SET inventory = inventory + 30;
SELECT * FROM vrs;
SAVEPOINT spoint3;
ROLLBACK TO SAVEPOINT spoint1;
SELECT * FROM vrs;

****************************************************************************************************************************************************************

DELETE FROM DEPARTMENTS
WHERE NAME = 'Administration';

SELECT * FROM DEPARTMENTS;

SET TRANSACTION NAME 'p1';
DELETE FROM DEPARTMENTS WHERE NAME = 'Administration';
SELECT * FROM DEPARTMENTS;
COMMIT;
SELECT * FROM DEPARTMENTS;