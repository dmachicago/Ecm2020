USE AdventureWorks2012;
SELECT
p.FirstName,
p.LastName,
ea.EmailAddress
FROM Person.Person AS p
INNER JOIN Person.EmailAddress AS ea
ON p.BusinessEntityID = ea.BusinessEntityID