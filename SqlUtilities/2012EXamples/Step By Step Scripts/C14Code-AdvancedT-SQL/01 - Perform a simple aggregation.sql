USE AdventureWorks2012;
SELECT
SUM(poh.TotalDue) AS TotalDue
FROM Purchasing.PurchaseOrderHeader poh;

USE AdventureWorks2012;
SELECT
SUM(poh.TotalDue) AS [Total Due],
AVG(poh.TotalDue) AS [Average Total Due],
COUNT(poh.EmployeeID) [Number Of Employees],
COUNT(DISTINCT poh.EmployeeID) [Distinct Number Of Employees]
FROM Purchasing.PurchaseOrderHeader poh;