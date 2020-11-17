
GO
PRINT 'proc_EDW_HA_TempTable_Load_Changed_Data.sql';
GO

IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_EDW_HA_TempTable_Load_Changed_Data' )
    BEGIN
        DROP PROCEDURE
             proc_EDW_HA_TempTable_Load_Changed_Data
    END;
GO

CREATE PROCEDURE proc_EDW_HA_TempTable_Load_Changed_Data
AS
BEGIN

    truncate TABLE TEMP_EDW_HealthAssessment_DATA;

    IF NOT EXISTS ( SELECT
                           name
                      FROM sys.indexes
                      WHERE name = 'PI_TEMP_EDW_HealthAssessment_DATA_Dates' )
        BEGIN
            PRINT 'Adding INDEX PI_TEMP_EDW_HealthAssessment_DATA_Dates at: ' + CAST ( GETDATE ( ) AS nvarchar ( 50 ));

            CREATE NONCLUSTERED INDEX PI_TEMP_EDW_HealthAssessment_DATA_Dates ON dbo.TEMP_EDW_HealthAssessment_DATA ( ItemCreatedWhen ASC ,
            ItemModifiedWhen ASC , HARiskCategory_ItemModifiedWhen ASC , HAUserRiskArea_ItemModifiedWhen ASC ,
            HAUserQuestion_ItemModifiedWhen ASC ,
            HAUserAnswers_ItemModifiedWhen ASC ) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF ,
            DROP_EXISTING = OFF , ONLINE = OFF ,
            ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON );
        END;

    IF NOT EXISTS
    ( SELECT
             name
        FROM sys.indexes
        WHERE name = 'PI_TEMP_EDW_HealthAssessment_DATA_NATKEY' )
        BEGIN
            PRINT 'Adding INDEX PI_TEMP_EDW_HealthAssessment_DATA_NATKEY at: ' + CAST ( GETDATE ( ) AS nvarchar ( 50 ));
            CREATE INDEX PI_TEMP_EDW_HealthAssessment_DATA_NATKEY ON dbo.TEMP_EDW_HealthAssessment_DATA (
            UserStartedItemID
            , UserGUID
            , PKHashCode
            );
        END;

    IF NOT EXISTS ( SELECT
                           name
                      FROM sys.indexes
                      WHERE name = 'PI_TEMP_EDW_HealthAssessment_DATA_IDs' )
        BEGIN
            EXEC PrintNow 'Adding INDEX PI_TEMP_EDW_HealthAssessment_DATA_IDs';
            CREATE INDEX PI_TEMP_EDW_HealthAssessment_DATA_IDs ON dbo.TEMP_EDW_HealthAssessment_DATA (
            UserStartedItemID
            , HealthAssesmentUserStartedNodeGUID
            , UserGUID
            , SiteGUID
            , AccountCD
            , HAModuleNodeGUID
            , CMSNodeGuid
            , HARiskCategoryNodeGUID
            , UserRiskAreaItemID
            , HARiskAreaNodeGUID
            , UserQuestionItemID
            , HAQuestionGuid
            , HAQuestionNodeGUID
            , UserAnswerItemID
            , HAAnswerNodeGUID
            , CampaignNodeGUID
            )
            INCLUDE ( AccountID , UserModuleItemId , UserRiskCategoryItemID , DeletedFlg , HASHCODE , LastModifiedDate )
            WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF ,
            ALLOW_ROW_LOCKS = ON ,
            ALLOW_PAGE_LOCKS = ON );
        END;

    INSERT INTO TEMP_EDW_HealthAssessment_DATA
    (
          [UserStartedItemID]
      ,[HealthAssesmentUserStartedNodeGUID]
      ,[UserID]
      ,[UserGUID]
      ,[HFitUserMpiNumber]
      ,[SiteGUID]
      ,[AccountID]
      ,[AccountCD]
      ,[AccountName]
      ,[HAStartedDt]
      ,[HACompletedDt]
      ,[UserModuleItemId]
      ,[UserModuleCodeName]
      ,[HAModuleNodeGUID]
      ,[CMSNodeGuid]
      ,[HAModuleVersionID]
      ,[UserRiskCategoryItemID]
      ,[UserRiskCategoryCodeName]
      ,[HARiskCategoryNodeGUID]
      ,[HARiskCategoryVersionID]
      ,[UserRiskAreaItemID]
      ,[UserRiskAreaCodeName]
      ,[HARiskAreaNodeGUID]
      ,[HARiskAreaVersionID]
      ,[UserQuestionItemID]
      ,[Title]
      ,[HAQuestionGuid]
      ,[UserQuestionCodeName]
      ,[HAQuestionDocumentID]
      ,[HAQuestionVersionID]
      ,[HAQuestionNodeGUID]
      ,[UserAnswerItemID]
      ,[HAAnswerNodeGUID]
      ,[HAAnswerVersionID]
      ,[UserAnswerCodeName]
      ,[HAAnswerValue]
      ,[HAModuleScore]
      ,[HARiskCategoryScore]
      ,[HARiskAreaScore]
      ,[HAQuestionScore]
      ,[HAAnswerPoints]
      ,[PointResults]
      ,[UOMCode]
      ,[HAScore]
      ,[ModulePreWeightedScore]
      ,[RiskCategoryPreWeightedScore]
      ,[RiskAreaPreWeightedScore]
      ,[QuestionPreWeightedScore]
      ,[QuestionGroupCodeName]
      ,[ItemCreatedWhen]
      ,[ItemModifiedWhen]
      ,[IsProfessionallyCollected]
      ,[HARiskCategory_ItemModifiedWhen]
      ,[HAUserRiskArea_ItemModifiedWhen]
      ,[HAUserQuestion_ItemModifiedWhen]
      ,[HAUserAnswers_ItemModifiedWhen]
      ,[HAPaperFlg]
      ,[HATelephonicFlg]
      ,[HAStartedMode]
      ,[HACompletedMode]
      ,[DocumentCulture_VHCJ]
      ,[DocumentCulture_HAQuestionsView]
      ,[CampaignNodeGUID]
      ,[HACampaignID]
      ,[HashCode]
      ,[ChangeType]
      ,[CHANGED_FLG]
      ,[LastModifiedDate]
      ,[DeleteFlg]
      ,[CT_CMS_User_UserID]
      ,[CT_CMS_User_CHANGE_OPERATION]
      ,[CT_UserSettingsID]
      ,[CT_UserSettingsID_CHANGE_OPERATION]
      ,[SiteID_CtID]
      ,[SiteID_CHANGE_OPERATION]
      ,[UserSiteID_CtID]
      ,[UserSiteID_CHANGE_OPERATION]
      ,[AccountID_CtID]
      ,[AccountID__CHANGE_OPERATION]
      ,[HAUserAnswers_CtID]
      ,[HAUserAnswers_CHANGE_OPERATION]
      ,[HFit_HealthAssesmentUserModule_CtID]
      ,[HFit_HealthAssesmentUserModule_CHANGE_OPERATION]
      ,[HFit_HealthAssesmentUserQuestion_CtID]
      ,[HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION]
      ,[HFit_HealthAssesmentUserQuestionGroupResults_CtID]
      ,[HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION]
      ,[HFit_HealthAssesmentUserRiskArea_CtID]
      ,[HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION]
      ,[HFit_HealthAssesmentUserRiskCategory_CtID]
      ,[HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION]
      ,[HFit_HealthAssesmentUserStarted_CtID]
      ,[HFit_HealthAssesmentUserStarted_CHANGE_OPERATION]
      ,[CT_CMS_User_SCV]
      ,[CT_CMS_UserSettings_SCV]
      ,[CT_CMS_Site_SCV]
      ,[CT_CMS_UserSite_SCV]
      ,[CT_HFit_Account_SCV]
      ,[CT_HFit_HealthAssesmentUserAnswers_SCV]
      ,[CT_HFit_HealthAssesmentUserModule_SCV]
      ,[CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV]
      ,[CT_HFit_HealthAssesmentUserRiskArea_SCV]
      ,[CT_HFit_HealthAssesmentUserRiskCategory_SCV]
      ,[CT_HFit_HealthAssesmentUserStarted_SCV]
      ,[PKHashCode])
    SELECT
           [UserStartedItemID]
      ,[HealthAssesmentUserStartedNodeGUID]
      ,[UserID]
      ,[UserGUID]
      ,[HFitUserMpiNumber]
      ,[SiteGUID]
      ,[AccountID]
      ,[AccountCD]
      ,[AccountName]
      ,[HAStartedDt]
      ,[HACompletedDt]
      ,[UserModuleItemId]
      ,[UserModuleCodeName]
      ,[HAModuleNodeGUID]
      ,[CMSNodeGuid]
      ,[HAModuleVersionID]
      ,[UserRiskCategoryItemID]
      ,[UserRiskCategoryCodeName]
      ,[HARiskCategoryNodeGUID]
      ,[HARiskCategoryVersionID]
      ,[UserRiskAreaItemID]
      ,[UserRiskAreaCodeName]
      ,[HARiskAreaNodeGUID]
      ,[HARiskAreaVersionID]
      ,[UserQuestionItemID]
      ,[Title]
      ,[HAQuestionGuid]
      ,[UserQuestionCodeName]
      ,[HAQuestionDocumentID]
      ,[HAQuestionVersionID]
      ,[HAQuestionNodeGUID]
      ,[UserAnswerItemID]
      ,[HAAnswerNodeGUID]
      ,[HAAnswerVersionID]
      ,[UserAnswerCodeName]
      ,[HAAnswerValue]
      ,[HAModuleScore]
      ,[HARiskCategoryScore]
      ,[HARiskAreaScore]
      ,[HAQuestionScore]
      ,[HAAnswerPoints]
      ,[PointResults]
      ,[UOMCode]
      ,[HAScore]
      ,[ModulePreWeightedScore]
      ,[RiskCategoryPreWeightedScore]
      ,[RiskAreaPreWeightedScore]
      ,[QuestionPreWeightedScore]
      ,[QuestionGroupCodeName]
      ,[ItemCreatedWhen]
      ,[ItemModifiedWhen]
      ,[IsProfessionallyCollected]
      ,[HARiskCategory_ItemModifiedWhen]
      ,[HAUserRiskArea_ItemModifiedWhen]
      ,[HAUserQuestion_ItemModifiedWhen]
      ,[HAUserAnswers_ItemModifiedWhen]
      ,[HAPaperFlg]
      ,[HATelephonicFlg]
      ,[HAStartedMode]
      ,[HACompletedMode]
      ,[DocumentCulture_VHCJ]
      ,[DocumentCulture_HAQuestionsView]
      ,[CampaignNodeGUID]
      ,[HACampaignID]
      ,[HashCode]
      ,[ChangeType]
      ,[CHANGED_FLG]
      ,[LastModifiedDate]
      ,[DeleteFlg]
      ,[CT_CMS_User_UserID]
      ,[CT_CMS_User_CHANGE_OPERATION]
      ,[CT_UserSettingsID]
      ,[CT_UserSettingsID_CHANGE_OPERATION]
      ,[SiteID_CtID]
      ,[SiteID_CHANGE_OPERATION]
      ,[UserSiteID_CtID]
      ,[UserSiteID_CHANGE_OPERATION]
      ,[AccountID_CtID]
      ,[AccountID__CHANGE_OPERATION]
      ,[HAUserAnswers_CtID]
      ,[HAUserAnswers_CHANGE_OPERATION]
      ,[HFit_HealthAssesmentUserModule_CtID]
      ,[HFit_HealthAssesmentUserModule_CHANGE_OPERATION]
      ,[HFit_HealthAssesmentUserQuestion_CtID]
      ,[HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION]
      ,[HFit_HealthAssesmentUserQuestionGroupResults_CtID]
      ,[HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION]
      ,[HFit_HealthAssesmentUserRiskArea_CtID]
      ,[HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION]
      ,[HFit_HealthAssesmentUserRiskCategory_CtID]
      ,[HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION]
      ,[HFit_HealthAssesmentUserStarted_CtID]
      ,[HFit_HealthAssesmentUserStarted_CHANGE_OPERATION]
      ,[CT_CMS_User_SCV]
      ,[CT_CMS_UserSettings_SCV]
      ,[CT_CMS_Site_SCV]
      ,[CT_CMS_UserSite_SCV]
      ,[CT_HFit_Account_SCV]
      ,[CT_HFit_HealthAssesmentUserAnswers_SCV]
      ,[CT_HFit_HealthAssesmentUserModule_SCV]
      ,[CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV]
      ,[CT_HFit_HealthAssesmentUserRiskArea_SCV]
      ,[CT_HFit_HealthAssesmentUserRiskCategory_SCV]
      ,[CT_HFit_HealthAssesmentUserStarted_SCV]
      ,[PKHashCode]
      FROM view_EDW_HealthAssesment_CT
	   where ChangeType is not NULL ;
END;

GO
PRINT 'CREATED proc_EDW_HA_TempTable_Load_Changed_Data.sql';
GO
