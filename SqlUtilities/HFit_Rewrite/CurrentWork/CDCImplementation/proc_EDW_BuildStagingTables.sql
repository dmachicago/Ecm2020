
GO
EXEC PrintImmediate 'Executing proc_EDW_BuildStagingTables.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_EDW_BuildStagingTables') 
    BEGIN
        DROP PROCEDURE
             proc_EDW_BuildStagingTables;
    END;
GO

/*-------------------------------------
------------------------------
EXEC proc_EDW_BuildStagingTables 12576 
exec proc_EDW_BuildHAHashkeys
*/
CREATE PROCEDURE proc_EDW_BuildStagingTables (
       @ChangeVersionID INT = 0
     , @ReloadAll INT = 0) 
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS ( SELECT
                           NAME
                           FROM sys.tables
                           WHERE
                           name = 'DIM_EDW_MASTER_TABLES') 
        BEGIN

/*--------------------------------------------------------------------
---------------------------------------------------------------------
----------------------------------------------------------------------
@ChangeVersionID is the CHANGE Version number that is desired to pull.
If not provided, it defaults to 0 which will cause all CT recs to be 
considered.

ADD THE MASTER TABLE SO THAT THIS INITIALIZATION WILL NOT OCCUR AGAIN.
NOTE: TO RELOAD ALL STAGING TABLES, JUST DROP DIM_EDW_MASTER_TABLES.
*/

            EXEC PrintImmediate '**INSIDE Populating Staging Tables: ';

            DECLARE
            @iInsertedCnt AS BIGINT = 0;

            EXEC PrintImmediate 'Populating DIM_EDW_MASTER_TABLES';
            RAISERROR ('Populating DIM_EDW_MASTER_TABLES.' , 10 , 1) WITH NOWAIT;
            SELECT
                   table_name INTO
                                   DIM_EDW_MASTER_TABLES
                   FROM information_schema.tables
                   WHERE table_name LIKE 'DIM_EDW%';

            --DROP ANY EXISTING TABLES SO THEY WILL BE REPOPULATED
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'DIM_EDW_CMS_USER') 
                BEGIN
                    EXEC proc_Create_StagingTables_INIT;

                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'DIM_EDW_CMS_USERSETTINGS') 
                BEGIN
                    EXEC proc_Create_StagingTables_INIT;
                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'DIM_EDW_CMS_USERSITE') 
                BEGIN
                    EXEC proc_Create_StagingTables_INIT;
                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'DIM_EDW_HealthAssessmentDefinition') 
                BEGIN
                    EXEC proc_Create_StagingTables_INIT;
                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'DIM_EDW_HFIT_HealthAssesmentUserAnswers') 
                BEGIN
                    EXEC proc_Create_StagingTables_INIT;
                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'DIM_EDW_HFIT_HEALTHASSESMENTUSERMODULE') 
                BEGIN
                    EXEC proc_Create_StagingTables_INIT;
                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'DIM_EDW_HFit_HealthAssesmentUserQuestion') 
                BEGIN
                    EXEC proc_Create_StagingTables_INIT;
                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'DIM_EDW_HFit_HealthAssesmentUserQuestionGroupResults') 
                BEGIN
                    EXEC proc_Create_StagingTables_INIT;
                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'DIM_EDW_HFit_HealthAssesmentUserRiskArea') 
                BEGIN
                    EXEC proc_Create_StagingTables_INIT;
                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'DIM_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY') 
                BEGIN
                    EXEC proc_Create_StagingTables_INIT;
                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'DIM_EDW_HFIT_HEALTHASSESMENTUSERSTARTED') 
                BEGIN
                    EXEC proc_Create_StagingTables_INIT;
                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'DIM_EDW_VIEW_HFIT_HACAMPAIGN_JOINED') 
                BEGIN
                    EXEC proc_Create_StagingTables_INIT;
                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'DIM_EDW_VIEW_HFIT_HEALTHASSESSMENT_JOINED') 
                BEGIN
                    EXEC proc_Create_StagingTables_INIT;
                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'DIM_EDW_View_EDW_HealthAssesmentQuestions') 
                BEGIN
                    EXEC proc_Create_StagingTables_INIT;
                END;

        END;

    --***************************************************************************
    DECLARE
    @iCnt AS BIGINT = 0;
    --***************************************************************************
    IF EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE
                      name = 'DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined') 
        BEGIN

            RAISERROR ('Populating DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined.' , 10 , 1) WITH NOWAIT;
            DROP TABLE
                 DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined;
        END;

    SELECT
           HAUserRiskArea.ITEMID AS UserRiskAreaItemID
         , HAUserRiskArea.HARISKCATEGORYITEMID
         , HAUserRiskArea.CODENAME AS USERRISKAREACODENAME
         , HAUserRiskArea.HARISKAREANODEGUID
         , NULL AS HARISKAREAVERSIONID
         , HAUserRiskArea.HARISKAREASCORE
         , HAUserRiskArea.PREWEIGHTEDSCORE AS RISKAREAPREWEIGHTEDSCORE
         , HAUserRiskArea.ITEMMODIFIEDWHEN AS HAUserRiskArea_ITEMMODIFIEDWHEN
         , HAUserRiskArea.ITEMMODIFIEDWHEN AS HAUserRiskArea_LASTMODIFIED   --HAUserRiskArea.LASTLOADEDDATE 
         , NULL AS HAUserRiskArea_LastUpdateID   --HAUserRiskArea.LastUpdateID 

         , HAUserQuestionGroupResults.HARiskAreaItemID
         , HAUserQuestionGroupResults.ItemID AS HAUserQuestionGroupResultsItemID
         , HAUserQuestionGroupResults.POINTRESULTS
         , HAUserQuestionGroupResults.CODENAME AS QUESTIONGROUPCODENAME
         , HAUserQuestionGroupResults.ITEMMODIFIEDWHEN AS HAUserQuestionGroupResults_LASTMODIFIED	--HAUserQuestionGroupResults.LASTLOADEDDATE 
         , NULL AS HAUserQuestionGroupResults_LastUpdateID	--HAUserQuestionGroupResults.LastUpdateID 

         , HAUserRiskArea.ItemModifiedWhen AS LastModifiedWhen
         , 0 AS LastUpdateID
         , GETDATE () AS LASTLOADEDDATE
         , HAUserRiskArea.SVR AS SVR
         , HAUserRiskArea.DBNAME AS DBNAME
         , HAUserRiskArea.LastModifiedDate
         , 0 AS DeletedFlg
    INTO
         DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined
           FROM DBO.FACT_HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea
                    LEFT JOIN DBO.FACT_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS AS HAUserQuestionGroupResults
                        ON HAUserRiskArea.ITEMID = HAUserQuestionGroupResults.HARiskAreaItemID
                       AND HAUserRiskArea.SVR = HAUserQuestionGroupResults.SVR
                       AND HAUserRiskArea.DBNAME = HAUserQuestionGroupResults.DBNAME;

    RAISERROR ('Populated DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined.' , 10 , 1) WITH NOWAIT;
    EXEC proc_Add_EDW_CT_StdCols DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined;

    IF NOT EXISTS (SELECT
                          column_name
                          FROM information_schema.columns
                          WHERE
                          table_name = 'DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined'
                      AND column_name = 'HARISKCATEGORYITEMID') 
        BEGIN
            EXEC PrintImmediate 'ADDING HARISKCATEGORYITEMID to DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined';
            ALTER TABLE DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined
            ADD
                        HARISKCATEGORYITEMID INT NULL;
        END;

    RAISERROR ('Populated PI_EDW_HFit_HealthAssesmentUserRiskArea_Joined.' , 10 , 1) WITH NOWAIT;
    CREATE CLUSTERED INDEX PI_EDW_HFit_HealthAssesmentUserRiskArea_Joined ON DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined (SVR ASC , DBNAME ASC , UserRiskAreaItemID ASC , HAUserQuestionGroupResultsItemID ASC) ;

    RAISERROR ('Populated CI_EDW_HFit_HealthAssesmentUserRiskArea_Joined.' , 10 , 1) WITH NOWAIT;

    CREATE NONCLUSTERED INDEX CI_EDW_HFit_HealthAssesmentUserRiskArea_Joined
    ON dbo.DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined (SVR ASC , DBNAME ASC , HAUserQuestionGroupResultsItemID) 
    INCLUDE (UserRiskAreaItemID , LastUpdateID) ;

    RAISERROR ('Created CI_EDW_HFit_HealthAssesmentUserRiskArea_Joined.' , 10 , 1) WITH NOWAIT;

    -- delete from FACT_HFit_HealthAssesmentUserRiskArea where ItemID = 6928
    -- Select * from CHANGETABLE (CHANGES FACT_HFit_HealthAssesmentUserRiskArea , 0) AS CT_HFit_HealthAssesmentUserRiskArea
    -- DECLARE @ChangeVersionID AS int = 0;
    DELETE D
           FROM DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined D
                    JOIN CHANGETABLE (CHANGES FACT_HFit_HealthAssesmentUserRiskArea , @ChangeVersionID) AS CT_HFit_HealthAssesmentUserRiskArea
                        ON
                        D.UserRiskAreaItemID = CT_HFit_HealthAssesmentUserRiskArea.ItemID
                    AND SYS_CHANGE_OPERATION = 'D'
                    AND D.SVR = CT_HFit_HealthAssesmentUserRiskArea.SVR
                    AND D.DBNAME = CT_HFit_HealthAssesmentUserRiskArea.DBNAME;

    -- select * from CHANGETABLE ( CHANGES FACT_HFit_HealthAssesmentUserRiskArea , 0) AS CT_HFit_HealthAssesmentUserRiskArea  
    -- select top 100 * from FACT_HFit_HealthAssesmentUserRiskArea
    -- update FACT_HFit_HealthAssesmentUserRiskArea set CodeName = 'Fats' where CodeNAme = 'Fats'
    -- DECLARE @ChangeVersionID AS int = 0;

    EXEC proc_Add_EDW_CT_StdCols FACT_HFit_HealthAssesmentUserRiskArea;

    RAISERROR ('Updating DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined.' , 10 , 1) WITH NOWAIT;
    UPDATE S
           SET
               S.USERRISKAREACODENAME = T.CODENAME
             ,S.HARISKAREANODEGUID = T.HARISKAREANODEGUID
             ,S.HARISKAREASCORE = T.HARISKAREASCORE
             ,S.RISKAREAPREWEIGHTEDSCORE = T.PREWEIGHTEDSCORE
             ,S.HAUserRiskArea_ITEMMODIFIEDWHEN = T.ITEMMODIFIEDWHEN
             ,S.HARISKCATEGORYITEMID = T.HARISKCATEGORYITEMID
             ,S.LastUpdateID = CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_VERSION
             ,S.LASTLOADEDDATE = GETDATE () 
             ,S.SVR = T.SVR
             ,S.DBNAME = T.DBNAME
             ,LastModifiedDate = GETDATE () 
             ,DeletedFlg = 0
               FROM FACT_HFit_HealthAssesmentUserRiskArea AS T
                        JOIN DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined AS S
                            ON
                            S.UserRiskAreaItemID = T.ItemID
                        AND S.SVR = T.SVR
                        AND S.DBNAME = T.DBNAME
                        JOIN CHANGETABLE ( CHANGES FACT_HFit_HealthAssesmentUserRiskArea , @ChangeVersionID) AS CT_HFit_HealthAssesmentUserRiskArea
                            ON
                            CT_HFit_HealthAssesmentUserRiskArea.ItemID = T.ItemID
                        AND CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_VERSION != S.LastUpdateID
                        AND CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_OPERATION = 'U'
                        AND CT_HFit_HealthAssesmentUserRiskArea.SVR = T.SVR
                        AND CT_HFit_HealthAssesmentUserRiskArea.DBNAME = T.DBNAME;

    -- select * from CHANGETABLE ( CHANGES FACT_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS , 0) AS CT_HFit_HealthAssesmentUserQuestionGroupResults
    -- select top 100 * from FACT_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS
    -- Update FACT_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS set CodeNAme = 'MME' where CodeName = 'MME'
    -- DECLARE @ChangeVersionID AS int = 0;

    RAISERROR ('Updating FACT_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS.' , 10 , 1) WITH NOWAIT;
    UPDATE S
           SET
               S.POINTRESULTS = T.POINTRESULTS
             ,S.QUESTIONGROUPCODENAME = T.CODENAME
             ,S.UserRiskAreaItemID = T.HARiskAreaItemID
             ,S.LastUpdateID = CT_HFit_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_VERSION
             ,S.LASTLOADEDDATE = GETDATE () 
             ,S.SVR = T.SVR
             ,S.DBNAME = T.DBNAME
             ,DeletedFlg = 0
             ,LastModifiedDate = GETDATE () 
               FROM FACT_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS AS T
                        JOIN DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined AS S
                            ON
                            S.HAUserQuestionGroupResultsItemID = T.ItemID
                        AND S.SVR = T.SVR
                        AND S.DBNAME = T.DBNAME
                        JOIN CHANGETABLE ( CHANGES FACT_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS , @ChangeVersionID) AS CT_HFit_HealthAssesmentUserQuestionGroupResults
                            ON
                            CT_HFit_HealthAssesmentUserQuestionGroupResults.ItemID = T.ItemID
                        AND CT_HFit_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_VERSION != S.LastUpdateID
                        AND CT_HFit_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_OPERATION = 'U'
                        AND CT_HFit_HealthAssesmentUserQuestionGroupResults.SVR = T.SVR
                        AND CT_HFit_HealthAssesmentUserQuestionGroupResults.DBNAME = T.DBNAME;

    RAISERROR ('Populating DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined.' , 10 , 1) WITH NOWAIT;
    EXEC PrintImmediate 'Populating DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined';

    WITH CTE_temp (
         UserRiskAreaItemID
       , HaRiskAreaItemID
       , SVR
       , DBNAME) 
        AS (
        SELECT
               HAUserRiskArea.ITEMID AS UserRiskAreaItemID
             , HAUserQuestionGroupResults.HARiskAreaItemID
             , HAUserRiskArea.svr
             , HAUserRiskArea.dbname
               FROM DBO.FACT_HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea
                        LEFT JOIN DBO.FACT_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS AS HAUserQuestionGroupResults
                            ON HAUserRiskArea.ITEMID = HAUserQuestionGroupResults.HaRiskAreaItemID
                           AND HAUserRiskArea.SVR = HAUserQuestionGroupResults.SVR
                           AND HAUserRiskArea.DBNAME = HAUserQuestionGroupResults.DBNAME
        EXCEPT
        SELECT
               UserRiskAreaItemID
             , HaRiskAreaItemID
             , SVR
             , DBNAME
               FROM DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined
        ) 
        INSERT INTO DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined (
               USERRISKAREAITEMID
             , HARISKCATEGORYITEMID
             , USERRISKAREACODENAME
             , HARISKAREANODEGUID
             , HARISKAREAVERSIONID
             , HARISKAREASCORE
             , RISKAREAPREWEIGHTEDSCORE
             , HAUserRiskArea_ITEMMODIFIEDWHEN
             , HAUserRiskArea_LASTMODIFIED
             , HAUserRiskArea_LastUpdateID
             , HAUserQuestionGroupResultsItemID
             , POINTRESULTS
             , QUESTIONGROUPCODENAME
             , HAUserQuestionGroupResults_LASTMODIFIED
             , HAUserQuestionGroupResults_LastUpdateID
             , LastModifiedWhen
             , LastUpdateID
             , LASTLOADEDDATE
             , SVR
             , DBNAME
             , DeletedFlg
             , LastModifiedDate
        ) 
        SELECT
               T.USERRISKAREAITEMID
             , T.HARISKCATEGORYITEMID
             , T.USERRISKAREACODENAME
             , T.HARISKAREANODEGUID
             , T.HARISKAREAVERSIONID
             , T.HARISKAREASCORE
             , T.RISKAREAPREWEIGHTEDSCORE
             , T.HAUserRiskArea_ITEMMODIFIEDWHEN
             , T.HAUserRiskArea_LASTMODIFIED
             , T.HAUserRiskArea_LastUpdateID
             , T.HAUserQuestionGroupResultsItemID
             , T.POINTRESULTS
             , T.QUESTIONGROUPCODENAME
             , T.HAUserQuestionGroupResults_LASTMODIFIED
             , T.HAUserQuestionGroupResults_LastUpdateID
             , T.LastModifiedWhen
             , 0 AS LastUpdateID
             , GETDATE () AS LASTLOADEDDATE
             , T.SVR
             , T.DBNAME
             , 0 AS DeletedFlg
             , T.LastModifiedWhen AS LAstModifiedDate
               FROM View_EDW_HFIT_HealthAssesmentUserRiskArea_Joined AS T
                        JOIN CTE_temp AS C
                            ON c.UserRiskAreaItemID = T.UserRiskAreaItemID
                           AND c.HaRiskAreaItemID = T.HaRiskAreaItemID
                           AND C.SVR = T.SVR
                           AND C.DBNAME = T.DBNAME;

    --***************************************************************************
    EXEC PrintImmediate 'Populating DIM_EDW_CMS_USER';
    --***************************************************************************
    EXEC @iCnt = proc_QuickRowCount 'DIM_EDW_CMS_USER';

    --Check for the existance of DIM_EDW_CMS_USER
    IF @iCnt = 0
        BEGIN
            EXEC PrintImmediate 'Populating DIM_EDW_CMS_USER';
            truncate TABLE DIM_EDW_CMS_USER;
            INSERT INTO DIM_EDW_CMS_USER
            (
                   USERID
                 , USERGUID
                 , LastModifiedWhen
                 , LastUpdateID
                 , LASTLOADEDDATE
                 , SVR
                 , DBNAME
                 , DeletedFlg
            ) 
            SELECT DISTINCT
                   CMSUSER.USERID
                 , CMSUSER.USERGUID
                 , CMSUSER.UserLastModified AS LastModifiedWhen
                 , 0 AS LastUpdateID
                 , GETDATE () AS LASTLOADEDDATE
                 , SVR
                 , DBNAME
                 , 0 AS DeletedFlg
                   FROM FACT_CMS_USER AS CMSUSER;

        --CREATE CLUSTERED INDEX PI_EDW_CMS_USER ON DIM_EDW_CMS_USER ( USERID ASC , USERGUID) ;
        END;

    DELETE D
           FROM DIM_EDW_CMS_USER D
                    JOIN CHANGETABLE (CHANGES CMS_User , @ChangeVersionID) AS CT_CMS_User
                        ON
                        SYS_CHANGE_OPERATION = 'D'
                    AND CT_CMS_User.UserID = D.UserID
                    AND CT_CMS_User.SVR = D.SVR
                    AND CT_CMS_User.DBNAME = D.DBNAME;

    UPDATE S
           SET
               S.LastUpdateID = CT_CMS_User.SYS_CHANGE_VERSION
             ,S.LASTLOADEDDATE = GETDATE () 
             ,SVR = @@Servername
             ,DBNAME = DB_NAME () 
             ,DeletedFlg = 0
               FROM FACT_CMS_USER AS T
                        JOIN DIM_EDW_CMS_USER AS S
                            ON
                            S.UserID = T.UserID
                        AND S.SVR = T.SVR
                        AND S.DBNAME = T.DBNAME
                        JOIN CHANGETABLE ( CHANGES CMS_User , @ChangeVersionID) AS CT_CMS_User
                            ON
                            CT_CMS_User.UserID = T.USERID
                        AND S.UserGUID = T.UserGUID
                        AND CT_CMS_User.SYS_CHANGE_VERSION != S.LastUpdateID
                        AND CT_CMS_User.SYS_CHANGE_OPERATION = 'U'
                        AND S.SVR = CT_CMS_User.SVR
                        AND S.DBNAME = CT_CMS_User.DBNAME;
    EXEC PrintImmediate 'Populating DIM_EDW_CMS_USER';
    WITH CTE_EDW_CMS_USER (
         SVR
       , DBNAME
       , USERID) 
        AS (
        SELECT
               SVR
             , DBNAME
             , CT_CMS_User.USERID
               FROM CHANGETABLE (CHANGES CMS_User, @ChangeVersionID) AS CT_CMS_User
               WHERE
               SYS_CHANGE_OPERATION = 'I'
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , USERID
               FROM DIM_EDW_CMS_USER
        ) 
        INSERT INTO DIM_EDW_CMS_USER (
               USERID
             , USERGUID
             , LastModifiedWhen
             , LastUpdateID
             , LASTLOADEDDATE
             , SVR
             , DBNAME
             , DeletedFlg) 
        SELECT
               T.USERID
             , T.USERGUID
             , T.UserLastModified AS LastModifiedWhen
             , CT_CMS_User.SYS_CHANGE_VERSION AS LastUpdateID
             , GETDATE () AS LASTLOADEDDATE
             , T.SVR
             , T.DBNAME
             , 0 AS DeletedFlg
               FROM FACT_cms_user AS T
                        JOIN CHANGETABLE (CHANGES CMS_User, @ChangeVersionID) AS CT_CMS_User
                            ON CT_CMS_User.UserID = T.USERID
                           AND CT_CMS_User.SYS_CHANGE_OPERATION = 'I'
                           AND CT_CMS_User.SVR = T.SVR
                           AND CT_CMS_User.DBNAME = T.DBNAME
                        JOIN CTE_EDW_CMS_USER AS C
                            ON c.userid = CT_CMS_User.userid
                           AND c.SVR = CT_CMS_User.SVR
                           AND c.DBNAME = CT_CMS_User.DBNAME;

    --*************************************************************************
    -- drop table DIM_EDW_HFIT_HEALTHASSESMENTUSERSTARTED

    EXEC @iCnt = proc_QuickRowCount 'DIM_EDW_HFIT_HEALTHASSESMENTUSERSTARTED';
    EXEC PrintImmediate 'Populating DIM_EDW_HFIT_HEALTHASSESMENTUSERSTARTED';
    IF @iCnt = 0
        BEGIN
            EXEC PrintImmediate 'Populating DIM_EDW_HFIT_HEALTHASSESMENTUSERSTARTED';
            INSERT INTO DIM_EDW_HFIT_HEALTHASSESMENTUSERSTARTED
            (
                   ITEMID
                 , USERID
                 , HASTARTEDDT
                 , HACOMPLETEDDT
                 , HASCORE
                 , HAPAPERFLG
                 , HATELEPHONICFLG
                 , HASTARTEDMODE
                 , HACOMPLETEDMODE
                 , HACAMPAIGNNODEGUID
                 , HADocumentConfigID
                 , ItemModifiedWhen
                 , LastUpdateID
                 , LASTLOADEDDATE
                 , SVR
                 , DBNAME
                 , DeletedFlg
            ) 
            SELECT
                   HAUSERSTARTED.ITEMID
                 , HAUSERSTARTED.USERID
                 , HAUSERSTARTED.HASTARTEDDT
                 , HAUSERSTARTED.HACOMPLETEDDT
                 , HAUSERSTARTED.HASCORE
                 , HAUSERSTARTED.HAPAPERFLG
                 , HAUSERSTARTED.HATELEPHONICFLG
                 , HAUSERSTARTED.HASTARTEDMODE
                 , HAUSERSTARTED.HACOMPLETEDMODE
                 , HAUSERSTARTED.HACAMPAIGNNODEGUID
                 , HAUserStarted.HADocumentConfigID
                 , HAUserStarted.ItemModifiedWhen
                 , 0 AS LastUpdateID
                 , GETDATE () AS LASTLOADEDDATE
                 , HAUSERSTARTED.SVR
                 , HAUSERSTARTED.DBNAME
                 , 0 AS DeletedFlg
                   FROM FACT_HFIT_HEALTHASSESMENTUSERSTARTED AS HAUSERSTARTED;
        END;

    DELETE D
           FROM DIM_EDW_HFIT_HEALTHASSESMENTUSERSTARTED D
                    JOIN CHANGETABLE ( CHANGES FACT_HFIT_HEALTHASSESMENTUSERSTARTED , @ChangeVersionID) AS CT
                        ON
                        CT.ItemID = D.ItemID
                    AND CT.SVR = D.SVR
                    AND CT.DBNAME = D.DBNAME
                    AND SYS_CHANGE_OPERATION = 'D';

    UPDATE S
           SET
               S.HASTARTEDDT = T.HASTARTEDDT
             ,S.HACOMPLETEDDT = T.HACOMPLETEDDT
             ,S.HASCORE = T.HASCORE
             ,S.HAPAPERFLG = T.HAPAPERFLG
             ,S.HATELEPHONICFLG = T.HATELEPHONICFLG
             ,S.HASTARTEDMODE = T.HASTARTEDMODE
             ,S.HACOMPLETEDMODE = T.HACOMPLETEDMODE
             ,S.HACAMPAIGNNODEGUID = T.HACAMPAIGNNODEGUID
             ,S.HADocumentConfigID = T.HADocumentConfigID
             ,S.ItemModifiedWhen = T.ItemModifiedWhen
             ,S.LastUpdateID = CT_HFIT_HEALTHASSESMENTUSERSTARTED.SYS_CHANGE_VERSION
             ,S.LASTLOADEDDATE = GETDATE () 
             ,S.SVR = @@Servername
             ,S.DBNAME = DB_NAME () 
             ,S.DeletedFlg = 0
               FROM FACT_HFIT_HEALTHASSESMENTUSERSTARTED AS T
                        JOIN DIM_EDW_HFIT_HEALTHASSESMENTUSERSTARTED AS S
                            ON
                            S.ItemID = T.ItemID
                        AND S.SVR = T.SVR
                        AND S.DBNAME = T.DBNAME
                        JOIN CHANGETABLE ( CHANGES HFIT_HEALTHASSESMENTUSERSTARTED , @ChangeVersionID) AS CT_HFIT_HEALTHASSESMENTUSERSTARTED
                            ON
                            CT_HFIT_HEALTHASSESMENTUSERSTARTED.ItemID = T.ItemID
                        AND S.ItemID = T.ItemID
                        AND S.SVR = T.SVR
                        AND S.DBNAME = T.DBNAME
                        AND CT_HFIT_HEALTHASSESMENTUSERSTARTED.SYS_CHANGE_VERSION != S.LastUpdateID
                        AND CT_HFIT_HEALTHASSESMENTUSERSTARTED.SYS_CHANGE_OPERATION = 'U';
    EXEC PrintImmediate 'Populating DIM_EDW_HFIT_HEALTHASSESMENTUSERSTARTED';
    WITH CTE_HFIT_HEALTHASSESMENTUSERSTARTED (
         SVR
       , DBNAME
       , ItemID) 
        AS (
        SELECT
               SVR
             , DBNAME
             , CT_HFIT_HEALTHASSESMENTUSERSTARTED.ItemID
               FROM CHANGETABLE (CHANGES HFIT_HEALTHASSESMENTUSERSTARTED, @ChangeVersionID) AS CT_HFIT_HEALTHASSESMENTUSERSTARTED
               WHERE
               SYS_CHANGE_OPERATION = 'I'
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , itemid
               FROM DIM_EDW_HFIT_HEALTHASSESMENTUSERSTARTED
        ) 
        INSERT INTO DIM_EDW_HFIT_HEALTHASSESMENTUSERSTARTED (
               USERID
             , HASTARTEDDT
             , HACOMPLETEDDT
             , HASCORE
             , HAPAPERFLG
             , HATELEPHONICFLG
             , HASTARTEDMODE
             , HACOMPLETEDMODE
             , HACAMPAIGNNODEGUID
             , HADocumentConfigID
             , ItemModifiedWhen
             , LastUpdateID
             , LASTLOADEDDATE
             , SVR
             , DBNAME
             , DeletedFlg
             , ITEMID) 
        SELECT
               T.USERID
             , T.HASTARTEDDT
             , T.HACOMPLETEDDT
             , T.HASCORE
             , T.HAPAPERFLG
             , T.HATELEPHONICFLG
             , T.HASTARTEDMODE
             , T.HACOMPLETEDMODE
             , T.HACAMPAIGNNODEGUID
             , T.HADocumentConfigID
             , T.ItemModifiedWhen
             , 0 AS LastUpdateID
             , GETDATE () AS LASTLOADEDDATE
             , T.SVR
             , T.DBNAME
             , 0 AS DeletedFlg
             , T.ITEMID
               FROM FACT_HFIT_HEALTHASSESMENTUSERSTARTED AS T
                        JOIN CHANGETABLE (CHANGES FACT_HFIT_HEALTHASSESMENTUSERSTARTED, @ChangeVersionID) AS CT_HFIT_HEALTHASSESMENTUSERSTARTED
                            ON CT_HFIT_HEALTHASSESMENTUSERSTARTED.ItemID = T.ItemID
                           AND CT_HFIT_HEALTHASSESMENTUSERSTARTED.SYS_CHANGE_OPERATION = 'I'
                           AND CT_HFIT_HEALTHASSESMENTUSERSTARTED.SVR = T.SVR
                           AND CT_HFIT_HEALTHASSESMENTUSERSTARTED.DBNAME = T.DBNAME
                        JOIN CTE_HFIT_HEALTHASSESMENTUSERSTARTED AS C
                            ON C.ItemID = T.ItemID
                           AND C.SVR = T.SVR
                           AND C.DBNAME = T.DBNAME;

    --set @iInsertedCnt = @iInsertedCnt + @@ROWCOUNT ;
    --***********************************************************************************

