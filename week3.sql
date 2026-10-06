USE ecoms_db;

DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Seller;

CREATE TABLE Seller (
    Seller_ID INT AUTO_INCREMENT PRIMARY KEY,
    Seller_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Address VARCHAR(150) NOT NULL
);

CREATE TABLE Inventory (
    Inventory_ID INT AUTO_INCREMENT PRIMARY KEY,
    Product_ID INT NOT NULL,
    Seller_ID INT NOT NULL,
    Stock_Quantity INT NOT NULL,
    Stock_Status VARCHAR(20) NOT NULL,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Seller_ID) REFERENCES Seller(Seller_ID)
);

INSERT INTO Seller
(Seller_Name, Email, Phone, Address)
VALUES
('ABC Electronics', 'abc@gmail.com', '9876543210', 'Chennai'),
('Fashion World', 'fashion@gmail.com', '9876543211', 'Coimbatore'),
('Book House', 'book@gmail.com', '9876543212', 'Madurai');

INSERT INTO Inventory
(Product_ID, Seller_ID, Stock_Quantity, Stock_Status)
VALUES
(1, 1, 35, 'Available'),
(2, 2, 20, 'Available'),
(3, 3, 0, 'Out of Stock');

SELECT * FROM Seller;

SELECT * FROM Inventory;
