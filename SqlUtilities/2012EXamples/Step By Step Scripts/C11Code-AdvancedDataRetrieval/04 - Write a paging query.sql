--Use this script to write a paging query
USE AdventureWorks2012;
SELECT
ProductID,
ProductNumber,
Name AS ProductName,
ListPrice
FROM Production.Product
ORDER BY ProductID
OFFSET 0 ROWS
FETCH NEXT 10 ROWS ONLY;

USE AdventureWorks2012;
SELECT
ProductID,
ProductNumber,
Name AS ProductName,
ListPrice
FROM Production.Product
ORDER BY ProductID
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY;