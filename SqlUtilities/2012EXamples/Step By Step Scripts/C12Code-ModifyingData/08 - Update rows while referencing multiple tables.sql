UPDATE Production.Product
SET ListPrice = p.ListPrice * 1.05
FROM Production.Product p
INNER JOIN Production.ProductSubcategory ps
ON p.ProductSubcategoryID = ps.ProductSubcategoryID
WHERE
ps.Name = 'Socks'