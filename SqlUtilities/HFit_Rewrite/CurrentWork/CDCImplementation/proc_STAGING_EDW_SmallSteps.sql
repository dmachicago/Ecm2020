
/*---------------------------------------
Developer  : W. Dale Miller
05.28.2015 : WDM - completed unit testing
*/

GO
PRINT 'creating proc_EDW_SmallSteps';
PRINT GETDATE () ;
GO

IF EXISTS ( SELECT
                   name
            FROM sys.procedures
            WHERE
                   name = 'proc_EDW_SmallSteps') 
    BEGIN
        PRINT 'UPDATING proc_EDW_SmallSteps';
        DROP PROCEDURE
             proc_EDW_SmallSteps;
    END;
GO
-- exec proc_EDW_SmallSteps 0
-- exec proc_EDW_SmallSteps 1
CREATE PROCEDURE proc_EDW_SmallSteps (
       @ReloadAll AS INT = 0) 
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
           @iTotal AS BIGINT = 0;

    EXEC @iTotal = proc_QuickRowCount 'DIM_EDW_SmallSteps';

    IF @iTotal = 1
        BEGIN
            SET @Reloadall = 1;
        END;

/*------------------------------------------------------------------------------------------------------------------------
    This procedure is added to the job job_EDW_GetStagingData_RewardUserDetail and set to run automatically on a schedule.
*/

    BEGIN
        DECLARE
               @STime AS DATETIME = GETDATE () 
             , @CNT_PulledRecords AS BIGINT = 0
             , @RecordID AS UNIQUEIDENTIFIER = NEWID () 
             , @CT_NAME AS NVARCHAR ( 100) = 'proc_EDW_SmallSteps';

        DECLARE
               @isNullable AS NVARCHAR ( 20) = NULL;

        SET @STime = GETDATE () ;
        EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_EDW_SmallSteps' , @STime , @CNT_PulledRecords , 'I';
        EXEC proc_EDW_Procedure_Performance_Monitor 'D' , @CT_NAME;
        EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '001 - start up';

        IF @ReloadAll = 1
            BEGIN
                PRINT 'RELOADING ALL EDW_SmallSteps records';

                IF EXISTS ( SELECT
                                   name
                            FROM sys.tables
                            WHERE
                                   name = 'DIM_EDW_SmallSteps') 
                    BEGIN
                        PRINT 'Dropping DIM_EDW_SmallSteps';
                        DROP TABLE
                             DIM_EDW_SmallSteps;
                    END;
            END;
        IF
        @ReloadAll = 0 OR
        @ReloadAll IS NULL
            BEGIN
                PRINT 'RELOADING only changed EDW_SmallSteps records';
            END;
        IF NOT EXISTS ( SELECT
                               name
                        FROM sys.tables
                        WHERE
                               name = 'DIM_EDW_SmallSteps') 
            BEGIN
                EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '002 - Starting Data Pulled';
                SELECT
                       * INTO
                              DIM_EDW_SmallSteps
                FROM view_EDW_SmallStepResponses_CT;
                DECLARE
                       @iPulled AS INT = @@ROWCOUNT;

                EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_SmallSteps';

                EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '002a - Data Pulled';

                EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @CNT_PulledRecords;
                IF NOT EXISTS ( SELECT
                                       column_name
                                FROM information_schema.columns
                                WHERE
                                       table_name = 'DIM_EDW_SmallSteps' AND
                                       column_name = 'LastModifiedDate') 
                    BEGIN
                        ALTER TABLE DIM_EDW_SmallSteps
                        ADD
                                    LastModifiedDate DATETIME2 ( 7) NULL;
                    END;

                SET @isNullable = ( SELECT
                                           IS_NULLABLE
                                    FROM information_schema.columns
                                    WHERE
                                           table_name = 'DIM_EDW_SmallSteps' AND
                                           column_name = 'LastModifiedDate') ;
                IF
                       @isNullable != 'YES'
                    BEGIN
                        ALTER TABLE dbo.DIM_EDW_SmallSteps ALTER COLUMN LastModifiedDate DATETIME2 NULL;
                        PRINT 'set LastModifiedDate to be NULLABLE.';
                    END;

                IF NOT EXISTS ( SELECT
                                       column_name
                                FROM information_schema.columns
                                WHERE
                                       table_name = 'DIM_EDW_SmallSteps' AND
                                       column_name = 'DeletedFlg') 
                    BEGIN
                        ALTER TABLE DIM_EDW_SmallSteps
                        ADD
                                    DeletedFlg BIT NULL;
                    END;

                IF NOT EXISTS ( SELECT
                                       column_name
                                FROM information_schema.columns
                                WHERE
                                       table_name = 'DIM_EDW_SmallSteps' AND
                                       column_name = 'ChangeType') 
                    BEGIN
                        ALTER TABLE DIM_EDW_SmallSteps
                        ADD
                                    ChangeType NVARCHAR ( 5) NULL;
                    END;
                EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '003 - Starting Data indexed';

                SET ANSI_PADDING ON;
                CREATE CLUSTERED INDEX PI_EDW_SmallSteps ON dbo.DIM_EDW_SmallSteps ( AccountCD , SiteGUID , SSItemID , SSItemGUID ,
                SSHealthAssesmentUserStartedItemID , SSOutcomeMessageGuid , HFitUserMPINumber , HACampaignNodeGUID , HAStartedMode , HACompletedMode ,
                HaCodeName ,
                HACampaignStartDate , HACampaignEndDate) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF ,
                DROP_EXISTING = OFF ,
                ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                CREATE NONCLUSTERED INDEX PI_EDW_SmallSteps_RowNbrCDate ON dbo.DIM_EDW_SmallSteps ( SSItemID , LastModifiedDate ,
                DeletedFlg) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF ,
                ALLOW_ROW_LOCKS = ON ,
                ALLOW_PAGE_LOCKS = ON) ;

                CREATE NONCLUSTERED INDEX PI_EDW_SmallSteps_ItemID ON dbo.DIM_EDW_SmallSteps ( SSItemID) 
                WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF ,
                ALLOW_ROW_LOCKS = ON ,
                ALLOW_PAGE_LOCKS = ON) ;

                CREATE NONCLUSTERED INDEX PI_EDW_SmallSteps_HashCode ON dbo.DIM_EDW_SmallSteps ( HFitUserMPINumber , HashCode) 
                WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF ,
                ALLOW_ROW_LOCKS = ON ,
                ALLOW_PAGE_LOCKS = ON) ;

                SET @STime = GETDATE () ;
                EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_EDW_SmallSteps' , @STime , @iPulled , 'U';
                EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '003a - Data indexed';
                EXEC proc_EDW_Procedure_Performance_Monitor 'T' , @CT_NAME , '002a - reload complete';

                EXEC proc_EDW_ChangeGmtToCentralTime 'DIM_EDW_SmallSteps';
                SET NOCOUNT OFF;
                EXEC proc_CT_EDW_SmallSteps_NoDups ;
                RETURN;
            END;

        --IF EXISTS ( SELECT
        --                   name
        --              FROM temp..sys.tables
        --              WHERE name = '##Temp_SmallSteps' )
        IF OBJECT_ID ('tempdb..##Temp_SmallSteps') IS NOT NULL
            BEGIN
                PRINT 'Dropping ##Temp_SmallSteps';
                DROP TABLE
                     ##Temp_SmallSteps;
            END;

        DECLARE
               @iChgType AS INT = 0;
        EXEC @iChgType = proc_CkSmallStepsHasChanged ;
        PRINT '@iChgType = ' + CAST ( @iChgType AS NVARCHAR (50)) ;

        IF @iChgType = 0
            BEGIN
                PRINT 'NO CHANGES FOUND, returning.';
                SET @STime = GETDATE () ;
                EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_EDW_SmallSteps' , @STime , @iPulled , 'U';
                EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '00Z1 - NO CHANGES';
                EXEC proc_EDW_Procedure_Performance_Monitor 'T' , @CT_NAME , '00Z2 - reload complete';

                RETURN;
            END;

        DECLARE
               @iCnt AS BIGINT = 0;

        --select top 10 * from ##Temp_SmallSteps
        EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '004 - get changes';
        IF @iChgType = 2
            BEGIN
                PRINT 'PULLING ALL records as deletes were detected.';
                SELECT
                       * INTO
                              ##Temp_SmallSteps
                FROM view_EDW_SmallStepResponses_CT;
            END;
        IF @iChgType = 1
            BEGIN
                DECLARE
                       @S1 AS NVARCHAR (2000) = '';
                PRINT 'PULLING only changed records as NO deletes were detected.';
                SET @S1 = 'SELECT
                       * INTO
                              ##Temp_SmallSteps
                  FROM view_EDW_SmallStepResponses_CT
                  WHERE ChangeType IS NOT NULL ';
                EXEC (@S1) ;
            END;
        --WHERE ChangeType IS NOT NULL;
        EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '005 - changes retrieved';
        SET @iCnt = @@ROWCOUNT;
        IF @iCnt = 0
            BEGIN
                PRINT 'No changes detected.';
                EXEC proc_EDW_Procedure_Performance_Monitor 'T' , @CT_NAME , '005 - NO CHANGES';

                EXEC proc_EDW_ChangeGmtToCentralTime 'DIM_EDW_SmallSteps';
                SET NOCOUNT OFF;
                RETURN;
            END;
        ELSE
            BEGIN
                PRINT 'PROCESSING ' + CAST ( @iCnt AS NVARCHAR ( 50)) + ' rows.';
            END;

        IF NOT EXISTS ( SELECT
                               column_name
                        FROM information_schema.columns
                        WHERE
                               table_name = 'DIM_EDW_SmallSteps' AND
                               column_name = 'LastModifiedDate') 
            BEGIN
                ALTER TABLE ##Temp_SmallSteps
                ADD
                            LastModifiedDate DATETIME2 ( 7) NULL;
            END;

        SET @isNullable = ( SELECT
                                   IS_NULLABLE
                            FROM information_schema.columns
                            WHERE
                                   table_name = 'DIM_EDW_SmallSteps' AND
                                   column_name = 'LastModifiedDate') ;
        IF
               @isNullable != 'YES'
            BEGIN
                ALTER TABLE dbo.DIM_EDW_SmallSteps ALTER COLUMN LastModifiedDate DATETIME2 NULL;
                PRINT 'set LastModifiedDate to be NULLABLE.';
            END;

        IF NOT EXISTS ( SELECT
                               column_name
                        FROM information_schema.columns
                        WHERE
                               table_name = 'DIM_EDW_SmallSteps' AND
                               column_name = 'DeletedFlg') 
            BEGIN
                ALTER TABLE ##Temp_SmallSteps
                ADD
                            DeletedFlg BIT NULL;
            END;

        IF NOT EXISTS ( SELECT
                               column_name
                        FROM information_schema.columns
                        WHERE
                               table_name = 'DIM_EDW_SmallSteps' AND
                               column_name = 'ChangeType') 
            BEGIN
                ALTER TABLE ##Temp_SmallSteps
                ADD
                            ChangeType NVARCHAR ( 5) NULL;
            END;

        CREATE CLUSTERED INDEX PI_TEMP_EDW_SmallSteps ON ##Temp_SmallSteps ( AccountCD , SiteGUID , SSItemID , SSItemGUID ,
        SSHealthAssesmentUserStartedItemID , SSOutcomeMessageGuid , HFitUserMPINumber , HACampaignNodeGUID , HAStartedMode , HACompletedMode ,
        HaCodeName ,
        HACampaignStartDate , HACampaignEndDate) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF ,
        ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

        CREATE NONCLUSTERED INDEX PI_TEMP_EDW_SmallSteps_ItemID ON ##Temp_SmallSteps ( SSItemID) 
        WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF ,
        ALLOW_ROW_LOCKS = ON ,
        ALLOW_PAGE_LOCKS = ON) ;

        CREATE NONCLUSTERED INDEX PI_TEMP_EDW_SmallSteps_Hashcode ON ##Temp_SmallSteps ( HFitUserMPINumber , HashCode) 
        WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF ,
        ALLOW_ROW_LOCKS = ON ,
        ALLOW_PAGE_LOCKS = ON) ;

        EXEC proc_CT_EDW_SmallSteps_Temp_NoDups ;

        EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '006 - indexes applied';
        EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '007 - get new records';

        DECLARE
               @iInserted AS INT = 0;

        --************************************************************
        --** APPLY ANY NEW RECORDS TO THE STAGING TABLE
        EXEC @iInserted = proc_CT_SmallSteps_AddNewRecs ;
        --************************************************************

        EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @iInserted;
        PRINT 'Records Added: ' + CAST ( @iInserted AS NVARCHAR (5)) ;
        EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '007a - new records added';

        DECLARE
               @RUNDATE AS DATETIME2 ( 7) = GETDATE () ;

