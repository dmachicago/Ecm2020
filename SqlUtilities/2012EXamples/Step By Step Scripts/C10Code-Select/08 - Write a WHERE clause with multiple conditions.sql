--Use this query to filter the results with multiple conditions
USE AdventureWorks2012;
SELECT
SalesOrderDetailID,
OrderQty,
ProductID,
ModifiedDate
FROM Sales.SalesOrderDetail s
WHERE
ModifiedDate BETWEEN '5/1/2007' AND '12/31/2007' AND
ProductID = 809