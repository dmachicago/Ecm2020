USE AdventureWorks2012
GO
;WITH ProductQty
AS
(
	SELECT TOP(10)
		p.ProductID,
		SUM(OrderQty) AS OrderQty
	FROM Sales.SalesOrderDetail AS sod
	INNER JOIN Production.Product AS p
		ON sod.ProductID = p.ProductID
	GROUP BY p.ProductID
)
SELECT 
	p.NAME AS ProductName,
	pq.OrderQty,
	ROW_NUMBER() OVER(ORDER BY pq.OrderQty DESC) ROWNUMBER,
	RANK() OVER(ORDER BY pq.OrderQty DESC) [RANK],
	DENSE_RANK() OVER(ORDER BY pq.OrderQty DESC) [DENSERANK]
FROM ProductQty AS pq
INNER JOIN Production.Product AS p
	ON pq.ProductID = p.ProductID
