

GO
PRINT 'Processing view_EDW_HealthAssessment_STAGED';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.views
             WHERE name = 'view_EDW_HealthAssessment_STAGED') 
    BEGIN
        DROP VIEW
             view_EDW_HealthAssessment_STAGED;
    END;
GO
--select top 100 * from [view_EDW_HealthAssessment_STAGED]
CREATE VIEW dbo.view_EDW_HealthAssessment_STAGED
AS SELECT
          UserStartedItemID
        , HealthAssesmentUserStartedNodeGUID
        , UserID
        , UserGUID
        , HFitUserMpiNumber
        , SiteGUID
        , AccountID
        , AccountCD
        , AccountName
        , cast(HAStartedDt as datetime) as HAStartedDt 
        , cast(HACompletedDt as datetime) as HACompletedDt
        , UserModuleItemId
        , UserModuleCodeName
        , HAModuleNodeGUID
        , CMSNodeGuid
        , HAModuleVersionID
        , UserRiskCategoryItemID
        , UserRiskCategoryCodeName
        , HARiskCategoryNodeGUID						--WDM 8/7/2014 as HARiskCategoryDocumentID
        , HARiskCategoryVersionID			--WDM 10.02.2014 place holder for EDW ETL
        , UserRiskAreaItemID
        , UserRiskAreaCodeName
        , HARiskAreaNodeGUID							--WDM 8/7/2014 as HARiskAreaDocumentID
        , HARiskAreaVersionID			--WDM 10.02.2014 place holder for EDW ETL
        , UserQuestionItemID
        , Title			--WDM 47619 12.29.2014
        , HAQuestionGuid		--WDM 9.2.2014	This is a repeat field but had to stay to match the previous view - this is the NODE GUID and matches to the definition file to get the question. This tells you the question, language agnostic.
        , UserQuestionCodeName
        , HAQuestionDocumentID	--WDM 10.1.2014 - this is GOING AWAY 		--WDM 10.02.2014 place holder for EDW ETL
        , HAQuestionVersionID			--WDM 10.1.2014 - this is GOING AWAY - no versions across environments 		--WDM 10.02.2014 place holder for EDW ETL
        , HAQuestionNodeGUID		--WDM 10.01.2014	Left this in place to preserve column structure.		
        , UserAnswerItemID
        , HAAnswerNodeGUID								--WDM 8/7/2014 as HAAnswerDocumentID
        , HAAnswerVersionID		--WDM 10.1.2014 - this is GOING AWAY - no versions across environments		--WDM 10.02.2014 place holder for EDW ETL
        , UserAnswerCodeName
        , HAAnswerValue
        , HAModuleScore
        , HARiskCategoryScore
        , HARiskAreaScore
        , HAQuestionScore
        , HAAnswerPoints
        , PointResults
        , UOMCode
        , HAScore
        , ModulePreWeightedScore
        , RiskCategoryPreWeightedScore
        , RiskAreaPreWeightedScore
        , QuestionPreWeightedScore
        , QuestionGroupCodeName
        --, ChangeType
        , cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
        , cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
        , IsProfessionallyCollected
        , cast(HARiskCategory_ItemModifiedWhen as datetime) as HARiskCategory_ItemModifiedWhen
        , cast(HAUserRiskArea_ItemModifiedWhen as datetime) as HAUserRiskArea_ItemModifiedWhen
        , cast(HAUserQuestion_ItemModifiedWhen as datetime) as HAUserQuestion_ItemModifiedWhen
        , cast(HAUserAnswers_ItemModifiedWhen as datetime) as HAUserAnswers_ItemModifiedWhen
        , HAPaperFlg
        , HATelephonicFlg
        , HAStartedMode		--12.11.2014 WDM Sowmiya and dale talked and decided to implement this column 12.17.2014 - Added 
        , HACompletedMode	--12.11.2014 WDM Sowmiya and dale talked and decided to implement this column 12.17.2014 - Added 

        , DocumentCulture_VHCJ
        , DocumentCulture_HAQuestionsView
        , CampaignNodeGUID
	   ,cast(LastModifiedDate as datetime) as LastModifiedDate
          FROM Staging_EDW_HealthAssessment;

GO

PRINT 'Processed view_EDW_HealthAssessment_STAGED';
GO
--  
--  
GO
PRINT '***** FROM: view_EDW_HealthAssessment_STAGED.sql';
GO 


