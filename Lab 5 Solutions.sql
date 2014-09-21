SELECT name
FROM ingredients
WHERE vendorid =
  (SELECT vendorid
  FROM vendors
  WHERE companyname = 'Veggies_R_Us');

SELECT name
FROM ingredients
WHERE vendorid IN
  (SELECT vendorid
  FROM vendors
  WHERE companyname = 'Veggies_R_Us' OR companyname = 'Spring Water Supply');

SELECT AVG(unitprice) AS avgprice
FROM ingredients
WHERE vendorid IN
  (SELECT vendorid
  FROM vendors
  WHERE companyname = 'Veggies_R_Us');

SELECT name
FROM ingredients
WHERE inventory BETWEEN
  (SELECT AVG(inventory) * 0.75
  FROM ingredients)
AND
  (SELECT AVG(inventory) * 1.25
  FROM ingredients);

SELECT companyname
FROM vendors
WHERE (referredby IN
  (SELECT vendorid
  FROM vendors
  WHERE companyname = 'Veggies_R_Us')) 
AND
  (vendorid IN
  (SELECT vendorid
  FROM ingredients
  WHERE foodgroup = 'Milk'));
  
SELECT name, price
FROM items
WHERE itemid IN
  (SELECT itemid -- Subquery 3
  FROM madewith
  WHERE ingredientid IN
    (SELECT ingredientid -- Subquery 2
    FROM ingredients
    WHERE vendorid =
      (SELECT vendorid -- Subquery 1
      FROM vendors
      WHERE companyname = 'Veggies_R_Us')));
      
SELECT storeid, SUM(price) AS sales
FROM orders
WHERE menuitemid IN
  (SELECT itemid -- Subquery 3
  FROM madewith
  WHERE ingredientid IN
    (SELECT ingredientid -- Subquery 2
    FROM ingredients
    WHERE vendorid =
      (SELECT vendorid -- Subquery 1
      FROM vendors
      WHERE companyname = 'Veggies_R_Us')))
GROUP BY storeid
HAVING COUNT(*) > 2
ORDER BY sales DESC;

SELECT name
FROM ingredients
WHERE vendorid NOT IN
  (SELECT vendorid
  FROM vendors
  WHERE companyname = 'Veggies_R_Us');
  
SELECT companyname
FROM vendors
WHERE vendorid NOT IN
  (SELECT vendorid
  FROM ingredients
  WHERE inventory > 100);
  
SELECT companyname
FROM vendors
WHERE vendorid NOT IN
  (SELECT vendorid
  FROM ingredients
  WHERE inventory > 100 AND vendorid IS NOT NULL);

SELECT companyname
FROM vendors
WHERE referredby =
  (SELECT vendorid
  FROM vendors
  WHERE companyname = 'No Such Company');

SELECT companyname
FROM vendors
WHERE referredby NOT IN
  (SELECT vendorid
  FROM vendors
  WHERE companyname = 'No Such Company');

SELECT DISTINCT items.itemid, price
FROM items JOIN madewith ON items.itemid=madewith.itemid
WHERE ingredientid IN
  (SELECT ingredientid
  FROM ingredients JOIN vendors on vendors.vendorid=ingredients.vendorid
  WHERE companyname = 'Veggies_R_Us');

SELECT name
FROM items
WHERE price > ANY
  (SELECT price
  FROM items
  WHERE name LIKE '%Salad');

SELECT name
FROM ingredients
WHERE ingredientid NOT IN
  (SELECT ingredientid
  FROM ingredients
  WHERE vendorid = ANY
    (SELECT vendorid
    FROM vendors
    WHERE companyname = 'Veggies_R_Us' OR companyname = 'Spring Water Supply'));

SELECT name
FROM ingredients
WHERE unitprice >= ALL
  (SELECT unitprice
  FROM ingredients ing JOIN madewith mw on mw.ingredientid=ing.ingredientid JOIN items i on mw.itemid=i.itemid 
  WHERE i.name LIKE '%Salad');

