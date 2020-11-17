-- Use this script to perform a more precise BETWEEN
SELECT
AccountNumber,
SalesOrderID,
OrderDate
FROM Sales.SalesOrderHeader
WHERE
OrderDate >= '5/1/2007 00:00:00' AND OrderDate<= '12/31/2007'