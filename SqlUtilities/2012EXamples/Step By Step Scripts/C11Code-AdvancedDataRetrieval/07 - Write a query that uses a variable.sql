USE AdventureWorks2012;
DECLARE @ProductID int = 1;

SELECT
ProductID,
ProductNumber,
Name AS ProductName
FROM Production.Product
WHERE ProductID = @ProductID