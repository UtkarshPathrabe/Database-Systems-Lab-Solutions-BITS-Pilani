Drop table orders;
Drop table stores;
Drop table ads;
Drop table partof;
Drop table meals;
Drop table madewith;
Drop table ingredients;
Drop table vendors;
Drop table items;
Select * from user_tables;

CREATE TABLE items (
  itemid CHAR(5) PRIMARY KEY, 
  name VARCHAR(30),
  price NUMERIC(5,2),
  dateadded DATE DEFAULT sysdate
);

Select * from items;

CREATE TABLE vendors (
  vendorid CHAR(5) NOT NULL,
  companyname VARCHAR(30) DEFAULT 'SECRET' NOT NULL,
  repfname VARCHAR(20) DEFAULT 'Mr. or Ms.',
  replname VARCHAR(20),
  referredby CHAR(5) NULL,
  UNIQUE (repfname, replname),
  PRIMARY KEY(vendorid),
  FOREIGN KEY(referredby) REFERENCES vendors(vendorid) ON DELETE CASCADE 
);

Select * from vendors;

CREATE TABLE ingredients (
  ingredientid CHAR(5) PRIMARY KEY,
  name VARCHAR(30) NOT NULL,
  unit CHAR(10),
  unitprice NUMERIC(5,2),
  foodgroup CHAR(15) CHECK (foodgroup IN ('Milk', 'Meat', 'Bread', 
                                          'Fruit', 'Vegetable')),
  inventory INTEGER DEFAULT 0,
  vendorid CHAR(5),
  check(unitprice * inventory <= 4000),
  FOREIGN KEY(vendorid) REFERENCES vendors(vendorid) 
);

Select * from ingredients;

CREATE TABLE madewith (
  itemid CHAR(5) REFERENCES items(itemid) ON DELETE CASCADE,
  ingredientid CHAR(5) REFERENCES ingredients ON DELETE CASCADE,
  quantity INTEGER DEFAULT 0 NOT NULL,
  PRIMARY KEY(itemid, ingredientid)
);

Select * from madewith;

CREATE TABLE meals (
  mealid CHAR(5) NOT NULL,
  name CHAR(20) UNIQUE,
  PRIMARY KEY(mealid)
);

Select * from meals;

CREATE TABLE partof (
  mealid CHAR(5),
  itemid CHAR(5),
  quantity INTEGER,
  discount DECIMAL (2, 2) DEFAULT 0.00,
  PRIMARY KEY(mealid, itemid),
  FOREIGN KEY(mealid) REFERENCES meals(mealid) ON DELETE CASCADE,
  FOREIGN KEY(itemid) REFERENCES items(itemid) ON DELETE CASCADE
);

Select * from partof;

CREATE TABLE ads (
  slogan VARCHAR(50)
);

Select * from ads;

CREATE TABLE stores (
   storeid CHAR(5) NOT NULL,
   address VARCHAR(30),
   city VARCHAR(20),
   state CHAR(2),
   zip CHAR(10),
   manager VARCHAR(30),
   PRIMARY KEY(storeid)
);

Select * from stores;

CREATE TABLE orders (
   ordernumber INTEGER NOT NULL,
   linenumber INTEGER NOT NULL,
   storeid CHAR(5) NOT NULL,
   menuitemid CHAR(5),
   price NUMERIC(5,2),
   time TIMESTAMP,
   PRIMARY KEY(storeid, ordernumber, linenumber),
   FOREIGN KEY(storeid) REFERENCES stores(storeid) ON DELETE CASCADE
);

Select * from Orders;

INSERT INTO items VALUES ('CHKSD', 'Chicken Salad', 2.85, '5-JUN-00');
INSERT INTO items VALUES ('FRTSD', 'Fruit Salad', 3.45, '6-JUN-00');
INSERT INTO items VALUES ('GDNSD', 'Garden Salad', 0.99, '3-FEB-01');
INSERT INTO items VALUES ('MILSD', 'Millennium Salad', NULL, '16-AUG-02');
INSERT INTO items VALUES ('SODA', 'Soda', 0.99, '2-FEB-02');
INSERT INTO items VALUES ('WATER', 'Water', 0, '20-FEB-01');
INSERT INTO items VALUES ('FRPLT', 'Fruit Plate', 3.99, '22-NOV-02');

Select * from items;

INSERT INTO vendors VALUES ('VGRUS', 'Veggies_R_Us', 'Candy', 'Corn', NULL);
INSERT INTO vendors VALUES ('DNDRY', 'Don''s Dairy', 'Marla', 'Milker', 'VGRUS');
INSERT INTO vendors VALUES ('FLVCR', 'Flavorful Creams', 'Sherman', 'Sherbert', 'VGRUS');
INSERT INTO vendors VALUES ('FRTFR', '"Fruit Eating" Friends', 'Gilbert', 'Grape', 'FLVCR');
INSERT INTO vendors VALUES ('EDDRS', 'Ed''s Dressings', 'Sam', 'Sauce', 'FRTFR');
INSERT INTO vendors VALUES ('SPWTR', 'Spring Water Supply', 'Gus', 'Hing', 'EDDRS');

