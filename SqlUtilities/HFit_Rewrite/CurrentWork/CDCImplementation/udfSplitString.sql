
-- use KenticoCMS_DataMart_2
go
/*
declare @Result as TABLE(strValue nvarchar(4000));
select * from dbo.udfSplitString ('a,b,c,d')
*/
go

IF EXISTS (SELECT *
           FROM   sys.objects
           WHERE  object_id = OBJECT_ID('udfSplitString')
                  AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION udfSplitString

GO 

CREATE FUNCTION dbo.udfSplitString ( @strString varchar(4000))
RETURNS  @Result TABLE(strValue nvarchar(4000))
AS
begin
--  W. Dale Miler 
--  November 2007

 DECLARE @IntLocation INT
        WHILE (CHARINDEX(',',    @strString, 0) > 0)
        BEGIN
              SET @IntLocation =   CHARINDEX(',',    @strString, 0)      
              INSERT INTO   @Result (strValue)
              --LTRIM and RTRIM to ensure blank spaces are   removed
              SELECT RTRIM(LTRIM(SUBSTRING(@strString,   0, @IntLocation)))   
              SET @strString = STUFF(@strString,   1, @IntLocation,   '') 
        END
        INSERT INTO   @Result (strValue)
        SELECT RTRIM(LTRIM(@strString))--LTRIM and RTRIM to ensure blank spaces are removed
        RETURN 
end 