CREATE DATABASE Week7DB;
USE Week7DB;


-- =========================================
-- 1. CREATE TABLES
-- =========================================

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50),
    Email VARCHAR(100),
    RegistrationDate DATE
);

CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50)
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    CategoryID INT,
    Price DECIMAL(10,2),
    StockQuantity INT,
    Rating DECIMAL(2,1),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    PaymentMethod VARCHAR(30),
    Amount DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


-- =========================================
-- 2. INSERT CUSTOMER DATA
-- =========================================

INSERT INTO Customer VALUES
(1, 'Priya', 'Chennai', 'priya@gmail.com', '2026-01-10'),
(2, 'Karthik', 'Bangalore', 'karthik@gmail.com', '2026-02-15'),
(3, 'Meena', 'Chennai', 'meena@gmail.com', '2026-03-20'),
(4, 'Arun', 'Coimbatore', 'arun@gmail.com', '2026-04-05'),
(5, 'Divya', 'Bangalore', 'divya@gmail.com', '2026-05-12');


-- =========================================
-- 3. INSERT CATEGORY DATA
-- =========================================

INSERT INTO Category VALUES
(1, 'Electronics'),
(2, 'Accessories'),
(3, 'Home Appliances');


-- =========================================
-- 4. INSERT PRODUCT DATA
-- =========================================

INSERT INTO Product VALUES
(101, 'Smartphone', 1, 25000, 15, 4.5),
(102, 'Laptop', 1, 55000, 8, 4.7),
(103, 'Bluetooth Speaker', 1, 4500, 20, 4.2),
(104, 'Mobile Charger', 2, 1200, 30, 4.0),
(105, 'Wireless Mouse', 2, 800, 0, 3.9),
(106, 'Smart Watch', 1, 7000, 12, 4.6),
(107, 'Keyboard', 2, 1500, 5, 4.3),
(108, 'Air Conditioner', 3, 42000, 3, 4.8);


-- =========================================
-- 5. INSERT ORDER DATA
-- =========================================

INSERT INTO Orders VALUES
(1001, 1, '2026-06-01', 'Completed'),
(1002, 2, '2026-06-05', 'Pending'),
(1003, 3, '2026-06-10', 'Completed'),
(1004, 4, '2026-07-01', 'Cancelled'),
(1005, 5, '2026-07-15', 'Completed');


-- =========================================
-- 6. INSERT ORDER DETAILS
-- =========================================

INSERT INTO OrderDetails VALUES
(1001, 101, 1),
(1001, 104, 2),
(1002, 102, 1),
(1003, 106, 1),
(1004, 105, 2),
(1005, 108, 1);


-- =========================================
-- 7. INSERT PAYMENT DATA
-- =========================================

INSERT INTO Payment VALUES
(501, 1001, 'UPI', 27400),
(502, 1002, 'Credit Card', 55000),
(503, 1003, 'Cash', 7000),
(504, 1004, 'UPI', 1600),
(505, 1005, 'Debit Card', 42000);


-- =========================================
-- 8. BASIC SELECT QUERIES
-- =========================================

-- 1. Display all customer details
SELECT * FROM Customer;

-- 2. Display all available products
SELECT * FROM Product
WHERE StockQuantity > 0;

-- 3. Retrieve product names and prices
SELECT ProductName, Price
FROM Product;

-- 4. Display all orders
SELECT * FROM Orders;

-- 5. Retrieve payment details
SELECT * FROM Payment;


-- =========================================
-- 9. WHERE FILTERING
-- =========================================

-- 1. Products with price greater than 5000
SELECT ProductName, Price
FROM Product
WHERE Price > 5000;

-- 2. Products available in stock
SELECT *
FROM Product
WHERE StockQuantity > 0;

-- 3. Customers from Chennai
SELECT *
FROM Customer
WHERE City = 'Chennai';

-- 4. Completed orders
SELECT *
FROM Orders
WHERE Status = 'Completed';

-- 5. Products with rating above 4
SELECT ProductName, Rating
FROM Product
WHERE Rating > 4;


-- =========================================
-- 10. ORDER BY
-- =========================================

-- 1. Lowest to highest price
SELECT *
FROM Product
ORDER BY Price ASC;

-- 2. Customers alphabetically
SELECT *
FROM Customer
ORDER BY CustomerName ASC;

-- 3. Top expensive products
SELECT *
FROM Product
ORDER BY Price DESC;

-- 4. Latest orders first
SELECT *
FROM Orders
ORDER BY OrderDate DESC;


-- =========================================
-- 11. DISTINCT
-- =========================================