Select * from vendors;

INSERT INTO ingredients VALUES ('CHESE', 'Cheese', 'scoop', 0.03, 'Milk', 150, 'DNDRY');
INSERT INTO ingredients VALUES ('CHIKN', 'Chicken', 'strip', 0.45, 'Meat', 120, 'DNDRY');
INSERT INTO ingredients VALUES ('CRUTN', 'Crouton', 'piece', 0.01, 'Bread', 400, 'EDDRS');
INSERT INTO ingredients VALUES ('GRAPE', 'Grape', 'piece', 0.01, 'Fruit', 300, 'FRTFR');
INSERT INTO ingredients VALUES ('LETUS', 'Lettuce', 'bowl', 0.01, 'Vegetable', 200, 'VGRUS');
INSERT INTO ingredients VALUES ('PICKL', 'Pickle', 'slice', 0.04, 'Vegetable', 800, 'VGRUS');
INSERT INTO ingredients VALUES ('SCTDR', 'Secret Dressing', 'ounce', 0.03, NULL, 120, NULL);
INSERT INTO ingredients VALUES ('TOMTO', 'Tomato', 'slice', 0.03, 'Fruit', 15, 'VGRUS');
INSERT INTO ingredients VALUES ('WATER', 'Water', 'glass', 0.06, NULL, NULL, 'SPWTR');
INSERT INTO ingredients VALUES ('SODA', 'Soda', 'glass', 0.69, NULL, 5000, 'SPWTR');
INSERT INTO ingredients VALUES ('WTRML', 'Watermelon', 'piece', 0.02, 'Fruit', NULL, 'FRTFR');
INSERT INTO ingredients VALUES ('ORNG', 'Orange', 'slice', 0.05, 'Fruit', 10, 'FRTFR');

Select * from ingredients;

INSERT INTO madewith VALUES ('CHKSD', 'CHESE', 2);
INSERT INTO madewith VALUES ('CHKSD', 'CHIKN', 4);
INSERT INTO madewith VALUES ('CHKSD', 'LETUS', 1);
INSERT INTO madewith VALUES ('CHKSD', 'SCTDR', 1);
INSERT INTO madewith VALUES ('FRTSD', 'GRAPE', 10);
INSERT INTO madewith VALUES ('FRTSD', 'WTRML', 5);
INSERT INTO madewith VALUES ('GDNSD', 'LETUS', 4);
INSERT INTO madewith VALUES ('GDNSD', 'TOMTO', 8);
INSERT INTO madewith VALUES ('FRPLT', 'WTRML', 10);
INSERT INTO madewith VALUES ('FRPLT', 'GRAPE', 10);
INSERT INTO madewith VALUES ('FRPLT', 'CHESE', 10);
INSERT INTO madewith VALUES ('FRPLT', 'CRUTN', 10);
INSERT INTO madewith VALUES ('FRPLT', 'TOMTO', 8);
INSERT INTO madewith VALUES ('WATER', 'WATER', 1);
INSERT INTO madewith VALUES ('SODA', 'SODA', 1);
INSERT INTO madewith VALUES ('FRPLT', 'ORNG', 10);

Select * from madewith;

INSERT INTO meals VALUES ('CKSDS', 'Chicken N Suds');
INSERT INTO meals VALUES ('VGNET', 'Vegan Eatin''');

Select * from meals;

INSERT INTO partof VALUES ('CKSDS', 'CHKSD', 1, 0.02);
INSERT INTO partof VALUES ('CKSDS', 'SODA', 1, 0.10);
INSERT INTO partof VALUES ('VGNET', 'GDNSD', 1, 0.03);
INSERT INTO partof VALUES ('VGNET', 'FRTSD', 1, 0.01);
INSERT INTO partof VALUES ('VGNET', 'WATER', 1, 0.00);

Select * from partof;

INSERT INTO ads VALUES ('Grazing in style');
INSERT INTO ads VALUES (NULL);
INSERT INTO ads VALUES ('Bovine friendly and heart smart');
INSERT INTO ads VALUES ('Where the grazin''s good');
INSERT INTO ads VALUES ('The grass is greener here');
INSERT INTO ads VALUES ('Welcome to the "other side"');

Select * from ads;

INSERT INTO stores VALUES ('FIRST','1111 Main St.','Waco','TX','76798','Jeff Donahoo');
INSERT INTO stores VALUES ('#2STR','2222 2nd Ave.','Waco','TX','76798-7356','Greg Speegle');
INSERT INTO stores VALUES ('NDSTR','3333 3rd St.','Fargo','ND','58106','Jeff Speegle');
INSERT INTO stores VALUES ('CASTR','4444 4th Blvd','San Francsico','CA','94101-4150','Greg Donahoo');
INSERT INTO stores VALUES ('NWSTR',null,null,'TX',null,'Man Ager');

