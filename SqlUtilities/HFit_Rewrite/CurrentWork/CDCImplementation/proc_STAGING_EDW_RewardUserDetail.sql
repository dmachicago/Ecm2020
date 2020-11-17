
/*---------------------------------------
Developer  : W. Dale Miller
05.28.2015 : WDM - completed unit testing
*/

GO
PRINT 'creating proc_EDW_RewardUserDetail';
PRINT GETDATE () ;
GO

IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_EDW_RewardUserDetail') 
    BEGIN
        PRINT 'Replacing proc_EDW_RewardUserDetail';
        DROP PROCEDURE
             proc_EDW_RewardUserDetail;
    END;

GO

/*---------------------------------------
exec proc_EDW_RewardUserDetail 0 
exec proc_EDW_RewardUserDetail 1
*/

CREATE PROCEDURE proc_EDW_RewardUserDetail
       @Reloadall int = 0
AS
BEGIN
    --declare @Reloadall as int = 1 ; 
    SET NOCOUNT ON;

/*-------------------------------------------------
RETURNS:	  Integer -   0 = no changes
				    1 = updates or inserts, no deletes
				    2 = DELETES and possibly updates or inserts
*/
    DECLARE @iChanges AS int = 0;
    EXEC @iChanges = proc_CkRewardUserDetailHasChanged ;
    IF @iChanges = 0
        BEGIN
            PRINT 'NO Changes found for Reward USer Details, competed.';
            RETURN;
        END;

    DECLARE
    @iTotal AS bigint = 0;

    EXEC @iTotal = proc_QuickRowCount 'DIM_EDW_RewardUserDetail';

    IF @iTotal = 1
        BEGIN
            SET @Reloadall = 1;
        END;

    DECLARE
    @RecordID AS uniqueidentifier = NEWID () 
  , @CT_DateTimeNow AS datetime = GETDATE () 
  , @CT_NAME AS nvarchar ( 50) = 'proc_EDW_RewardUserDetail';

    EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , @CT_NAME , @CT_DateTimeNow , 0 , 'I';

    IF @Reloadall = 1
        BEGIN
            PRINT 'RELOADING all proc_EDW_RewardUserDetail data';
            IF EXISTS ( SELECT
                               name
                               FROM sys.tables
                               WHERE name = 'DIM_EDW_RewardUserDetail') 
                BEGIN
                    DROP TABLE
                         DIM_EDW_RewardUserDetail;
                END;

            IF NOT EXISTS ( SELECT
                                   name
                                   FROM sys.tables
                                   WHERE name = 'DIM_EDW_RewardUserDetail') 
                BEGIN
                    SELECT
                           * INTO
                                  DIM_EDW_RewardUserDetail
                           FROM view_EDW_RewardUserDetail_CT;

                    EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_RewardUserDetail';

                    DECLARE
                    @iCnt2 AS int = @@ROWCOUNT;
                    PRINT 'Processed ' + CAST ( @iCnt2 AS nvarchar ( 50)) ;

                    EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @iCnt2;
                    EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'T' , @iCnt2;
                    EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , @CT_NAME , @CT_DateTimeNow , @iCnt2 , 'U';

                    SET ANSI_PADDING ON;

                    CREATE CLUSTERED INDEX PI_EDW_RewardUserDetail ON dbo.
                    DIM_EDW_RewardUserDetail
                    (
                    UserGUID ASC ,
                    AccountID ASC ,
                    AccountCD ASC ,
                    SiteGUID ASC ,
                    HFitUserMpiNumber ASC ,
                    RewardActivityGUID ASC ,
                    RewardTriggerGUID ASC
                    )WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF ,
                    DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

                    CREATE NONCLUSTERED INDEX PI_EDW_RewardUserDetail_RowNbrCDate ON dbo.
                    DIM_EDW_RewardUserDetail
                    (
                    RowNbr , LastModifiedDate , DeletedFlg
                    )WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF ,
                    DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

                    PRINT 'ALL Records reloaded successfully';
                    EXEC proc_EDW_ChangeGmtToCentralTime 'DIM_EDW_RewardUserDetail';

                    EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @iCnt2;
                    EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'T' , @iCnt2;

                    SET NOCOUNT OFF;

                    RETURN;
                END;
        END;

    PRINT 'RELOADING Changes Only';
    IF EXISTS ( SELECT
                       name
                       FROM tempdb.dbo.sysobjects
                       WHERE id = OBJECT_ID ( N'tempdb..##Temp_RewardUserDetail')) 
        BEGIN
            PRINT 'Dropping ##Temp_RewardUserDetail';
            DROP TABLE
                 ##Temp_RewardUserDetail;
        END;

