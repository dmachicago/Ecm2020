-- use KenticoCMS_DataMart_2

GO
PRINT 'Executing VIEW_DIM_HA.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.views
           WHERE
                  name = 'VIEW_DIM_HA') 
    BEGIN
        DROP VIEW
             dbo.VIEW_DIM_HA;
    END;
GO

/*------------------------------------
select top 100 * from VIEW_DIM_HA
select count(*) from VIEW_DIM_HA
select * into #DIM_HA from VIEW_DIM_HA
*/
CREATE VIEW VIEW_DIM_HA
AS SELECT DISTINCT
          BASE_cms_user.SVR AS BASE_cms_user_SVR
        , BASE_HFit_HealthAssesmentUserQuestion.ItemID
        , BASE_HFit_HealthAssesmentUserQuestion.HAQuestionNodeGUID
        , BASE_cms_user.UserName
        , BASE_cms_user.FirstName
        , BASE_cms_user.MiddleName
        , BASE_cms_user.LastName
        , BASE_cms_user.FullName
        , BASE_cms_user.PreferredCultureCode
        , BASE_cms_user.PreferredUICultureCode
        , BASE_cms_user.UserID
        , BASE_cms_user.SurrogateKey_cms_user
        , BASE_cms_user.LASTMODIFIEDDATE AS BASE_cms_user_LASTMODIFIEDDATE
        , BASE_cms_user.DBNAME AS BASE_cms_user_DBNAME
        , BASE_cms_usersettings.UserDateOfBirth
        , BASE_cms_usersettings.UserGender
        , BASE_HFit_HealthAssesmentUserStarted.HAPaperFlg
        , BASE_HFit_HealthAssesmentUserStarted.HAStartedDt
        , BASE_HFit_HealthAssesmentUserStarted.HACompletedDt
        , BASE_HFit_HealthAssesmentUserStarted.LASTMODIFIEDDATE
        , BASE_CMS_Site.SiteName
        , BASE_CMS_Site.SiteStatus
        , BASE_CMS_Site.LASTMODIFIEDDATE AS BASE_CMS_Site_LASTMODIFIEDDATE
        , BASE_CMS_Site.SurrogateKey_CMS_Site
        , BASE_HFit_Account.SurrogateKey_HFit_Account
        , BASE_cms_usersite.SurrogateKey_cms_usersite
        , BASE_HFit_HealthAssesmentUserRiskCategory.SurrogateKey_HFit_HealthAssesmentUserRiskCategory
        , BASE_HFit_HealthAssesmentUserRiskArea.SurrogateKey_HFit_HealthAssesmentUserRiskArea
        , BASE_HFit_HealthAssesmentUserModule.SurrogateKey_HFit_HealthAssesmentUserModule
        , BASE_HFit_HealthAssesmentUserStarted.SurrogateKey_HFit_HealthAssesmentUserStarted
        , BASE_HFit_HealthAssesmentUserQuestion.SurrogateKey_HFit_HealthAssesmentUserQuestion
        , BASE_HFit_HealthAssesmentUserAnswers.SurrogateKey_HFit_HealthAssesmentUserAnswers
        , FACT_View_EDW_HealthAssesmentQuestions.TITLE
        , FACT_View_EDW_HealthAssesmentQuestions.RowNbr
        , FACT_View_EDW_HealthAssesmentQuestions.LastModifiedDate AS FACT_View_EDW_HealthAssesmentQuestions_LastModifiedDate
        , BASE_HFit_HealthAssesmentUserQuestion.LASTMODIFIEDDATE AS BASE_HFit_HealthAssesmentUserQuestion_LASTMODIFIEDDATE
        , BASE_HFit_HealthAssesmentUserAnswers.LASTMODIFIEDDATE AS BASE_HFit_HealthAssesmentUserAnswers_LASTMODIFIEDDATE
        , BASE_HFit_HealthAssesmentUserRiskArea.LASTMODIFIEDDATE AS BASE_HFit_HealthAssesmentUserRiskArea_LASTMODIFIEDDATE
        , BASE_HFit_HealthAssesmentUserRiskCategory.LASTMODIFIEDDATE AS BASE_HFit_HealthAssesmentUserRiskCategory_LASTMODIFIEDDATE
        , BASE_cms_usersite.LASTMODIFIEDDATE AS BASE_cms_usersite_LASTMODIFIEDDATE
        , BASE_HFit_Account.LASTMODIFIEDDATE AS BASE_HFit_Account_LASTMODIFIEDDATE
        , BASE_cms_usersettings.LASTMODIFIEDDATE AS BASE_cms_usersettings_LASTMODIFIEDDATE
        , BASE_HFit_HealthAssesmentUserModule.LASTMODIFIEDDATE AS BASE_HFit_HealthAssesmentUserModule_LASTMODIFIEDDATE
   FROM
        dbo.BASE_CMS_Site
        INNER JOIN dbo.BASE_cms_usersite
        ON
          BASE_CMS_Site.SiteID = BASE_cms_usersite.SiteID AND
          BASE_CMS_Site.SVR = BASE_cms_usersite.SVR AND
          BASE_CMS_Site.DBNAME = BASE_cms_usersite.DBNAME
        INNER JOIN dbo.BASE_cms_user
        ON
          BASE_cms_usersite.SVR = BASE_cms_user.SVR AND
          BASE_cms_usersite.DBNAME = BASE_cms_user.DBNAME AND
          BASE_cms_usersite.UserID = BASE_cms_user.UserID
        INNER JOIN dbo.BASE_HFit_Account
        ON
          BASE_CMS_Site.SiteID = BASE_HFit_Account.SiteID AND
          BASE_CMS_Site.SVR = BASE_HFit_Account.SVR AND
          BASE_CMS_Site.DBNAME = BASE_HFit_Account.DBNAME
        INNER JOIN dbo.BASE_cms_usersettings
        ON
          BASE_cms_user.SVR = BASE_cms_usersettings.SVR AND
          BASE_cms_user.DBNAME = BASE_cms_usersettings.DBNAME AND
          BASE_cms_user.UserID = BASE_cms_usersettings.UserSettingsID
        INNER JOIN dbo.BASE_HFit_HealthAssesmentUserStarted
        ON
          BASE_cms_usersite.UserID = BASE_HFit_HealthAssesmentUserStarted.UserID AND
          BASE_cms_usersite.SVR = BASE_HFit_HealthAssesmentUserStarted.SVR AND
          BASE_cms_usersite.DBNAME = BASE_HFit_HealthAssesmentUserStarted.DBNAME
        INNER JOIN dbo.BASE_HFit_HealthAssesmentUserModule
        ON
          BASE_HFit_HealthAssesmentUserStarted.ItemID = BASE_HFit_HealthAssesmentUserModule.HAStartedItemID AND
          BASE_HFit_HealthAssesmentUserStarted.SVR = BASE_HFit_HealthAssesmentUserModule.SVR AND
          BASE_HFit_HealthAssesmentUserStarted.DBNAME = BASE_HFit_HealthAssesmentUserModule.DBNAME
        INNER JOIN dbo.BASE_HFit_HealthAssesmentUserRiskCategory
        ON
          BASE_HFit_HealthAssesmentUserModule.ItemID = BASE_HFit_HealthAssesmentUserRiskCategory.HAModuleItemID AND
          BASE_HFit_HealthAssesmentUserModule.SVR = BASE_HFit_HealthAssesmentUserRiskCategory.SVR AND
          BASE_HFit_HealthAssesmentUserModule.DBNAME = BASE_HFit_HealthAssesmentUserRiskCategory.DBNAME
        INNER JOIN dbo.BASE_HFit_HealthAssesmentUserRiskArea
        ON
          BASE_HFit_HealthAssesmentUserRiskCategory.ItemID = BASE_HFit_HealthAssesmentUserRiskArea.HARiskCategoryItemID AND
          BASE_HFit_HealthAssesmentUserRiskCategory.SVR = BASE_HFit_HealthAssesmentUserRiskArea.SVR AND
          BASE_HFit_HealthAssesmentUserRiskCategory.DBNAME = BASE_HFit_HealthAssesmentUserRiskArea.DBNAME
        INNER JOIN dbo.BASE_HFit_HealthAssesmentUserQuestion
        ON
          BASE_HFit_HealthAssesmentUserRiskArea.ItemID = BASE_HFit_HealthAssesmentUserQuestion.HARiskAreaItemID AND
          BASE_HFit_HealthAssesmentUserRiskArea.SVR = BASE_HFit_HealthAssesmentUserQuestion.SVR AND
          BASE_HFit_HealthAssesmentUserRiskArea.DBNAME = BASE_HFit_HealthAssesmentUserQuestion.DBNAME
        INNER JOIN dbo.BASE_HFit_HealthAssesmentUserAnswers
        ON
          BASE_HFit_HealthAssesmentUserQuestion.ItemID = BASE_HFit_HealthAssesmentUserAnswers.HAQuestionItemID AND
          BASE_HFit_HealthAssesmentUserQuestion.SVR = BASE_HFit_HealthAssesmentUserAnswers.SVR AND
          BASE_HFit_HealthAssesmentUserQuestion.DBNAME = BASE_HFit_HealthAssesmentUserAnswers.DBNAME
        INNER JOIN dbo.FACT_View_EDW_HealthAssesmentQuestions
        ON
          BASE_HFit_HealthAssesmentUserQuestion.HAQuestionNodeGUID = FACT_View_EDW_HealthAssesmentQuestions.NODEGUID;
GO
PRINT 'Executed VIEW_DIM_HA.sql';
GO
