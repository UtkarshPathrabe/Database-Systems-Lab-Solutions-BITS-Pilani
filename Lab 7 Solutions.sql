DECLARE
  num_age NUMBER(3) := 20; -- assign value to variable
BEGIN
  num_age := 20;
  DBMS_OUTPUT.PUT_LINE('My age is: ' || TO_CHAR(num_age));
END;

DECLARE
  wages NUMBER;
  hours_worked NUMBER := 40;
  hourly_salary NUMBER := 22.50;
  bonus NUMBER := 150;
  country VARCHAR2(128);
  counter NUMBER := 0;
  done BOOLEAN;
  valid_id BOOLEAN;
  TYPE myarr IS VARRAY(10) of NUMBER; --array
  TYPE commissions IS TABLE OF NUMBER INDEX BY VARCHAR2(10); --associative array
  t_arr myarr:= myarr();
  comm_tab commissions;
BEGIN
  t_arr.extend; --append element
  t_arr(1):=1;
  t_arr.extend(2);
  t_arr(2):=1;
  t_arr(3):=1.9;
  wages := (hours_worked * hourly_salary) + bonus;
  country := 'France';
  done := (counter > 100);
  valid_id := TRUE;
  comm_tab('France') := 20000 * 0.15;
  DBMS_OUTPUT.PUT_LINE( to_char(wages) || ' ' || country || ' ' || to_char(comm_tab('France')) );
END;

DECLARE
  v_PurchaseAmount NUMBER(9,2) := 1001;
  v_DiscountAmount NUMBER(9,2);
BEGIN
  IF NOT (v_PurchaseAmount <= 1000) THEN
    v_DiscountAmount := v_PurchaseAmount * 0.05;
  END IF;
  DBMS_OUTPUT.PUT_LINE('Discount: ' || TO_CHAR(v_DiscountAmount));
END;

DECLARE
  v_CustomerStatus CHAR(3) := '&CustomerStatus';
  v_PurchaseAmount NUMBER(9,2) := '&PurchaseAmount';
  v_DiscountAmount NUMBER(9,2);
BEGIN
  IF v_CustomerStatus = 'AAA' THEN
    IF v_PurchaseAmount > 1000 then
      v_DiscountAmount := v_PurchaseAmount * 0.05;
    ELSE
      v_DiscountAmount := v_PurchaseAmount * 0.02;
    END IF;
  ELSE
    v_DiscountAmount := 0;
  END IF;
  DBMS_OUTPUT.PUT_LINE('Discount: ' || TO_CHAR(v_DiscountAmount));
END;

DECLARE
  v_Balance NUMBER(9,2) := 100;
BEGIN
  LOOP
    v_Balance := v_Balance - 15;
    IF v_Balance <= 0 THEN
      EXIT;
    END IF;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('You may have paid too much.');
  DBMS_OUTPUT.PUT_LINE('Ending balance: ' || TO_CHAR(v_Balance));
END;

DECLARE
  v_Counter NUMBER := 1;
BEGIN
  WHILE v_Counter < 5 LOOP
    DBMS_OUTPUT.PUT_LINE('Count = ' || TO_CHAR(v_Counter));
    v_Counter := v_Counter + 1;
  END LOOP;
END;

DECLARE
  v_Rate NUMBER(5,4) := 0.06/12;
  v_Periods NUMBER := 12;
  v_Balance NUMBER(9,2) := 0;
BEGIN
  FOR i IN 1..v_Periods LOOP -- loop number of periods
    v_Balance := v_Balance + 50;
    v_Balance := v_Balance + (v_Balance * v_Rate);
    DBMS_OUTPUT.PUT_LINE('Balance for Period ' || TO_CHAR(i) || ' ' || TO_CHAR(v_Balance));
  END LOOP;
END;

SELECT * FROM user_tables;

DROP TABLE INGREDIENTS_NEW;

CREATE TABLE INGREDIENTS_NEW(INGREDIENTID,NAME,UNIT,UNITPRICE,FOODGROUP,INVENTORY,VENDORID) AS
SELECT INGREDIENTID,NAME,UNIT,UNITPRICE,FOODGROUP,INVENTORY,VENDORID
FROM INGREDIENTS;

SELECT * FROM INGREDIENTS_NEW;

DECLARE
  unit_price ingredients_new.unitprice%type;
  old_price ingredients_new.unitprice%type;
  ingredient ingredients_new.ingredientid%type :='&ingredient';
BEGIN
  select unitprice into unit_price from ingredients_new where ingredientid=ingredient;
  IF SQL%NOTFOUND THEN --implicit cursor
    DBMS_OUTPUT.PUT_LINE('Ingredient ' || ingredient || ' not found');
  else
    old_price:=unit_price;
    unit_price:=unit_price+ unit_price*0.1;
    UPDATE ingredients_new set unitprice=unit_price where ingredientid=ingredient;
    IF SQL%FOUND THEN -- ingredient updated
      DBMS_OUTPUT.PUT_LINE('Updated unitprice for ' || ingredient ||' from '|| TO_CHAR(old_price) || ' to ' || TO_CHAR(unit_price));
    END IF;
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('no ingredient found');
  WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('Too many rows selectd');
END;

BEGIN
  DELETE FROM ingredients_new WHERE ingredientid <> 'WATER';
  IF SQL%FOUND THEN -- ingredients were deleted
    DBMS_OUTPUT.PUT_LINE('Number deleted: ' || TO_CHAR(SQL%ROWCOUNT));
  END IF;
END;