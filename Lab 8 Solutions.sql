DECLARE
  c_name menuitems.name%TYPE;
  c_price menuitems.price%TYPE;
  CURSOR menuitemcur IS SELECT name, price FROM menuitems ORDER BY price DESC;
BEGIN
  OPEN menuitemcur ;
    LOOP
    FETCH menuitemcur INTO c_name, c_price;
      DBMS_OUTPUT.PUT_LINE(to_char(c_name) ||' and ' || c_price);
    EXIT WHEN menuitemcur%NOTFOUND ;
    END LOOP;
  CLOSE menuitemcur;
END;

/*PROCEDURE****************************************************************************************************************************************************/

CREATE PROCEDURE AllergyMenu (allergen VARCHAR) is
  namee number(20);
  pricee number(20);
BEGIN
  SELECT name, price into namee,pricee
  FROM items it
  WHERE NOT EXISTS
    (SELECT *
    FROM madewith m JOIN ingredients ig ON (m.ingredientid = ig.ingredientid)
    WHERE it.itemid = m.itemid AND ig.name = allergen);
END AllergyMenu ;

DROP PROCEDURE AllergyMenu;

/*TRIGGER******************************************************************************************************************************************************/

DROP TABLE T4;

DROP TABLE T5;

CREATE TABLE T4 (a INTEGER, b CHAR(10));

SELECT * FROM T4;

CREATE TABLE T5 (c CHAR(10), d INTEGER);

SELECT * FROM T5;

CREATE TRIGGER oninsert
AFTER INSERT ON T4
REFERENCING NEW AS newRow
FOR EACH ROW
WHEN (newRow.a <= 10)
BEGIN
INSERT INTO T5 VALUES(:newRow.b, :newRow.a);
END oninsert;

insert into T4 values (3,'mytigger');

select * from T5;

select trigger_name from user_triggers;

drop trigger oninsert;

****************************************************************************************************************************************************************

DECLARE
  FIRST_NAME EMPLOYEES.FIRSTNAME%TYPE;
  LAST_NAME EMPLOYEES.LASTNAME%TYPE;
  SAL EMPLOYEES.SALARY%TYPE;
  CO NUMBER(2);
  AV NUMBER(7,2);
  X NUMBER(7);
  STD NUMBER(7,2);
  BUF NUMBER(7,2);
  CURSOR cur IS SELECT FIRSTNAME, LASTNAME, SALARY FROM EMPLOYEES ORDER BY employeeid;
  CURSOR cur2 IS SELECT SALARY FROM EMPLOYEES ORDER BY employeeid;
BEGIN
  X := 0;
  CO := 0;
  AV := 0.0;
  STD := 0.0;
  BUF := 0.0;
  OPEN cur;
    LOOP
    FETCH cur INTO FIRST_NAME, LAST_NAME, SAL;
      X := X + SAL;
      DBMS_OUTPUT.PUT_LINE(FIRST_NAME ||' ' || LAST_NAME);
    EXIT WHEN cur%NOTFOUND ;
    END LOOP;
    CO := cur%ROWCOUNT;
  CLOSE cur;
  AV := (X/CO);
  DBMS_OUTPUT.PUT_LINE('AVERAGE SALARY IS '|| TO_CHAR(AV) || '.');
  OPEN cur2;
    LOOP
      FETCH cur2 INTO SAL;
      BUF := BUF + ((AV - SAL)*(AV - SAL));
    EXIT WHEN cur2%NOTFOUND;
    END LOOP;
  CLOSE cur2;
  STD := SQRT(BUF);
  DBMS_OUTPUT.PUT_LINE('STANDARD DEVIATION OF SALARY IS '|| TO_CHAR(STD) || '.');
END;