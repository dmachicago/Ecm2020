
GO
PRINT 'Creating proc_Add_EDW_CT_StdCols.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_Add_EDW_CT_StdCols') 
    BEGIN
        DROP PROCEDURE
             proc_Add_EDW_CT_StdCols;
    END;
GO

-- EXEC proc_Add_EDW_CT_StdCols 'FACT_MART_EDW_HealthAssesment';
CREATE PROCEDURE proc_Add_EDW_CT_StdCols (
       @tname AS nvarchar (100)) 
AS
BEGIN
    DECLARE @MySql AS nvarchar (2000) = NULL;
    declare @DBN as nvarchar(100) = DB_NAME() ;
    IF @tname LIKE '#%'
        BEGIN
            IF NOT EXISTS ( SELECT
                                   column_name
                                   FROM TempDB.INFORMATION_SCHEMA.COLUMNS
                                   WHERE
                                   table_name = @tname AND
                                   column_name = 'LastModifiedDate') 
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @tname + ' ADD LastModifiedDate datetime NULL; ';
                    EXEC (@MySql) ;
                END;

            IF NOT EXISTS ( SELECT
                                   column_name
                                   FROM TempDB.INFORMATION_SCHEMA.COLUMNS
                                   WHERE
                                   table_name = @tname AND
                                   column_name = 'RowNbr') 
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @tname + ' ADD RowNbr int NULL; ';
                    EXEC (@MySql) ;
                END;

            IF NOT EXISTS ( SELECT
                                   column_name
                                   FROM TempDB.INFORMATION_SCHEMA.COLUMNS
                                   WHERE
                                   table_name = @tname AND
                                   column_name = 'DeletedFlg') 
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @tname + ' add DeletedFlg bit NULL; ';
                    EXEC (@MySql) ;
                END;

            IF NOT EXISTS ( SELECT
                                   column_name
                                   FROM TempDB.INFORMATION_SCHEMA.COLUMNS
                                   WHERE
                                   table_name = @tname AND
                                   column_name = 'TimeZone') 
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @tname + ' add TimeZone nvarchar (10) NULL; ';
                    EXEC (@MySql) ;
                END;
            IF NOT EXISTS ( SELECT
                                   column_name
                                   FROM TempDB.INFORMATION_SCHEMA.COLUMNS
                                   WHERE
                                   table_name = @tname AND
                                   column_name = 'ConvertedToCentralTime') 
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @tname + ' add ConvertedToCentralTime bit NULL; ';
                    EXEC (@MySql) ;
                END;
			 IF NOT EXISTS ( SELECT
                                   column_name
                                   FROM TempDB.INFORMATION_SCHEMA.COLUMNS
                                   WHERE
                                   table_name = @tname AND
                                   column_name = 'SVR') 
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @tname + ' add SVR nvarchar(100) not NULL default(@@SERVERNAME); ';
                    EXEC (@MySql) ;
                END;
			 IF NOT EXISTS ( SELECT
                                   column_name
                                   FROM TempDB.INFORMATION_SCHEMA.COLUMNS
                                   WHERE
                                   table_name = @tname AND
                                   column_name = 'DBNAME') 
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @tname + ' add DBNAME nvarchar(100) not NULL default('''+@DBN+'''); ';
                    EXEC (@MySql) ;
                END;
			 IF NOT EXISTS ( SELECT
                                   column_name
                                   FROM TempDB.INFORMATION_SCHEMA.COLUMNS
                                   WHERE
                                   table_name = @tname AND
                                   column_name = 'HashCode') 
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @tname + ' add HashCode nvarchar(75) NULL; ';
                    EXEC (@MySql) ;
                END;
        END ;
    ELSE
        BEGIN

            IF NOT EXISTS ( SELECT
                                   column_name
                                   FROM information_schema.columns
                                   WHERE
                                   table_name = @tname AND
                                   column_name = 'LastModifiedDate') 
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @tname + ' ADD LastModifiedDate datetime NULL; ';
                    EXEC (@MySql) ;
                END;

            IF NOT EXISTS ( SELECT
                                   column_name
                                   FROM information_schema.columns
                                   WHERE
                                   table_name = @tname AND
                                   column_name = 'RowNbr') 
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @tname + ' ADD RowNbr int NULL; ';
                    EXEC (@MySql) ;
                END;

            IF NOT EXISTS ( SELECT
                                   column_name
                                   FROM information_schema.columns
                                   WHERE
                                   table_name = @tname AND
                                   column_name = 'DeletedFlg') 
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @tname + ' add DeletedFlg bit NULL; ';
                    EXEC (@MySql) ;
                END;

            IF NOT EXISTS ( SELECT
                                   column_name
                                   FROM information_schema.columns
                                   WHERE
                                   table_name = @tname AND
                                   column_name = 'TimeZone') 
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @tname + ' add TimeZone nvarchar (10) NULL; ';
                    EXEC (@MySql) ;
                END;
            IF NOT EXISTS ( SELECT
                                   column_name
                                   FROM information_schema.columns
                                   WHERE
                                   table_name = @tname AND
                                   column_name = 'ConvertedToCentralTime') 
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @tname + ' add ConvertedToCentralTime bit NULL; ';
                    EXEC (@MySql) ;
                END;

		  IF NOT EXISTS ( SELECT
                                   column_name
                                   FROM INFORMATION_SCHEMA.COLUMNS
                                   WHERE
                                   table_name = @tname AND
                                   column_name = 'SVR') 
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @tname + ' add SVR nvarchar(100) not NULL default(@@SERVERNAME); ';
                    EXEC (@MySql) ;
                END;
			 IF NOT EXISTS ( SELECT
                                   column_name
                                   FROM INFORMATION_SCHEMA.COLUMNS
                                   WHERE
                                   table_name = @tname AND
                                   column_name = 'DBNAME') 
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @tname + ' add DBNAME nvarchar(100) not NULL default('''+@DBN+'''); ';
                    EXEC (@MySql) ;
                END;

		  IF NOT EXISTS ( SELECT
                                   column_name
                                   FROM INFORMATION_SCHEMA.COLUMNS
                                   WHERE
                                   table_name = @tname AND
                                   column_name = 'HashCode') 
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @tname + ' add HashCode nvarchar(75) NULL ; ';
                    EXEC (@MySql) ;
                END;


        END;
--*************************************************************************

END;

GO
PRINT 'Created proc_Add_EDW_CT_StdCols.sql';
GO
