--Use this query to return a distinct list of products that have not been shipped
USE AdventureWorks2012;
SELECT DISTINCT
p.Name AS ProductName
FROM Production.Product AS p
INNER JOIN Sales.SalesOrderDetail sd
ON p.ProductID = sd.ProductID
WHERE
sd.CarrierTrackingNumber IS NULL
ORDER BY productname