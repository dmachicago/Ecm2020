

/*
Developer  : W. Dale Miller
05.28.2015 : WDM - completed unit testing
*/

GO
PRINT 'FROM proc_STAGING_EDW_CoachingDefinition.SQL';
PRINT 'Creating proc_STAGING_EDW_CoachingDefinition';
GO
IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_STAGING_EDW_CoachingDefinition' )
    BEGIN
        PRINT 'Replacing proc_STAGING_EDW_CoachingDefinition proc';
        DROP PROCEDURE
             proc_STAGING_EDW_CoachingDefinition;
    END;
GO

/*
exec proc_STAGING_EDW_CoachingDefinition 1,1,0
exec proc_STAGING_EDW_CoachingDefinition 1,1,1
exec proc_STAGING_EDW_CoachingDefinition 1,0,1

exec proc_STAGING_EDW_CoachingDefinition 0,1,0
exec proc_STAGING_EDW_CoachingDefinition 0,1,1
exec proc_STAGING_EDW_CoachingDefinition 0,0,1
*/

CREATE PROCEDURE proc_STAGING_EDW_CoachingDefinition
@Reloadall int = 0
, @TrackProgress int = 0
, @KeepData AS bit = 0
AS
BEGIN


    DECLARE
       @iTotal AS bigint = 0;

    EXEC @iTotal = proc_QuickRowCount 'STAGING_EDW_CoachingDefinition';

    IF @iTotal = 1
        BEGIN
            SET @Reloadall = 1;
        END;

    DECLARE
       @Synchronization_Version bigint = 0
       ,@CurrentDbVersion AS int
       ,@STime AS datetime
       ,@TgtView AS nvarchar ( 100 ) = 'view_EDW_CoachingDefinition_CT'
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
    EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_STAGING_EDW_CoachingDefinition' , @STime , 0 , 'I';

    IF @Reloadall = 1
        BEGIN
            IF EXISTS ( SELECT
                               NAME
                          FROM sys.tables
                          WHERE name = 'STAGING_EDW_CoachingDefinition' )
                BEGIN
                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'Dropping STAGING_EDW_CoachingDefinition for FULL reload.';
                        END;
                    --*******************************	 
                    --** DROP THE TABLE AND RECREATE
                    --*******************************
                    DROP TABLE
                         STAGING_EDW_CoachingDefinition;
                END;
            ELSE
                BEGIN
                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'Reloading STAGING_EDW_CoachingDefinition.';
                        END;
                END;
            IF @TrackProgress = 1
                BEGIN
                    PRINT 'Standby, performing initial load of the HA definitions - this could take a couple of hours, Started at: ' + CAST ( GETDATE ( ) AS nvarchar ( 50 ));
                END;

            IF @Reloadall = 1
                BEGIN

                    PRINT 'RELOADING ALL EDW HA Data.';

                    SELECT
                           * INTO
                                  STAGING_EDW_CoachingDefinition
                      FROM view_EDW_CoachingDefinition_CT;

                    EXEC proc_Add_EDW_CT_StdCols 'STAGING_EDW_CoachingDefinition';

                    IF @TrackProgress = 1
                        BEGIN
                            SET @iCnt = ( SELECT
                                                 COUNT ( * )
                                            FROM STAGING_EDW_CoachingDefinition );
                            PRINT DB_NAME ( ) + ' - Completed FULL RELOAD at: ' + CAST ( GETDATE ( ) AS nvarchar ( 50 )) + ' , loaded ' + CAST ( @iCnt AS nvarchar ( 50 )) + ' records.';
                        END;

                    SET @CNT_PulledRecords = ( SELECT
                                                      COUNT ( * )
                                                 FROM STAGING_EDW_CoachingDefinition );
                    SET @CNT_StagingTable = @CNT_PulledRecords;
                    IF NOT EXISTS ( SELECT
                                           name
                                      FROM sys.indexes
                                      WHERE name = 'PI_Staging_EDW_CoachingDefinition_IDs' )
                        BEGIN
                            IF @TrackProgress = 1
                                BEGIN
                                    PRINT 'Adding INDEX PI_Staging_EDW_CoachingDefinition_IDs at: ' + CAST ( GETDATE ( ) AS nvarchar ( 50 ));
                                END;
                            CREATE CLUSTERED INDEX PI_Staging_EDW_CoachingDefinition_IDs ON dbo.STAGING_EDW_CoachingDefinition ( GoalID , DocumentGuid , NodeSiteID , SiteGUID ) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON );
                        END;

                    SET @ExtractionDate = GETDATE ( );
                    SET @ExtractedVersion = -1;
                    SET @ExtractedRowCnt = ( SELECT
                                                    COUNT ( * )
                                               FROM STAGING_EDW_CoachingDefinition );
                    --SET @TgtView = 'view_EDW_CoachingDefinition';
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
                    EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @@ROWCOUNT;
                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'Completed , RELOAD at: ' + CAST ( GETDATE ( ) AS nvarchar ( 50 ));
                        END;

                END;
            -- SELECT * INTO [STAGING_EDW_CoachingDefinition] FROM [view_EDW_CoachingDefinition_CT];
            IF @TrackProgress = 1
                BEGIN
                    PRINT 'Completed , reloading at: ' + CAST ( GETDATE ( ) AS nvarchar ( 50 ));
                END;

            IF @TrackProgress = 1
                BEGIN
                    PRINT 'Completed FULL RELOAD at: ' + CAST ( GETDATE ( ) AS nvarchar ( 50 ));
                END;

            EXEC proc_EDW_ChangeGmtToCentralTime 'STAGING_EDW_CoachingDefinition';
            SET @STime = GETDATE ( );
            EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_STAGING_EDW_CoachingDefinition' , @STime , @CNT_PulledRecords , 'U';

            RETURN;
        END;

    IF NOT EXISTS ( SELECT
                           NAME
                      FROM sys.tables
                      WHERE name = 'STAGING_EDW_CoachingDefinition' )
        BEGIN
            PRINT '****************************************************************************';
            PRINT 'FATAL ERROR: table STAGING_EDW_CoachingDefinition was NOT found, aborting.';
            PRINT '****************************************************************************';
        END;
    ELSE
        BEGIN
            IF NOT EXISTS ( SELECT
                                   name
                              FROM sys.indexes
                              WHERE name = 'PI_Staging_EDW_CoachingDefinition_IDs' )
                BEGIN

                    PRINT 'Adding INDEX PI_Staging_EDW_CoachingDefinition_IDs';

                    CREATE CLUSTERED INDEX PI_Staging_EDW_CoachingDefinition_IDs ON dbo.STAGING_EDW_CoachingDefinition ( GoalID , DocumentGuid , NodeSiteID , SiteGUID ) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON );
                END;

            --The staging table exists, CHANGES will be determined and applied.

            IF EXISTS ( SELECT
                               name
                          FROM tempdb.dbo.sysobjects
                          WHERE id = OBJECT_ID ( N'tempdb..##TEMP_STAGING_EDW_CoachingDefinition_DATA' ))

                BEGIN
                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'Dropping ##TEMP_STAGING_EDW_CoachingDefinition_DATA';
                        END;
                    DROP TABLE
                         ##TEMP_STAGING_EDW_CoachingDefinition_DATA;
                END;

            /*******************************************************************************/

            SELECT
                   * INTO
                          ##TEMP_STAGING_EDW_CoachingDefinition_DATA
              FROM view_EDW_CoachingDefinition_CT;
            --WHERE CHANGED_FLG IS NOT NULL;

            ALTER TABLE ##TEMP_STAGING_EDW_CoachingDefinition_DATA
            ADD
                        LastModifiedDate datetime NULL;
            ALTER TABLE ##TEMP_STAGING_EDW_CoachingDefinition_DATA
            ADD
                        RowNbr int NULL;
            ALTER TABLE ##TEMP_STAGING_EDW_CoachingDefinition_DATA
            ADD
                        DeletedFlg bit NULL;

            CREATE CLUSTERED INDEX temp_PI_Staging_EDW_CoachingDefinition_IDs ON dbo.##TEMP_STAGING_EDW_CoachingDefinition_DATA ( GoalID , DocumentGuid , NodeSiteID , SiteGUID ) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON );

            IF @KeepData = 1
                BEGIN
                    PRINT 'KEEPING TEMP DATA IN TABLE TEMP_STAGING_EDW_CoachingDefinition_DATA';
                    IF EXISTS ( SELECT
                                       name
                                  FROM sys.tables
                                  WHERE name = 'TEMP_STAGING_EDW_CoachingDefinition_DATA' )
                        BEGIN
                            DROP TABLE
                                 TEMP_STAGING_EDW_CoachingDefinition_DATA;
                        END;

                    SELECT
                           * INTO
                                  TEMP_STAGING_EDW_CoachingDefinition_DATA
                      FROM ##TEMP_STAGING_EDW_CoachingDefinition_DATA;

                    CREATE CLUSTERED INDEX temp_PI_Staging_EDW_CoachingDefinition_IDs ON TEMP_STAGING_EDW_CoachingDefinition_DATA ( GoalID , DocumentGuid , NodeSiteID , SiteGUID ) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON );

                END;

            SET @CNT_PulledRecords = ( SELECT
                                              COUNT ( * )
                                         FROM ##TEMP_STAGING_EDW_CoachingDefinition_DATA );

            --select * from ##TEMP_STAGING_EDW_CoachingDefinition_DATA
            --update ##TEMP_STAGING_EDW_CoachingDefinition_DATA set AnsDocumentGuid = '1B8A2611-B0BF-4555-B609-56CC7D4EFC38' where AnsDocumentGuid = '001FBF56-C327-490F-AA15-4EB6F595D47A' and AnsPOints = 15
            --update ##TEMP_STAGING_EDW_CoachingDefinition_DATA set AnsDocumentGuid = newid() where AnsDocumentGuid = 'C1D9949E-786D-42F7-8E31-0619D8ED60BD' and AnsPOints = 0
            DECLARE
               @iIns AS int = @@ROWCOUNT;
		  exec @iIns = proc_CT_CoachingDefinition_AddNewRecs ;

            PRINT 'Insert Count: ' + CAST ( @iIns AS nvarchar ( 50 ));

            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @iIns;

		  --***************************************
		  --*** Apply Updates
            DECLARE @iUpdt AS int = 0;
		  exec @iUpdt = proc_CT_CoachingDefinition_AddUpdatedRecs ;
            PRINT 'Updated Count: ' + CAST ( @iUpdt AS nvarchar ( 50 ));

                    EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'U' , @iUpdt;
                END;

		  --************************************************
		  -- FIND DELETED ROWS
            DECLARE @iDel AS int = 0;
		  exec @iDel = proc_CT_CoachingDefinition_AddDeletedRecs ;

            PRINT 'Deleted Count: ' + CAST ( @iUpdt AS nvarchar ( 50 ));
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'D' , @iDel;

            SET @CNT_StagingTable = ( SELECT
                                             COUNT ( * )
                                        FROM STAGING_EDW_CoachingDefinition );
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
                                         FROM ##TEMP_STAGING_EDW_CoachingDefinition_DATA );

            EXEC proc_EDW_ChangeGmtToCentralTime 'STAGING_EDW_CoachingDefinition';
            SET @STime = GETDATE ( );
            EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_STAGING_EDW_CoachingDefinition' , @STime , @CNT_PulledRecords , 'U';

        END;

GO
PRINT 'Created proc_STAGING_EDW_CoachingDefinition';
GO 
