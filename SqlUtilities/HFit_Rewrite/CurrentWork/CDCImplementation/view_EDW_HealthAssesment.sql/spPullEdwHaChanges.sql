
/*
exec proc_STAGING_EDW_HA_Changes 0   --Process Changed Data only
exec proc_STAGING_EDW_HA_Changes 1   --Reload ALL
exec proc_STAGING_EDW_HA_Changes 0,7

select * from #TEMP_Staging_EDW_HealthAssessment_DATA
select  * from CT_VersionTracking ; 
PULLING Changes for versions between: 42944  and 43281
PULLING Changes for versions between: 43284  and 43287
PULLING Changes for versions between: 43455  and 43468
PULLING Changes for versions between: 43625  and 43627
PULLING Changes for versions between: 43629  and 43632
PULLING Changes for versions between: 43635  and 43691

PULLING Changes for versions between: 11  and 14

SELECT COUNT(*) FROM Staging_EDW_HealthAssessment
SELECT COUNT(*) FROM [view_EDW_HealthAssesment_CT]
SELECT top 10 * FROM [view_EDW_HealthAssesment_CT]
SELECT TOP 100 * FROM [Staging_EDW_HealthAssessment];
SELECT COUNT (*) FROM [Staging_EDW_HealthAssessment]; 

PERF Measurements
03.26.2015 : 4681580 rows - 01:26:36 run time / PROD 1 @ LAB - full reload
03.27.2015 : 4681580 rows - 01:01:20 run time / PROD 1 @ LAB - full reload
03.27.2015 : Prod2  @ LAB : (3711933 row(s) affected) : 01:56:01 - full reload
03.28.2015 : Prod3  @ LAB : (5697805 row(s) affected) : 05:45:57 - full reload

03.29.2015 : Prod2  @ LAB : (xx row(s) affected) : 01:56:01 - Changed Records
*/

GO
PRINT 'FROM proc_STAGING_EDW_HA_Changes.SQL';
PRINT 'Creating proc_STAGING_EDW_HA_Changes';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE
                         name = 'proc_STAGING_EDW_HA_Changes') 
    BEGIN
        PRINT 'Replacing proc_STAGING_EDW_HA_Changes proc';
        DROP PROCEDURE
             proc_STAGING_EDW_HA_Changes;
    END;
GO

CREATE PROCEDURE proc_STAGING_EDW_HA_Changes
       @Reloadall int = 0
     ,@VersionNBR AS int = NULL
     ,@TrackProgress AS bit = 1
     ,@KeepData AS bit = 0
