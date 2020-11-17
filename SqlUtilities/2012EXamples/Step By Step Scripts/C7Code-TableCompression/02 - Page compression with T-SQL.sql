--Use this code to page compress the Sales.SalesOrderDetail table
USE AdventureWorks2012
ALTER TABLE Sales.SalesOrderDetail
REBUILD WITH(DATA_COMPRESSION = PAGE);

--Use this code to page compress a nonclustered index on the Sales.SalesOrderDetail table
ALTER INDEX IX_SalesOrderDetail_ProductID
	ON Sales.SalesOrderDetail
REBUILD WITH(DATA_COMPRESSION = PAGE);