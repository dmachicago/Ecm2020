--Use this query to filter the results with the IN operator
USE AdventureWorks2012;
SELECT
SalesOrderDetailID,
OrderQty,
ProductID,
ModifiedDate
FROM Sales.SalesOrderDetail s
WHERE
ProductID IN (776, 778, 747, 809)