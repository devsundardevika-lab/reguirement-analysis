CREATE DATABASE Week6DB2;
USE Week6DB2;

-- 1. Third Normal Form (3NF)

CREATE TABLE Customer (
    CustomerID VARCHAR(10) PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE City (
    City VARCHAR(50) PRIMARY KEY,
    State VARCHAR(50)
);

-- Insert 3NF Data
INSERT INTO City VALUES
('Coimbatore', 'Tamil Nadu'),
('Mysore', 'Karnataka');

INSERT INTO Customer VALUES
('C1', 'Priya', 'Coimbatore'),
('C2', 'Karthik', 'Mysore');

SELECT * FROM Customer;
SELECT * FROM City;


-- 2. BCNF

CREATE TABLE Teacher (
    Teacher VARCHAR(50),
    Subject VARCHAR(50)
);

CREATE TABLE SubjectRoom (
    Subject VARCHAR(50),
    Room VARCHAR(50)
);

-- Insert BCNF Data
INSERT INTO Teacher VALUES
('Suresh', 'Python'),
('Meena', 'C++');

INSERT INTO SubjectRoom VALUES
('Python', 'Room201'),
('C++', 'Room202');

SELECT * FROM Teacher;
SELECT * FROM SubjectRoom;


-- 3. Final Normalized Online Order Management System

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID VARCHAR(10),
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Product (
    ProductID VARCHAR(10) PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID VARCHAR(10),
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);


-- 4. Insert Product Data
INSERT INTO Product VALUES
('P1', 'Smartphone', 25000),
('P2', 'Power Bank', 1200),
('P3', 'Smart Watch', 3500);


-- 5. Insert Order Data
INSERT INTO Orders VALUES
(201, 'C1', '2026-10-01'),
(202, 'C2', '2026-10-02');


-- 6. Insert Order Details
INSERT INTO OrderDetails VALUES
(201, 'P1', 1),
(201, 'P2', 2),
(202, 'P3', 1);


-- 7. Retrieve Final Normalized Data
SELECT
    O.OrderID,
    C.CustomerName,
    P.ProductName,
    OD.Quantity
FROM Orders O
JOIN Customer C
    ON O.CustomerID = C.CustomerID
JOIN OrderDetails OD
    ON O.OrderID = OD.OrderID
JOIN Product P
    ON OD.ProductID = P.ProductID;
