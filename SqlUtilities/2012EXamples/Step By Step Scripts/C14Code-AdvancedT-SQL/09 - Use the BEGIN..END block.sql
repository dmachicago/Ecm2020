USE AdventureWorks2012;
BEGIN
DECLARE @StartingHireDate datetime = '12/31/2001'
SELECT e.BusinessEntityID, p.FirstName, p.LastName, e.HireDate
FROM HumanResources.Employee e
INNER JOIN Person.Person p
ON e.BusinessEntityID = p.BusinessEntityID
WHERE HireDate <= @StartingHireDate
END