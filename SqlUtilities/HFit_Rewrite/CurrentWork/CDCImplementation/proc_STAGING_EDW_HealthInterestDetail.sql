
GO
-- use KenticoCMS_Prod1

/*---------------------------------------
Developer  : W. Dale Miller
05.28.2015 : WDM - completed unit testing
*/

GO

/*---------------------------------------------------------------------------------------------------------------------------
{Potential Natural Key}
select count(*), UserID,UserGUID,HFitUserMpiNumber,SiteGUID,CoachingHealthInterestID,FirstNodeID,SecondNodeGuid,ThirdNodeGuid
from 
view_EDW_HealthInterestDetail_CT
group by UserID,UserGUID,HFitUserMpiNumber,SiteGUID,CoachingHealthInterestID,FirstNodeID,SecondNodeGuid,ThirdNodeGuid
having Count(*) > 1

exec proc_EDW_HealthInterestDetail 1
exec proc_EDW_HealthInterestDetail 0
*/

GO
PRINT 'creating proc_EDW_HealthInterestDetail';
PRINT GETDATE () ;
GO

IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_EDW_HealthInterestDetail') 
    BEGIN
        PRINT 'Replacing proc_EDW_HealthInterestDetail';
        DROP PROCEDURE
             proc_EDW_HealthInterestDetail;
    END;

GO

CREATE PROCEDURE proc_EDW_HealthInterestDetail (
       @ReloadAll AS int = 0) 
AS
BEGIN
    BEGIN
        SET NOCOUNT ON;

        DECLARE
        @iTotal AS bigint = 0;

        EXEC @iTotal = proc_QuickRowCount 'DIM_EDW_HealthInterestDetail';

        IF @iTotal <= 1
            BEGIN
                SET @Reloadall = 1;
            END;

        DECLARE
        @RecordID AS uniqueidentifier = NEWID () ;
        DECLARE
        @CT_DateTimeNow AS datetime = GETDATE () ;
        DECLARE
        @CT_NAME AS nvarchar ( 50) = 'proc_EDW_HealthInterestDetail';
        EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , @CT_NAME , @CT_DateTimeNow , 0 , 'I';
        IF @ReloadAll = 1
            BEGIN
                PRINT 'RELOADING ALL EDW_HealthInterestDetail records';
                DROP TABLE
                     DIM_EDW_HealthInterestDetail;
            END;
        IF
        @ReloadAll = 0 OR
        @ReloadAll IS NULL
            BEGIN
                PRINT 'RELOADING only changed EDW_HealthInterestDetail records';
            END;

        IF NOT EXISTS ( SELECT
                               name
                               FROM sys.tables
                               WHERE name = 'DIM_EDW_HealthInterestDetail') 
            BEGIN
                SELECT
                       * INTO
                              DIM_EDW_HealthInterestDetail
                       FROM view_EDW_HealthInterestDetail_CT;
                DECLARE
                @irecs AS int = @@ROWCOUNT;
                PRINT 'RECORDS Loaded: ' + CAST ( @irecs AS nvarchar ( 50)) ;

                EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_HealthInterestDetail';

                EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @irecs;
                EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , @CT_NAME , @CT_DateTimeNow , @irecs , 'U';

                SET ANSI_PADDING ON;

                CREATE CLUSTERED INDEX PI_EDW_HealthInterestDetail ON dbo.DIM_EDW_HealthInterestDetail ( UserID , UserGUID , HFitUserMpiNumber , SiteGUID , CoachingHealthInterestID , FirstNodeID , SecondNodeGuid , ThirdNodeGuid) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

                CREATE NONCLUSTERED INDEX PI_EDW_HealthInterestDetail_RowNbrCDate ON dbo.DIM_EDW_HealthInterestDetail ( LastModifiedDate , DeletedFlg) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

                EXEC proc_EDW_ChangeGmtToCentralTime 'DIM_EDW_HealthInterestDetail';

                IF @ReloadAll = 1
                    BEGIN
                        RETURN;
                    END;
            END;

        IF EXISTS ( SELECT
                           table_name
                           FROM tempdb.information_schema.tables
                           WHERE table_name = '##Temp_HealthInterestDetail'
        ) 
            BEGIN
                PRINT 'Dropping ##Temp_HealthInterestDetail';
                DROP TABLE
                     ##Temp_HealthInterestDetail;
            END;

        SELECT
               * INTO
                      ##Temp_HealthInterestDetail
               FROM view_EDW_HealthInterestDetail_CT;

        EXEC proc_Add_EDW_CT_StdCols '##Temp_HealthInterestDetail';
        EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_HealthInterestDetail';

        CREATE CLUSTERED INDEX PI_TEMP_EDW_HealthInterestDetail
        ON ##Temp_HealthInterestDetail
        ( UserID , UserGUID , HFitUserMpiNumber , SiteGUID , CoachingHealthInterestID , FirstNodeID , SecondNodeGuid , ThirdNodeGuid) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

        DECLARE
        @irecs2 AS int = @@ROWCOUNT;
        EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , @CT_NAME , @CT_DateTimeNow , @irecs2 , 'U';

        --************************************************
        --	   get the NEW records and insert them
        --	   TEST: Truncate table DIM_EDW_HealthInterestDetail
        --************************************************
        --SET IDENTITY_INSERT DIM_EDW_HealthInterestDetail ON ;

        DECLARE
        @inew AS int = 0;
        EXEC @inew = proc_CT_HealthInterestDetail_AddNewRecs ;
        EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @inew;
        PRINT 'Records Added: ' + CAST ( @inew AS nvarchar (5)) ;

        --************************************************
        --get the changed records and update them
        --************************************************
        DECLARE
        @iupdate AS int = 0;
        EXEC @iupdate = proc_CT_HealthInterestDetail_AddUpdatedRecs ;
        EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'U' , @iupdate;
        PRINT 'Records Updated: ' + CAST ( @iupdate AS nvarchar (5)) ;

        --************************************************
        --get the deleted records flag them
        --************************************************
        DECLARE
        @idel AS int = 0;
        EXEC @idel = proc_CT_HealthInterestDetail_AddDeletedRecs ;
        EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'D' , @idel;
        PRINT 'Records Marked As Deleted: ' + CAST ( @idel AS nvarchar (5)) ;

    END;

    EXEC proc_EDW_ChangeGmtToCentralTime 'DIM_EDW_HealthInterestDetail';
    EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , @CT_NAME , @CT_DateTimeNow , @irecs , 'U';
    PRINT 'Created proc_EDW_HealthInterestDetail';
    PRINT GETDATE () ;
    SET NOCOUNT OFF;
--select top 100 * from DIM_EDW_HealthInterestDetail
END;

GO
PRINT 'CREATED proc_EDW_HealthInterestDetail';
PRINT GETDATE () ;
GO
