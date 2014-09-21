@"D:\DataBase Systems\New Lab Sheets\restaurant.sql";

Select name, price from items where price <= 0.99;

Select name, price from items where price between 0.99 and 3.45;

Select name, price from items where price is null;

Select * from items where dateadded > '31-12-2000';

Select name from items where name <= 'Garden';

Select repfname from vendors where repfname like 'S%';

Select companyname from vendors where companyname like '%#_%' escape '#';

Select companyname from vendors where companyname like '%\_%' escape '\';

Select name from items where Not name like '%Salad';

Select ingredientid, name, foodgroup, inventory from ingredients where foodgroup = 'Fruit' AND inventory > 100;

Select name, price from items where (name like 'F%' or name like 'S%') and price < 3.50;

Select name, price from items where (name like 'F%' and price < 3.50) or (name like 'S%' and price < 3.50);

Select * from items where price between 2.50 and 3.50;

Select ingredientid, name, unit from ingredients where unit not in('piece','strip');

Select * from vendors where referredby = NULL;

Select * from vendors where referredby IS NULL;

Select * from items where price <= 0.99;

Select * from user_tables;

*************************************************************************************************************************************************************************

@"D:\DataBase Systems\New Lab Sheets\employeedb.sql";

Select firstname, lastname from employees;

Select * from projects where revenue > 40000;

Select deptcode from projects where revenue between 100000 and 150000;

Select projectid, startdate from projects where startdate <= '1-7-2004';

Select name, subdeptof from departments where subdeptof is null;

Select projectid, description, deptcode from projects where deptcode in('ACCNT', 'CNSLT', 'HDWRE');

Select * from employees where lastname like '%ware' and lastname like '________';

Select employeeid, lastname from employees where salary < 30000 and deptcode in ('ACTNG');

Select * from projects where startdate is null or startdate > sysdate;

Select projectid from projects where (deptcode in('ACTNG') or enddate is null) and revenue > 50000;

************************************************************************************************************************************************************************

Select * from user_tables;

Select companyname as "Company", repfname as "First Name" from vendors;

Select distinct foodgroup, vendorid from ingredients;

Select ingredientid, inventory * 2 * unitprice as "Inventory Value" from ingredients where name = 'Pickle';

Select manager, to_char(sysdate, 'dd-mm-yyyy') as "As on", address || ' ' || city || ' ' || state || ' '|| zip || ' USA' as mail from stores;

Select name, price from items order by price asc;

Select name, inventory*unitprice as "value" from ingredients order by "value" desc;

SELECT name, 
  CASE foodgroup
    WHEN 'Vegetable' THEN 'Good' 
    WHEN 'Fruit' THEN 'Good' 
    WHEN 'Milk' THEN 'Acceptable' 
    WHEN 'Bread' THEN 'Acceptable' 
    WHEN 'Meat' THEN 'Bad' 
    END AS quality 
FROM ingredients;

SELECT name, 
FLOOR( 
  CASE 
    WHEN inventory < 20 THEN 20 - inventory 
    WHEN foodgroup = 'Milk' THEN inventory * 0.05 
    WHEN foodgroup IN ('Meat', 'Bread') THEN inventory * 0.10 
    WHEN foodgroup = 'Vegetable' AND unitprice <= 0.03 THEN inventory * 0.10 
    WHEN foodgroup = 'Vegetable' THEN inventory * 0.03 
    WHEN foodgroup = 'Fruit' THEN inventory * 0.04 
    WHEN foodgroup IS NULL THEN inventory * 0.07
    ELSE 0 
    END) AS "size", 
vendorid 
FROM ingredients 
WHERE inventory < 1000 AND vendorid IS NOT NULL 
ORDER BY vendorid, "size"; 

SELECT ingredientid, name, unit, unitprice, NULLIF(foodgroup, 'Meat') AS "foodgroup", inventory, vendorid FROM ingredients;

SELECT name, price, COALESCE(price, 0.00) AS "PRICE(MODIFIED)" FROM items;

*****************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************

Select employeeid, firstname || ' ' || lastname as "NAME", deptcode, salary from employees;

Select distinct deptcode from projects;

Select projectid, enddate-startdate as "DURATION" from projects;

Select projectid, 
  (Case 
    When enddate < sysdate then enddate - startdate 
    else sysdate - startdate
  end) as "DURATION" 
from projects;

Select projectid, 
  (CASE
    When enddate is not null then (revenue/(enddate-startdate)) 
  end) as "AVERAGE REVENUE PER DAY" 
from projects 
where enddate is not null;

Select distinct to_char(startdate, 'YYYY') as "START YEAR" from projects Order by "START YEAR" asc;

Select EMPLOYEEID, 
  (CASE
    WHEN ASSIGNEDTIME<0.33 THEN 'PART TIME' 
    WHEN ASSIGNEDTIME >= 0.33 AND ASSIGNEDTIME < 0.67 THEN 'SPLIT TIME' 
    WHEN ASSIGNEDTIME >= 0.67 THEN 'FULL TIME' 
  END) AS "TYPE OF EMPLOYEE"
FROM WORKSON;

SELECT CASE DESCRIPTION
  WHEN 'Employee Moral' THEN 'EMP' 
  WHEN 'Robotic Spouse' THEN 'ROB' 
  WHEN 'Mofia Audit' THEN 'MOF' 
  WHEN 'Download Client' THEN 'DOW' 
  WHEN 'Employee Spouse' THEN 'EMS' 
  END || '-' || DEPTCODE AS "ABBREVIATED PROJECT NAMES"