SELECT name
FROM ingredients
WHERE vendorid <> ANY
  (SELECT vendorid
  FROM vendors
  WHERE companyname = 'Veggies_R_Us' OR companyname = 'Spring Water Supply');

SELECT name
FROM ingredients
WHERE ingredientid NOT IN
  (SELECT ingredientid
  FROM ingredients
  WHERE vendorid = ANY
    (SELECT vendorid
    FROM vendors
    WHERE companyname = 'Veggies_R_Us' OR companyname = 'Spring Water Supply'));

SELECT *
FROM items
WHERE price >= ALL
  (SELECT price
  FROM items);

SELECT *
FROM items
WHERE price >= ALL
  (SELECT max(price)
  FROM items);

SELECT itemid, name
FROM items
WHERE 
  (SELECT COUNT(*)
  FROM madewith
  WHERE madewith.itemid = items.itemid) >= 3;

SELECT vendorid, companyname
FROM vendors v1
WHERE 
  (SELECT COUNT(*)
  FROM vendors v2
  WHERE v2.referredby = v1.vendorid) >= 2;

SELECT *
FROM meals m
WHERE EXISTS
  (SELECT *
  FROM partof p JOIN items on p.itemid=items.itemid JOIN madewith on items.itemid=madewith.itemid 
  JOIN ingredients on madewith.ingredientid=ingredients.ingredientid
  WHERE foodgroup = 'Milk' AND m.mealid = p.mealid);

SELECT vendorid, companyname
FROM vendors v1
WHERE NOT EXISTS 
  (SELECT *
  FROM vendors v2
  WHERE v2.referredby = v1.vendorid);

SELECT name, companyname, val
FROM vendors v,
  (SELECT name, vendorid, unitprice * inventory as val FROM ingredients i WHERE foodgroup IN ('Fruit', 'Vegetable') ) d
WHERE v.vendorid = d.vendorid;

SELECT companyname
FROM vendors v, ingredients i
WHERE i.vendorid = v.vendorid
GROUP BY v.vendorid, companyname
HAVING COUNT(*) > (SELECT COUNT(*)
  FROM ingredients i, vendors v
  WHERE i.vendorid = v.vendorid AND companyname = 'Spring Water Supply');

SELECT v1.vendorid, AVG(unitprice * inventory) as "INVENTORY VALUE"
FROM ingredients JOIN vendors v1 ON (ingredients.vendorid=v1.vendorid)
GROUP BY v1.vendorid
HAVING EXISTS (SELECT *
  FROM vendors v2
  WHERE v1.vendorid = v2.referredby);

SELECT name, companyname
FROM items it, vendors v
WHERE NOT EXISTS (
  SELECT ingredientid -- ingredients supplied by vendor
  FROM ingredients i
  WHERE i.vendorid = v.vendorid
  MINUS
  SELECT ingredientid -- ingredients used in item
  FROM madewith m
  WHERE it.itemid = m.itemid);

SELECT i.name, companyname
FROM items i, vendors v
WHERE NOT EXISTS (
  (SELECT m.ingredientid -- ingredients used in item
  FROM madewith m
  WHERE i.itemid = m.itemid)
  MINUS
  (SELECT ingredientid -- ingredients supplied by vendors
  FROM ingredients i
  WHERE i.vendorid = v.vendorid));

SELECT i.name, companyname
FROM items i, vendors v
WHERE
  (SELECT COUNT(DISTINCT m.ingredientid) -- number of ingredients in item
  FROM madewith m
  WHERE i.itemid = m.itemid)
  = 
  (SELECT COUNT(DISTINCT m.ingredientid) -- number of ingredients in item supplied by vendor
  FROM madewith m, ingredients n
  WHERE i.itemid = m.itemid AND m.ingredientid = n.ingredientid AND n.vendorid = v.vendorid);

