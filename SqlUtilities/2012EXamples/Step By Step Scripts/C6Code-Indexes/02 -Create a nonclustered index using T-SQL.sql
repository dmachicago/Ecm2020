--Use this script to create a nonclustered index
USE AdventureWorks2012;
CREATE NONCLUSTERED INDEX IX_SalesOrderHeader_DueDate
ON Sales.SalesOrderHeader
(
DueDate
);