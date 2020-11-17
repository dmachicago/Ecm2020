USE AdventureWorks2012;
SELECT TOP(10)
SalesOrderNumber,
TotalDue,
CAST(TotalDue AS decimal(10,2)) AS TotalDueCast,
OrderDate,
CAST(OrderDate AS DATE) AS OrderDateCast
FROM Sales.SalesOrderHeader;