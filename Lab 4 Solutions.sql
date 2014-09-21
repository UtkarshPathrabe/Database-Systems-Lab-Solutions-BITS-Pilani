SELECT vendors.vendorid, name, companyname
FROM ingredients, vendors
WHERE ingredients.vendorid = vendors.vendorid;

SELECT name
FROM ingredients, vendors
WHERE ingredients.vendorid = vendors.vendorid AND companyname = 'Veggies_R_Us';

SELECT v2.companyname
FROM vendors v1, vendors v2
WHERE v1.vendorid = v2.referredby AND v1.companyname = 'Veggies_R_Us';

SELECT items.name as "ITEM NAME", ing.name as "INGREDIENT NAME"
FROM items, madewith mw, ingredients ing
WHERE items.itemid = mw.itemid AND mw.ingredientid = ing.ingredientid AND 3 * mw.quantity > ing.inventory;

SELECT a.name
FROM items a, items q
WHERE a.price > q.price AND q.name = 'Garden Salad';

SELECT name
FROM ingredients i INNER JOIN vendors v ON i.vendorid = v.vendorid
WHERE v.companyname = 'Veggies_R_Us';

SELECT i1.name
FROM items i1 INNER JOIN items i2 ON i1.price > i2.price
WHERE i2.name = 'Garden Salad';

SELECT companyname, name, vendorid
FROM ingredients JOIN vendors v USING (vendorid)
WHERE v.companyname = 'Veggies_R_Us';

SELECT DISTINCT(i.name)
FROM vendors JOIN ingredients USING (vendorid) JOIN madewith USING(ingredientid) JOIN items i USING (itemid)
WHERE companyname = 'Veggies_R_Us';

SELECT companyname, i.vendorid, i.name
FROM vendors v FULL JOIN ingredients i ON v.vendorid = i.vendorid;

SELECT companyname
FROM vendors v LEFT JOIN ingredients i on v.vendorid=i.vendorid
WHERE ingredientid IS NULL;

SELECT i.name, v.companyname AS Vendor
FROM ingredients i CROSS JOIN vendors v
ORDER BY v.vendorid;

SELECT name
FROM ingredients NATURAL JOIN vendors
WHERE companyname = 'Veggies_R_Us';

SELECT companyname
FROM vendors v NATURAL LEFT JOIN ingredients i
WHERE ingredientid IS NULL;

SELECT name
FROM vendors NATURAL JOIN ingredients NATURAL JOIN madewith NATURAL JOIN items
WHERE companyname = 'Veggies_R_Us';

****************************************************************************************************************************************************************

SELECT e.FIRSTNAME || ' ' || e.LASTNAME AS "EMPLOYEE NAME"
FROM EMPLOYEES e, DEPARTMENTS d
WHERE e.DEPTCODE = d.CODE AND d.NAME IN ('Consulting');

SELECT e.FIRSTNAME || ' ' || e.LASTNAME AS "EMPLOYEE NAME"
FROM EMPLOYEES e CROSS JOIN DEPARTMENTS d
WHERE e.DEPTCODE = d.CODE AND d.NAME IN ('Consulting');

SELECT e.FIRSTNAME || ' ' || e.LASTNAME AS "EMPLOYEE NAME"
FROM EMPLOYEES e, DEPARTMENTS d, WORKSON w
WHERE e.DEPTCODE = d.CODE AND e.EMPLOYEEID = w.EMPLOYEEID AND d.NAME IN ('Acting') AND w.PROJECTID IN ('ADT4MFIA') AND w.ASSIGNEDTIME > 0.2;

SELECT e.FIRSTNAME || ' ' || e.LASTNAME AS "EMPLOYEE NAME"
FROM EMPLOYEES e INNER JOIN DEPARTMENTS d ON e.DEPTCODE = d.CODE INNER JOIN WORKSON w ON e.EMPLOYEEID = w.EMPLOYEEID
WHERE d.NAME IN ('Acting') AND w.PROJECTID IN ('ADT4MFIA') AND w.ASSIGNEDTIME > 0.2;

SELECT e.FIRSTNAME || ' ' || e.LASTNAME AS "EMPLOYEE NAME"
FROM EMPLOYEES e CROSS JOIN DEPARTMENTS d CROSS JOIN WORKSON w
WHERE e.DEPTCODE = d.CODE AND e.EMPLOYEEID = w.EMPLOYEEID AND d.NAME IN ('Acting') AND w.PROJECTID IN ('ADT4MFIA') AND w.ASSIGNEDTIME > 0.2;

SELECT e.EMPLOYEEID, SUM(w.assignedtime) AS "% TOTAL ASSIGNED TIME"
FROM EMPLOYEES e, WORKSON w
WHERE e.EMPLOYEEID = w.EMPLOYEEID AND e.FIRSTNAME = 'Abe' AND e.LASTNAME = 'Advice'
GROUP BY e.EMPLOYEEID;

