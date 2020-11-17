

go
print 'Creating proc_Denormalize_EDW_Views.sql';
go

if exists (select name from sys.procedures where name = 'proc_Denormalize_EDW_Views')
    drop procedure proc_Denormalize_EDW_Views;
--exec proc_Denormalize_EDW_Views
go
CREATE PROCEDURE proc_Denormalize_EDW_Views
AS
BEGIN
/*
Author:	  W. Dale Miller
Created:	  06.15.2015
USE:		  exec proc_Denormalize_EDW_Views
PERF:	  Appox 50 minutes
*/
SET NOCOUNT ON;
    IF EXISTS ( SELECT
                       name
                  FROM tempdb.dbo.sysobjects
                  WHERE id = OBJECT_ID ( N'tempdb..##TEMP_HFit_HealthAssesmentUserQuestion' ))

        BEGIN

            DROP TABLE
                 ##TEMP_HFit_HealthAssesmentUserQuestion;
        END;

    SELECT
           USERQUES.ItemID
           ,USERQUES.HAQuestionNodeGUID
           ,USERQUES.CodeName
           ,USERQUES.HAQuestionScore
           ,USERQUES.PreWeightedScore
           ,USERQUES.IsProfessionallyCollected
           ,USERQUES.ItemModifiedWhen
           ,USERQUES.HARiskAreaItemID
           ,CT_HFit_HealthAssesmentUserQuestion.ItemID AS HFit_HealthAssesmentUserQuestion_CtID
           ,CT_HFit_HealthAssesmentUserQuestion.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION
           ,CT_HFit_HealthAssesmentUserQuestion.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserQuestion_SCV
		  
    INTO
         ##TEMP_HFit_HealthAssesmentUserQuestion
      FROM
           BASE_HFIT_HEALTHASSESMENTUSERQUESTION AS USERQUES LEFT OUTER JOIN
                CHANGETABLE( CHANGES BASE_HFIT_HEALTHASSESMENTUSERQUESTION , NULL )AS CT_HFit_HealthAssesmentUserQuestion
                                                        ON USERQUES.ItemID = CT_HFit_HealthAssesmentUserQuestion.ItemID;
    
    -- select top 100 * from ##TEMP_HFit_HealthAssesmentUserQuestion

    CREATE UNIQUE CLUSTERED INDEX TEMP_USERQUES ON ##TEMP_HFit_HealthAssesmentUserQuestion
    (
    ItemID
    , HARiskAreaItemID
    , HAQuestionNodeGUID
    , CodeName
    , HAQuestionScore
    , PreWeightedScore
    , ItemModifiedWhen
    )WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON );

    CREATE NONCLUSTERED INDEX PI_USERQUES_RiskAreaID
    ON ##TEMP_HFit_HealthAssesmentUserQuestion ( HARiskAreaItemID )
    INCLUDE ( ItemID , HAQuestionNodeGUID , CodeName , HAQuestionScore , PreWeightedScore , IsProfessionallyCollected , ItemModifiedWhen );

    IF EXISTS ( SELECT
                       name
                  FROM tempdb.dbo.sysobjects
                  WHERE id = OBJECT_ID ( N'tempdb..##TEMP_View_HFit_HACampaign_Joined' ))

        BEGIN

            --PRINT 'Dropping ##TEMP_View_HFit_HACampaign_Joined';

            DROP TABLE
                 ##TEMP_View_HFit_HACampaign_Joined;
        END;

    SELECT
           campaign.DocumentCulture
           ,campaign.HACampaignID
           ,campaign.NodeGUID
           ,campaign.NodeSiteID
           ,campaign.HealthAssessmentID
    INTO
         ##TEMP_View_HFit_HACampaign_Joined
      FROM View_HFit_HACampaign_Joined AS campaign;

    CREATE UNIQUE CLUSTERED INDEX TEMP_campaign ON ##TEMP_View_HFit_HACampaign_Joined
    (
    DocumentCulture ASC ,
    HACampaignID ASC ,
    NodeGUID ASC ,
    HealthAssessmentID
    )WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON );

    IF EXISTS ( SELECT
                       name
                  FROM tempdb.dbo.sysobjects
                  WHERE id = OBJECT_ID ( N'tempdb..##TEMP_View_HFit_HealthAssessment_Joined' ))

        BEGIN

            --PRINT 'Dropping ##TEMP_View_HFit_HealthAssessment_Joined';

            DROP TABLE
                 ##TEMP_View_HFit_HealthAssessment_Joined;
        END;

    SELECT
           HAJOINED.NodeGUID
           ,HAJOINED.DocumentID
    INTO
         ##TEMP_View_HFit_HealthAssessment_Joined
      FROM View_HFit_HealthAssessment_Joined AS HAJOINED;

    SET ANSI_PADDING ON;

    CREATE UNIQUE CLUSTERED INDEX TEMP_HAJOINED ON ##TEMP_View_HFit_HealthAssessment_Joined
    (
    NodeGUID ASC ,
    DocumentID ASC
    )WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON );

    IF EXISTS ( SELECT
                       name
                  FROM tempdb.dbo.sysobjects
                  WHERE id = OBJECT_ID ( N'tempdb..##TEMP_View_EDW_HealthAssesmentQuestions' ))

        BEGIN

            --PRINT 'Dropping ##TEMP_View_EDW_HealthAssesmentQuestions';

            DROP TABLE
                 ##TEMP_View_EDW_HealthAssesmentQuestions;
        END;

    SELECT
           dbo.udf_StripHTML ( QUES.Title ) AS Title
           ,QUES.DocumentCulture
           ,QUES.NodeGUID
    INTO
         ##TEMP_View_EDW_HealthAssesmentQuestions
      FROM View_EDW_HealthAssesmentQuestions AS QUES;

    SET ANSI_PADDING ON;

    CREATE UNIQUE CLUSTERED INDEX TEMP_Ques ON ##TEMP_View_EDW_HealthAssesmentQuestions
    (
    DocumentCulture ASC ,
    NodeGUID ASC
    )WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON );

END;

go
print 'Created proc_Denormalize_EDW_Views.sql';
go
