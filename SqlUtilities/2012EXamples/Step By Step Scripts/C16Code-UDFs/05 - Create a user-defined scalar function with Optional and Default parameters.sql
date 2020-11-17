USE [AdventureWorks2012]
GO
IF(OBJECT_ID('dbo.GetEmployeeAge')) IS NOT NULL
DROP FUNCTION dbo.GetEmployeeAge
GO
CREATE FUNCTION [dbo].[GetEmployeeAge]
(
@BirthDate datetime = '5/26/1972', --DEFAULT
@Temp datetime = NULL --OPTIONAL
)
RETURNS int
AS
BEGIN
-- Declare the return variable here
DECLARE @Age int
-- Add the T-SQL statements to compute the return value here
SELECT @Age = DATEDIFF(Year, @BirthDate, GETDATE())
-- Return the result of the function
RETURN @Age
END
GO

--Single Input Parameter
SELECT dbo.GetEmployeeAge('5/26/1972')
--First parameter is Default and second is Input
SELECT dbo.GetEmployeeAge('5/26/1972', '1/10/1972')

--Input and Optional Parameters
SELECT dbo.GetEmployeeAge('5/26/1972', NULL)
--Default and Input Parameters
SELECT dbo.GetEmployeeAge(DEFAULT, '1/10/1972')