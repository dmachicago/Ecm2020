

go
/*
declare @Result as TABLE(strValue nvarchar(250));
select * from dbo.udfGetTableColumns ('BASE_CMS_User')
*/
go

IF EXISTS (SELECT *
           FROM   sys.objects
           WHERE  object_id = OBJECT_ID('udfGetTableColumns')
                  AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION udfGetTableColumns

GO 

CREATE FUNCTION dbo.udfGetTableColumns ( @TblName nvarchar(250))
RETURNS  @Result TABLE(ColName nvarchar(250))
AS
begin
--  W. Dale Miler 
--  November 2007
    insert into @Result
    select column_name from information_schema.columns where table_name = @TblName
    
    return
end 