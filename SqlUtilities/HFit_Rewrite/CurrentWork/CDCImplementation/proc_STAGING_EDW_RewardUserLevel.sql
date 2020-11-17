
/*
Developer  : W. Dale Miller
05.28.2015 : WDM - completed unit testing
*/

GO
PRINT 'FROM proc_EDW_RewardUserLevel.SQL';
PRINT 'Creating proc_EDW_RewardUserLevel';
GO
IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_EDW_RewardUserLevel' )
    BEGIN
        PRINT 'Replacing proc_EDW_RewardUserLevel proc';
        DROP PROCEDURE
             proc_EDW_RewardUserLevel;
    END;
GO

/*
exec proc_EDW_RewardUserLevel 1,1,0
exec proc_EDW_RewardUserLevel 1,1,1
exec proc_EDW_RewardUserLevel 1,0,1

exec proc_EDW_RewardUserLevel 0,1,0
exec proc_EDW_RewardUserLevel 0,1,1
exec proc_EDW_RewardUserLevel 0,0,1
*/

CREATE PROCEDURE proc_EDW_RewardUserLevel
@Reloadall int = 0
, @TrackProgress int = 0
, @KeepData AS bit = 0
AS
BEGIN


    DECLARE
       @iTotal AS bigint = 0;

    EXEC @iTotal = proc_QuickRowCount 'DIM_EDW_RewardUserLevel';

    IF @iTotal = 1
        BEGIN
            SET @Reloadall = 1;
        END;


    DECLARE
       @Synchronization_Version bigint = 0
       ,@CurrentDbVersion AS int
       ,@STime AS datetime
       ,@TgtView AS nvarchar ( 100 ) = 'view_EDW_RewardUserLevel_CT'
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
    EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_EDW_RewardUserLevel' , @STime , 0 , 'I';

    IF @Reloadall = 1
        BEGIN
            IF EXISTS ( SELECT
                               NAME
                          FROM sys.tables
                          WHERE name = 'DIM_EDW_RewardUserLevel' )
                BEGIN
                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'Dropping DIM_EDW_RewardUserLevel for FULL reload.';
                        END;
                    --*******************************	 
                    --** DROP THE TABLE AND RECREATE
                    --*******************************
                    DROP TABLE
                         DIM_EDW_RewardUserLevel;
                END;
            ELSE
                BEGIN
                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'Reloading DIM_EDW_RewardUserLevel.';
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
                                  DIM_EDW_RewardUserLevel
                      FROM view_EDW_RewardUserLevel_CT;

                    EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_RewardUserLevel';

                    IF @TrackProgress = 1
                        BEGIN
                            SET @iCnt = ( SELECT
                                                 COUNT ( * )
                                            FROM DIM_EDW_RewardUserLevel );
                            PRINT DB_NAME ( ) + ' - Completed FULL RELOAD at: ' + CAST ( GETDATE ( ) AS nvarchar ( 50 )) + ' , loaded ' + CAST ( @iCnt AS nvarchar ( 50 )) + ' records.';
                        END;

                    SET @CNT_PulledRecords = ( SELECT
                                                      COUNT ( * )
                                                 FROM DIM_EDW_RewardUserLevel );
                    EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @@ROWCOUNT;
                    SET @CNT_StagingTable = @CNT_PulledRecords;

                    IF NOT EXISTS ( SELECT
                                           name
                                      FROM sys.indexes
                                      WHERE name = 'PI_EDW_RewardUserLevel_IDs' )
                        BEGIN
                            IF @TrackProgress = 1
                                BEGIN
                                    PRINT 'Adding INDEX PI_EDW_RewardUserLevel_IDs at: ' + CAST ( GETDATE ( ) AS nvarchar ( 50 ));
                                END;
                            CREATE CLUSTERED INDEX PI_EDW_RewardUserLevel_IDs ON dbo.DIM_EDW_RewardUserLevel ( UserId , LevelCompletedDt , LevelName , SiteName , nodeguid , SiteGuid ) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON );
                        END;

                    SET @ExtractionDate = GETDATE ( );
                    SET @ExtractedVersion = -1;
                    SET @ExtractedRowCnt = ( SELECT
                                                    COUNT ( * )
                                               FROM DIM_EDW_RewardUserLevel );
                    --SET @TgtView = 'view_EDW_RewardUserLevel';
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
            -- SELECT * INTO [DIM_EDW_RewardUserLevel] FROM [view_EDW_RewardUserLevel_CT];
            IF @TrackProgress = 1
                BEGIN
                    PRINT 'Completed , reloading at: ' + CAST ( GETDATE ( ) AS nvarchar ( 50 ));
                END;

            IF @TrackProgress = 1
                BEGIN
                    PRINT 'Completed FULL RELOAD at: ' + CAST ( GETDATE ( ) AS nvarchar ( 50 ));
                END;

            EXEC proc_EDW_ChangeGmtToCentralTime 'DIM_EDW_RewardUserLevel';
            SET @STime = GETDATE ( );
            EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_EDW_RewardUserLevel' , @STime , @CNT_PulledRecords , 'U';
            RETURN;
        END;

    IF NOT EXISTS ( SELECT
                           NAME
                      FROM sys.tables
                      WHERE name = 'DIM_EDW_RewardUserLevel' )
        BEGIN
            PRINT '****************************************************************************';
            PRINT 'FATAL ERROR: table DIM_EDW_RewardUserLevel was NOT found, aborting.';
            PRINT '****************************************************************************';
        END;
    ELSE
        BEGIN

            --IF NOT EXISTS ( SELECT
            --                name
            --                  FROM sys.indexes
            --                  WHERE name = 'PI_EDW_RewardUserLevel_IDs') 
            --    BEGIN
            --        IF @TrackProgress = 1
            --            BEGIN
            --                PRINT 'Adding INDEX PI_EDW_RewardUserLevel_IDs';
            --            END;
            --        CREATE NONCLUSTERED INDEX PI_EDW_RewardUserLevel_IDs ON dbo.DIM_EDW_RewardUserLevel ( ItemCreatedWhen ASC , ItemModifiedWhen ASC , HARiskCategory_ItemModifiedWhen ASC , HAUserRiskArea_ItemModifiedWhen ASC , HAUserQuestion_ItemModifiedWhen ASC , HAUserAnswers_ItemModifiedWhen ASC) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
            --    END;

            IF NOT EXISTS ( SELECT
                                   name
                              FROM sys.indexes
                              WHERE name = 'PI_EDW_RewardUserLevel_IDs' )
                BEGIN

                    PRINT 'Adding INDEX PI_EDW_RewardUserLevel_IDs';

                    CREATE CLUSTERED INDEX PI_EDW_RewardUserLevel_IDs ON dbo.DIM_EDW_RewardUserLevel ( UserId , LevelCompletedDt , LevelName , SiteName , nodeguid , SiteGuid ) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON );
                END;

            --The staging table exists, CHANGES will be determined and applied.

            IF EXISTS ( SELECT
                               name
                          FROM tempdb.dbo.sysobjects
                          WHERE id = OBJECT_ID ( N'tempdb..#DIM_TEMPTBL_EDW_RewardUserLevel_DATA' ))

                BEGIN
                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'Dropping #DIM_TEMPTBL_EDW_RewardUserLevel_DATA';
                        END;
                    DROP TABLE
                         #DIM_TEMPTBL_EDW_RewardUserLevel_DATA;
                END;

            /*******************************************************************************/

            SELECT
                   * INTO
                          #DIM_TEMPTBL_EDW_RewardUserLevel_DATA
              FROM view_EDW_RewardUserLevel_CT;
            --WHERE CHANGED_FLG IS NOT NULL;

            ALTER TABLE #DIM_TEMPTBL_EDW_RewardUserLevel_DATA
            ADD
                        LastModifiedDate datetime NULL;
            ALTER TABLE #DIM_TEMPTBL_EDW_RewardUserLevel_DATA
            ADD
                        RowNbr int NULL;
            ALTER TABLE #DIM_TEMPTBL_EDW_RewardUserLevel_DATA
            ADD
                        DeletedFlg bit NULL;

            CREATE CLUSTERED INDEX temp_PI_EDW_RewardUserLevel_IDs ON dbo.#DIM_TEMPTBL_EDW_RewardUserLevel_DATA ( UserId , LevelCompletedDt , LevelName , SiteName , nodeguid , SiteGuid ) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON );

            IF @KeepData = 1
                BEGIN
                    PRINT 'KEEPING TEMP DATA IN TABLE DIM_TEMPTBL_EDW_RewardUserLevel_DATA';
                    IF EXISTS ( SELECT
                                       name
                                  FROM sys.tables
                                  WHERE name = 'DIM_TEMPTBL_EDW_RewardUserLevel_DATA' )
                        BEGIN
                            DROP TABLE
                                 DIM_TEMPTBL_EDW_RewardUserLevel_DATA;
                        END;

                    SELECT
                           * INTO
                                  DIM_TEMPTBL_EDW_RewardUserLevel_DATA
                      FROM #DIM_TEMPTBL_EDW_RewardUserLevel_DATA;

                    CREATE CLUSTERED INDEX temp_PI_EDW_RewardUserLevel_IDs ON DIM_TEMPTBL_EDW_RewardUserLevel_DATA ( UserId , LevelCompletedDt , LevelName , SiteName , nodeguid , SiteGuid ) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON );

                END;

            SET @CNT_PulledRecords = ( SELECT
                                              COUNT ( * )
                                         FROM #DIM_TEMPTBL_EDW_RewardUserLevel_DATA );

            --select * from #DIM_TEMPTBL_EDW_RewardUserLevel_DATA
            --update #DIM_TEMPTBL_EDW_RewardUserLevel_DATA set AnsDocumentGuid = '1B8A2611-B0BF-4555-B609-56CC7D4EFC38' where AnsDocumentGuid = '001FBF56-C327-490F-AA15-4EB6F595D47A' and AnsPOints = 15
            --update #DIM_TEMPTBL_EDW_RewardUserLevel_DATA set AnsDocumentGuid = newid() where AnsDocumentGuid = 'C1D9949E-786D-42F7-8E31-0619D8ED60BD' and AnsPOints = 0
            WITH CTE (
                 UserId
                 ,LevelCompletedDt
                 ,LevelName
                 ,SiteName
                 ,nodeguid
                 ,SiteGuid )
                AS ( SELECT
                            UserId
                            ,LevelCompletedDt
                            ,LevelName
                            ,SiteName
                            ,nodeguid
                            ,SiteGuid
                       FROM #DIM_TEMPTBL_EDW_RewardUserLevel_DATA
                     EXCEPT
                     SELECT
                            UserId
                            ,LevelCompletedDt
                            ,LevelName
                            ,SiteName
                            ,nodeguid
                            ,SiteGuid
                       FROM DIM_EDW_RewardUserLevel
                       WHERE LastModifiedDate IS NULL )
                INSERT INTO dbo.DIM_EDW_RewardUserLevel (
                       UserId
                       ,LevelCompletedDt
                       ,LevelName
                       ,SiteName
                       ,nodeguid
                       ,SiteGuid
                       ,LevelHeader
                       ,GroupHeadingText
                       ,GroupHeadingDescription
                       ,HashCode
                       ,LastModifiedDate
                       ,DeletedFlg )
                SELECT
                       T.UserId
                       ,T.LevelCompletedDt
                       ,T.LevelName
                       ,T.SiteName
                       ,T.nodeguid
                       ,T.SiteGuid
                       ,T.LevelHeader
                       ,T.GroupHeadingText
                       ,T.GroupHeadingDescription
                       ,T.HashCode
                       ,NULL AS LastModifiedDate
                       ,NULL AS DeletedFlg
                  FROM
                       #DIM_TEMPTBL_EDW_RewardUserLevel_DATA AS T JOIN CTE AS S
                       ON
                       S.UserId = T.UserId
                   AND S.LevelCompletedDt = T.LevelCompletedDt
                   AND S.LevelName = T.LevelName
                   AND S.SiteName = T.SiteName
                   AND S.nodeguid = T.nodeguid
                   AND S.SiteGuid = T.SiteGuid;

            DECLARE
               @iIns AS int = @@ROWCOUNT;
            PRINT 'Inset Count: ' + CAST ( @iIns AS nvarchar ( 50 ));
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @iIns;

            --Check to see if CURRENT records have differnet HASH codes and if so, update the staging table
            SET @iCnt = ( SELECT
                                 COUNT ( * )
                            FROM
                                 DIM_EDW_RewardUserLevel AS S JOIN #DIM_TEMPTBL_EDW_RewardUserLevel_DATA AS T
                                 ON
                                 S.UserId = T.UserId
                             AND S.LevelCompletedDt = T.LevelCompletedDt
                             AND S.LevelName = T.LevelName
                             AND S.SiteName = T.SiteName
                             AND S.nodeguid = T.nodeguid
                             AND S.SiteGuid = T.SiteGuid
                            WHERE S.HashCode != T.HashCode );
            IF @iCnt > 0
                BEGIN
                    UPDATE S
                      SET
                          S.UserId = T.UserId
                          ,S.LevelCompletedDt = T.LevelCompletedDt
                          ,S.LevelName = T.LevelName
                          ,S.SiteName = T.SiteName
                          ,S.nodeguid = T.nodeguid
                          ,S.SiteGuid = T.SiteGuid
                          ,S.LevelHeader = T.LevelHeader
                          ,S.GroupHeadingText = T.GroupHeadingText
                          ,S.GroupHeadingDescription = T.GroupHeadingDescription
                          ,S.HashCode = T.HashCode
                          ,S.LastModifiedDate = GETDATE ( )
                          ,S.DeletedFlg = NULL
                          ,S.ConvertedToCentralTime = NULL
                      FROM DIM_EDW_RewardUserLevel AS S JOIN #DIM_TEMPTBL_EDW_RewardUserLevel_DATA AS T
                           ON
                           S.UserId = T.UserId
                       AND S.LevelCompletedDt = T.LevelCompletedDt
                       AND S.LevelName = T.LevelName
                       AND S.SiteName = T.SiteName
                       AND S.nodeguid = T.nodeguid
                       AND S.SiteGuid = T.SiteGuid
                      WHERE
                            T.HashCode != S.HashCode;

                    DECLARE
                       @iUpdt AS int = @@ROWCOUNT;
                    PRINT 'Update Count: ' + CAST ( @iUpdt AS nvarchar ( 50 ));
                    EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'U' , @iUpdt;
                END;

/************************************************
		  FIND DELETED ROWS
		  ************************************************/

            WITH CTE (
                 UserId
                 ,LevelCompletedDt
                 ,LevelName
                 ,SiteName
                 ,nodeguid
                 ,SiteGuid )
                AS ( SELECT
                            UserId
                            ,LevelCompletedDt
                            ,LevelName
                            ,SiteName
                            ,nodeguid
                            ,SiteGuid
                       FROM DIM_EDW_RewardUserLevel
                     EXCEPT
                     SELECT
                            UserId
                            ,LevelCompletedDt
                            ,LevelName
                            ,SiteName
                            ,nodeguid
                            ,SiteGuid
                       FROM #DIM_TEMPTBL_EDW_RewardUserLevel_DATA )
                UPDATE S
                  SET
                      S.DeletedFlg = 1
                  FROM CTE AS T JOIN DIM_EDW_RewardUserLevel AS S
                       ON
                       S.UserId = T.UserId
                   AND S.LevelCompletedDt = T.LevelCompletedDt
                   AND S.LevelName = T.LevelName
                   AND S.SiteName = T.SiteName
                   AND S.nodeguid = T.nodeguid
                   AND S.SiteGuid = T.SiteGuid;

            DECLARE
               @iDel AS int = @@ROWCOUNT;
            PRINT 'Update Count: ' + CAST ( @iDel AS nvarchar ( 50 ));
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'D' , @iDel;

            SET @CNT_StagingTable = ( SELECT
                                             COUNT ( * )
                                        FROM DIM_EDW_RewardUserLevel );
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
                                         FROM #DIM_TEMPTBL_EDW_RewardUserLevel_DATA );
            EXEC proc_EDW_ChangeGmtToCentralTime 'DIM_EDW_RewardUserLevel';
            SET @STime = GETDATE ( );
            EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_EDW_RewardUserLevel' , @STime , @CNT_PulledRecords , 'U';

        END;
END;

GO
PRINT 'Created proc_EDW_RewardUserLevel';
GO 
