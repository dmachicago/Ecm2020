--Use this query to return the top 5 sales
USE AdventureWorks2012;
SELECT TOP(5)
SalesOrderID,
OrderDate,
SalesOrderNumber,
TotalDue
FROM Sales.SalesOrderHeader
ORDER BY
TotalDue DESC