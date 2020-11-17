USE AdventureWorks2012
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Patrick LeBlanc
-- Create date: 7/8/2012
-- Description: Scalar function that will be used to return employee age
-- =============================================
CREATE FUNCTION dbo.GetEmployeeAge
(
@BirthDate datetime
)
RETURNS int
AS
BEGIN
-- Declare the return variable here
DECLARE @Age int
-- Add the T-SQL statements to compute the return value here
SELECT @Age = DATEDIFF(DAY, @BirthDate, GETDATE())
-- Return the result of the function
RETURN @Age
END
GO

USE AdventureWorks2012;
SELECT TOP(10)
p.FirstName, p.LastName, e.BirthDate,
dbo.GetEmployeeAge(BirthDate) EmployeeAge
FROM HumanResources.Employee e
INNER JOIN Person.Person p
ON e.BusinessEntityID = p.BusinessEntityID
GO

USE AdventureWorks2012;
SELECT TOP(10)
p.FirstName, p.LastName, e.BirthDate,
dbo.GetEmployeeAge(BirthDate) EmployeeAge
FROM HumanResources.Employee e
INNER JOIN Person.Person p
ON e.BusinessEntityID = p.BusinessEntityID