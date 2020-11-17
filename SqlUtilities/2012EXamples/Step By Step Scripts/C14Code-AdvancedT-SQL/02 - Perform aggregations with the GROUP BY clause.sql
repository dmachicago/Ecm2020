-- This query will return an error due to missing GROUP BY
USE AdventureWorks2012;
SELECT
sm.Name AS ShippingMethod
SUM(poh.TotalDue) AS [Total Due],
AVG(poh.TotalDue) AS [Average Total Due],
COUNT(poh.EmployeeID) [Number Of Employees],
COUNT(DISTINCT poh.EmployeeID) [Distinct Number Of Employees]
FROM Purchasing.PurchaseOrderHeader poh
INNER JOIN Purchasing.ShipMethod sm
ON poh.ShipMethodID = sm.ShipMethodID

--This query will return aggregated data using  GROUP BY
USE AdventureWorks2012;
SELECT
sm.Name AS ShippingMethod,
SUM(poh.TotalDue) AS [Total Due],
AVG(poh.TotalDue) AS [Average Total Due],
COUNT(poh.EmployeeID) AS [Number Of Employees],
COUNT(DISTINCT poh.EmployeeID) AS [Distinct Number Of Employees]
FROM Purchasing.PurchaseOrderHeader poh
INNER JOIN Purchasing.ShipMethod sm
ON poh.ShipMethodID = sm.ShipMethodID
GROUP BY sm.Name

--This query returns data based on a GROUP BY with derived columns
USE AdventureWorks2012;
SELECT
sm.Name AS ShippingMethod,
YEAR(poh.OrderDate) AS OrderYear,
SUM(poh.TotalDue) AS [Total Due],
AVG(poh.TotalDue) AS [Average Total Due],
COUNT(poh.EmployeeID) AS [Number Of Employees],
COUNT(DISTINCT poh.EmployeeID) AS [Distinct Number Of Employees]
FROM Purchasing.PurchaseOrderHeader poh
INNER JOIN Purchasing.ShipMethod sm
ON poh.ShipMethodID = sm.ShipMethodID
GROUP BY
sm.Name,
YEAR(poh.OrderDate)s