-- 1. Unique product categories
SELECT DISTINCT CategoryID
FROM Product;

-- 2. Different payment methods
SELECT DISTINCT PaymentMethod
FROM Payment;

-- 3. Unique customer locations
SELECT DISTINCT City
FROM Customer;


-- =========================================
-- 12. PRODUCT SEARCH
-- =========================================

-- 1. Products between 1000 and 5000
SELECT *
FROM Product
WHERE Price BETWEEN 1000 AND 5000;

-- 2. Products belonging to Electronics category
SELECT *
FROM Product
WHERE CategoryID = 1;

-- 3. Products currently available
SELECT *
FROM Product
WHERE StockQuantity > 0;

-- 4. Search products containing "Mobile"
SELECT *
FROM Product
WHERE ProductName LIKE '%Mobile%';

-- 5. Low-stock products
SELECT *
FROM Product
WHERE StockQuantity < 10;


-- =========================================
-- 13. CUSTOMER AND PRODUCT INFORMATION
-- =========================================

-- 1. Customer details with their orders
SELECT
    C.CustomerName,
    C.City,
    O.OrderID,
    O.OrderDate,
    O.Status
FROM Customer C
JOIN Orders O
ON C.CustomerID = O.CustomerID;


-- 2. Product details with category
SELECT
    P.ProductName,
    P.Price,
    C.CategoryName
FROM Product P
JOIN Category C
ON P.CategoryID = C.CategoryID;


-- 3. Customers who purchased Smartphone
SELECT DISTINCT
    C.CustomerName
FROM Customer C
JOIN Orders O
ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD
ON O.OrderID = OD.OrderID
JOIN Product P
ON OD.ProductID = P.ProductID
WHERE P.ProductName = 'Smartphone';


-- 4. Products purchased by each customer
SELECT
    C.CustomerName,
    P.ProductName,
    OD.Quantity
FROM Customer C
JOIN Orders O
ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD
ON O.OrderID = OD.OrderID
JOIN Product P
ON OD.ProductID = P.ProductID;


-- =========================================
-- 14. MULTIPLE FILTERING CONDITIONS
-- =========================================

-- 1. Electronics products costing more than 10000
SELECT *
FROM Product
WHERE CategoryID = 1
AND Price > 10000;

-- 2. Customers from Chennai OR Bangalore
SELECT *
FROM Customer
WHERE City = 'Chennai'
OR City = 'Bangalore';

-- 3. Products containing "Mobile"
SELECT *
FROM Product
WHERE ProductName LIKE '%Mobile%';

-- 4. Orders between two dates
SELECT *
FROM Orders
WHERE OrderDate BETWEEN '2026-06-01'
AND '2026-06-30';

-- Using IN
SELECT *
FROM Customer
WHERE City IN ('Chennai', 'Bangalore');


-- =========================================
-- 15. BUSINESS REPORT 1
-- PRODUCT AVAILABILITY REPORT
-- =========================================

SELECT
    ProductName,
    Price,
    StockQuantity,
    CASE
        WHEN StockQuantity > 0 THEN 'Available'
        ELSE 'Out of Stock'
    END AS Availability
FROM Product;


-- =========================================
-- 16. BUSINESS REPORT 2
-- CUSTOMER REPORT
-- =========================================

-- Total number of customers
SELECT COUNT(*) AS TotalCustomers
FROM Customer;

-- Customer list by city
SELECT City, COUNT(*) AS CustomerCount
FROM Customer
GROUP BY City;

-- New customer registrations
SELECT *
FROM Customer
ORDER BY RegistrationDate DESC;


-- =========================================
-- 17. BUSINESS REPORT 3
-- ORDER REPORT
-- =========================================

-- Total orders
SELECT COUNT(*) AS TotalOrders
FROM Orders;

-- Completed orders
SELECT COUNT(*) AS CompletedOrders
FROM Orders
WHERE Status = 'Completed';

-- Pending orders
SELECT COUNT(*) AS PendingOrders
FROM Orders
WHERE Status = 'Pending';

-- Cancelled orders
SELECT COUNT(*) AS CancelledOrders
FROM Orders
WHERE Status = 'Cancelled';


-- =========================================
-- 18. BUSINESS REPORT 4
-- PRODUCT PERFORMANCE REPORT
-- =========================================

-- Highest-priced products
SELECT *
FROM Product
ORDER BY Price DESC;

-- Most reviewed / highest-rated products
SELECT ProductName, Rating
FROM Product
ORDER BY Rating DESC;

-- Available products
SELECT ProductName, StockQuantity
FROM Product
WHERE StockQuantity > 0;
