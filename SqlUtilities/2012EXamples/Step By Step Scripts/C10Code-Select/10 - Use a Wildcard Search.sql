--Use this query to filter the results using LIKE
USE AdventureWorks2012;
SELECT
*
FROM HumanResources.Department
WHERE
Name LIKE 'Pr%'