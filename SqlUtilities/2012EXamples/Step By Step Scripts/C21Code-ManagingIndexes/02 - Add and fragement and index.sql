USE AdventureWorks2012;
GO
--Create index if it does not exist
CREATE NONCLUSTERED INDEX IX_SalesOrderHeader_OrderDate
ON Sales.SalesOrderHeader
(
OrderDate
)
INCLUDE(Status, AccountNumber)
WHERE(OnlineOrderFlag = 0)
ON AW2012FileGroup2;
GO
UPDATE Sales.SalesOrderHeader
SET OrderDate = DATEADD(day, 1, orderdate)
where orderdate <= '8/31/2006'