USE AdventureWorks2012;
SELECT
sm.Name AS ShippingMethod,
YEAR(poh.OrderDate) OrderYear,
SUM(poh.TotalDue) AS [Total Due],
AVG(poh.TotalDue) AS [Average Total Due],
COUNT(poh.EmployeeID) AS [Number Of Employees],
COUNT(DISTINCT poh.EmployeeID) AS [Distinct Number Of Employees]
FROM Purchasing.PurchaseOrderHeader poh
INNER JOIN Purchasing.ShipMethod sm
ON poh.ShipMethodID = sm.ShipMethodID
GROUP BY sm.Name,YEAR(poh.OrderDate)
HAVING SUM(poh.TotalDue) > 5000000