--Simple common table expression
USE AdventureWorks2012;
WITH EmployeePOs (EmployeeID, [Total Due])
AS
(
SELECT
poh.EmployeeID,
CONVERT(varchar(20), SUM(poh.TotalDue),1)
FROM Purchasing.PurchaseOrderHeader poh
GROUP BY
poh.EmployeeID
)
SELECT *
FROM EmployeePOs;

--Common table expression using a JOIN
WITH EmployeePOs (EmployeeID, [Total Due])
AS
(
SELECT
poh.EmployeeID,
CONVERT(varchar(20), SUM(poh.TotalDue),1)
FROM Purchasing.PurchaseOrderHeader poh
GROUP BY
poh.EmployeeID
)
SELECT
ep.EmployeeID,
p.FirstName,
p.LastName,
ep.[Total Due]
FROM EmployeePOs ep
INNER JOIN Person.Person p
ON ep.EmployeeID = p.BusinessEntityID;