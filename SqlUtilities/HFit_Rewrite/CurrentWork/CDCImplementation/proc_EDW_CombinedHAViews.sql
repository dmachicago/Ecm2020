
GO

PRINT 'Executing proc_EDW_CombinedHAViews.sql';

GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_EDW_CombinedHAViews') 
    BEGIN
        DROP PROCEDURE
             proc_EDW_CombinedHAViews;
    END;

GO
-- drop table FACT_EDW_CombinedHAViews
CREATE PROCEDURE proc_EDW_CombinedHAViews
AS
BEGIN
    DECLARE
    @iRows AS BIGINT = 0;

    EXEC @iRows = proc_QuickRowCount 'FACT_EDW_CombinedHAViews';
    IF @iRows = 0
   AND EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE
                      name = 'FACT_EDW_CombinedHAViews') 
        BEGIN
            DROP TABLE
                 FACT_EDW_CombinedHAViews;
        END;

    IF @iRows = 0
    OR NOT EXISTS (SELECT
                          name
                          FROM sys.tables
                          WHERE
                          name = 'FACT_EDW_CombinedHAViews') 
        BEGIN
            SELECT
                   HARISKCATEGORY.ITEMID AS USERRISKCATEGORYITEMID
                 , HARISKCATEGORY.CODENAME AS USERRISKCATEGORYCODENAME
                 , HARISKCATEGORY.HARISKCATEGORYNODEGUID
                 , HARISKCATEGORY.HARISKCATEGORYSCORE
                 , HARISKCATEGORY.PREWEIGHTEDSCORE AS RISKCATEGORYPREWEIGHTEDSCORE
                 , HARISKCATEGORY.ITEMMODIFIEDWHEN AS HARISKCATEGORY_ITEMMODIFIEDWHEN
                 , HARISKCATEGORY.ItemID AS HAMODULEITEMID

                 , HAUSERRISKAREA.ITEMID AS USERRISKAREAITEMID
                 , HAUSERRISKAREA.CODENAME AS USERRISKAREACODENAME
                 , HAUSERRISKAREA.HARISKAREANODEGUID
                 , HAUSERRISKAREA.HARISKAREASCORE
                 , HAUSERRISKAREA.PREWEIGHTEDSCORE AS RISKAREAPREWEIGHTEDSCORE
                 , HAUSERRISKAREA.ITEMMODIFIEDWHEN AS HAUSERRISKAREA_ITEMMODIFIEDWHEN

                 , HAUSERQUESTION.ITEMID AS USERQUESTIONITEMID
                 , HAUSERQUESTION.HAQUESTIONNODEGUID AS HAQUESTIONGUID
                 , HAUSERQUESTION.CODENAME AS USERQUESTIONCODENAME
                 , HAUSERQUESTION.HAQUESTIONNODEGUID
                 , HAUSERQUESTION.HAQUESTIONSCORE
                 , HAUSERQUESTION.PREWEIGHTEDSCORE AS QUESTIONPREWEIGHTEDSCORE
                 , HAUSERQUESTION.ISPROFESSIONALLYCOLLECTED
                 , HAUSERQUESTION.ITEMMODIFIEDWHEN AS HAUSERQUESTION_ITEMMODIFIEDWHEN

                 , HAQUESTIONSVIEW.TITLE
                 , HAQUESTIONSVIEW.DOCUMENTCULTURE AS DOCUMENTCULTURE_HAQUESTIONSVIEW
                 , HAQUESTIONSVIEW.LASTLOADEDDATE AS HAQUESTIONSVIEW_LASTMODIFIED

                 , HAUSERQUESTIONGROUPRESULTS.ItemID AS GroupResultsItemID
                 , HAUSERQUESTIONGROUPRESULTS.POINTRESULTS
                 , HAUSERQUESTIONGROUPRESULTS.CODENAME AS QUESTIONGROUPCODENAME
                 , HAUSERQUESTIONGROUPRESULTS.HARISKAREAITEMID
                 , HAUSERQUESTIONGROUPRESULTS.LASTLOADEDDATE AS HAUSERQUESTIONGROUPRESULTS_LASTMODIFIED

                 , HAUSERANSWERS.ITEMID AS USERANSWERITEMID
                 , HAUSERANSWERS.HAANSWERNODEGUID
                 , HAUSERANSWERS.CODENAME AS USERANSWERCODENAME
                 , HAUSERANSWERS.HAANSWERVALUE
                 , HAUSERANSWERS.HAANSWERPOINTS
                 , HAUSERANSWERS.UOMCODE
                 , HAUSERANSWERS.HAQUESTIONITEMID
                 , HAUSERANSWERS.ITEMCREATEDWHEN
                 , HAUSERANSWERS.ITEMMODIFIEDWHEN AS HAUSERANSWERS_ITEMMODIFIEDWHEN

                 , GETDATE () AS LASTLOADEDDATE
                 , HARISKCATEGORY.SVR
                 , HARISKCATEGORY.DBNAME
                 , DeletedFlg = 0
                 , HAUSERANSWERS.LastModifiedDate

            INTO
                 FACT_EDW_CombinedHAViews
                   FROM
            DBO.FACT_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY AS HARISKCATEGORY
                JOIN DBO.FACT_EDW_HFit_HealthAssesmentUserRiskArea AS HAUSERRISKAREA
                    ON
                    HARISKCATEGORY.ITEMID = HAUSERRISKAREA.HARISKCATEGORYITEMID
                INNER JOIN DBO.FACT_EDW_HFit_HealthAssesmentUserQuestion AS HAUSERQUESTION
                    ON
                    HAUSERRISKAREA.ITEMID = HAUSERQUESTION.HARISKAREAITEMID
                INNER JOIN DBO.FACT_View_EDW_HealthAssesmentQuestions AS HAQUESTIONSVIEW
                    ON
                    HAUSERQUESTION.HAQUESTIONNODEGUID = HAQUESTIONSVIEW.NODEGUID
                LEFT JOIN DBO.FACT_EDW_HFit_HealthAssesmentUserQuestionGROUPRESULTS AS HAUSERQUESTIONGROUPRESULTS
                    ON
                    HAUSERRISKAREA.ITEMID = HAUSERQUESTIONGROUPRESULTS.HARISKAREAITEMID
                INNER JOIN DBO.FACT_EDW_HFIT_HealthAssesmentUserAnswers AS HAUSERANSWERS
                    ON
                    HAUSERQUESTION.ITEMID = HAUSERANSWERS.HAQUESTIONITEMID;

        END;

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.indexes
                          WHERE
                          name = 'PI_EDW_CombinedHAViews') 
        BEGIN
            CREATE CLUSTERED INDEX PI_EDW_CombinedHAViews ON dbo.FACT_EDW_CombinedHAViews
            (SVR ASC, DBNAME ASC,
            USERRISKCATEGORYITEMID ASC ,
            USERRISKAREAITEMID ASC ,
            HARISKAREANODEGUID ASC ,
            USERQUESTIONITEMID ASC ,
            HAQUESTIONGUID ASC ,
            HAQUESTIONNODEGUID ASC ,
            HAANSWERNODEGUID ASC, LastModifiedDate
            )WITH (PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
        END;

    --***********************************************************************************

    DELETE FROM		FACT_EDW_CombinedHAViews	  -- FACT_EDW_HFIT_HealthAssesmentUserAnswers
    WHERE
          USERANSWERITEMID IN ( SELECT
                                       CT_HealthAssesmentUserAnswers.ItemID
                                       FROM CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserAnswers, NULL) AS CT_HealthAssesmentUserAnswers
                                       WHERE
                                       SYS_CHANGE_OPERATION = 'D') ;

    UPDATE S
           SET
               S.HAANSWERNODEGUID = T.HAANSWERNODEGUID
             ,S.USERANSWERCODENAME = T.CODENAME
             ,S.HAANSWERVALUE = T.HAANSWERVALUE
             ,S.HAANSWERPOINTS = T.HAANSWERPOINTS
             ,S.UOMCODE = T.UOMCODE
             ,S.ITEMCREATEDWHEN = T.ITEMCREATEDWHEN
             ,S.HAUSERANSWERS_ITEMMODIFIEDWHEN = T.ITEMMODIFIEDWHEN
             ,S.HAQUESTIONITEMID = T.HAQUESTIONITEMID
               --,S.LASTUPDATEID = CT_HealthAssesmentUserAnswers.SYS_CHANGE_VERSION
             ,
               S.LASTLOADEDDATE = GETDATE () 
             ,SVR = @@Servername
             ,DBNAME = DB_NAME () 
             ,DeletedFlg = 0
             ,S.LastModifiedDate = T.LastModifiedDate
               FROM BASE_HFit_HealthAssesmentUserAnswers AS T
                        JOIN FACT_EDW_CombinedHAViews AS S
                            ON
                            S.USERANSWERITEMID = T.ItemID
                        AND S.SVR = T.SVR
                        AND S.DBNAME = T.DBNAME
                        JOIN CHANGETABLE ( CHANGES BASE_HFit_HealthAssesmentUserAnswers , NULL) AS CT_HealthAssesmentUserAnswers
                            ON
                            CT_HealthAssesmentUserAnswers.ItemID = T.ItemID
                        AND CT_HealthAssesmentUserAnswers.SVR = T.SVR
                        AND CT_HealthAssesmentUserAnswers.DBNAME = T.DBNAME
                        AND CT_HealthAssesmentUserAnswers.SYS_CHANGE_OPERATION = 'U';

    --***********************************************************************************

    DELETE FROM FACT_EDW_CombinedHAViews
    WHERE
          GroupResultsItemID IN ( SELECT
                                         CT_HFit_HealthAssesmentUserQuestionGroupResults.ItemID
                                         FROM CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserQuestionGroupResults, NULL) AS CT_HFit_HealthAssesmentUserQuestionGroupResults
                                         WHERE
                                         SYS_CHANGE_OPERATION = 'D') ;

    UPDATE S
           SET
               S.POINTRESULTS = T.POINTRESULTS
             ,S.QUESTIONGROUPCODENAME = T.CODENAME
             ,S.HARISKAREAITEMID = T.HARISKAREAITEMID
             ,S.HAUSERQUESTIONGROUPRESULTS_LASTMODIFIED = GETDATE () 
             ,S.SVR = T.SVR
             ,S.DBNAME = T.DBNAME
             ,S.LastModifiedDate = T.LastModifiedDate
             ,DeletedFlg = 0
               FROM FACT_EDW_HFit_HealthAssesmentUserQuestionGroupResults AS T
                        JOIN FACT_EDW_CombinedHAViews AS S
                            ON
                            S.GroupResultsItemID = T.ItemID
                        AND S.SVR = T.SVR
                        AND S.DBNAME = T.DBNAME
                        JOIN CHANGETABLE ( CHANGES BASE_HFit_HealthAssesmentUserQuestionGroupResults , NULL) AS CT_HFit_HealthAssesmentUserQuestionGroupResults
                            ON
                            CT_HFit_HealthAssesmentUserQuestionGroupResults.ItemID = T.ItemID
                        AND CT_HFit_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_OPERATION = 'U'
                        AND CT_HFit_HealthAssesmentUserQuestionGroupResults.SVR = T.SVR
                        AND CT_HFit_HealthAssesmentUserQuestionGroupResults.DBNAME = T.DBNAME;

    --***********************************************************************************

    DELETE FROM FACT_EDW_CombinedHAViews
    WHERE
          USERQUESTIONITEMID IN ( SELECT
                                         CT_CMS_HFIT_HEALTHASSESMENTUSERQUESTION.ItemID
                                         FROM CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERQUESTION, NULL) AS CT_CMS_HFIT_HEALTHASSESMENTUSERQUESTION
                                         WHERE
                                         SYS_CHANGE_OPERATION = 'D') ;

    WITH CTE_HAQ (
         SVR, DBNAME, ItemID) 
        AS (
        SELECT
			 CT_CMS_HFIT_HEALTHASSESMENTUSERQUESTION.SVR,
			 CT_CMS_HFIT_HEALTHASSESMENTUSERQUESTION.DBNAME,
               CT_CMS_HFIT_HEALTHASSESMENTUSERQUESTION.ItemID
               FROM CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERQUESTION, NULL) AS CT_CMS_HFIT_HEALTHASSESMENTUSERQUESTION
               WHERE
               SYS_CHANGE_OPERATION = 'U'
        EXCEPT
        SELECT
			SVR,
			DBNAME,               
               USERQUESTIONITEMID
               FROM FACT_EDW_CombinedHAViews
        ) 

        UPDATE S
               SET
                   S.HAQUESTIONGUID = T.HAQUESTIONNODEGUID
                 ,S.USERQUESTIONCODENAME = T.CODENAME
                 ,S.HAQUESTIONSCORE = T.HAQUESTIONSCORE
                 ,S.QUESTIONPREWEIGHTEDSCORE = T.PREWEIGHTEDSCORE
                 ,S.ISPROFESSIONALLYCOLLECTED = T.ISPROFESSIONALLYCOLLECTED
                 ,S.HAUSERQUESTION_ITEMMODIFIEDWHEN = T.ITEMMODIFIEDWHEN
                 ,S.LASTLOADEDDATE = GETDATE () 
                 ,S.SVR = T.SVR
                 ,S.DBNAME = T.DBNAME
                 ,S.DeletedFlg = 0
                 ,S.LastModifiedDate = T.LastModifiedDate

                   FROM BASE_HFIT_HEALTHASSESMENTUSERQUESTION AS T
                            JOIN FACT_EDW_CombinedHAViews AS S
                                ON
                                S.USERQUESTIONITEMID = T.ItemID
                            AND S.SVR = T.SVR
                            AND S.DBNAME = T.DBNAME
                            JOIN CHANGETABLE ( CHANGES BASE_HFIT_HEALTHASSESMENTUSERQUESTION , NULL) AS CT_HAQ
                                ON
                                CT_HAQ.ItemID = T.ItemID
                            AND S.USERQUESTIONITEMID = T.ItemID
                            AND CT_HAQ.SYS_CHANGE_OPERATION = 'U'
                            AND CT_HAQ.SVR = T.SVR
                            AND CT_HAQ.DBNAME = T.DBNAME
                            JOIN CTE_HAQ
                                ON
                                CTE_HAQ.ItemID = S.USERQUESTIONITEMID
                            AND CTE_HAQ.SVR = S.SVR
                            AND CTE_HAQ.DBNAME = S.DBNAME;

    --***********************************************************************************

    DELETE FROM	 FACT_EDW_CombinedHAViews
    WHERE
          USERRISKCATEGORYITEMID IN ( SELECT
                                             CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.ItemID
                                             FROM CHANGETABLE (CHANGES HFIT_HEALTHASSESMENTUSERRISKCATEGORY, NULL) AS CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY
                                             WHERE
                                             SYS_CHANGE_OPERATION = 'D') ;

    UPDATE S
           SET
               S.USERRISKCATEGORYCODENAME = T.CODENAME
             ,S.HARISKCATEGORYNODEGUID = T.HARISKCATEGORYNODEGUID
             ,S.HARISKCATEGORYSCORE = T.HARISKCATEGORYSCORE
             ,S.RISKCATEGORYPREWEIGHTEDSCORE = T.PREWEIGHTEDSCORE
             ,S.HARISKCATEGORY_ITEMMODIFIEDWHEN = T.ITEMMODIFIEDWHEN
             ,S.HAMODULEITEMID = T.HAMODULEITEMID
             ,S.LASTLOADEDDATE = GETDATE () 
             ,S.SVR = T.SVR
             ,S.DBNAME = T.DBNAME
             ,S.LastModifiedDate = T.LastModifiedDate
             ,DeletedFlg = 0
               FROM HFIT_HEALTHASSESMENTUSERRISKCATEGORY AS T
                        JOIN FACT_EDW_CombinedHAViews AS S
                            ON
                            S.USERRISKCATEGORYITEMID = T.ItemID
                        AND T.SVR = S.SVR
                        AND T.DBNAME = S.DBNAME
                        JOIN CHANGETABLE ( CHANGES HFIT_HEALTHASSESMENTUSERRISKCATEGORY , NULL) AS CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY
                            ON
                            CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.ItemID = S.USERRISKCATEGORYITEMID
                        AND CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.SYS_CHANGE_OPERATION = 'U'
                        AND CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.SVR = S.SVR
                        AND CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.DBNAME = S.DBNAME;

    --WITH CTE_temp (
    --     [ItemID]) 
    --    AS (
    --    SELECT
    --           [CTE_temp].[ItemID]
    --           FROM CHANGETABLE (CHANGES [HFIT_HEALTHASSESMENTUSERRISKCATEGORY], NULL) AS [CTE_temp]
    --           WHERE
    --           [SYS_CHANGE_OPERATION] = 'I'
    --    EXCEPT
    --    SELECT
    --           [ItemID]
    --           FROM [FACT_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY]
    --    ) 
    --    INSERT INTO [FACT_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY] (
    --           [ITEMID]
    --         , [CODENAME]
    --         , [HARISKCATEGORYNODEGUID]
    --         , [HARISKCATEGORYSCORE]
    --         , [PREWEIGHTEDSCORE]
    --         , [ITEMMODIFIEDWHEN]
    --         , [HAMODULEITEMID]
    --         , [LASTUPDATEID]
    --         , [LASTLOADEDDATE]
    --         , [SVR]
    --         , [DBNAME]
    --         , [DeletedFlg]) 
    --    SELECT
    --           [T].[ITEMID]
    --         , [T].[CODENAME]
    --         , [T].[HARISKCATEGORYNODEGUID]
    --         , [T].[HARISKCATEGORYSCORE]
    --         , [T].[PREWEIGHTEDSCORE]
    --         , [T].[ITEMMODIFIEDWHEN]
    --         , [T].[HAMODULEITEMID]
    --         , [CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY].[SYS_CHANGE_VERSION] AS [LASTUPDATEID]
    --         , GETDATE () AS [LASTLOADEDDATE]
    --         , @@Servername AS [SVR]
    --         , DB_NAME () AS [DBNAME]
    --         , 0 AS [DeletedFlg]
    --           FROM
    --               [HFIT_HEALTHASSESMENTUSERRISKCATEGORY] AS [T]
    --               JOIN CHANGETABLE (CHANGES [HFIT_HEALTHASSESMENTUSERRISKCATEGORY], NULL) AS [CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY]
    --               ON [CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY].[ItemID] = [T].[ItemID]
    --              AND [CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY].[SYS_CHANGE_OPERATION] = 'I'
    --               JOIN [CTE_temp] AS [C]
    --               ON [c].[ItemID] = [CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY].[ItemID];

    --***********************************************************************************
    DELETE FROM FACT_EDW_CombinedHAViews
    WHERE
          USERRISKAREAITEMID IN ( SELECT
                                         CT_HFit_HealthAssesmentUserRiskArea.ItemID
                                         FROM CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERRISKAREA, NULL) AS CT_HFit_HealthAssesmentUserRiskArea
                                         WHERE
                                         SYS_CHANGE_OPERATION = 'D') ;

    UPDATE S
           SET
               S.USERRISKAREACODENAME = T.CODENAME
             ,S.HARISKAREANODEGUID = T.HARISKAREANODEGUID
             ,S.HARISKAREASCORE = T.HARISKAREASCORE
             ,S.RISKAREAPREWEIGHTEDSCORE = T.PREWEIGHTEDSCORE
             ,S.HAUSERRISKAREA_ITEMMODIFIEDWHEN = T.ITEMMODIFIEDWHEN
               --,S.LASTUPDATEID = CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_VERSION
             ,
               S.LASTLOADEDDATE = GETDATE () 
             ,S.SVR = T.SVR
             ,S.DBNAME = T.DBNAME
             ,S.LastModifiedDate = T.LastModifiedDate
             ,DeletedFlg = 0
               FROM BASE_HFit_HealthAssesmentUserRiskArea AS T
                        JOIN FACT_EDW_CombinedHAViews AS S
                            ON
                            S.USERRISKAREAITEMID = T.ItemID
                        AND S.SVR = T.SVR
                        AND S.DBNAME = T.DBNAME
                        JOIN CHANGETABLE ( CHANGES BASE_HFIT_HEALTHASSESMENTUSERRISKAREA , NULL) AS CT_HFit_HealthAssesmentUserRiskArea
                            ON
                            CT_HFit_HealthAssesmentUserRiskArea.ItemID = T.ItemID
                        AND CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_OPERATION = 'U'
                        AND CT_HFit_HealthAssesmentUserRiskArea.SVR = T.SVR
                        AND CT_HFit_HealthAssesmentUserRiskArea.DBNAME = T.DBNAME;

--***********************************************************************************
END;

GO

PRINT 'Executed proc_EDW_CombinedHAViews.sql';

GO