AS
BEGIN

    DECLARE
       @Synchronization_Version bigint = 0
     ,@iVersion AS int
     ,@Lastviewpull_Version AS bigint
     ,@Lastpullversion AS bigint
     ,@CurrentDbVersion AS int
     ,@STime AS datetime
     ,@TgtView AS nvarchar ( 100) = 'view_EDW_HealthAssessment_CT'
     ,@ExtractionDate AS datetime
     ,@ExtractedVersion AS int
     ,@ExtractedRowCnt AS int
     ,@EndTime AS datetime
     ,@CNT_PulledRecords AS int = 0
     ,@iCnt AS int = 0
     ,@RowNbr AS int = 0
     ,@StartTime AS datetime = GETDATE () 
     ,@SVRName AS nvarchar ( 100) 
     ,@DBName AS nvarchar ( 100) = DB_NAME () 
     ,@CNT_Insert AS int = 0
     ,@CNT_Update AS int = 0
     ,@CNT_Delete AS int = 0
     ,@CNT_StagingTable int = 0
     ,@DeletedRecCnt AS int = 0;



    DECLARE
       @RecordID AS uniqueidentifier = NEWID () ;

    set @STime = getdate() ;
    EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_STAGING_EDW_HA_Changes' , @STime , 0 , 'I';

    SET @SVRName = ( SELECT
                            @@SERVERNAME );

    SET @STime = GETDATE () ;

    IF NOT EXISTS ( SELECT
                           name
                           FROM sys.tables
                           WHERE
                                 name = 'CT_VersionTracking') 
        BEGIN
            IF
               @TrackProgress = 1
                BEGIN
                    PRINT 'Creating the tracking table CT_VersionTracking';
                END;
            SET ANSI_NULLS ON;
            SET QUOTED_IDENTIFIER ON;
            CREATE TABLE dbo.CT_VersionTracking (
                         SVRName nvarchar ( 100) NOT NULL
                       ,DBName nvarchar ( 100) NOT NULL
                       ,TgtView nvarchar ( 100) NOT NULL
                       ,ExtractionDate datetime NOT NULL
                       ,ExtractedVersion int NOT NULL
                       ,CurrentDbVersion int NULL
                       ,ExtractedRowCnt int NOT NULL
                       ,StartTime datetime2 ( 7) NOT NULL
                       ,EndTime datetime2 ( 7) NULL
                       ,CNT_Insert int NULL
                       ,CNT_Update int NULL
                       ,CNT_Delete int NULL
                       ,CNT_PulledRecords int NULL
                       ,CNT_StagingTable int NULL
                       ,RowNbr int IDENTITY ( 1 , 1) 
                                   NOT NULL
                       ,CONSTRAINT PK_CT_VersionTracking PRIMARY KEY CLUSTERED ( SVRName , DBName , ExtractedVersion , TgtView , ExtractionDate ASC) 
                            WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , IGNORE_DUP_KEY = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) 
            ON [PRIMARY];

            ALTER TABLE dbo.CT_VersionTracking
            ADD
                        CONSTRAINT DF_CT_VersionTracking_StartTime DEFAULT GETDATE () FOR StartTime;

        END;

    IF
       @Reloadall = NULL
        BEGIN
            SET @Reloadall = 0;
        END;
    IF @Reloadall = 1
        BEGIN
            SET @VersionNBR = NULL;
            IF
               @TrackProgress = 1
                BEGIN
                    PRINT 'RELOAD is ON: ' + CAST ( @Reloadall AS nvarchar ( 50)) ;
                    PRINT 'Change Version is: ' + CAST ( @VersionNBR AS nvarchar ( 50)) ;
                END;
        END;
    ELSE
        BEGIN
            IF @VersionNBR IS NULL
                BEGIN

                    SET @iVersion = ( SELECT
                                             MAX ( ExtractedVersion) 
                                             FROM CT_VersionTracking
                                             WHERE
                                                   TgtView = @TgtView );
                    IF @iVersion IS NULL
                        BEGIN
                            SET @ExtractedVersion = -1;
                        END;
                    ELSE
                        BEGIN
                            SET @ExtractedVersion = @iVersion;
                        END;

                    IF @iVersion IS NULL
                        BEGIN
                            SET @VersionNBR = NULL;
                        END;
                    ELSE
                        BEGIN
                            SET @VersionNBR = @iVersion - 1;
                        END;
                END;
            IF
               @TrackProgress = 1
                BEGIN
                    PRINT 'RELOAD is OFF: ' + CAST ( @Reloadall AS nvarchar ( 50)) ;
                    PRINT 'Change Version is: ' + CAST ( @VersionNBR AS nvarchar ( 50)) ;
                END;
        END;

    SET @CurrentDbVersion = CHANGE_TRACKING_CURRENT_VERSION () ;

    IF @Reloadall = 1
        BEGIN
            IF EXISTS ( SELECT
                               NAME
                               FROM sys.tables
                               WHERE
                                     name = 'Staging_EDW_HealthAssessment') 
                BEGIN
                    IF
                       @TrackProgress = 1
                        BEGIN
                            PRINT 'Dropping Staging_EDW_HealthAssessment for FULL reload.';
                        END;
                    DROP TABLE
                         Staging_EDW_HealthAssessment;
                END;
            ELSE
                BEGIN
                    IF
                       @TrackProgress = 1
                        BEGIN
                            PRINT 'Reloading Staging_EDW_HealthAssessment.';
                        END;
                END;
            IF
               @TrackProgress = 1
                BEGIN
                    PRINT 'Standby, performing initial load of the HA data - this could take several hours, Started at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                END;

            IF @Reloadall = 1
                BEGIN
                    IF
                       @TrackProgress = 1
                        BEGIN
                            PRINT 'RELOADING ALL EDW HA Data.';
                        END;

                    SELECT
                           * INTO
                                  Staging_EDW_HealthAssessment
                           FROM view_EDW_HealthAssesment_CT;

                    --update Staging_EDW_HealthAssessment set [LastModifiedDate] = null ;

                    IF
                       @TrackProgress = 1
                        BEGIN
                            SET @iCnt = ( SELECT
                                                 COUNT ( *) 
                                                 FROM Staging_EDW_HealthAssessment );
                            PRINT DB_NAME () + ' - Completed FULL RELOAD at: ' + CAST ( GETDATE () AS nvarchar ( 50)) + ' , loaded ' + CAST ( @iCnt AS nvarchar ( 50)) + ' records.';
                        END;

                    SET @CNT_PulledRecords = ( SELECT
                                                      COUNT ( *) 
                                                      FROM Staging_EDW_HealthAssessment );
                    SET @CNT_StagingTable = @CNT_PulledRecords;
                    IF NOT EXISTS ( SELECT
                                           name
                                           FROM sys.indexes
                                           WHERE
                                                 name = 'PI_Staging_EDW_HealthAssessment_Dates') 
                        BEGIN
                            IF
                               @TrackProgress = 1
                                BEGIN
                                    PRINT 'Adding INDEX PI_Staging_EDW_HealthAssessment_Dates at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                                END;
                            CREATE NONCLUSTERED INDEX PI_Staging_EDW_HealthAssessment_Dates ON dbo.Staging_EDW_HealthAssessment ( ItemCreatedWhen ASC , ItemModifiedWhen ASC , HARiskCategory_ItemModifiedWhen ASC , HAUserRiskArea_ItemModifiedWhen ASC , HAUserQuestion_ItemModifiedWhen ASC , HAUserAnswers_ItemModifiedWhen ASC) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                        END;

                    SET @ExtractionDate = GETDATE () ;
                    SET @ExtractedVersion = -1;
                    SET @ExtractedRowCnt = ( SELECT
                                                    COUNT ( *) 
                                                    FROM Staging_EDW_HealthAssessment );
                    SET @TgtView = 'view_EDW_HealthAssessment';
                    SET @EndTime = GETDATE () ;

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
                         ,CNT_StagingTable) 
                    VALUES
                           (
                           @ExtractionDate , @ExtractedVersion , @CurrentDbVersion , @ExtractedRowCnt , @TgtView , @StartTime , @EndTime , @SVRName , @DBName , @CNT_Insert , @CNT_Update , @CNT_delete , @CNT_PulledRecords , @CNT_StagingTable) ;

                    IF
                       @TrackProgress = 1
                        BEGIN
                            PRINT 'Completed , RELOAD at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                        END;

                END;
            -- SELECT * INTO [Staging_EDW_HealthAssessment] FROM [view_EDW_HealthAssesment_CT];
            IF
               @TrackProgress = 1
                BEGIN
                    PRINT 'Completed , reloading at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                END;
            IF NOT EXISTS ( SELECT
                                   name
                                   FROM sys.indexes
                                   WHERE
                                         name = 'PI_Staging_EDW_HealthAssessment_Dates') 
                BEGIN
                    IF
                       @TrackProgress = 1
                        BEGIN
                            PRINT 'Adding INDEX PI_Staging_EDW_HealthAssessment_Dates at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                        END;
                    CREATE NONCLUSTERED INDEX PI_Staging_EDW_HealthAssessment_Dates ON dbo.Staging_EDW_HealthAssessment ( ItemCreatedWhen ASC , ItemModifiedWhen ASC , HARiskCategory_ItemModifiedWhen ASC , HAUserRiskArea_ItemModifiedWhen ASC , HAUserQuestion_ItemModifiedWhen ASC , HAUserAnswers_ItemModifiedWhen ASC) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                END;
            IF
               @TrackProgress = 1
                BEGIN
                    PRINT 'Completed FULL RELOAD at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                END;

            SET @STime = GETDATE () ;
            EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_STAGING_EDW_HA_Changes' , @STime , @CNT_PulledRecords , 'U';

            RETURN;
        END;

    IF NOT EXISTS ( SELECT
                           NAME
                           FROM sys.tables
                           WHERE
                                 name = 'Staging_EDW_HealthAssessment') 
        BEGIN
            PRINT '****************************************************************************';
            PRINT 'FATAL ERROR: table Staging_EDW_HealthAssessment was NOT found, aborting.';
            PRINT '****************************************************************************';
        END;
    ELSE
        BEGIN

            IF NOT EXISTS ( SELECT
                                   name
                                   FROM sys.indexes
                                   WHERE
                                         name = 'PI_Staging_EDW_HealthAssessment_Dates') 
                BEGIN
                    IF
                       @TrackProgress = 1
                        BEGIN
                            PRINT 'Adding INDEX PI_Staging_EDW_HealthAssessment_Dates';
                        END;
                    CREATE NONCLUSTERED INDEX PI_Staging_EDW_HealthAssessment_Dates ON dbo.Staging_EDW_HealthAssessment ( ItemCreatedWhen ASC , ItemModifiedWhen ASC , HARiskCategory_ItemModifiedWhen ASC , HAUserRiskArea_ItemModifiedWhen ASC , HAUserQuestion_ItemModifiedWhen ASC , HAUserAnswers_ItemModifiedWhen ASC) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                END;

            IF NOT EXISTS ( SELECT
                                   name
                                   FROM sys.indexes
                                   WHERE
                                         name = 'PI_Staging_EDW_HealthAssessment_IDs') 
                BEGIN
                    IF
                       @TrackProgress = 1
                        BEGIN
                            PRINT 'Adding INDEX PI_Staging_EDW_HealthAssessment_IDs';
                        END;
                    CREATE CLUSTERED INDEX PI_Staging_EDW_HealthAssessment_IDs ON dbo.Staging_EDW_HealthAssessment ( UserStartedItemID , UserModuleItemId , UserRiskCategoryItemID , UserRiskAreaItemID , UserQuestionItemID , UserAnswerItemID , AccountID , UserGUID , HFitUserMpiNumber) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                END;

            --The staging table exists, CHANGES will be determined and applied.
            PRINT 'Standby, PULL HA changes- this could take several hours: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;

            SET @LastpullVersion = ( SELECT
                                            MAX ( CurrentDbVersion) 
                                            FROM CT_VersionTracking
                                            WHERE
                                            SVRname = @@ServerName
                                        AND
                                            DBName = DB_NAME () 
                                        AND
                                            TgtView = 'view_EDW_HealthAssessment' );
            SET @LastViewPull_Version = ( SELECT
                                                 MAX ( ExtractedVersion) 
                                                 FROM CT_VersionTracking
                                                 WHERE
                                                 SVRname = @@ServerName
                                             AND
                                                 DBName = DB_NAME () 
                                             AND
                                                 TgtView = 'view_EDW_HealthAssessment' );

            IF
                   @LastpullVersion < 0
                OR @LastpullVersion IS NULL
                BEGIN
                    SET @LastpullVersion = 0;
                END;
            IF
                   @LastViewPull_Version < 0
                OR @LastpullVersion IS NULL
                BEGIN
                    SET @LastViewPull_Version = 0;
                END;
            IF
               @TrackProgress = 1
                BEGIN
                    PRINT 'Pulling @LastpullVersion ' + CAST ( @LastpullVersion AS nvarchar ( 50)) ;
                    PRINT 'Pulling @LastViewPull_Version ' + CAST ( @LastViewPull_Version AS nvarchar ( 50)) ;
                END;

            IF
               @LastpullVersion = @CurrentDbVersion
                BEGIN
                    PRINT 'NO Changes found as the db version of ' + CAST ( @CurrentDbVersion AS nvarchar ( 50)) + ' has not changed.';
                    RETURN;
                END;
            ELSE
                BEGIN
                    PRINT 'PULLING Changes for versions between: ' + CAST ( @LastpullVersion AS nvarchar ( 50)) + '  and ' + CAST ( @CurrentDbVersion AS nvarchar ( 50)) ;
                END;

            /*******************************************************************************/

            EXEC @DeletedRecCnt = proc_EDW_CountDeletedHA;

            IF EXISTS ( SELECT
                               name
                               FROM tempdb.dbo.sysobjects
                               WHERE
                                     id = OBJECT_ID ( N'tempdb..#TEMP_Staging_EDW_HealthAssessment_DATA')) 
                BEGIN
                    PRINT 'Dropping #TEMP_Staging_EDW_HealthAssessment_DATA';
                    DROP TABLE
                         #TEMP_Staging_EDW_HealthAssessment_DATA;
                END;
