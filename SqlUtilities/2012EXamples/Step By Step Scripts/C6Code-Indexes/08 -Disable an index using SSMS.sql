--Use this script to disable an index
USE AdventureWorks2012;
ALTER INDEX IX_SalesOrderHeader_OrderDate
ON Sales.SalesOrderHeader DISABLE;