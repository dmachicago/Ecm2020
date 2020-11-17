--Use this query to return a list of products that are black and silver
USE AdventureWorks2012;
SELECT
Name AS ProductName
FROM Production.Product
WHERE
Color = 'Black'
UNION
SELECT
Name AS ProductName
FROM Production.Product
WHERE
Color = 'Silver'