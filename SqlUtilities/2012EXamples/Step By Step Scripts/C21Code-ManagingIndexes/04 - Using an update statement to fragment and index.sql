USE AdventureWorks2012;
UPDATE Sales.SalesOrderHeader
SET OrderDate = DATEADD(day, -1, orderdate)
where orderdate <= '8/31/2006'