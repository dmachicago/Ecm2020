
/*
Developer  : W. Dale Miller
05.28.2015 : WDM - completed unit testing
*/

GO
PRINT 'FROM proc_EDW_Coaches.SQL';
PRINT 'Creating proc_EDW_Coaches';
GO
IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE
              name = 'proc_EDW_Coaches' )
    BEGIN
        PRINT 'Replacing proc_EDW_Coaches proc';
        DROP PROCEDURE
             proc_EDW_Coaches;
    END;
GO

/*
exec proc_EDW_Coaches 1,1,0
exec proc_EDW_Coaches 1,1,1
exec proc_EDW_Coaches 1,0,1

exec proc_EDW_Coaches 0,1,0
exec proc_EDW_Coaches 0,1,1
exec proc_EDW_Coaches 0,0,1
*/

CREATE PROCEDURE proc_EDW_Coaches
@Reloadall int = 0
, @TrackProgress int = 0
, @KeepData AS bit = 0
AS
BEGIN
set nocount on ;
    DECLARE
       @iTotal AS bigint = 0;

    EXEC @iTotal = proc_QuickRowCount 'DIM_EDW_Coaches';

    IF @iTotal = 1
        BEGIN
            SET @Reloadall = 1;
        END;

    DECLARE
       @Synchronization_Version bigint = 0
       ,@CurrentDbVersion AS int
       ,@STime AS datetime
       ,@TgtView AS nvarchar ( 100 ) = 'view_EDW_Coaches_CT'
       ,@ExtractionDate AS datetime
       ,@ExtractedVersion AS int
       ,@ExtractedRowCnt AS int
       ,@EndTime AS datetime
       ,@CNT_PulledRecords AS int = 0
       ,@iCnt AS int = 0
       ,@RowNbr AS int = 0
       ,@StartTime AS datetime = GETDATE ( )
       ,@SVRName AS nvarchar ( 100 )
       ,@DBName AS nvarchar ( 100 ) = DB_NAME ( )
       ,@CNT_Insert AS int = 0
       ,@CNT_Update AS int = 0
       ,@CNT_Delete AS int = 0
       ,@CNT_StagingTable int = 0
       ,@VersionNBR int = 0;

    SET @SVRName = ( SELECT
                            @@SERVERNAME );

    SET @STime = GETDATE ( );

    DECLARE
       @RecordID AS uniqueidentifier = NEWID ( );
    EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_EDW_Coaches' , @STime , 0 , 'I';

    IF @Reloadall = 1
        BEGIN
            IF EXISTS ( SELECT
                               NAME
                          FROM sys.tables
                          WHERE
                          name = 'DIM_EDW_Coaches' )
                BEGIN
                    IF
                    @TrackProgress = 1
                        BEGIN
                            PRINT 'Dropping DIM_EDW_Coaches for FULL reload.';
                        END;
                    --*******************************	 
                    --** DROP THE TABLE AND RECREATE
                    --*******************************
                    DROP TABLE
                         DIM_EDW_Coaches;
                END;
            ELSE
                BEGIN
                    IF
                    @TrackProgress = 1
                        BEGIN
                            PRINT 'Reloading DIM_EDW_Coaches.';
                        END;
                END;
            IF
            @TrackProgress = 1
                BEGIN
                    PRINT 'Standby, performing initial load of the HA definitions - this could take a couple of hours, Started at: ' + CAST ( GETDATE ( ) AS nvarchar ( 50 ));
                END;

            IF @Reloadall = 1
                BEGIN

                    PRINT 'RELOADING ALL Coaches.';

                    SELECT
                           * INTO
                                  DIM_EDW_Coaches
                      FROM view_EDW_Coaches_CT;

                    EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_Coaches';

                    IF
                    @TrackProgress = 1
                        BEGIN
                            SET @iCnt = ( SELECT
                                                 COUNT ( * )
                                            FROM DIM_EDW_Coaches );
                            PRINT DB_NAME ( ) + ' - Completed FULL RELOAD at: ' + CAST ( GETDATE ( ) AS nvarchar ( 50 )) + ' , loaded ' + CAST ( @iCnt AS nvarchar ( 50 )) + ' records.';
                        END;

                    SET @CNT_PulledRecords = ( SELECT
                                                      COUNT ( * )
                                                 FROM DIM_EDW_Coaches );
                    SET @CNT_StagingTable = @CNT_PulledRecords;
                    IF NOT EXISTS ( SELECT
                                           name
                                      FROM sys.indexes
                                      WHERE
                                      name = 'PI_EDW_Coaches_IDs' )
                        BEGIN
                            IF
                            @TrackProgress = 1
                                BEGIN
                                    PRINT 'Adding INDEX PI_EDW_Coaches_IDs at: ' + CAST ( GETDATE ( ) AS nvarchar ( 50 ));
                                END;
                            CREATE CLUSTERED INDEX PI_EDW_Coaches_IDs ON dbo.DIM_EDW_Coaches (
                            UserGUID
                            , SiteGUID
                            , AccountID
                            , AccountCD
                            , CoachID
                            , email
                            )
                            WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON );
                        END;

                    SET @ExtractionDate = GETDATE ( );
                    SET @ExtractedVersion = -1;
                    SET @ExtractedRowCnt = ( SELECT
                                                    COUNT ( * )
                                               FROM DIM_EDW_Coaches );
                    --SET @TgtView = 'view_EDW_Coaches';
                    SET @EndTime = GETDATE ( );

                    INSERT INTO CT_VersionTracking (
                           ExtractionDate
                           ,ExtractedVersion
                           ,CurrentDbVersion
                           ,ExtractedRowCnt
                           ,TgtView
                           ,StartTime
                           ,EndTime
                           ,SVRName
                           ,DBName
                           ,CNT_Insert
                           ,CNT_Update
                           ,CNT_delete
                           ,CNT_PulledRecords
                           ,CNT_StagingTable
                    )
                    VALUES
                    (
                    @ExtractionDate ,
                    @ExtractedVersion ,
                    @CurrentDbVersion ,
                    @ExtractedRowCnt ,
                    @TgtView ,
                    @StartTime ,
                    @EndTime ,
                    @SVRName ,
                    @DBName ,
                    @CNT_Insert ,
                    @CNT_Update ,
                    @CNT_delete ,
                    @CNT_PulledRecords ,
                    @CNT_StagingTable );

                    EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @@ROWCOUNT;

                    IF
                    @TrackProgress = 1
                        BEGIN
                            PRINT 'Completed , RELOAD at: ' + CAST ( GETDATE ( ) AS nvarchar ( 50 ));
                        END;

                END;
            -- SELECT * INTO [DIM_EDW_Coaches] FROM [view_EDW_Coaches_CT];
            IF
            @TrackProgress = 1
                BEGIN
                    PRINT 'Completed , reloading at: ' + CAST ( GETDATE ( ) AS nvarchar ( 50 ));
                END;

            IF
            @TrackProgress = 1
                BEGIN
                    PRINT
                    'Completed FULL RELOAD at: ' + CAST ( GETDATE ( ) AS nvarchar ( 50 ));
                END;

            EXEC proc_EDW_ChangeGmtToCentralTime 'DIM_EDW_Coaches';
            SET @STime = GETDATE ( );
            EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_EDW_Coaches' , @STime , @CNT_PulledRecords , 'U';
	   set nocount off ;
            RETURN;
        END;

    IF NOT EXISTS ( SELECT
                           NAME
                      FROM sys.tables
                      WHERE
                      name = 'DIM_EDW_Coaches' )
        BEGIN
            PRINT '****************************************************************************';
            PRINT 'FATAL ERROR: table DIM_EDW_Coaches was NOT found, aborting.';
            PRINT '****************************************************************************';
        END;
    ELSE
        BEGIN

            --IF NOT EXISTS ( SELECT
            --                name
            --                  FROM sys.indexes
            --                  WHERE name = 'PI_EDW_Coaches_IDs') 
            --    BEGIN
            --        IF @TrackProgress = 1
            --            BEGIN
            --                PRINT 'Adding INDEX PI_EDW_Coaches_IDs';
            --            END;
            --        CREATE NONCLUSTERED INDEX PI_EDW_Coaches_IDs ON dbo.DIM_EDW_Coaches ( ItemCreatedWhen ASC , ItemModifiedWhen ASC , HARiskCategory_ItemModifiedWhen ASC , HAUserRiskArea_ItemModifiedWhen ASC , HAUserQuestion_ItemModifiedWhen ASC , HAUserAnswers_ItemModifiedWhen ASC) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
            --    END;

            IF NOT EXISTS ( SELECT
                                   name
                              FROM sys.indexes
                              WHERE
                              name = 'PI_EDW_Coaches_IDs' )
                BEGIN

                    PRINT 'Adding INDEX PI_EDW_Coaches_IDs';

                    CREATE CLUSTERED INDEX PI_EDW_Coaches_IDs ON dbo.DIM_EDW_Coaches (
                    UserGUID
                    , SiteGUID
                    , AccountID
                    , AccountCD
                    , CoachID
                    , email )
                    WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON );
                END;

            --The staging table exists, CHANGES will be determined and applied.

            IF EXISTS ( SELECT
                               name
                          FROM tempdb.dbo.sysobjects
                          WHERE
                          id = OBJECT_ID ( N'tempdb..##DIM_TEMPTBL_EDW_Coaches_DATA' ))

                BEGIN
                    IF
                    @TrackProgress = 1
                        BEGIN
                            PRINT 'Dropping ##DIM_TEMPTBL_EDW_Coaches_DATA';
                        END;
                    DROP TABLE
                         ##DIM_TEMPTBL_EDW_Coaches_DATA;
                END;

            /*******************************************************************************/

            SELECT
                   * INTO
                          ##DIM_TEMPTBL_EDW_Coaches_DATA
              FROM view_EDW_Coaches_CT;
            --WHERE CHANGED_FLG IS NOT NULL;

            ALTER TABLE ##DIM_TEMPTBL_EDW_Coaches_DATA
            ADD
                        LastModifiedDate datetime NULL;
            ALTER TABLE ##DIM_TEMPTBL_EDW_Coaches_DATA
            ADD
                        RowNbr  int NULL;
            ALTER TABLE ##DIM_TEMPTBL_EDW_Coaches_DATA
            ADD
                        DeletedFlg  bit NULL;

            CREATE CLUSTERED INDEX temp_PI_EDW_Coaches_IDs ON dbo.##DIM_TEMPTBL_EDW_Coaches_DATA (
            UserGUID
            , SiteGUID
            , AccountID
            , AccountCD
            , CoachID
            , email )
            WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON );

            IF @KeepData = 1
                BEGIN
                    PRINT 'KEEPING TEMP DATA IN TABLE DIM_TEMPTBL_EDW_Coaches_DATA';
                    IF EXISTS ( SELECT
                                       name
                                  FROM sys.tables
                                  WHERE
                                  name = 'DIM_TEMPTBL_EDW_Coaches_DATA' )
                        BEGIN
                            DROP TABLE
                                 DIM_TEMPTBL_EDW_Coaches_DATA;
                        END;

                    SELECT
                           * INTO
                                  DIM_TEMPTBL_EDW_Coaches_DATA
                      FROM ##DIM_TEMPTBL_EDW_Coaches_DATA;

                    CREATE CLUSTERED INDEX temp_PI_EDW_Coaches_IDs ON DIM_TEMPTBL_EDW_Coaches_DATA (
                    UserGUID
                    , SiteGUID
                    , AccountID
                    , AccountCD
                    , CoachID
                    , email )
                    WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON );

                END;

            SET @CNT_PulledRecords = ( SELECT
                                              COUNT ( * )
                                         FROM ##DIM_TEMPTBL_EDW_Coaches_DATA );

/************************************************/
declare @iInserts as int = 0 ;
exec @iInserts = proc_CT_Coaching_AddNewRecs ;
EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @iInserts;
/************************************************/
declare @iUpdates as int = 0 
exec @iUpdates = proc_CT_Coaching_AddUpdatedRecs ;
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'U' , @iUpdates;
/************************************************/
declare @idels as int = 0 ;
exec @iUpdates = proc_CT_Coaching_AddDeletedRecs ;
/************************************************/

            SET @CNT_StagingTable = ( SELECT
                                             COUNT ( * )
                                        FROM DIM_EDW_Coaches );
            UPDATE CT_VersionTracking
              SET
                  CNT_PulledRecords = @iCnt
              WHERE
                    RowNbr = @RowNbr;

            UPDATE CT_VersionTracking
              SET
                  CNT_StagingTable = @CNT_StagingTable
              WHERE
                    RowNbr = @RowNbr;

            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'D' , @idels;
            SET @CNT_PulledRecords = ( SELECT
                                              COUNT ( * )
                                         FROM ##DIM_TEMPTBL_EDW_Coaches_DATA );

            EXEC proc_EDW_ChangeGmtToCentralTime 'DIM_EDW_Coaches';
            SET @STime = GETDATE ( );
            EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_EDW_Coaches' , @STime , @CNT_PulledRecords , 'U';
set nocount off ;
        END;
END;

GO
PRINT 'Created proc_EDW_Coaches';
GO 