FROM PROJECTS;

SELECT PROJECTID, TO_CHAR(STARTDATE,'YYYY') AS "START YEAR" FROM PROJECTS ORDER BY "START YEAR" ASC;

SELECT LASTNAME, (SALARY + 0.05*SALARY) AS "NEW SALARY" FROM EMPLOYEES WHERE (SALARY + 0.05*SALARY)>50000;

SELECT EMPLOYEEID, FIRSTNAME, LASTNAME, (SALARY + 0.1*SALARY) AS "NEXT YEAR" FROM EMPLOYEES WHERE DEPTCODE IN('HDWRE');

SELECT * FROM EMPLOYEES ORDER BY DEPTCODE ASC;

SELECT * FROM EMPLOYEES ORDER BY LASTNAME ASC;

SELECT * FROM EMPLOYEES ORDER BY FIRSTNAME ASC;

*************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************

SELECT AVG(price), SUM(price) 
FROM items;

SELECT SUM(inventory) AS totalinventoy FROM ingredients;

SELECT MAX (dateadded) AS lastmenuitem FROM items;

SELECT COUNT(foodgroup) AS "FGIngreds", COUNT(DISTINCT foodgroup) AS "NoFGs" FROM ingredients;

SELECT 'Results: ' AS " ", COUNT(*) AS noingredients, COUNT(inventory) AS countedingredients, SUM(DISTINCT inventory) AS totalingredients FROM ingredients;

SELECT storeid, SUM(price) FROM orders GROUP BY storeid;

SELECT storeid, ordernumber, SUM(price) FROM orders GROUP BY storeid,ordernumber ORDER BY STOREID;

SELECT vendorid, foodgroup FROM ingredients GROUP BY vendorid, foodgroup ORDER BY VENDORID;

SELECT storeid, COUNT(*) FROM orders WHERE menuitemid NOT IN ('SODA','WATER') GROUP BY storeid;

SELECT storeid, SUM(price) FROM orders GROUP BY storeid ORDER BY COUNT(*);

SELECT storeid, MAX(linenumber) AS "MAX ITEMS SOLD" FROM orders GROUP BY storeid HAVING SUM(price)>20;

SELECT SUM(price) AS "SALES" FROM orders GROUP BY storeid HAVING storeid='FIRST';

SELECT foodgroup, MIN(unitprice) AS minprice, MAX(unitprice) AS maxprice FROM ingredients WHERE foodgroup IS NOT NULL GROUP BY foodgroup HAVING COUNT(*) >= 2 OR SUM(inventory) > 500;

*****************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************

SELECT VENDORID FROM VENDORS WHERE REPLNAME='Grape';

SELECT NAME FROM INGREDIENTS WHERE INVENTORY>100 AND FOODGROUP IN('Fruit');

SELECT FOODGROUP FROM INGREDIENTS WHERE NAME NOT IN ('Grape');

SELECT NAME, UNITPRICE FROM INGREDIENTS WHERE VENDORID='VGRUS' ORDER BY UNITPRICE ASC;

SELECT MAX(DATEADDED) FROM ITEMS;

SELECT DISTINCT REFERREDBY AS "VENDORS",COUNT(REFERREDBY) AS "NUMBER OF VENDORS REFERRING" FROM VENDORS GROUP BY REFERREDBY HAVING COUNT(REFERREDBY)>1;

*************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************

SELECT AVG(SALARY) FROM EMPLOYEES;

SELECT MAX(REVENUE) AS "MAXIMUM REVENUE", MIN(REVENUE) AS "MINIMUN REVENUE" FROM PROJECTS WHERE STARTDATE IS NOT NULL AND ENDDATE IS NULL;

SELECT COUNT(ENDDATE-STARTDATE) AS "ACTIVE PROJECTS" FROM PROJECTS GROUP BY (ENDDATE-STARTDATE) HAVING ENDDATE-STARTDATE IS NOT NULL; 

SELECT EMPLOYEEID, COUNT(PROJECTID) AS "NUMBER OF PROJECTS WORKING ON" FROM WORKSON GROUP BY EMPLOYEEID;

SELECT MAX(LASTNAME) AS "LAST PERSON" FROM EMPLOYEES;

SELECT DEPTCODE, COUNT(EMPLOYEEID) AS "NUMBER OF EMPLOYEES" FROM EMPLOYEES GROUP BY DEPTCODE;

SELECT COUNT(EMPLOYEEID) FROM EMPLOYEES;

SELECT DEPTCODE, AVG(REVENUE) AS "AVG REVENUE", COUNT(PROJECTID) AS "NUMBER OF PROJECTS" FROM PROJECTS GROUP BY DEPTCODE;

SELECT EMPLOYEEID FROM WORKSON WHERE ASSIGNEDTIME>=1;

SELECT DEPTCODE, (SALARY + 0.1*SALARY) AS "NEW SALARY COST" FROM EMPLOYEES WHERE LASTNAME NOT LIKE '%re';

ALTER TABLE EMPLOYEES ADD(STATUS VARCHAR2(10));

UPDATE EMPLOYEES SET STATUS = 'WORKING';

SELECT SQRT(sum(e1.salary-(avg(e2.salary))*(e1.salary-(avg(e2.salary))))/COUNT(e1.SALARY)) AS "STANDARD DEVIATION" 
FROM EMPLOYEES e1, Employees e2 
GROUP BY e1.employeeid, e2.status
Having e2.status in ('WORKING');

SELECT * FROM EMPLOYEES;