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

CREATE TABLE ProductCategory (
    ProductCategoryID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL
);

INSERT INTO ProductCategory (Name) VALUES 
    ('Bikes'), 
    ('Accessories'), 
    ('Clothing'), 
    ('Components');

ALTER TABLE Production
ADD ProductionCategoryID INT;

UPDATE Production SET ProductCategoryID = 1 WHERE Name IN ('Mountain Bike', 'Road Bike');
UPDATE Production SET ProductCategoryID = 2 WHERE Name IN ('Helmet', 'Cycling Gloves', 'Water Bottle', 'Bike Pump');
UPDATE Production SET ProductCategoryID = 3 WHERE Name = 'Mountain Bike Socks';
UPDATE Production SET ProductCategoryID = 4 WHERE Name IN ('Smartwatch', 'Smartphone');

CREATE TABLE ProductInventory (
    ProductID INT,
    Quantity INT,
    CONSTRAINT FK_ProductInventory_Product FOREIGN KEY (ProductID) REFERENCES Production(ProductID)
);

INSERT INTO ProductInventory (ProductID, Quantity) VALUES 
(1, 100), (2, 200), (3, 150), (4, 120), (5, 180), (6, 220), (7, 140), (8, 160), (9, 130);

SELECT 
    p.Name AS Produto,
    pc.Name AS Categoria,
    pi.Quantity AS QuantidadeEmEstoque
FROM 
    Production p
JOIN 
    ProductCategory pc ON p.ProductCategoryID = pc.ProductCategoryID
JOIN 
    ProductInventory pi ON p.ProductID = pi.ProductID;

DECLARE @ClothingCategoryID INT;

SELECT 
    @ClothingCategoryID = ProductCategoryID
FROM 
    ProductCategory
WHERE 
    Name = 'Clothing';

DELETE FROM 
    Production
WHERE 
    ProductCategoryID = @ClothingCategoryID;

CREATE TABLE Sales (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(10),
    FirstName NVARCHAR(50) NOT NULL,
    MiddleName NVARCHAR(50),
    LastName NVARCHAR(50) NOT NULL
);

INSERT INTO Sales (Title, FirstName, MiddleName, LastName)
VALUES 
    ('Mr.', 'John', 'A', 'Doe'),
    ('Ms.', 'Jane', NULL, 'Smith'),
    (NULL, 'Alice', 'B', 'Johnson'),
    ('Dr.', 'Robert', NULL, 'Brown'),
    ('Mrs.', 'Emily', 'C', 'Davis');

SELECT 
    CustomerID,
    CASE 
        WHEN Title IS NOT NULL THEN Title + ' ' 
        ELSE '' 
    END +
    FirstName + ' ' +
    CASE 
        WHEN MiddleName IS NOT NULL THEN LEFT(MiddleName, 1) + '. ' 
        ELSE '' 
    END +
    LastName AS NomeCompleto
FROM 
    Sales;