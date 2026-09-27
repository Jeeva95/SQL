CREATE DATABASE ABCFashion;
USE ABCFashion;

-------Tables & Records for SQL Mandatory Assignment 1
-----Salesman table creation
CREATE TABLE Salesman (
SalesmanId INT,
Name VARCHAR(255),
Commission DECIMAL(10, 2),
City VARCHAR(255),
Age INT
);
-----Salesman table record insertion
INSERT INTO Salesman (SalesmanId, Name, Commission, City, Age)
VALUES
(101, 'Joe', 50, 'California', 17),
(102, 'Simon', 75, 'Texas', 25),
(103, 'Jessie', 105, 'Florida', 35),
(104, 'Danny', 100, 'Texas', 22),
(105, 'Lia', 65, 'New Jersey', 30);

SELECT * FROM Salesman;

------Customer table creation
CREATE TABLE Customer (
SalesmanId INT,
CustomerId INT,
CustomerName VARCHAR(255),
PurchaseAmount INT,
);
-------Customer table record insertion
INSERT INTO Customer (SalesmanId, CustomerId, CustomerName, PurchaseAmount)
VALUES
(101, 2345, 'Andrew', 550),
(103, 1575, 'Lucky', 4500),
(104, 2345, 'Andrew', 4000),
(107, 3747, 'Remona', 2700),
(110, 4004, 'Julia', 4545);

SELECT * FROM Customer;

-------Orders table Creation
CREATE TABLE Orders (OrderId int, CustomerId int, SalesmanId int, Orderdate Date, Amount
money)
-------Orders table record insertion
INSERT INTO Orders Values
(5001,2345,101,'2021-07-01',550),
(5003,1234,105,'2022-02-15',1500)

SELECT * FROM Orders;

---------------------------------Tasks to be Performed:------------------------------------
----------1. Insert a new record in your Orders table.
-----Answer 1. 
INSERT INTO Orders
(OrderId, CustomerId, SalesmanId, Orderdate, Amount)
VALUES
(5004, 2345, 101, '2022-03-10', 2500);

SELECT * FROM Orders;





----------2. Add Primary key constraint for SalesmanId column in Salesman table. 
----------Add default constraint for City column in Salesman table. 
----------Add Foreign key constraint for SalesmanId column in Customer table. 
----------Add not null constraint in Customer_name column for the Customer table.
----Answer 2. 
----1. Add Primary Key to SalesmanId
ALTER TABLE Salesman
ALTER COLUMN SalesmanId INT NOT NULL;

ALTER TABLE Salesman
ADD CONSTRAINT PK_Salesman
PRIMARY KEY (SalesmanId);

-----2. Add Default Constraint to City
ALTER TABLE Salesman
ADD CONSTRAINT DF_Salesman_City
DEFAULT 'Unknown' FOR City;

-----3. Add Foreign Key to SalesmanId in Customer
DELETE FROM Customer
WHERE SalesmanId NOT IN (
    SELECT SalesmanId
    FROM Salesman
);

ALTER TABLE Customer
ADD CONSTRAINT FK_Customer_Salesman
FOREIGN KEY (SalesmanId)
REFERENCES Salesman(SalesmanId);

-------4. Add NOT NULL to CustomerName
ALTER TABLE Customer
ALTER COLUMN CustomerName VARCHAR(255) NOT NULL;





------------3. Fetch the data where the Customer’s name is ending with ‘N’ 
------------also get the purchase amount value greater than 500.
--------Answer 3
SELECT *
FROM Customer
WHERE CustomerName LIKE '%N'
AND PurchaseAmount > 500;





----------4. Using SET operators, retrieve the first result with unique SalesmanId values from two tables, 
----------and the other result containing SalesmanId with duplicates from two tables.
------Answer 4
-----1. Unique SalesmanId values from both tables — UNION
SELECT SalesmanId
FROM Salesman

UNION

SELECT SalesmanId
FROM Customer;

-------2. SalesmanId values including duplicates — UNION ALL
SELECT SalesmanId
FROM Salesman

UNION ALL

SELECT SalesmanId
FROM Customer;





----------------5. Display the below columns which has the matching data.
----------------Orderdate, Salesman Name, Customer Name, Commission, 
----------------and City which has the range of Purchase Amount between 500 to 1500.
--------Answer 5
SELECT 
    O.Orderdate,
    S.Name AS SalesmanName,
    C.CustomerName,
    S.Commission,
    S.City
FROM Orders AS O
INNER JOIN Salesman AS S
    ON O.SalesmanId = S.SalesmanId
INNER JOIN Customer AS C
    ON O.CustomerId = C.CustomerId
    AND O.SalesmanId = C.SalesmanId
WHERE C.PurchaseAmount BETWEEN 500 AND 1500;





----------------6. Using right join fetch all the results from Salesman and Orders table.
-------Answer 6.
SELECT 
    S.SalesmanId,
    S.Name,
    S.Commission,
    S.City,
    S.Age,
    O.OrderId,
    O.CustomerId,
    O.Orderdate,
    O.Amount
FROM Salesman AS S
RIGHT JOIN Orders AS O
    ON S.SalesmanId = O.SalesmanId;