SELECT EMPLOYEEID, SUM(w.assignedtime) AS "% TOTAL ASSIGNED TIME"
FROM EMPLOYEES e JOIN WORKSON w USING(EMPLOYEEID)
WHERE e.FIRSTNAME = 'Abe' AND e.LASTNAME = 'Advice'
GROUP BY EMPLOYEEID;

SELECT p.description
FROM PROJECTS p, WORKSON w
WHERE p.PROJECTID = w.PROJECTID AND w.assignedtime > 0.7;

SELECT p.description
FROM projects p JOIN workson w USING(PROJECTID)
WHERE w.assignedtime > 0.7;

SELECT e.EMPLOYEEID, COUNT(w.PROJECTID) AS "TOTAL NUMBER OF PROJECTS", SUM(w.ASSIGNEDTIME) AS "% TOTAL ASSIGNED TIME"
FROM EMPLOYEES e LEFT JOIN WORKSON w ON e.EMPLOYEEID = w.EMPLOYEEID
GROUP BY e.EMPLOYEEID
ORDER BY e.EMPLOYEEID;

SELECT p.DESCRIPTION
FROM WORKSON w RIGHT JOIN PROJECTS p ON w.PROJECTID = p.PROJECTID
WHERE w.EMPLOYEEID IS NULL;

SELECT p.PROJECTID, MAX(w.ASSIGNEDTIME) AS "MAX % OF TIME TO ONE EMPLOYEE"
FROM PROJECTS p, WORKSON w
WHERE p.PROJECTID = w.PROJECTID
GROUP BY p.PROJECTID;

SELECT p.PROJECTID, MAX(w.ASSIGNEDTIME) AS "MAX % OF TIME TO ONE EMPLOYEE"
FROM PROJECTS p LEFT JOIN WORKSON w ON p.PROJECTID = w.PROJECTID
GROUP BY p.PROJECTID;

SELECT e1.EMPLOYEEID, e2.LASTNAME
FROM EMPLOYEES e1, EMPLOYEES e2
WHERE e1.SALARY < e2.SALARY
ORDER BY e1.EMPLOYEEID, e2.LASTNAME;

SELECT e1.EMPLOYEEID, e2.LASTNAME
FROM EMPLOYEES e1 CROSS JOIN EMPLOYEES e2
WHERE e1.SALARY < e2.SALARY
ORDER BY e1.EMPLOYEEID, e2.LASTNAME;

SELECT *
FROM PROJECTS
ORDER BY REVENUE DESC;

****************************************************************************************************************************************************************

SELECT price
FROM items
UNION
SELECT unitprice
FROM ingredients;

SELECT name, price
FROM items
UNION
SELECT m.name, SUM(quantity * price * (1.0 - discount))
FROM meals m, partof p, items i
WHERE m.mealid = p.mealid AND p.itemid = i.itemid
GROUP BY m.mealid, m.name;

SELECT itemid
FROM madewith mw, ingredients ing
WHERE mw.ingredientid = ing.ingredientid and foodgroup = 'Vegetable'
INTERSECT
SELECT itemid
FROM madewith mw, ingredients ing
WHERE mw.ingredientid = ing.ingredientid and foodgroup = 'Fruit';

SELECT itemid
FROM items
MINUS
SELECT itemid
FROM madewith mw, ingredients ing
WHERE mw.ingredientid = ing.ingredientid AND ing.name = 'Cheese';

SELECT DISTINCT(itemid)
FROM madewith mw, ingredients ing
WHERE mw.ingredientid = ing.ingredientid AND ing.name != 'Cheese';

SELECT foodgroup
FROM madewith m, ingredients i
WHERE m.ingredientid = i.ingredientid AND m.itemid = 'FRPLT'
MINUS
SELECT foodgroup
FROM madewith m, ingredients i
WHERE m.ingredientid = i.ingredientid AND m.itemid = 'FRTSD';

SELECT companyname
FROM vendors v LEFT JOIN ingredients i on v.vendorid=i.vendorid
WHERE ingredientid IS NULL;

SELECT COMPANYNAME
FROM VENDORS
MINUS
SELECT COMPANYNAME
FROM VENDORS v JOIN INGREDIENTS i USING(VENDORID);

SELECT itemid
FROM madewith m, ingredients i
WHERE m.ingredientid = i.ingredientid AND foodgroup='Milk'
INTERSECT
SELECT itemid
FROM madewith m, ingredients i
WHERE m.ingredientid = i.ingredientid AND foodgroup='Fruit';

SELECT itemid
FROM madewith m, ingredients i
WHERE m.ingredientid = i.ingredientid AND foodgroup='Milk'
MINUS
(SELECT itemid
FROM madewith m, ingredients i
WHERE m.ingredientid = i.ingredientid AND foodgroup='Milk'
MINUS
SELECT itemid
FROM madewith m, ingredients i
WHERE m.ingredientid = i.ingredientid AND foodgroup='Fruit');