/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
  select top 100 S.LastUpdateID , T.ItemID, * from DIM_EDW_HFIT_HealthAssesmentUserAnswers as S
	   join HFIT_HealthAssesmentUserAnswers as T on T.itemid = S.itemid 
	   join DIM_EDW_HFit_HealthAssesmentUserQuestion as S2 on S2.ItemID = S.ItemID
	   where S.LastUpdateID > 60
	   order by S.LastUpdateID desc
 

 delete from HFIT_HealthAssesmentUserAnswers where ItemID between 131264 and 131268

 select top 100 * from HFIT_HealthAssesmentUserAnswers 
 where ItemID in (SELECT top 100
		  USERANSWERITEMID FROM VIEW_EDW_PULLHADATA_NOCT order by USERANSWERITEMID )

  update HFIT_HealthAssesmentUserAnswers  set codename = lower(codename),itemmodifiedwhen = getdate() where ItemID in (SELECT top 25000
		  USERANSWERITEMID FROM VIEW_EDW_PULLHADATA_NOCT order by USERANSWERITEMID )

  SELECT distinct SYS_CHANGE_VERSION FROM CHANGETABLE ( CHANGES HFIT_HealthAssesmentUserAnswers , NULL) AS CT_HealthAssesmentUserAnswers ORDER BY SYS_CHANGE_VERSION DESC
