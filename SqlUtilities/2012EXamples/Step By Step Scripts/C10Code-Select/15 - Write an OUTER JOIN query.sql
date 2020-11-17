--Use this query to perform a LEFT OUTER JOIN
SELECT
p.ProductID,
sd.ProductID,
p.Name AS ProductName,
sd.OrderQty,
sd.UnitPrice
FROM Production.Product AS p
LEFT OUTER JOIN Sales.SalesOrderDetail sd
ON p.ProductID = sd.ProductID