Select * from stores;

INSERT INTO orders VALUES (1,1,'FIRST','FRTSD',3.45,'26-JAN-2005 1:46:04.188');
INSERT INTO orders VALUES (1,2,'FIRST','WATER',0.0,'26-JAN-2005 1:46:19.188');
INSERT INTO orders VALUES (1,3,'FIRST','WATER',0.0,'26-JAN-2005 1:46:34.188');
INSERT INTO orders VALUES (2,1,'FIRST','CHKSD',2.85,'26-JAN-2005 1:47:49.188');
INSERT INTO orders VALUES (3,1,'FIRST','SODA ',0.99,'26-JAN-2005 1:49:04.188');
INSERT INTO orders VALUES (3,2,'FIRST','FRPLT',3.99,'26-JAN-2005 1:49:19.188');
INSERT INTO orders VALUES (3,3,'FIRST','VGNET',4.38,'26-JAN-2005 1:49:34.188');
INSERT INTO orders VALUES (1,1,'#2STR','CKSDS',3.68,'26-JAN-2005 2:02:04.188');
INSERT INTO orders VALUES (1,2,'#2STR','CHKSD',2.85,'26-JAN-2005 2:02:19.188');
INSERT INTO orders VALUES (1,3,'#2STR','SODA ',0.99,'26-JAN-2005 2:02:34.188');
INSERT INTO orders VALUES (1,4,'#2STR','GDNSD',0.99,'26-JAN-2005 2:02:49.188');
INSERT INTO orders VALUES (2,1,'#2STR','CHKSD',2.85,'26-JAN-2005 2:04:04.188');
INSERT INTO orders VALUES (2,2,'#2STR','SODA ',0.99,'26-JAN-2005 2:04:19.188');
INSERT INTO orders VALUES (3,1,'#2STR','CHKSD',2.85,'26-JAN-2005 2:05:34.188');
INSERT INTO orders VALUES (3,2,'#2STR','FRPLT',3.99,'26-JAN-2005 2:05:49.188');
INSERT INTO orders VALUES (3,3,'#2STR','GDNSD',0.99,'26-JAN-2005 2:06:04.188');
INSERT INTO orders VALUES (1,1,'NDSTR','WATER',0.0,'26-JAN-2005  2:1:04.188');
INSERT INTO orders VALUES (1,2,'NDSTR','FRPLT',3.99,'26-JAN-2005 2:1:19.188');
INSERT INTO orders VALUES (2,1,'NDSTR','GDNSD',0.99,'26-JAN-2005 2:15:34.188');
INSERT INTO orders VALUES (3,1,'NDSTR','VGNET',4.38,'26-JAN-2005 2:16:49.188');
INSERT INTO orders VALUES (3,2,'NDSTR','FRPLT',3.99,'26-JAN-2005 2:17:04.188');
INSERT INTO orders VALUES (3,3,'NDSTR','FRTSD',3.45,'26-JAN-2005 2:17:19.188');
INSERT INTO orders VALUES (3,4,'NDSTR','SODA ',0.99,'26-JAN-2005 2:17:34.188');
INSERT INTO orders VALUES (1,1,'CASTR','CHKSD',2.85,'26-JAN-2005 2:22:04.188');
INSERT INTO orders VALUES (1,2,'CASTR','GDNSD',0.99,'26-JAN-2005 2:22:19.188');
INSERT INTO orders VALUES (2,1,'CASTR','SODA ',0.99,'26-JAN-2005 2:23:34.188');
INSERT INTO orders VALUES (2,2,'CASTR','FRTSD',3.45,'26-JAN-2005 2:23:49.188');
INSERT INTO orders VALUES (2,3,'CASTR','SODA ',0.99,'26-JAN-2005 2:24:04.188');
INSERT INTO orders VALUES (2,4,'CASTR','VGNET',4.38,'26-JAN-2005 2:24:19.188');
INSERT INTO orders VALUES (3,1,'CASTR','VGNET',4.38,'26-JAN-2005 2:25:34.188');
INSERT INTO orders VALUES (3,2,'CASTR','FRPLT',3.99,'26-JAN-2005 2:25:49.188');
INSERT INTO orders VALUES (3,3,'CASTR','FRTSD',3.45,'26-JAN-2005 2:26:04.188');
INSERT INTO orders VALUES (3,4,'CASTR','WATER',0.0,'26-JAN-2005 2:26:19.188');
INSERT INTO orders VALUES (3,5,'CASTR','CHKSD',2.85,'26-JAN-2005 2:26:34.188');

Select * from orders;