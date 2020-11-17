USE tempdb;
GO
IF EXISTS
(
    SELECT 1
    FROM   sys.procedures
    WHERE  name = 'sp_UTIL_RebuildAllDbIndexUsingDBCC'
)
    DROP PROCEDURE sp_UTIL_RebuildAllDbIndexUsingDBCC;
	GO
CREATE PROCEDURE sp_UTIL_RebuildAllDbIndexUsingDBCC
AS
    BEGIN
        DECLARE @tblname VARCHAR(250);
        DECLARE tbl CURSOR
        FOR SELECT table_name
            FROM   information_schema.tables
            WHERE  table_type = 'base table';
        OPEN tbl;
        DECLARE @msg VARCHAR(1000);
        FETCH NEXT FROM tbl INTO @tblname;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @msg = 'Processing: ' + @tblname;
                EXEC DFINAnalytics.dbo.PrintImmediate 
                     @msg;
                DBCC DBREINDEX(@tblname, ' ', 80);
                FETCH NEXT FROM tbl INTO @tblname;
            END;
        CLOSE tbl;
        DEALLOCATE tbl;
    END;