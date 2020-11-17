USE AdventureWorks2012;
GO
DECLARE @Age int;
EXECUTE @Age = dbo.GetEmployeeAge @BirthDate = '5/26/1972'
SELECT @Age;