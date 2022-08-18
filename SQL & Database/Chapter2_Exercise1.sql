CREATE DATABASE ProductShipping

CREATE TABLE Employees(
Empid INT PRIMARY KEY,
Lastname VARCHAR(20),
Firstname VARCHAR(10),
Title VARCHAR (30),
Titleofcourtesy VARCHAR(25),
Birthdate DATETIME,
Hiredate DATETIME,
Address VARCHAR(60),
City VARCHAR(60),
Region VARCHAR(15),
Postalcode VARCHAR(10),
Country VARCHAR(15),
Phone VARCHAR(24),
Mgrid INT)

CREATE TABLE Categories(
Categoryid INT PRIMARY KEY,
Categoryname VARCHAR(15),
Description VARCHAR(200))

CREATE TABLE Suppliers(
Supplierid INT PRIMARY KEY,
Companyname VARCHAR(40),
Contactname VARCHAR(30),
Contacttitle VARCHAR(30),
Address VARCHAR(60),
City VARCHAR(15),
Region VARCHAR(15),
Postalcode VARCHAR(10),
Country VARCHAR(15),
Phone VARCHAR(24),
Fax VARCHAR(24))

CREATE TABLE Products(
Productid INT PRIMARY KEY,
Productname VARCHAR(40),
Supplierid INT,
Categoryid INT,
Unitprice FLOAT,
Discontinued bit(1) )


CREATE TABLE Customers(
Custid INT PRIMARY KEY,
Companyname VARCHAR(40),
Contactname VARCHAR(30),
Contacttitle VARCHAR(30),
Address VARCHAR(60),
City VARCHAR(15),
Region VARCHAR(15),
Postalcode VARCHAR(10),
Country VARCHAR(15),
Phone VARCHAR(24),
Fax VARCHAR(24))

CREATE TABLE Shippers(
Shipperid INT PRIMARY KEY,
Companyname VARCHAR(40),
Phone VARCHAR(24))

CREATE TABLE Orders(
Orderid INT PRIMARY KEY,
Custid INT, 
Empid INT,
Orderdate DATETIME,
Requireddate DATETIME, 
Shippeddate DATETIME, 
Shipperid INT,
Freight FLOAT,
Shipname VARCHAR(40),
Shipaddress VARCHAR(60),
Shipcity VARCHAR(15),
Shipregion VARCHAR(15),
Shippostalcode VARCHAR(10),
Shipcountry VARCHAR(15))

CREATE TABLE OrderDetails(
Orderid INT,
Productid INT,
Unitprice FLOAT,
Qty SMALLINT,
Discount FLOAT,
PRIMARY KEY(Orderid, Productid))

#3. Tao cac rang buoc(Constraint)
#a) Unique Key
ALTER TABLE categories
ADD CONSTRAINT UC_Categories UNIQUE KEY (Categoryname)

#b) Foreign Key
ALTER TABLE products
ADD CONSTRAINT FK_Products_Categories FOREIGN KEY (Categoryid) REFERENCES categories(Categoryid)

ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_Employees FOREIGN KEY (Mgrid) REFERENCES Employees(Empid)

ALTER TABLE products
ADD CONSTRAINT FK_Products_Suppliers FOREIGN KEY (Supplierid) REFERENCES Suppliers(Supplierid)

ALTER TABLE Orderdetails
ADD CONSTRAINT FK_Orderdetails_Products FOREIGN KEY (Productid) REFERENCES Products(Productid)

ALTER TABLE Orderdetails
ADD CONSTRAINT FK_Orderdetails_Orders FOREIGN KEY (Orderid) REFERENCES Orders(orderid)

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customers FOREIGN KEY (Custid) REFERENCES Customers(Custid)

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Shippers FOREIGN KEY (Shipperid) REFERENCES Shippers(Shipperid)

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Employees FOREIGN KEY (Empid) REFERENCES Employees(Empid)

#c)check
ALTER TABLE products
ADD CONSTRAINT CHK_Products_unitprice
CHECK (Unitprice >=0)

ALTER TABLE employees 
ADD CONSTRAINT CHK_birthdate
CHECK (birthdate <= CURRENT_TIMESTAMP)

#d)Default
ALTER TABLE orderdetails
ALTER Qty set DEFAULT  1  
