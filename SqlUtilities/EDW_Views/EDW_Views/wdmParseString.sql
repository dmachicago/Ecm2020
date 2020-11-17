alter FUNCTION [dbo].[wdmParseString] (@string NVARCHAR(MAX),@separator NCHAR(1))
RETURNS @parsedString TABLE (string NVARCHAR(MAX))
AS 
BEGIN
	--*************************************************************************************************************
	--W. Dale Miller - 2/20/2003
	--Call this function to parse the passed in string ; elements delimited with the | as passed in or whatever 
	--other delimiting character is used.
	--USE: SELECT * FROM dbo.wdmParseString('SQL Server 2000|SQL Server 2005|SQL Server 2008|SQL Server 7.0','|')
	--     SELECT * FROM dbo.wdmParseString('SQL Server 2000,SQL Server 2005,SQL Server 2008,SQL Server 7.0',',')
	--*************************************************************************************************************
   DECLARE @position int
   SET @position = 1
   SET @string = @string + @separator
   WHILE charindex(@separator,@string,@position) <> 0
      BEGIN
         INSERT into @parsedString
         SELECT substring(@string, @position, charindex(@separator,@string,@position) - @position)
         SET @position = charindex(@separator,@string,@position) + 1
      END
     RETURN
END  --  
  --  
GO 
print('***** FROM: wdmParseString.sql'); 
GO 
