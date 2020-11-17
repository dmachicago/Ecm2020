
print ('Processing: EDW_HealthAssessment');
GO

if exists(select name from sys.tables where name = 'EDW_HealthAssessment')
BEGIN	
	drop table EDW_HealthAssessment ;
END

	CREATE TABLE [dbo].[EDW_HealthAssessment]
	(		
		UserStartedItemID  int,
        HealthAssesmentUserStartedNodeGUID  uniqueidentifier,
        UserID  bigint,
        UserGUID  uniqueidentifier,
        HFitUserMpiNumber  bigint,
        SiteGUID  uniqueidentifier,
        AccountID  int,
        AccountCD  nvarchar (8),
        HAStartedDt  datetime,
        HACompletedDt  datetime,
        UserModuleItemId  int,
        UserModuleCodeName  nvarchar(100)
        
		, HAModuleNodeGUID uniqueidentifier	--WDM 8/7/2014 as HAModuleDocumentID
		, CMSNodeGuid uniqueidentifier						--WDM 8/7/2014 as HAModuleDocumentID

        ,HAModuleVersionID  int,
        UserRiskCategoryItemID  int,
        UserRiskCategoryCodeName  nvarchar(100),
        HARiskCategoryNodeGUID  uniqueidentifier,
        HARiskCategoryVersionID  int,
        UserRiskAreaItemID  int,
        UserRiskAreaCodeName  nvarchar(100),
        HARiskAreaNodeGUID  uniqueidentifier,
        HARiskAreaVersionID  int,
        UserQuestionItemID  int,
        Title  nvarchar(4000),
        HAQuestionGuid  uniqueidentifier,
        UserQuestionCodeName  nvarchar(100),
        HAQuestionDocumentID  int,
        HAQuestionVersionID  bigint,
        HAQuestionNodeGUID  uniqueidentifier,
        UserAnswerItemID  int,
        HAAnswerNodeGUID  uniqueidentifier,
        HAAnswerVersionID  bigint,
        UserAnswerCodeName  nvarchar(100),
        HAAnswerValue  nvarchar(255),
        HAModuleScore  float,
        HARiskCategoryScore  float,
        HARiskAreaScore  float,
        HAQuestionScore  float,
        HAAnswerPoints  int,
        PointResults  int,
        UOMCode  nvarchar(10),
        HAScore  int,
        ModulePreWeightedScore  float,
        RiskCategoryPreWeightedScore  float,
        RiskAreaPreWeightedScore  float,
        QuestionPreWeightedScore  float,
        QuestionGroupCodeName  nvarchar(100),
        ChangeType  varchar(1)
       
	   ,IsProfessionallyCollected bit

	   ,ItemCreatedWhen datetime
       ,ItemModifiedWhen  datetime	   
	   ,HARiskCategory_ItemModifiedWhen datetime
	   ,HAUserRiskArea_ItemModifiedWhen datetime
	   ,HAUserQuestion_ItemModifiedWhen datetime
	   ,HAUserAnswers_ItemModifiedWhen datetime
	    ,HAPaperFlg bit
	   ,HATelephonicFlg bit
	)

GO
  --  
  --  
GO 
print('***** FROM: CreateTableEDW_HealthAssessment.sql'); 
GO 
