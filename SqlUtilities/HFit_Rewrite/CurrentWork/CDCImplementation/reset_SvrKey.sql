
GO
USE KenticoCMS_Datamart_2;
GO

/*
select  'exec reset_SvrKey "' + table_name +'" ' + char(10) + 'GO' as CMD 
from	   information_schema.tables 
where   (table_name like 'FACT_%' OR table_name like 'BASE_%')
	   and table_name not like  '%_CTVerHIST'
	   --and table_name not like '%_NoNulls'
	   --and table_name not like '%_VerHIST'
*/
-- use KenticoCMS_Datamart_2;
GO
-- exec reset_SvrKey BASE_View_Hfit_CoachingSystemSettings_Joined
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'reset_SvrKey') 
    BEGIN
        DROP PROCEDURE
             reset_SvrKey;
    END;
GO
-- exec reset_SvrKey BASE_View_HFit_CoachingNotAssignedSettings_Joined
CREATE PROCEDURE reset_SvrKey (
       @TblName AS NVARCHAR (250) 
     , @inc AS BIGINT = 100000) 
AS
BEGIN

    SET @TblName = ltrim (rtrim (@TblName)) ;

    SET NOCOUNT ON;
    DECLARE
           @iCnt AS BIGINT = 0
         , @TotRecs AS BIGINT = 0
         , @PCT AS FLOAT = 0
         , @TotProcessed AS BIGINT = 0
         , @iCurr AS BIGINT = 0
         , @TempCountTBL AS BIGINT = 0
         , @iLoop AS BIGINT = 0
         , @iTotLoopReqd AS BIGINT = 0
         , @iRemain AS BIGINT = 0
         , @msg AS NVARCHAR (MAX) = ''
         , @start AS DATETIME
         , @end AS DATETIME
         , @secs AS DECIMAL (10 , 2) 
         , @minutes AS DECIMAL (10 , 2) 
         , @MySQl AS NVARCHAR (MAX) = ''
         , @IdentCol AS NVARCHAR (250) = '';

    SET @Msg = '--------------------------------------------' + char (10) + 'Processing Table: ' + @TblName;
    EXEC printImmediate @msg;

    SET @IdentCol = (SELECT
                            COLUMN_NAME
                     FROM INFORMATION_SCHEMA.COLUMNS
                     WHERE
                            TABLE_SCHEMA = 'dbo' AND
                            TABLE_NAME = @TblNAme AND
                            COLUMNPROPERTY (object_id (TABLE_NAME) , COLUMN_NAME , 'IsIdentity') = 1) ;

    IF @IdentCol IS NULL
        BEGIN
            PRINT 'Table ' + @TblName + ' has no identity column, adding one called RowNbrIdent, standby...';
            SET @MySql = 'alter table ' + @TblName + ' add RowNbrIdent bigint identity (1,1) ';
            EXEC (@MySql) ;
            SET @iCnt = @TempCountTBL;
            SET @msg = 'Added indentity ID to ' + CAST (@iCnt  AS NVARCHAR (50)) + ' rows.';
        END;

    DECLARE
           @TempTBL TABLE (
                          Value BIGINT) ;

    EXEC @TotRecs = proc_QuickRowCount @TblName , 1;

    -- declare @iTbl as table (cnt as bigint) ;

    SET @MySql = 'select count(*) from ' + @TblName + ' where SVR != ''TGT-AZUSQL02'' OR SVR IS NULL ';
    --SET @MySql = 'insert into @iTbl (cnt) values (select count(*) from ' + @TblName + ' where SVR != '' TGT-AZUSQL02'' OR SVR IS NULL )';
    DELETE FROM @TempTBL;
    INSERT INTO @TempTBL
    EXEC ('SELECT COUNT(*) ' + @MySql) ;
    SELECT
           @iCnt = Value
    FROM @TempTBL;

    SET @iTotLoopReqd = @TotRecs / @inc;

    IF @iCnt = 0
        BEGIN
            SET NOCOUNT OFF;
            PRINT '1 -NO ROWS FOUND, in ' + @TblName + ', Skipping...';
            RETURN;
        END;
    ELSE
        BEGIN
            SET @MSg = cast (@iCnt AS NVARCHAR) + ' ROWS FOUND, in ' + @TblName + ', Processing...';
            EXEC PrintImmediate @msg;
        END;
    IF @iCnt < @inc
        BEGIN
            SET NOCOUNT OFF;

            EXEC ScriptAllForeignKeyConstraints ;
		  exec dropAllForeignKeyCONSTRAINTS @TblName ;
            EXEC proc_TableFKeysDrop @TblName;
            EXEC Disable_TableTriggers @TblName;

            SET @Msg = 'Processing ' + cast (@iCnt AS NVARCHAR (50)) + ' rows immediately... standy.';
            EXEC PrintImmediate @Msg;
            SET @MySql = 'update ' + @TblName + ' set SVR = ''TGT-AZUSQL02'' where SVR != ''TGT-AZUSQL02'' or SVR is null ';
		  EXEC PrintImmediate @MySql;
            EXEC (@MySql) ;
            SET @iCnt = @@ROWCOUNT;
            SET @msg = 'Successfully updated ' + CAST (@iCnt  AS NVARCHAR (50)) + ' rows. Finished.';
            EXEC PrintImmediate @Msg;

            EXEC proc_AddMissingTableFKeys @TblName;
            EXEC Enable_TableTriggers @TblName;

            RETURN;
        END;

    DECLARE
           @IdxName AS NVARCHAR (500) = 'PI000_' + @TblName;
    IF NOT EXISTS (SELECT
                          name
                   FROM sys.indexes
                   WHERE name = @IdxName) 
        BEGIN
            SET @MySql = 'create NONCLUSTERED index ' + @IdxName + ' on dbo.' + @TblName + '(SVR ASC) include (' + @IdentCol + ') ';
            EXEC printImmediate @MySql;
            EXEC (@MySql) ;
        END;

    EXEC ScriptAllForeignKeyConstraints ;
    EXEC proc_TableFKeysDrop @TblName;
    EXEC Disable_TableTriggers @TblName;
    --exec Disable_TableINDEXES @TblName ;

    WHILE
           @iLoop <= @iTotLoopReqd
        BEGIN
            SET @iLoop = @iLoop + 1;
            SET @msg = 'LOOP ' + cast (@iLoop AS NVARCHAR (50)) + ' of ' + cast (@iTotLoopReqd AS NVARCHAR (50)) ;
            EXEC PrintImmediate @Msg;
            SET @start = getdate () ;

            BEGIN TRANSACTION tx1;
            SET @MySql = 'update ' + @TblName + ' set SVR = ''TGT-AZUSQL02'' where ' + @IdentCol + ' in (Select top ' + cast (@inc AS NVARCHAR (50)) + ' ' + @IdentCol + ' from ' + @TblName + ' where SVR = ''TGT-AZUSQL01'' or SVR is null) ';
            IF @iLoop <= 3
                BEGIN
                    EXEC PrintImmediate @MySql;
                END;
            EXEC (@MySql) ;
            SET @iCurr = @@ROWCOUNT;
            SET @iRemain = @TotRecs - @iCurr;
            SET @TotProcessed = @TotProcessed + @iCurr;
            SET @iRemain = @TotRecs - @TotProcessed;
            COMMIT TRANSACTION tx1;
            CHECKPOINT;
            SET @end = getdate () ;
            SET @secs = datediff (second , @start , @end) ;
            SET @minutes = @secs / 60;
            SET @PCT = cast (@TotProcessed AS FLOAT) / cast (@TotRecs AS FLOAT) * 100;
            SET @msg = 'Total Recs: ' + cast (@TotRecs AS NVARCHAR (50)) + ' / Total Processed: ' + cast (@TotProcessed AS NVARCHAR (50)) + ' / Remaining: ' + cast (@iRemain AS  NVARCHAR (50)) ;
            SET @msg = @msg + ' / Seconds: ' + cast (@secs AS NVARCHAR (50)) + ' / minutes: ' + cast (@minutes AS NVARCHAR (50)) ;
            SET @msg = @msg + ' / PCT Completed: ' + cast (cast (@TotProcessed AS DECIMAL (10 , 2)) / cast (@TotRecs AS DECIMAL (10 , 2)) * 100 AS NVARCHAR (50)) ;
            EXEC PrintImmediate @msg;

            DECLARE
                   @hrs AS DECIMAL (10 , 2) = @minutes * (@iTotLoopReqd - @iLoop) / 60;
            SET @msg = @TblName + ' - Hrs. Remaining: ' + cast (@hrs AS NVARCHAR (50)) ;
            EXEC PrintImmediate @msg;

            SET @MySql = 'select count(*) from ' + @TblName + ' where SVR = ''TGT-AZUSQL01'' OR SVR IS NULL ';

            DELETE FROM @TempTBL;
            INSERT INTO @TempTBL (
                   Value) 
            VALUES (@iRemain) ;
            SET @iCnt = @iRemain;

        --EXEC (@MySql) ;
        --SELECT
        --       @iCnt = Value
        --FROM @TempTBL;

        END;

    EXEC proc_AddMissingTableFKeys @TblName ;
    EXEC Enable_TableTriggers @TblName;

    --PUT this section back in place when the initial update is completed.
    --if not exists (select name from sys.indexes where name = @IdxName) 
    --begin
    --exec printImmediate @MySql ;
    --set @MySql = 'drop index ' + @IdxName + ' on ' + @TblName  ;
    --exec (@MySql ) ;
    --end 

    SET NOCOUNT OFF;
END;