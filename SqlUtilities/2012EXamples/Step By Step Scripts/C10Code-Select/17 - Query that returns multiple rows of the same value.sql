--This query returns multiple product names prior to the demonstration of using a DISTINCT

USE AdventureWorks2012;
SELECT
p.Name AS ProductName
FROM Production.Product AS p
INNER JOIN Sales.SalesOrderDetail sd
ON p.ProductID = sd.ProductID