/*-------------------------------------------------
***********************************************
	   get the changed records and update them
	   ***********************************************
*/
        EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '008 - get changed records';

        DECLARE
               @iUpdated AS INT = 0;
        --************************************************************
        --** APPLY ANY NEW RECORDS TO THE STAGING TABLE
        EXEC @iUpdated = proc_CT_SmallSteps_AddUpdatedRecs ;
        --************************************************************

        EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '008a - retrieved changed records';
        EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'U' , @iUpdated;
        PRINT 'Records Updated: ' + CAST ( @iUpdated  AS NVARCHAR (5)) ;
        EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '009 - retrieve deleted records';

        DECLARE
               @iDeleted AS INT = @@ROWCOUNT;
        --************************************************************
        --** MARK DELETED RECORDS
        EXEC @iDeleted = proc_CT_SmallSteps_AddDeletedRecords ;
        --************************************************************

        EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @CT_NAME , '009a - retrieved deleted records';
        EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'D' , @iDeleted;
        PRINT 'Records Marked As Deleted: ' + CAST ( @iDeleted AS NVARCHAR (5)) ;
        SET @STime = GETDATE () ;
        SET @CNT_PulledRecords = ( SELECT
                                          COUNT ( *) 
                                   FROM ##Temp_SmallSteps) ;
    END;
    EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_EDW_SmallSteps' , @STime , @CNT_PulledRecords , 'U';

    EXEC proc_EDW_ChangeGmtToCentralTime 'DIM_EDW_SmallSteps';

    PRINT 'Executed proc_EDW_SmallSteps';
    PRINT GETDATE () ;

    EXEC proc_EDW_Procedure_Performance_Monitor 'T' , @CT_NAME , '010 - retrieved deleted records';
    EXEC proc_CT_EDW_SmallSteps_NoDups;

    SET NOCOUNT OFF;
END;
GO
PRINT 'CREATED proc_EDW_SmallSteps';
PRINT GETDATE () ;
GO