*/
    EXEC @iCnt = proc_QuickRowCount 'DIM_EDW_HFIT_HealthAssesmentUserAnswers';
    EXEC PrintImmediate 'Populating DIM_EDW_HFIT_HealthAssesmentUserAnswers';
    IF @iCnt = 0
        BEGIN

            EXEC PrintImmediate 'Populating DIM_EDW_HFIT_HealthAssesmentUserAnswers';

            INSERT INTO DIM_EDW_HFIT_HealthAssesmentUserAnswers (
                   ITEMID
                 , HAANSWERNODEGUID
                 , CODENAME
                 , HAANSWERVALUE
                 , HAANSWERPOINTS
                 , UOMCODE
                 , ITEMCREATEDWHEN
                 , ITEMMODIFIEDWHEN
                 , HAQUESTIONITEMID
                 , LastUpdateID
                 , LASTLOADEDDATE
                 , SVR
                 , DBNAME
                 , DeletedFlg
            ) 
            SELECT
                   HAUSERANSWERS.ITEMID
                 , HAUSERANSWERS.HAANSWERNODEGUID
                 , HAUSERANSWERS.CODENAME
                 , HAUSERANSWERS.HAANSWERVALUE
                 , HAUSERANSWERS.HAANSWERPOINTS
                 , HAUSERANSWERS.UOMCODE
                 , HAUSERANSWERS.ITEMCREATEDWHEN
                 , HAUSERANSWERS.ITEMMODIFIEDWHEN
                 , HAUSERANSWERS.HAQUESTIONITEMID
                 , 0 AS LastUpdateID
                 , GETDATE () AS LASTLOADEDDATE
                 , HAUSERANSWERS.SVR
                 , HAUSERANSWERS.DBNAME
                 , 0 AS DeletedFlg
                   FROM FACT_HFIT_HealthAssesmentUserAnswers AS HAUSERANSWERS;
        END;

    DELETE T
           FROM DIM_EDW_HFIT_HealthAssesmentUserAnswers T
                    JOIN CHANGETABLE (CHANGES FACT_HFIT_HealthAssesmentUserAnswers , @ChangeVersionID) AS CT
                        ON
                        CT.SVR = T.SVR
                    AND CT.DBNAME = T.DBNAME
                    AND CT.SYS_CHANGE_OPERATION = 'D';

    UPDATE S
           SET
               S.HAANSWERNODEGUID = T.HAANSWERNODEGUID
             ,S.CODENAME = T.CODENAME
             ,S.HAANSWERVALUE = T.HAANSWERVALUE
             ,S.HAANSWERPOINTS = T.HAANSWERPOINTS
             ,S.UOMCODE = T.UOMCODE
             ,S.ITEMCREATEDWHEN = T.ITEMCREATEDWHEN
             ,S.ITEMMODIFIEDWHEN = T.ITEMMODIFIEDWHEN
             ,S.HAQUESTIONITEMID = T.HAQUESTIONITEMID
             ,S.LastUpdateID = CT_HealthAssesmentUserAnswers.SYS_CHANGE_VERSION
             ,S.LASTLOADEDDATE = GETDATE () 
             ,SVR = @@Servername
             ,DBNAME = DB_NAME () 
             ,DeletedFlg = 0
               FROM FACT_HFIT_HealthAssesmentUserAnswers AS T
                        JOIN DIM_EDW_HFIT_HealthAssesmentUserAnswers AS S
                            ON
                            S.ItemID = T.ItemID
                        AND S.SVR = T.SVR
                        AND S.DBNAME = T.DBNAME
                        JOIN CHANGETABLE ( CHANGES FACT_HFIT_HealthAssesmentUserAnswers , @ChangeVersionID) AS CT_HealthAssesmentUserAnswers
                            ON
                            CT_HealthAssesmentUserAnswers.ItemID = T.ItemID
                        AND CT_HealthAssesmentUserAnswers.SVR = T.SVR
                        AND CT_HealthAssesmentUserAnswers.DBNAME = T.DBNAME
                        AND CT_HealthAssesmentUserAnswers.SYS_CHANGE_VERSION != S.LastUpdateID
                        AND CT_HealthAssesmentUserAnswers.SYS_CHANGE_OPERATION = 'U';
    EXEC PrintImmediate 'Populating DIM_EDW_HFIT_HealthAssesmentUserAnswers';
    WITH CTE_temp (
         SVR
       , DBNAME
       , ItemID) 
        AS (
        SELECT
               SVR
             , DBNAME
             , CTE_temp.ItemID
               FROM CHANGETABLE (CHANGES FACT_HFIT_HealthAssesmentUserAnswers, @ChangeVersionID) AS CTE_temp
               WHERE
               SYS_CHANGE_OPERATION = 'I'
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , ItemID
               FROM DIM_EDW_HFIT_HealthAssesmentUserAnswers
        ) 
        INSERT INTO DIM_EDW_HFIT_HealthAssesmentUserAnswers (
               HAANSWERNODEGUID
             , CODENAME
             , HAANSWERVALUE
             , HAANSWERPOINTS
             , UOMCODE
             , ITEMCREATEDWHEN
             , ITEMMODIFIEDWHEN
             , HAQUESTIONITEMID
             , LastUpdateID
             , LASTLOADEDDATE
             , SVR
             , DBNAME
             , DeletedFlg
             , ITEMID) 
        SELECT
               T.HAANSWERNODEGUID
             , T.CODENAME
             , T.HAANSWERVALUE
             , T.HAANSWERPOINTS
             , T.UOMCODE
             , T.ITEMCREATEDWHEN
             , T.ITEMMODIFIEDWHEN
             , T.HAQUESTIONITEMID
             , CT_HealthAssesmentUserAnswers.SYS_CHANGE_VERSION AS LastUpdateID
             , GETDATE () AS LASTLOADEDDATE
             , T.SVR
             , T.DBNAME
             , 0 AS DeletedFlg
             , T.ITEMID
               FROM FACT_HFIT_HealthAssesmentUserAnswers AS T
                        JOIN CHANGETABLE (CHANGES FACT_HFIT_HealthAssesmentUserAnswers, @ChangeVersionID) AS CT_HealthAssesmentUserAnswers
                            ON CT_HealthAssesmentUserAnswers.ItemID = T.ItemID
                           AND CT_HealthAssesmentUserAnswers.SYS_CHANGE_OPERATION = 'I'
                           AND CT_HealthAssesmentUserAnswers.SVR = T.SVR
                           AND CT_HealthAssesmentUserAnswers.DBNAME = T.DBNAME
                        JOIN CTE_temp AS C
                            ON c.ItemID = CT_HealthAssesmentUserAnswers.ItemID
                           AND CT_HealthAssesmentUserAnswers.SVR = C.SVR
                           AND CT_HealthAssesmentUserAnswers.DBNAME = C.DBNAME;
    --set @iInsertedCnt = @iInsertedCnt + @@ROWCOUNT ;

    --***********************************************************************************
    --drop table DIM_EDW_CMS_USERSITE
    --select CT_TEMP.USERSITEID, CT_TEMP.SYS_CHANGE_VERSION from CHANGETABLE (CHANGES FACT_CMS_USERSITE , NULL) AS CT_TEMP where SYS_CHANGE_OPERATION = 'U'
    --select * from DIM_EDW_CMS_USERSITE
    --select top 100 * from FACT_CMS_USERSITE
    --select top 100 * from DIM_EDW_CMS_USERSITE
    --update FACT_CMS_USERSITE set UserPreferredCurrencyID = NULL where UserSiteID = 22594   --changes nothing, just enters a rec into CT

    EXEC @iCnt = proc_QuickRowCount 'DIM_EDW_CMS_USERSITE';
    EXEC PrintImmediate 'Populating DIM_EDW_CMS_USERSITE';
    IF @iCnt = 0
        BEGIN

            EXEC PrintImmediate 'Populating DIM_EDW_CMS_USERSITE';
            INSERT INTO DIM_EDW_CMS_USERSITE
            (
                   USERSITEID
                 , USERID
                 , SITEID
                 , LastUpdateID
                 , LASTLOADEDDATE
                 , SVR
                 , DBNAME
                 , DeletedFlg
            ) 
            SELECT
                   USERSITE.USERSITEID
                 , USERSITE.USERID
                 , USERSITE.SITEID
                 , 0 AS LastUpdateID
                 , GETDATE () AS LASTLOADEDDATE
                 , USERSITE.SVR
                 , USERSITE.DBNAME
                 , 0 AS DeletedFlg
                   FROM FACT_CMS_USERSITE AS USERSITE;
        END;

    DELETE D
           FROM DIM_EDW_CMS_USERSITE D
                    JOIN CHANGETABLE (CHANGES FACT_CMS_USERSITE , @ChangeVersionID) AS CT_XXX
                        ON
                        CT_XXX.SVR = D.SVR
                    AND CT_XXX.DBNAME = D.DBNAME
                    AND CT_XXX.UserSiteID = D.UserSiteID
                    AND SYS_CHANGE_OPERATION = 'D';

    UPDATE S
           SET
               S.USERID = T.USERID
             ,S.SITEID = T.SITEID
             ,S.LastUpdateID = CT_CMS_USERSITE.SYS_CHANGE_VERSION
             ,S.LASTLOADEDDATE = GETDATE () 
             ,S.SVR = T.SVR
             ,S.DBNAME = T.DBNAME
             ,S.DeletedFlg = 0
               FROM FACT_CMS_USERSITE AS T
                        JOIN DIM_EDW_CMS_USERSITE AS S
                            ON
                            S.UserSiteID = T.UserSiteID
                        AND S.SVR = T.SVR
                        AND S.DBNAME = T.DBNAME
                        JOIN CHANGETABLE ( CHANGES FACT_CMS_USERSITE , @ChangeVersionID) AS CT_CMS_USERSITE
                            ON
                            CT_CMS_USERSITE.UserSiteID = T.UserSiteID
                        AND CT_CMS_USERSITE.SVR = T.SVR
                        AND CT_CMS_USERSITE.DBNAME = T.DBNAME
                        AND CT_CMS_USERSITE.SYS_CHANGE_VERSION != S.LastUpdateID
                        AND CT_CMS_USERSITE.SYS_CHANGE_OPERATION = 'U';
    EXEC PrintImmediate 'Populating DIM_EDW_CMS_USERSITE';
    WITH CTE_temp (
         SVR
       , DBNAME
       , UserSiteID) 
        AS (
        SELECT
               SVR
             , DBNAME
             , CTE_temp.UserSiteID
               FROM CHANGETABLE (CHANGES FACT_CMS_USERSITE, @ChangeVersionID) AS CTE_temp
               WHERE
               SYS_CHANGE_OPERATION = 'I'
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , UserSiteID
               FROM DIM_EDW_CMS_USERSITE
        ) 
        INSERT INTO DIM_EDW_CMS_USERSITE (
               USERID
             , SITEID
             , LastUpdateID
             , LASTLOADEDDATE
             , SVR
             , DBNAME
             , DeletedFlg
             , USERSITEID) 
        SELECT
               T.USERID
             , T.SITEID
             , CT_CMS_USERSITE.SYS_CHANGE_VERSION AS LastUpdateID
             , GETDATE () AS LASTLOADEDDATE
             , T.SVR
             , T.DBNAME
             , 0 AS DeletedFlg
             , T.USERSITEID
               FROM FACT_CMS_USERSITE AS T
                        JOIN CHANGETABLE (CHANGES FACT_CMS_USERSITE, @ChangeVersionID) AS CT_CMS_USERSITE
                            ON CT_CMS_USERSITE.UserSiteID = T.UserSiteID
                           AND CT_CMS_USERSITE.SYS_CHANGE_OPERATION = 'I'
                           AND CT_CMS_USERSITE.SVR = T.SVR
                           AND CT_CMS_USERSITE.DBNAME = T.DBNAME
                        JOIN CTE_temp AS C
                            ON c.UserSiteID = CT_CMS_USERSITE.UserSiteID
                           AND CT_CMS_USERSITE.SVR = C.SVR
                           AND CT_CMS_USERSITE.DBNAME = C.DBNAME;
    --set @iInsertedCnt = @iInsertedCnt + @@ROWCOUNT ;

    --***********************************************************************************
    --drop table DIM_EDW_HFIT_HEALTHASSESMENTUSERMODULE
    --select CT_TEMP.ItemID, CT_TEMP.SYS_CHANGE_VERSION from CHANGETABLE (CHANGES HFIT_HEALTHASSESMENTUSERMODULE , NULL) AS CT_TEMP where SYS_CHANGE_OPERATION = 'U'
    --select * from DIM_EDW_HFIT_HEALTHASSESMENTUSERMODULE
    --select top 100 * from HFIT_HEALTHASSESMENTUSERMODULE
    --select top 100 * from DIM_EDW_HFIT_HEALTHASSESMENTUSERMODULE
    --update HFIT_HEALTHASSESMENTUSERMODULE set CodeName = 'AboutYou' where itemid = 10257

    EXEC @iCnt = proc_QuickRowCount 'DIM_EDW_HFIT_HEALTHASSESMENTUSERMODULE';
    EXEC PrintImmediate 'Populating DIM_EDW_HFIT_HEALTHASSESMENTUSERMODULE';
    IF @iCnt = 0
        BEGIN

            EXEC PrintImmediate 'Populating DIM_EDW_HFIT_HEALTHASSESMENTUSERMODULE';
            INSERT INTO DIM_EDW_HFIT_HEALTHASSESMENTUSERMODULE
            (
                   HASTARTEDITEMID
                 , ITEMID
                 , CODENAME
                 , HAMODULENODEGUID
                 , HAMODULESCORE
                 , PREWEIGHTEDSCORE
                 , LastUpdateID
                 , LASTLOADEDDATE
                 , SVR
                 , DBNAME
                 , DeletedFlg
            ) 
            SELECT
                   HAUSERMODULE.HASTARTEDITEMID
                 , HAUSERMODULE.ITEMID
                 , HAUSERMODULE.CODENAME
                 , HAUSERMODULE.HAMODULENODEGUID
                 , HAUSERMODULE.HAMODULESCORE
                 , HAUSERMODULE.PREWEIGHTEDSCORE
                 , 0 AS LastUpdateID
                 , GETDATE () AS LASTLOADEDDATE
                 , HAUSERMODULE.SVR
                 , HAUSERMODULE.DBNAME
                 , 0 AS DeletedFlg
                   FROM FACT_HFIT_HEALTHASSESMENTUSERMODULE AS HAUSERMODULE;
        END;

    DELETE D
           FROM DIM_EDW_HFIT_HEALTHASSESMENTUSERMODULE D
                    JOIN CHANGETABLE (CHANGES FACT_HFIT_HEALTHASSESMENTUSERMODULE , @ChangeVersionID) AS CT_HFIT_HEALTHASSESMENTUSERMODULE
                        ON
                        CT_HFIT_HEALTHASSESMENTUSERMODULE.ItemID = D.ItemID
                    AND CT_HFIT_HEALTHASSESMENTUSERMODULE.SVR = D.SVR
                    AND CT_HFIT_HEALTHASSESMENTUSERMODULE.DBNAME = D.DBNAME
                    AND SYS_CHANGE_OPERATION = 'D';

    UPDATE S
           SET
               S.HASTARTEDITEMID = T.HASTARTEDITEMID
             ,S.CODENAME = T.CODENAME
             ,S.HAMODULENODEGUID = T.HAMODULENODEGUID
             ,S.HAMODULESCORE = T.HAMODULESCORE
             ,S.PREWEIGHTEDSCORE = T.PREWEIGHTEDSCORE
             ,S.LastUpdateID = CT_HFIT_HEALTHASSESMENTUSERMODULE.SYS_CHANGE_VERSION
             ,S.LASTLOADEDDATE = GETDATE () 
             ,S.SVR = T.SVR
             ,S.DBNAME = T.DBNAME
             ,DeletedFlg = 0
               FROM FACT_HFIT_HEALTHASSESMENTUSERMODULE AS T
                        JOIN DIM_EDW_HFIT_HEALTHASSESMENTUSERMODULE AS S
                            ON
                            S.ItemID = T.ItemID
                        AND S.SVR = T.SVR
                        AND S.DBNAME = T.DBNAME
                        JOIN CHANGETABLE ( CHANGES FACT_HFIT_HEALTHASSESMENTUSERMODULE , @ChangeVersionID) AS CT_HFIT_HEALTHASSESMENTUSERMODULE
                            ON
                            CT_HFIT_HEALTHASSESMENTUSERMODULE.ItemID = T.ItemID
                        AND CT_HFIT_HEALTHASSESMENTUSERMODULE.SVR = T.SVR
                        AND CT_HFIT_HEALTHASSESMENTUSERMODULE.DBNAME = T.DBNAME
                        AND CT_HFIT_HEALTHASSESMENTUSERMODULE.SYS_CHANGE_VERSION != S.LastUpdateID
                        AND CT_HFIT_HEALTHASSESMENTUSERMODULE.SYS_CHANGE_OPERATION = 'U';

    EXEC PrintImmediate 'Populating DIM_EDW_HFIT_HEALTHASSESMENTUSERMODULE';
    WITH CTE_temp (
         SVR
       , DBNAME
       , ItemID) 
        AS (
        SELECT
               SVR
             , DBNAME
             , CTE_temp.ItemID
               FROM CHANGETABLE (CHANGES HFIT_HEALTHASSESMENTUSERMODULE, @ChangeVersionID) AS CTE_temp
               WHERE
               SYS_CHANGE_OPERATION = 'I'
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , ItemID
               FROM DIM_EDW_HFIT_HEALTHASSESMENTUSERMODULE
        ) 
        INSERT INTO DIM_EDW_HFIT_HEALTHASSESMENTUSERMODULE (
               HASTARTEDITEMID
             , CODENAME
             , HAMODULENODEGUID
             , HAMODULESCORE
             , PREWEIGHTEDSCORE
             , LastUpdateID
             , LASTLOADEDDATE
             , SVR
             , DBNAME
             , DeletedFlg
             , ITEMID) 
        SELECT
               T.HASTARTEDITEMID
             , T.CODENAME
             , T.HAMODULENODEGUID
             , T.HAMODULESCORE
             , T.PREWEIGHTEDSCORE
             , CT_HFIT_HEALTHASSESMENTUSERMODULE.SYS_CHANGE_VERSION AS LastUpdateID
             , GETDATE () AS LASTLOADEDDATE
             , T.SVR
             , T.DBNAME
             , 0 AS DeletedFlg
             , T.ITEMID
               FROM FACT_HFIT_HEALTHASSESMENTUSERMODULE AS T
                        JOIN CHANGETABLE (CHANGES FACT_HFIT_HEALTHASSESMENTUSERMODULE, @ChangeVersionID) AS CT_HFIT_HEALTHASSESMENTUSERMODULE
                            ON CT_HFIT_HEALTHASSESMENTUSERMODULE.ItemID = T.ItemID
                           AND CT_HFIT_HEALTHASSESMENTUSERMODULE.SYS_CHANGE_OPERATION = 'I'
                           AND CT_HFIT_HEALTHASSESMENTUSERMODULE.SVR = T.SVR
                           AND CT_HFIT_HEALTHASSESMENTUSERMODULE.DBNAME = T.DBNAME
                        JOIN CTE_temp AS C
                            ON c.ItemID = CT_HFIT_HEALTHASSESMENTUSERMODULE.ItemID
                           AND CT_HFIT_HEALTHASSESMENTUSERMODULE.SVR = C.SVR
                           AND CT_HFIT_HEALTHASSESMENTUSERMODULE.DBNAME = C.DBNAME;
    --set @iInsertedCnt = @iInsertedCnt + @@ROWCOUNT ;

    --***********************************************************************************
    --drop table DIM_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY
    --select CT_TEMP.ItemID, CT_TEMP.SYS_CHANGE_VERSION from CHANGETABLE (CHANGES HFIT_HEALTHASSESMENTUSERRISKCATEGORY , NULL) AS CT_TEMP where SYS_CHANGE_OPERATION = 'U'
    --select * from DIM_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY
    --select top 100 * from HFIT_HEALTHASSESMENTUSERRISKCATEGORY
    --select top 100 * from DIM_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY
    --update HFIT_HEALTHASSESMENTUSERRISKCATEGORY set CodeName = 'AboutYou' where itemid = 32919

    EXEC @iCnt = proc_QuickRowCount 'DIM_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY';
    EXEC PrintImmediate 'Populating DIM_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY';
    IF @iCnt = 0
        BEGIN
            EXEC PrintImmediate 'Populating DIM_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY';
            INSERT INTO DIM_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY
            (
                   ITEMID
                 , CODENAME
                 , HARISKCATEGORYNODEGUID
                 , HARISKCATEGORYSCORE
                 , PREWEIGHTEDSCORE
                 , ITEMMODIFIEDWHEN
                 , HAMODULEITEMID
                 , LastUpdateID
                 , LASTLOADEDDATE
                 , SVR
                 , DBNAME
                 , DeletedFlg
            ) 
            SELECT
                   HARISKCATEGORY.ITEMID
                 , HARISKCATEGORY.CODENAME
                 , HARISKCATEGORY.HARISKCATEGORYNODEGUID
                 , HARISKCATEGORY.HARISKCATEGORYSCORE
                 , HARISKCATEGORY.PREWEIGHTEDSCORE
                 , HARISKCATEGORY.ITEMMODIFIEDWHEN
                 , HARISKCATEGORY.HAMODULEITEMID
                 , 0 AS LastUpdateID
                 , GETDATE () AS LASTLOADEDDATE
                 , SVR
                 , DBNAME
                 , 0 AS DeletedFlg
                   FROM FACT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY AS HARISKCATEGORY;
        END;

    DELETE D
           FROM DIM_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY D
                    JOIN CHANGETABLE (CHANGES FACT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY , @ChangeVersionID) AS CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY
                        ON
                        SYS_CHANGE_OPERATION = 'D'
                    AND CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.SVR = D.SVR
                    AND CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.DBNAME = D.DBNAME;

    UPDATE S
           SET
               S.CODENAME = T.CODENAME
             ,S.HARISKCATEGORYNODEGUID = T.HARISKCATEGORYNODEGUID
             ,S.HARISKCATEGORYSCORE = T.HARISKCATEGORYSCORE
             ,S.PREWEIGHTEDSCORE = T.PREWEIGHTEDSCORE
             ,S.ITEMMODIFIEDWHEN = T.ITEMMODIFIEDWHEN
             ,S.HAMODULEITEMID = T.HAMODULEITEMID
             ,S.LastUpdateID = CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.SYS_CHANGE_VERSION
             ,S.LASTLOADEDDATE = GETDATE () 
             ,S.SVR = T.SVR
             ,S.DBNAME = T.DBNAME
             ,DeletedFlg = 0
               FROM FACT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY AS T
                        JOIN DIM_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY AS S
                            ON
                            S.ItemID = T.ItemID
                        AND S.SVR = T.SVR
                        AND S.DBNAME = T.DBNAME
                        JOIN CHANGETABLE ( CHANGES FACT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY , @ChangeVersionID) AS CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY
                            ON
                            CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.ItemID = T.ItemID
                        AND CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.SYS_CHANGE_VERSION != S.LastUpdateID
                        AND CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.SYS_CHANGE_OPERATION = 'U'
                        AND S.SVR = CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.SVR
                        AND S.DBNAME = CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.DBNAME;
    EXEC PrintImmediate 'Populating DIM_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY';
    WITH CTE_temp (
         SVR
       , DBNAME
       , ItemID) 
        AS (
        SELECT
               SVR
             , DBNAME
             , CTE_temp.ItemID
               FROM CHANGETABLE (CHANGES FACT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY, @ChangeVersionID) AS CTE_temp
               WHERE
               SYS_CHANGE_OPERATION = 'I'
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , ItemID
               FROM DIM_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY
        ) 
        INSERT INTO DIM_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY (
               ITEMID
             , CODENAME
             , HARISKCATEGORYNODEGUID
             , HARISKCATEGORYSCORE
             , PREWEIGHTEDSCORE
             , ITEMMODIFIEDWHEN
             , HAMODULEITEMID
             , LastUpdateID
             , LASTLOADEDDATE
             , SVR
             , DBNAME
             , DeletedFlg) 
        SELECT
               T.ITEMID
             , T.CODENAME
             , T.HARISKCATEGORYNODEGUID
             , T.HARISKCATEGORYSCORE
             , T.PREWEIGHTEDSCORE
             , T.ITEMMODIFIEDWHEN
             , T.HAMODULEITEMID
             , CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.SYS_CHANGE_VERSION AS LastUpdateID
             , GETDATE () AS LASTLOADEDDATE
             , T.SVR
             , T.DBNAME
             , 0 AS DeletedFlg
               FROM FACT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY AS T
                        JOIN CHANGETABLE (CHANGES FACT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY, @ChangeVersionID) AS CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY
                            ON CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.ItemID = T.ItemID
                           AND CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.SYS_CHANGE_OPERATION = 'I'
                           AND CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.SVR = T.SVR
                           AND CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.DBNAME = T.DBNAME
                        JOIN CTE_temp AS C
                            ON c.ItemID = CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.ItemID
                           AND CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.SVR = C.SVR
                           AND CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.DBNAME = C.DBNAME;
    --set @iInsertedCnt = @iInsertedCnt + @@ROWCOUNT ;

    --***********************************************************************************
    --drop table DIM_EDW_CMS_USERSETTINGS
    --select CT_TEMP.UserSettingID, CT_TEMP.SYS_CHANGE_VERSION from CHANGETABLE (CHANGES CMS_USERSETTINGS , NULL) AS CT_TEMP where SYS_CHANGE_OPERATION = 'U'
    --select * from DIM_EDW_CMS_USERSETTINGS
    --select top 100 * from CMS_USERSETTINGS
    --select top 100 * from DIM_EDW_CMS_USERSETTINGS
    --update CMS_USERSETTINGS set UserNickName = 'XXX' where UserSettingsID = 63971
    --update CMS_USERSETTINGS set UserNickName = null where UserSettingsID = 63971

    EXEC @iCnt = proc_QuickRowCount 'DIM_EDW_CMS_USERSETTINGS';
    EXEC PrintImmediate 'Populating DIM_EDW_CMS_USERSETTINGS';
    IF @iCnt = 0
        BEGIN

            EXEC PrintImmediate 'Populating DIM_EDW_CMS_USERSETTINGS';
            INSERT INTO DIM_EDW_CMS_USERSETTINGS
            (
                   USERSETTINGSID
                 , USERSETTINGSUSERID
                 , HFITUSERMPINUMBER
                 , LastUpdateID
                 , LASTLOADEDDATE
                 , SVR
                 , DBNAME
                 , DeletedFlg
            ) 
            SELECT
                   USERSETTINGS.USERSETTINGSID
                 , USERSETTINGS.USERSETTINGSUSERID
                 , USERSETTINGS.HFITUSERMPINUMBER
                 , 0 AS LastUpdateID
                 , GETDATE () AS LASTLOADEDDATE
                 , USERSETTINGS.SVR
                 , USERSETTINGS.DBNAME
                 , 0 AS DeletedFlg
                   FROM FACT_CMS_USERSETTINGS AS USERSETTINGS;
        END;

    --select * from CHANGETABLE (CHANGES FACT_CMS_USERSETTINGS , @ChangeVersionID) AS CT_CMS_USERSETTINGS
    DELETE D
           FROM DIM_EDW_CMS_USERSETTINGS D
                    JOIN CHANGETABLE (CHANGES FACT_CMS_USERSETTINGS , @ChangeVersionID) AS CT_CMS_USERSETTINGS
                        ON
                        SYS_CHANGE_OPERATION = 'D'
                    AND D.SVR = CT_CMS_USERSETTINGS.SVR
                    AND D.DBNAME = CT_CMS_USERSETTINGS.DBNAME;

    UPDATE S
           SET
               S.USERSETTINGSUSERID = T.USERSETTINGSUSERID
             ,S.HFITUSERMPINUMBER = T.HFITUSERMPINUMBER
             ,S.LastUpdateID = CT_CMS_USERSETTINGS.SYS_CHANGE_VERSION
             ,S.LASTLOADEDDATE = GETDATE () 
             ,S.SVR = T.SVR
             ,S.DBNAME = T.DBNAME
             ,DeletedFlg = 0
               FROM FACT_CMS_USERSETTINGS AS T
                        JOIN DIM_EDW_CMS_USERSETTINGS AS S
                            ON
                            S.USERSETTINGSID = T.USERSETTINGSID
                        JOIN CHANGETABLE ( CHANGES FACT_CMS_USERSETTINGS , @ChangeVersionID) AS CT_CMS_USERSETTINGS
                            ON
                            CT_CMS_USERSETTINGS.USERSETTINGSID = T.USERSETTINGSID
                        AND CT_CMS_USERSETTINGS.SYS_CHANGE_VERSION != S.LastUpdateID
                        AND CT_CMS_USERSETTINGS.SYS_CHANGE_OPERATION = 'U';

    EXEC PrintImmediate 'Populating DIM_EDW_CMS_USERSETTINGS';
    WITH CTE_temp (
         SVR
       , DBNAME
       , USERSETTINGSID) 
        AS (
        SELECT
               SVR
             , DBNAME
             , CTE_temp.USERSETTINGSID
               FROM CHANGETABLE (CHANGES FACT_CMS_USERSETTINGS, @ChangeVersionID) AS CTE_temp
               WHERE
               SYS_CHANGE_OPERATION = 'I'
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , USERSETTINGSID
               FROM DIM_EDW_CMS_USERSETTINGS
        ) 
        INSERT INTO DIM_EDW_CMS_USERSETTINGS (
               USERSETTINGSUSERID
             , HFITUSERMPINUMBER
             , LastUpdateID
             , LASTLOADEDDATE
             , SVR
             , DBNAME
             , DeletedFlg
             , USERSETTINGSID) 
        SELECT
               T.USERSETTINGSUSERID
             , T.HFITUSERMPINUMBER
             , CT_CMS_USERSETTINGS.SYS_CHANGE_VERSION AS LastUpdateID
             , GETDATE () AS LASTLOADEDDATE
             , T.SVR
             , T.DBNAME
             , 0 AS DeletedFlg
             , T.USERSETTINGSID
               FROM FACT_CMS_USERSETTINGS AS T
                        JOIN CHANGETABLE (CHANGES FACT_CMS_USERSETTINGS, @ChangeVersionID) AS CT_CMS_USERSETTINGS
                            ON CT_CMS_USERSETTINGS.USERSETTINGSID = T.USERSETTINGSID
                           AND CT_CMS_USERSETTINGS.SYS_CHANGE_OPERATION = 'I'
                           AND CT_CMS_USERSETTINGS.SVR = T.SVR
                           AND CT_CMS_USERSETTINGS.DBNAME = T.DBNAME
                        JOIN CTE_temp AS C
                            ON c.USERSETTINGSID = CT_CMS_USERSETTINGS.USERSETTINGSID
                           AND CT_CMS_USERSETTINGS.SVR = C.SVR
                           AND CT_CMS_USERSETTINGS.DBNAME = C.DBNAME;

    --set @iInsertedCnt = @iInsertedCnt + @@ROWCOUNT ;

    --***********************************************************************************
    --drop table DIM_EDW_HFit_HealthAssesmentUserRiskArea
    --select CT_TEMP.ItemID, CT_TEMP.SYS_CHANGE_VERSION from CHANGETABLE (CHANGES FACT_HFit_HealthAssesmentUserRiskArea , NULL) AS CT_TEMP where SYS_CHANGE_OPERATION = 'U'
    --select * from DIM_EDW_HFit_HealthAssesmentUserRiskArea
    --select top 100 * from FACT_HFit_HealthAssesmentUserRiskArea
    --select top 100 * from DIM_EDW_HFit_HealthAssesmentUserRiskArea
    --update FACT_HFit_HealthAssesmentUserRiskArea set CodeName = 'AboutYou' where itemid = 46664

    EXEC @iCnt = proc_QuickRowCount 'DIM_EDW_HFit_HealthAssesmentUserRiskArea';
    EXEC PrintImmediate 'Populating DIM_EDW_HFit_HealthAssesmentUserRiskArea';
    IF @iCnt = 0
        BEGIN

            EXEC PrintImmediate 'Populating DIM_EDW_HFit_HealthAssesmentUserRiskArea';
            INSERT INTO DIM_EDW_HFit_HealthAssesmentUserRiskArea
            (
                   ITEMID
                 , CODENAME
                 , HARISKAREANODEGUID
                 , HARISKAREASCORE
                 , PREWEIGHTEDSCORE
                 , ITEMMODIFIEDWHEN
                 , HARISKCATEGORYITEMID
                 , LastUpdateID
                 , LASTLOADEDDATE
                 , SVR
                 , DBNAME
                 , DeletedFlg
            ) 
            SELECT
                   HAUserRiskArea.ItemID
                 , HAUserRiskArea.CODENAME
                 , HAUserRiskArea.HARISKAREANODEGUID
                 , HAUserRiskArea.HARISKAREASCORE
                 , HAUserRiskArea.PREWEIGHTEDSCORE
                 , HAUserRiskArea.ITEMMODIFIEDWHEN
                 , HAUserRiskArea.HARISKCATEGORYITEMID
                 , 0 AS LastUpdateID
                 , GETDATE () AS LASTLOADEDDATE
                 , HAUserRiskArea.SVR
                 , HAUserRiskArea.DBNAME
                 , 0 AS DeletedFlg
                   FROM FACT_HFIT_HealthAssesmentUserRiskArea AS HAUserRiskArea;

        END;
    DELETE FROM DIM_EDW_HFit_HealthAssesmentUserRiskArea
    WHERE
          ItemID IN ( SELECT
                             CT_HFit_HealthAssesmentUserRiskArea.ItemID
                             FROM CHANGETABLE (CHANGES FACT_HFit_HealthAssesmentUserRiskArea, @ChangeVersionID) AS CT_HFit_HealthAssesmentUserRiskArea
                             WHERE
                             SYS_CHANGE_OPERATION = 'D') ;
    UPDATE S
           SET
               S.CODENAME = T.CODENAME
             ,S.HARISKAREANODEGUID = T.HARISKAREANODEGUID
             ,S.HARISKAREASCORE = T.HARISKAREASCORE
             ,S.PREWEIGHTEDSCORE = T.PREWEIGHTEDSCORE
             ,S.ITEMMODIFIEDWHEN = T.ITEMMODIFIEDWHEN
             ,S.HARISKCATEGORYITEMID = T.HARISKCATEGORYITEMID
             ,S.LastUpdateID = CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_VERSION
             ,S.LASTLOADEDDATE = GETDATE () 
             ,S.SVR = T.SVR
             ,S.DBNAME = T.DBNAME
             ,DeletedFlg = 0
               FROM FACT_HFit_HealthAssesmentUserRiskArea AS T
                        JOIN DIM_EDW_HFit_HealthAssesmentUserRiskArea AS S
                            ON
                            S.ItemID = T.ItemID
                        JOIN CHANGETABLE ( CHANGES FACT_HFit_HealthAssesmentUserRiskArea , @ChangeVersionID) AS CT_HFit_HealthAssesmentUserRiskArea
                            ON
                            CT_HFit_HealthAssesmentUserRiskArea.ItemID = T.ItemID
                        AND CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_VERSION != S.LastUpdateID
                        AND CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_OPERATION = 'U';

    EXEC PrintImmediate 'Populating DIM_EDW_HFit_HealthAssesmentUserRiskArea';
    WITH CTE_temp (
         SVR
       , DBNAME
       , ItemID) 
        AS (
        SELECT
               SVR
             , DBNAME
             , CTE_temp.ItemID
               FROM CHANGETABLE (CHANGES FACT_HFit_HealthAssesmentUserRiskArea, @ChangeVersionID) AS CTE_temp
               WHERE
               SYS_CHANGE_OPERATION = 'I'
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , ItemID
               FROM DIM_EDW_HFit_HealthAssesmentUserRiskArea
        ) 
        INSERT INTO DIM_EDW_HFit_HealthAssesmentUserRiskArea (
               CODENAME
             , HARISKAREANODEGUID
             , HARISKAREASCORE
             , PREWEIGHTEDSCORE
             , ITEMMODIFIEDWHEN
             , HARISKCATEGORYITEMID
             , LastUpdateID
             , LASTLOADEDDATE
             , SVR
             , DBNAME
             , DeletedFlg
             , ITEMID) 
        SELECT
               T.CODENAME
             , T.HARISKAREANODEGUID
             , T.HARISKAREASCORE
             , T.PREWEIGHTEDSCORE
             , T.ITEMMODIFIEDWHEN
             , T.HARISKCATEGORYITEMID
             , CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_VERSION AS LastUpdateID
             , GETDATE () AS LASTLOADEDDATE
             , T.SVR
             , T.DBNAME
             , 0 AS DeletedFlg
             , T.ITEMID
               FROM FACT_HFit_HealthAssesmentUserRiskArea AS T
                        JOIN CHANGETABLE (CHANGES FACT_HFit_HealthAssesmentUserRiskArea, @ChangeVersionID) AS CT_HFit_HealthAssesmentUserRiskArea
                            ON CT_HFit_HealthAssesmentUserRiskArea.ItemID = T.ItemID
                           AND CT_HFit_HealthAssesmentUserRiskArea.SVR = T.SVR
                           AND CT_HFit_HealthAssesmentUserRiskArea.DBNAME = T.DBNAME
                           AND CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_OPERATION = 'I'
                        JOIN CTE_temp AS C
                            ON c.ItemID = CT_HFit_HealthAssesmentUserRiskArea.ItemID
                           AND c.SVR = CT_HFit_HealthAssesmentUserRiskArea.SVR
                           AND c.DBNAME = CT_HFit_HealthAssesmentUserRiskArea.DBNAME;
    --set @iInsertedCnt = @iInsertedCnt + @@ROWCOUNT ;

    --***********************************************************************************		 
    --drop table DIM_EDW_HFit_HealthAssesmentUserQuestionGroupResults
    --select CT_TEMP.ItemID, CT_TEMP.SYS_CHANGE_VERSION from CHANGETABLE (CHANGES FACT_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS , NULL) AS CT_TEMP where SYS_CHANGE_OPERATION = 'U'
    --select * from DIM_EDW_HFit_HealthAssesmentUserQuestionGroupResults
    --select top 100 * from FACT_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS
    --select top 100 * from DIM_EDW_HFit_HealthAssesmentUserQuestionGroupResults
    --update FACT_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS set CodeName = 'MME' where itemid = 19864

    EXEC @iCnt = proc_QuickRowCount 'DIM_EDW_HFit_HealthAssesmentUserQuestionGroupResults';
    EXEC PrintImmediate 'Populating DIM_EDW_HFit_HealthAssesmentUserQuestionGroupResults';
    IF @iCnt = 0
        BEGIN

            EXEC PrintImmediate 'Populating DIM_EDW_HFit_HealthAssesmentUserQuestionGroupResults';
            INSERT INTO DIM_EDW_HFit_HealthAssesmentUserQuestionGroupResults
            (
                   ITEMID
                 , POINTRESULTS
                 , CODENAME
                 , HARiskAreaItemID
                 , LastUpdateID
                 , LASTLOADEDDATE
                 , SVR
                 , DBNAME
                 , DeletedFlg
            ) 
            SELECT
                   HAUserQuestionGroupResults.ItemID
                 , HAUserQuestionGroupResults.POINTRESULTS
                 , HAUserQuestionGroupResults.CODENAME
                 , HAUserQuestionGroupResults.HARiskAreaItemID
                 , 0 AS LastUpdateID
                 , GETDATE () AS LASTLOADEDDATE
                 , HAUserQuestionGroupResults.SVR
                 , HAUserQuestionGroupResults.DBNAME
                 , 0 AS DeletedFlg
                   FROM FACT_HFIT_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults;

        END;

    DELETE FROM DIM_EDW_HFit_HealthAssesmentUserQuestionGroupResults
    WHERE
          ItemID IN ( SELECT
                             CT_HFit_HealthAssesmentUserQuestionGroupResults.ItemID
                             FROM CHANGETABLE (CHANGES FACT_HFit_HealthAssesmentUserQuestionGroupResults, @ChangeVersionID) AS CT_HFit_HealthAssesmentUserQuestionGroupResults
                             WHERE
                             SYS_CHANGE_OPERATION = 'D') ;
    UPDATE S
           SET
               S.POINTRESULTS = T.POINTRESULTS
             ,S.CODENAME = T.CODENAME
             ,S.HARiskAreaItemID = T.HARiskAreaItemID
             ,S.LastUpdateID = CT_HFit_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_VERSION
             ,S.LASTLOADEDDATE = GETDATE () 
             ,S.SVR = T.SVR
             ,S.DBNAME = T.DBNAME
             ,DeletedFlg = 0
               FROM FACT_HFit_HealthAssesmentUserQuestionGroupResults AS T
                        JOIN DIM_EDW_HFit_HealthAssesmentUserQuestionGroupResults AS S
                            ON
                            S.ItemID = T.ItemID
                        AND S.SVR = T.SVR
                        AND S.DBNAME = T.DBNAME
                        JOIN CHANGETABLE ( CHANGES FACT_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS , @ChangeVersionID) AS CT_HFit_HealthAssesmentUserQuestionGroupResults
                            ON
                            CT_HFit_HealthAssesmentUserQuestionGroupResults.ItemID = T.ItemID
                        AND CT_HFit_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_VERSION != S.LastUpdateID
                        AND CT_HFit_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_OPERATION = 'U'
                        AND S.SVR = CT_HFit_HealthAssesmentUserQuestionGroupResults.SVR
                        AND S.DBNAME = CT_HFit_HealthAssesmentUserQuestionGroupResults.DBNAME;

    EXEC PrintImmediate 'Populating DIM_EDW_HFit_HealthAssesmentUserQuestionGroupResults';
    WITH CTE_temp (
         SVR
       , DBNAME
       , ItemID) 
        AS (
        SELECT
               SVR
             , DBNAME
             , CTE_temp.ItemID
               FROM CHANGETABLE (CHANGES FACT_HFit_HealthAssesmentUserQuestionGroupResults, @ChangeVersionID) AS CTE_temp
               WHERE
               SYS_CHANGE_OPERATION = 'I'
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , ItemID
               FROM DIM_EDW_HFit_HealthAssesmentUserQuestionGroupResults
        ) 
        INSERT INTO DIM_EDW_HFit_HealthAssesmentUserQuestionGroupResults (
               POINTRESULTS
             , CODENAME
             , HARiskAreaItemID
             , LastUpdateID
             , LASTLOADEDDATE
             , SVR
             , DBNAME
             , DeletedFlg
             , ITEMID) 
        SELECT
               T.POINTRESULTS
             , T.CODENAME
             , T.HARiskAreaItemID
             , CT_HFit_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_VERSION AS LastUpdateID
             , GETDATE () AS LASTLOADEDDATE
             , T.SVR
             , T.DBNAME
             , 0 AS DeletedFlg
             , T.ITEMID
               FROM FACT_HFit_HealthAssesmentUserQuestionGroupResults AS T
                        JOIN CHANGETABLE (CHANGES FACT_HFit_HealthAssesmentUserQuestionGroupResults, @ChangeVersionID) AS CT_HFit_HealthAssesmentUserQuestionGroupResults
                            ON CT_HFit_HealthAssesmentUserQuestionGroupResults.ItemID = T.ItemID
                           AND CT_HFit_HealthAssesmentUserQuestionGroupResults.SVR = T.SVR
                           AND CT_HFit_HealthAssesmentUserQuestionGroupResults.DBNAME = T.DBNAME
                           AND CT_HFit_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_OPERATION = 'I'
                        JOIN CTE_temp AS C
                            ON c.ItemID = CT_HFit_HealthAssesmentUserQuestionGroupResults.ItemID
                           AND CT_HFit_HealthAssesmentUserQuestionGroupResults.SVR = C.SVR
                           AND CT_HFit_HealthAssesmentUserQuestionGroupResults.DBNAME = C.DBNAME;
    --set @iInsertedCnt = @iInsertedCnt + @@ROWCOUNT ;

    --***********************************************************************************
    -- drop table DIM_EDW_HFit_HealthAssesmentUserQuestion
    -- select top 100 * from DIM_EDW_HFit_HealthAssesmentUserQuestion

    EXEC @iCnt = proc_QuickRowCount 'DIM_EDW_HFit_HealthAssesmentUserQuestion';
    EXEC PrintImmediate 'Populating DIM_EDW_HFit_HealthAssesmentUserQuestion';
    IF @iCnt = 0
        BEGIN
            EXEC PrintImmediate 'Populating DIM_EDW_HFit_HealthAssesmentUserQuestion';
            INSERT INTO DIM_EDW_HFit_HealthAssesmentUserQuestion
            (
                   ITEMID
                 , HAQUESTIONNODEGUID
                 , CODENAME
                 , HAQUESTIONSCORE
                 , PREWEIGHTEDSCORE
                 , ISPROFESSIONALLYCOLLECTED
                 , ITEMMODIFIEDWHEN
                 , HARiskAreaItemID
                 , HFIT_HEALTHASSESMENTUSERQUESTION_CTID
                 , HFIT_HEALTHASSESMENTUSERQUESTION_CHANGE_OPERATION
                 , CT_HFIT_HEALTHASSESMENTUSERQUESTION_SCV
                 , LastUpdateID
                 , LASTLOADEDDATE
                 , SVR
                 , DBNAME
                 , DeletedFlg
            ) 
            SELECT
                   USERQUES.ITEMID
                 , USERQUES.HAQUESTIONNODEGUID
                 , USERQUES.CODENAME
                 , USERQUES.HAQUESTIONSCORE
                 , USERQUES.PREWEIGHTEDSCORE
                 , USERQUES.ISPROFESSIONALLYCOLLECTED
                 , USERQUES.ITEMMODIFIEDWHEN
                 , USERQUES.HARiskAreaItemID
                 , CT_HFIT_HEALTHASSESMENTUSERQUESTION.ITEMID AS HFIT_HEALTHASSESMENTUSERQUESTION_CTID
                 , CT_HFIT_HEALTHASSESMENTUSERQUESTION.SYS_CHANGE_OPERATION AS HFIT_HEALTHASSESMENTUSERQUESTION_CHANGE_OPERATION
                 , CT_HFIT_HEALTHASSESMENTUSERQUESTION.SYS_CHANGE_VERSION AS CT_HFIT_HEALTHASSESMENTUSERQUESTION_SCV
                 , 0 AS LastUpdateID
                 , GETDATE () AS LASTLOADEDDATE
                 , USERQUES.SVR
                 , USERQUES.DBNAME
                 , 0 AS DeletedFlg

                   FROM
            FACT_HFIT_HEALTHASSESMENTUSERQUESTION AS USERQUES
                LEFT OUTER JOIN CHANGETABLE ( CHANGES FACT_HFIT_HEALTHASSESMENTUSERQUESTION , @ChangeVersionID) AS CT_HFIT_HEALTHASSESMENTUSERQUESTION
                    ON
                    USERQUES.ITEMID = CT_HFIT_HEALTHASSESMENTUSERQUESTION.ITEMID
                AND USERQUES.svr = CT_HFIT_HEALTHASSESMENTUSERQUESTION.svr
                AND USERQUES.DBNAME = CT_HFIT_HEALTHASSESMENTUSERQUESTION.DBNAME;

        END;

    EXEC PrintImmediate 'Populating DIM_EDW_HFit_HealthAssesmentUserQuestion';
    WITH CTE_HFIT_HEALTHASSESMENTUSERQUESTION (
         SVR
       , DBNAME
       , ItemID) 
        AS (
        SELECT
               SVR
             , DBNAME
             , CT_HFIT_HEALTHASSESMENTUSERQUESTION.ItemID
               FROM CHANGETABLE (CHANGES FACT_HFIT_HEALTHASSESMENTUSERQUESTION, @ChangeVersionID) AS CT_HFIT_HEALTHASSESMENTUSERQUESTION
               WHERE
               SYS_CHANGE_OPERATION = 'I'
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , itemid
               FROM DIM_EDW_HFit_HealthAssesmentUserQuestion
        ) 
        INSERT INTO DIM_EDW_HFit_HealthAssesmentUserQuestion (
               ITEMID
             , HAQUESTIONNODEGUID
             , CODENAME
             , HAQUESTIONSCORE
             , PREWEIGHTEDSCORE
             , ISPROFESSIONALLYCOLLECTED
             , ITEMMODIFIEDWHEN
             , HARiskAreaItemID
             , HFIT_HEALTHASSESMENTUSERQUESTION_CTID
             , HFIT_HEALTHASSESMENTUSERQUESTION_CHANGE_OPERATION
             , CT_HFIT_HEALTHASSESMENTUSERQUESTION_SCV
             , LastUpdateID
             , LASTLOADEDDATE
             , SVR
             , DBNAME
             , DeletedFlg) 
        SELECT
               T.ITEMID
             , T.HAQUESTIONNODEGUID
             , T.CODENAME
             , T.HAQUESTIONSCORE
             , T.PREWEIGHTEDSCORE
             , T.ISPROFESSIONALLYCOLLECTED
             , T.ITEMMODIFIEDWHEN
             , T.HARiskAreaItemID
             , CT_HFIT_HEALTHASSESMENTUSERQUESTION.ItemID  AS HFIT_HEALTHASSESMENTUSERQUESTION_CTID
             , 'I' AS HFIT_HEALTHASSESMENTUSERQUESTION_CHANGE_OPERATION
             , CT_HFIT_HEALTHASSESMENTUSERQUESTION.SYS_CHANGE_VERSION AS CT_HFIT_HEALTHASSESMENTUSERQUESTION_SCV
             , 0 AS LastUpdateID
             , GETDATE () AS LASTLOADEDDATE
             , T.SVR
             , T.DBNAME
             , 0 AS DeletedFlg
               FROM FACT_HFIT_HEALTHASSESMENTUSERQUESTION AS T
                        JOIN CHANGETABLE (CHANGES FACT_HFIT_HEALTHASSESMENTUSERQUESTION, @ChangeVersionID) AS CT_HFIT_HEALTHASSESMENTUSERQUESTION
                            ON CT_HFIT_HEALTHASSESMENTUSERQUESTION.ItemID = T.ItemID
                           AND CT_HFIT_HEALTHASSESMENTUSERQUESTION.SVR = T.SVR
                           AND CT_HFIT_HEALTHASSESMENTUSERQUESTION.DBNAME = T.DBNAME
                           AND CT_HFIT_HEALTHASSESMENTUSERQUESTION.SYS_CHANGE_OPERATION = 'I'
                        JOIN CTE_HFIT_HEALTHASSESMENTUSERQUESTION
                            ON CTE_HFIT_HEALTHASSESMENTUSERQUESTION.ItemID = T.ItemID
                           AND CTE_HFIT_HEALTHASSESMENTUSERQUESTION.SVR = T.SVR
                           AND CTE_HFIT_HEALTHASSESMENTUSERQUESTION.DBNAME = T.DBNAME;
    --set @iInsertedCnt = @iInsertedCnt + @@ROWCOUNT ;

    DELETE FROM DIM_EDW_HFit_HealthAssesmentUserQuestion
    WHERE
          ItemID IN ( SELECT
                             CT_CMS_HFIT_HEALTHASSESMENTUSERQUESTION.ItemID
                             FROM CHANGETABLE (CHANGES FACT_HFIT_HEALTHASSESMENTUSERQUESTION, @ChangeVersionID) AS CT_CMS_HFIT_HEALTHASSESMENTUSERQUESTION
                             WHERE
                             SYS_CHANGE_OPERATION = 'D') ;

    WITH CTE_HAQ (
         SVR
       , DBNAME
       , ItemID
       , SYS_CHANGE_VERSION) 
        AS (
        SELECT
               SVR
             , DBNAME
             , CT_CMS_HFIT_HEALTHASSESMENTUSERQUESTION.ItemID
             , CT_CMS_HFIT_HEALTHASSESMENTUSERQUESTION.SYS_CHANGE_VERSION
               FROM CHANGETABLE (CHANGES FACT_HFIT_HEALTHASSESMENTUSERQUESTION, @ChangeVersionID) AS CT_CMS_HFIT_HEALTHASSESMENTUSERQUESTION
               WHERE
               SYS_CHANGE_OPERATION = 'U'
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , ItemID
             , LastUpdateID
               FROM DIM_EDW_HFit_HealthAssesmentUserQuestion
        ) 
        UPDATE S
               SET
                   S.HAQUESTIONNODEGUID = T.HAQUESTIONNODEGUID
                 ,S.CODENAME = T.CODENAME
                 ,S.HAQUESTIONSCORE = T.HAQUESTIONSCORE
                 ,S.PREWEIGHTEDSCORE = T.PREWEIGHTEDSCORE
                 ,S.ISPROFESSIONALLYCOLLECTED = T.ISPROFESSIONALLYCOLLECTED
                 ,S.ITEMMODIFIEDWHEN = T.ITEMMODIFIEDWHEN
                 ,S.HARiskAreaItemID = T.HARiskAreaItemID
                 ,S.LastUpdateID = CT_HFIT_HEALTHASSESMENTUSERQUESTION.SYS_CHANGE_VERSION
                 ,S.LASTLOADEDDATE = GETDATE () 
                 ,S.SVR = T.SVR
                 ,S.DBNAME = T.DBNAME
                 ,S.DeletedFlg = 0
                   FROM FACT_HFIT_HEALTHASSESMENTUSERQUESTION AS T
                            JOIN DIM_EDW_HFit_HealthAssesmentUserQuestion AS S
                                ON
                                S.ItemID = T.ItemID
                            AND S.SVR = T.SVR
                            AND S.DBNAME = T.DBNAME
                            JOIN CHANGETABLE ( CHANGES FACT_HFIT_HEALTHASSESMENTUSERQUESTION , @ChangeVersionID) AS CT_HFIT_HEALTHASSESMENTUSERQUESTION
                                ON
                                CT_HFIT_HEALTHASSESMENTUSERQUESTION.ItemID = T.ItemID
                            AND S.ItemID = T.ItemID
                            AND S.SVR = T.SVR
                            AND S.DBNAME = T.DBNAME
                            AND CT_HFIT_HEALTHASSESMENTUSERQUESTION.SYS_CHANGE_VERSION != S.LastUpdateID
                            AND CT_HFIT_HEALTHASSESMENTUSERQUESTION.SVR != S.SVR
                            AND CT_HFIT_HEALTHASSESMENTUSERQUESTION.DBNAME != S.DBNAME
                            AND CT_HFIT_HEALTHASSESMENTUSERQUESTION.SYS_CHANGE_OPERATION = 'U'
                            JOIN CTE_HAQ
                                ON
                                CTE_HAQ.ItemID = S.ItemID
                            AND CTE_HAQ.SVR = S.SVR
                            AND CTE_HAQ.DBNAME = S.DBNAME;

    --********************************************************************************************
    -- THIS IS A TABLE CREATED FROM A VIEW WITH A SMALL NUMBER OF ROWS, JUST DROP AND RECREATE.
    truncate TABLE DIM_EDW_VIEW_HFIT_HACAMPAIGN_JOINED;
    EXEC @iCnt = proc_QuickRowCount 'DIM_EDW_VIEW_HFIT_HACAMPAIGN_JOINED';
    EXEC PrintImmediate 'Populating DIM_EDW_VIEW_HFIT_HACAMPAIGN_JOINED';
    -- drop table DIM_EDW_VIEW_HFIT_HACAMPAIGN_JOINED ;
    IF @iCnt = 0
        BEGIN
            -- Select * from DIM_EDW_VIEW_HFIT_HACAMPAIGN_JOINED 
            EXEC PrintImmediate 'Populating DIM_EDW_VIEW_HFIT_HACAMPAIGN_JOINED';
            INSERT INTO DIM_EDW_VIEW_HFIT_HACAMPAIGN_JOINED
            (
                   DOCUMENTCULTURE
                 , HACAMPAIGNID
                 , NODEGUID
                 , NODESITEID
                 , HEALTHASSESSMENTID
                 , LastUpdateID
                 , LASTLOADEDDATE
                 , SVR
                 , DBNAME
                 , DeletedFlg
                 , LastModifiedDate) 
            SELECT
                   CAMPAIGN.DOCUMENTCULTURE
                 , CAMPAIGN.HACAMPAIGNID
                 , CAMPAIGN.NODEGUID
                 , CAMPAIGN.NODESITEID
                 , CAMPAIGN.HEALTHASSESSMENTID
                 , 0 AS LastUpdateID
                 , GETDATE () AS LASTLOADEDDATE
                 , CAMPAIGN.FACT_HFit_HACampaign_SVR
                 , CAMPAIGN.FACT_HFit_HACampaign_DBNAME
                 , 0 AS DeletedFlg
                 , GETDATE () AS LastModifiedDate
                   FROM VIEW_HFIT_HACAMPAIGN_JOINED AS CAMPAIGN;
        END;

    --***********************************************************************************
    --select top 100 * from View_HFit_HealthAssessment_Joined
    -- THIS IS A TABLE CREATED FROM A VIEW WITH A SMALL NUMBER OF ROWS, JUST DROP AND RECREATE.
    truncate TABLE DIM_EDW_VIEW_HFIT_HEALTHASSESSMENT_JOINED;
    EXEC @iCnt = proc_QuickRowCount 'DIM_EDW_VIEW_HFIT_HEALTHASSESSMENT_JOINED';
    EXEC PrintImmediate 'Populating DIM_EDW_VIEW_HFIT_HEALTHASSESSMENT_JOINED';
    IF @iCnt = 0
        BEGIN

            EXEC PrintImmediate 'Populating DIM_EDW_VIEW_HFIT_HEALTHASSESSMENT_JOINED';
            INSERT INTO DIM_EDW_VIEW_HFIT_HEALTHASSESSMENT_JOINED
            (
                   NODEGUID
                 , DOCUMENTID
                 , DOCUMENTCULTURE
                 , LastUpdateID
                 , LASTLOADEDDATE
                 , SVR
                 , DBNAME
                 , DeletedFlg) 
            SELECT
                   HAJOINED.NODEGUID
                 , HAJOINED.DOCUMENTID
                 , HAJOINED.DOCUMENTCULTURE
                 , 0 AS LastUpdateID
                 , GETDATE () AS LASTLOADEDDATE
                 , HAJOINED.SVR
                 , HAJOINED.DBNAME
                 , 0 AS DeletedFlg
                   FROM VIEW_HFIT_HEALTHASSESSMENT_JOINED AS HAJOINED;
        END;

    --***********************************************************************************		
    --***********************************************************************************
    --drop table DIM_EDW_View_EDW_HealthAssesmentQuestions
    --select CT_TEMP.ItemID, CT_TEMP.SYS_CHANGE_VERSION from CHANGETABLE (CHANGES View_EDW_HealthAssesmentQuestions , NULL) AS CT_TEMP where SYS_CHANGE_OPERATION = 'U'
    --select * from DIM_EDW_View_EDW_HealthAssesmentQuestions
    --select top 100 * from View_EDW_HealthAssesmentQuestions
    --select top 100 * from DIM_EDW_View_EDW_HealthAssesmentQuestions
    --update View_EDW_HealthAssesmentQuestions set CodeName = 'AboutYou' where itemid = 32919
    -- THIS IS A TABLE CREATED FROM A VIEW WITH A SMALL NUMBER OF ROWS, JUST DROP AND RECREATE.

    truncate TABLE DIM_EDW_View_EDW_HealthAssesmentQuestions;
    EXEC @iCnt = proc_QuickRowCount 'DIM_EDW_View_EDW_HealthAssesmentQuestions';
    EXEC PrintImmediate 'Populating DIM_EDW_View_EDW_HealthAssesmentQuestions';
    IF @iCnt = 0
        BEGIN

            EXEC PrintImmediate 'Populating DIM_EDW_View_EDW_HealthAssesmentQuestions';
            INSERT INTO DIM_EDW_View_EDW_HealthAssesmentQuestions
            (
                   TITLE
                 , DOCUMENTCULTURE
                 , NODEGUID
                 , LastUpdateID
                 , LASTLOADEDDATE
                 , SVR
                 , DBNAME
                 , DeletedFlg
            ) 
            SELECT
                   DBO.UDF_STRIPHTML ( QUES.TITLE) AS TITLE
                 , QUES.DOCUMENTCULTURE
                 , QUES.NODEGUID
                 , 0 AS LastUpdateID
                 , GETDATE () AS LASTLOADEDDATE
                 , QUES.SVR
                 , QUES.DBNAME
                 , 0 AS DeletedFlg
                   FROM VIEW_EDW_HEALTHASSESMENTQUESTIONS AS QUES;
        END;

    --***********************************************************************************		 		 
    EXEC PrintImmediate 'Populating PI_DIM_HAUserQuestionGroupResults';
    IF NOT EXISTS ( SELECT
                           NAME
                           FROM SYS.INDEXES
                           WHERE
                           NAME = 'PI_DIM_HAUserQuestionGroupResults') 
        BEGIN
            EXEC PrintImmediate 'Populating PI_DIM_HAUserQuestionGroupResults';
            CREATE NONCLUSTERED INDEX PI_DIM_HAUserQuestionGroupResults ON DBO.DIM_EDW_HFit_HealthAssesmentUserQuestionGroupResults ( SVR ASC , DBNAME ASC , HARiskAreaItemID ASC) INCLUDE (
            ITEMID
            , POINTRESULTS
            , CODENAME) ;
        END;
    SET ANSI_PADDING ON;
    SET NOCOUNT OFF;
    EXEC PrintImmediate '**LEAVING Populating Staging Tables: ';

END;
GO
EXEC PrintImmediate 'Executed proc_EDW_BuildStagingTables.sql';
GO
EXEC PrintImmediate 'RUNNING PROCEDURE proc_EDW_BuildStagingTables';
GO

--EXEC PrintImmediate 'ERROR ERROR ERROR ERROR ERROR ERROR ERROR ';
EXEC proc_EDW_BuildStagingTables;

GO

EXEC PrintImmediate 'COMPLETED RUNNING PROCEDURE proc_EDW_BuildStagingTables';
PRINT GETDATE () ;

GO