if @iChanges = 1
begin
    print 'Changes and NO DELETES Found, loading only changed data.';
    SELECT
           *
    INTO
         ##Temp_RewardUserDetail
           FROM view_EDW_RewardUserDetail_CT;
end ;
if @iChanges = 2
begin
    print 'DELETES Found, loading all data for compare.';
    declare @MySql as nvarchar(2000) = 'SELECT * INTO ##Temp_RewardUserDetail FROM view_EDW_RewardUserDetail_CT ' ; 
    exec (@MySql) ;
end ;

    DECLARE
    @iCnt AS int = @@ROWCOUNT;

    ALTER TABLE ##Temp_RewardUserDetail
    ADD
                LastModifiedDate datetime2 (7) NULL;
    ALTER TABLE ##Temp_RewardUserDetail
    ADD
                RowNbr int IDENTITY ( 1 , 1) ;

    ALTER TABLE ##Temp_RewardUserDetail
    ADD
                DeletedFlg bit NULL;

    ALTER TABLE ##Temp_RewardUserDetail
    ADD
                ConvertedToCentralTime bit NULL;

    ALTER TABLE ##Temp_RewardUserDetail
    ADD
                TimeZone nvarchar (10) NULL;

    CREATE CLUSTERED INDEX PI_TEMP_EDW_RewardUserDetail ON ##Temp_RewardUserDetail
    (
    UserGUID ASC ,
    AccountID ASC ,
    AccountCD ASC ,
    SiteGUID ASC ,
    HFitUserMpiNumber ASC ,
    RewardActivityGUID ASC ,
    RewardTriggerGUID ASC
    )WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF ,
    DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

    EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , @CT_NAME , @CT_DateTimeNow , @iCnt , 'U';
    EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'T' , @iCnt;

    --************************************************
    --get the NEW records and insert them
    --************************************************
    DECLARE
    @iIns AS int = 0;
    EXEC @iIns = proc_CT_RewardUserDetail_AddNewRecs ;
    PRINT 'INSERTED Count: ' + CAST ( @iIns AS nvarchar (50)) ;
    EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @iIns;

    --************************************************
    --get the changed records and update them
    --************************************************
    DECLARE
    @iUpdt AS int = 0;
    EXEC @iUpdt = proc_CT_RewardUserDetail_AddUpdatedRecs ;
    PRINT 'Records Updated: ' + CAST ( @iUpdt AS nvarchar (5)) ;
    EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'U' , @iUpdt;

/*---------------------------------------------
***********************************************
    FIND DELETED ROWS
***********************************************
*/
    DECLARE
    @iDel AS int = 0;
    EXEC @iDel = proc_CT_RewardUserDetail_AddDeletedRecs ;
    PRINT 'Records Marked As Deleted: ' + CAST ( @iDel AS nvarchar (50)) ;

    EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'D' , @iDel;
    EXEC proc_EDW_ChangeGmtToCentralTime 'DIM_EDW_RewardUserDetail';

    SET NOCOUNT OFF;

END;

GO
PRINT 'Created proc_EDW_RewardUserDetail';
PRINT GETDATE () ;

--select top 100 * from DIM_EDW_RewardUserDetail

GO
PRINT 'CREATED proc_EDW_RewardUserDetail';
PRINT GETDATE () ;
GO
