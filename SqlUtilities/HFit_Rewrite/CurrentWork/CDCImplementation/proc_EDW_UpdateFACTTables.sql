
use KenticoCMS_DataMart
GO
EXEC PrintImmediate 'Executing proc_EDW_UpdateDIMTables.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_EDW_UpdateDIMTables') 
    BEGIN
        DROP PROCEDURE
             proc_EDW_UpdateDIMTables;
    END;
GO

/*-----------------------------------
-------------------------------------
------------------------------
EXEC proc_EDW_UpdateDIMTables 12576 
exec proc_EDW_BuildHAHashkeys
*/
CREATE PROCEDURE proc_EDW_UpdateDIMTables (
       @ChangeVersionID INT = 0
     , @ReloadAll INT = 0) 
AS
BEGIN
    SET NOCOUNT ON;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    IF NOT EXISTS ( SELECT
                           NAME
                           FROM sys.tables
                           WHERE
                           name = 'FACT_EDW_MASTER_TABLES') 
        BEGIN

/*--------------------------------------------------------------------
---------------------------------------------------------------------
----------------------------------------------------------------------
@ChangeVersionID is the CHANGE Version number that is desired to pull.
If not provided, it defaults to 0 which will cause all CT recs to be 
considered.

ADD THE MASTER TABLE SO THAT THIS INITIALIZATION WILL NOT OCCUR AGAIN.
NOTE: TO RELOAD ALL STAGING TABLES, JUST DROP FACT_EDW_MASTER_TABLES.
*/

            EXEC PrintImmediate '**INSIDE Populating Staging Tables: ';

            DECLARE
                   @iInsertedCnt AS BIGINT = 0, @DBNAME as nvarchar(100) = DB_NAME();

            EXEC PrintImmediate 'Populating FACT_EDW_MASTER_TABLES';
            RAISERROR ('Populating FACT_EDW_MASTER_TABLES.' , 10 , 1) WITH NOWAIT;
            SELECT
                   table_name INTO
                                   FACT_EDW_MASTER_TABLES
                   FROM information_schema.tables
                   WHERE table_name LIKE 'FACT_EDW%';

            --DROP ANY EXISTING TABLES SO THEY WILL BE REPOPULATED
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'FACT_EDW_CMS_USER') 
                BEGIN
                    EXEC PROC_CREATE_FACT_Tables;

                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'FACT_EDW_CMS_USERSETTINGS') 
                BEGIN
                    EXEC PROC_CREATE_FACT_Tables;
                    EXEC proc_Add_EDW_CT_StdCols FACT_EDW_CMS_USERSETTINGS;
                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'FACT_EDW_CMS_USERSITE') 
                BEGIN
                    EXEC PROC_CREATE_FACT_Tables;
                    EXEC proc_Add_EDW_CT_StdCols FACT_EDW_CMS_USERSITE;
                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'FACT_MART_EDW_HealthAssesmentDefinition') 
                BEGIN
                    EXEC PROC_CREATE_FACT_Tables;
                    EXEC proc_Add_EDW_CT_StdCols FACT_MART_EDW_HealthAssesmentDefinition;
                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'FACT_EDW_HFIT_HealthAssesmentUserAnswers') 
                BEGIN
                    EXEC PROC_CREATE_FACT_Tables;
                    EXEC proc_Add_EDW_CT_StdCols FACT_EDW_HFIT_HealthAssesmentUserAnswers;
                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'FACT_EDW_HFIT_HEALTHASSESMENTUSERMODULE') 
                BEGIN
                    EXEC PROC_CREATE_FACT_Tables;
                    EXEC proc_Add_EDW_CT_StdCols FACT_EDW_HFIT_HEALTHASSESMENTUSERMODULE;
                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'FACT_EDW_HFit_HealthAssesmentUserQuestion') 
                BEGIN
                    EXEC PROC_CREATE_FACT_Tables;
                    EXEC proc_Add_EDW_CT_StdCols FACT_EDW_HFit_HealthAssesmentUserQuestion;
                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS') 
                BEGIN
                    EXEC PROC_CREATE_FACT_Tables;
                    EXEC proc_Add_EDW_CT_StdCols FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS;
                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'FACT_EDW_HFit_HealthAssesmentUserRiskArea') 
                BEGIN
                    EXEC PROC_CREATE_FACT_Tables;
                    EXEC proc_Add_EDW_CT_StdCols FACT_EDW_HFit_HealthAssesmentUserRiskArea;
                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'FACT_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY') 
                BEGIN
                    EXEC PROC_CREATE_FACT_Tables;
                    EXEC proc_Add_EDW_CT_StdCols FACT_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY;
                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'FACT_EDW_HFIT_HEALTHASSESMENTUSERSTARTED') 
                BEGIN
                    EXEC PROC_CREATE_FACT_Tables;
                    EXEC proc_Add_EDW_CT_StdCols FACT_EDW_HFIT_HEALTHASSESMENTUSERSTARTED;
                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'FACT_EDW_VIEW_HFIT_HACAMPAIGN_JOINED') 
                BEGIN
                    EXEC PROC_CREATE_FACT_Tables;
                    EXEC proc_Add_EDW_CT_StdCols FACT_EDW_VIEW_HFIT_HACAMPAIGN_JOINED;
                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'FACT_EDW_VIEW_HFIT_HEALTHASSESSMENT_JOINED') 
                BEGIN
                    EXEC PROC_CREATE_FACT_Tables;
                    EXEC proc_Add_EDW_CT_StdCols FACT_EDW_VIEW_HFIT_HEALTHASSESSMENT_JOINED;
                END;
            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.tables
                                  WHERE
                                  name = 'FACT_View_EDW_HealthAssesmentQuestions') 
                BEGIN
                    EXEC PROC_CREATE_FACT_Tables;
                    EXEC proc_Add_EDW_CT_StdCols FACT_View_EDW_HealthAssesmentQuestions;
                END;

        END;

    --***************************************************************************
    DECLARE
           @iCnt AS BIGINT = 0;
    --***************************************************************************
    --IF EXISTS (SELECT
    --                  name
    --                  FROM sys.tables
    --                  WHERE
    --                  name = 'FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined') 
    --    BEGIN

    --        RAISERROR ('Populating FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined.' , 10 , 1) WITH NOWAIT;
    --        DROP TABLE
    --             FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined;
    --    END;

    EXEC @iCnt = proc_QuickRowCount 'FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined';
    IF
       @iCnt = 0 OR
       NOT EXISTS (SELECT
                          name
                          FROM sys.tables
                          WHERE
                          name = 'FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined') 
        BEGIN
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
                 --, HAUserQuestionGroupResults.ITEMMODIFIEDWHEN AS HAUserQuestionGroupResults_LASTMODIFIED	--HAUserQuestionGroupResults.LASTLOADEDDATE 
    , HAUserQuestionGroupResults.LastModifiedDate AS HAUserQuestionGroupResults_LASTMODIFIED	--HAUserQuestionGroupResults.LASTLOADEDDATE 
                 , NULL AS HAUserQuestionGroupResults_LastUpdateID	--HAUserQuestionGroupResults.LastUpdateID 

                 , HAUserRiskArea.ItemModifiedWhen AS LastModifiedWhen
                 , 0 AS LastUpdateID
                 , GETDATE () AS LASTLOADEDDATE
                 , HAUserRiskArea.SVR AS SVR
                 , HAUserRiskArea.DBNAME AS DBNAME
                 , HAUserRiskArea.LastModifiedDate
                 , 0 AS DeletedFlg
            INTO
                 FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined
                   FROM
                        DBO.BASE_HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea
                             LEFT JOIN DBO.FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS AS HAUserQuestionGroupResults
                             ON
                   HAUserRiskArea.ITEMID = HAUserQuestionGroupResults.HARiskAreaItemID AND
                   HAUserRiskArea.SVR = HAUserQuestionGroupResults.SVR AND
                   HAUserRiskArea.DBNAME = HAUserQuestionGroupResults.DBNAME;
        END;
    RAISERROR ('Populated FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined.' , 10 , 1) WITH NOWAIT;
    EXEC proc_Add_EDW_CT_StdCols FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined;

    IF NOT EXISTS (SELECT
                          column_name
                          FROM information_schema.columns
                          WHERE
                          table_name = 'FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined' AND
                          column_name = 'HARiskCATEGORYItemID') 
        BEGIN
            EXEC PrintImmediate 'ADDING HARiskCATEGORYItemID to FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined';
            ALTER TABLE FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined
            ADD
                        HARISKCATEGORYITEMID INT NULL;
        END;

    RAISERROR ('Populated PI_EDW_HFit_HealthAssesmentUserRiskArea_Joined.' , 10 , 1) WITH NOWAIT;
    IF NOT EXISTS (SELECT
                          name
                          FROM sys.indexes
                          WHERE
                          name = 'PI_EDW_HFit_HealthAssesmentUserRiskArea_Joined') 
        BEGIN
            CREATE CLUSTERED INDEX PI_EDW_HFit_HealthAssesmentUserRiskArea_Joined ON FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined (SVR ASC , DBNAME ASC , UserRiskAreaItemID ASC , HAUserQuestionGroupResultsItemID ASC) 
        END;

    RAISERROR ('Populated CI_EDW_HFit_HealthAssesmentUserRiskArea_Joined.' , 10 , 1) WITH NOWAIT;

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.indexes
                          WHERE
                          name = 'CI_EDW_HFit_HealthAssesmentUserRiskArea_Joined') 
        BEGIN
            CREATE NONCLUSTERED INDEX CI_EDW_HFit_HealthAssesmentUserRiskArea_Joined
            ON dbo.FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined (SVR ASC , DBNAME ASC , HAUserQuestionGroupResultsItemID) 
            INCLUDE (UserRiskAreaItemID , LastUpdateID) 
        END;

    RAISERROR ('Created CI_EDW_HFit_HealthAssesmentUserRiskArea_Joined.' , 10 , 1) WITH NOWAIT;

    -- delete from BASE_HFit_HealthAssesmentUserRiskArea where ItemID = 6928
    -- Select * from CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserRiskArea , 0) AS CT_HFit_HealthAssesmentUserRiskArea
    -- DECLARE @ChangeVersionID AS int = 0;
    RAISERROR ('checking deletes on FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined.' , 10 , 1) WITH NOWAIT;
    DELETE D
           FROM FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined D
                     JOIN CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserRiskArea , @ChangeVersionID) AS CT_HFit_HealthAssesmentUserRiskArea
                     ON
           D.UserRiskAreaItemID = CT_HFit_HealthAssesmentUserRiskArea.ItemID            
           AND D.SVR = CT_HFit_HealthAssesmentUserRiskArea.SVR 
           AND D.DBNAME = CT_HFit_HealthAssesmentUserRiskArea.DBNAME
		  AND SYS_CHANGE_OPERATION = 'D' ;

    -- select * from CHANGETABLE ( CHANGES BASE_HFit_HealthAssesmentUserRiskArea , 0) AS CT_HFit_HealthAssesmentUserRiskArea  
    -- select top 100 * from BASE_HFit_HealthAssesmentUserRiskArea
    -- update BASE_HFit_HealthAssesmentUserRiskArea set CodeName = 'Fats' where CodeNAme = 'Fats'
    -- DECLARE @ChangeVersionID AS int = 0;

    EXEC proc_Add_EDW_CT_StdCols BASE_HFit_HealthAssesmentUserRiskArea;

    RAISERROR ('Processing FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined.' , 10 , 1) WITH NOWAIT;
    SELECT
           CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_VERSION
         , CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_OPERATION
         , CT_HFit_HealthAssesmentUserRiskArea.SVR
         , CT_HFit_HealthAssesmentUserRiskArea.DBNAME
         , CT_HFit_HealthAssesmentUserRiskArea.ItemID
    INTO
         #TEMP_HFit_HealthAssesmentUserRiskArea
           FROM CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserRiskArea , 0) AS CT_HFit_HealthAssesmentUserRiskArea
           WHERE
           CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_OPERATION = 'U';
    RAISERROR ('Created #TEMP_HFit_HealthAssesmentUserRiskArea.' , 10 , 1) WITH NOWAIT;

