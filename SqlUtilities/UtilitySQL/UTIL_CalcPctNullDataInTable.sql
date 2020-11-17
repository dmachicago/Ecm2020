create proc UTIL_CalcPctNullDataInTable (@Schema as nvarchar(100), @TBL as nvarchar(100))
as
--WDM 3/15/2012 :  Calculates the percentage of NULL data in each column within a table or view
--USE exec UTIL_CalcPctNullDataInTable 'dbo', 'view_EDW_HealthAssesment'
SET NOCOUNT ON
DECLARE @Statement NVARCHAR(MAX) = ''
DECLARE @Statement2 NVARCHAR(MAX) = ''
DECLARE @FinalStatement NVARCHAR(MAX) = ''
DECLARE @TABLE_SCHEMA SYSNAME = @Schema
DECLARE @TABLE_NAME SYSNAME = @TBL
SELECT
        @Statement = @Statement + 'SUM(CASE WHEN ' + COLUMN_NAME + ' IS NULL THEN 1 ELSE 0 END) AS ' + COLUMN_NAME + ',' + CHAR(13) ,
        @Statement2 = @Statement2 + COLUMN_NAME + '*100 / OverallCount AS ' + COLUMN_NAME + ',' + CHAR(13) FROM
INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @TABLE_NAME AND TABLE_SCHEMA = @TABLE_SCHEMA
IF @@ROWCOUNT = 0
        RAISERROR('TABLE OR VIEW with schema "%s" and name "%s" does not exist or you do not have appropriate permissions.',16,1, @TABLE_SCHEMA, @TABLE_NAME)
ELSE
BEGIN
        SELECT @FinalStatement =
                'SELECT ' + LEFT(@Statement2, LEN(@Statement2) -2) + ' FROM (SELECT ' + LEFT(@Statement, LEN(@Statement) -2) +
                ', COUNT(*) AS OverallCount FROM ' + @TABLE_SCHEMA + '.' + @TABLE_NAME + ') SubQuery'
        EXEC(@FinalStatement)
END

GO

GRANT EXECUTE ON OBJECT::dbo.UTIL_CalcPctNullDataInTable TO public;