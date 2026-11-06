



CREATE DATABASE Data;
USE DataDigger;


 CREATE CUSTOMERS TABLE
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(100),
    Address VARCHAR(100)
);


INSERT INTO Customers VALUES
(1, 'aasha', 'aasha@gmail.com', 'Mumbai'),
(2, 'Rahul', 'rahul@gmail.com', 'Kolkata'),
(3, 'Riya', 'riya@gmail.com', 'Delhi'),
(4, 'Raj', 'raj@gmail.com', 'Dubai'),
(5, 'Vikas', 'vikas@gmail.com', 'Surat');



CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID)
);


INSERT INTO Orders VALUES
(101, 1, DATE_SUB(CURDATE(), INTERVAL 5 DAY), 51500),
(102, 2, DATE_SUB(CURDATE(), INTERVAL 10 DAY), 15000),
(103, 3, DATE_SUB(CURDATE(), INTERVAL 15 DAY), 3000),
(104, 4, DATE_SUB(CURDATE(), INTERVAL 20 DAY), 8000),
(105, 1, DATE_SUB(CURDATE(), INTERVAL 2 DAY), 2000);



CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);


INSERT INTO Products VALUES
(1, 'Laptop', 50000, 20),
(2, 'Mobile', 15000, 15),
(3, 'Keyboard', 1500, 30),
(4, 'Monitor', 8000, 10),
(5, 'Mouse', 750, 0);



CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    SubTotal DECIMAL(10,2),
);


INSERT INTO OrderDetails VALUES
(1, 101, 1, 1, 50000),
(2, 101, 5, 2, 1500),
(3, 102, 2, 1, 15000),
(4, 103, 3, 2, 3000),
(5, 104, 4, 1, 8000);



SELECT * FROM Customers;

-- Update customer address
UPDATE Customers
SET Address = 'Pune'
WHERE CustomerID = 1;


SELECT * FROM Customers
WHERE Name = 'Aasha';





SELECT * FROM Orders;


SELECT * FROM Orders
WHERE CustomerID = 1;


UPDATE Orders
SET TotalAmount = 52000
WHERE OrderID = 101;


SELECT * FROM Orders
WHERE OrderDate >= CURDATE() - INTERVAL 30 DAY;


SELECT MAX(TotalAmount) AS HighestAmount
FROM Orders;


SELECT MIN(TotalAmount) AS LowestAmount
FROM Orders;


SELECT AVG(TotalAmount) AS AverageAmount
FROM Orders;



SELECT * FROM Products;

SELECT * FROM Products
ORDER BY Price DESC;


UPDATE Products
SET Price = 16000
WHERE ProductID = 2;


SELECT * FROM Products
WHERE Price BETWEEN 500 AND 2000;


SELECT MAX(Price) AS HighestPrice
FROM Products;


SELECT MIN(Price) AS LowestPrice
FROM Products;




SELECT * FROM OrderDetails;


SELECT * FROM OrderDetails
WHERE OrderID = 101;

SELECT SUM(SubTotal) AS TotalRevenue
FROM OrderDetails;


SELECT ProductID, SUM(Quantity) AS TotalSold
FROM OrderDetails
GROUP BY ProductID
ORDER BY TotalSold DESC
LIMIT 3;


SELECT ProductID, COUNT(*) AS TimesSold
FROM OrderDetails
GROUP BY ProductID;




SELECT
    C.Name,
    O.OrderID,
    O.OrderDate,
    P.ProductName,
    OD.Quantity,
    OD.SubTotal
FROM Customers C
JOIN Orders O
ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD
ON O.OrderID = OD.OrderID
JOIN Products P
ON OD.ProductID = P.ProductID;





DELETE FROM Orders
WHERE OrderID = 105;


DELETE FROM Products
WHERE Stock = 0
AND NOT EXISTS (
    SELECT 1
    FROM OrderDetails
    WHERE OrderDetails.ProductID = Products.ProductID
);

DELETE FROM Customers
WHERE CustomerID = 5;