SELECT name, companyname
FROM items i, vendors v
WHERE 
  (SELECT COUNT(DISTINCT m.ingredientid) -- number of ingredients in item supplied by vendor
  FROM madewith m, ingredients ing
  WHERE i.itemid = m.itemid AND m.ingredientid = ing.ingredientid AND ing.vendorid = v.vendorid)
  =
  (SELECT COUNT(DISTINCT ing.ingredientid) -- number of ingredients supplied by vendor
  FROM ingredients ing
  WHERE ing.vendorid = v.vendorid);

SELECT name, companyname
FROM items i, vendors v
WHERE
  (SELECT COUNT(DISTINCT m.ingredientid) -- number of ingredients in item supplied by vendor
  FROM madewith m, ingredients ing
  WHERE i.itemid = m.itemid AND m.ingredientid = ing.ingredientid AND ing.vendorid = v.vendorid)
  =
  (SELECT COUNT(DISTINCT ing.ingredientid) -- number of ingredients supplied by vendor
  FROM ingredients ing
  WHERE ing.vendorid = v.vendorid);

SELECT name, unitprice * inventory AS "Inventory Value",
  (SELECT MAX(unitprice * inventory) FROM ingredients) AS "Max. Value",
  (unitprice * inventory) / (SELECT AVG(unitprice * inventory) FROM ingredients) AS "Ratio"
FROM ingredients;

SELECT name,
  (SELECT companyname FROM vendors v WHERE v.vendorid = i.vendorid) AS "supplier"
FROM ingredients i;

****************************************************************************************************************************************************************

SELECT FIRSTNAME || ' ' || LASTNAME AS "NAME"
FROM EMPLOYEES
WHERE DEPTCODE IN
  (SELECT CODE
  FROM DEPARTMENTS
  WHERE NAME = 'Consulting');
  
SELECT FIRSTNAME || ' ' || LASTNAME AS "NAME"
FROM EMPLOYEES
WHERE (DEPTCODE IN
  (SELECT CODE
  FROM DEPARTMENTS
  WHERE NAME = 'Consulting'))
  AND
  (EMPLOYEEID IN
  (SELECT EMPLOYEEID
  FROM WORKSON
  WHERE ASSIGNEDTIME > 0.2 AND PROJECTID = 'ADT4MFIA'));

SELECT SUM(ASSIGNEDTIME)
FROM WORKSON
WHERE EMPLOYEEID IN
  (SELECT EMPLOYEEID
  FROM EMPLOYEES
  WHERE FIRSTNAME = 'Abe' AND LASTNAME = 'Advice');

SELECT NAME
FROM DEPARTMENTS
WHERE CODE NOT IN
  (SELECT DEPTCODE
  FROM PROJECTS);

SELECT FIRSTNAME ||' ' || LASTNAME AS "NAME"
FROM EMPLOYEES
WHERE SALARY > 
  (SELECT AVG(SALARY)
  FROM EMPLOYEES
  WHERE DEPTCODE IN
    (SELECT CODE
    FROM DEPARTMENTS
    WHERE NAME = 'Accounting'));

SELECT DESCRIPTION
FROM PROJECTS
WHERE PROJECTID IN
  (SELECT PROJECTID
  FROM WORKSON
  WHERE ASSIGNEDTIME > 0.7);

SELECT FIRSTNAME, LASTNAME
FROM EMPLOYEES
WHERE SALARY > ANY
  (SELECT SALARY
  FROM EMPLOYEES
  WHERE DEPTCODE IN
    (SELECT CODE
    FROM DEPARTMENTS
    WHERE NAME = 'Accounting'));

SELECT MIN(SALARY) AS "MINIMUM SALARY"
FROM EMPLOYEES
WHERE SALARY > ALL 
  (SELECT SALARY
  FROM EMPLOYEES
  WHERE DEPTCODE IN
    (SELECT CODE
    FROM DEPARTMENTS
    WHERE NAME = 'Accounting'));

SELECT FIRSTNAME, LASTNAME
FROM EMPLOYEES
WHERE SALARY =
  (SELECT MAX(SALARY)
  FROM EMPLOYEES
  WHERE DEPTCODE IN
    (SELECT CODE
    FROM DEPARTMENTS
    WHERE NAME = 'Accounting'));

