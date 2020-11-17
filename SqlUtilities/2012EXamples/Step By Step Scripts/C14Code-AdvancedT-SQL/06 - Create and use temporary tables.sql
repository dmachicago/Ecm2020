USE AdventureWorks2012;
CREATE TABLE #EmployeePOs
(
EmployeeID int,
TotalDue money
)
INSERT INTO #EmployeePOs
SELECT
poh.EmployeeID,
CONVERT(varchar(20), SUM(poh.TotalDue),1)
FROM Purchasing.PurchaseOrderHeader poh
GROUP BY
poh.EmployeeID;

USE AdventureWorks2012;
CREATE TABLE #EmployeePOs
(
EmployeeID int,
TotalDue money
)
INSERT INTO #EmployeePOs
SELECT
poh.EmployeeID,
CONVERT(varchar(20), SUM(poh.TotalDue),1)
FROM Purchasing.PurchaseOrderHeader poh
GROUP BY
poh.EmployeeID
SELECT
ep.EmployeeID,
p.FirstName,
p.LastName,
ep.[TotalDue]
FROM #EmployeePOs ep
INNER JOIN Person.Person p
ON ep.EmployeeID = p.BusinessEntityID