declare @MySql as nvarchar(1000) = '' ;

            IF
               @DeletedRecCnt = 0
                BEGIN
				print ('Pulling changes only');
                    set @MySql = 'SELECT
                           * INTO
                                  #TEMP_Staging_EDW_HealthAssessment_DATA
                           FROM view_EDW_HealthAssesment_CT
                           WHERE CHANGED_FLG IS NOT NULL' ;
                END;
            ELSE
                BEGIN
				print ('Pulling all core data as deletes were found');
                    set @MySql = 'SELECT
                           * INTO
                                  #TEMP_Staging_EDW_HealthAssessment_DATA
                           FROM view_EDW_HealthAssesment_CT' ;
                END;

		  exec (@MySql);

            --and (
            --		  ON [CT_CMS_User_SCV]  between @LastpullVersion and @CurrentDbVersion
            --		  ON [CT_CMS_UserSettings_SCV] between @LastpullVersion and @CurrentDbVersion
            --		  ON [CT_CMS_Site_SCV] between @LastpullVersion and @CurrentDbVersion
            --		  ON [CT_CMS_UserSite_SCV] between @LastpullVersion and @CurrentDbVersion
            --		  ON [CT_HFit_Account_SCV] between @LastpullVersion and @CurrentDbVersion
            --		  ON [CT_HFit_HealthAssesmentUserAnswers_SCV] between @LastpullVersion and @CurrentDbVersion
            --		  ON [CT_HFit_HealthAssesmentUserModule_SCV] between @LastpullVersion and @CurrentDbVersion
            --		  ON [CT_HFit_HealthAssesmentUserQuestion_SCV] between @LastpullVersion and @CurrentDbVersion
            --		  ON [CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV] between @LastpullVersion and @CurrentDbVersion
            --		  ON [CT_HFit_HealthAssesmentUserRiskArea_SCV] between @LastpullVersion and @CurrentDbVersion
            --		  ON [CT_HFit_HealthAssesmentUserRiskCategory_SCV] between @LastpullVersion and @CurrentDbVersion
            --		  ON [CT_HFit_HealthAssesmentUserStarted_SCV] between @LastpullVersion and @CurrentDbVersion
            --		)	 ;	   

            CREATE CLUSTERED INDEX temp_PI_Staging_EDW_HealthAssessment_IDs ON dbo.#TEMP_Staging_EDW_HealthAssessment_DATA ( UserStartedItemID , UserModuleItemId , UserRiskCategoryItemID , UserRiskAreaItemID , UserQuestionItemID , UserAnswerItemID , AccountID , UserGUID , HFitUserMpiNumber) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

            SET @CNT_PulledRecords = ( SELECT
                                              COUNT ( *) 
                                              FROM #TEMP_Staging_EDW_HealthAssessment_DATA );

		  if (@KeepData = 1)
			 if exists(select name from sys.tables where name = 'TEMP_Staging_EDW_HealthAssessment_DATA')
			 BEGIN
				drop table TEMP_Staging_EDW_HealthAssessment_DATA ;
			 END;
		  begin 
			 SELECT * INTO
				    TEMP_Staging_EDW_HealthAssessment_DATA
				 from #TEMP_Staging_EDW_HealthAssessment_DATA ;

			 CREATE CLUSTERED INDEX temp_PI_Staging_EDW_HealthAssessment_IDs ON dbo.TEMP_Staging_EDW_HealthAssessment_DATA ( UserStartedItemID , UserModuleItemId , UserRiskCategoryItemID , UserRiskAreaItemID , UserQuestionItemID , UserAnswerItemID , AccountID , UserGUID , HFitUserMpiNumber) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
		  end;

            IF
               @TrackProgress = 1
                BEGIN
                    SET @iCnt = ( SELECT
                                         COUNT ( *) 
                                         FROM #TEMP_Staging_EDW_HealthAssessment_DATA );
                    PRINT DB_NAME () + ' - Completed PULL at: ' + CAST ( GETDATE () AS nvarchar ( 50)) + ' , loaded ' + CAST ( @iCnt AS nvarchar ( 50)) + ' records.';
                END;

            SET @STime = GETDATE () ;
            SET @CurrentDbVersion = CHANGE_TRACKING_CURRENT_VERSION () ;
            IF
               @TrackProgress = 1
                BEGIN
                    PRINT '@CurrentDbVersion: ' + CAST ( @CurrentDbVersion AS nvarchar ( 50)) ;
                END;
            SET @ExtractionDate = GETDATE () ;
            SET @ExtractedRowCnt = ( SELECT
                                            COUNT ( *) 
                                            FROM #TEMP_Staging_EDW_HealthAssessment_DATA );
            SET @TgtView = 'view_EDW_HealthAssessment';
            SET @EndTime = GETDATE () ;

            IF
               @TrackProgress = 1
                BEGIN
                    PRINT 'ADDING THE TRACKING RECORD.';
                END;
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
                 ,CNT_PulledRecords) 
            VALUES
                   (
                   @ExtractionDate ,
                   --@LastpullVersion ,
                   @CurrentDbVersion , @CurrentDbVersion , @ExtractedRowCnt , @TgtView , @StartTime , @EndTime , @SVRName , @DBName , @CNT_Insert , @CNT_Update , @CNT_delete , @CNT_PulledRecords) ;

            SET @RowNbr = ( SELECT
                                   MAX ( RowNbr) 
                                   FROM CT_VersionTracking
                                   WHERE
                                   SVRName = @SVRName
                               AND DBName = @DBName
                               AND
                                   TgtView = @TgtView );

            SET @CNT_PulledRecords = ( SELECT
                                              COUNT ( *) 
                                              FROM #TEMP_Staging_EDW_HealthAssessment_DATA );
            UPDATE CT_VersionTracking
                   SET
                       CNT_PulledRecords = @iCnt
            WHERE
                  RowNbr = @RowNbr;

            --SELECT * FROM CT_VersionTracking
            --The temp table is loaded.
            --Check to see if NEW records exist and if not, insert them into the staging table
            SET @iCnt = ( SELECT
                                 COUNT ( *) 
                                 FROM
                                     #TEMP_Staging_EDW_HealthAssessment_DATA AS T
                                         LEFT JOIN Staging_EDW_HealthAssessment AS S
                                             ON
                                 T.UserStartedItemID = S.UserStartedItemID
                             AND
                                 T.UserModuleItemId = S.UserModuleItemId
                             AND
                                 T.UserRiskCategoryItemID = S.UserRiskCategoryItemID
                             AND
                                 T.UserRiskAreaItemID = S.UserRiskAreaItemID
                             AND
                                 T.UserQuestionItemID = S.UserQuestionItemID
                             AND
                                 T.UserAnswerItemID = S.UserAnswerItemID
                             AND
                                 T.AccountID = S.AccountID
                             AND
                                 T.UserGUID = S.UserGUID
                             AND
                                 T.HFitUserMpiNumber = S.HFitUserMpiNumber
                                 WHERE
                                 S.UserStartedItemID IS NULL
                             AND S.UserModuleItemId IS NULL
                             AND S.UserRiskCategoryItemID IS NULL
                             AND S.UserRiskAreaItemID IS NULL
                             AND S.UserQuestionItemID IS NULL
                             AND S.UserAnswerItemID IS NULL
                             AND S.AccountID IS NULL
                             AND S.HFitUserMpiNumber IS NULL );
            IF
               @TrackProgress = 1
                BEGIN
                    PRINT '#New Records found: ' + CAST ( @iCnt AS nvarchar ( 50)) + '. Updating VersionTracking RowNbr: ' + CAST ( @RowNbr AS nvarchar ( 5)) ;
                END;

            UPDATE CT_VersionTracking
                   SET
                       CNT_Insert = @iCnt
            WHERE
                  RowNbr = @RowNbr;
            IF @iCnt > 0
                BEGIN
                    INSERT INTO dbo.Staging_EDW_HealthAssessment (
                           UserStartedItemID
                         ,HealthAssesmentUserStartedNodeGUID
                         ,UserID
                         ,UserGUID
                         ,HFitUserMpiNumber
                         ,SiteGUID
                         ,AccountID
                         ,AccountCD
                         ,AccountName
                         ,HAStartedDt
                         ,HACompletedDt
                         ,UserModuleItemId
                         ,UserModuleCodeName
                         ,HAModuleNodeGUID
                         ,CMSNodeGuid
                         ,HAModuleVersionID
                         ,UserRiskCategoryItemID
                         ,UserRiskCategoryCodeName
                         ,HARiskCategoryNodeGUID
                         ,HARiskCategoryVersionID
                         ,UserRiskAreaItemID
                         ,UserRiskAreaCodeName
                         ,HARiskAreaNodeGUID
                         ,HARiskAreaVersionID
                         ,UserQuestionItemID
                         ,Title
                         ,HAQuestionGuid
                         ,UserQuestionCodeName
                         ,HAQuestionDocumentID
                         ,HAQuestionVersionID
                         ,HAQuestionNodeGUID
                         ,UserAnswerItemID
                         ,HAAnswerNodeGUID
                         ,HAAnswerVersionID
                         ,UserAnswerCodeName
                         ,HAAnswerValue
                         ,HAModuleScore
                         ,HARiskCategoryScore
                         ,HARiskAreaScore
                         ,HAQuestionScore
                         ,HAAnswerPoints
                         ,PointResults
                         ,UOMCode
                         ,HAScore
                         ,ModulePreWeightedScore
                         ,RiskCategoryPreWeightedScore
                         ,RiskAreaPreWeightedScore
                         ,QuestionPreWeightedScore
                         ,QuestionGroupCodeName
                         ,ChangeType
                         ,ItemCreatedWhen
                         ,ItemModifiedWhen
                         ,IsProfessionallyCollected
                         ,HARiskCategory_ItemModifiedWhen
                         ,HAUserRiskArea_ItemModifiedWhen
                         ,HAUserQuestion_ItemModifiedWhen
                         ,HAUserAnswers_ItemModifiedWhen
                         ,HAPaperFlg
                         ,HATelephonicFlg
                         ,HAStartedMode
                         ,HACompletedMode
                         ,DocumentCulture_VHCJ
                         ,DocumentCulture_HAQuestionsView
                         ,CampaignNodeGUID
                         ,HACampaignID
                         ,HashCode
                         ,LastModifiedDate
                         ,DeleteFlg
                         ,CHANGED_FLG
                         ,CT_CMS_User_UserID
                         ,CT_CMS_User_CHANGE_OPERATION
                         ,CT_UserSettingsID
                         ,CT_UserSettingsID_CHANGE_OPERATION
                         ,SiteID_CtID
                         ,SiteID_CHANGE_OPERATION
                         ,UserSiteID_CtID
                         ,UserSiteID_CHANGE_OPERATION
                         ,AccountID_CtID
                         ,AccountID__CHANGE_OPERATION
                         ,HAUserAnswers_CtID
                         ,HAUserAnswers_CHANGE_OPERATION
                         ,HFit_HealthAssesmentUserModule_CtID
                         ,HFit_HealthAssesmentUserModule_CHANGE_OPERATION
                         ,HFit_HealthAssesmentUserQuestion_CtID
                         ,HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION
                         ,HFit_HealthAssesmentUserQuestionGroupResults_CtID
                         ,HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION
                         ,HFit_HealthAssesmentUserRiskArea_CtID
                         ,HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION
                         ,HFit_HealthAssesmentUserRiskCategory_CtID
                         ,HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION
                         ,HFit_HealthAssesmentUserStarted_CtID
                         ,HFit_HealthAssesmentUserStarted_CHANGE_OPERATION) 
                    SELECT
                           T.UserStartedItemID
                         ,T.HealthAssesmentUserStartedNodeGUID
                         ,T.UserID
                         ,T.UserGUID
                         ,T.HFitUserMpiNumber
                         ,T.SiteGUID
                         ,T.AccountID
                         ,T.AccountCD
                         ,T.AccountName
                         ,T.HAStartedDt
                         ,T.HACompletedDt
                         ,T.UserModuleItemId
                         ,T.UserModuleCodeName
                         ,T.HAModuleNodeGUID
                         ,T.CMSNodeGuid
                         ,T.HAModuleVersionID
                         ,T.UserRiskCategoryItemID
                         ,T.UserRiskCategoryCodeName
                         ,T.HARiskCategoryNodeGUID
                         ,T.HARiskCategoryVersionID
                         ,T.UserRiskAreaItemID
                         ,T.UserRiskAreaCodeName
                         ,T.HARiskAreaNodeGUID
                         ,T.HARiskAreaVersionID
                         ,T.UserQuestionItemID
                         ,T.Title
                         ,T.HAQuestionGuid
                         ,T.UserQuestionCodeName
                         ,T.HAQuestionDocumentID
                         ,T.HAQuestionVersionID
                         ,T.HAQuestionNodeGUID
                         ,T.UserAnswerItemID
                         ,T.HAAnswerNodeGUID
                         ,T.HAAnswerVersionID
                         ,T.UserAnswerCodeName
                         ,T.HAAnswerValue
                         ,T.HAModuleScore
                         ,T.HARiskCategoryScore
                         ,T.HARiskAreaScore
                         ,T.HAQuestionScore
                         ,T.HAAnswerPoints
                         ,T.PointResults
                         ,T.UOMCode
                         ,T.HAScore
                         ,T.ModulePreWeightedScore
                         ,T.RiskCategoryPreWeightedScore
                         ,T.RiskAreaPreWeightedScore
                         ,T.QuestionPreWeightedScore
                         ,T.QuestionGroupCodeName
                         ,T.ChangeType
                         ,T.ItemCreatedWhen
                         ,T.ItemModifiedWhen
                         ,T.IsProfessionallyCollected
                         ,T.HARiskCategory_ItemModifiedWhen
                         ,T.HAUserRiskArea_ItemModifiedWhen
                         ,T.HAUserQuestion_ItemModifiedWhen
                         ,T.HAUserAnswers_ItemModifiedWhen
                         ,T.HAPaperFlg
                         ,T.HATelephonicFlg
                         ,T.HAStartedMode
                         ,T.HACompletedMode
                         ,T.DocumentCulture_VHCJ
                         ,T.DocumentCulture_HAQuestionsView
                         ,T.CampaignNodeGUID
                         ,T.HACampaignID
                         ,T.HashCode
                           --, T.LastModifiedDate
                         ,
                           @StartTime
                         ,T.DeleteFlg
                         ,T.CHANGED_FLG
                         ,T.CT_CMS_User_UserID
                         ,T.CT_CMS_User_CHANGE_OPERATION
                         ,T.CT_UserSettingsID
                         ,T.CT_UserSettingsID_CHANGE_OPERATION
                         ,T.SiteID_CtID
                         ,T.SiteID_CHANGE_OPERATION
                         ,T.UserSiteID_CtID
                         ,T.UserSiteID_CHANGE_OPERATION
                         ,T.AccountID_CtID
                         ,T.AccountID__CHANGE_OPERATION
                         ,T.HAUserAnswers_CtID
                         ,T.HAUserAnswers_CHANGE_OPERATION
                         ,T.HFit_HealthAssesmentUserModule_CtID
                         ,T.HFit_HealthAssesmentUserModule_CHANGE_OPERATION
                         ,T.HFit_HealthAssesmentUserQuestion_CtID
                         ,T.HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION
                         ,T.HFit_HealthAssesmentUserQuestionGroupResults_CtID
                         ,T.HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION
                         ,T.HFit_HealthAssesmentUserRiskArea_CtID
                         ,T.HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION
                         ,T.HFit_HealthAssesmentUserRiskCategory_CtID
                         ,T.HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION
                         ,T.HFit_HealthAssesmentUserStarted_CtID
                         ,T.HFit_HealthAssesmentUserStarted_CHANGE_OPERATION
                           FROM
                               #TEMP_Staging_EDW_HealthAssessment_DATA AS T
                                   LEFT JOIN Staging_EDW_HealthAssessment AS S
                                       ON
                           T.UserStartedItemID = S.UserStartedItemID
                       AND
                           T.UserModuleItemId = S.UserModuleItemId
                       AND
                           T.UserRiskCategoryItemID = S.UserRiskCategoryItemID
                       AND
                           T.UserRiskAreaItemID = S.UserRiskAreaItemID
                       AND
                           T.UserQuestionItemID = S.UserQuestionItemID
                       AND
                           T.UserAnswerItemID = S.UserAnswerItemID
                       AND
                           T.AccountID = S.AccountID
                       AND
                           T.UserGUID = S.UserGUID
                       AND
                           T.HFitUserMpiNumber = S.HFitUserMpiNumber
                           WHERE
                           S.UserStartedItemID IS NULL
                       AND S.UserModuleItemId IS NULL
                       AND S.UserRiskCategoryItemID IS NULL
                       AND S.UserRiskAreaItemID IS NULL
                       AND S.UserQuestionItemID IS NULL
                       AND S.UserAnswerItemID IS NULL
                       AND S.AccountID IS NULL
                       AND S.HFitUserMpiNumber IS NULL;
                END;
            --Check to see if CURRENT records have differnet HASH codes and if so, update the staging table
            SET @iCnt = ( SELECT
                                 COUNT ( *) 
                                 FROM
                                     Staging_EDW_HealthAssessment AS S
                                         JOIN #TEMP_Staging_EDW_HealthAssessment_DATA AS T
                                             ON
                                 T.UserStartedItemID = S.UserStartedItemID
                             AND
                                 T.UserModuleItemId = S.UserModuleItemId
                             AND
                                 T.UserRiskCategoryItemID = S.UserRiskCategoryItemID
                             AND
                                 T.UserRiskAreaItemID = S.UserRiskAreaItemID
                             AND
                                 T.UserQuestionItemID = S.UserQuestionItemID
                             AND
                                 T.UserAnswerItemID = S.UserAnswerItemID
                             AND
                                 T.AccountID = S.AccountID
                             AND
                                 T.UserGUID = S.UserGUID
                             AND
                                 T.HFitUserMpiNumber = S.HFitUserMpiNumber
                                 WHERE
                                       T.HashCode != S.HashCode );
            IF
               @TrackProgress = 1
                BEGIN
                    PRINT '#Records found to update: ' + CAST ( @iCnt AS nvarchar ( 50)) + '. Updating VersionTracking RowNbr: ' + CAST ( @RowNbr AS nvarchar ( 5)) ;
                END;
            IF @iCnt > 0
                BEGIN
                    UPDATE CT_VersionTracking
                           SET
                               CNT_Update = @iCnt
                    WHERE
                          RowNbr = @RowNbr;

                    UPDATE T2
                           SET
                               T2.UserStartedItemID = T1.UserStartedItemID
                             ,T2.HAQuestionNodeGUID = T1.HAQuestionNodeGUID
                             ,T2.UserID = T1.UserID
                             ,T2.UserGUID = T1.UserGUID
                             ,T2.HFitUserMpiNumber = T1.HFitUserMpiNumber
                             ,T2.SiteGUID = T1.SiteGUID
                             ,T2.AccountID = T1.AccountID
                             ,T2.AccountCD = T1.AccountCD
                             ,T2.HAStartedDt = T1.HAStartedDt
                             ,T2.HACompletedDt = T1.HACompletedDt
                             ,T2.UserModuleItemId = T1.UserModuleItemId
                             ,T2.UserModuleCodeName = T1.UserModuleCodeName
                             ,T2.HAModuleNodeGUID = T1.HAModuleNodeGUID
                             ,T2.CMSNodeGuid = T1.CMSNodeGuid
                             ,T2.HAModuleVersionID = T1.HAModuleVersionID
                             ,T2.UserRiskCategoryItemID = T1.UserRiskCategoryItemID
                             ,T2.UserRiskCategoryCodeName = T1.UserRiskCategoryCodeName
                             ,T2.HARiskCategoryNodeGUID = T1.HARiskCategoryNodeGUID
                             ,T2.HARiskCategoryVersionID = T1.HARiskCategoryVersionID
                             ,T2.UserRiskAreaItemID = T1.UserRiskAreaItemID
                             ,T2.UserRiskAreaCodeName = T1.UserRiskAreaCodeName
                             ,T2.HARiskAreaNodeGUID = T1.HARiskAreaNodeGUID
                             ,T2.HARiskAreaVersionID = T1.HARiskAreaVersionID
                             ,T2.UserQuestionItemID = T1.UserQuestionItemID
                             ,T2.Title = T1.Title
                             ,T2.UserQuestionCodeName = T1.UserQuestionCodeName
                             ,T2.HAQuestionVersionID = T1.HAQuestionVersionID
                             ,T2.UserAnswerItemID = T1.UserAnswerItemID
                             ,T2.HAAnswerNodeGUID = T1.HAAnswerNodeGUID
                             ,T2.HAAnswerVersionID = T1.HAAnswerVersionID
                             ,T2.UserAnswerCodeName = T1.UserAnswerCodeName
                             ,T2.HAAnswerValue = T1.HAAnswerValue
                             ,T2.HAModuleScore = T1.HAModuleScore
                             ,T2.HARiskCategoryScore = T1.HARiskCategoryScore
                             ,T2.HARiskAreaScore = T1.HARiskAreaScore
                             ,T2.HAQuestionScore = T1.HAQuestionScore
                             ,T2.HAAnswerPoints = T1.HAAnswerPoints
                             ,T2.PointResults = T1.PointResults
                             ,T2.UOMCode = T1.UOMCode
                             ,T2.HAScore = T1.HAScore
                             ,T2.ModulePreWeightedScore = T1.ModulePreWeightedScore
                             ,T2.RiskCategoryPreWeightedScore = T1.RiskCategoryPreWeightedScore
                             ,T2.RiskAreaPreWeightedScore = T1.RiskAreaPreWeightedScore
                             ,T2.QuestionPreWeightedScore = T1.QuestionPreWeightedScore
                             ,T2.QuestionGroupCodeName = T1.QuestionGroupCodeName
                             ,T2.ChangeType = T1.ChangeType
                             ,T2.IsProfessionallyCollected = T1.IsProfessionallyCollected
                             ,T2.ItemCreatedWhen = T1.ItemCreatedWhen
                             ,T2.ItemModifiedWhen = T1.ItemModifiedWhen
                             ,T2.HARiskCategory_ItemModifiedWhen = T1.HARiskCategory_ItemModifiedWhen
                             ,T2.HAUserRiskArea_ItemModifiedWhen = T1.HAUserRiskArea_ItemModifiedWhen
                             ,T2.HAUserQuestion_ItemModifiedWhen = T1.HAUserQuestion_ItemModifiedWhen
                             ,T2.HAUserAnswers_ItemModifiedWhen = T1.HAUserAnswers_ItemModifiedWhen
                             ,T2.HashCode = T1.HashCode
                               --, T2.LastModifiedDate = T1.LastModifiedDate
                             ,
                               T2.LastModifiedDate = @StartTime
                             ,T2.DeleteFlg = T1.DeleteFlg
                               FROM Staging_EDW_HealthAssessment AS T2
                                        JOIN #TEMP_Staging_EDW_HealthAssessment_DATA AS T1
                                            ON
                           T1.UserStartedItemID = T2.UserStartedItemID
                       AND
                           T1.UserModuleItemId = T2.UserModuleItemId
                       AND
                           T1.UserRiskCategoryItemID = T2.UserRiskCategoryItemID
                       AND
                           T1.UserRiskAreaItemID = T2.UserRiskAreaItemID
                       AND
                           T1.UserQuestionItemID = T2.UserQuestionItemID
                       AND
                           T1.UserAnswerItemID = T2.UserAnswerItemID
                       AND
                           T1.AccountID = T2.AccountID
                       AND
                           T1.UserGUID = T2.UserGUID
                       AND
                           T1.HFitUserMpiNumber = T2.HFitUserMpiNumber
                               WHERE
                                     T1.HashCode != T2.HashCode;
                END;

            IF
               @DeletedRecCnt > 0
                BEGIN
                    --Check to see if records exist in the Staging Table and not in the Temp Table and if so, update the DeleteFlg in the staging table
                    SET @iCnt = ( SELECT
                                         COUNT ( *) 
                                         FROM
                                             #TEMP_Staging_EDW_HealthAssessment_DATA AS T
                                                 INNER JOIN Staging_EDW_HealthAssessment AS StagedData
                                                     ON
                                         T.UserStartedItemID = StagedData.UserStartedItemID
                                     AND
                                         T.UserModuleItemId = StagedData.UserModuleItemId
                                     AND
                                         T.UserRiskCategoryItemID = StagedData.UserRiskCategoryItemID
                                     AND
                                         T.UserRiskAreaItemID = StagedData.UserRiskAreaItemID
                                     AND
                                         T.UserQuestionItemID = StagedData.UserQuestionItemID
                                     AND
                                         T.UserAnswerItemID = StagedData.UserAnswerItemID
                                     AND
                                         T.AccountID = StagedData.AccountID
                                     AND
                                         T.UserGUID = StagedData.UserGUID
                                     AND
                                         T.HFitUserMpiNumber = StagedData.HFitUserMpiNumber
                                     AND (
                                         T.CT_CMS_User_CHANGE_OPERATION = 'D'
                                      OR
                                         T.CT_UserSettingsID_CHANGE_OPERATION = 'D'
                                      OR
                                         T.SiteID_CHANGE_OPERATION = 'D'
                                      OR
                                         T.UserSiteID_CHANGE_OPERATION = 'D'
                                      OR
                                         T.AccountID__CHANGE_OPERATION = 'D'
                                      OR
                                         T.HAUserAnswers_CHANGE_OPERATION = 'D'
                                      OR
                                         T.HFit_HealthAssesmentUserModule_CHANGE_OPERATION = 'D'
                                      OR
                                         T.HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION = 'D'
                                      OR
                                         T.HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION = 'D'
                                      OR
                                         T.HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION = 'D'
                                      OR
                                         T.HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION = 'D'
                                      OR
                                         T.HFit_HealthAssesmentUserStarted_CHANGE_OPERATION = 'D'));

                    IF
                       @TrackProgress = 1
                        BEGIN
                            PRINT '#Records found to delete: ' + CAST ( @iCnt AS nvarchar ( 50)) ;
                        END;
                    UPDATE CT_VersionTracking
                           SET
                               CNT_delete = @iCnt
                    WHERE
                          RowNbr = @RowNbr;

                    WITH CTE (
                         UserStartedItemID
                       ,UserModuleItemId
                       ,UserRiskCategoryItemID
                       ,UserRiskAreaItemID
                       ,UserQuestionItemID
                       ,UserAnswerItemID
                       ,AccountID
                       ,UserGUID
                       ,HFitUserMpiNumber) 
                        AS ( SELECT
                                    UserStartedItemID
                                  ,UserModuleItemId
                                  ,UserRiskCategoryItemID
                                  ,UserRiskAreaItemID
                                  ,UserQuestionItemID
                                  ,UserAnswerItemID
                                  ,AccountID
                                  ,UserGUID
                                  ,HFitUserMpiNumber
                                    FROM Staging_EDW_HealthAssessment
                             EXCEPT
                             SELECT
                                    UserStartedItemID
                                  ,UserModuleItemId
                                  ,UserRiskCategoryItemID
                                  ,UserRiskAreaItemID
                                  ,UserQuestionItemID
                                  ,UserAnswerItemID
                                  ,AccountID
                                  ,UserGUID
                                  ,HFitUserMpiNumber
                                    FROM #TEMP_Staging_EDW_HealthAssessment_DATA) 

                        UPDATE S
                               SET
                                   DeleteFlg = 1
                                   FROM Staging_EDW_HealthAssessment AS S
                                            INNER JOIN CTE AS T
                                                ON
                               T.UserStartedItemID = S.UserStartedItemID
                           AND
                               T.UserModuleItemId = S.UserModuleItemId
                           AND
                               T.UserRiskCategoryItemID = S.UserRiskCategoryItemID
                           AND
                               T.UserRiskAreaItemID = S.UserRiskAreaItemID
                           AND
                               T.UserQuestionItemID = S.UserQuestionItemID
                           AND
                               T.UserAnswerItemID = S.UserAnswerItemID
                           AND
                               T.AccountID = S.AccountID
                           AND
                               T.UserGUID = S.UserGUID
                           AND
                               T.HFitUserMpiNumber = S.HFitUserMpiNumber;
                END;

            SET @CNT_StagingTable = ( SELECT
                                             COUNT ( *) 
                                             FROM #TEMP_Staging_EDW_HealthAssessment_DATA );
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
		 
		  SET @STime = GETDATE () ;
            EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_STAGING_EDW_HA_Changes' , @STime , @CNT_PulledRecords , 'U';

        END;
END;

GO
PRINT 'Created proc_STAGING_EDW_HA_Changes';
GO 
