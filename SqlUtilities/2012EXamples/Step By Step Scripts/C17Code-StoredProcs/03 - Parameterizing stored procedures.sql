USE AdventureWorks2012;
GO
--Create Proc with OUTPUT param
CREATE PROC dbo.SampleOutput
@Parameter2 int OUTPUT
as
SELECT @Parameter2 = 10
--Execute Proc with OUTPUT param
DECLARE @HoldParameter2 INT
EXEC dbo.SampleOutput
@HoldParameter2 OUTPUT
SELECT @HoldParameter2