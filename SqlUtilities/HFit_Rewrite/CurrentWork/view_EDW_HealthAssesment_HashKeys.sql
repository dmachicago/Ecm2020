
GO

PRINT ' FROM view_EDW_HealthAssesment_HashKeys.sql';

PRINT 'Processing view_EDW_HealthAssesment_HashKeys';

/********************************************************************************************************************
SELECT count(*) FROM view_EDW_HealthAssesment_HashKeys  WHERE [ChangeType] IS NOT NULL group by [ChangeType] ;	   --6587671
SELECT count(*) FROM view_EDW_HealthAssesment_HashKeys  group by [ChangeType] ;
SELECT count(*) FROM view_EDW_HealthAssesment_HashKeys WHERE [ChangeType] = 'U';    
SELECT top 100 * FROM view_EDW_HealthAssesment_HashKeys WHERE [ChangeType] = 'U'

declare @StartChangeID as bigint = 18;
declare @EndChangeID as bigint = 22;
SELECT * into ##TEMP_HA_HashKeys 
FROM view_EDW_HealthAssesment_HashKeys 
 WHERE
    CT_CMS_User_SCV  BETWEEN @StartChangeID  AND  @EndChangeID
    OR CT_CMS_UserSettings_SCV  BETWEEN @StartChangeID  AND  @EndChangeID
    OR CT_CMS_Site_SCV  BETWEEN @StartChangeID  AND  @EndChangeID
    OR CT_CMS_UserSite_SCV  BETWEEN @StartChangeID  AND  @EndChangeID
    OR CT_HFit_Account_SCV  BETWEEN @StartChangeID  AND  @EndChangeID
    OR CT_HFit_HealthAssesmentUserAnswers_SCV  BETWEEN @StartChangeID  AND  @EndChangeID
    OR CT_HFit_HealthAssesmentUserModule_SCV  BETWEEN @StartChangeID  AND  @EndChangeID
    OR CT_HFit_HealthAssesmentUserQuestion_SCV  BETWEEN @StartChangeID  AND  @EndChangeID
    OR CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV  BETWEEN @StartChangeID  AND  @EndChangeID
    OR CT_HFit_HealthAssesmentUserRiskArea_SCV  BETWEEN @StartChangeID  AND  @EndChangeID
    OR CT_HFit_HealthAssesmentUserRiskCategory_SCV  BETWEEN @StartChangeID  AND  @EndChangeID
    OR CT_HFit_HealthAssesmentUserStarted_SCV  BETWEEN @StartChangeID  AND  @EndChangeID;

********************************************************************************************************************/

GO

IF NOT EXISTS ( SELECT
                       name
                  FROM sys.indexes
                  WHERE name = 'CI_HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID' )

    BEGIN

        CREATE NONCLUSTERED INDEX CI_HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID ON dbo.HFit_HealthAssesmentUserRiskArea (
        HARiskCategoryItemID ) INCLUDE (
        ItemID
        , HARiskAreaScore
        , ItemModifiedWhen
        , CodeName
        , PreWeightedScore
        , HARiskAreaNodeGUID );
    END;

GO

IF EXISTS ( SELECT
                   name
              FROM sys.views
              WHERE name = 'view_EDW_HealthAssesment_HashKeys' )

    BEGIN

        DROP VIEW
             view_EDW_HealthAssesment_HashKeys;
    END;

GO

