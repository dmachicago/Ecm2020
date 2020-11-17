
go
-- use KenticoCMS_Prod1

/*
Developer  : W. Dale Miller
05.28.2015 : WDM - completed unit testing
*/

GO
PRINT 'FROM proc_EDW_RewardsDefinition.SQL';
PRINT 'Creating proc_EDW_RewardsDefinition';
GO
IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_EDW_RewardsDefinition' )
    BEGIN
        PRINT 'Replacing proc_EDW_RewardsDefinition proc';
        DROP PROCEDURE
             proc_EDW_RewardsDefinition;
    END;
GO

/*
exec proc_EDW_RewardsDefinition 1,1,0
exec proc_EDW_RewardsDefinition 1,1,1
exec proc_EDW_RewardsDefinition 1,0,1

exec proc_EDW_RewardsDefinition 0,1,0
exec proc_EDW_RewardsDefinition 0,1,1
exec proc_EDW_RewardsDefinition 0,0,1
*/

CREATE PROCEDURE proc_EDW_RewardsDefinition
@Reloadall int = 0
, @TrackProgress int = 0
, @KeepData AS bit = 0
AS
BEGIN

    DECLARE
       @iTotal AS bigint = 0;

    EXEC @iTotal = proc_QuickRowCount 'DIM_EDW_RewardsDefinition';

    IF @iTotal = 1
        BEGIN
            SET @Reloadall = 1;
        END;


    DECLARE
       @Synchronization_Version bigint = 0
       ,@CurrentDbVersion AS int
       ,@STime AS datetime
       ,@TgtView AS nvarchar ( 100 ) = 'view_EDW_RewardsDefinition_CT'
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
    EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_EDW_RewardsDefinition' , @STime , 0 , 'I';

    IF @Reloadall = 1
        BEGIN
            IF EXISTS ( SELECT
                               NAME
                          FROM sys.tables
                          WHERE name = 'DIM_EDW_RewardsDefinition' )
                BEGIN
                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'Dropping DIM_EDW_RewardsDefinition for FULL reload.';
                        END;
                    --*******************************	 
                    --** DROP THE TABLE AND RECREATE
                    --*******************************
                    DROP TABLE
                         DIM_EDW_RewardsDefinition;
                END;
            ELSE
                BEGIN
                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'Reloading DIM_EDW_RewardsDefinition.';
                        END;
                END;
            IF @TrackProgress = 1
                BEGIN
                    PRINT 'Standby, performing initial load of the HA definitions - this could take a couple of hours, Started at: ' + CAST ( GETDATE ( ) AS nvarchar ( 50 ));
                END;

            IF @Reloadall = 1
                BEGIN

                    PRINT 'RELOADING ALL RewardsDefinition Data.';

                    SELECT
                           * INTO
                                  DIM_EDW_RewardsDefinition
                      FROM view_EDW_RewardsDefinition_CT;

                    EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_RewardsDefinition';

                    EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @@ROWCOUNT;

                    IF @TrackProgress = 1
                        BEGIN
                            SET @iCnt = ( SELECT
                                                 COUNT ( * )
                                            FROM DIM_EDW_RewardsDefinition );
                            PRINT DB_NAME ( ) + ' - Completed FULL RELOAD at: ' + CAST ( GETDATE ( ) AS nvarchar ( 50 )) + ' , loaded ' + CAST ( @iCnt AS nvarchar ( 50 )) + ' records.';
                        END;

                    SET @CNT_PulledRecords = ( SELECT
                                                      COUNT ( * )
                                                 FROM DIM_EDW_RewardsDefinition );
                    SET @CNT_StagingTable = @CNT_PulledRecords;
                    IF NOT EXISTS ( SELECT
                                           name
                                      FROM sys.indexes
                                      WHERE name = 'PI_EDW_RewardsDefinition_IDs' )
                        BEGIN
                            IF @TrackProgress = 1
                                BEGIN
                                    PRINT 'Adding INDEX PI_EDW_RewardsDefinition_IDs at: ' + CAST ( GETDATE ( ) AS nvarchar ( 50 ));
                                END;
                            CREATE CLUSTERED INDEX PI_EDW_RewardsDefinition_IDs ON dbo.DIM_EDW_RewardsDefinition ( SiteGUID , AccountID , AccountCD , RewardProgramGUID , RewardGroupGuid , RewardLevelGuid , RewardActivityGuid , RewardTriggerGuid , RewardTriggerParmGUID ) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON );
                        END;

                    SET @ExtractionDate = GETDATE ( );
                    SET @ExtractedVersion = -1;
                    SET @ExtractedRowCnt = ( SELECT
                                                    COUNT ( * )
                                               FROM DIM_EDW_RewardsDefinition );
                    --SET @TgtView = 'view_EDW_RewardsDefinition';
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
                           ,CNT_StagingTable )
                    VALUES
                    (
                    @ExtractionDate , @ExtractedVersion , @CurrentDbVersion , @ExtractedRowCnt , @TgtView , @StartTime , @EndTime , @SVRName , @DBName , @CNT_Insert , @CNT_Update , @CNT_delete , @CNT_PulledRecords , @CNT_StagingTable );

                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'Completed , RELOAD at: ' + CAST ( GETDATE ( ) AS nvarchar ( 50 ));
                        END;

                END;
            -- SELECT * INTO [DIM_EDW_RewardsDefinition] FROM [view_EDW_RewardsDefinition_CT];
            IF @TrackProgress = 1
                BEGIN
                    PRINT 'Completed , reloading at: ' + CAST ( GETDATE ( ) AS nvarchar ( 50 ));
                END;

            IF @TrackProgress = 1
                BEGIN
                    PRINT 'Completed FULL RELOAD at: ' + CAST ( GETDATE ( ) AS nvarchar ( 50 ));
                END;

            SET @STime = GETDATE ( );

            EXEC proc_EDW_ChangeGmtToCentralTime 'DIM_EDW_RewardsDefinition';

            EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_EDW_RewardsDefinition' , @STime , @CNT_PulledRecords , 'U';
            RETURN;
        END;

    IF NOT EXISTS ( SELECT
                           NAME
                      FROM sys.tables
                      WHERE name = 'DIM_EDW_RewardsDefinition' )
        BEGIN
            PRINT '****************************************************************************';
            PRINT 'FATAL ERROR: table DIM_EDW_RewardsDefinition was NOT found, aborting.';
            PRINT '****************************************************************************';
        END;
    ELSE
        BEGIN
            IF NOT EXISTS ( SELECT
                                   name
                              FROM sys.indexes
                              WHERE name = 'PI_EDW_RewardsDefinition_IDs' )
                BEGIN

                    PRINT 'Adding INDEX PI_EDW_RewardsDefinition_IDs';

                    CREATE CLUSTERED INDEX PI_EDW_RewardsDefinition_IDs ON dbo.DIM_EDW_RewardsDefinition ( SiteGUID , AccountID , AccountCD , RewardProgramGUID , RewardGroupGuid , RewardLevelGuid , RewardActivityGuid , RewardTriggerGuid , RewardTriggerParmGUID ) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON );
                END;

            --The staging table exists, CHANGES will be determined and applied.

            IF EXISTS ( SELECT
                               name
                          FROM tempdb.dbo.sysobjects
                          WHERE id = OBJECT_ID ( N'tempdb..##TEMP_EDW_RewardsDefinition_DATA' ))

                BEGIN
                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'Dropping ##TEMP_EDW_RewardsDefinition_DATA';
                        END;
                    DROP TABLE
                         ##TEMP_EDW_RewardsDefinition_DATA;
                END;

            /*******************************************************************************/

            SELECT
                   * INTO
                          ##TEMP_EDW_RewardsDefinition_DATA
              FROM view_EDW_RewardsDefinition_CT;
            --WHERE CHANGED_FLG IS NOT NULL;

		  EXEC proc_Add_EDW_CT_StdCols '##TEMP_EDW_RewardsDefinition_DATA';

            CREATE CLUSTERED INDEX temp_PI_EDW_RewardsDefinition_IDs ON dbo.##TEMP_EDW_RewardsDefinition_DATA ( SiteGUID , AccountID , AccountCD , RewardProgramGUID , RewardGroupGuid , RewardLevelGuid , RewardActivityGuid , RewardTriggerGuid , RewardTriggerParmGUID ) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON );

            IF @KeepData = 1
                BEGIN
                    PRINT 'KEEPING TEMP DATA IN TABLE TEMP_EDW_RewardsDefinition_DATA';
                    IF EXISTS ( SELECT
                                       name
                                  FROM sys.tables
                                  WHERE name = 'TEMP_EDW_RewardsDefinition_DATA' )
                        BEGIN
                            DROP TABLE
                                 TEMP_EDW_RewardsDefinition_DATA;
                        END;

                    SELECT
                           * INTO
                                  TEMP_EDW_RewardsDefinition_DATA
                      FROM ##TEMP_EDW_RewardsDefinition_DATA;

                    CREATE CLUSTERED INDEX temp_PI_EDW_RewardsDefinition_IDs ON TEMP_EDW_RewardsDefinition_DATA ( SiteGUID , AccountID , AccountCD , RewardProgramGUID , RewardGroupGuid , RewardLevelGuid , RewardActivityGuid , RewardTriggerGuid , RewardTriggerParmGUID ) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON );

                END;

            SET @CNT_PulledRecords = ( SELECT
                                              COUNT ( * )
                                         FROM ##TEMP_EDW_RewardsDefinition_DATA );

            --select * from ##TEMP_EDW_RewardsDefinition_DATA
            --update ##TEMP_EDW_RewardsDefinition_DATA set AnsDocumentGuid = '1B8A2611-B0BF-4555-B609-56CC7D4EFC38' where AnsDocumentGuid = '001FBF56-C327-490F-AA15-4EB6F595D47A' and AnsPOints = 15
            --update ##TEMP_EDW_RewardsDefinition_DATA set AnsDocumentGuid = newid() where AnsDocumentGuid = 'C1D9949E-786D-42F7-8E31-0619D8ED60BD' and AnsPOints = 0
		  --*********************************************************
		  -- ADD NEW RECORDS
		  --*********************************************************
            DECLARE
               @iIns AS int = 0;
		  exec @iIns = proc_CT_RewardsDefinition_AddNewRecs ;
            PRINT 'Insert Count: ' + CAST ( @iIns AS nvarchar ( 50 ));
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @iIns;

            --*********************************************************
		  -- ADD UPDATED RECORDS
		  --*********************************************************            
                    DECLARE
                       @iUpdt AS int = 0;
		  exec @iUpdt = proc_CT_RewardsDefinition_AddUpdatedRecs;
                    PRINT 'Update Count: ' + CAST ( @iUpdt AS nvarchar ( 50 ));
                    EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'U' , @iUpdt;


		  --*********************************************************
		  -- FIND DELETED ROWS
		  --*********************************************************            
            DECLARE
               @idel AS int = 0;
		  exec @idel = proc_CT_RewardsDefinition_AddDeletedRecs ;
            PRINT 'Delete Count: ' + CAST ( @idel AS nvarchar ( 50 ));
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'D' , @idel;

            SET @CNT_StagingTable = ( SELECT
                                             COUNT ( * )
                                        FROM DIM_EDW_RewardsDefinition );
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

            SET @CNT_PulledRecords = ( SELECT
                                              COUNT ( * )
                                         FROM ##TEMP_EDW_RewardsDefinition_DATA );
            SET @STime = GETDATE ( );

            EXEC proc_EDW_ChangeGmtToCentralTime 'DIM_EDW_RewardsDefinition';
            EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_EDW_RewardsDefinition' , @STime , @CNT_PulledRecords , 'U';

        END;
END;

GO
PRINT 'Created proc_EDW_RewardsDefinition';
GO 
