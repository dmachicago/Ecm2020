
GO
-- use KenticoCMS_DataMart_2
PRINT 'Executing proc_PULL_ALL_Tracker_StoredProceduresFromDB.sql';
GO
IF EXISTS (SELECT
              name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_PULL_ALL_Tracker_StoredProceduresFromDB') 
    BEGIN
        DROP PROCEDURE
           proc_PULL_ALL_Tracker_StoredProceduresFromDB
    END;
GO

-- bcp AdventureWorks2008R2.Sales.Currency out Currency.dat -c -U<login_id> -S<server_name\instance_name>
-- exec proc_PULL_ALL_Tracker_StoredProceduresFromDB
CREATE PROCEDURE proc_PULL_ALL_Tracker_StoredProceduresFromDB
AS
BEGIN

    DECLARE
           @source_code VARCHAR (MAX) 
         , @TSQL VARCHAR (MAX) = ' '
         , @msg VARCHAR (MAX) 
         , @ProcName VARCHAR (500) 
         , @ddl VARCHAR (MAX) 
         , @Header VARCHAR (MAX) ;
    -- drop table #t
    CREATE TABLE #T (
       line VARCHAR (MAX)) ;
    DECLARE
           @procs TABLE (
       StoredProcedure VARCHAR (MAX)) ;

    DECLARE C CURSOR
        FOR
            SELECT
               name
                   FROM sys.procedures
                   WHERE
                   name LIKE 'proc_CT%' AND
                   name LIKE '%Tracker%';

    OPEN C;

    FETCH NEXT FROM C INTO @ProcName;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET @msg = 'Processing: ' + @ProcName;
            EXEC PrintImmediate @msg;
            SET @Header = '--********************************************************' + char (10) ;
            SET @Header = @Header + '-- Procedure: ' + @ProcName + char (10) ;
            SET @Header = @Header + '-- Author   : W.Dale Miller' + char (10) ;
            SET @Header = @Header + '-- Pull Date: ' + cast (getdate () AS NVARCHAR (50)) + char (10) ;
            SET @Header = @Header + '--********************************************************' + char (10) ;
		  SET @Header = @Header + 'go ' + char(10) ;
		  SET @Header = @Header + 'if exists (select name from sys.procedures where name = '''+@ProcName+''') ' + char(10) ;
		  SET @Header = @Header + '    drop procedure '+@ProcName+' ; ' + char(10) ;
		  SET @Header = @Header + 'go' + char(10)
            SET @Header = @Header + '--********************************************************' + char (10) ;
            SELECT
               @source_code = definition
                   FROM sys.sql_modules
                   WHERE
                   object_id = object_id (@ProcName) ;

            PRINT '001 ';
            SET @msg = 'truncate table #T ';
            EXEC (@msg) ;
            PRINT '002 ';

            INSERT INTO #T
            EXEC sp_helptext @ProcName;

            SET @ddl = '';
            SELECT
               @ddl = @ddl + line
                   FROM #T;

            SET @msg = @Header + @ddl + char (10) + 'GO' + char (10) ;
            INSERT INTO @procs (
               StoredProcedure) 
            VALUES ( @msg) ;

            --SET @TSQL = @TSQL + @Header + @ddl + char (10) + char (10) ;
            --EXEC PrintImmediate @Header;
            --EXEC PrintImmediate @source_code;
            --exec PrintImmediate @TSQL ;
            FETCH NEXT FROM C INTO @ProcName;
        END;
    CLOSE C;
    DEALLOCATE C;
    -- SELECT @TSql;
    -- SELECT * FROM #T;
    SELECT
       *
           FROM @procs;
END;
GO
PRINT 'Executed proc_PULL_ALL_Tracker_StoredProceduresFromDB.sql';
GO