/*
DROP TABLE
     ##TEMP_HA_HashKeys;

print getdate() ;
select * into ##TEMP_HA_HashKeys from view_EDW_HealthAssesment_HashKeys;
print getdate() ;
*/
go
--select top 1000 * from ##TEMP_HA_HashKeys
CREATE VIEW dbo.view_EDW_HealthAssesment_HashKeys
AS

    SELECT 
       HAUserStarted.ItemID AS UserStartedItemID
       ,HAUserStarted.UserID
       ,CMSUser.UserGUID

       ,CAST( HASHBYTES ( 'sha1' , ISNULL ( CAST ( HAUserStarted.ItemID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( VHAJ.NodeGUID  AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( UserGUID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( SiteGUID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( ACCT.AccountID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( AccountCD AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HAUserModule.ItemID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HAModuleNodeGUID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( VHAJ.NodeGUID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HARiskCategory.ItemID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HARiskCategoryNodeGUID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HARiskCategory.CodeName AS varchar( 100 )) , '-' ) + ISNULL ( CAST ( HARiskCategory.HARiskCategoryNodeGUID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HAUserRiskArea.ItemID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HARiskAreaNodeGUID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HAUserRiskArea.CodeName AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HAUserQuestion.ItemID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HAUserQuestion.HAQuestionNodeGUID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HAUserQuestion.CodeName AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HAQuestionNodeGUID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HAUserAnswers.ItemID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HAAnswerNodeGUID   AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HAUserStarted.HACampaignNodeGUID AS varchar( 50 )) , '-' )) AS varchar( 100 )) AS PKHashCode

       ,COALESCE ( CT_CMS_User.SYS_CHANGE_OPERATION , CT_CMS_UserSettings.SYS_CHANGE_OPERATION , CT_CMS_Site.SYS_CHANGE_OPERATION , CT_CMS_UserSite.SYS_CHANGE_OPERATION , CT_HFit_Account.SYS_CHANGE_OPERATION , CT_HFit_HealthAssesmentUserAnswers.SYS_CHANGE_OPERATION ,
       CT_HFit_HealthAssesmentUserModule.SYS_CHANGE_OPERATION , CT_HFit_HealthAssesmentUserQuestion.SYS_CHANGE_OPERATION ,
       CT_HFit_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_OPERATION , CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_OPERATION ,
       CT_HFit_HealthAssesmentUserRiskCategory.SYS_CHANGE_OPERATION , CT_HFit_HealthAssesmentUserStarted.SYS_CHANGE_OPERATION ) AS ChangeType

    --ADD THE CAHNGE VERSION IDs
	   , CT_CMS_User.SYS_CHANGE_VERSION AS CT_CMS_User_SCV
	, CT_CMS_UserSettings.SYS_CHANGE_VERSION AS CT_CMS_UserSettings_SCV
	, CT_CMS_Site.SYS_CHANGE_VERSION AS CT_CMS_Site_SCV
	, CT_CMS_UserSite.SYS_CHANGE_VERSION AS CT_CMS_UserSite_SCV
	, CT_HFit_Account.SYS_CHANGE_VERSION AS CT_HFit_Account_SCV
	, CT_HFit_HealthAssesmentUserAnswers.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserAnswers_SCV
	, CT_HFit_HealthAssesmentUserModule.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserModule_SCV
	, CT_HFit_HealthAssesmentUserQuestion.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserQuestion_SCV
	, CT_HFit_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV
	, CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserRiskArea_SCV
	, CT_HFit_HealthAssesmentUserRiskCategory.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserRiskCategory_SCV
	, CT_HFit_HealthAssesmentUserStarted.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserStarted_SCV

  FROM
       --KEEP
       dbo.HFit_HealthAssesmentUserStarted AS HAUserStarted --KEEP
       INNER JOIN
            dbo.CMS_User AS CMSUser
       ON HAUserStarted.UserID = CMSUser.UserID
       INNER JOIN
            dbo.CMS_UserSettings AS UserSettings
       ON
       UserSettings.UserSettingsUserID = CMSUser.UserID
   AND HFitUserMpiNumber >= 0
   AND HFitUserMpiNumber IS NOT NULL
       INNER JOIN
            dbo.CMS_UserSite AS UserSite
       ON CMSUser.UserID = UserSite.UserID
       INNER JOIN
            dbo.CMS_Site AS CMSSite
       ON UserSite.SiteID = CMSSite.SiteID --KEEP
       INNER JOIN
            dbo.HFit_Account AS ACCT
       ON ACCT.SiteID = CMSSite.SiteID --keep
       INNER JOIN
            dbo.HFit_HealthAssesmentUserModule AS HAUserModule
       ON HAUserStarted.ItemID = HAUserModule.HAStartedItemID
       INNER JOIN
            dbo.View_HFit_HACampaign_Joined AS VHCJ
       ON
       VHCJ.NodeGUID = HAUserStarted.HACampaignNodeGUID
   AND VHCJ.NodeSiteID = UserSite.SiteID
   AND VHCJ.DocumentCulture = 'en-US' --keep
       INNER JOIN
            dbo.View_HFit_HealthAssessment_Joined AS VHAJ
       ON VHAJ.DocumentID = VHCJ.HealthAssessmentID --keep
       INNER JOIN
            dbo.HFit_HealthAssesmentUserRiskCategory AS HARiskCategory
       ON HAUserModule.ItemID = HARiskCategory.HAModuleItemID
       INNER JOIN
            dbo.HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea
       ON HARiskCategory.ItemID = HAUserRiskArea.HARiskCategoryItemID --keep
       INNER JOIN
            dbo.HFit_HealthAssesmentUserQuestion AS HAUserQuestion
       ON HAUserRiskArea.ItemID = HAUserQuestion.HARiskAreaItemID
       INNER JOIN
            dbo.View_EDW_HealthAssesmentQuestions AS HAQuestionsView
       ON
       HAUserQuestion.HAQuestionNodeGUID = HAQuestionsView.NodeGUID
   AND HAQuestionsView.DocumentCulture = 'en-US'
       LEFT OUTER JOIN
            dbo.HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults
       ON HAUserRiskArea.ItemID = HAUserQuestionGroupResults.HARiskAreaItemID
       INNER JOIN
            dbo.HFit_HealthAssesmentUserAnswers AS HAUserAnswers
       ON HAUserQuestion.ItemID = HAUserAnswers.HAQuestionItemID

/******************************
Add in the change tracking data
******************************/

       LEFT JOIN
            CHANGETABLE( CHANGES CMS_UserSettings , NULL )AS CT_CMS_UserSettings
       ON UserSettings.UserSettingsID = CT_CMS_UserSettings.UserSettingsID
       LEFT JOIN
            CHANGETABLE( CHANGES CMS_User , NULL )AS CT_CMS_User
       ON CMSUser.UserID = CT_CMS_User.UserID
       LEFT OUTER JOIN
            CHANGETABLE( CHANGES CMS_Site , NULL )AS CT_CMS_Site
       ON CMSSite.SiteID = CT_CMS_Site.SiteID
       LEFT OUTER JOIN
            CHANGETABLE( CHANGES CMS_UserSite , NULL )AS CT_CMS_UserSite
       ON UserSite.UserSiteID = CT_CMS_UserSite.UserSiteID
       LEFT OUTER JOIN
            CHANGETABLE( CHANGES HFit_Account , NULL )AS CT_HFit_Account
       ON ACCT.AccountID = CT_HFit_Account.AccountID
       LEFT OUTER JOIN
            CHANGETABLE( CHANGES HFit_HACampaign , NULL )AS CT_HFit_HACampaign
       ON VHCJ.HACampaignID = CT_HFit_HACampaign.HACampaignID
       LEFT OUTER JOIN
            CHANGETABLE( CHANGES HFit_HealthAssesmentUserAnswers , NULL )AS CT_HFit_HealthAssesmentUserAnswers
       ON HAUserAnswers.ItemID = CT_HFit_HealthAssesmentUserAnswers.ItemID
       LEFT OUTER JOIN
            CHANGETABLE( CHANGES HFit_HealthAssesmentUserModule , NULL )AS CT_HFit_HealthAssesmentUserModule
       ON HAUserModule.ItemID = CT_HFit_HealthAssesmentUserModule.ItemID
       LEFT OUTER JOIN
            CHANGETABLE( CHANGES HFit_HealthAssesmentUserQuestion , NULL )AS CT_HFit_HealthAssesmentUserQuestion
       ON HAUserQuestion.ItemID = CT_HFit_HealthAssesmentUserQuestion.ItemID
       LEFT OUTER JOIN
            CHANGETABLE( CHANGES HFit_HealthAssesmentUserQuestionGroupResults , NULL )AS CT_HFit_HealthAssesmentUserQuestionGroupResults
       ON HAUserQuestionGroupResults.ItemID = CT_HFit_HealthAssesmentUserQuestionGroupResults.ItemID
       LEFT OUTER JOIN
            CHANGETABLE( CHANGES HFit_HealthAssesmentUserRiskArea , NULL )AS CT_HFit_HealthAssesmentUserRiskArea
       ON HAUserRiskArea.ItemID = CT_HFit_HealthAssesmentUserRiskArea.ItemID
       LEFT OUTER JOIN
            CHANGETABLE( CHANGES HFit_HealthAssesmentUserRiskCategory , NULL )AS CT_HFit_HealthAssesmentUserRiskCategory
       ON HARiskCategory.ItemID = CT_HFit_HealthAssesmentUserRiskCategory.ItemID
       LEFT OUTER JOIN
            CHANGETABLE( CHANGES HFit_HealthAssesmentUserStarted , NULL )AS CT_HFit_HealthAssesmentUserStarted
       ON HAUserStarted.ItemID = CT_HFit_HealthAssesmentUserStarted.ItemID
  WHERE UserSettings.HFitUserMpiNumber NOT IN (
  SELECT
         RejectMPICode
    FROM HFit_LKP_EDW_RejectMPI );

/*****************************************************************************
UNCOMMENT THE BELOW TO LIMIT THE RETURNED RECORDS TO ONLY CHANGED RECORDS.
*****************************************************************************/

--AND (
--    [CT_CMS_User].[UserID] IS NOT NULL
-- OR [CT_CMS_UserSettings].[UserSettingsID] IS NOT NULL
-- OR [CT_CMS_Site].[SiteID] IS NOT NULL
-- OR [CT_CMS_UserSite].[UserSiteID] IS NOT NULL
-- OR [CT_HFit_Account].[AccountID] IS NOT NULL
-- OR [CT_HFit_HealthAssesmentUserModule].[ItemID] IS NOT NULL
-- OR [CT_HFit_HealthAssesmentUserModule].[ItemID] IS NOT NULL
-- OR [CT_HFit_HealthAssesmentUserQuestion].[ItemID] IS NOT NULL
-- OR [CT_HFit_HealthAssesmentUserQuestionGroupResults].[ItemID] IS NOT NULL
-- OR [CT_HFit_HealthAssesmentUserRiskArea].[ItemID] IS NOT NULL
-- OR [CT_HFit_HealthAssesmentUserRiskCategory].[ItemID] IS NOT NULL
-- OR [CT_HFit_HealthAssesmentUserStarted].[ItemID] IS NOT NULL
-- OR [CT_CMS_User].[UserID] IS NOT NULL
-- OR [CT_CMS_UserSettings].[UserSettingsID] IS NOT NULL
-- OR [CT_CMS_Site].[SiteID] IS NOT NULL
-- OR [CT_CMS_UserSite].[UserSiteID] IS NOT NULL
-- OR [CT_HFit_Account].[AccountID] IS NOT NULL
-- OR [CT_HFit_HealthAssesmentUserAnswers].[ItemID] IS NOT NULL
-- OR [CT_HFit_HealthAssesmentUserModule].[ItemID] IS NOT NULL
-- OR [CT_HFit_HealthAssesmentUserQuestion].[ItemID] IS NOT NULL
-- OR [CT_HFit_HealthAssesmentUserQuestionGroupResults].[ItemID] IS NOT NULL
-- OR [CT_HFit_HealthAssesmentUserRiskArea].[ItemID] IS NOT NULL
-- OR [CT_HFit_HealthAssesmentUserRiskCategory].[ItemID] IS NOT NULL
-- OR [CT_HFit_HealthAssesmentUserStarted].[ItemID] IS NOT NULL
--    );

GO

PRINT 'Processed view_EDW_HealthAssesment_HashKeys';

GO

PRINT ' FROM view_EDW_HealthAssesment_HashKeys.sql';

GO



