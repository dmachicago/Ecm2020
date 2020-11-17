USE [AdventureWorks2012]
GO
/****** Object: UserDefinedFunction [dbo].[GetEmployeeAge] Script Date: 7/8/2012 1:03:20
PM
******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Patrick LeBlanc
-- Create date: 6/8/2012
-- Description: Scalar function that will be used to return employee age
-- =============================================
ALTER FUNCTION [dbo].[GetEmployeeAge]
(
@BirthDate datetime
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