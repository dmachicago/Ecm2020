
IF EXISTS
(
    SELECT 1
    FROM sys.objects
    WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[udf_SHA512_128]')
          AND TYPE IN(N'FN', N'IF', N'TF', N'FS', N'FT')
)
    DROP FUNCTION dbo.udf_SHA512_128;
GO
CREATE FUNCTION udf_SHA512_128
(@strtext VARCHAR(1000)
)
RETURNS VARCHAR(128)
AS
     BEGIN
         DECLARE @hash VARCHAR(128)= '';
         SET @hash =
         (
             SELECT CONVERT(CHAR(128), HASHBYTES('sha2_512', @strtext), 2)
         );
         RETURN @hash;
     END;
GO