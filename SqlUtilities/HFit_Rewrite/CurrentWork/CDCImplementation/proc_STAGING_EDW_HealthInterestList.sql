
GO
-- use KenticoCMS_Prod1

/*---------------------------------------
Developer  : W. Dale Miller
05.28.2015 : WDM - completed unit testing
*/

GO
PRINT 'creating proc_EDW_HealthInterestList';
PRINT GETDATE () ;
GO

IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_EDW_HealthInterestList') 
    BEGIN
        PRINT 'UPDATING proc_EDW_HealthInterestList';
        DROP PROCEDURE
             proc_EDW_HealthInterestList;
    END;

GO

/*-------------------------------------------------------------
{Potential Natural Key}
select count(*) as CNT,  HealthAreaID,NodeID,NodeGuid,AccountCD
from 
view_EDW_HealthInterestList_CT
group by HealthAreaID,NodeID,NodeGuid,AccountCD
having Count(*) > 1

exec proc_EDW_HealthInterestList 0
exec proc_EDW_HealthInterestList 1
*/

CREATE PROCEDURE proc_EDW_HealthInterestList (
       @ReloadAll AS int = 0) 
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE
    @iTotal AS bigint = 0;

    EXEC @iTotal = proc_QuickRowCount 'DIM_EDW_HealthInterestList';

    IF @iTotal <= 1
        BEGIN
            SET @Reloadall = 1;
        END;

    --******************************************************************************************************************************
    -- This procedure is added to the job job_EDW_GetStagingData_RewardUserDetail and set to run automatically on a schedule.
    --******************************************************************************************************************************

    BEGIN

        IF @ReloadAll IS NULL
            BEGIN
                SET @ReloadAll = 0;
            END;

        DECLARE
        @RecordID AS uniqueidentifier = NEWID () ;
        DECLARE
        @CT_DateTimeNow AS datetime = GETDATE () ;
        DECLARE
        @CT_NAME AS nvarchar ( 50) = 'proc_EDW_HealthInterestList';
        EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , @CT_NAME , @CT_DateTimeNow , 0 , 'I';

        IF @ReloadAll = 1
            BEGIN
                PRINT 'RELOADING ALL EDW_HealthInterestList records';
                PRINT 'Droppoing table DIM_EDW_HealthInterestList';
                IF EXISTS ( SELECT
                                   name
                                   FROM sys.tables
                                   WHERE name = 'DIM_EDW_HealthInterestList') 
                    BEGIN
                        DROP TABLE
                             DIM_EDW_HealthInterestList;
                    END;
            END;

        DECLARE
        @iFound AS int = ( SELECT
                                  COUNT ( *) 
                                  FROM sys.tables
                                  WHERE name = 'DIM_EDW_HealthInterestList') ;

        PRINT '@iFound: ' + CAST ( @iFound AS nvarchar (50)) ;

        IF @iFound = 0
            BEGIN
                PRINT 'CREATING DIM_EDW_HealthInterestList';
                SELECT
                       * INTO
                              DIM_EDW_HealthInterestList
                       FROM view_EDW_HealthInterestList_CT;

                EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_HealthInterestList';

                DECLARE
                @iReloadCnt AS int = @@ROWCOUNT;
                EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , @CT_NAME , @CT_DateTimeNow , @iReloadCnt , 'U';
                EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @iReloadCnt;
                --PRINT 'LOC 003';

                SET ANSI_PADDING ON;

                CREATE CLUSTERED INDEX PI_EDW_HealthInterestList ON dbo.DIM_EDW_HealthInterestList ( HealthAreaID , NodeID , NodeGuid , AccountCD) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

                CREATE NONCLUSTERED INDEX PI_EDW_HealthInterestList_RowNbrCDate ON dbo.DIM_EDW_HealthInterestList ( RowNbr , LastModifiedDate , DeletedFlg) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                --PRINT 'LOC 004a';
                EXEC proc_EDW_ChangeGmtToCentralTime 'DIM_EDW_HealthInterestList';
                SET NOCOUNT OFF;
                RETURN;
            END;

        IF EXISTS ( SELECT
                           table_name
                           FROM tempdb.information_schema.tables
                           WHERE table_name = '##Temp_HealthInterestList'
        ) 
            BEGIN
                PRINT 'Dropping ##Temp_HealthInterestList';
                DROP TABLE
                     ##Temp_HealthInterestList;
            END;

        SELECT
               * INTO
                      ##Temp_HealthInterestList
               FROM view_EDW_HealthInterestList_CT;

        EXEC proc_Add_EDW_CT_StdCols '##Temp_HealthInterestList';
        CREATE CLUSTERED INDEX PI_TEMP_EDW_HealthInterestList ON ##Temp_HealthInterestList ( HealthAreaID , NodeID , NodeGuid , AccountCD) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

        --************************************************
        --get the NEW records and insert them
        --************************************************
        DECLARE
        @iInserts AS int = 0;
        EXEC @iInserts = proc_CT_HealthInterestList_AddNewRecs ;
        PRINT 'NEW Records Added: ' + CAST ( @iInserts AS nvarchar (5)) ;
        EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @iInserts;

        --************************************************
        --get the changed records and update them
        --************************************************

        DECLARE
        @iUpdates AS int = 0;
        EXEC @iUpdates = proc_CT_HealthInterestList_AddUpdatedRecs ;
        EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'U' , @iUpdates;

        PRINT 'Records Updated: ' + CAST ( @iUpdates AS nvarchar (5)) ;

        --************************************************
        --Mark deleted records
        --************************************************
        DECLARE
        @iDeletes AS int = @@ROWCOUNT;
        EXEC @iDeletes = proc_CT_HealthInterestList_AddDeletedRecs ;
        PRINT 'Records Marked As Deleted: ' + CAST ( @iDeletes AS nvarchar (5)) ;
        EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'D' , @iDeletes;
        EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , @CT_NAME , @CT_DateTimeNow , @iReloadCnt , 'U';

    END;

    EXEC proc_EDW_ChangeGmtToCentralTime 'DIM_EDW_HealthInterestList';
    EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , @CT_NAME , @CT_DateTimeNow , @iReloadCnt , 'U';
    PRINT 'Created proc_EDW_HealthInterestList';
    PRINT GETDATE () ;
    SET NOCOUNT OFF;
--select top 100 * from DIM_EDW_HealthInterestList
END;

GO
PRINT 'CREATED proc_EDW_HealthInterestList';
PRINT GETDATE () ;
GO
