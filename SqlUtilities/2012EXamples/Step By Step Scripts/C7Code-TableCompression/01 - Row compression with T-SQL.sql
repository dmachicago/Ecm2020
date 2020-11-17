--Use this code to row compress the Sales.SalesOrderHeader table
USE AdventureWorks2012
ALTER TABLE [Sales].[SalesOrderHeader]
	REBUILD WITH(DATA_COMPRESSION = ROW);

--Use this code to row compress a nonclustered index on the Sales.SalesOrderHeader table
ALTER INDEX IX_SalesOrderHeader_SalesPersonID
	ON Sales.SalesOrderHeader
REBUILD WITH(DATA_COMPRESSION = ROW);

--Use this code to row compress a table during creation
USE AdventureWorks2012;
CREATE TABLE dbo.Ch7RowCompression
(
	ID int PRIMARY KEY,
	FirstName varchar(50),
	LastName varchar(50),
	BirthDate datetime
)
WITH (DATA_COMPRESSION = ROW);