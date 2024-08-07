CREATE DATABASE Produto_DB;
USE Produto_DB;

CREATE TABLE Production(
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    StandardCost DECIMAL(10, 2) NOT NULL,
    ListPrice DECIMAL(10, 2) NOT NULL,
    ModifiedDate DATETIME DEFAULT GETDATE()
);

INSERT INTO Production (Name, StandardCost, ListPrice)
VALUES 
    ('Mountain Bike', 500, 1200),
    ('Road Bike', 700, 1500),
    ('Helmet', 25, 50),
    ('Mountain Bike Socks', 5, 12),
    ('Cycling Gloves', 15, 30),
    ('Water Bottle', 2, 10),
    ('Bike Pump', 10, 25),
    ('Smartwatch', 100, 250),
    ('Smartphone', 200, 400);

UPDATE Production
SET ListPrice = 15
WHERE Name = 'Mountain Bike Socks';

SELECT TOP 5 Name, ListPrice
FROM Production
ORDER BY ListPrice DESC;