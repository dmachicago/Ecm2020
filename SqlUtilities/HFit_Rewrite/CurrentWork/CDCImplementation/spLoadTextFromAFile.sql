IF OBJECT_ID (N'dbo.spLoadTextFromAFile') IS NOT NULL
   DROP PROCEDURE dbo.spLoadTextFromAFile
GO
CREATE PROCEDURE spLoadTextFromAFile
   @Filename VARCHAR(255),
   @Unicode INT = 0
--spLoadTextFromAFile 'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\LOG\ERRORLOG.6', @Unicode=1
AS 
   SET NOCOUNT ON
   DECLARE @MySpecialTempTable VARCHAR(255)
   DECLARE @Command NVARCHAR(4000)
   DECLARE @RESULT INT

--firstly we create a global temp table with a unique name
   SELECT   @MySpecialTempTable = '##temp' 
       + CONVERT(VARCHAR(12), CONVERT(INT, RAND() * 1000000))
--then we create it using dynamic SQL, 
--
   SELECT   @Command = 'create table [' 
       + @MySpecialTempTable + '] (MyLine '
       + CASE WHEN @unicode <>0 THEN 'N' ELSE '' END +'varchar(MAX))
 '
   EXECUTE sp_ExecuteSQL @command

   SELECT   @command = 'bulk insert [' 
       + @MySpecialTempTable + '] from' + ' ''' 
       + REPLACE(@Filename, '"', '') + '''' 
       + ' with (FIELDTERMINATOR=''|~||''' + ',ROWTERMINATOR = ''
'''        + CASE WHEN @unicode <>0 THEN ', DATAFILETYPE=''widechar'''ELSE '' END
       + ')'
-- import the data
   EXEC (@Command)
   EXECUTE ('Select * from ' + @MySpecialTempTable)
   EXECUTE ('Drop table ' + @MySpecialTempTable)
GO