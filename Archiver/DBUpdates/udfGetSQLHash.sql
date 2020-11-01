
IF EXISTS (SELECT 1
           FROM   sys.objects
           WHERE  object_id = OBJECT_ID(N'[dbo].[getSQLHash]')
                  AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[getSQLHash]
go

create FUNCTION [dbo].[getSQLHash]
(@FullName VARCHAR(500)
)
RETURNS VARCHAR(500)
AS
BEGIN
	DECLARE @result NVARCHAR(150)= '';
	set @result = (select convert(char(128), HASHBYTES('sha2_512', @FullName), 1));
	RETURN @result;
END;
