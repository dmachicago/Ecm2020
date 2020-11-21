

IF EXISTS
(
  SELECT 1
  FROM sys.procedures
  WHERE name='GenerateProgrammingDeclareStatements'
)
    DROP PROCEDURE GenerateProgrammingDeclareStatements;
GO
-- exec GenerateProgrammingDeclareStatements 'C#', 'DataSource';
-- exec GenerateProgrammingDeclareStatements 'VB', 'DataSource';

CREATE PROCEDURE GenerateProgrammingDeclareStatements
(
  @LANG NVARCHAR(10), 
  @TBL  NVARCHAR(80))
AS
BEGIN
--DECLARE @LANG AS nvarchar(10)= 'C#';
--DECLARE @TBL AS nvarchar(80)= 'DataSource';
IF @LANG='VB'
BEGIN
SELECT ' DIM '+column_name+' as '+CASE data_type
                                    WHEN 'float'
                                    THEN 'float = 0 '
                                    WHEN 'int'
                                    THEN 'integer = 0 '
                                    WHEN 'nvarchar'
                                    THEN 'string = ""'
                                    WHEN 'varchar'
                                    THEN 'string = ""'
                                    WHEN 'bit'
                                    THEN 'boolean = true'
                                    WHEN 'char'
                                    THEN 'char('+CAST( CHARACTER_MAXIMUM_LENGTH AS NVARCHAR(50) )+') = ""'
                                    WHEN 'nchar'
                                    THEN 'char('+CAST( CHARACTER_MAXIMUM_LENGTH AS NVARCHAR(50) )+') = ""'
                                    WHEN 'date'
                                    THEN 'datetime = now'
                                    WHEN 'datetime'
                                    THEN 'datetime = now'
                                    WHEN 'varbinary'
                                    THEN 'binary() = nothing'
                                    WHEN 'uniqueidentifier'
                                    THEN 'string = ""'
                                    ELSE data_type
                                  END
AS STMT, 
       CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME=@TBL
ORDER BY COLUMN_NAME;
END;
IF @LANG='C#'
BEGIN
SELECT CASE data_type
         WHEN 'float'
         THEN 'float'
         WHEN 'int'
         THEN 'integer'
         WHEN 'nvarchar'
         THEN 'string'
         WHEN 'varchar'
         THEN 'string'
         WHEN 'bit'
         THEN 'boolean'
         WHEN 'char'
         THEN 'char('+CAST( CHARACTER_MAXIMUM_LENGTH AS NVARCHAR(50) )+')'
         WHEN 'nchar('+CAST( CHARACTER_MAXIMUM_LENGTH AS NVARCHAR(50) )+')'
         THEN 'boolean'
         WHEN 'date'
         THEN 'datetime'
         WHEN 'datetime'
         THEN 'datetime'
         WHEN 'varbinary'
         THEN 'binary('+CASE
                          WHEN CHARACTER_MAXIMUM_LENGTH<1
                               OR CHARACTER_MAXIMUM_LENGTH IS NULL
                          THEN ')'
                          ELSE CAST( CHARACTER_MAXIMUM_LENGTH AS NVARCHAR(50) )+')'
                        END
         WHEN 'uniqueidentifier'
         THEN 'guid'
         ELSE data_type
       END+' '+column_name+CASE data_type
                             WHEN 'float'
                             THEN ' = 0;'
                             WHEN 'int'
                             THEN ' = 0;'
                             WHEN 'nvarchar'
                             THEN ' = "";'
                             WHEN 'varchar'
                             THEN ' = "";'
                             WHEN 'bit'
                             THEN ' = true;'
                             WHEN 'char'
                             THEN ' = null;'
                             WHEN 'nchar'
                             THEN ' = null;'
                             WHEN 'date'
                             THEN ' = null;'
                             WHEN 'datetime'
                             THEN ' = null;'
                             WHEN 'varbinary'
                             THEN ' = null;'
                             WHEN 'uniqueidentifier'
                             THEN '= newguid();'
                             ELSE data_type
                           END
AS STMT, 
       CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME=@TBL
ORDER BY COLUMN_NAME;
END;
END;