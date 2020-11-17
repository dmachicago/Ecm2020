/*This method is used when table is not created*/
SELECT FirstName, LastName
INTO TestTable
FROM Person.Contact
WHERE EmailPromotion = 2


/*This method is used when table is already created*/
INSERT INTO TestTable (FirstName, LastName)
SELECT FirstName, LastName
FROM Person.Contact
WHERE EmailPromotion = 2
