--Use the query to perform an INNER JOIN on two tables
USE AdventureWorks2012;
SELECT
p.ProductID,
p.Name AS ProductName,
sd.OrderQty,
sd.UnitPrice
FROM Production.Product AS p
INNER JOIN Sales.SalesOrderDetail sd
ON p.ProductID = sd.ProductID