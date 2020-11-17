

GO
PRINT 'EXECUTING proc_GenTrackerCTProcMASTER.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_GenTrackerCTProcMASTER') 
    BEGIN
        DROP PROCEDURE
             proc_GenTrackerCTProcMASTER;
    END;
GO

-- Use KenticoCMS_Datamart_X
-- EXEC proc_GenTrackerCTProcMASTER 'YES'
-- EXEC proc_GenTrackerCTProcMASTER 'NO'

CREATE PROCEDURE proc_GenTrackerCTProcMASTER (
       @PreviewOnly AS NVARCHAR (50) = 'NO') 
AS
BEGIN

    DECLARE
           @cmd AS NVARCHAR (MAX) = '';

    IF OBJECT_ID ( 'usp_GetErrorInfo' , 'P') IS NULL
        BEGIN
            SET @cmd = 'CREATE PROCEDURE usp_GetErrorInfo ' + CHAR (10) ;
            SET @cmd = @cmd + 'AS ' + CHAR (10) ;
            SET @cmd = @cmd + ' SELECT ERROR_NUMBER() AS ErrorNumber ' + CHAR (10) ;
            SET @cmd = @cmd + '    ,ERROR_SEVERITY() AS ErrorSeverity ' + CHAR (10) ;
            SET @cmd = @cmd + '    ,ERROR_STATE() AS ErrorState ' + CHAR (10) ;
            SET @cmd = @cmd + '    ,ERROR_PROCEDURE() AS ErrorProcedure ' + CHAR (10) ;
            SET @cmd = @cmd + '    ,ERROR_LINE() AS ErrorLine ' + CHAR (10) ;
            SET @cmd = @cmd + '    ,ERROR_MESSAGE() AS ErrorMessage; ' + CHAR (10) ;
            EXEC (@cmd) ;
        END;
    SET @cmd = '';
    --Build the execution commands
    DECLARE cmdCursor CURSOR
        FOR
		  -- declare @table_name as nvarchar(250) = 'BASE_CMS_User' ;
            SELECT
                   'EXEC proc_GenTrackerCTProc ''' + table_name + ''';'
            FROM information_schema.tables
            WHERE
            table_name LIKE 'BASE_HFIT_Tracker%' AND
            table_name NOT LIKE '%_DEL' AND
            table_name NOT LIKE '%_CTVerHIST' AND
            table_name NOT LIKE '%_TrackerDef%' AND
            table_name NOT LIKE 'BASE_HFIT_Tracker' AND
            table_name NOT LIKE 'BASE_HFit_TrackerDef_Tracker' and 
		  table_name in (SELECT table_name FROM information_schema.tables WHERE TABLE_TYPE = 'BASE TABLE') 
		  --OR table_name in (Select 'BASE_' + table_name from MART_VIEWS_TO_CONVERT
		  --	 where 'BASE_'+table_name in (SELECT table_name FROM information_schema.tables WHERE TABLE_TYPE = 'BASE TABLE')) ;

    OPEN cmdCursor;
    FETCH NEXT FROM cmdCursor
    INTO @cmd;

    --Build each table using the previously constructed execution commands.
    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET @cmd = REPLACE (@cmd , 'EXEC ' , '') ;
            BEGIN TRY
                IF
                       @PreviewOnly = 'NO'
                    BEGIN
                        EXEC (@cmd) 
                    END;
                PRINT 'SUCCESS: ' + @cmd;
                PRINT ' ';
            END TRY
            BEGIN CATCH
                PRINT 'ERROR: ' + @cmd;
                EXECUTE usp_GetErrorInfo;
                PRINT ' ';
            END CATCH;
            FETCH NEXT FROM cmdCursor INTO @cmd;
        END;
    CLOSE cmdCursor;
    DEALLOCATE cmdCursor;

    EXEC dbo.proc_TrackerAddTrackerName ;		  --Verified WDM 1.21.2016

    EXEC dbo.proc_TrackerAlterPKEY ;			  --Verified WDM 1.21.2016

    EXEC proc_RI_Tracker_User ;				  --Verified WDM 1.21.2016

    EXEC proc_SetTrackerKeyColToStandardLength ;	  --Verified WDM 1.21.2016

    EXEC proc_AddSurrogateKey_AllTrackerTables ;	  --Verified WDM 1.21.2016
    EXEC proc_Set_Fact_TrackerDataSurrogateKeyData; --Verified WDM 1.21.2016

    exec proc_create_Trigger_ON_TrackerName ;

    -- THE Following MAY NOT execute properly, may need to be removed.
    EXEC proc_genTrackerPrimaryKeys;



END;
GO
PRINT 'EXECUTED proc_GenTrackerCTProcMASTER.sql';
GO
