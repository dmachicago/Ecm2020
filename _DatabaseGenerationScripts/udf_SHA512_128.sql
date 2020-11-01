
IF EXISTS ( SELECT 1 FROM sys.objects WHERE   OBJECT_ID = OBJECT_ID(N'[SCHEMA].[FUNCTION_NAME_HERE]')
                    AND TYPE IN (N'FN', N'IF', N'TF', N'FS', N'FT') )
    DROP FUNCTION dbo.sp_SHA512_128 ;

GO

CREATE FUNCTION sp_SHA512_128 (@strtext varchar(1000))
RETURNS varchar(128) AS
BEGIN
	declare @hash varchar(128) = '';
    set @hash = (SELECT convert(char(125), HASHBYTES('sha2_512', @strtext), 2 ));
    RETURN @hash
END
go