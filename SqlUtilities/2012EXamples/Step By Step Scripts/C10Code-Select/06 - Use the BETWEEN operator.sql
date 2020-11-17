--Use this query to filter the results of a query using the BETWEEN operator
USE AdventureWorks2012;
SELECT
AccountNumber,
SalesOrderID,
OrderDate
FROM Sales.SalesOrderHeader
WHERE
OrderDate BETWEEN '5/1/2007' AND '12/31/2007'