/*---------------------------------------------------------------------------------------------------------------
***** Object:  Index [CI_BASE_BASE_HFIT_HEALTHASSESMENTUSERANSWERS09]    Script Date: 11/25/2015 8:38:01 AM *****
*/
    IF NOT EXISTS (SELECT
                          name
                          FROM sys.indexes
                          WHERE
                          name = 'CI_BASE_BASE_HFIT_HEALTHASSESMENTUSERANSWERS09') 
        BEGIN
            CREATE CLUSTERED INDEX CI_BASE_BASE_HFIT_HEALTHASSESMENTUSERANSWERS09 ON #TEMP_HFit_HealthAssesmentUserRiskArea
            (
            ItemID ASC ,
            SVR ASC ,
            DBNAME ASC
            ) 
        END;
    RAISERROR ('Indexed #TEMP_HFit_HealthAssesmentUserRiskArea.' , 10 , 1) WITH NOWAIT;
    RAISERROR ('Updating FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined.' , 10 , 1) WITH NOWAIT;

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
        ,S.LastModifiedDate = GETDATE () 
        ,DeletedFlg = 0
          FROM BASE_HFit_HealthAssesmentUserRiskArea AS T
                    JOIN FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined AS S
                    ON
           S.UserRiskAreaItemID = T.ItemID AND
           S.SVR = T.SVR AND
           S.DBNAME = T.DBNAME
                    JOIN #TEMP_HFit_HealthAssesmentUserRiskArea AS CT_HFit_HealthAssesmentUserRiskArea
                    ON
           CT_HFit_HealthAssesmentUserRiskArea.ItemID = T.ItemID
           --AND CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_VERSION != S.LastUpdateID
           AND
           CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_OPERATION = 'U' AND
           CT_HFit_HealthAssesmentUserRiskArea.SVR = T.SVR AND
           CT_HFit_HealthAssesmentUserRiskArea.DBNAME = T.DBNAME;

    -- select * from CHANGETABLE ( CHANGES FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS , 0) AS CT_HFit_HealthAssesmentUserQuestionGroupResults
    -- select top 100 * from FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS
    -- Update FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS set CodeNAme = 'MME' where CodeName = 'MME'
    -- DECLARE @ChangeVersionID AS int = 0;
    RAISERROR ('Updated FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined.' , 10 , 1) WITH NOWAIT;
    RAISERROR ('Updating FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS.' , 10 , 1) WITH NOWAIT;
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
        ,S.LastModifiedDate = GETDATE () 
          FROM FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS AS T
                    JOIN FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined AS S
                    ON
           S.HAUserQuestionGroupResultsItemID = T.ItemID AND
           S.SVR = T.SVR AND
           S.DBNAME = T.DBNAME
                    JOIN CHANGETABLE ( CHANGES BASE_HFit_HealthAssesmentUserQuestionGroupResults , @ChangeVersionID) AS CT_HFit_HealthAssesmentUserQuestionGroupResults
                    ON
           CT_HFit_HealthAssesmentUserQuestionGroupResults.ItemID = T.ItemID
           --AND CT_HFit_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_VERSION != S.LastUpdateID
           AND
           CT_HFit_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_OPERATION = 'U' AND
           CT_HFit_HealthAssesmentUserQuestionGroupResults.SVR = T.SVR AND
           CT_HFit_HealthAssesmentUserQuestionGroupResults.DBNAME = T.DBNAME;
    RAISERROR ('Updated FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS.' , 10 , 1) WITH NOWAIT;
    RAISERROR ('Populating FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined.' , 10 , 1) WITH NOWAIT;
    EXEC PrintImmediate 'Populating FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined';

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
               FROM
                    DBO.BASE_HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea
                         --LEFT JOIN DBO.FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS AS HAUserQuestionGroupResults
				    LEFT JOIN DBO.BASE_HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults
                         ON
               HAUserRiskArea.ITEMID = HAUserQuestionGroupResults.HaRiskAreaItemID AND
               HAUserRiskArea.SVR = HAUserQuestionGroupResults.SVR AND
               HAUserRiskArea.DBNAME = HAUserQuestionGroupResults.DBNAME
        EXCEPT
        SELECT
               UserRiskAreaItemID
             , HaRiskAreaItemID
             , SVR
             , DBNAME
               FROM FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined
        ) 
        INSERT INTO FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined (
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
               FROM
                    View_EDW_HFIT_HealthAssesmentUserRiskArea_Joined AS T
                         JOIN CTE_temp AS C
                         ON
               c.UserRiskAreaItemID = T.UserRiskAreaItemID AND
               c.HaRiskAreaItemID = T.HaRiskAreaItemID AND
               C.SVR = T.SVR AND
               C.DBNAME = T.DBNAME;

    --***************************************************************************
    RAISERROR ('Populating FACT_EDW_CMS_USER - 01.' , 10 , 1) WITH NOWAIT;
    EXEC PrintImmediate 'Populating FACT_EDW_CMS_USER';
    --***************************************************************************
    EXEC @iCnt = proc_QuickRowCount 'FACT_EDW_CMS_USER';
    IF @iCnt = 0
        BEGIN
            EXEC PrintImmediate 'Populating FACT_EDW_CMS_USER';
            INSERT INTO FACT_EDW_CMS_USER
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
                   FROM BASE_CMS_USER AS CMSUSER;

		  exec proc_SaveCTVerHist @DBNAME , 'BASE_CMS_USER' , -1 ;
        --CREATE CLUSTERED INDEX PI_EDW_CMS_USER ON FACT_EDW_CMS_USER ( USERID ASC , USERGUID) ;
        END;

    RAISERROR ('Deleting from FACT_EDW_CMS_USER - 01.' , 10 , 1) WITH NOWAIT;
    DELETE D
           FROM FACT_EDW_CMS_USER D
                     JOIN CHANGETABLE (CHANGES BASE_CMS_User , @ChangeVersionID) AS CT_CMS_User
                     ON
           SYS_CHANGE_OPERATION = 'D' AND
           CT_CMS_User.UserID = D.UserID AND
           CT_CMS_User.SVR = D.SVR AND
           CT_CMS_User.DBNAME = D.DBNAME;

    RAISERROR ('Updating FACT_EDW_CMS_USER - 01.' , 10 , 1) WITH NOWAIT;
    UPDATE S
      SET
          S.LastUpdateID = CT_CMS_User.SYS_CHANGE_VERSION
        ,S.LASTLOADEDDATE = GETDATE () 
        ,S.SVR = T.SVR
        ,S.DBNAME = T.DBNAME
        ,DeletedFlg = 0
        ,S.LastModifiedDate = GETDATE () 
          FROM BASE_CMS_USER AS T
                    JOIN FACT_EDW_CMS_USER AS S
                    ON
           S.UserID = T.UserID AND
           S.SVR = T.SVR AND
           S.DBNAME = T.DBNAME
                    JOIN CHANGETABLE ( CHANGES BASE_CMS_User , @ChangeVersionID) AS CT_CMS_User
                    ON
           CT_CMS_User.UserID = T.USERID AND
           S.UserGUID = T.UserGUID
           --AND CT_CMS_User.SYS_CHANGE_VERSION != S.LastUpdateID
           AND
           CT_CMS_User.SYS_CHANGE_OPERATION = 'U' AND
           S.SVR = CT_CMS_User.SVR AND
           S.DBNAME = CT_CMS_User.DBNAME;

    EXEC PrintImmediate 'Populating FACT_EDW_CMS_USER';
    RAISERROR ('Populating FACT_EDW_CMS_USER - 01.' , 10 , 1) WITH NOWAIT;

    WITH CTE_EDW_CMS_USER (
         SVR
       , DBNAME
       , USERID) 
        AS (
        SELECT
               SVR
             , DBNAME
             , CT_CMS_User.USERID
               FROM CHANGETABLE (CHANGES BASE_CMS_User , 0) AS CT_CMS_User
               WHERE
               SYS_CHANGE_OPERATION = 'I'
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , USERID
               FROM FACT_EDW_CMS_USER
        ) 
        INSERT INTO FACT_EDW_CMS_USER (
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
               FROM
                    BASE_cms_user AS T
                         JOIN CHANGETABLE (CHANGES BASE_CMS_USER , @ChangeVersionID) AS CT_CMS_User
                         ON
               CT_CMS_User.UserID = T.USERID AND
               CT_CMS_User.SYS_CHANGE_OPERATION = 'I' AND
               CT_CMS_User.SVR = T.SVR AND
               CT_CMS_User.DBNAME = T.DBNAME
                         JOIN CTE_EDW_CMS_USER AS C
                         ON
               c.userid = CT_CMS_User.userid AND
               c.SVR = CT_CMS_User.SVR AND
               c.DBNAME = CT_CMS_User.DBNAME;

    --*************************************************************************
    -- drop table FACT_EDW_HFIT_HEALTHASSESMENTUSERSTARTED

    EXEC @iCnt = proc_QuickRowCount 'FACT_EDW_HFIT_HEALTHASSESMENTUSERSTARTED';
    EXEC PrintImmediate 'Populating FACT_EDW_HFIT_HEALTHASSESMENTUSERSTARTED';
    IF @iCnt = 0
        BEGIN
            EXEC PrintImmediate 'Populating FACT_EDW_HFIT_HEALTHASSESMENTUSERSTARTED';
            INSERT INTO FACT_EDW_HFIT_HEALTHASSESMENTUSERSTARTED
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
                   FROM BASE_HFIT_HEALTHASSESMENTUSERSTARTED AS HAUSERSTARTED;
			 exec proc_SaveCTVerHist @DBNAME , 'BASE_HFIT_HEALTHASSESMENTUSERSTARTED' , -1 ;
        END;

    RAISERROR ('Deleting from FACT_EDW_HFIT_HEALTHASSESMENTUSERSTARTED - 01.' , 10 , 1) WITH NOWAIT;
    DELETE D
           FROM FACT_EDW_HFIT_HEALTHASSESMENTUSERSTARTED D
                     JOIN CHANGETABLE ( CHANGES BASE_HFIT_HEALTHASSESMENTUSERSTARTED , @ChangeVersionID) AS CT
                     ON
           CT.ItemID = D.ItemID AND
           CT.SVR = D.SVR AND
           CT.DBNAME = D.DBNAME AND
           SYS_CHANGE_OPERATION = 'D';

    RAISERROR ('Updating FACT_EDW_HFIT_HEALTHASSESMENTUSERSTARTED - 01.' , 10 , 1) WITH NOWAIT;
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
        ,S.SVR = T.SVR
        ,S.DBNAME = T.DBNAME
        ,S.DeletedFlg = 0
        ,S.LastModifiedDate = GETDATE () 
          FROM BASE_HFIT_HEALTHASSESMENTUSERSTARTED AS T
                    JOIN FACT_EDW_HFIT_HEALTHASSESMENTUSERSTARTED AS S
                    ON
           S.ItemID = T.ItemID AND
           S.SVR = T.SVR AND
           S.DBNAME = T.DBNAME
                    JOIN CHANGETABLE ( CHANGES BASE_HFIT_HEALTHASSESMENTUSERSTARTED , @ChangeVersionID) AS CT_HFIT_HEALTHASSESMENTUSERSTARTED
                    ON
           CT_HFIT_HEALTHASSESMENTUSERSTARTED.ItemID = T.ItemID AND
           S.ItemID = T.ItemID AND
           S.SVR = T.SVR AND
           S.DBNAME = T.DBNAME
           --AND CT_HFIT_HEALTHASSESMENTUSERSTARTED.SYS_CHANGE_VERSION != S.LastUpdateID
           AND
           CT_HFIT_HEALTHASSESMENTUSERSTARTED.SYS_CHANGE_OPERATION = 'U';
    EXEC PrintImmediate 'Populating FACT_EDW_HFIT_HEALTHASSESMENTUSERSTARTED';
    WITH CTE_HFIT_HEALTHASSESMENTUSERSTARTED (
         SVR
       , DBNAME
       , ItemID) 
        AS (
        SELECT
               SVR
             , DBNAME
             , CT_HFIT_HEALTHASSESMENTUSERSTARTED.ItemID
               FROM CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERSTARTED , @ChangeVersionID) AS CT_HFIT_HEALTHASSESMENTUSERSTARTED
               WHERE
               SYS_CHANGE_OPERATION = 'I'
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , itemid
               FROM FACT_EDW_HFIT_HEALTHASSESMENTUSERSTARTED
        ) 
        INSERT INTO FACT_EDW_HFIT_HEALTHASSESMENTUSERSTARTED (
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
               FROM
                    BASE_HFIT_HEALTHASSESMENTUSERSTARTED AS T
                         JOIN CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERSTARTED , @ChangeVersionID) AS CT_HFIT_HEALTHASSESMENTUSERSTARTED
                         ON
               CT_HFIT_HEALTHASSESMENTUSERSTARTED.ItemID = T.ItemID AND
               CT_HFIT_HEALTHASSESMENTUSERSTARTED.SYS_CHANGE_OPERATION = 'I' AND
               CT_HFIT_HEALTHASSESMENTUSERSTARTED.SVR = T.SVR AND
               CT_HFIT_HEALTHASSESMENTUSERSTARTED.DBNAME = T.DBNAME
                         JOIN CTE_HFIT_HEALTHASSESMENTUSERSTARTED AS C
                         ON
               C.ItemID = T.ItemID AND
               C.SVR = T.SVR AND
               C.DBNAME = T.DBNAME;

    EXEC @iCnt = proc_QuickRowCount 'FACT_EDW_HFIT_HealthAssesmentUserAnswers';
    EXEC PrintImmediate 'Populating FACT_EDW_HFIT_HealthAssesmentUserAnswers';

    IF @iCnt = 0
        BEGIN
            EXEC @iCnt = proc_QuickRowCount 'BASE_HFIT_HealthAssesmentUserAnswers';
            DECLARE
                   @S AS NVARCHAR (250) = 'Populating FACT_EDW_HFIT_HealthAssesmentUserAnswers: ' + CAST (@iCnt AS NVARCHAR (50)) ;
            EXEC PrintImmediate @S;

            INSERT INTO FACT_EDW_HFIT_HealthAssesmentUserAnswers (
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
                   FROM BASE_HFIT_HealthAssesmentUserAnswers AS HAUSERANSWERS;
		  exec proc_SaveCTVerHist @DBNAME , 'BASE_HFIT_HealthAssesmentUserAnswers' , -1 ;
        END;

    EXEC PrintImmediate 'Deleting FACT_EDW_HFIT_HealthAssesmentUserAnswers';
    DELETE T
           FROM FACT_EDW_HFIT_HealthAssesmentUserAnswers T
                     JOIN CHANGETABLE (CHANGES BASE_HFIT_HealthAssesmentUserAnswers , @ChangeVersionID) AS CT
                     ON
                     CT.SVR = T.SVR AND
           CT.DBNAME = T.DBNAME AND
           CT.ItemID = T.ItemID AND
           CT.SYS_CHANGE_OPERATION = 'D';

    EXEC PrintImmediate 'Updating FACT_EDW_HFIT_HealthAssesmentUserAnswers';
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
        ,S.SVR = T.SVR
        ,S.DBNAME = T.DBNAME
        ,DeletedFlg = 0
        ,S.LastModifiedDate = GETDATE () 
          FROM BASE_HFIT_HealthAssesmentUserAnswers AS T
                    JOIN FACT_EDW_HFIT_HealthAssesmentUserAnswers AS S
                    ON
           S.ItemID = T.ItemID AND
           S.SVR = T.SVR AND
           S.DBNAME = T.DBNAME
                    JOIN CHANGETABLE ( CHANGES BASE_HFIT_HealthAssesmentUserAnswers , @ChangeVersionID) AS CT_HealthAssesmentUserAnswers
                    ON
           CT_HealthAssesmentUserAnswers.ItemID = T.ItemID AND
           CT_HealthAssesmentUserAnswers.SVR = T.SVR AND
           CT_HealthAssesmentUserAnswers.DBNAME = T.DBNAME
           --AND CT_HealthAssesmentUserAnswers.SYS_CHANGE_VERSION != S.LastUpdateID
           AND
           CT_HealthAssesmentUserAnswers.SYS_CHANGE_OPERATION = 'U';

    EXEC PrintImmediate 'Populating Inserts FACT_EDW_HFIT_HealthAssesmentUserAnswers';    
    WITH CTE_temp (
         SVR
       , DBNAME
       , ItemID) 
        AS (
        SELECT
               SVR
             , DBNAME
             , CTE_temp.ItemID
               FROM CHANGETABLE (CHANGES BASE_HFIT_HealthAssesmentUserAnswers , @ChangeVersionID) AS CTE_temp
               WHERE
               SYS_CHANGE_OPERATION = 'I'
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , ItemID
               FROM FACT_EDW_HFIT_HealthAssesmentUserAnswers
        ) 
        INSERT INTO FACT_EDW_HFIT_HealthAssesmentUserAnswers (
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
               FROM
                    BASE_HFIT_HealthAssesmentUserAnswers AS T
                         JOIN CHANGETABLE (CHANGES BASE_HFIT_HealthAssesmentUserAnswers , @ChangeVersionID) AS CT_HealthAssesmentUserAnswers
                         ON
               CT_HealthAssesmentUserAnswers.ItemID = T.ItemID AND
               CT_HealthAssesmentUserAnswers.SYS_CHANGE_OPERATION = 'I' AND
               CT_HealthAssesmentUserAnswers.SVR = T.SVR AND
               CT_HealthAssesmentUserAnswers.DBNAME = T.DBNAME
                         JOIN CTE_temp AS C
                         ON
               c.ItemID = CT_HealthAssesmentUserAnswers.ItemID AND
               CT_HealthAssesmentUserAnswers.SVR = C.SVR AND
               CT_HealthAssesmentUserAnswers.DBNAME = C.DBNAME;
    --set @iInsertedCnt = @iInsertedCnt + @@ROWCOUNT ;

    --***********************************************************************************
    --drop table FACT_EDW_CMS_USERSITE
    --select CT_TEMP.USERSITEID, CT_TEMP.SYS_CHANGE_VERSION from CHANGETABLE (CHANGES BASE_CMS_USERSITE , NULL) AS CT_TEMP where SYS_CHANGE_OPERATION = 'U'
    --select * from FACT_EDW_CMS_USERSITE
    --select top 100 * from BASE_CMS_USERSITE
    --select top 100 * from FACT_EDW_CMS_USERSITE
    --update BASE_CMS_USERSITE set UserPreferredCurrencyID = NULL where UserSiteID = 22594   --changes nothing, just enters a rec into CT

    EXEC PrintImmediate 'Populating FACT_EDW_CMS_USERSITE';
    EXEC @iCnt = proc_QuickRowCount 'FACT_EDW_CMS_USERSITE';
    IF @iCnt = 0
        BEGIN

            EXEC PrintImmediate 'Populating immediate FACT_EDW_CMS_USERSITE';
            INSERT INTO FACT_EDW_CMS_USERSITE
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
                   FROM BASE_CMS_USERSITE AS USERSITE;
			 exec proc_SaveCTVerHist @DBNAME , 'BASE_CMS_USERSITE' , -1 ;
        END;

    EXEC PrintImmediate 'Cleaning FACT_EDW_CMS_USERSITE';
    DELETE D
           FROM FACT_EDW_CMS_USERSITE D
                     JOIN CHANGETABLE (CHANGES BASE_CMS_USERSITE , @ChangeVersionID) AS CT_XXX
                     ON
           CT_XXX.SVR = D.SVR AND
           CT_XXX.DBNAME = D.DBNAME AND
           CT_XXX.UserSiteID = D.UserSiteID AND
           SYS_CHANGE_OPERATION = 'D';

    EXEC PrintImmediate 'Updating FACT_EDW_CMS_USERSITE';
    UPDATE S
      SET
          S.USERID = T.USERID
        ,S.SITEID = T.SITEID
        ,S.LastUpdateID = CT_CMS_USERSITE.SYS_CHANGE_VERSION
        ,S.LASTLOADEDDATE = GETDATE () 
        ,S.SVR = T.SVR
        ,S.DBNAME = T.DBNAME
        ,S.DeletedFlg = 0
        ,S.LastModifiedDate = GETDATE () 
          FROM BASE_CMS_USERSITE AS T
                    JOIN FACT_EDW_CMS_USERSITE AS S
                    ON
           S.UserSiteID = T.UserSiteID AND
           S.SVR = T.SVR AND
           S.DBNAME = T.DBNAME
                    JOIN CHANGETABLE ( CHANGES BASE_CMS_USERSITE , @ChangeVersionID) AS CT_CMS_USERSITE
                    ON
           CT_CMS_USERSITE.UserSiteID = T.UserSiteID AND
           CT_CMS_USERSITE.SVR = T.SVR AND
           CT_CMS_USERSITE.DBNAME = T.DBNAME
           --AND CT_CMS_USERSITE.SYS_CHANGE_VERSION != S.LastUpdateID
           AND
           CT_CMS_USERSITE.SYS_CHANGE_OPERATION = 'U';
    EXEC PrintImmediate 'Populating FACT_EDW_CMS_USERSITE';
    WITH CTE_temp (
         SVR
       , DBNAME
       , UserSiteID) 
        AS (
        SELECT
               SVR
             , DBNAME
             , CTE_temp.UserSiteID
               FROM CHANGETABLE (CHANGES BASE_CMS_USERSITE , @ChangeVersionID) AS CTE_temp
               WHERE
               SYS_CHANGE_OPERATION = 'I'
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , UserSiteID
               FROM FACT_EDW_CMS_USERSITE
        ) 
        INSERT INTO FACT_EDW_CMS_USERSITE (
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
               FROM
                    BASE_CMS_USERSITE AS T
                         JOIN CHANGETABLE (CHANGES BASE_CMS_USERSITE , @ChangeVersionID) AS CT_CMS_USERSITE
                         ON
               CT_CMS_USERSITE.UserSiteID = T.UserSiteID AND
               CT_CMS_USERSITE.SYS_CHANGE_OPERATION = 'I' AND
               CT_CMS_USERSITE.SVR = T.SVR AND
               CT_CMS_USERSITE.DBNAME = T.DBNAME
                         JOIN CTE_temp AS C
                         ON
               c.UserSiteID = CT_CMS_USERSITE.UserSiteID AND
               CT_CMS_USERSITE.SVR = C.SVR AND
               CT_CMS_USERSITE.DBNAME = C.DBNAME;

    EXEC @iCnt = proc_QuickRowCount 'FACT_EDW_HFIT_HEALTHASSESMENTUSERMODULE';
    EXEC PrintImmediate 'Populating FACT_EDW_HFIT_HEALTHASSESMENTUSERMODULE';
    IF @iCnt = 0
        BEGIN

            EXEC PrintImmediate 'Populating FACT_EDW_HFIT_HEALTHASSESMENTUSERMODULE';
            INSERT INTO FACT_EDW_HFIT_HEALTHASSESMENTUSERMODULE
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
                   FROM BASE_HFIT_HEALTHASSESMENTUSERMODULE AS HAUSERMODULE;
			 exec proc_SaveCTVerHist @DBNAME , 'BASE_HFIT_HEALTHASSESMENTUSERMODULE' , -1 ;
        END;

    EXEC PrintImmediate 'Cleaning FACT_EDW_HFIT_HEALTHASSESMENTUSERMODULE';
    DELETE D
           FROM FACT_EDW_HFIT_HEALTHASSESMENTUSERMODULE D
                     JOIN CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERMODULE , @ChangeVersionID) AS CT_HFIT_HEALTHASSESMENTUSERMODULE
                     ON
           CT_HFIT_HEALTHASSESMENTUSERMODULE.ItemID = D.ItemID AND
           CT_HFIT_HEALTHASSESMENTUSERMODULE.SVR = D.SVR AND
           CT_HFIT_HEALTHASSESMENTUSERMODULE.DBNAME = D.DBNAME AND
           SYS_CHANGE_OPERATION = 'D';

    EXEC PrintImmediate 'Updating FACT_EDW_HFIT_HEALTHASSESMENTUSERMODULE';
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
        ,S.LastModifiedDate = GETDATE () 
          FROM BASE_HFIT_HEALTHASSESMENTUSERMODULE AS T
                    JOIN FACT_EDW_HFIT_HEALTHASSESMENTUSERMODULE AS S
                    ON
           S.ItemID = T.ItemID AND
           S.SVR = T.SVR AND
           S.DBNAME = T.DBNAME
                    JOIN CHANGETABLE ( CHANGES BASE_HFIT_HEALTHASSESMENTUSERMODULE , @ChangeVersionID) AS CT_HFIT_HEALTHASSESMENTUSERMODULE
                    ON
           CT_HFIT_HEALTHASSESMENTUSERMODULE.ItemID = T.ItemID AND
           CT_HFIT_HEALTHASSESMENTUSERMODULE.SVR = T.SVR AND
           CT_HFIT_HEALTHASSESMENTUSERMODULE.DBNAME = T.DBNAME
           --AND CT_HFIT_HEALTHASSESMENTUSERMODULE.SYS_CHANGE_VERSION != S.LastUpdateID
           AND
           CT_HFIT_HEALTHASSESMENTUSERMODULE.SYS_CHANGE_OPERATION = 'U';

    EXEC PrintImmediate 'Populating FACT_EDW_HFIT_HEALTHASSESMENTUSERMODULE';
    WITH CTE_temp (
         SVR
       , DBNAME
       , ItemID) 
        AS (
        SELECT
               SVR
             , DBNAME
             , CTE_temp.ItemID
               FROM CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERMODULE , @ChangeVersionID) AS CTE_temp
               WHERE
               SYS_CHANGE_OPERATION = 'I'
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , ItemID
               FROM FACT_EDW_HFIT_HEALTHASSESMENTUSERMODULE
        ) 
        INSERT INTO FACT_EDW_HFIT_HEALTHASSESMENTUSERMODULE (
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
               FROM
                    BASE_HFIT_HEALTHASSESMENTUSERMODULE AS T
                         JOIN CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERMODULE , @ChangeVersionID) AS CT_HFIT_HEALTHASSESMENTUSERMODULE
                         ON
               CT_HFIT_HEALTHASSESMENTUSERMODULE.ItemID = T.ItemID AND
               CT_HFIT_HEALTHASSESMENTUSERMODULE.SYS_CHANGE_OPERATION = 'I' AND
               CT_HFIT_HEALTHASSESMENTUSERMODULE.SVR = T.SVR AND
               CT_HFIT_HEALTHASSESMENTUSERMODULE.DBNAME = T.DBNAME
                         JOIN CTE_temp AS C
                         ON
               c.ItemID = CT_HFIT_HEALTHASSESMENTUSERMODULE.ItemID AND
               CT_HFIT_HEALTHASSESMENTUSERMODULE.SVR = C.SVR AND
               CT_HFIT_HEALTHASSESMENTUSERMODULE.DBNAME = C.DBNAME;
    --set @iInsertedCnt = @iInsertedCnt + @@ROWCOUNT ;

    --***********************************************************************************
    --drop table FACT_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY
    --select CT_TEMP.ItemID, CT_TEMP.SYS_CHANGE_VERSION from CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERRISKCATEGORY , NULL) AS CT_TEMP where SYS_CHANGE_OPERATION = 'U'
    --select * from FACT_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY
    --select top 100 * from HFIT_HEALTHASSESMENTUSERRISKCATEGORY
    --select top 100 * from FACT_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY
    --update HFIT_HEALTHASSESMENTUSERRISKCATEGORY set CodeName = 'AboutYou' where itemid = 32919

    EXEC @iCnt = proc_QuickRowCount 'FACT_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY';
    EXEC PrintImmediate 'PROCESSING FACT_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY';
    IF @iCnt = 0
        BEGIN
            EXEC PrintImmediate 'Populating FACT_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY';
            INSERT INTO FACT_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY
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
                   FROM BASE_HFIT_HEALTHASSESMENTUSERRISKCATEGORY AS HARISKCATEGORY;
			 exec proc_SaveCTVerHist @DBNAME , 'BASE_HFIT_HEALTHASSESMENTUSERRISKCATEGORY' , -1 ;
        END;

    EXEC PrintImmediate 'Cleaning FACT_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY';
    DELETE D
           FROM FACT_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY D
                     JOIN CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERRISKCATEGORY , @ChangeVersionID) AS CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY
                     ON
           SYS_CHANGE_OPERATION = 'D' AND
           CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.ItemID = D.ItemID AND
           CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.SVR = D.SVR AND
           CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.DBNAME = D.DBNAME;

    EXEC PrintImmediate 'Updating FACT_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY';
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
        ,S.LastModifiedDate = GETDATE () 
          FROM BASE_HFIT_HEALTHASSESMENTUSERRISKCATEGORY AS T
                    JOIN FACT_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY AS S
                    ON
           S.ItemID = T.ItemID AND
           S.SVR = T.SVR AND
           S.DBNAME = T.DBNAME
                    JOIN CHANGETABLE ( CHANGES BASE_HFIT_HEALTHASSESMENTUSERRISKCATEGORY , @ChangeVersionID) AS CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY
                    ON
           CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.ItemID = T.ItemID
           --AND CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.SYS_CHANGE_VERSION != S.LastUpdateID
           AND
           CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.SYS_CHANGE_OPERATION = 'U' AND
           S.SVR = CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.SVR AND
           S.DBNAME = CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.DBNAME;
    EXEC PrintImmediate 'Populating FACT_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY';
    WITH CTE_temp (
         SVR
       , DBNAME
       , ItemID) 
        AS (
        SELECT
               SVR
             , DBNAME
             , CTE_temp.ItemID
               FROM CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERRISKCATEGORY , @ChangeVersionID) AS CTE_temp
               WHERE
               SYS_CHANGE_OPERATION = 'I'
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , ItemID
               FROM FACT_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY
        ) 
        INSERT INTO FACT_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY (
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
               FROM
                    BASE_HFIT_HEALTHASSESMENTUSERRISKCATEGORY AS T
                         JOIN CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERRISKCATEGORY , @ChangeVersionID) AS CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY
                         ON
               CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.ItemID = T.ItemID AND
               CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.SYS_CHANGE_OPERATION = 'I' AND
               CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.SVR = T.SVR AND
               CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.DBNAME = T.DBNAME
                         JOIN CTE_temp AS C
                         ON
               c.ItemID = CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.ItemID AND
               CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.SVR = C.SVR AND
               CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.DBNAME = C.DBNAME;
    --set @iInsertedCnt = @iInsertedCnt + @@ROWCOUNT ;

    --***********************************************************************************
    --drop table FACT_EDW_CMS_USERSETTINGS
    --select CT_TEMP.UserSettingID, CT_TEMP.SYS_CHANGE_VERSION from CHANGETABLE (CHANGES CMS_USERSETTINGS , NULL) AS CT_TEMP where SYS_CHANGE_OPERATION = 'U'
    --select * from FACT_EDW_CMS_USERSETTINGS
    --select top 100 * from CMS_USERSETTINGS
    --select top 100 * from FACT_EDW_CMS_USERSETTINGS
    --update CMS_USERSETTINGS set UserNickName = 'XXX' where UserSettingsID = 63971
    --update CMS_USERSETTINGS set UserNickName = null where UserSettingsID = 63971

    EXEC @iCnt = proc_QuickRowCount 'FACT_EDW_CMS_USERSETTINGS';
    EXEC PrintImmediate 'Populating FACT_EDW_CMS_USERSETTINGS';
    IF @iCnt = 0
        BEGIN

            EXEC PrintImmediate 'Populating FACT_EDW_CMS_USERSETTINGS';
            INSERT INTO FACT_EDW_CMS_USERSETTINGS
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
                   FROM BASE_CMS_USERSETTINGS AS USERSETTINGS;
			 exec proc_SaveCTVerHist @DBNAME , 'BASE_CMS_USERSETTINGS' , -1 ;
        END;

    EXEC PrintImmediate 'Cleaning FACT_EDW_CMS_USERSETTINGS';
    DELETE D
           FROM FACT_EDW_CMS_USERSETTINGS D
                     JOIN CHANGETABLE (CHANGES BASE_CMS_USERSETTINGS , @ChangeVersionID) AS CT_CMS_USERSETTINGS
                     ON
           SYS_CHANGE_OPERATION = 'D' AND
           D.UserSettingsID = CT_CMS_USERSETTINGS.UserSettingsID AND
           D.SVR = CT_CMS_USERSETTINGS.SVR AND
           D.DBNAME = CT_CMS_USERSETTINGS.DBNAME;

    EXEC PrintImmediate 'Updating FACT_EDW_CMS_USERSETTINGS';
    UPDATE S
      SET
          S.USERSETTINGSUSERID = T.USERSETTINGSUSERID
        ,S.HFITUSERMPINUMBER = T.HFITUSERMPINUMBER
        ,S.LastUpdateID = CT_CMS_USERSETTINGS.SYS_CHANGE_VERSION
        ,S.LASTLOADEDDATE = GETDATE () 
        ,S.SVR = T.SVR
        ,S.DBNAME = T.DBNAME
        ,DeletedFlg = 0
        ,S.LastModifiedDate = GETDATE () 
          FROM BASE_CMS_USERSETTINGS AS T
                    JOIN FACT_EDW_CMS_USERSETTINGS AS S
                    ON
           S.USERSETTINGSID = T.USERSETTINGSID
                    JOIN CHANGETABLE ( CHANGES BASE_CMS_USERSETTINGS , @ChangeVersionID) AS CT_CMS_USERSETTINGS
                    ON
           CT_CMS_USERSETTINGS.USERSETTINGSID = T.USERSETTINGSID
           --AND CT_CMS_USERSETTINGS.SYS_CHANGE_VERSION != S.LastUpdateID
           AND
           CT_CMS_USERSETTINGS.SYS_CHANGE_OPERATION = 'U';

    EXEC PrintImmediate 'Populating FACT_EDW_CMS_USERSETTINGS';
    WITH CTE_temp (
         SVR
       , DBNAME
       , USERSETTINGSID) 
        AS (
        SELECT
               SVR
             , DBNAME
             , CTE_temp.USERSETTINGSID
               FROM CHANGETABLE (CHANGES BASE_CMS_USERSETTINGS , @ChangeVersionID) AS CTE_temp
               WHERE
               SYS_CHANGE_OPERATION = 'I'
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , USERSETTINGSID
               FROM FACT_EDW_CMS_USERSETTINGS
        ) 
        INSERT INTO FACT_EDW_CMS_USERSETTINGS (
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
               FROM
                    BASE_CMS_USERSETTINGS AS T
                         JOIN CHANGETABLE (CHANGES BASE_CMS_USERSETTINGS , @ChangeVersionID) AS CT_CMS_USERSETTINGS
                         ON
               CT_CMS_USERSETTINGS.USERSETTINGSID = T.USERSETTINGSID AND
               CT_CMS_USERSETTINGS.SYS_CHANGE_OPERATION = 'I' AND
               CT_CMS_USERSETTINGS.SVR = T.SVR AND
               CT_CMS_USERSETTINGS.DBNAME = T.DBNAME
                         JOIN CTE_temp AS C
                         ON
               c.USERSETTINGSID = CT_CMS_USERSETTINGS.USERSETTINGSID AND
               CT_CMS_USERSETTINGS.SVR = C.SVR AND
               CT_CMS_USERSETTINGS.DBNAME = C.DBNAME;

    --set @iInsertedCnt = @iInsertedCnt + @@ROWCOUNT ;

    --***********************************************************************************
    --drop table FACT_EDW_HFit_HealthAssesmentUserRiskArea
    --select CT_TEMP.ItemID, CT_TEMP.SYS_CHANGE_VERSION from CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserRiskArea , NULL) AS CT_TEMP where SYS_CHANGE_OPERATION = 'U'
    --select * from FACT_EDW_HFit_HealthAssesmentUserRiskArea
    --select top 100 * from BASE_HFit_HealthAssesmentUserRiskArea
    --select top 100 * from FACT_EDW_HFit_HealthAssesmentUserRiskArea
    --update BASE_HFit_HealthAssesmentUserRiskArea set CodeName = 'AboutYou' where itemid = 46664

    EXEC @iCnt = proc_QuickRowCount 'FACT_EDW_HFit_HealthAssesmentUserRiskArea';
    EXEC PrintImmediate 'Populating FACT_EDW_HFit_HealthAssesmentUserRiskArea';
    IF @iCnt = 0
        BEGIN

            EXEC PrintImmediate 'Add records FACT_EDW_HFit_HealthAssesmentUserRiskArea';
            INSERT INTO FACT_EDW_HFit_HealthAssesmentUserRiskArea
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
                   FROM BASE_HFIT_HealthAssesmentUserRiskArea AS HAUserRiskArea;
			 exec proc_SaveCTVerHist @DBNAME , 'BASE_HFIT_HealthAssesmentUserRiskArea' , -1 ;
        END;

    EXEC PrintImmediate 'Cleaning FACT_EDW_HFit_HealthAssesmentUserRiskArea';
    DELETE D
           FROM FACT_EDW_HFit_HealthAssesmentUserRiskArea D
                     JOIN CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserRiskArea , @ChangeVersionID) AS CT
                     ON
           D.ItemID = CT.ItemID AND
           SYS_CHANGE_OPERATION = 'D' AND
           D.SVR = CT.SVR AND
           D.DBNAME = CT.DBNAME;

    EXEC PrintImmediate 'Updating FACT_EDW_HFit_HealthAssesmentUserRiskArea';
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
        ,S.LastModifiedDate = GETDATE () 
          FROM BASE_HFit_HealthAssesmentUserRiskArea AS T
                    JOIN FACT_EDW_HFit_HealthAssesmentUserRiskArea AS S
                    ON
           S.ItemID = T.ItemID
                    JOIN CHANGETABLE ( CHANGES BASE_HFit_HealthAssesmentUserRiskArea , @ChangeVersionID) AS CT_HFit_HealthAssesmentUserRiskArea
                    ON
           CT_HFit_HealthAssesmentUserRiskArea.ItemID = T.ItemID
           --AND CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_VERSION != S.LastUpdateID
           AND
           CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_OPERATION = 'U';

    EXEC PrintImmediate 'INSERTS FACT_EDW_HFit_HealthAssesmentUserRiskArea';
    WITH CTE_temp (
         SVR
       , DBNAME
       , ItemID) 
        AS (
        SELECT
               SVR
             , DBNAME
             , CTE_temp.ItemID
               FROM CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserRiskArea , @ChangeVersionID) AS CTE_temp
               WHERE
               SYS_CHANGE_OPERATION = 'I'
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , ItemID
               FROM FACT_EDW_HFit_HealthAssesmentUserRiskArea
        ) 
        INSERT INTO FACT_EDW_HFit_HealthAssesmentUserRiskArea (
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
               FROM
                    BASE_HFit_HealthAssesmentUserRiskArea AS T
                         JOIN CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserRiskArea , @ChangeVersionID) AS CT_HFit_HealthAssesmentUserRiskArea
                         ON
               CT_HFit_HealthAssesmentUserRiskArea.ItemID = T.ItemID AND
               CT_HFit_HealthAssesmentUserRiskArea.SVR = T.SVR AND
               CT_HFit_HealthAssesmentUserRiskArea.DBNAME = T.DBNAME AND
               CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_OPERATION = 'I'
                         JOIN CTE_temp AS C
                         ON
               c.ItemID = CT_HFit_HealthAssesmentUserRiskArea.ItemID AND
               c.SVR = CT_HFit_HealthAssesmentUserRiskArea.SVR AND
               c.DBNAME = CT_HFit_HealthAssesmentUserRiskArea.DBNAME;
    --set @iInsertedCnt = @iInsertedCnt + @@ROWCOUNT ;

    --***********************************************************************************		 
    --drop table FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS
    --select CT_TEMP.ItemID, CT_TEMP.SYS_CHANGE_VERSION from CHANGETABLE (CHANGES FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS , NULL) AS CT_TEMP where SYS_CHANGE_OPERATION = 'U'
    --select * from FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS
    --select top 100 * from FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS
    --select top 100 * from FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS
    --update FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS set CodeName = 'MME' where itemid = 19864

    EXEC @iCnt = proc_QuickRowCount 'FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS';
    EXEC PrintImmediate 'Populating FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS';
    IF @iCnt = 0
        BEGIN

            EXEC PrintImmediate 'Populating FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS';
            INSERT INTO FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS
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
                   --FROM FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS AS HAUserQuestionGroupResults;
				FROM BASE_HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults;
			 exec proc_SaveCTVerHist @DBNAME , 'BASE_HFit_HealthAssesmentUserQuestionGroupResults' , -1 ;
        END;

    --EXEC PrintImmediate 'Cleaning FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS';
    EXEC PrintImmediate 'Cleaning BASE_HFit_HealthAssesmentUserQuestionGroupResults';
    DELETE D
           --FROM FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS D
		  FROM BASE_HFit_HealthAssesmentUserQuestionGroupResults D
                     JOIN CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserQuestionGroupResults , @ChangeVersionID) AS CT
                     ON
           D.ItemID = CT.ItemID AND
           SYS_CHANGE_OPERATION = 'D' AND
           D.SVR = CT.SVR AND
           D.DBNAME = CT.DBNAME;

    EXEC PrintImmediate 'Updating FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS';
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
        ,S.LastModifiedDate = GETDATE () 
          FROM BASE_HFit_HealthAssesmentUserQuestionGroupResults AS T
                    JOIN FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS AS S
                    ON
           S.ItemID = T.ItemID AND
           S.SVR = T.SVR AND
           S.DBNAME = T.DBNAME
                    JOIN CHANGETABLE ( CHANGES BASE_HFit_HealthAssesmentUserQuestionGroupResults , @ChangeVersionID) AS CT_HFit_HealthAssesmentUserQuestionGroupResults
                    ON
           CT_HFit_HealthAssesmentUserQuestionGroupResults.ItemID = T.ItemID
           --AND CT_HFit_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_VERSION != S.LastUpdateID
           AND
           CT_HFit_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_OPERATION = 'U' AND
           S.SVR = CT_HFit_HealthAssesmentUserQuestionGroupResults.SVR AND
           S.DBNAME = CT_HFit_HealthAssesmentUserQuestionGroupResults.DBNAME;

    EXEC PrintImmediate 'Populating FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS';
    WITH CTE_temp (
         SVR
       , DBNAME
       , ItemID) 
        AS (
        SELECT
               SVR
             , DBNAME
             , CTE_temp.ItemID
               FROM CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserQuestionGroupResults , @ChangeVersionID) AS CTE_temp
               WHERE
               SYS_CHANGE_OPERATION = 'I'
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , ItemID
               FROM FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS
        ) 
        INSERT INTO FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS (
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
               FROM
                    FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS AS T
                         JOIN CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserQuestionGroupResults , @ChangeVersionID) AS CT_HFit_HealthAssesmentUserQuestionGroupResults
                         ON
               CT_HFit_HealthAssesmentUserQuestionGroupResults.ItemID = T.ItemID AND
               CT_HFit_HealthAssesmentUserQuestionGroupResults.SVR = T.SVR AND
               CT_HFit_HealthAssesmentUserQuestionGroupResults.DBNAME = T.DBNAME AND
               CT_HFit_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_OPERATION = 'I'
                         JOIN CTE_temp AS C
                         ON
               c.ItemID = CT_HFit_HealthAssesmentUserQuestionGroupResults.ItemID AND
               CT_HFit_HealthAssesmentUserQuestionGroupResults.SVR = C.SVR AND
               CT_HFit_HealthAssesmentUserQuestionGroupResults.DBNAME = C.DBNAME;
    --set @iInsertedCnt = @iInsertedCnt + @@ROWCOUNT ;

    --***********************************************************************************
    -- drop table FACT_EDW_HFit_HealthAssesmentUserQuestion
    -- select top 100 * from FACT_EDW_HFit_HealthAssesmentUserQuestion

    EXEC PrintImmediate 'Populating #TEMP_BASE_HFIT_HEALTHASSESMENTUSERQUESTION';
    SELECT
           CT.ITEMID
         , CT.SVR
         , CT.DBNAME
         , CT.SYS_CHANGE_OPERATION
         , CT.SYS_CHANGE_VERSION
    INTO
         #TEMP_BASE_HFIT_HEALTHASSESMENTUSERQUESTION
           FROM CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERQUESTION , 0) AS CT;

    RAISERROR ('Populated TEMP_BASE_HFIT_HEALTHASSESMENTUSERQUESTION.' , 10 , 1) WITH NOWAIT;
    RAISERROR ('Creating IDXTEMP_BASE_HFIT_HEALTHASSESMENTUSERQUESTION.' , 10 , 1) WITH NOWAIT;

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.indexes
                          WHERE
                          name = 'IDXTEMP_BASE_HFIT_HEALTHASSESMENTUSERQUESTION') 
        BEGIN
            CREATE CLUSTERED INDEX IDXTEMP_BASE_HFIT_HEALTHASSESMENTUSERQUESTION ON #TEMP_BASE_HFIT_HEALTHASSESMENTUSERQUESTION
            (SVR , DBNAME , ITEMID , SYS_CHANGE_OPERATION , SYS_CHANGE_VERSION) 
        END;
    RAISERROR ('Created IDXTEMP_BASE_HFIT_HEALTHASSESMENTUSERQUESTION.' , 10 , 1) WITH NOWAIT;

    -- Truncate table FACT_EDW_HFit_HealthAssesmentUserQuestion
    EXEC @iCnt = proc_QuickRowCount 'FACT_EDW_HFit_HealthAssesmentUserQuestion';
    EXEC PrintImmediate 'Populating FACT_EDW_HFit_HealthAssesmentUserQuestion';
    IF @iCnt = 0
        BEGIN
            EXEC PrintImmediate 'Populating FACT_EDW_HFit_HealthAssesmentUserQuestion';
            INSERT INTO FACT_EDW_HFit_HealthAssesmentUserQuestion
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
                        BASE_HFIT_HEALTHASSESMENTUSERQUESTION AS USERQUES
                             LEFT OUTER JOIN #TEMP_BASE_HFIT_HEALTHASSESMENTUSERQUESTION AS CT_HFIT_HEALTHASSESMENTUSERQUESTION
                             ON
                   USERQUES.ITEMID = CT_HFIT_HEALTHASSESMENTUSERQUESTION.ITEMID AND
                   USERQUES.svr = CT_HFIT_HEALTHASSESMENTUSERQUESTION.svr AND
                   USERQUES.DBNAME = CT_HFIT_HEALTHASSESMENTUSERQUESTION.DBNAME;
			 exec proc_SaveCTVerHist @DBNAME , 'BASE_HFIT_HEALTHASSESMENTUSERQUESTION' , -1 ;
        END;

    EXEC PrintImmediate 'Populating Inserts FACT_EDW_HFit_HealthAssesmentUserQuestion';
    WITH CTE_HFIT_HEALTHASSESMENTUSERQUESTION (
         SVR
       , DBNAME
       , ItemID) 
        AS (
        SELECT
               SVR
             , DBNAME
             , CT_HFIT_HEALTHASSESMENTUSERQUESTION.ItemID
               FROM CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERQUESTION , @ChangeVersionID) AS CT_HFIT_HEALTHASSESMENTUSERQUESTION
               WHERE
               SYS_CHANGE_OPERATION = 'I'
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , itemid
               FROM FACT_EDW_HFit_HealthAssesmentUserQuestion
        ) 
        INSERT INTO FACT_EDW_HFit_HealthAssesmentUserQuestion (
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
               FROM
                    BASE_HFIT_HEALTHASSESMENTUSERQUESTION AS T
                         JOIN CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERQUESTION , @ChangeVersionID) AS CT_HFIT_HEALTHASSESMENTUSERQUESTION
                         ON
               CT_HFIT_HEALTHASSESMENTUSERQUESTION.ItemID = T.ItemID AND
               CT_HFIT_HEALTHASSESMENTUSERQUESTION.SVR = T.SVR AND
               CT_HFIT_HEALTHASSESMENTUSERQUESTION.DBNAME = T.DBNAME AND
               CT_HFIT_HEALTHASSESMENTUSERQUESTION.SYS_CHANGE_OPERATION = 'I'
                         JOIN CTE_HFIT_HEALTHASSESMENTUSERQUESTION
                         ON
               CTE_HFIT_HEALTHASSESMENTUSERQUESTION.ItemID = T.ItemID AND
               CTE_HFIT_HEALTHASSESMENTUSERQUESTION.SVR = T.SVR AND
               CTE_HFIT_HEALTHASSESMENTUSERQUESTION.DBNAME = T.DBNAME;

    --set @iInsertedCnt = @iInsertedCnt + @@ROWCOUNT ;
    DELETE D
           FROM FACT_EDW_HFit_HealthAssesmentUserQuestion D
                     JOIN CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERQUESTION , @ChangeVersionID) AS CT
                     ON
           D.ItemID = CT.ItemID AND
           SYS_CHANGE_OPERATION = 'D' AND
           D.SVR = CT.SVR AND
           D.DBNAME = CT.DBNAME;

    EXEC PrintImmediate 'Updating FACT_EDW_HFit_HealthAssesmentUserQuestion';
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
               FROM CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERQUESTION , @ChangeVersionID) AS CT_CMS_HFIT_HEALTHASSESMENTUSERQUESTION
               WHERE
               SYS_CHANGE_OPERATION = 'U'
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , ItemID
             , LastUpdateID
               FROM FACT_EDW_HFit_HealthAssesmentUserQuestion
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
            ,S.LastModifiedDate = GETDATE () 
              FROM BASE_HFIT_HEALTHASSESMENTUSERQUESTION AS T
                        JOIN FACT_EDW_HFit_HealthAssesmentUserQuestion AS S
                        ON
               S.ItemID = T.ItemID AND
               S.SVR = T.SVR AND
               S.DBNAME = T.DBNAME
                        JOIN CHANGETABLE ( CHANGES BASE_HFIT_HEALTHASSESMENTUSERQUESTION , @ChangeVersionID) AS CT_HFIT_HEALTHASSESMENTUSERQUESTION
                        ON
               CT_HFIT_HEALTHASSESMENTUSERQUESTION.ItemID = T.ItemID AND
               S.ItemID = T.ItemID AND
               S.SVR = T.SVR AND
               S.DBNAME = T.DBNAME
               --AND CT_HFIT_HEALTHASSESMENTUSERQUESTION.SYS_CHANGE_VERSION != S.LastUpdateID
               AND
               CT_HFIT_HEALTHASSESMENTUSERQUESTION.SYS_CHANGE_OPERATION = 'U'
                        JOIN CTE_HAQ
                        ON
               CTE_HAQ.ItemID = S.ItemID AND
               CTE_HAQ.SVR = S.SVR AND
               CTE_HAQ.DBNAME = S.DBNAME;

    --********************************************************************************************
    -- THIS IS A TABLE CREATED FROM A VIEW WITH A SMALL NUMBER OF ROWS, JUST DROP AND RECREATE.
    --truncate TABLE FACT_EDW_VIEW_HFIT_HACAMPAIGN_JOINED;
    EXEC @iCnt = proc_QuickRowCount 'FACT_EDW_VIEW_HFIT_HACAMPAIGN_JOINED';
    EXEC PrintImmediate 'Populating FACT_EDW_VIEW_HFIT_HACAMPAIGN_JOINED';
    -- drop table FACT_EDW_VIEW_HFIT_HACAMPAIGN_JOINED ;
    IF @iCnt = 0
        BEGIN
            -- Select * from FACT_EDW_VIEW_HFIT_HACAMPAIGN_JOINED 
            EXEC PrintImmediate 'Populating FACT_EDW_VIEW_HFIT_HACAMPAIGN_JOINED';
            INSERT INTO FACT_EDW_VIEW_HFIT_HACAMPAIGN_JOINED
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
                 , CAMPAIGN.SVR
                 , CAMPAIGN.DBNAME
                 , 0 AS DeletedFlg
                 , GETDATE () AS LastModifiedDate
                   FROM View_HFit_HACampaign_Joined AS CAMPAIGN;
        END;

    --***********************************************************************************
    --select top 100 * from View_HFit_HealthAssessment_Joined
    -- THIS IS A TABLE CREATED FROM A VIEW WITH A SMALL NUMBER OF ROWS, JUST DROP AND RECREATE.
    --truncate TABLE FACT_EDW_VIEW_HFIT_HEALTHASSESSMENT_JOINED;
    EXEC @iCnt = proc_QuickRowCount 'FACT_EDW_VIEW_HFIT_HEALTHASSESSMENT_JOINED';
    EXEC PrintImmediate 'Populating FACT_EDW_VIEW_HFIT_HEALTHASSESSMENT_JOINED';
    IF @iCnt = 0
        BEGIN

            EXEC PrintImmediate 'Populating FACT_EDW_VIEW_HFIT_HEALTHASSESSMENT_JOINED';
            INSERT INTO FACT_EDW_VIEW_HFIT_HEALTHASSESSMENT_JOINED
            (
                   NODEGUID
                 , DOCUMENTID
                 , DOCUMENTCULTURE
                 , LastUpdateID
                 , LASTLOADEDDATE
                 , SVR
                 , DBNAME
                 , DeletedFlg) 
            SELECT distinct
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
select * from VIEW_HFIT_HEALTHASSESSMENT_JOINED
    --truncate table FACT_View_EDW_HealthAssesmentQuestions
    EXEC @iCnt = proc_QuickRowCount 'FACT_View_EDW_HealthAssesmentQuestions';
    EXEC PrintImmediate 'Populating FACT_View_EDW_HealthAssesmentQuestions';
    IF @iCnt = 0
        BEGIN

            EXEC PrintImmediate 'Populating FACT_View_EDW_HealthAssesmentQuestions';
            INSERT INTO FACT_View_EDW_HealthAssesmentQuestions
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
                   FROM View_EDW_HealthAssesmentQuestions AS QUES;
        END;

    --***********************************************************************************		 		 
    EXEC PrintImmediate 'Populating PI_FACT_HAUserQuestionGroupResults';
    IF NOT EXISTS ( SELECT
                           NAME
                           FROM SYS.INDEXES
                           WHERE
                           NAME = 'PI_FACT_HAUserQuestionGroupResults') 
        BEGIN
            EXEC PrintImmediate 'Populating PI_FACT_HAUserQuestionGroupResults';
            CREATE NONCLUSTERED INDEX PI_FACT_HAUserQuestionGroupResults ON DBO.FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS ( SVR ASC , DBNAME ASC , HARiskAreaItemID ASC) INCLUDE (
            ITEMID
            , POINTRESULTS
            , CODENAME) ;
        END;
    SET ANSI_PADDING ON;
    SET NOCOUNT OFF;
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    EXEC PrintImmediate '**LEAVING Populating Staging Tables: ';

END;
GO
EXEC PrintImmediate 'Executed proc_EDW_UpdateDIMTables.sql';
EXEC PrintImmediate 'RUNNING PROCEDURE proc_EDW_UpdateDIMTables';
GO

--EXEC PrintImmediate 'ERROR ERROR ERROR ERROR ERROR ERROR ERROR ';
PRINT GETDATE () ;
EXEC proc_EDW_UpdateDIMTables;
EXEC PrintImmediate 'COMPLETED RUNNING PROCEDURE proc_EDW_UpdateDIMTables';
PRINT GETDATE () ;

GO
