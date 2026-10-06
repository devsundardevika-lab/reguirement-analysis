CREATE DATABASE OnlineShoppingDB;
USE OnlineShoppingDB;

-- 1. Unnormalized Orders Table
CREATE TABLE Orders (
    OrderID INT,
    CustomerID VARCHAR(10),
    CustomerName VARCHAR(50),
    ProductID VARCHAR(10),
    ProductName VARCHAR(50),
    Quantity INT
);

-- Insert Data
INSERT INTO Orders VALUES
(201, 'C1', 'Priya', 'P1', 'Mobile', 1),
(202, 'C1', 'Priya', 'P2', 'Keyboard', 2),
(203, 'C2', 'Karthik', 'P3', 'Headphones', 1);

-- View Data
SELECT * FROM Orders;


-- 2. Functional Dependencies
-- CustomerID -> CustomerName
-- ProductID -> ProductName
-- OrderID -> CustomerID


-- 3. Update Anomaly
UPDATE Orders
SET CustomerName = 'Priya Sharma'
WHERE CustomerID = 'C1';

SELECT * FROM Orders;


-- 4. Insertion Anomaly
-- Customer cannot be inserted alone
-- because Orders needs order/product details.


-- 5. Deletion Anomaly
DELETE FROM Orders
WHERE OrderID = 203;

SELECT * FROM Orders;


-- 6. Normalized Customer Table
CREATE TABLE Customer (
    CustomerID VARCHAR(10),
    CustomerName VARCHAR(50)
);


-- 7. Normalized Product Table
CREATE TABLE Product (
    ProductID VARCHAR(10),
    ProductName VARCHAR(50)
);


-- 8. New Orders Table
CREATE TABLE Orders_New (
    OrderID INT,
    CustomerID VARCHAR(10),
    ProductID VARCHAR(10),
    Quantity INT
);


-- Insert Customer Data
INSERT INTO Customer VALUES
('C1', 'Priya'),
('C2', 'Karthik');


-- Insert Product Data
INSERT INTO Product VALUES
('P1', 'Mobile'),
('P2', 'Keyboard'),
('P3', 'Headphones');


-- Insert Order Data
INSERT INTO Orders_New VALUES
(201, 'C1', 'P1', 1),
(202, 'C1', 'P2', 2),
(203, 'C2', 'P3', 1);


-- 9. Retrieve Normalized Data Using JOIN
SELECT 
    O.OrderID,
    C.CustomerName,
    P.ProductName,
    O.Quantity
FROM Orders_New O
JOIN Customer C
    ON O.CustomerID = C.CustomerID
JOIN Product P
    ON O.ProductID = P.ProductID;