****************************************************************************************************************************************************************

(SELECT STARTDATE AS "DATE"
FROM PROJECTS
WHERE STARTDATE IS NOT NULL
UNION
SELECT ENDDATE AS "DATE"
FROM PROJECTS
WHERE ENDDATE IS NOT NULL)
ORDER BY "DATE" DESC;

SELECT e.FIRSTNAME, e.LASTNAME
FROM EMPLOYEES e JOIN DEPARTMENTS d ON e.DEPTCODE = d.CODE
WHERE d.NAME = 'Hardware'
INTERSECT
SELECT e.FIRSTNAME, e.LASTNAME
FROM EMPLOYEES e JOIN WORKSON w ON e.EMPLOYEEID = w.EMPLOYEEID JOIN PROJECTS p ON w.PROJECTID = p.PROJECTID
WHERE p.DESCRIPTION = 'Robotic Spouse';

SELECT e.FIRSTNAME, e.LASTNAME
FROM EMPLOYEES e JOIN WORKSON w ON e.EMPLOYEEID = w.EMPLOYEEID JOIN PROJECTS p ON w.PROJECTID = p.PROJECTID
WHERE p.DESCRIPTION = 'Robotic Spouse'
MINUS
SELECT e.FIRSTNAME, e.LASTNAME
FROM EMPLOYEES e JOIN DEPARTMENTS d ON e.DEPTCODE = d.CODE
WHERE d.NAME = 'Hardware';

SELECT e.FIRSTNAME, e.LASTNAME
FROM EMPLOYEES e JOIN WORKSON w ON e.EMPLOYEEID = w.EMPLOYEEID JOIN PROJECTS p ON w.PROJECTID = p.PROJECTID
WHERE p.DESCRIPTION = 'Download Client'
MINUS
SELECT e.FIRSTNAME, e.LASTNAME
FROM EMPLOYEES e JOIN WORKSON w ON e.EMPLOYEEID = w.EMPLOYEEID JOIN PROJECTS p ON w.PROJECTID = p.PROJECTID
WHERE p.DESCRIPTION = 'Robotic Spouse';

SELECT e.FIRSTNAME, e.LASTNAME
FROM EMPLOYEES e JOIN WORKSON w ON e.EMPLOYEEID = w.EMPLOYEEID JOIN PROJECTS p ON w.PROJECTID = p.PROJECTID
WHERE p.DESCRIPTION = 'Download Client'
INTERSECT
SELECT e.FIRSTNAME, e.LASTNAME
FROM EMPLOYEES e JOIN WORKSON w ON e.EMPLOYEEID = w.EMPLOYEEID JOIN PROJECTS p ON w.PROJECTID = p.PROJECTID
WHERE p.DESCRIPTION = 'Robotic Spouse';

SELECT e.FIRSTNAME, e.LASTNAME
FROM EMPLOYEES e JOIN WORKSON w ON e.EMPLOYEEID = w.EMPLOYEEID JOIN PROJECTS p ON w.PROJECTID = p.PROJECTID
WHERE p.DESCRIPTION = 'Download Client'
UNION
SELECT e.FIRSTNAME, e.LASTNAME
FROM EMPLOYEES e JOIN WORKSON w ON e.EMPLOYEEID = w.EMPLOYEEID JOIN PROJECTS p ON w.PROJECTID = p.PROJECTID
WHERE p.DESCRIPTION = 'Robotic Spouse';

(SELECT e.FIRSTNAME, e.LASTNAME
FROM EMPLOYEES e JOIN WORKSON w ON e.EMPLOYEEID = w.EMPLOYEEID JOIN PROJECTS p ON w.PROJECTID = p.PROJECTID
WHERE p.DESCRIPTION = 'Download Client'
UNION
SELECT e.FIRSTNAME, e.LASTNAME
FROM EMPLOYEES e JOIN WORKSON w ON e.EMPLOYEEID = w.EMPLOYEEID JOIN PROJECTS p ON w.PROJECTID = p.PROJECTID
WHERE p.DESCRIPTION = 'Robotic Spouse')
MINUS
(SELECT e.FIRSTNAME, e.LASTNAME
FROM EMPLOYEES e JOIN WORKSON w ON e.EMPLOYEEID = w.EMPLOYEEID JOIN PROJECTS p ON w.PROJECTID = p.PROJECTID
WHERE p.DESCRIPTION = 'Download Client'
INTERSECT
SELECT e.FIRSTNAME, e.LASTNAME
FROM EMPLOYEES e JOIN WORKSON w ON e.EMPLOYEEID = w.EMPLOYEEID JOIN PROJECTS p ON w.PROJECTID = p.PROJECTID
WHERE p.DESCRIPTION = 'Robotic Spouse');

SELECT NAME
FROM DEPARTMENTS
MINUS
SELECT NAME
FROM PROJECTS p JOIN DEPARTMENTS d ON p.DEPTCODE = d.CODE;